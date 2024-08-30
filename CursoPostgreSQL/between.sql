SELECT nome_produto, preco
FROM produtos
WHERE preco BETWEEN 10.00 AND 20.00;


SELECT nome_produto, preco
FROM produtos
WHERE preco BETWEEN 3.00 AND 7.00
OR preco BETWEEN 10.00 AND 20.00;


SELECT nome_produto, preco, qtde_estoque
FROM produtos
WHERE preco BETWEEN 3.00 AND 7.00
AND qtde_estoque < 10;


SELECT nome_produto, preco
FROM produtos
WHERE preco NOT BETWEEN 3.00 AND 7.00;
