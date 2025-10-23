drop database if exists zoo;
create database if not exists zoo;
use zoo;

create databases if not exists zoo;

create table especie (
id_especie int, 
descripcion varchar (100),
primary key (id_especie)
)

create table animal (
id_animal int, 
nombre varchar(100),
fechanac date,
especie_id int,
zona_id int,
primary key (id_animal),
Foreign Key (especie_id) references  especie(id_especie),
Foreign key (zona_id) references zona(id_zona)
)

create table zona (
id_zona int,
descripcion varchar(100)
)

create table consume (
animal_id int,
alimento_id int,
cantidad_dia int,
Foreign key (animal_id) references animal(id_animal),
foreign key (alimento_id) references alimento(id_alimento)
)

create table alimento (
id_alimento int,
descripcion varchar(100),
coste Double
)

create table tratamiento(
id_tratamiento int,
descripcion varchar(100),
coste Double
)

create table recibe (
id_animal int,
id_empleado int,
id_tratamiento int,
fechahora datetime
)

create table trabaja (
zona_id int,
empleado_id int
)

create table empleado (
id_empleado int,
nombre varchar(100),
fechanac date,
direccion varchar(100),
zona_id int,
tratamiento_id int,
primary key (id_empleado),
foreign key (zona_id) references zona(id_zona),
foreign key (tratamiento_id) references tratamiento(id_tratamiento)
)

create table escapaz (
empleado_id int,
tratamiento_id int,
foreign key (empleado_id) references empleado (id_empleado),
foreign key (tratamiento_id) references tratamiento(id_tratamiento)
)

create table nomina (
id_nomina int,
fecha_emision date,
importe_bruto double,
irpf double,
segsocial double,
empleado_id,
primary key (id_nomina),
foreign key (empleado_id) references empleado(id_empleado)
)

##tabla independiente

create table evento(
id_evento int,
descripcion varchar(100),
precio double,
horainicio time,
horafin time

)

create table entrada(
id_entrada int,
fechahoraventa datetime,
evento_id int,
primary key (id_entrada),
foreign key (evento_id) references evento(id_evento)

)
