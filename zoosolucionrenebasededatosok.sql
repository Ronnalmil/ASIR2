# https://www.w3schools.com/mysql/mysql_insert.asp

CREATE DATABASE IF NOT EXISTS zoo;
USE zoo ;

-- -----------------------------------------------------
-- Table zoo.evento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.evento (
  id INT NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  horaInicio TIME NULL,
  horaFin TIME NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table zoo.entrada
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.entrada (
  id INT NOT NULL  AUTO_INCREMENT,
  fechaHoraVenta DATETIME NOT NULL,
  idEvento INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idEvento) REFERENCES zoo.evento (id));


-- -----------------------------------------------------
-- Table zoo.zona
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.zona (
  id INT NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table zoo.especie
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.especie (
  id INT NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table zoo.animal
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.animal (
  id INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  idEspecie INT NOT NULL,
  idZona INT NOT NULL,
  fechaNac DATE NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idZona) REFERENCES zoo.zona (id),
  FOREIGN KEY (idEspecie) REFERENCES zoo.especie (id));


-- -----------------------------------------------------
-- Table zoo.alimento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.alimento (
  id INT NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  coste DOUBLE NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table zoo.consume
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.consume (
  idAnimal INT NOT NULL,
  idAlimento INT NOT NULL,
  cantidadDia INT NOT NULL,
  PRIMARY KEY (idAnimal, idAlimento),
  FOREIGN KEY (idAnimal) REFERENCES zoo.animal (id),
  FOREIGN KEY (idAlimento) REFERENCES zoo.alimento (id));


-- -----------------------------------------------------
-- Table zoo.empleado
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.empleado (
  id INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  fechaNac DATE NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table zoo.tratamiento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.tratamiento (
  id INT NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  coste DOUBLE NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table zoo.animaltratamiento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.animaltratamiento (
  idAnimal INT NOT NULL,
  idEmpleado INT NOT NULL,
  idTratamiento INT NOT NULL,
  fechaHora DATETIME NOT NULL,
  PRIMARY KEY (idAnimal, idEmpleado, idTratamiento, fechaHora),
  FOREIGN KEY (idAnimal) REFERENCES zoo.animal (id),
  FOREIGN KEY (idTratamiento) REFERENCES zoo.tratamiento (id),
  -- La siguiente FH la añade el diseñador de la BD
  -- para asegurar integridad referencial (que idEmpleado exista en tabla empleado)
  -- NO PROCEDE DEL DIAGRAMA ENTIDAD-RELACIÓN
  FOREIGN KEY (idEmpleado) REFERENCES zoo.empleado (id));


-- -----------------------------------------------------
-- Table zoo.trabaja
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.trabaja (
  idZona INT NOT NULL,
  idEmpleado INT NOT NULL,
  PRIMARY KEY (idZona, idEmpleado),
  FOREIGN KEY (idZona) REFERENCES zoo.zona (id),
  FOREIGN KEY (idEmpleado) REFERENCES zoo.empleado (id));


-- -----------------------------------------------------
-- Table zoo.escapaz
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.escapaz (
  idEmpleado INT NOT NULL,
  idTratamiento INT NOT NULL,
  PRIMARY KEY (idEmpleado, idTratamiento),
  FOREIGN KEY (idTratamiento) REFERENCES zoo.tratamiento (id),
  FOREIGN KEY (idEmpleado) REFERENCES zoo.empleado (id));


-- -----------------------------------------------------
-- Table zoo.nomina
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS zoo.nomina (
  id INT NOT NULL,
  fechaEmision DATE NOT NULL,
  importeBruto DOUBLE NOT NULL,
  irpf DOUBLE NOT NULL,
  segSocial DOUBLE NOT NULL,
  idEmpleado INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (idEmpleado) REFERENCES zoo.empleado (id));
