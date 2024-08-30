CREATE TABLE clientes (
	cod_cliente INT PRIMARY KEY,
	nome_cliente VARCHAR(20) NOT NULL,
	sobrenome_cliente VARCHAR(40) NOTNULL
);

CREATE TABLE produtos (
	cod_produto INT PRIMARY KEY,
	nome_produto VARCHAR(30) NOT NULL,
	descricao TEXT,
	preco NUMERIC CHECK(preco>0) NOT NULL, -- checa se o preço é maior que 0
	qtde_estoque SMALLINT DEFAULT 0 -- deixa 0 como default
);

CREATE TABLE pedidos (
	cod_pedido SERIAL PRIMARY KEY,
	cod_cliente INT NOT NULL REFERENCES clientes(cod_cliente), -- chave estrangeira
	cod_produto INT NOT NULL,
	qtde SMALLINT NOT NULL,
	FOREIGN KEY(cod_produto) REFERENCES produtos(cod_produto)
	
);