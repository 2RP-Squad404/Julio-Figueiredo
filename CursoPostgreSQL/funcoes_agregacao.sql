-- funcao COUNT -- serve para contar linhas de uma tabela

SELECT COUNT(*) FROM clientes

SELECT COUNT(*) AS "qtde_clientes" FROM clientes

SELECT COUNT(nome_cliente) FROM clientes


SELECT COUNT (DISTINCT nome_produto) FROM produtos -- nesse caso não conta nomes iguais


SELECT COUNT (*)
FROM produtos
WHERE preco >= 10.00; -- seleciona quantos produtos tem preço maior ou igual a 10



-- funcao MAX

SELECT MAX(preco) FROM produtos



-- funcao MIN
SELECT MIN(preco) FROM produtos



-- funcao SUM
SELECT SUM(preco) FROM produtos


-- funcao AVG (media)
SELECT AVG(preco) FROM produtos
SELECT ROUND(AVG(preco),2) FROM produtos

SELECT ROUND(AVG(preco),2) FROM produtos
WHERE nome_produto='Refrigerante'
