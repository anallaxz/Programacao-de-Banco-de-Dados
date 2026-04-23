CREATE DATABASE Triigger;
USE Triigger;

CREATE TABLE Produtos ( 
Id_Produto INT PRIMARY KEY AUTO_INCREMENT,
Nome VARCHAR(100),
Quantidade_estoque INT NOT NULL

);

CREATE TABLE Pedidos(
Id_Pedido INT PRIMARY KEY AUTO_INCREMENT,
Quantidade_vendida INT,
Data_venda DATETIME, 
Id_Produto INT,
FOREIGN KEY (Id_Produto) REFERENCES Produtos(Id_Produto)
); 

DELIMITER $$
CREATE TRIGGER tg_atualizar_estoque
AFTER INSERT ON Pedidos
FOR EACH ROW 
BEGIN

	UPDATE Produtos
	SET Quantidade_estoque = Quantidade_estoque-NEW.Quantidade_vendida
	WHERE Id_Produto = NEW.Id_Produto;
END $$
DELIMITER ;

INSERT INTO Produtos(Id_produto, Nome, Quantidade_estoque)
VALUES
(1, 'Carro', '4'),
(2, 'Onibus', '1'),
(3, 'Moto', '2')
(4, 'Metro', '1');
