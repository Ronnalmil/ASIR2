PRIMERA PARTE
=============
Crea un usuario 'tengopermisos' y otórgale permisos para que pueda crear usuarios:
CREATE USER 'tengopermisos'@'localhost' IDENTIFIED BY 'manager';
GRANT CREATE USER ON *.* TO 'tengopermisos'@'localhost';

Conectado como 'tengopermisos' crea un nuevo usuario 'user1':
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'manager';

Conectado como 'root', otórgale permisos al usuario 'user1' para que pueda crear tablespaces:
GRANT CREATE TABLESPACE ON *.* TO 'user1'@'localhost';


Conectado como 'user1' comprueba que dispone de dichos permisos ejecutando sentencias SQL que necesiten tener el permiso otorgado:
CREATE TABLESPACE ejemplo ADD DATAFILE '/tmp/tabla.ibd';

Conectado como 'root' crea una tabla dentro del TABLESPACE creado por 'user1':
CREATE TABLE zoo.tabla (cl INT PRIMARY KEY) TABLESPACE ejemplo;z

Conectado como 'root', muestra los permisos que tiene el usuario 'user1':
SHOW GRANTS FOR 'user1'@'localhost';

Conectado como 'user1' muestra los permisos que posee y comprueba que son los mismos a los de la orden anterior:
SHOW GRANTS;

Conectado como 'root' crea un usuario 'matador' que tenga permisos para poder eliminar conexiones activas y pueda ver las conexiones activas de todos los usuarios con el servidor:
GRANT PROCESS, SUPER ON *.* TO 'matador'@'localhost' IDENTIFIED BY 'manager'; (Esta sentencia crea el usuario sin utilizar: CREATE USER)

Conectado como 'root' otorga permiso de creación y borrado de procedimientos, así como de ejecución al usuario 'user1' sobre la base de datos creada previamente:
GRANT ALTER ROUTINE, CREATE ROUTINE, EXECUTE ON zoo.* TO 'user1'@'localhost';

Conectado como 'user1' crea un procedimiento almacenado en la base de datos indicada en el paso anterior, con las siguientes órdenes SQL:
USE zoo

DELIMITER $$
DROP PROCEDURE IF EXISTS test_mysql_while_loop$$
CREATE PROCEDURE test_mysql_while_loop()
BEGIN
DECLARE x INT;
SET x = 1;
WHILE x >= 0 DO
 set x = x+1;
END WHILE;
END$$
DELIMITER ;

Este procedimiento crea un bucle infinito. Conéctate como 'user1' y ejecuta el procedimiento con la orden SQL:
CALL test_mysql_while_loop;

Conectado como 'matador' identifica el proceso y mátalo:
SHOW PROCESSLIST;
+----+---------+-----------+------+---------+------+----------------+----------------------------+
| Id | User    | Host      | db   | Command | Time | State          | Info                       |
+----+---------+-----------+------+---------+------+----------------+----------------------------+
|  8 | user1   | localhost | zoo  | Query   |    0 | Opening tables | CALL test_mysql_while_loop |
|  9 | matador | localhost | NULL | Query   |    0 | starting       | SHOW PROCESSLIST           |
+----+---------+-----------+------+---------+------+----------------+----------------------------+

KILL 8;

¿ Cómo harías para determinar cual es la consulta que está consumiendo los recursos de MySQL ? 
Analizando la salida sel comando SHOW PROCESSLIST; (el procedimiento permanece ejecutando)

Conectado como 'root' crea un usuario de nombre 'creartablas' que tenga permisos para crear, borrar y modificar tablas de una base de datos creada previamente:
CREATE USER 'creartablas'@'localhost' IDENTIFIED BY 'manager';
GRANT CREATE, DROP, ALTER ON zoo.* TO 'creartablas'@'localhost';

Conectado como 'creartablas' crea un tabla sencilla de al menos dos columnas:
CREATE TABLE zoo.prueba (columna1 INT, columna2 VARCHAR(100), columna3 DATE);

Conectado como 'root' crea un usuario de nombre 'accesoglobal' que pueda realizar operaciones de selección e inserción sobre todas las tablas de todas las bases de datos:
CREATE USER 'accesoglobal'@'localhost' IDENTIFIED BY 'manager';
GRANT SELECT, INSERT ON *.* TO 'accesoglobal'@'localhost';

Conectado como 'accesoglobal' añade una fila a la tabla creada anteriormente. Intenta borrar la fila creada. ¿ Puedes ?
INSERT INTO zoo.prueba VALUES (123,'HOLA','2022-11-07');
DELETE FROM zoo.prueba WHERE columna1=123;
No se puede por no terne permiso para borrar filas: DELETE command denied to user 'accesoglobal'@'localhost' for table 'prueba'

Conectado como 'root' crea un usuario de nombre 'accesolocal' que pueda seleccionar todas las tablas de la base de datos anterior:
CREATE USER 'accesolocal'@'localhost' IDENTIFIED BY 'manager';
GRANT SELECT ON zoo.* TO 'accesolocal'@'localhost';

Conéctate como 'accesolocal' y comprueba que puedes selecciona la fila añadida anteriormente:
SELECT * FROM zoo.prueba;

