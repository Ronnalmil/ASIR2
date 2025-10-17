drop database if exists zoo;
create database if not exists zoo;
use zoo; 

create table empleado (
id varchar(100),
nombre varchar(100),
fecha_nacimiento date,
direccion varchar(100)
);


create table nomina (
id varchar(50),
fecha_emision varchar(100),
importe_bruto varchar(100),
irph varchar(100),
segsocial varchar(100)	
primary key (id),
foreign key (id_empleado) references empleado(id)
);


