-- 1. Crear la base de datos y seleccionarla para su uso
CREATE DATABASE Mascotas;
USE Mascotas;

-- 2. Crear tablas para almacenar información sobre clientes, productos, mascotas y vacunas

-- Tabla para almacenar la información de los clientes
CREATE TABLE Cliente (
    cedulaCliente INT(11) AUTO_INCREMENT PRIMARY KEY,  -- Identificador único del cliente
    nombreCliente VARCHAR(15),  -- Nombre del cliente
    apellidoCliente VARCHAR(15),  -- Apellido del cliente
    direccionCliente VARCHAR(15),  -- Dirección del cliente
    telefono INT(10),  -- Número de teléfono del cliente
    idMascotaFK INT(11)  -- Referencia a la mascota del cliente (si aplica)
);

-- Tabla para almacenar la información de los productos
CREATE TABLE Producto (
    codigoProducto INT(11) AUTO_INCREMENT PRIMARY KEY,  -- Identificador único del producto
    nombreProducto VARCHAR(15),  -- Nombre del producto
    marca VARCHAR(15),  -- Marca del producto
    precio FLOAT,  -- Precio del producto
    cedulaClienteFK INT(11)  -- Referencia al cliente que compró el producto
);

-- Tabla para almacenar la información de las mascotas
CREATE TABLE Mascota (
    idMascota INT(11) AUTO_INCREMENT PRIMARY KEY,  -- Identificador único de la mascota
    nombreMascota VARCHAR(15),  -- Nombre de la mascota
    generoMascota VARCHAR(15),  -- Género de la mascota
    razaMascota VARCHAR(15),  -- Raza de la mascota
    cantidad INT(10)  -- Cantidad de mascotas (en caso de múltiples animales del mismo tipo)
);

-- Tabla para almacenar la información sobre las vacunas
CREATE TABLE Vacuna (
    CodigoVacuna INT(11) AUTO_INCREMENT PRIMARY KEY,  -- Identificador único de la vacuna
    nombreVacuna VARCHAR(15),  -- Nombre de la vacuna
    dosisVacuna INT(15),  -- Dosis de la vacuna
    enfermedad VARCHAR(15)  -- Enfermedad que previene la vacuna
);

-- Tabla para registrar qué vacunas ha recibido cada mascota
CREATE TABLE mascota_vacuna (
    CodigoVacunaFK INT(11),  -- Referencia a la vacuna recibida
    idMascotaFK INT(11),  -- Referencia a la mascota que recibió la vacuna
    enfermedad VARCHAR(15)  -- Enfermedad para la cual se administró la vacuna
);

-- 3. Crear relaciones entre las tablas utilizando claves foráneas

ALTER TABLE Cliente
ADD CONSTRAINT FKClienteMascota
FOREIGN KEY (idMascotaFK)
REFERENCES Mascota(idMascota);

ALTER TABLE Producto
ADD CONSTRAINT FKProductoCliente
FOREIGN KEY (cedulaClienteFK)
REFERENCES Cliente(cedulaCliente);

ALTER TABLE mascota_vacuna
ADD CONSTRAINT FKmascota_vacunaMascota
FOREIGN KEY (idMascotaFK)
REFERENCES Mascota(idMascota);

ALTER TABLE mascota_vacuna
ADD CONSTRAINT FKmascota_vacunaVacuna
FOREIGN KEY (CodigoVacunaFK)
REFERENCES Vacuna(CodigoVacuna);

-- 4. Agregar una nueva columna para la cantidad en la tabla Producto
ALTER TABLE Producto
ADD COLUMN cantidad INT(15) NOT NULL;

-- 5. Renombrar la columna 'cantidad' a 'cantidadMascota' en la tabla Mascota
ALTER TABLE Mascota
CHANGE COLUMN cantidad cantidadMascota INT(10);

-- 6. Renombrar la tabla 'mascota_vacuna' a 'detalleVacuna'
ALTER TABLE mascota_vacuna
RENAME TO detalleVacuna;
