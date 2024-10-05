-- 1 Crear base de datos

-- CREATE DATABASE Mascotas;
USE Mascotas;
/*
-- 2 Crear tablas
-- Tabla Cliente
CREATE TABLE Cliente (
    cedulaCliente INT(11) auto_increment PRIMARY KEY,
    nombreCliente VARCHAR(15),
    apellidoCliente VARCHAR(15),
    direccionCliente VARCHAR(15),
    telefono INT(10),
    idMascotaFK INT(11)
);

-- Tabla Producto
CREATE TABLE Producto (
    codigoProducto INT(11) auto_increment PRIMARY KEY,
    nombreProducto VARCHAR(15), 
    marca VARCHAR(15),
    precio FLOAT,
    cedulaClienteFK INT(11)
);

-- Tabla Mascota
CREATE TABLE Mascota (
    idMascota INT(11) auto_increment PRIMARY KEY,
    nombreMascota VARCHAR(15),
    generoMascota VARCHAR(15),
    razaMascota VARCHAR(15),
    cantidad INT(10)
);

-- Tabla Vacuna
CREATE TABLE Vacuna (
    CodigoVacuna INT(11) auto_increment PRIMARY KEY,
    nombreVacuna VARCHAR(15),
    dosisVacuna INT(15),
    enfermedad VARCHAR(15)
);

 
-- Tabla mascota_vacuna
CREATE TABLE mascota_vacuna (
    CodigoVacunaFK INT(11),
    idMascotaFK INT(11),
    enfermedad VARCHAR(15)
);

-- 3 Crear relaciones

alter table Cliente
add constraint FKClienteMascota
foreign key (idMascotaFK)
references Mascota(idMascota);


alter table Producto
add constraint FKProductoCliente
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);


alter table mascota_vacuna
add constraint FKmascota_vacunaMascota
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table mascota_vacuna
add constraint FKmascota_vacunaVacuna
foreign key (CodigoVacunaFK)
references Vacuna(CodigoVacuna);

-- 4 Agregar cantidad en producto
alter table Producto
ADD COLUMN cantidad Int(15) NOT NULL;

-- 5 Cambiar nombre cantidad por cantidadmascota en mascota
ALTER TABLE Mascota
CHANGE COLUMN cantidad cantidadMascota INT(10);

-- 6 cambiar de mascota_vacuna a DETALLE VACUNA
ALTER TABLE mascota_vacuna
RENAME detalleVacuna;
*/

-- 
select * from Mascota;

insert into Mascota (idMascota,nombreMascota,generoMascota,razaMascota,cantidad) values(1,'Rusth', 'M','Criollo',1),(2,'Macarena', 'F','Criollo',1), (3,'Fridom', 'M','Criollo',1);
insert into Mascota values(4,'Mascota 4', 'M','Raza 4',1), (5,'', '','Raza 4',1);

describe Vacuna;
insert into Vacuna values(1,'Vacuna 1',3,'Enfermedad 1'),(2,'Vacuna 2', 5,'Enfermedad 2');
select * from Vacuna;

describe Cliente;
insert into Cliente values(12345, 'Nombre 1', 'Apellido 1','Direccion 1',78945, 3);
insert into Cliente values(1522, 'Nombre 2', 'Apellido 2','Direccion 2',5829, 2);
select * from Cliente;

describe Producto;
insert into Producto values(1,'Producto 1','Marca 1',123,12345,13), (2,'Producto 2','Marca 2',190,1522,5);
select * from Producto;

describe detalleVacuna;
insert into detalleVacuna values(1,4,'Enfermedad 1'), (2,1,'Enfermedad 2');
select * from detalleVacuna;

-- Clase de sentencias 
select NombreMascota,razaMascota from Mascota;
select cedulaCliente AS 'Documento',direccionCliente  AS 'direccion cliente' from Cliente;
-- Mascota producto y Vacunas (Alias)
select nombreProducto AS 'producto',precio AS 'costo' from Producto;
select nombreVacuna AS 'Vacuna', enfermedad AS 'tipo de Vacuna' from Vacuna;
select generoMascota AS 'sexo mascota' from Mascota;
-- select campo 1 from nombre_TABLA ORDER BY Campo 2 asc, desc
select cedulaCliente as 'documento', idMascotaFK as 'Codigo mascota' from Cliente order by nombreCliente asc;
select * from Producto  order by precio desc;
-- where permite hacer condiciones en basesd de datos 
select nombreProducto from Producto where precio >160;
select enfermedad from detalleVacuna where idMascotaFK >1;


-- el and si una de las dos es verdadera sale f f y y = f 
-- dos consultas con opreadores logicos sobre vacunas cliente mascota
select nombreCliente from Cliente where telefono >=10;
select  dosisVacuna from Vacuna where CodigoVacuna <=1;
select  nombreMascota from Mascota where idMascota !=9;
select  direccionCliente from Cliente where cedulaCliente >=15;
select  enfermedad  from Vacuna where nombreVacuna = 'Vacuna';
select  *  from Vacuna;
-- clausula where between (poner los rangos) 


-- busqeuda de patrones like select nombreProducto from Porducto where marca Like 'M%'
select nombreProducto from Producto where marca Like '%C';

-- Tarea hacer dos busquedad de tipo like y Not like  en cada una de las tablas que tenemos , quiero consultar (campos Not Like ) 
-- el lunes de ve update y quiz , funciones agregadas 
SELECT nombreProducto FROM Producto WHERE marca LIKE 'M%';
SELECT nombreProducto FROM Producto WHERE marca NOT LIKE '%C%';
SELECT nombreCliente, apellidoCliente FROM Cliente WHERE apellidoCliente LIKE 'A%';
SELECT nombreCliente FROM Cliente WHERE nombreCliente NOT LIKE '%e';
SELECT nombreMascota FROM Mascota WHERE nombreMascota LIKE 'M%';
SELECT nombreMascota, razaMascota FROM Mascota WHERE razaMascota NOT LIKE '%Criollo%';
