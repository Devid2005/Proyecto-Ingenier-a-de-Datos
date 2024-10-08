create database Solacom;
use Solacom;

create table Cliente(
Nombre varchar(100),
IdCliente varchar(50) primary key not null,
DireccionCliente varchar(100) not null,
correo varchar(100) not null
);

create table GenerarVenta(
IdCompra varchar(50) primary key not null,
RegistroVenta varchar(50) not null,
FechaVenta date not null,
NombreProductoFK varchar(50) not null,
IdClienteFK varchar(50) not null,
TaxVenta double not null,
TotalVenta double not null,
direccionEnvio varchar(100) not null
);

create table Detalle_compra(
IdCompraFK varchar(50) not null,
RegistroVentaFK varchar(50) not null,
FechaVentaFK date not null,
FechaDespacho date not null,
IdClienteFK varchar(50) not null,
TaxVentaFK double not null,
TotalVentaFK double not null,
direccionEnvioFK varchar(100) not null,
EstadoEntrega bool
);

create table Provedor(
IdProvedor varchar(50) primary key not null,
NombreProvedor varchar(50) not null,
IdCompraP varchar(50) not null,
NombreProducto varchar(50) not null,
HarmonizedCode varchar(50) not null,
CantidadProductos varchar(25) not null,
precioProductos int not null
);

create table Servicio(
IdServicio varchar(25) primary key not null,
NombreServicio varchar(50) not null,
IdClienteFK varchar(50) not null,
DescripcionServicio varchar(50) not null
);

create table Registro_Solacom(
IdProvedorFK varchar(25) not null,
IdClienteFK varchar(25)not null,
IdServicioFK varchar(25) not null
);

create table CompraProvedor(
idCompraP varchar(25) primary key not null,
Nombreproducto varchar(50) not null,
HarmonizedCode int not null,
PrecioProductos float not null,
CantidadProductos int
);
alter table CompraProvedor
add column IdProvedorFK varchar(50);

alter table CompraProvedor
add constraint FKProvedorProducto
foreign key (IdProvedorFK)
references Provedor(IdProvedor);

alter table GenerarVenta
drop column TotalVenta;

describe GenerarVenta;
describe Provedor;
describe Detalle_compra;

alter table GenerarVenta
add constraint FKClienteCompraProducto
foreign key (NombreProductoFK)
references Provedor(IdProvedor);

alter table GenerarVenta
add constraint FKClienteCompras
foreign key (IdClienteFK)
references Cliente(IdCliente);

alter table Detalle_Compra
add constraint FKIdcompra
foreign key (IdCompraFK)
references GenerarVenta(IdCompra);

alter table Detalle_Compra
add constraint FKRegistroCompra
foreign key (RegistroVentaFK)
references GenerarVenta(IdCompra);

alter table Detalle_Compra
add constraint FKClienteCompra
foreign key (IdClienteFK)
references Cliente(IdCliente);

alter table Detalle_Compra
add constraint FKDireccionCompra
foreign key (direccionEnvioFK)
references GenerarVenta(IdCompra);

alter table Servicio
add constraint FKClienteServicio
foreign key (IdClienteFK)
references Cliente(IdCliente);

alter table Registro_Solacom
add constraint FKProveedorSolacom
foreign key (IdProvedorFK)
references Provedor(idProvedor);

alter table Registro_Solacom
add constraint FKCliente_Solacom
foreign key (IdClienteFK)
references Cliente(IdCliente);

alter table Registro_Solacom
add constraint FKServicioSolacom
foreign key (IdServicioFK)
references Servicio(IdServicio);

alter table GenerarVenta
add constraint FKCompraProvedor
foreign key (NombreProductoFK)
references CompraProvedor(IdCompraP);

describe GenerarVenta;

DELIMITER //
create procedure RegistrarCliente(Nombre varchar(50),IdCliente varchar(50),DireccionCliente varchar(100),correo varchar(100))
begin 
insert into Cliente values(Nombre,IdCliente,DireccionCliente,correo);
end//
DELIMITER ;

DELIMITER //
create procedure RegistarProvedor(IdProvedor varchar(50),NombreProvedor varchar(50),IdCompraP varchar(50),NombreProducto varchar(50),HarmonizedCode varchar(50),CantidadProductos varchar(25),precioProductos int)
begin
insert into Provedor values(IdProvedor,NombreProvedor,IdCompraP,NombreProducto,HarmonizedCode,CantidadProductos,precioProductos);
end//
DELIMITER ; 

