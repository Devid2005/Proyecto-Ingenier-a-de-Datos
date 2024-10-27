create database Solacom;
use solacom;

create table Usuario(
IdUsuario int auto_increment primary key not null,
NombreUsuario varchar(30) not null,
ApellidoUsuario varchar(30) not null,
EmailUsuario varchar(100) not null,
rolUsuario varchar(30) not null
);

create table Pedido_Cliente(
IdPedidoC int auto_increment primary key not null,
FechaPedido date not null,
IdClienteFK int not null,
IdUsuarioFK int not null
);

create table Cliente(
IdCliente varchar(30) primary key not null,
NombreCliente varchar(30) not null,
ApellidoCliente varchar(30) not null,
FechaNacimiento date not null,
estadoCliente bool
);

create table Producto(
HarmonizedCode varchar(25) primary key not null,
NombreProducto varchar(50) not null,
PrecioProducto float
);

create table Pedido_Producto_Cliente(
HarmonizedCodeFK varchar(25) not null,
IdPedidoCFK int not null,
PrecioProductoFK float,
Cantidad int
);

create table Servicio(
IdServicio varchar(25) primary key not null,
IdPedidoCFK int not null,
NombreServicio varchar(50) not null,
DescripcionServicio varchar(20) not null
);

create table Pedido_Provedor(
IdPedidoP int auto_increment primary key not null,
FechaPedido date not null,
IdProvedorFK int not null
);

create table Provedor(
IdProvedor varchar(25) primary key not null,
NombreProvedor varchar(50) not null
);

create table Stock(
HarmonizedCode varchar(25) primary key not null,
NombreProducto varchar(50) not null,
PrecioProducto float
);

create table compra_a_Provedor(
HarmonizedCodeFK varchar(25) not null,
IdPedidoPFK int not null,
PrecioProductoFK float not null,
Cantidad int not null
);

alter table Pedido_Cliente
add constraint FKIdUsuario
foreign key(IdUsuarioFK)
references Usuario(IdUsuario);

alter table Pedido_Cliente
modify IdClienteFK varchar(25) not null;

alter table Pedido_Cliente
add constraint FKIdCliente
foreign key(IdClienteFK)
references Cliente(IdCliente);

alter table Servicio
add constraint FKIdPedidoCl
foreign key(IdPedidoCFK)
references Pedido_Cliente(IdPedidoC);

alter table Pedido_Producto_Cliente
add constraint FKHarmonizedCode
foreign key(HarmonizedCodeFK)
references Producto(HarmonizedCode);

alter table Pedido_Producto_Cliente
add constraint FKIdPedidoC
foreign key(IdPedidoCFK)
references Pedido_Cliente(IdPedidoC);

alter table Pedido_Provedor
add column IdUsuarioFK int not null;

alter table Pedido_Provedor
add constraint FKIdUsuario_p
foreign key(IdUsuarioFK)
references Usuario(IdUsuario);

alter table Pedido_Provedor
modify IdProvedorFK varchar(25) not null;

alter table Pedido_Provedor
add constraint FKIdProvedor
foreign key(IdProvedorFK)
references Provedor(IdProvedor);

alter table Compra_a_Provedor
add constraint FKHarmonizedCode_P
foreign key(HarmonizedCodeFK)
references Stock(HarmonizedCode);

alter table Compra_a_Provedor
add constraint FKIdPedido_P
foreign key(IdPedidoPFK)
references Pedido_Provedor(IdPedidoP);

ALTER TABLE cliente
CHANGE COLUMN ApellidoCliente Dirección VARCHAR(100);

ALTER TABLE cliente
CHANGE COLUMN FechaNacimiento Correo VARCHAR(100);

ALTER TABLE Usuario
drop column ApellidoUsuario;

