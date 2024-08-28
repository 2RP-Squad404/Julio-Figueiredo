-- criação da tabela para análises

%hive
CREATE EXTERNAL TABLE analises(
    client_id VARCHAR(50),
    total_price VARCHAR(30),
    most_purchase_location STRING,
    first_purchase TIMESTAMP,
    last_purchase TIMESTAMP,
    most_campaign STRING,
    quantity_error INT,
    date_today TIMESTAMP,
    anomes_day INT
)

ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1")


-- 1. Preencher a coluna client_id da tabela analises com a coluna client_id da tabela campanhas
INSERT INTO TABLE analises
SELECT DISTINCT client_id, 
       NULL AS total_price, 
       NULL AS most_purchase_location, 
       NULL AS first_purchase, 
       NULL AS last_purchase, 
       NULL AS most_campaign, 
       NULL AS quantity_error, 
       NULL AS date_today, 
       NULL AS anomes_day
FROM campanhas

-- criando uma tabela para purchases
CREATE EXTERNAL TABLE compras(
    purchase_id VARCHAR(50),
    product_name VARCHAR(40),
    product_id VARCHAR(50),
    amount INT,
    price DECIMAL(10,2),
    discount_applied DOUBLE,
    payment_method STRING,
    purchase_datetime TIMESTAMP,
    purchase_location STRING,
    client_id VARCHAR(50)
)

ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1")

-- preenchendo a tabela
LOAD DATA INPATH 's3a://desafio02/purchases_2023.csv'
INTO TABLE compras

%hive
-- criando uma coluna de preço total
ALTER TABLE compras ADD COLUMNS (total_value DECIMAL(10,2))

--  2. 

%hive
-- cria uma tabela temporária para calcular
CREATE TABLE temp_total_price AS
SELECT
    client_id,
    SUM(price * amount * (1 - discount_applied)) AS total_price
FROM
    compras
GROUP BY
    client_id

-- traz para tabela analises a coluna com o cálculo
%hive
CREATE TABLE analises_temp AS
SELECT
    a.client_id,
    COALESCE(t.total_price, a.total_price) AS total_price,
    a.most_purchase_location,
    a.first_purchase,
    a.last_purchase,
    a.most_campaign,
    a.quantity_error,
    a.date_today,
    a.anomes_day
FROM
    analises a
LEFT JOIN
    temp_total_price t
ON
    a.client_id = t.client_id

-- 3.
-- Encontre o local de compra mais frequente para cada cliente
CREATE TABLE temp_most_purchase_location AS
SELECT
    client_id,
    purchase_location AS most_purchase_location
FROM (
    SELECT
        client_id,
        purchase_location,
        COUNT(*) AS location_count,
        ROW_NUMBER() OVER (PARTITION BY client_id ORDER BY COUNT(*) DESC) AS rn
    FROM compras
    GROUP BY client_id, purchase_location
) sub
WHERE rn = 1

INSERT OVERWRITE TABLE analises
SELECT
    a.client_id,
    a.total_price,
    COALESCE(t.most_purchase_location, a.most_purchase_location) AS most_purchase_location,
    a.first_purchase,
    a.last_purchase,
    a.most_campaign,
    a.quantity_error,
    a.date_today,
    a.anomes_day
FROM
    analises a
LEFT JOIN
    temp_most_purchase_location t
ON
    a.client_id = t.client_id

DROP TABLE temp_first_purchase

%hive

DROP TABLE temp_most_purchase_location

-- 4.
-- Função MIN() obtém a data mais antiga
CREATE TABLE temp_first_purchase AS
SELECT
    client_id,
    MIN(purchase_datetime) AS first_purchase
FROM compras
GROUP BY client_id

%hive
INSERT OVERWRITE TABLE analises
SELECT
    a.client_id,
    a.total_price,
    a.most_purchase_location,
    COALESCE(t.first_purchase, a.first_purchase) AS first_purchase,
    a.last_purchase,
    a.most_campaign,
    a.quantity_error,
    a.date_today,
    a.anomes_day
FROM
    analises a
LEFT JOIN
    temp_first_purchase t
ON
    a.client_id = t.client_id

DROP TABLE temp_first_purchase