DELIMITER // 
create procedure DetallesProducto(id_compra varchar(50))
begin
select NombreProductoFK from GenerarVenta where IdCompra = id_compra;
end//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GenerarPedido(IdCompra varchar(50),RegistroVenta varchar(50),FechaVenta date,FechaDespacho date,IdClienteFK varchar(50),TaxVenta double(50,15),TotalVenta double(50,15),direccionEnvio varchar(100),EstadoEntrega bool)
BEGIN
insert into Detalle_Compra values (IdCompra, RegistroVenta,FechaVenta,FechaDespacho,IdclienteFK,Taxventa,TotalVenta,DireccionEnvio,EstadoEntrega);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MostrarFactura(Id_Compra varchar(50))
BEGIN
SELECT C.NombreCliente AS NombreCliente,P.NombreProducto AS NombreProducto,P.PrecioProducto AS PrecioProducto,P.cantidadProductos AS CantidadProducto,D.direccionEnvio AS DireccionEnvio,D.FechadeVenta AS FechaCompra,D.TotalVenta AS TotalCompra,sum(TotalVenta)FROM 
        DETALLE_COMPRA D
JOIN Cliente C ON D.IdClienteFK = C.IdCliente
JOIN Provedor P ON P.IdProvedor = D.IdCompra  
WHERE D.IdCompra = Id_Compra
GROUP BY C.direccionCliente, P.CantidadDeProductos, P.PrecioProducto, D.direccionEnvio, D.FechadeVenta, D.TotalVenta;
END//
DELIMITER ;

DELIMITER // 
create procedure MostrarFactura_Provedor(Id_Provedor varchar(50))
begin
select CP.nombreProducto, CP.cantidadProductos, CP.precioProductos, (precioProductos*cantidadProductos) as total, sum(precioProductos*cantidadProductos) from CompraProvedor CP
where Id_Provedor = IdProvedorFK;
end//
DELIMITER ;

DELIMITER // 
create procedure Estado_de_compra(id_compra varchar(50))
begin
select EstadoCompra from Detalle_Compra where IdCompraP = id_compra;
end//
DELIMITER ;

call RegistrarCliente('NovaTech Solutions','NT001','123 Silicon Valley Blvd, San Francisco, CA','nova.tech@gmail.com');

