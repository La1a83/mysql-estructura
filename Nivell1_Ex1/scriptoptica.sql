DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;
use optica;

/*Creació taula proveïdors*/
CREATE TABLE proveidor (
id int(12) not null auto_increment,
nom varchar(60) not null,
direccio varchar(60),
telefon varchar(12),
fax varchar(12),
nif varchar(60),
primary key (id),
key idx_id(id));

/*Creació taula empleats*/
CREATE TABLE empleat (
id int(11) not null auto_increment,
nom varchar (60),
primary key (id));

/*Creació taula ulleres*/
CREATE TABLE ulleres (
id int(11) not null auto_increment,
marca varchar(60) not null,
graduacio_vidre_esq float (5.2) not null,
graduacio_vidre_dret float(5.2) not null,
montura enum('flotant','pasta','metalica'),
color_montura varchar(20) not null,
color_vidre_esq varchar (20) not null,
color_vidre_dret varchar(20) not null,
preu decimal,
venuda boolean,
id_empleat_venta int(11),
primary key (id),
key idx_marca(marca),
foreign key(id_empleat_venta) references empleat (id));

/*Creació taula client*/
CREATE TABLE client (
id int(12) not null auto_increment,
nom varchar(60) not null,
adreça varchar(80),
telefon varchar(12),
mail varchar (60),
data_registre date,
id_client_recomana int(11),
primary key(id),
foreign key(id_client_recomana) references client(id));

/*Creació taula factura*/
CREATE TABLE factura (
id int(12) not null auto_increment,
data date not null,
id_client int(11)not null,
id_ulleres int(11) not null,
preu decimal,
primary key(id),
foreign key(id_client) references client(id),
foreign key(id_ulleres) references ulleres(id));

/*Creació taula comanda_ulleres*/
CREATE TABLE comanda_ulleres (
id_proveidor int not null,
marca varchar(60) not null,
foreign key(id_proveidor) references proveidor(id),
foreign key (marca) references ulleres(marca));


/*Emplenar taula proveïdors*/
insert into proveidor (nom, direccio,telefon,fax,nif) 
values('proveidor 1','cr. Aragó, 145, 08030, Barcelona,Espanya','938708167','938900012','B90876876');
insert into proveidor (nom, direccio,telefon,fax,nif) 
values('proveidor 2','cr. Meridiana, 530, 08020, Barcelona,Espanya','938703465','939082354','B9098709456');
insert into proveidor (nom, direccio,telefon,fax,nif) 
values('proveidor 3','cr. Corró, 163, 08400, Granollers,Espanya','938790456','939873456','B9807654');

/*Emplenar taula empleat*/
insert into empleat(nom)
values ('Juan Garcia Fernandez');
insert into empleat(nom)
values ('Pedro Gonzalez Gonzalez');
insert into empleat (nom)
values ('Sandra Capdevila, Bellés');
insert into empleat(nom)
values ('Laia Facundo Mogas');	

/*Emplenar taula ulleres*/
insert into ulleres(marca, graduacio_vidre_esq,graduacio_vidre_dret, montura,color_montura,color_vidre_esq,color_vidre_dret,preu,venuda,id_empleat_venta)
values ('Guess',10.20,10.20,'flotant','vermell','transparent','transparent',200.50,1,1);
insert into ulleres(marca, graduacio_vidre_esq,graduacio_vidre_dret, montura,color_montura,color_vidre_esq,color_vidre_dret,preu,venuda,id_empleat_venta)
values ('Ralph Lauren',00.00,00.00,'metalica','gris','marró','marró',300.00,1,2);
insert into ulleres(marca, graduacio_vidre_esq,graduacio_vidre_dret, montura,color_montura,color_vidre_esq,color_vidre_dret,preu,venuda,id_empleat_venta)
values ('Gucci',00.00,00.00,'metalica','gris','blau','blau',100.00,1,1);
insert into ulleres(marca, graduacio_vidre_esq,graduacio_vidre_dret, montura,color_montura,color_vidre_esq,color_vidre_dret,preu,venuda,id_empleat_venta)
values ('Ray Ban',00.00,00.00,'flotant','marró','marró','marró',300,1,1);

/*emplenar taula client*/
insert into client (nom,adreça,telefon,mail,data_registre)
value ('Pere Garrigó Sanchez','cr. Aribau, 340 2n 2a, 08040 Barcelona, Espanya','650345678','pere@gmail.com',20211120);
insert into client (nom,adreça,telefon,mail,data_registre,id_client_recomana)
value ('Jorge Pelaez Garrido','cr. Aribau, 350 2n 2a, 08040 Barcelona, Espanya','630982397','jorge@gmail.com',20211213,1);
insert into client (nom,adreça,telefon,mail,data_registre)
value ('Laura Fernando Marquez','cr. Entença, 200 2n 2a, 08040 Barcelona, Espanya','630789834','laura@gmail.com',2021214);
insert into client (nom,telefon,mail,data_registre,id_client_recomana)
value ('Jaume Domenech fernandez','630982397','laura@gmail.com',20211214,1);

/*emplenar taula comanda_ulleres*/
insert into comanda_ulleres(id_proveidor,marca)
value (1,'Guess');
insert into comanda_ulleres(id_proveidor,marca)
value (1,'Ralph Lauren');
insert into comanda_ulleres(id_proveidor,marca)
value (2,'Gucci');
insert into comanda_ulleres(id_proveidor,marca)
value (3,'Ray Ban');

/*emplenar taula factura*/
insert into factura (data,id_client,id_ulleres,preu)
value(20211214,1,1,400.00);
insert into factura (data,id_client,id_ulleres,preu)
value(20211214,2,2,300.00);
insert into factura (data,id_client,id_ulleres,preu)
value(20211214,3,3,300.00);
insert into factura (data,id_client,id_ulleres,preu)
value(20211212,1,3,400.00);

/*Consulta factures del client amb id =1 durant l'any 2021*/
select * from factura
inner join client
on factura.id_client =  client.id
where factura.id_client = 1
and data between '20210101' and '20211215';

/*Consulta de marques d'ulleres venudes per l'empleat 1 dutrant l'any 2021*/
select  distinct marca, id_empleat_venta from ulleres
inner join empleat
on ulleres.id_empleat_venta = empleat.id
inner join factura
on ulleres.id = factura.id_ulleres
where factura.data between '20210101' and '20211215'
and ulleres.id_empleat_venta= 1;

/*consulta dels proveidors de ulleres venudes*/
select * from comanda_ulleres
inner join ulleres
on comanda_ulleres.marca = ulleres.marca
inner join proveidor
on comanda_ulleres.id_proveidor = proveidor.id
where ulleres.venuda = 1;





















