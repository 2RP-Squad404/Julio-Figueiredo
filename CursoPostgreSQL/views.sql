-- cria uma tabela para mostrar uma query 

CREATE OR REPLACE VIEW vendas AS
	SELECT CL.nome_cliente AS Cliente, PR.nome_produto AS Produto, 
	PE.qtde AS quantidade, PE.cod_pedido AS Pedido, 
	PR.preco * PE.qtde AS Fatura 
	FROM pedidos PE 
	INNER JOIN clientes CL 
		ON PE.cod_cliente = CL.cod_cliente
	INNER JOIN produtos PR 
		ON PE.cod_produto = PR.cod_produto;

SELECT cliente, SUM(fatura)
FROM vendas
GROUP BY cliente


DROP VIEW nome_tabela