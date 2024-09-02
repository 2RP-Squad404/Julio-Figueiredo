-- 'apelidos'

SELECT nome_produto AS produto
FROM produtos
WHERE qtde_estoque >5


SELECT nome_cliente as "nome", sobrenome_cliente AS "sobrenome"
FROM clientes AS clients;


-- tambem funciona sem AS
SELECT nome_cliente "nome", sobrenome_cliente "sobrenome"
FROM clientes clients;