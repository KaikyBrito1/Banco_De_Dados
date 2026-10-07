-- 1

CREATE USER 'my_user'@'host' IDENTIFIED BY 'senha_forte';

-- 2

CREATE USER 'my_admin'@'host' IDENTIFIED BY 'senha_forte';

-- 3



-- 4

GRANT ALL PRIVILEGES ON biblioteca.* TO 'my_admin'@'host';

-- 5

GRANT SELECT, INSERT, DELETE, UPDATE ON biblioteca.* TO 'my_user'@'host';

-- 6

SHOW GRANTS FOR 'my_user'@'host';

SHOW GRANTS FOR 'my_admin'@'host';

-- 7

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'my_user'@'host';

-- 8

CREATE VIEW id_livro AS SELECT * FROM livros;

-- 9 

GRANT SELECT ON biblioteca.id_livro TO 'my_user'@'host'; 

-- 10

CREATE USER 'my_user'@'localhost' IDENTIFIED BY 'senha_123';
SHOW TABLES;

-- 11

UPDATE sua_tabela SET sua_coluna = 'novo_valor' WHERE id = 1;

-- 12

CREATE ROLE papelAdmin;
CREATE ROLE papelDev;

-- 13

GRANT ALL PRIVILEGES ON seu_banco.* TO papelAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON seu_banco.* TO papelDev;

-- 14

CREATE USER 'my_user'@'localhost' IDENTIFIED BY 'my_user';
CREATE USER 'my_admin'@'localhost' IDENTIFIED BY 'my_admin';

GRANT papelDev TO 'my_user'@'localhost';
GRANT papelAdmin TO 'my_admin'@'localhost';

-- 15

SET DEFAULT ROLE papelDev TO 'my_user'@'localhost';
SET DEFAULT ROLE papelAdmin TO 'my_admin'@'localhost';

