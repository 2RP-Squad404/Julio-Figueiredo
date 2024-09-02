INSERT INTO clientes (cod_cliente, nome_cliente, sobrenome_cliente)
VALUES (1, 'Fabio', 'dos Reis');

INSERT INTO clientes (cod_cliente, nome_cliente, sobrenome_cliente)
VALUES (2, 'Monica', 'Silveira');

INSERT INTO clientes (cod_cliente, nome_cliente, sobrenome_cliente)
VALUES (3, 'Ana', 'Teixeira');



INSERT INTO produtos (cod_produto, nome_produto, descricao, preco, qtde_estoque)
VALUES
(1, 'alcool gel', 'garrafa de alcool de 1 litro', 12.90, 20),
(2, 'Luvas de Latex', 'caixa de luvas com 100 unidades', 32.50, 25),
(3, 'Pasta de dentes', 'tubo de pasta de 90g', 3.60, 12),
(4, 'Sabonete', 'Sabonete antibacteriano',3.50, 5),
(5, 'Enxaguante bucal', 'anti septico bucal 500ml', 17.00, 28);



INSERT INTO pedidos (cod_cliente, cod_produto, qtde)
VALUES
(1,2,3),
(2,3,2),
(1,3,4);





INSERT INTO produtos(cod_produto, nome_produto, descricao, preco, qtde_estoque) 
VALUES 
(6, 'Detergente', 'Detergente líquido 500ml', 1.89, 32),
(7, 'Leite Integral', 'Leite Integral caixa de 1 litro', 4.60, 70),
(8, 'Refrigerante', 'Garrafa de refrigerante 600ml', 3.70, 14),
(9, 'Refrigerante', 'Garrafa de refrigerante 1 litro', 6.89, 16),
(10, 'Refrigerante', 'Lata de refrigerante 300 ml', 2.99, 45);

INSERT INTO produtos(cod_produto, nome_produto, preco, qtde_estoque) 
VALUES 
(11, 'Margarina', 3.20, 8);

SELECT * FROM produtos;




INSERT INTO produtos (cod_produto, nome_produto, descricao, preco, qtde_estoque)
VALUES 
(12, 'Sabão em Pó', 'Caixa de Sabão em pó de 1/2 kg', 12.50, 5),
(13, 'Biscoito', 'Pacote de biscoito integral 110g', 3.45, 16),
(14, 'Manteiga', 'Pote de manteiga 250g', 8.70, 5);

SELECT * FROM produtos


INSERT INTO pedidos (cod_cliente, cod_produto, qtde)
VALUES 
(1,2,3),
(2,3,2),
(1,3,4),
(2,6,3),
(2,5,2),
(3,8,5);