insert into Provedor values('1','Pallets'),('2','Dell position boxes'),('3','Dell Mobile position'),('4','Cisco Box Labeled'),('5','Solacom Box Labeled');
use solacom;
select * from Usuario;
select * from Cliente;
select * from Producto;
select * from Pedido_Cliente;
select * from Servicio;
select * from Provedor;
select * from Stock;
select * from Pedido_Provedor;
select * from Pedido_Producto_Cliente;
select * from Compra_a_Provedor;

delete from usuario where IdUsuario > 107;

DELIMITER //
create procedure RegistrarCliente(IdCliente varchar(30),Nombre varchar(30),DireccionCliente varchar(100),correo varchar(100),estadoCliente bool)
begin 
insert into Cliente values(IdCliente,Nombre,DireccionCliente,correo,estadoCliente);
end//
DELIMITER ;

DELIMITER //
create procedure RegistarProvedor(IdProvedor varchar(25),NombreProvedor varchar(50))
begin
insert into Provedor values(IdProvedor,NombreProvedor);
end//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE DetalleCompraCliente(IdClienteParam VARCHAR(30))
BEGIN
    SELECT 
        pc.IdPedidoC AS PedidoID,
        pc.FechaPedido AS Fecha,
        c.Dirección AS Direccion,
        ppc.HarmonizedCodeFK AS CodigoProducto,
        pr.NombreProducto AS Producto,
        ppc.Cantidad AS Cantidad,ppc.PrecioProductoFK AS Precio
    FROM 
        Pedido_Cliente pc
    INNER JOIN 
        Cliente c ON pc.IdClienteFK = c.IdCliente
    INNER JOIN 
        Pedido_Producto_Cliente ppc ON pc.IdPedidoC = ppc.IdPedidoCFK
    INNER JOIN 
        Producto pr ON ppc.HarmonizedCodeFK = pr.HarmonizedCode
    WHERE 
        c.IdCliente = IdClienteParam;
END //
DELIMITER ;

drop procedure DetalleCompraCliente;
call DetalleCompraCliente('DSE103');

DELIMITER //
CREATE PROCEDURE GenerarPedido_Cliente(IdPedidoC int,fecha date,IdClienteFK varchar(25),IdUsuarioFK int)
BEGIN
insert into Pedido_Cliente values (IdPedidoC,fecha,IdClienteFK,IdUsuarioFK);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Generar_Pedido_Producto_Cliente(HarmonizedCodeFK varchar(25),IdPedidoCFK int,PrecioProductoFK float,Cantidad int)
BEGIN
insert into Pedido_Producto_Cliente values (HarmonizedCodeFK,IdPedidoCFK,PrecioProductoFK,Cantidad);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GenerarPedido_Provedor(IdPedidoP int,fecha date,IdProvedorFK varchar(25),IdUsuarioFK int)
BEGIN
insert into Pedido_Provedor values (IdPedidoP,fecha,IdProvedorFK,IdUsuarioFK);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Generar_Compra_a_Provedor(HarmonizedCodeFK varchar(25),IdPedidoPFK int,PrecioProductoFK float,Cantidad int)
BEGIN
insert into Compra_a_Provedor values (HarmonizedCodeFK,IdPedidoPFK,PrecioProductoFK,Cantidad);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Precio_Producto(Nombre_Producto varchar(25))
BEGIN
select NombreProducto,PrecioProducto From Producto where NombreProducto = Nombre_Producto;
END//
DELIMITER ;

select * from Producto;
call Precio_Producto('CREATIVE Speackers-A50');

