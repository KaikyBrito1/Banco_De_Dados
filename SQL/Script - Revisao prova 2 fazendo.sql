CREATE DATABASE IF NOT EXISTS loja_virtual;
USE loja_virtual;

-- 1. Tabela de Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    data_cadastro DATE
);

-- 2. Tabela de Produtos
CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    preco DECIMAL(10, 2) NOT NULL
);

-- 3. Tabela de Pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    status VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- 4. Tabela de Itens do Pedido (Relacionamento N:M entre Pedidos e Produtos)
CREATE TABLE itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- 5. Tabela de Avaliações de Produtos
CREATE TABLE avaliacoes (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT,
    id_cliente INT,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Inserindo Clientes (Note que o cliente 'Carlos' não terá pedidos)
INSERT INTO clientes (nome, cidade, data_cadastro) VALUES
('Ana Silva', 'São Paulo', '2025-01-10'),
('Bruno Costa', 'Rio de Janeiro', '2025-02-15'),
('Carlos Souza', 'Belo Horizonte', '2025-03-01'),
('Diana Prince', 'São Paulo', '2025-03-12'),
('Eduardo Lima', 'Porto Alegre', '2025-04-05');

-- Inserindo Produtos (O produto 'Teclado Mecânico' não terá vendas nem avaliações)
INSERT INTO produtos (nome, categoria, preco) VALUES
('Smartphone X', 'Eletrônicos', 2500.00),
('Notebook Pro', 'Eletrônicos', 4500.00),
('Cadeira Gamer', 'Móveis', 1200.00),
('Teclado Mecânico', 'Periféricos', 350.00),
('Livro de SQL', 'Livros', 90.00),
('Mouse Sem Fio', 'Periféricos', 150.00);

-- Inserindo Pedidos
INSERT INTO pedidos (id_cliente, data_pedido, status) VALUES
(1, '2026-01-15', 'Entregue'),
(2, '2026-01-20', 'Entregue'),
(1, '2026-02-10', 'Processando'),
(4, '2026-02-15', 'Entregue'),
(5, '2026-03-01', 'Cancelado');

-- Inserindo Itens dos Pedidos
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 2500.00),
(1, 5, 2, 90.00),   
(2, 2, 1, 4500.00), 
(3, 6, 1, 150.00),  
(4, 3, 1, 1200.00), 
(5, 1, 1, 2500.00); 

-- Inserindo Avaliações
INSERT INTO avaliacoes (id_produto, id_cliente, nota, comentario) VALUES
(1, 1, 5, 'Excelente celular, bateria dura muito.'),
(2, 2, 4, 'Muito rápido, mas esquenta um pouco.'),
(5, 1, 5, 'Melhor livro de banco de dados!');



-- 1

SELECT max(preco), min(preco), avg(preco) from produtos;

-- 2
-- CORRIGIR

SELECT count(id_produto) from produtos where categoria is not null; 

-- 3

SELECT clientes.nome, pedidos.id_pedido from clientes left join pedidos on clientes.id_cliente = pedidos.id_cliente;

-- 4

SELECT categoria, avg(preco) from produtos group by categoria having avg(preco) > 1000;

-- 5

SELECT produtos.nome, sum(itens_pedido.quantidade) 
from produtos join itens_pedido on produtos.id_produto = itens_pedido.id_produto 
group by produtos.nome having sum(itens_pedido.quantidade);

-- 6
-- CORRIGIR 
SELECT cliente.nome, sum(itens_pedido.quantidade) 
from produtos
join itens_pedido on clientes.id_produto = itens_pedido.id_produto
join pedidos on pedidos.id_pedido = itens_pedido.id_pedido 
group by produtos.nome
having count(itens_pedido.quantidade) > 1;

-- 7

SELECT count(itens_pedido.quantidade), sum(quantidade * preco), categoria from produto join itens_pedido on itens_pedido.id