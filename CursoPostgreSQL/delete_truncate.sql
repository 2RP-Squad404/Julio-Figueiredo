-- DELETE FROM nome_tabela
-- WHERE condições


-- TRUNCATE TABLE -- EXCLUI TODOS OS REGISTROS DA TABELA
-- TRUNCATE TABLE nome_tabela


DELETE FROM produtos
WHERE cod_produto = 12;

DELETE FROM produtos
WHERE nome_produto = 'Manteiga'


DELETE FROM produtos
WHERE qtde_estoque <= 5;


SELECT * FROM pedidos
TRUNCATE TABLE pedidos