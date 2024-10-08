-- 1. Crear base de datos
CREATE DATABASE TIENDAONLINE;
USE TIENDAONLINE;

-- 2. Crear tablas

-- Tabla Cliente
CREATE TABLE Cliente (
    cedulaCliente INT(11) AUTO_INCREMENT PRIMARY KEY,
    nombreCliente VARCHAR(50),
    apellidoCliente VARCHAR(50),
    mes_nacimiento VARCHAR(15)
);

-- Tabla Producto
CREATE TABLE Producto (
    codigoProducto INT(11) AUTO_INCREMENT PRIMARY KEY,
    codigo_barras VARCHAR(30),
    precio FLOAT
);

-- Tabla Usuarios
CREATE TABLE Usuarios (
    idUsuario INT(11) AUTO_INCREMENT PRIMARY KEY,
    nombreUsuario VARCHAR(50),
    rol VARCHAR(15)
);

-- Tabla Ventas (Órdenes)
CREATE TABLE Ventas (
    numero_orden INT(11) AUTO_INCREMENT PRIMARY KEY,
    cantidad_productos INT(10),
    total FLOAT,
    idCliente INT(11),
    idUsuario INT(11),
    FOREIGN KEY (idCliente) REFERENCES Cliente(cedulaCliente),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

-- Tabla Detalle_Venta (Relación muchos a muchos entre Ventas y Productos)
CREATE TABLE Detalle_Venta (
    idVenta INT(11),
    idProducto INT(11),
    cantidad INT(11),
    total FLOAT,
    PRIMARY KEY (idVenta, idProducto),
    FOREIGN KEY (idVenta) REFERENCES Ventas(numero_orden),
    FOREIGN KEY (idProducto) REFERENCES Producto(codigoProducto)
);

-- 4. Inserciones de ejemplo

-- Insertar productos
INSERT INTO Producto (codigo_barras, precio) 
VALUES ('1236547', 50000),('1236587', 25000),('7654569', 19000),('8765432', 15000);

-- Insertar usuarios
INSERT INTO Usuarios (nombreUsuario, rol) 
VALUES ('Ana Cardona', 'empleado'),('María Gómez', 'administrador'),('Andres Castano', 'empleado'),('Andrea Torres', 'cliente');

-- Insertar clientes
INSERT INTO Cliente (nombreCliente, apellidoCliente, mes_nacimiento) 
VALUES ('Mariana', 'Acosta', 'junio'), ('Daniel', 'Maecha', 'marzo'),('Sara', 'Diaz', 'abril'),('Juan Daniel', 'Moreno', 'enero');

-- Insertar ventas
INSERT INTO Ventas (cantidad_productos, total, idCliente, idUsuario) 
VALUES (3, 165000, 1, 1), (1, 19000, 2, 2), (2, 75000, 3, 3), (4, 184000, 4, 4);

-- Insertar detalles de ventas (relacionando productos y ventas)
INSERT INTO Detalle_Venta (idVenta, idProducto, cantidad, total) 
VALUES (1, 1, 2, 100000), (1, 2, 1, 25000), (2, 3, 1, 19000), (3, 2, 2, 50000);

-- 5. Consultas

-- a. Consulta general de todos los productos
SELECT * FROM Producto;

-- b. Ordenar productos por precio (menor a mayor)
SELECT * FROM Producto ORDER BY precio ASC;

-- c. Consultar los clientes que nacen en enero
SELECT * FROM Cliente WHERE mes_nacimiento = 'enero';

-- d. Consultar usuarios con el rol de empleado
SELECT * FROM Usuarios WHERE rol = 'empleado';

-- e. Consultar las órdenes generadas entre marzo y junio
SELECT * FROM Ventas WHERE idCliente IN (
    SELECT cedulaCliente FROM Cliente WHERE mes_nacimiento IN ('marzo', 'abril', 'mayo', 'junio')
);

-- f. Consultar productos que contengan la letra 'r'
SELECT * FROM Producto WHERE codigo_barras LIKE '%r%';

-- g. Consultar las ventas que tengan productos con precios entre 15,000 y 30,000
SELECT v.* 
FROM Ventas v
JOIN Detalle_Venta dv ON v.numero_orden = dv.idVenta
JOIN Producto p ON dv.idProducto = p.codigoProducto
WHERE p.precio BETWEEN 15000 AND 30000;

-- 6. Funciones agregadas

-- a. Promedio de ventas
SELECT AVG(total) AS promedio_venta FROM Ventas;

-- b. Total de ventas, cantidad de productos vendidos, y venta más económica
SELECT 
    COUNT(*) AS total_ventas,
    SUM(cantidad_productos) AS total_elementos_vendidos,
    MIN(total) AS venta_mas_economica 
FROM Ventas;

-- 7. INNER JOIN entre Ventas y Cliente
SELECT * 
FROM Ventas v
INNER JOIN Cliente c ON v.idCliente = c.cedulaCliente;

-- 8. Consultas adicionales

-- a. Consultar el cliente con la mayor venta
SELECT c.nombreCliente, c.apellidoCliente, MAX(v.total) AS mayor_venta
FROM Cliente c
JOIN Ventas v ON c.cedulaCliente = v.idCliente
GROUP BY c.cedulaCliente
ORDER BY mayor_venta DESC;

-- b. Consultar el usuario y la venta de una venta específica
SELECT u.nombreUsuario, v.numero_orden, v.total
FROM Usuarios u
JOIN Ventas v ON u.idUsuario = v.idUsuario
WHERE v.numero_orden = 1; -- Reemplazar '1' por el número de orden específico

-- c. Consultar los productos que compró un cliente específico
SELECT p.codigo_barras, p.precio, dv.cantidad
FROM Producto p
JOIN Detalle_Venta dv ON p.codigoProducto = dv.idProducto
JOIN Ventas v ON dv.idVenta = v.numero_orden
WHERE v.idCliente = 1; -- Reemplazar '1' por el ID del cliente específico

-- d. Consultar todos los clientes que han hecho compras (ventas u órdenes)
SELECT DISTINCT c.nombreCliente, c.apellidoCliente
FROM Cliente c
JOIN Ventas v ON c.cedulaCliente = v.idCliente;

UPDATE Producto set precio = 35000 where codigoProducto = 1;

Describe Cliente;
insert into Cliente values (123456, 'Tatiana', 'ING', 'junio');

insert into Usuarios values (2607, 'David Hernandez', 'Gerente');

insert into Producto values(5, 989666, 600000);

insert into Ventas values(5, 3, 1800000, 123456, 2607);

SELECT * FROM Ventas;


insert into Cliente values (55163118, 'Tatiana', 'ING', 'junio');

UPDATE Ventas set idCliente = 55163118 where numero_orden = 5;

delete from Cliente where cedulaCliente = 123456;

SELECT * FROM Cliente;


-- Procedimientos almacenados -> subrutinas almacenar la informacion en la bd 

-- delimiter empieza y terminar en un punto 
/*
DELIMITER //

CREATE PROCEDURE nombre_procedimiento(parametros)
BEGIN
-- LOGICA SENTENCIA QUE SE QUIERA UTILIZAR 
END // 

CREATE VIEW


DELIMITER;
*/

Describe Producto;


delimiter //
CREATE PROCEDURE registrar_producto(codigoProducto int(11), codigoBarras varchar(30), precio float)
BEGIN
INSERT INTO Producto values(codigoProducto, codigoBarras, precio);
END//
delimiter ;


call registrar_producto('','545656','156.3');

select * from Producto;

-- describe Producto;
 -- Delimiter //
-- create procedure updateMascota(codigoProducto int(11), codigoBarras varchar(30), precio float)

create view consultarCliente as 
select * from Cliente;

select * from consultarCliente;



-- de tienda online crear tres procedimientos para inactivar cliente un procedimiento para consultar los productos que han comprado un cliente, procedimiento para modificar la fecha de nacimiento del cliente, 
-- dos vistas, una que me consulte que cliente compro un producto y cual fue su numero de orden, una vista que me muestre el cliente que mas compras haya hecho 