insert into Cliente values('QuantumLeap Inc.','QL002','456 Innovation Drive, Toronto, ON','quantum@hotmail.com'),('NorthStar Enterprises','NSE003','789 Main Street, Seattle, WA','northS@gmail.com'),
('CyberShield Corp.','CSC004','110 Cyber Avenue, Ottawa, ON','cyberShield@gmail.com'),('DataStream Inc.','DS005','220 Data Drive, Vancouver, BC','datas@gmail.com'),('Biotech Toronto','NSE009','150 Elgin Street, Suite 800, Ottawa, ON K2P 1L4, Canada','biotech@gmail.com'),
('GreenTech Seattle','DSE98','5th Floor, 111 East 5th Avenue, Vancouver, BC V5T 1G4, Canada','greentech@gmail.com'),('Ryerson AI','DSE99','1910 Avenue 1, Suite 200, Montreal, QC H3A 2R6, Canada','reyersonAI@gmail.com'),
('WinterLight Labs','DSE100','275 Frank Tompa Drive, Waterloo, ON N2L 0A1, Canada','winterl@gmail.com'),('Kindred Systems','DSE101','3500 Carling Avenue, Suite 100, Ottawa, ON K2H 8T5, Canada','Kindred@gmail.com'),
('ZoomInfo','DSE102','1000 - 1005 W 17th Avenue, Vancouver, BC V6H 1A5, Canada','Zoomn@gmail.com'),('Asana','DSE103','2200 University Avenue E, Waterloo, ON N2K 0A7, Canada','Asana@gmail.com'),('PagerDuty','DSE104','1500 Don Mills Road, Suite 400, Ottawa, ON K4A 3Z5, Canada','Pager@gmail.com'),
('Evernote','DSE105','25, 2300 René-Lévesque Blvd W, Montreal, QC H3H 2T8, Canada','Evernote@gmail.com'),('DuckDuckGo','DSE106','2300-100  Toronto, ON M5J 1V6, Canada','contact@duckduckgo.com'),('Mailchimp','DSE107','Av. México 83, Colonia Hipódromo, 06100 Ciudad de México, CDMX, México','support@mailchimp.com'),
('Squarespace','DSE108','Av. José María Pino Suárez 60, Centro Histórico, 06060 Ciudad de México, CDMX, México','support@squarespace.com'),('Box','DSE109','699 8th St, San Francisco, CA 94103, USA','support@box.com'),
('HubSpot','DSE110','401- 119 West Pender Street, Vancouver, BC V6B 1S5, Canada','support@hubspot.com'),('Plaid','DSE111','399 11th St, San Francisco, CA 94103, USA','support@plaid.com');
insert into Cliente values('Robinhood','DSE112','699 8th St, San Francisco, CA 94103, USA','support@robinhood.com'),('GitHub','DSE113','2850 3rd St, San Francisco, CA 94107, USA','support@github.com'),('Coursera','DSE114','197 Spadina Ave, Suite 600, Toronto, ON M5T 2C1, Canada','support@coursera.org'),
('Wix (Israel, pero con operaciones en América del Norte)','DSE115','3300 E 1st Ave, Denver, CO 80205, USA','support@wix.com'),('Trello','DSE116','900 Jefferson Ave, Redwood City, CA 94063, USA','contact@trello.com'),('Kio Networks','DSE117','650 Castro St, Mountain View, CA 94041, USA','info@kionetworks.com'),
('Bitso','DSE118','25 First Street, Cambridge, MA 02141, USA','soporte@bitso.com'),('Clip','DSE119','501 W 15th St, Austin, TX 78701, USA','contacto@clip.mx'),('Konfio','DSE120','600 Harrison St, Suite 200, San Francisco, CA 94107, USA','contacto@konfio.mx'),
('Conekta','DSE121','1100 Marietta St NW, Atlanta, GA 30318, USA','support@conekta.com'),('Rappi','DSE122','85 Willow Road, Menlo Park, CA 94025, USA','soporte@rappi.com'),('OXXO','DSE123','1390 Market St, San Francisco, CA 94102, USA','contacto@oxxo.com'),
('Kavak','DSE124','12655 W 64th Ave, Suite 200, Arvada, CO 80004, USA','contacto@kavak.com'),('B2B Media','DSE125','1750 Zanker Rd #100, San Jose, CA 95112, USA','contacto@b2bmedia.mx'),('Kubo Financiero','DSE126','400 W 15th St, Austin, TX 78701, USA','contacto@kubofinanciero.com'),
('Auronix','DSE127','2300 W 17th St, San Francisco, CA 94107, USA','contacto@auronix.com'),('500 Startups','DSE128','7400, 1er Avenue, Suite 300, Québec, QC G1H 7C1, Canada','info@500.co'),('Ginkgo','DSE129','244 2nd St, San Francisco, CA 94105, USA','contact@ginkgobioworks.com'),
('Payit','DSE130','1215 St-Alexandre St #300, Montreal, QC H3B 3H4, Canada','info@payit.com'),('Dev.F','DSE131','1515 Rue Saint-Antoine O, Suite 400, Montreal, QC H3C 2S2, Canada','info@dev.f');
insert into Cliente values('Shopify','DSE132','460 Speedvale Ave E, Guelph, ON N1E 1P1, Canada','support@shopify.com'),('Hootsuite','DSE133','325 Front St W, Toronto, ON M5V 2Y1, Canada','support@hootsuite.com'),('Slack Technologies','DSE134','1600-1177 11th Ave SW, Calgary, AB T2R 1K3, Canada','feedback@slack.com'),
('OpenText','DSE135','1300-200 Granville St, Vancouver, BC V6C 1S4, Canada','info@opentext.com'),('Ceridian','DSE136','1600-1177 11th Ave SW, Calgary, AB T2R 1K3, Canada','info@ceridian.com'),('Mitel Networks','DSE137','5600-1000 Sherbrooke St W, Montreal, QC H3A 3R2, Canada','contact@mitel.com'),
('Coveo','DSE138','501 W 15th St, Austin, TX 78701, USA','info@coveo.com'),('Absolute Software','DSE139','103 5th Ave, New York, NY 10003, USA','info@absolute.com'),('Blackberry','DSE140','1515 Rue Saint-Antoine O, Suite 400, Montreal, QC H3C 2S2, Canada','info@blackberry.com'),
('Kinaxis','DSE141','1010 Rue Galt E, Sherbrooke, QC J1G 1X5, Canada','info@kinaxis.com'),('Lightspeed Commerce','DSE142','1500 - 1000 St. Laurent Blvd, Montreal, QC H2X 2S9, Canada','contact@lightspeedhq.com'),('Constellation Software','DSE143','2800 3rd St, San Francisco, CA 94107, USA','info@csw.com'),
('FreshBooks','DSE144','150 W 13th St, New York, NY 10011, USA','support@freshbooks.com'),('Bench','DSE145','69. 1500 - 1000 St. Laurent Blvd, Montreal, QC H2X 2S9, Canada','support@bench.co'),('Clio','DSE146','5700 W 11th St, Los Angeles, CA 90011, USA','support@clio.com'),
('Descartes Systems Group','DSE147','1000 E 1st St, Los Angeles, CA 90012,USA','info@descartes.com'),('Nuvei','DSE148','125 E 11th St, New York, NY 10003, USA','contact@nuvei.com'),('Clearco','DSE149','101 N. 5th St, Philadelphia, PA 19106, USA','support@clear.co'),
('Wealthsimple','DSE150','3031 N 14th St, Lincoln, NE 68521, USA','help@wealthsimple.com'),('Thinkific','DSE151','3200 E Camelback Rd #240, Phoenix, AZ 85018, USA','support@thinkific.com');
insert into Cliente values('Vidyard','DSE152','600 S 2nd St, Minneapolis, MN 55401, USA','info@vidyard.com'),('Auvik Networks','DSE153','2001 S. 16th St, San Francisco, CA 94103, USA','support@auvik.com'),('D2L','DSE154','5700 W 11th St, Los Angeles, CA 90011, USA','support@d2l.com'),
('Benevity','DSE155','1200 W 4th St, Austin, TX 78703, USA','info@benevity.com'),('Unbounce','DSE156','3031 N 14th St, Lincoln, NE 68521, USA','support@unbounce.com'),('Element AI	','DSE157','5500 W 2nd St, Santa Ana, CA 92703, USA','info@elementai.com'),
('WealthBar','DSE158','3131 S 10th St, San Jose, CA 95112, USA','support@wealthbar.com'),('Wave Financial','DSE159','1201 S. Orange Ave, Orlando, FL 32806, USA','support@waveapps.com'),('GSoft','DSE160','707 E 15th St, Austin, TX 78701, USA','info@gsoft.com'),
('Plooto','DSE161','150 W 13th St, New York, NY 10011, USA','support@plooto.com'),('Dapper Labs (desarrollo de tecnología blockchain y NFT)','DSE162','1515 Rue Saint-Antoine O, Suite 400, Montreal, QC H3C 2S2, Canada','info@dapperlabs.com'),('Tribe (plataforma de comunidades online)','DSE163','1000 E 1st St, Los Angeles, CA 90012, USA','support@tribe.so'),
('Plooto (software de gestión de pagos)','DSE164','3200 E Camelback Rd #240, Phoenix, AZ 85018, USA','hello@crisp.co'),('Crisp (plataforma de análisis de datos para restaurantes)','DSE165','1201 W 10th St, Los Angeles, CA 90015, USA','info@ada.support'),('Ada (plataforma de automatización de atención al cliente)','DSE166','401- 119 West Pender Street, Vancouver, BC V6B 1S5, Canada','info@loom.ai'),
('Loom.ai (tecnología de creación de avatares en 3D)','DSE167','5000 N Central Ave, Phoenix, AZ 85012, USA','contactus@zynga.com'),('Zynga (juegos sociales)','DSE168','197 Spadina Ave, Suite 600, Toronto, ON M5T 2C1, Canada','hello@foko.com'),('Foko (software de gestión de contenido para empresas)','DSE169','1775 19th St NW, Washington, DC 20009, USA','info@jibestream.com'),
('Unbounce (herramientas para crear landing pages)','DSE170','5775 16th Avenue, Suite 210, Vancouver, BC V5Y 1A5, Canada','support@calendly.com'),('Jibestream (soluciones de mapeo en interiores)','DSE171','2020 S. 7th St, Philadelphia, PA 19148, USA','hello@makenotion.com');
insert into Cliente values('Calendly (herramienta de programación de citas)','DSE172','85 Willow Road, Menlo Park, CA 94025, USA','support@gumroad.com'),('Notion (plataforma de gestión de proyectos y notas)','DSE173','6100 W 104th Ave, Westminster, CO 80020, USA','contact@substack.com'),('Gumroad (plataforma de venta de productos digitales)','DSE174','675 Ponce de Leon Ave NE, Suite 5000, Atlanta, GA 30308, USA','support@sift.com'),
('Substack (plataforma de newsletters)','DSE175','101 N. 5th St, Philadelphia, PA 19106, USA','support@airtable.com'),('Sift (soluciones de gestión de fraude)','DSE176','Av. Revolución 1310, Colonia San Angel, 01000 Ciudad de México, CDMX, México','support@zapier.com'),('Airtable (plataforma de bases de datos flexibles)','DSE177','1700 E 18th St, Austin, TX 78702, USA','help@figma.com'),
('Zapier (automatización de tareas entre aplicaciones)','DSE178','1500 Don Mills Road, Suite 400, Ottawa, ON K4A 3Z5, Canada','hello@buffer.com'),('Figma (herramienta de diseño colaborativo)','DSE179','600 S 2nd St, Minneapolis, MN 55401, USA','support@loom.com'),('Buffer (gestión de redes sociales)','DSE180','275 Frank Tompa Drive, Waterloo, ON N2L 0A1, Canada','hello@yalo.com'),
('Loom (herramienta de grabación de video)','DSE181','2425 W 26th St, Chicago, IL 60623, USA','contacto@kueski.com'),('Yalo (plataforma de automatización de ventas y atención al cliente)','DSE182','150 Elgin Street, Suite 800, Ottawa, ON K2P 1L4, Canada','contacto@jisto.mx'),('Kueski (fintech de préstamos en línea)','DSE183','1000 S 10th St, San Jose, CA 95112, USA','hola@albo.mx'),
('Conekta (soluciones de pago)','DSE184','1000 N. 4th St. Suite 300, Austin, TX 78703, USA','conekta@conecta.com'),('Jüsto (plataforma de comercio electrónico)','DSE185','27 Drydock Ave, Boston, MA 02210, USA','justo@justo.com'),('Albo (banco digital)','DSE186','1201 S. Orange Ave, Orlando, FL 32806, USA','albo@albo.com'),
('Morgan County EMA','DSE187','60S Fourth St McConnelsville OH 43756','911coordinator@morgancounty-oh.gov'),('Lincoln County Sheriffs Office','DSE188','512 California Avenue Libby MT 59923 USA','bfaulkner@lcsomt.us'),('ELLSOUTH TELECOMMUNICATIONS INC(Opelika AL)','DSE189','1819 Pepperrell Pkwy Suite 203','mz7001@att.com'),
('Harrison County Sheriffs Office','DSE190','978 E.Market St Cadiz OH 43907 USA','ewilson@harrisoncountyohio.org');

