create database listaaa01;
use listaaa01;

create table editora (
cod_editora int primary key auto_increment,
nome varchar(45) not null,
endereco varchar(45)
);

create table autor (
cod_autor int auto_increment primary key,
nome varchar(45),
sexo CHAR(1),
data_nascimento date
);

create table livro (
cod_livro int primary key auto_increment,
isbn varchar(45),
titulo varchar(45),
num_edicao int,
preco float,
cod_editora int,
foreign key(cod_editora) references editora(cod_editora)
);

create table livro_autor(
cod_livro int not null,
cod_autor int not null,
primary key(cod_livro, cod_autor),
foreign key (cod_livro) references livro(cod_livro) on update cascade,
foreign key (cod_autor) references autor(cod_autor) on update cascade
);
 


