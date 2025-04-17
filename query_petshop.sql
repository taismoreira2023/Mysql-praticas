-- Criação do banco de dados
create database petshop;
-- criação da tabela (create table)
use petshop;

create table Cliente(
idCliente int auto_increment,
nome varchar(45) not null,
nascimento datetime,
primary key(idCliente));

create table Telefone(
numero varchar(15),
primary key(numero));

create table Endereco(
idEndereco int auto_increment,
logradouro varchar(45) not null,
numero varchar(6) not null,
complemento varchar(45),
bairro varchar(45) not null,
cidade varchar(45) not null,
cep varchar(8),
uf varchar(2),
primary key(idEndereco));

create table TipoCliente(
idTipoCliente int auto_increment,
descricao varchar(45),
primary key(idTipoCliente));

create table Pet(
idPet int auto_increment,
nome varchar(45) not null,
nascimento datetime not null,
primary key(idPet));

create table PorteDoPet(
idPorteDoPet int auto_increment,
descricao varchar(45) not null,
primary key(idPorteDoPet));

create table Raca(
idRaca int auto_increment,
nome varchar(45) not null,
descricao varchar(45),
primary key(idRaca));

create table Sexo(
idSexo int auto_increment,
descricao varchar(45),
primary key(idSexo));

-- Alterar as tabelas(Adicionando Foreign Key)
-- telefone(n) : cliente(1)
alter table Telefone
add column cliente_idCliente int not null,
add constraint fk_telefone_cliente
foreign key (cliente_idCliente)
references Cliente(idCliente);

-- endereco(n) : cliente(1)
alter table Endereco
add column cliente_idCliente int not null,
add constraint fk_endereco_cliente
foreign key(cliente_idCliente)
references Cliente(idCliente);

-- raca(n) : porteDoPet(1)
alter table Raca
add column porteDoPet_idporteDoPet int not null,
add constraint fk_raca_porte_do_pet
foreign key(porteDoPet_idPorteDoPet)
references PorteDoPet(idPorteDoPet);

-- pet(n) : raca(1)
alter table Pet
add column raca_idRaca int not null,
add constraint fk_pet_raca
foreign key(raca_idRaca)
references Raca(idRaca),

-- pet(n) : cliente(1)
add column cliente_idCliente int not null,
add constraint fk_pet_cliente
foreign key(cliente_idCliente)
references Cliente(idCliente),

-- pet(n) : sexo(1)
add column sexo_idSexo int not null,
add constraint fk_pet_sexo
foreign key(sexo_idSexo)
references Sexo(idSexo);

-- cliente(n) : sexo(1)
alter table Cliente
add column sexo_idSexo int not null,
add constraint fk_cliente_sexo
foreign key(sexo_idSexo)
references Sexo(idSexo),

-- cliente(n) : tipoCliente(1)
add column tipoCliente_idTipoCliente int not null,
add constraint fk_cliente_tipo_cliente
foreign key(tipoCliente_idTipoCliente)
references TipoCliente(idTipoCliente);

-- Inserção dos dados
start transaction;
insert into Sexo(descricao)
values('Feminino'),
('Feminino');

insert into TipoCliente (descricao)
values('Pessoa Jurídica'),
('Pessoa Física');

insert into Cliente(nome, nascimento, sexo_idSexo, tipoCliente_idTipoCliente)
values('Taís Moreira', '2002-07-30', 1,1),
('Jujuba Silva', '1970-01-07',2,2);

insert into Telefone(numero,cliente_idCliente)
values('987654321',1),
('123456789',2);

insert into Endereco(logradouro, numero, complemento, bairro, cidade, cep, uf,
cliente_idCliente)
values('Rua da limpeza', '1000', 'Bananeirado lado','Dados de
Lar','Fortaleza','15786254','CE',1),
('Rua da manipulação', '0001', 'Mercado Rosa','Lar de
Dados','Fortaleza','98765432','CE',2);

insert into PorteDoPet(descricao)
values('Porte Grande'),
('Porte Pequeno');

insert into Raca(nome, descricao, porteDoPet_idporteDoPet)
values('Gato','dócil e experiente no banho',1),
('Papagaio','agressivo',2);

insert into Pet (nome, nascimento, raca_idRaca,cliente_idCliente,sexo_idSexo)
values('Lila','2024-03-28',1,1,1),
('Bubu','2024-07-28',2,2,2);
commit;