DELIMITER //
CREATE PROCEDURE ObtenerFacturaCliente(IN IdClienteParam VARCHAR(30))
BEGIN
    SELECT 
        c.IdCliente AS ClienteID,
        c.NombreCliente AS Nombre,
        c.Dirección AS Direccion,
        c.Correo AS Correo,
        pc.IdPedidoC AS PedidoID,
        pc.FechaPedido AS FechaPedido,
        pr.NombreProducto AS Producto,
        ppc.Cantidad AS Cantidad,
        ppc.PrecioProductoFK AS PrecioUnitario,
        (ppc.Cantidad * ppc.PrecioProductoFK) AS TotalProducto
    FROM Cliente c
    INNER JOIN Pedido_Cliente pc ON c.IdCliente = pc.IdClienteFK
    INNER JOIN Pedido_Producto_Cliente ppc ON pc.IdPedidoC = ppc.IdPedidoCFK
    INNER JOIN Producto pr ON ppc.HarmonizedCodeFK = pr.HarmonizedCode
    WHERE c.IdCliente = IdClienteParam;
END //
DELIMITER ;

call ObtenerFacturaCliente('DSE104');

DELIMITER //
CREATE PROCEDURE ObtenerFacturaProvedor(IN IdUsuarioParam VARCHAR(30))
BEGIN
    SELECT 
        U.IdUsuario AS UsuarioID,
        U.NombreUsuario AS Nombre,
        U.EmailUsuario AS Correo,
        pp.IdPedidoP AS PedidoID,
        pp.FechaPedido AS FechaPedido,
        pr.NombreProducto AS Producto,
        ccp.Cantidad AS Cantidad,
        ccp.PrecioProductoFK AS PrecioUnitario,
        (ccp.Cantidad * ccp.PrecioProductoFK) AS TotalProducto
    FROM Usuario U
    INNER JOIN Pedido_Provedor pp ON U.IdUsuario = pp.IdUsuarioFK
    INNER JOIN Compra_a_Provedor ccp ON pp.IdPedidoP = ccp.IdPedidoPFK
    INNER JOIN Producto pr ON ccp.HarmonizedCodeFK = pr.HarmonizedCode
    WHERE U.IdUsuario = IdUsuarioParam;
END //
DELIMITER ;

select * from Usuario;
call ObtenerFacturaProvedor('106');

CREATE VIEW ClienteMasCompras AS
SELECT 
    c.IdCliente AS ClienteID,
    c.NombreCliente AS Nombre,
    c.Dirección AS Direccion,
    c.Correo AS Correo,
    COUNT(pc.IdPedidoC) AS NumeroDePedidos
FROM Cliente c
INNER JOIN Pedido_Cliente pc ON c.IdCliente = pc.IdClienteFK
GROUP BY c.IdCliente, c.NombreCliente, c.Dirección, c.Correo
ORDER BY NumeroDePedidos DESC;

SELECT * FROM ClienteMasCompras;

CREATE VIEW ClientesActivos AS
SELECT IdCliente,NombreCliente,Dirección,Correo
FROM Cliente
WHERE estadoCliente = TRUE;

SELECT * FROM ClientesActivos;

SELECT pc.IdPedidoC AS PedidoID,pc.FechaPedido AS FechaPedido,c.IdCliente AS ClienteID,c.NombreCliente AS NombreCliente,
	c.Dirección AS Direccion,c.Correo AS Correo,SUM(ppc.Cantidad) AS TotalProductos
FROM Pedido_Cliente pc
INNER JOIN Cliente c ON pc.IdClienteFK = c.IdCliente
INNER JOIN Pedido_Producto_Cliente ppc ON pc.IdPedidoC = ppc.IdPedidoCFK
WHERE c.IdCliente = (SELECT IdCliente FROM Pedido_Cliente GROUP BY IdCliente ORDER BY COUNT(IdPedidoC) DESC)
GROUP BY pc.IdPedidoC, c.IdCliente, c.NombreCliente, c.Dirección, c.Correo;

/*
create trigger validar_precio
after insert onStored Procedures producto
for each row
begin
	if new.precioProducto <= 0 then
		set message_text = 'El precio es incorrecto'
	end if;
end ;

create trigger actualizar_stock
after insert on Pedido_Producto_Cliente
for each row
begin
update Compra_a_Cliente
set cantidad = cantidad - new.cantidad_vendida
where HarmonizedCode = new.HarmonizedCode;
end;
*/