DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE IF NOT EXISTS pizzeria;
USE pizzeria;

/*Creació taula provincies*/
CREATE TABLE provincies (
id int not null auto_increment,
nom varchar (50),
primary key (id));

/*Creació taula localitat*/
CREATE TABLE localitat (
id int not null auto_increment,
nom varchar (50),
id_provincia int,
primary key (id),
foreign key (id_provincia) references provincies (id));

/*Creació taula client*/
CREATE TABLE client (
id int not null auto_increment,
nom varchar(20) not null,
cognoms varchar(40) not null,
direccio varchar(60),
codi_postal int,
id_localitat int,
telefon int,
foreign key (id_localitat) references localitat(id),
primary key (id));

/*Creació taula botiga*/
CREATE TABLE botiga (
id int not null auto_increment,
direccio varchar(60),
codi_postal int,
id_localitat int,
primary key (id),
foreign key (id_localitat) references localitat(id));

/*Creació taula empleat*/
CREATE TABLE empleat (
id int not null auto_increment,
nom varchar(20),
cognoms varchar(40),
nif varchar (9),
telefon int,
feina enum('cuiner','repartidor'),
id_botiga int,
primary key(id),
foreign key (id_botiga) references botiga(id));

/*Creació taula categories*/
CREATE TABLE categories (
id int not null auto_increment,
nom varchar (40),
primary key (id));

/*Creació taula pizzes*/
CREATE TABLE pizzes (
id int not null auto_increment,
nom varchar (20),
descripcio varchar(60),
image blob,
preu decimal,
id_categoria int,
primary key (id),
foreign key (id_categoria) references categories (id));

/*Creació taula hamburgueses*/
CREATE TABLE hamburgueses (
id int not null auto_increment,
nom varchar (30),
descripcio varchar(60),
image blob,
preu decimal,
primary key (id));

/*Creació taula begudes*/
CREATE TABLE begudes (
id int not null auto_increment,
nom varchar (30),
descripcio varchar(60),
image blob,
preu decimal,
primary key (id));

/*Creació taula comandes*/
CREATE TABLE comandes (
id int not null auto_increment,
id_botiga int,
id_empleat int,
id_client int,
data timestamp,
repartir boolean,
pizza1 int,
pizza2 int,
pizza3 int,
hamburguesa1 int,
hamburguesa2 int,
hamburguesa3 int,
beguda1 int,
beguda2 int,
beguda3 int,
preu_total decimal,
id_repartidor int,
entrega timestamp null,
primary key (id),
foreign key (id_botiga) references botiga(id),
foreign key (id_empleat) references empleat (id),
foreign key (id_client) references client(id),
foreign key (id_repartidor) references empleat(id));

/*emplena taula provincies*/
insert into provincies values (1,'Barcelona');
insert into provincies values (2,'Girona');
insert into provincies values (3,'Lleida');
insert into provincies values (4,'Tarragpna');

/*emplena taula localitat*/
insert into localitat (nom, id_provincia) values ('Barcelona',1);
insert into localitat (nom, id_provincia) values ('Granollers',1);
insert into localitat (nom, id_provincia) values ('Mataró',1);
insert into localitat (nom, id_provincia) values ('Girona',2);
insert into localitat (nom, id_provincia) values ('Lleida',3);
insert into localitat (nom, id_provincia) values ('Tarragona',4);

/*emplena taula clients*/
insert into client values (1, 'Jordi','Garcia Moreno','cr. Corró, 163 2n 2a',08401,2,938464703);
insert into client values (2, 'Laia', 'Facundo Mogas','cr. Corró, 163 2n 2a',08401,2,938464703);
insert into client values (3, 'Laura','Marti Perafita','cr. Almogavers, 24',08301,3,678989890);
insert into client values (4, 'Pepa','Fernandez Moreno','cr. espanya, 189',17007,4,615785467);
insert into client values (5, 'Sandra','Marquez Viladrau','cr. Pompeu Fabra,45 baixos',25002,5,628765687);

