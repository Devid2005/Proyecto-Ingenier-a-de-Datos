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

create trigger validar_precio
after insert on producto
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
update inventario
set cantidad = cantidad - new.cantidad_vendida
where idProducto = new.idProducto;
end;