-- ordena os nomes em ordem alfabética

SELECT * 
FROM produtos
ORDER BY nome_produto


-- ordena da maior quantidade pra menor

SELECT * 
FROM produtos
ORDER BY qtde_estoque DESC;


-- ordena pelo nome, depois pelo preço

SELECT nome_produto, preco
FROM produtos
ORDER BY nome_produto, preco;

-- ordena as descrições e coloca os nulos por último

SELECT nome_produto, descricao
FROM produtos
ORDER BY descricao NULLS LAST;