select * from Cliente;
describe Servicio;

insert into Servicio values ('SC0001','Servicios de Ciberseguridad','NT001','SC'),('RP0001','Repuestos y Pedidos','QL002','RP'),('AC0001','Atención al Cliente','NSE003','AC'),
('SC0002','Servicios de Ciberseguridad','CSC004','SC'),('RP0002','Repuestos y Pedidos','DS005','RP'),('RP0003','Repuestos y Pedidos','NSE009','RP'),
('RP0004','Repuestos y Pedidos','DSE98','RP'),('RP0005','Repuestos y Pedidos','DSE99','RP'),('SC0003','Servicios de Ciberseguridad','DSE100','SC'),
('SC0004','Servicios de Ciberseguridad','DSE101','SC'),('SC0005','Servicios de Ciberseguridad','DSE102','SC'),('SC0006','Servicios de Ciberseguridad','DSE103','SC'),
('SC0007','Servicios de Ciberseguridad','DSE104','SC'),('SC0008','Servicios de Ciberseguridad','DSE105','SC'),('SC0009','Servicios de Ciberseguridad','DSE106','SC'),
('RP0006','Repuestos y Pedidos','DSE107','RP'),('RP0007','Repuestos y Pedidos','DSE108','RP'),('RP0008','Repuestos y Pedidos','DSE109','RP'),
('RP0009','Repuestos y Pedidos','DSE110','RP'),('RP0010','Repuestos y Pedidos','DSE111','RP');
insert into Servicio values ('RP0011','Repuestos y Pedidos','DSE112','RP'),('RP0012','Repuestos y Pedidos','DSE113','RP'),('RP0013','Repuestos y Pedidos','DSE114','RP'),
('RP0014','Repuestos y Pedidos','DSE115','RP'),('RP0015','Repuestos y Pedidos','DSE116','RP'),('RP0016','Repuestos y Pedidos','DSE117','RP'),
('AC0002','Atención al Cliente','DSE118','AC'),('AC0003','Atención al Cliente','DSE119','AC'),('AC0004','Atención al Cliente','DSE120','AC'),
('AC0005','Atención al Cliente','DSE121','AC'),('AC0006','Atención al Cliente','DSE122','AC'),('AC0007','Atención al Cliente','DSE123','AC'),
('AC0008','Atención al Cliente','DSE124','AC'),('AC0009','Atención al Cliente','DSE125','AC'),('AC0010','Atención al Cliente','DSE126','AC'),
('AC0011','Atención al Cliente','DSE127','AC'),('AC0012','Atención al Cliente','DSE128','AC'),('AC0013','Atención al Cliente','DSE129','AC'),
('AC0014','Atención al Cliente','DSE130','AC'),('AC0015','Atención al Cliente','DSE131','AC');
insert into Servicio values ('AC0016','Atención al Cliente','DSE132','AC'),('SC0010','Servicios de Ciberseguridad','DSE133','SC'),('SC0011','Servicios de Ciberseguridad','DSE134','SC'),
('SC0012','Servicios de Ciberseguridad','DSE135','SC'),('SC0013','Servicios de Ciberseguridad','DSE136','SC'),('SC0014','Servicios de Ciberseguridad','DSE137','SC'),
('SC0015','Servicios de Ciberseguridad','DSE138','SC'),('SC0016','Servicios de Ciberseguridad','DSE139','SC'),('SC0017','Servicios de Ciberseguridad','DSE140','SC'),
('SC0018','Servicios de Ciberseguridad','DSE141','SC'),('SC0019','Servicios de Ciberseguridad','DSE142','SC'),('SC0020','Servicios de Ciberseguridad','DSE143','SC'),
('SC0021','Servicios de Ciberseguridad','DSE144','SC'),('SC0022','Servicios de Ciberseguridad','DSE145','SC'),('RP0017','Repuestos y Pedidos','DSE146','RP'),
('RP0018','Repuestos y Pedidos','DSE147','RP'),('RP0019','Repuestos y Pedidos','DSE148','RP'),('RP0020','Repuestos y Pedidos','DSE149','RP'),
('RP0021','Repuestos y Pedidos','DSE150','RP'),('RP0022','Repuestos y Pedidos','DSE151','RP');
insert into Servicio values ('RP0023','Repuestos y Pedidos','DSE152','RP'),('RP0024','Repuestos y Pedidos','DSE153','RP'),('RP0025','Repuestos y Pedidos','DSE154','RP'),
('RP0026','Repuestos y Pedidos','DSE155','RP'),('RP0027','Repuestos y Pedidos','DSE156','RP'),('RP0028','Repuestos y Pedidos','DSE157','RP'),
('RP0029','Repuestos y Pedidos','DSE158','RP'),('RP0030','Repuestos y Pedidos','DSE159','RP'),('RP0031','Repuestos y Pedidos','DSE160','RP'),
('RP0032','Repuestos y Pedidos','DSE161','RP'),('RP0033','Repuestos y Pedidos','DSE162','RP'),('RP0034','Repuestos y Pedidos','DSE163','RP'),
('RP0035','Repuestos y Pedidos','DSE164','RP'),('RP0036','Repuestos y Pedidos','DSE165','RP'),('RP0037','Repuestos y Pedidos','DSE166','RP'),
('RP0038','Repuestos y Pedidos','DSE167','RP'),('RP0039','Repuestos y Pedidos','DSE168','RP'),('RP0040','Repuestos y Pedidos','DSE169','RP'),
('RP0041','Repuestos y Pedidos','DSE170','RP'),('SC0023','Servicios de Ciberseguridad','DSE171','SC');
insert into Servicio values ('SC0024','Servicios de Ciberseguridad','DSE172','SC'),('SC0025','Servicios de Ciberseguridad','DSE173','SC'),('SC0026','Servicios de Ciberseguridad','DSE174','SC'),
('SC0027','Servicios de Ciberseguridad','DSE175','SC'),('SC0028','Servicios de Ciberseguridad','DSE176','SC'),('SC0029','Servicios de Ciberseguridad','DSE177','SC'),
('SC0030','Servicios de Ciberseguridad','DSE178','SC'),('SC0031','Servicios de Ciberseguridad','DSE179','SC'),('SC0032','Servicios de Ciberseguridad','DSE180','SC'),
('SC0033','Servicios de Ciberseguridad','DSE181','SC'),('SC0034','Servicios de Ciberseguridad','DSE182','SC'),('SC0035','Servicios de Ciberseguridad','DSE183','SC'),
('AC0017','Atención al Cliente','DSE184','AC'),('AC0018','Atención al Cliente','DSE185','AC'),('AC0019','Atención al Cliente','DSE186','AC'),
('RP0042','Repuestos y Pedidos','DSE187','RP'),('RP0043','Repuestos y Pedidos','DSE188','RP'),('RP0044','Repuestos y Pedidos','DSE189','RP'),
('RP0045','Repuestos y Pedidos','DSE190','RP');