/*emplena taula botiga*/
insert into botiga values (1,'cr. Joan Prim, 286','08401',2);
insert into botiga values (2,'cr. Tarragona, 300','08301',3);
insert into botiga values (3,'Plaça Catalunya, 12','08001',1);
insert into botiga values (4,'cr LLuis Companys, 158','17007',4); 
insert into botiga values (5,'cr inventat s/n,','25002',5); 

/*emplena taula empleat*/
insert into empleat values (1,'Gerard','Minguez Hernandez','47703778P',634567898,'repartidor',1);
insert into empleat values (2,'Josep','Galvez Bellard','4804748Ñ',615769876,'cuiner',1);
insert into empleat values (3,'Maria','Soler Figueres','479679D',680452154,'repartidor',2);
insert into empleat values (4,'Paula','Dominguez Hervàs','523679L',938769823,'cuiner',2);
insert into empleat values (5,'Mireia','Fernandez Vazquez','477876H',628653465,'cuiner',3);
insert into empleat values (6,'Albert','Sanchez Sanchez','4234556L',615563421,'repartidor',3);
insert into empleat values (7,'Pau','Verdaguer Verdasco','66543783L',938467687,'repartidor',4);
insert into empleat values (8,'Josep','Berenguer Gálvez','4569758X',628654802,'cuiner',4);
insert into empleat values (9,'Bea','Solsona Capdevila','794797K',678493646,'repartidor',5);
insert into empleat values (10,'Jorge','Alfons Brutau','47473G',62987437,'cuiner',5);

/* emplenar taula categories*/
insert into categories values (1,'primavera');
insert into categories values (2,'estiu');
insert into categories values (3,'tardor');
insert into categories values (4,'hivern');

/*emplenar taula pizzes*/
insert into pizzes values (1,'Margarita','mozzarella i pernil',null,9.90,1);
insert into pizzes values (2,'Hawaiana','pinya, pernil i mozarella',null,9.90,2);
insert into pizzes values (3,'boletus','diversos bolets',null,9.90,3);

/*emplenar taula hamburgueses*/
insert into hamburgueses values (1,'clàssica','hamburguesa amb formatge',null,12.50);
insert into hamburgueses values (2,'parrilla','hamburguesa amb bacon i ceba',null,15.00);
insert into hamburgueses values (3,'extra','hamburguesa premium amb formatge',null,20.00);

/*emplenar taula begudes*/
insert into begudes values (1,'aigua','aigua',null,2.50);
insert into begudes values (2,'refresc','cola',null,3.0);
insert into begudes values (3,'cervesa','estrella damm',null,4.50);

/*emplenar taula comandes*/
insert into comandes values(1,1,1,1,'2021-12-01 22:10:15',true,1,0,0,1,0,0,2,0,0,33.15,1,'2021-12-01 22:30:00');
insert into comandes values(2,1,2,2,'2021-12-08 22:00:00',true,2,0,0,1,1,0,2,0,2,74.17,3,'2021-12-08 22:25:00');
insert into comandes values(3,2,3,3,'2021-12-08 22:00:00',false,2,0,0,1,1,0,2,0,2,74.17,null,null);
insert into comandes values(4,3,6,1,'2021-12-15 15:00:00',false,1,0,0,0,0,0,0,1,0,15.60,null,null);
insert into comandes values(5,4,9,4,'2021-12-08 22:00:00',true,2,0,0,0,0,0,0,0,2,31.21,9,'2021-12-08 22:15:00');

/*consulta begudes venudes en la localitat 3 */
SELECT  beguda1,beguda2,beguda3 FROM comandes
INNER JOIN botiga
on botiga.id = comandes.id_botiga
inner join localitat
on botiga.id_localitat = localitat.id
where localitat.id = 3;

/*consulta de les comandes fetes per l'empleat Maria */
SELECT * FROM comandes
inner join empleat
on empleat.id = comandes.id_empleat
where empleat.nom LIKE 'Maria';

