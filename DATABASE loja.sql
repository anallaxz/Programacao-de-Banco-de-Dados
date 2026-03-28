CREATE DATABASE loja;
USE loja;

CREATE TABLE clientes (
	id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(100),
    uf VARCHAR(100),
    data_cadastro DATE
    );
    
CREATE TABLE categorias (
	id_categoria INT PRIMARY KEY,
    nome_categoria VARCHAR(100)
    );
    
CREATE TABLE produtos (
	id_produto INT PRIMARY KEY,
    descricao VARCHAR(100),
    preco_unitario FLOAT,
    estoque INT,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
    );
    
    CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    quantidade INT,
    data_venda DATE
    );
    
INSERT INTO clientes (id_cliente, nome, cidade, uf, data_cadastro)
VALUES 
(10, 'Ana Silva', 'São Paulo', 'SP', '2023-01-15');
(11, 'Bruno Souza', 'Curitiba', 'PR', '2023-05-20');
(12, 'Carla Dias', 'São Paulo', 'SP', '2024-02-10');
(13, 'Diego Lemos', 'Belo Horizonte', 'MG', '2024-03-01');

INSERT INTO categorias (id_categoria, nome_categoria)
VALUES
(1, 'Eletrônicos');
(2, 'Móveis');
(3, 'Informática');

INSERT INTO produtos (id_produto, descricao, preco_unitario, estoque, id_categoria)
VALUES 
(101, 'Smartphone X', 2500.00, 50, 1);
(102, 'Cadeira Gamer', 1200.00, 15, 2);
(103, 'Mouse Sem Fio', 150.00, 100, 3);
(104, 'Monitor 4K', 3200.00, 10, 3);
(105, 'Mesa de Escritório', 850.00, 8, 2);

INSERT INTO vendas (id_venda, id_cliente, id_produto, quantidade, data_venda)
VALUES 
(1001, 10, 101, 1, '2024-03-10');
(1002, 11, 102, 2, '2024-03-12');
(1003, 10, 103, 5, '2024-03-15');
(1004, 12, 101, 1, '2024-03-20');
(1005, 13, 105, 1, '2024-03-22');
(1006, 10, 104, 1, '2024-03-25');


-- att.4: A) 1
SELECT MAX(preco_unitario) 
FROM produtos 
WHERE id_categoria = 3;
-- Rspt: 3200

-- att.4: A) 2
SELECT MIN(preco_unitario) 
FROM produtos 
WHERE id_categoria = 2;
-- Rspt: 850

-- att.4: A) 3
SELECT p.id_categoria, COUNT(DISTINCT v.id_produto)
FROM vendas v
JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY p.id_categoria;
-- Rspt: id_1: 1, id_2: 2, id_3: 2. 

-- att.4: B) 1
SELECT MAX(p.preco_unitario) AS maior_valor
FROM vendas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN produtos p ON p.id_produto = v.id_produto
WHERE c.cidade = 'São Paulo'
-- Rspt: 3200

-- att.4: B) 2
SELECT SUM(quantidade) 
FROM vendas 
WHERE id_produto = 101;
-- Rspt: 2

-- att.4: B) 3
SELECT * 
FROM vendas
WHERE data_venda BETWEEN '2024-01-01' AND '2024-12-31';
-- Rspt: 3200

-- att.5
INSERT INTO vendas VALUES (2000, 99, 101, 1, '2024-04-01');
-- Rspt: vai dar erro de violação de chave estrangeira. 
-- o comando tenta inserir uma venda e um cliente inexistentes em outras tabelas, então o banco protege a consistência dos dados.