-- 5.
-- Função MAX() obtém a data mais atual
CREATE TABLE temp_last_purchase AS
SELECT
    client_id,
    MAX(purchase_datetime) AS last_purchase
FROM compras
GROUP BY client_id

INSERT OVERWRITE TABLE analises
SELECT
    a.client_id,
    a.total_price,
    a.most_purchase_location,
    a.first_purchase,
    COALESCE(t.last_purchase, a.last_purchase) AS last_purchase,
    a.most_campaign,
    a.quantity_error,
    a.date_today,
    a.anomes_day
FROM
    analises a
LEFT JOIN
    temp_last_purchase t
ON
    a.client_id = t.client_id

DROP TABLE temp_last_purchase

-- 6.
%hive
-- Cria uma tabela temporária com contagem de campanhas recebidas por cliente e tipo de campanha
CREATE TABLE temp_campaign_counts AS
SELECT
    client_id,
    type_campaign,
    COUNT(*) AS campaign_count
FROM campanhas
WHERE return_status = 'received'
GROUP BY client_id, type_campaign

%hive
-- Cria uma tabela temporária para classificar as campanhas por cliente e contagem
CREATE TABLE temp_ranked_campaigns AS
SELECT
    client_id,
    type_campaign,
    campaign_count,
    ROW_NUMBER() OVER (PARTITION BY client_id ORDER BY campaign_count DESC) AS rank
FROM temp_campaign_counts

%hive
-- Cria a tabela final que contém a campanha mais frequente para cada cliente
CREATE TABLE most_campaign AS
SELECT
    client_id,
    type_campaign AS most_campaign
FROM temp_ranked_campaigns
WHERE rank = 1

%hive
-- Atualize a tabela analises com a campanha mais frequente
INSERT OVERWRITE TABLE analises
SELECT
    a.client_id,
    a.total_price,
    a.most_purchase_location,
    a.first_purchase,
    a.last_purchase,
    m.most_campaign AS most_campaign,
    a.quantity_error,
    a.date_today,
    a.anomes_day
FROM analises a
LEFT JOIN most_campaign m
ON a.client_id = m.client_id

DROP TABLE temp_campaign_counts
DROP TABLE temp_ranked_campaigns
DROP TABLE most_campaign

-- 7.
%hive

CREATE TABLE temp_quantity_error AS
SELECT
    client_id,
    COUNT(*) AS quantity_error
FROM campanhas
WHERE return_status = 'error'
GROUP BY client_id

%hive

INSERT OVERWRITE TABLE analises
SELECT
    a.client_id,
    a.total_price,
    a.most_purchase_location,
    a.first_purchase,
    a.last_purchase,
    a.most_campaign,
    COALESCE(te.quantity_error, 0) AS quantity_error, -- se não tiver erro deixa 0 como padrão
    a.date_today,
    a.anomes_day
FROM analises a
LEFT JOIN temp_quantity_error te
ON a.client_id = te.client_id

DROP TABLE temp_quantity_erro

-- 8.

INSERT OVERWRITE TABLE analises
SELECT
    a.client_id,
    a.total_price,
    a.most_purchase_location,
    a.first_purchase,
    a.last_purchase,
    a.most_campaign,
    COALESCE(te.quantity_error, 0) AS quantity_error,
    CURRENT_DATE() AS data_today, -- Insere a data atual
    a.anomes_day
FROM analises a
LEFT JOIN temp_quantity_error te
ON a.client_id = te.client_id

-- 9.
%hive
INSERT OVERWRITE TABLE analises
SELECT
    a.client_id,
    a.total_price,
    a.most_purchase_location,
    a.first_purchase,
    a.last_purchase,
    a.most_campaign,
    COALESCE(te.quantity_error, 0) AS quantity_error,
    CURRENT_DATE() AS data_today,
    CAST(CONCAT(LPAD(CAST(MONTH(CURRENT_DATE()) AS STRING), 2, '0'), CAST(YEAR(CURRENT_DATE()) AS STRING)) AS INT) AS anomes_today
FROM analises a
LEFT JOIN temp_quantity_error te
ON a.client_id = te.client_id

-- select para visualizar a tabela

SELECT * FROM analises ORDER BY RAND() LIMIT 10