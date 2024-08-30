-- limita a 4 linhas

SELECT * FROM produtos
ORDER BY preco
LIMIT 4

-- seleciona 3 e começa a contara partir do 3 (exclui os 2 primeiros)

SELECT * FROM produtos
ORDER BY preco DESC
LIMIT 3
OFFSET 2;


-- mostra os produtos a partir do 3º (exclui os 2 primeiros)

SELECT * FROM produtos
ORDER BY preco DESC
OFFSET 2;