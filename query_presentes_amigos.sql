CREATE DATABASE PresentesAmigos;
USE PresentesAmigos;
-- DROP DATABASE presentesamigos;


CREATE TABLE Amigo(
    idAmigo int auto_increment,
    nome varchar(100) not null,
    email varchar(50) not null,
    tipoAmigo varchar(20) not null,
       
    pais varchar (30) not null,
    cep varchar(10) not null,
    cidade varchar(40) not null,
    UF varchar(2) not null,
    bairro varchar(100) not null,
    rua varchar(100) not null,
    numero varchar(10),
    complemento varchar(100),
    PRIMARY KEY (idAmigo)
);


CREATE TABLE Presente(
    idPresente int auto_increment,
    nome varchar(100) not null,
    preco decimal(10,2),
    tipo varchar(50) not null,
   
    PRIMARY KEY (idPresente)
);


CREATE TABLE Telefone(
    idTelefone int auto_increment,
    telefone varchar(20) not null,
   
    amigo_idAmigo int not null,
    PRIMARY KEY (idTelefone),
    INDEX fk_telefone_amigo1_idx (amigo_idAmigo ASC)
);


CREATE TABLE Presentear(
    idPresentear int,
    presente_idPresente int,
    amigo_idAmigo int,
    dataPresente date not null,
   
    PRIMARY KEY (idPresentear),
    INDEX fk_presentear_amigo1_idx (amigo_idAmigo ASC)
);
       
ALTER TABLE Telefone
    ADD CONSTRAINT fk_telefone_amigo1
        FOREIGN KEY (amigo_idAmigo)
        REFERENCES Amigo(idAmigo);
       
ALTER TABLE Presentear
    ADD CONSTRAINT presentear_ibfk_1
        FOREIGN KEY (presente_idPresente)
        REFERENCES Presente (idPresente),
    ADD CONSTRAINT fk_presentear_amigo1
        FOREIGN KEY (amigo_idAmigo)
        REFERENCES Amigo (idAmigo);