select * from Servicio;

use solacom;
describe provedor;

alter table provedor
drop column Nombreproducto;

alter table provedor
drop column CantidadProductos;

alter table provedor
drop column PrecioProductos;

alter table provedor
drop column HarmonizedCode;

alter table provedor
drop column idCompraP;

insert into Provedor values('1','Pallets'),('2','Dell position boxes'),('3','Dell Mobile position'),('4','Cisco Box Labeled'),('5','Solacom Box Labeled');
select * from provedor;
describe CompraProvedor;

alter table CompraProvedor
modify HarmonizedCode varchar(25);

select * from CompraProvedor;

insert into CompraProvedor values('1','Position Audio Controller II w/ Jack Box','P-PAC II',15.00,25,'1'),('2','Dell 23.8 Monitor @ AML','C2213340-5 SR1','180.00',20,'1'),('3','Speaker USB powered, 3.5mm Audio','C2213213-3 SR1','51.00',15,'1'),('4','Cyberpower 900VA 120V UPS','C2213150-1 SR1','138.95',25,'1'),('5','Network laser color printer','C2213811-2 SR1','269.00',20,'1');
insert into CompraProvedor values('6','Dell T5820 Win10 IOT 2019 LTSC','C2213794-8 3YS+','7000',15,'2'),('7','Guardian Intelligent WorkstationUserCard','C2214210-1 SR2','80.00',25,'2'),('8','Solacom Mouse Pad','C2213660-1 SR1','3.67',20,'2');
insert into CompraProvedor values('9','Precision 7780 XCTO BASE','C2213452-11 5YS','30.00',15,'3'),('10','Hardened case black','C2213162-1 SR1','66.99',25,'3'),('11','Optical Mouse','C2213164-1 SR1','14.39',20,'3'),('12','Guardian Intelligent WorkstationUserCard','C2214210-1 SR2','80.00',15,'3'),
('13','Solacom Mouse Pad','C2213660-1 SR1','3.67',25,'3'),('14','Mono Headsets (w/o adapter)','C2213236-2 SR1','27.19',20,'3'),('15','DA80 USB Hdst adapter w volume','C2213876-1 SR1','18.55',15,'3'),('16','HASP key for stand-alone recording w/w','B3211264-1 SR1','23.00',25,'3'),('17','Jackbox 4 Assembly Rev A','C3210053-1 SR1','18.99',20,'3'),
('18','RJ45 to RJ45 CABLE 10','C2213217-1 SR1','10.39',15,'3'),('19','USB Programmable 24 key  Keypad','C2213176-1 SR1','159.55',25,'3'),('20','10ft USB 2.0 A Male to A Female cable','C2213735-1 SR1','6.29',20,'3'),('21','VT4000 Docking Station for Laptop','C2213911-1 SR1','35.00',15,'3'),('22','USB keyboard & mouse combo ','C2213367-1 SR1','33.98',25,'3');
insert into CompraProvedor values('23','Cisco C9200L 24','C2213895-1 SR1','1738.35',20,4),('24','Nema 5-15 to C13 AC Cord (3)','B3210506-1 0036','8.80',15,4),('25','Cisco console cable - RJ45m - DB9F 6ft','C2213800-1 SR1','6.50',25,4),('26','Cat 6A Shielded Grey Ether Cable (12IN)','C2213692-1 0012','161.98',20,4);
insert into CompraProvedor values('27','HASP key for stand-alone recording w/w','B3211264-1 SR1','23.00',15,5),('28','Perle IOLAN STS4-D','C2213490-1 SR1','545.28',25,5),('29','CAT5e unshielded ethernet cable','C2213201-1 0012','143.99',20,5),('30','DB9 to DB9 Patch Panel','B2213424-2 SR1','11.19',15,5),
('31','Perle IOLAN RJ45 to DB9 Null modem','C3210065-1 SR1','4.95',25,5),('32','Cat 6A Shielded Blue Ether Cable (60IN)','C3210015-1 0060','35.99',20,5),('33','1U Rackmount shelf (silver)','B2213412-1 SR1','45.49',15,5),('34','PTS Handset w/ 15ft cord','B5100005','6.90',25,5),
('35','10ft USB 2.0 A Male to A Female cable','C2213735-1 SR1','10.39',20,5),('36','USB Programmable 24 key  Keypad','C2213176-1 SR1','169.55',15,5),('37','Jackbox 4 Assembly Rev A','C3210053-1 SR1','18.99',25,5),('38','RJ45 to RJ45 CABLE 10','C2213217-1 SR1','10.39',20,5);

