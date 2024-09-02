-- clausula ON determina a condição do join

SELECT pedidos.cod_pedido, produtos.nome_produto, pedidos.qtde
FROM pedidos -- essa tabela é a que tem a FK
INNER JOIN produtos
ON pedidos.cod_produto=produtos.cod_produto; -- pk e fk

-- usando aliases

SELECT PE.cod_pedido, PR.nome_produto, PE.qtde
FROM pedidos PE
INNER JOIN produtos PR
ON PE.cod_produto=PR.cod_produto
WHERE PE.cod_pedido = 9;

-- com 3 tabelas

SELECT PE.cod_pedido, CL.nome_cliente, PR.nome_produto, PE.qtde
FROM pedidos PE
INNER JOIN produtos PR
ON PE.cod_produto=PR.cod_produto
INNER JOIN clientes CL
ON PE.cod_cliente=CL.cod_cliente
WHERE PE.cod_pedido = 9;