Conectado como 'root' crea un usuario de nombre 'accesolimitado' que pueda realizar operaciones de inserción, actualización y selección sobre la primera columna de la tabla creada previamente:
CREATE USER 'accesolimitado'@'localhost' IDENTIFIED BY 'manager';
GRANT INSERT(columna1), UPDATE(columna1), SELECT(columna1) ON zoo.prueba TO 'accesolimitado'@'localhost';

Conéctate como 'accesolimitado' y comprueba que tienes los permisos ejecutando las órdenes SQL SELECT, UPDATE e INSERT:
SELECT * FROM zoo.prueba; (falla porque sólo tenemos permiso para la columna1)
SELECT columna1 FROM zoo.prueba;
INSERT INTO zoo.prueba (columna1) VALUES (124);
UPDATE zoo.prueba SET columna1=222 WHERE columna1=124;

Comprueba que permisos tienes:
SHOW GRANTS;
+-----------------------------------------------------------------------------------------------------------------+
| Grants for accesolimitado@localhost                                                                             |
+-----------------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'accesolimitado'@'localhost'                                                              |
| GRANT SELECT (columna1), INSERT (columna1), UPDATE (columna1) ON `zoo`.`prueba` TO 'accesolimitado'@'localhost' |
+-----------------------------------------------------------------------------------------------------------------+


SEGUNDA PARTE
=============
Conectado como root crea un usuario de nombre 'creador' que tenga permisos para crear usuarios:
CREATE USER 'creador'@'localhost' IDENTIFIED BY 'manager';
GRANT CREATE USER ON *.* TO 'creador'@'localhost';

Conectado como 'creador' crea un nuevo usuario de nombre 'prueba1':
CREATE USER 'prueba1'@'localhost' IDENTIFIED BY 'manager';

Conectado como root haz que tenga permisos de selección y borrado a nivel global y todos los permisos sobre una base de datos de ejemplo creada previamente. Dichos permisos podrán ser gestionados por el usuario:
GRANT SELECT, DELETE ON *.* TO 'prueba1'@'localhost' WITH GRANT OPTION;
GRANT ALL ON zoo.* TO 'prueba1'@'localhost' WITH GRANT OPTION;

Conectado como 'root' crea un usario de nombre 'prueba2' que tenga permiso para actualizar una tabla de una base de datos creada previamente. Podrá gestionar dicho permiso:
CREATE USER 'prueba2'@'localhost' IDENTIFIED BY 'manager';
GRANT UPDATE ON zoo.animal TO 'prueba2'@'localhost' WITH GRANT OPTION;

Conectado como 'creador' crea un usuario 'prueba3' y 'prueba4':
CREATE USER 'prueba3'@'localhost' IDENTIFIED BY 'manager';
CREATE USER 'prueba4'@'localhost' IDENTIFIED BY 'manager';

Conectado como 'prueba1' otorga permiso de selección, actualización de una columna de una tabla (creada previamente en la base de datos de ejemplo) y ejecución de procedimientos al usuario 'prueba3' en la base de datos de ejemplo. ¿ Puedes hacerlo ? ¿ Por qué ?
GRANT SELECT(nombre),UPDATE(nombre) ON zoo.animal TO 'prueba3'@'localhost';
GRANT EXECUTE ON zoo.* TO 'prueba3'@'localhost';
Puede hacerlo porque 'prueba1' tiene todos los permisos sobre la base de datos zoo y además puede concederlos a otros.

Conectado como 'root' haz que el usuario 'prueba4' pueda parar el servicio mysql:
GRANT SHUTDOWN ON *.* TO 'prueba4'@'localhost';

Impide que el usuario 'prueba1' pueda gestionar los permisos otorgados a nivel global:
REVOKE GRANT OPTION ON *.* FROM 'prueba1'@'localhost';

Comprueba que aún puede gestionar los permisos de la base de datos
GRANT SELECT ON zoo.* TO 'prueba4'@'localhost';
¿ Con qué usuario has realizado la operación ?
Con el usuario 'prueba1'. Puede hacerlo porque tiene GRANT OPTION para todos los privilegios de zoo.
¿ Lo puedes hacer conectado con el usuario 'creador' ?
No se puede.
¿Por qué ?
El usuario 'creador' sólo tiene el privilegio 'CREATE USER' con el que puede quitar permisos a cualquiera, pero no puede concederlos.

Quita todos los permisos al usuario 'prueba3'.
REVOKE ALL ON zoo.* FROM 'prueba3'@'localhost';
REVOKE ALL ON zoo.animal FROM 'prueba3'@'localhost';
¿ Puedes hacerlo conectado como 'creador' ?
Sí, con la orden: REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'prueba3'@'localhost';
¿ Por qué ?
Porque un usuario con privilegio 'CREATE USER' siempre puede ejecutar esta orden: REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'usuario'@'host';

Quita los permisos 'específicos' otorgados a cada uno de los usuarios anteriores, comprobando con la orden SQL SHOW GRANTS que realmente fueron eliminados:
Como 'root' hacemos:
REVOKE CREATE USER ON *.* FROM 'creador'@'localhost';
REVOKE SELECT, DELETE ON *.* FROM 'prueba1'@'localhost';
REVOKE ALL PRIVILEGES ON zoo.* FROM 'prueba1'@'localhost';
REVOKE UPDATE,GRANT OPTION ON zoo.animal FROM 'prueba2'@'localhost';
REVOKE SHUTDOWN ON *.* FROM 'prueba4'@'localhost';