insert into Registro_Solacom values('5','NSE003','AC0001'),('5','DSE118','AC0002'),('5','DSE119','AC0003'),('5','DSE120','AC0004'),('5','DSE121','AC0005'),
('5','DSE122','AC0006'),('5','DSE123','AC0007'),('5','DSE124','AC0008'),('5','DSE125','AC0009'),('5','DSE126','AC0010'),
('5','DSE127','AC0011'),('5','DSE128','AC0012'),('5','DSE129','AC0013'),('5','DSE130','AC0014'),('5','DSE131','AC0015'),
('5','DSE132','AC0016'),('5','DSE184','AC0017'),('5','DSE185','AC0018'),('5','DSE186','AC0019'),('4','QL002','RP0001');
insert into Registro_Solacom values('4','DS005','RP0002'),('3','NSE009','RP0003'),('1','DSE98','RP0004'),('1','DSE99','RP0005'),('1','DSE107','RP0006'),
('1','DSE108','RP0007'),('4','DSE109','RP0008'),('5','DSE110','RP0009'),('5','DSE111','RP0010'),('3','DSE112','RP0011'),
('3','DSE113','RP0012'),('3','DSE114','RP0013'),('2','DSE115','RP0014'),('2','DSE116','RP0015'),('2','DSE117','RP0016'),
('2','DSE146','RP0017'),('2','DSE147','RP0018'),('1','DSE148','RP0019'),('3','DSE149','RP0020'),('4','DSE150','RP0021');
insert into Registro_Solacom values('4','DSE151','RP0022'),('4','DSE152','RP0023'),('5','DSE153','RP0024'),('5','DSE154','RP0025'),('3','DSE155','RP0026'),
('2','DSE156','RP0027'),('1','DSE157','RP0028'),('1','DSE158','RP0029'),('2','DSE159','RP0030'),('3','DSE160','RP0031'),
('3','DSE161','RP0032'),('4','DSE162','RP0033'),('1','DSE163','RP0034'),('1','DSE164','RP0035'),('2','DSE165','RP0036'),
('2','DSE166','RP0037'),('3','DSE167','RP0038'),('3','DSE168','RP0039'),('4','DSE169','RP0040'),('4','DSE170','RP0041');
insert into Registro_Solacom values('4','DSE187','RP0042'),('2','DSE188','RP0043'),('2','DSE189','RP0044'),('3','DSE190','RP0045'),('1','NT001','SC0001'),
('5','CSC004','SC0002'),('5','DSE100','SC0003'),('5','DSE101','SC0004'),('1','DSE102','SC0005'),('1','DSE103','SC0006'),
('1','DSE104','SC0007'),('5','DSE105','SC0008'),('5','DSE106','SC0009'),('1','DSE133','SC0010'),('1','DSE134','SC0011'),
('1','DSE135','SC0012'),('5','DSE136','SC0013'),('1','DSE137','SC0014'),('5','DSE138','SC0015'),('1','DSE139','SC0016');
insert into Registro_Solacom values('1','DSE140','SC0017'),('1','DSE141','SC0018'),('1','DSE142','SC0019'),('1','DSE143','SC0020'),('5','DSE144','SC0021'),
('5','DSE145','SC0022'),('5','DSE171','SC0023'),('5','DSE172','SC0024'),('5','DSE173','SC0025'),('1','DSE174','SC0026'),
('1','DSE175','SC0027'),('5','DSE176','SC0028'),('5','DSE177','SC0029'),('1','DSE178','SC0030'),('1','DSE179','SC0031'),
('5','DSE180','SC0032'),('5','DSE181','SC0033'),('1','DSE182','SC0034'),('1','DSE183','SC0035');

describe registro_solacom;
select * from Registro_Solacom;

call MostrarFactura_Provedor('3');
SELECT C.DireccionCliente AS NombreCliente, P.NombreProvedor AS NombreProveedor, G.TotalVenta AS TotalCompra
FROM GenerarVenta G
JOIN Cliente C ON G.IdClienteFK = C.IdCliente
JOIN Provedor P ON G.NombreProductoFK = P.IdProvedor
WHERE G.FechaVenta = '';