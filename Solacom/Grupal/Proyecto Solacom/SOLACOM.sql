create database Solacom;
use Solacom;

create table cliente(
IdCliente varchar(25) primary key not null,
NombreCliente varchar(50) not null,
direccionCliente varchar(100) not null,
correo varchar(100) not null
);

create table Producto(
HarmonizedCode varchar(25) not null primary key,
NombreProducto varchar(50) not null,
PrecioProducto float not null,
IdprovedorFK varchar(25) not null
);

create table CompraCliente(
IdCompra int auto_increment primary key,
IdClienteFK varchar(25) not null,
HarmonizedCodeFK varchar(25) not null,
cantidadProducto int not null,
fechaCompraCliente date not null
);

create table provedor(
IdProvedor varchar(25) primary key,
NombreProvedor varchar(50)
);

create table CompraProvedor(
IdCompraP varchar(25) primary key not null,
IdprovedorFK varchar(25) not null,
HarmonizedCodeFK varchar(25) not null,
Cantidad int not null,
fechaCompra date not null
);

create table Servicio(
IdServicio int auto_increment primary key not null,
NombreServicio varchar(25) not null,
IdClienteFK varchar(25) not null,
Descripcion varchar(20)
);

create table Solacom(
IdClienteFK varchar(25) not null,
IdProvedorFK varchar(25) not null,
IdServicioFK int
);

alter table CompraCliente
add constraint FKIdCliente
foreign key(IdClienteFK)
references Cliente(IdCliente);

alter table CompraCliente
add constraint FKHarCode
foreign key (HarmonizedCodeFK)
references Producto(HarmonizedCode);

alter table CompraProvedor
add constraint FKIdProvedor
foreign key (IdProvedorFK)
references Provedor(IdProvedor);

alter table CompraProvedor
add constraint FKHarCodeprovedor
foreign key (HarmonizedCodeFK)
references Producto(HarmonizedCode);

alter table Solacom
add constraint FKIdClienteSolacom
foreign key (IdClienteFK)
references Cliente(IdCliente);

alter table Solacom
add constraint FKIdProvedorSolacom
foreign key (IdProvedorFK)
references Provedor(IdProvedor);

alter table Solacom
add constraint FKIdServicioSolacom
foreign key (IdservicioFK)
references Servicio(IdServicio);

alter table Servicio
add constraint FKIdClienteServicio
foreign key (IdClienteFK)
references Cliente(IdCliente);

alter table CompraCliente
add column EstadoCompra bool;

alter table CompraProvedor
add column EstadoCompraP bool;

DELIMITER //
create procedure RegistrarCliente(IdCliente varchar(50),Nombre varchar(50),DireccionCliente varchar(100),correo varchar(100))
begin 
insert into Cliente values(IdCliente,Nombre,DireccionCliente,correo);
end//
DELIMITER ;

DELIMITER //
create procedure RegistarProvedor(IdProvedor varchar(50),NombreProvedor varchar(50))
begin
insert into Provedor values(IdProvedor,NombreProvedor);
end//
DELIMITER ; 

DELIMITER // 
create procedure DetallesProducto(id_compra varchar(50))
begin
select P.NombreProducto,P.PrecioProducto,C.Cantidadproductos from CompraCliente C 
inner join Producto P on C.HarmonizedCodeFK = P.HarmonizedCode
where IdCompra = id_compra;
end//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GenerarPedidoCliente(IdCompra int,IdClienteFK varchar(25),HarmonizedCodeFK varchar(25),Cantidad int,fecha date,estado bool)
BEGIN
insert into Detalle_Compra values (IdCompra,IdClienteFK,HarmonizedCodeFK,Cantidad,fecha,estado);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerFacturaCompra(Id_Compra INT)
BEGIN
SELECT CL.NombreCliente,CL.direccionCliente,CL.correo,CC.fechaCompraCliente,P.NombreProducto,P.PrecioProducto,CC.cantidadProducto,(P.PrecioProducto * CC.cantidadProducto) AS Subtotal,SUM(P.PrecioProducto * CC.cantidadProducto) OVER () AS TotalCompra
FROM CompraCliente CC
INNER JOIN Cliente CL ON CC.IdClienteFK = CL.IdCliente
INNER JOIN Producto P ON CC.HarmonizedCodeFK = P.HarmonizedCode
WHERE CC.IdClienteFK = Id_Compra;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerFacturaCompraProvedor(Id_CompraP VARCHAR(25))
BEGIN
SELECT PR.NombreProvedor,P.NombreProducto,P.PrecioProducto,CP.Cantidad,(P.PrecioProducto * CP.Cantidad) AS Subtotal,SUM(P.PrecioProducto * CP.Cantidad) OVER () AS TotalCompra
FROM CompraProvedor CP
INNER JOIN Provedor PR ON CP.IdProvedorFK = PR.IdProvedor
INNER JOIN Producto P ON CP.HarmonizedCodeFK = P.HarmonizedCode
WHERE CP.IdProvedorFK = Id_CompraP;
END //
DELIMITER ;
drop procedure ObtenerFacturaCompra;

DELIMITER // 
create procedure Estado_de_compra(id_compra varchar(50))
begin
select EstadoCompra from CompraCliente where IdCompraP = id_compra;
end//
DELIMITER ;

call RegistrarCliente('NT001','NovaTech Solutions','123 Silicon Valley Blvd, San Francisco, CA','nova.tech@gmail.com');

insert into Cliente values('QL002','QuantumLeap Inc.','456 Innovation Drive, Toronto, ON','quantum@hotmail.com'),('NSE003','NorthStar Enterprises','789 Main Street, Seattle, WA','northS@gmail.com'),
('CSC004','CyberShield Corp.','110 Cyber Avenue, Ottawa, ON','cyberShield@gmail.com'),('DS005','DataStream Inc.','220 Data Drive, Vancouver, BC','datas@gmail.com'),('NSE009','Biotech Toronto','150 Elgin Street, Suite 800, Ottawa, ON K2P 1L4, Canada','biotech@gmail.com'),
('DSE98','GreenTech Seattle','5th Floor, 111 East 5th Avenue, Vancouver, BC V5T 1G4, Canada','greentech@gmail.com'),('DSE99','Ryerson AI','1910 Avenue 1, Suite 200, Montreal, QC H3A 2R6, Canada','reyersonAI@gmail.com'),
('DSE100','WinterLight Labs','275 Frank Tompa Drive, Waterloo, ON N2L 0A1, Canada','winterl@gmail.com'),('DSE101','Kindred Systems','3500 Carling Avenue, Suite 100, Ottawa, ON K2H 8T5, Canada','Kindred@gmail.com'),
('DSE102','ZoomInfo','1000 - 1005 W 17th Avenue, Vancouver, BC V6H 1A5, Canada','Zoomn@gmail.com'),('DSE103','Asana','2200 University Avenue E, Waterloo, ON N2K 0A7, Canada','Asana@gmail.com'),('DSE104','PagerDuty','1500 Don Mills Road, Suite 400, Ottawa, ON K4A 3Z5, Canada','Pager@gmail.com'),
('DSE105','Evernote','25, 2300 René-Lévesque Blvd W, Montreal, QC H3H 2T8, Canada','Evernote@gmail.com'),('DSE106','DuckDuckGo','2300-100  Toronto, ON M5J 1V6, Canada','contact@duckduckgo.com'),('DSE107','Mailchimp','Av. México 83, Colonia Hipódromo, 06100 Ciudad de México, CDMX, México','support@mailchimp.com'),
('DSE108','Squarespace','Av. José María Pino Suárez 60, Centro Histórico, 06060 Ciudad de México, CDMX, México','support@squarespace.com'),('DSE109','Box','699 8th St, San Francisco, CA 94103, USA','support@box.com'),
('DSE110','HubSpot','401- 119 West Pender Street, Vancouver, BC V6B 1S5, Canada','support@hubspot.com'),('DSE111','Plaid','399 11th St, San Francisco, CA 94103, USA','support@plaid.com');
insert into Cliente values('DSE112','Robinhood','699 8th St, San Francisco, CA 94103, USA','support@robinhood.com'),('DSE113','GitHub','2850 3rd St, San Francisco, CA 94107, USA','support@github.com'),('DSE114','Coursera','197 Spadina Ave, Suite 600, Toronto, ON M5T 2C1, Canada','support@coursera.org'),
('DSE115','Wix (Israel, pero con operaciones en América del Norte)','3300 E 1st Ave, Denver, CO 80205, USA','support@wix.com'),('DSE116','Trello','900 Jefferson Ave, Redwood City, CA 94063, USA','contact@trello.com'),('DSE117','Kio Networks','650 Castro St, Mountain View, CA 94041, USA','info@kionetworks.com'),
('DSE118','Bitso','25 First Street, Cambridge, MA 02141, USA','soporte@bitso.com'),('DSE119','Clip','501 W 15th St, Austin, TX 78701, USA','contacto@clip.mx'),('DSE120','Konfio','600 Harrison St, Suite 200, San Francisco, CA 94107, USA','contacto@konfio.mx'),
('DSE121','Conekta','1100 Marietta St NW, Atlanta, GA 30318, USA','support@conekta.com'),('DSE122','Rappi','85 Willow Road, Menlo Park, CA 94025, USA','soporte@rappi.com'),('DSE123','OXXO','1390 Market St, San Francisco, CA 94102, USA','contacto@oxxo.com'),
('DSE124','Kavak','12655 W 64th Ave, Suite 200, Arvada, CO 80004, USA','contacto@kavak.com'),('DSE125','B2B Media','1750 Zanker Rd #100, San Jose, CA 95112, USA','contacto@b2bmedia.mx'),('DSE126','Kubo Financiero','400 W 15th St, Austin, TX 78701, USA','contacto@kubofinanciero.com'),
('DSE127','Auronix','2300 W 17th St, San Francisco, CA 94107, USA','contacto@auronix.com'),('DSE128','500 Startups','7400, 1er Avenue, Suite 300, Québec, QC G1H 7C1, Canada','info@500.co'),('DSE129','Ginkgo','244 2nd St, San Francisco, CA 94105, USA','contact@ginkgobioworks.com'),
('DSE130','Payit','1215 St-Alexandre St #300, Montreal, QC H3B 3H4, Canada','info@payit.com'),('DSE131','Dev.F','1515 Rue Saint-Antoine O, Suite 400, Montreal, QC H3C 2S2, Canada','info@dev.f');
insert into Cliente values('DSE132','Shopify','460 Speedvale Ave E, Guelph, ON N1E 1P1, Canada','support@shopify.com'),('DSE133','Hootsuite','325 Front St W, Toronto, ON M5V 2Y1, Canada','support@hootsuite.com'),('DSE134','Slack Technologies','1600-1177 11th Ave SW, Calgary, AB T2R 1K3, Canada','feedback@slack.com'),
('DSE135','OpenText','1300-200 Granville St, Vancouver, BC V6C 1S4, Canada','info@opentext.com'),('DSE136','Ceridian','1600-1177 11th Ave SW, Calgary, AB T2R 1K3, Canada','info@ceridian.com'),('DSE137','Mitel Networks','5600-1000 Sherbrooke St W, Montreal, QC H3A 3R2, Canada','contact@mitel.com'),
('DSE138','Coveo','501 W 15th St, Austin, TX 78701, USA','info@coveo.com'),('DSE139','Absolute Software','103 5th Ave, New York, NY 10003, USA','info@absolute.com'),('DSE140','Blackberry','1515 Rue Saint-Antoine O, Suite 400, Montreal, QC H3C 2S2, Canada','info@blackberry.com'),
('DSE141','Kinaxis','1010 Rue Galt E, Sherbrooke, QC J1G 1X5, Canada','info@kinaxis.com'),('DSE142','Lightspeed Commerce','1500 - 1000 St. Laurent Blvd, Montreal, QC H2X 2S9, Canada','contact@lightspeedhq.com'),('DSE143','Constellation Software','2800 3rd St, San Francisco, CA 94107, USA','info@csw.com'),
('DSE144','FreshBooks','150 W 13th St, New York, NY 10011, USA','support@freshbooks.com'),('DSE145','Bench','69. 1500 - 1000 St. Laurent Blvd, Montreal, QC H2X 2S9, Canada','support@bench.co'),('DSE146','Clio','5700 W 11th St, Los Angeles, CA 90011, USA','support@clio.com'),
('DSE147','Descartes Systems Group','1000 E 1st St, Los Angeles, CA 90012,USA','info@descartes.com'),('DSE148','Nuvei','125 E 11th St, New York, NY 10003, USA','contact@nuvei.com'),('DSE149','Clearco','101 N. 5th St, Philadelphia, PA 19106, USA','support@clear.co'),
('DSE150','Wealthsimple','3031 N 14th St, Lincoln, NE 68521, USA','help@wealthsimple.com'),('DSE151','Thinkific','3200 E Camelback Rd #240, Phoenix, AZ 85018, USA','support@thinkific.com');
insert into Cliente values('DSE152','Vidyard','600 S 2nd St, Minneapolis, MN 55401, USA','info@vidyard.com'),('DSE153','Auvik Networks','2001 S. 16th St, San Francisco, CA 94103, USA','support@auvik.com'),('DSE154','D2L','5700 W 11th St, Los Angeles, CA 90011, USA','support@d2l.com'),
('DSE155','Benevity','1200 W 4th St, Austin, TX 78703, USA','info@benevity.com'),('DSE156','Unbounce','3031 N 14th St, Lincoln, NE 68521, USA','support@unbounce.com'),('DSE157','Element AI','5500 W 2nd St, Santa Ana, CA 92703, USA','info@elementai.com'),
('DSE158','WealthBar','3131 S 10th St, San Jose, CA 95112, USA','support@wealthbar.com'),('DSE159','Wave Financial','1201 S. Orange Ave, Orlando, FL 32806, USA','support@waveapps.com'),('DSE160','GSoft','707 E 15th St, Austin, TX 78701, USA','info@gsoft.com'),
('DSE161','Plooto','150 W 13th St, New York, NY 10011, USA','support@plooto.com'),('DSE162','Dapper Labs (desarrollo de tecnología blockchain y NFT)','1515 Rue Saint-Antoine O, Suite 400, Montreal, QC H3C 2S2, Canada','info@dapperlabs.com'),('DSE163','Tribe (plataforma de comunidades online)','1000 E 1st St, Los Angeles, CA 90012, USA','support@tribe.so'),
('DSE164','Plooto (software de gestión de pagos)','3200 E Camelback Rd #240, Phoenix, AZ 85018, USA','hello@crisp.co'),('DSE165','Crisp (plataforma de análisis de datos para restaurantes)','1201 W 10th St, Los Angeles, CA 90015, USA','info@ada.support'),('DSE166','Ada (plataforma de automatización de atención al cliente)','401- 119 West Pender Street, Vancouver, BC V6B 1S5, Canada','info@loom.ai'),
('DSE167','Loom.ai (tecnología de creación de avatares en 3D)','5000 N Central Ave, Phoenix, AZ 85012, USA','contactus@zynga.com'),('DSE168','Zynga (juegos sociales)','197 Spadina Ave, Suite 600, Toronto, ON M5T 2C1, Canada','hello@foko.com'),('DSE169','Foko (software de gestión de contenido para empresas)','1775 19th St NW, Washington, DC 20009, USA','info@jibestream.com'),
('DSE170','Unbounce (herramientas para crear landing pages)','5775 16th Avenue, Suite 210, Vancouver, BC V5Y 1A5, Canada','support@calendly.com'),('DSE171','Jibestream (soluciones de mapeo en interiores)','2020 S. 7th St, Philadelphia, PA 19148, USA','hello@makenotion.com');
insert into Cliente values('DSE172','Calendly (herramienta de programación de citas)','85 Willow Road, Menlo Park, CA 94025, USA','support@gumroad.com'),('DSE173','Notion (plataforma de gestión de proyectos y notas)','6100 W 104th Ave, Westminster, CO 80020, USA','contact@substack.com'),('DSE174','Gumroad (plataforma de venta de productos digitales)','675 Ponce de Leon Ave NE, Suite 5000, Atlanta, GA 30308, USA','support@sift.com'),
('DSE175','Substack (plataforma de newsletters)','101 N. 5th St, Philadelphia, PA 19106, USA','support@airtable.com'),('DSE176','Sift (soluciones de gestión de fraude)','Av. Revolución 1310, Colonia San Angel, 01000 Ciudad de México, CDMX, México','support@zapier.com'),('DSE177','Airtable (plataforma de bases de datos flexibles)','1700 E 18th St, Austin, TX 78702, USA','help@figma.com'),
('DSE178','Zapier (automatización de tareas entre aplicaciones)','1500 Don Mills Road, Suite 400, Ottawa, ON K4A 3Z5, Canada','hello@buffer.com'),('DSE179','Figma (herramienta de diseño colaborativo)','600 S 2nd St, Minneapolis, MN 55401, USA','support@loom.com'),('DSE180','Buffer (gestión de redes sociales)','275 Frank Tompa Drive, Waterloo, ON N2L 0A1, Canada','hello@yalo.com'),
('DSE181','Loom (herramienta de grabación de video)','2425 W 26th St, Chicago, IL 60623, USA','contacto@kueski.com'),('DSE182','Yalo (plataforma de automatización de ventas y atención al cliente)','150 Elgin Street, Suite 800, Ottawa, ON K2P 1L4, Canada','contacto@jisto.mx'),('DSE183','Kueski (fintech de préstamos en línea)','1000 S 10th St, San Jose, CA 95112, USA','hola@albo.mx'),
('DSE184','Conekta (soluciones de pago)','1000 N. 4th St. Suite 300, Austin, TX 78703, USA','conekta@conecta.com'),('DSE185','Jüsto (plataforma de comercio electrónico)','27 Drydock Ave, Boston, MA 02210, USA','justo@justo.com'),('DSE186','Albo (banco digital)','1201 S. Orange Ave, Orlando, FL 32806, USA','albo@albo.com'),
('DSE187','Morgan County EMA','60S Fourth St McConnelsville OH 43756','911coordinator@morgancounty-oh.gov'),('DSE188','Lincoln County Sheriffs Office','512 California Avenue Libby MT 59923 USA','bfaulkner@lcsomt.us'),('DSE189','ELLSOUTH TELECOMMUNICATIONS INC(Opelika AL)','1819 Pepperrell Pkwy Suite 203','mz7001@att.com'),
('DSE190','Harrison County Sheriffs Office','978 E.Market St Cadiz OH 43907 USA','ewilson@harrisoncountyohio.org');

select * from Cliente;
describe Servicio;

insert into Servicio values ('10001','Servicios de Ciberseguridad','NT001','SC'),('','Repuestos y Pedidos','QL002','RP'),('','Atención al Cliente','NSE003','AC'),
('','Servicios de Ciberseguridad','CSC004','SC'),('','Repuestos y Pedidos','DS005','RP'),('','Repuestos y Pedidos','NSE009','RP'),
('','Repuestos y Pedidos','DSE98','RP'),('','Repuestos y Pedidos','DSE99','RP'),('','Servicios de Ciberseguridad','DSE100','SC'),
('','Servicios de Ciberseguridad','DSE101','SC'),('','Servicios de Ciberseguridad','DSE102','SC'),('','Servicios de Ciberseguridad','DSE103','SC'),
('','Servicios de Ciberseguridad','DSE104','SC'),('','Servicios de Ciberseguridad','DSE105','SC'),('','Servicios de Ciberseguridad','DSE106','SC'),
('','Repuestos y Pedidos','DSE107','RP'),('','Repuestos y Pedidos','DSE108','RP'),('','Repuestos y Pedidos','DSE109','RP'),
('','Repuestos y Pedidos','DSE110','RP'),('','Repuestos y Pedidos','DSE111','RP');
insert into Servicio values ('','Repuestos y Pedidos','DSE112','RP'),('','Repuestos y Pedidos','DSE113','RP'),('','Repuestos y Pedidos','DSE114','RP'),
('','Repuestos y Pedidos','DSE115','RP'),('','Repuestos y Pedidos','DSE116','RP'),('','Repuestos y Pedidos','DSE117','RP'),
('','Atención al Cliente','DSE118','AC'),('','Atención al Cliente','DSE119','AC'),('','Atención al Cliente','DSE120','AC'),
('','Atención al Cliente','DSE121','AC'),('','Atención al Cliente','DSE122','AC'),('','Atención al Cliente','DSE123','AC'),
('','Atención al Cliente','DSE124','AC'),('','Atención al Cliente','DSE125','AC'),('','Atención al Cliente','DSE126','AC'),
('','Atención al Cliente','DSE127','AC'),('','Atención al Cliente','DSE128','AC'),('','Atención al Cliente','DSE129','AC'),
('','Atención al Cliente','DSE130','AC'),('','Atención al Cliente','DSE131','AC');
insert into Servicio values ('','Atención al Cliente','DSE132','AC'),('','Servicios de Ciberseguridad','DSE133','SC'),('','Servicios de Ciberseguridad','DSE134','SC'),
('','Servicios de Ciberseguridad','DSE135','SC'),('','Servicios de Ciberseguridad','DSE136','SC'),('','Servicios de Ciberseguridad','DSE137','SC'),
('','Servicios de Ciberseguridad','DSE138','SC'),('','Servicios de Ciberseguridad','DSE139','SC'),('','Servicios de Ciberseguridad','DSE140','SC'),
('','Servicios de Ciberseguridad','DSE141','SC'),('','Servicios de Ciberseguridad','DSE142','SC'),('','Servicios de Ciberseguridad','DSE143','SC'),
('','Servicios de Ciberseguridad','DSE144','SC'),('','Servicios de Ciberseguridad','DSE145','SC'),('','Repuestos y Pedidos','DSE146','RP'),
('','Repuestos y Pedidos','DSE147','RP'),('','Repuestos y Pedidos','DSE148','RP'),('','Repuestos y Pedidos','DSE149','RP'),
('','Repuestos y Pedidos','DSE150','RP'),('','Repuestos y Pedidos','DSE151','RP');
insert into Servicio values ('','Repuestos y Pedidos','DSE152','RP'),('','Repuestos y Pedidos','DSE153','RP'),('','Repuestos y Pedidos','DSE154','RP'),
('','Repuestos y Pedidos','DSE155','RP'),('','Repuestos y Pedidos','DSE156','RP'),('','Repuestos y Pedidos','DSE157','RP'),
('','Repuestos y Pedidos','DSE158','RP'),('','Repuestos y Pedidos','DSE159','RP'),('','Repuestos y Pedidos','DSE160','RP'),
('','Repuestos y Pedidos','DSE161','RP'),('','Repuestos y Pedidos','DSE162','RP'),('','Repuestos y Pedidos','DSE163','RP'),
('','Repuestos y Pedidos','DSE164','RP'),('','Repuestos y Pedidos','DSE165','RP'),('','Repuestos y Pedidos','DSE166','RP'),
('','Repuestos y Pedidos','DSE167','RP'),('','Repuestos y Pedidos','DSE168','RP'),('','Repuestos y Pedidos','DSE169','RP'),
('','Repuestos y Pedidos','DSE170','RP'),('','Servicios de Ciberseguridad','DSE171','SC');
insert into Servicio values ('','Servicios de Ciberseguridad','DSE172','SC'),('','Servicios de Ciberseguridad','DSE173','SC'),('','Servicios de Ciberseguridad','DSE174','SC'),
('','Servicios de Ciberseguridad','DSE175','SC'),('','Servicios de Ciberseguridad','DSE176','SC'),('','Servicios de Ciberseguridad','DSE177','SC'),
('','Servicios de Ciberseguridad','DSE178','SC'),('','Servicios de Ciberseguridad','DSE179','SC'),('','Servicios de Ciberseguridad','DSE180','SC'),
('','Servicios de Ciberseguridad','DSE181','SC'),('','Servicios de Ciberseguridad','DSE182','SC'),('','Servicios de Ciberseguridad','DSE183','SC'),
('','Atención al Cliente','DSE184','AC'),('','Atención al Cliente','DSE185','AC'),('','Atención al Cliente','DSE186','AC'),
('','Repuestos y Pedidos','DSE187','RP'),('','Repuestos y Pedidos','DSE188','RP'),('','Repuestos y Pedidos','DSE189','RP'),
('','Repuestos y Pedidos','DSE190','RP');

select * from Servicio;

insert into Provedor values('1','Pallets'),('2','Dell position boxes'),('3','Dell Mobile position'),('4','Cisco Box Labeled'),('5','Solacom Box Labeled');
select * from provedor;

INSERT INTO Producto VALUES('P-PAC II', 'Position Audio Controller II w/ Jack Box', 15.00, 1),('C2213340-5 SR1', 'Dell 23.8 Monitor @ AML', 180.00, 1),('C2213213-3 SR1', 'Speaker USB powered, 3.5mm Audio', 51.00, 1),('C2213150-1 SR1', 'Cyberpower 900VA 120V UPS', 138.95, 1),
('C2213811-2 SR1', 'Network laser color printer', 269.00, 1),('C2213794-8 3YS+', 'Dell T5820 Win10 IOT 2019 LTSC', 7000.00, 2),('C2213452-11 5YS', 'Precision 7780 XCTO BASE', 30.00, 3),
('C2213162-1 SR1', 'Hardened case black', 66.99, 3),('C2213164-1 SR1', 'Optical Mouse', 14.39, 3),('C2214210-1 SR2', 'Guardian Intelligent WorkstationUserCard', 80.00, 3),('C2213660-1 SR1', 'Solacom Mouse Pad', 3.67, 3),('C2213236-2 SR1', 'Mono Headsets (w/o adapter)', 29.19, 3),('C2213876-1 SR1', 'DA80 USB Hdst adapter w volume', 18.55, 3),('B3211264-1 SR1', 'HASP key for stand-alone recording w/w', 23.00, 3),('C3210053-1 SR1', 'Jackbox 4 Assembly Rev A', 18.99, 3),('C2213217-1 SR1', 'RJ45 to RJ45 CABLE 10\'', 10.39, 3),('C2213176-1 SR1', 'USB Programmable 24 key Keypad', 159.55, 3),('C2213735-1 SR1', '10ft USB 2.0 A Male to A Female cable', 6.29, 3),
('C2213911-1 SR1', 'VT4000 Docking Station for Laptop', 35.00, 3),('C2213367-1 SR1', 'USB keyboard & mouse combo', 33.98, 3),
('C2213895-1 SR1', 'Cisco C9200L 24', 1738.35, 4),('B3210506-1 0036', 'Nema 5-15 to C13 AC Cord 3', 8.80, 4),('C2213800-1 SR1', 'Cisco console cable - RJ45m - DB9F 6ft', 6.50, 4),('C2213692-1 0012', 'Cat 6A Shielded Grey Ether Cable (12IN)', 161.98, 4),('C2213490-1 SR1', 'Perle IOLAN STS4-D', 545.28, 5),
('C2213201-1 0012', 'CAT5e unshielded ethernet cable', 143.99, 5),('B2213424-2 SR1', 'DB9 to DB9 Patch Panel', 11.19, 5),
('C3210065-1 SR1', 'Perle IOLAN RJ45 to DB9 Null modem', 4.95, 5),('C3210015-1 0060', 'Cat 6A Shielded Blue Ether Cable (60IN)', 35.99, 5),('B2213412-1 SR1', '1U Rackmount shelf (silver)', 45.49, 5),
('B5100005', 'PTS Handset w/ 15ft cord', 6.90, 5);
select * from Producto;

insert into Solacom values('NSE003','5',10001),('DSE118','5','10002'),('DSE119','5','10003'),('DSE120','5','10004'),('DSE121','5','10005'),
('DSE122','5','10006'),('DSE123','5','10007'),('DSE124','5','10008'),('DSE125','5','10009'),('DSE126','5','10010'),
('DSE127','5','10011'),('DSE128','5','10012'),('DSE129','5','10013'),('DSE130','5','10014'),('DSE131','5','10015'),
('DSE132','5','10016'),('DSE184','5','10017'),('DSE185','5','10018'),('DSE186','5','10019'),('QL002','4','10020');
insert into Solacom values('DS005','4','10022'),('NSE009','3','10023'),('DSE98','2','10024'),('DSE99','1','10025'),('DSE107','1','10026'),
('DSE108','1','10027'),('DSE109','4','10028'),('DSE110','5','10029'),('DSE111','5','10030'),('DSE112','3','10031'),
('DSE113','3','10032'),('DSE114','3','10033'),('DSE115','2','10034'),('DSE116','2','10035'),('DSE117','2','10036'),
('DSE146','2','10037'),('DSE147','2','10038'),('DSE148','1','10039'),('DSE149','3','10040'),('DSE150','4','10041');
insert into Solacom values('DSE151','4',10042),('DSE152','4',10043),('DSE153','5',10044),('DSE154','5',10045),('DSE155','3',10046),
('DSE156','2',10047),('DSE157','2',10048),('DSE158','1',10049),('DSE159','2',10050),('DSE160','3',10051),
('DSE161','3',10052),('DSE162','4',10053),('DSE163','1',10054),('DSE164','1',10055),('DSE165','2',10056),
('DSE166','2',10057),('DSE167','3',10058),('DSE168','3',10059),('DSE169','4',10060),('DSE170','4',10061);
insert into Solacom values('DSE187','4',10062),('DSE188','2',10063),('DSE189','2',10064),('DSE190','3',10065),('NT001','1',10066),
('CSC004','5',10067),('DSE100','5',10068),('DSE101','5',10069),('DSE102','1',10070),('DSE103','1',10071),
('DSE104','1',10072),('DSE105','5',10073),('DSE106','5',10074),('DSE133','1',10075),('DSE134','1',10076),
('DSE135','1',10077),('DSE136','5',10078),('DSE137','1',10079),('DSE138','5',10080),('DSE139','1',10081);
insert into Solacom values('DSE140','1',10102),('DSE141','1',10103),('DSE142','1',10104),('DSE143','1',10105),('DSE144','5',10106),
('DSE145','5',10107),('DSE171','5',10108),('DSE172','5',10109),('DSE173','5',10110),('DSE174','1',10111),
('DSE175','1',10112),('DSE176','5',10113),('DSE177','5',10114),('DSE178','1',10115),('DSE179','1',10116),
('DSE180','5',10117),('DSE181','5',10118),('DSE182','1',10119),('DSE183','1',10120);

describe solacom;
select * from Solacom;

insert into CompraCliente values(101,'DSE109','B2213412-1 SR1',2,'2024-04-12',1),('','DSE109','B2213424-2 SR1',2,'2024-04-12',1),('','DSE109','C2213150-1 SR1',2,'2024-04-12',1),('','DSE109','C2213201-1 0012',2,'2024-04-12',1),('','DSE109','C2213794-8 3YS+',2,'2024-04-12',1),
('','DSE109','C2213876-1 SR1',2,'2024-04-12',1),('','DSE109','B2213412-1 SR1',2,'2024-06-12',1),('','DSE109','B2213424-2 SR1',2,'2024-06-12',1),('','DSE109','C2213150-1 SR1',2,'2024-06-12',1),('','DSE109','C2213201-1 0012',2,'2024-06-12',1),
('','DSE109','C2213794-8 3YS+',2,'2024-06-12',1),('','DSE109','C2213876-1 SR1',2,'2024-06-12',1),('','DSE109','C2213811-2 SR1',2,'2024-06-12',1),('','DSE109','C3210053-1 SR1',2,'2024-06-12',1),('','DSE109','C2213895-1 SR1',2,'2024-06-12',1);
insert into CompraCliente values('','DS005','C2213490-1 SR1',3,'2024-03-12',1),('','DS005','C2213692-1 0012',3,'2024-03-12',1),('','DS005','C2213895-1 SR1',3,'2024-03-12',1),('','DS005','C2213735-1 SR1',3,'2024-03-12',1),('','DS005','C2213213-3 SR1',3,'2024-03-12',1),
('','DS005','C2213811-2 SR1',3,'2024-03-12',1),('','DS005','C2213490-1 SR1',3,'2024-05-12',1),('','DS005','C2213692-1 0012',3,'2024-05-12',1),('','DS005','C2213895-1 SR1',3,'2024-05-12',1),('','DS005','C2213735-1 SR1',3,'2024-05-12',1),('','DS005','C2213213-3 SR1',3,'2024-05-12',1),
('','DS005','C2213811-2 SR1',3,'2024-05-12',1),('','DS005','C2213800-1 SR1',3,'2024-05-12',1),('','DS005','C2213735-1 SR1',3,'2024-05-12',1),('','DS005','B2213412-1 SR1',3,'2024-05-12',1),('','DS005','B3210506-1 0036',3,'2024-05-12',1);
insert into CompraCliente values('','DSE181','B2213424-2 SR1',2,'2024-06-15',1),('','DSE181','C2213735-1 SR1',2,'2024-06-15',1),('','DSE181','B3210506-1 0036',2,'2024-06-15',1),('','DSE181','C2213692-1 0012',2,'2024-06-15',1),('','DSE181','C2213794-8 3YS+',2,'2024-06-15',1),
('','DSE181','B2213424-2 SR1',2,'2024-08-15',1),('','DSE181','C2213735-1 SR1',2,'2024-08-15',1),('','DSE181','B3210506-1 0036',2,'2024-08-15',1),('','DSE181','C2213692-1 0012',2,'2024-08-15',1),('','DSE181','C2213794-8 3YS+',2,'2024-08-15',1);
insert into CompraCliente values('','DSE141','B2213412-1 SR1',1,'2024-07-21',1),('','DSE141','C2213150-1 SR1',1,'2024-07-21',1),('','DSE141','B3210506-1 0036',1,'2024-07-21',1),('','DSE141','C2213800-1 SR1',1,'2024-07-21',1),('','DSE141','C2213794-8 3YS+',1,'2024-07-21',1),
('','DSE141','B2213412-1 SR1',1,'2024-09-21',1),('','DSE141','C2213150-1 SR1',1,'2024-09-21',1),('','DSE141','B3210506-1 0036',1,'2024-09-21',1),('','DSE141','C2213800-1 SR1',1,'2024-09-21',1),('','DSE141','C2213794-8 3YS+',1,'2024-09-21',1);
insert into CompraCliente values('','QL002','C2213201-1 0012',2,'2024-10-24',1),('','QL002','C2213735-1 SR1',2,'2024-10-24',1),('','QL002','C2213800-1 SR1',2,'2024-10-24',1),('','QL002','B2213412-1 SR1',2,'2024-10-24',1),('','QL002','B3210506-1 0036',2,'2024-10-24',1);
insert into CompraCliente values('','NSE009','C2213794-8 3YS+',3,'2024-11-30',1),('','NSE009','C2213895-1 SR1',3,'2024-11-30',1),('','NSE009','C2213811-2 SR1',3,'2024-11-30',1),('','NSE009','B2213412-1 SR1',3,'2024-11-30',1);
select * from CompraCliente;

delete from CompraCliente where IdCompra >152;
delete from CompraCliente where 115 < IdCompra and IdCompra < 133;

insert into CompraProvedor values(501,'1','B2213412-1 SR1',2,'2024-04-12',1),('502','1','B2213424-2 SR1',2,'2024-04-12',1),('503','1','C2213150-1 SR1',2,'2024-04-12',1),('504','1','C2213201-1 0012',2,'2024-04-12',1),('505','1','C2213794-8 3YS+',2,'2024-04-12',1),
('506','1','C2213876-1 SR1',2,'2024-04-12',1),('507','1','B2213412-1 SR1',2,'2024-06-12',1),('508','1','B2213424-2 SR1',2,'2024-06-12',1),('509','1','C2213150-1 SR1',2,'2024-06-12',1),('510','1','C2213201-1 0012',2,'2024-06-12',1),
('511','1','C2213794-8 3YS+',2,'2024-06-12',1),('512','1','C2213876-1 SR1',2,'2024-06-12',1),('513','1','C2213811-2 SR1',2,'2024-06-12',1),('514','1','C3210053-1 SR1',2,'2024-06-12',1),('515','1','C2213895-1 SR1',2,'2024-06-12',1);
insert into CompraProvedor values('516','2','C2213490-1 SR1',3,'2024-03-12',1),('517','2','C2213692-1 0012',3,'2024-03-12',1),('518','2','C2213895-1 SR1',3,'2024-03-12',1),('519','2','C2213735-1 SR1',3,'2024-03-12',1),('520','2','C2213213-3 SR1',3,'2024-03-12',1),
('521','2','C2213811-2 SR1',3,'2024-03-12',1),('522','2','C2213490-1 SR1',3,'2024-05-12',1),('523','2','C2213692-1 0012',3,'2024-05-12',1),('524','2','C2213895-1 SR1',3,'2024-05-12',1),('525','2','C2213735-1 SR1',3,'2024-05-12',1),('526','2','C2213213-3 SR1',3,'2024-05-12',1),
('527','2','C2213811-2 SR1',3,'2024-05-12',1),('528','2','C2213800-1 SR1',3,'2024-05-12',1),('529','2','C2213735-1 SR1',3,'2024-05-12',1),('530','2','B2213412-1 SR1',3,'2024-05-12',1),('531','2','B3210506-1 0036',3,'2024-05-12',1);
insert into CompraProvedor values('532','3','B2213424-2 SR1',2,'2024-06-15',1),('533','3','C2213735-1 SR1',2,'2024-06-15',1),('534','3','B3210506-1 0036',2,'2024-06-15',1),('535','3','C2213692-1 0012',2,'2024-06-15',1),('536','3','C2213794-8 3YS+',2,'2024-06-15',1),
('537','3','B2213424-2 SR1',2,'2024-08-15',1),('538','3','C2213735-1 SR1',2,'2024-08-15',1),('539','3','B3210506-1 0036',2,'2024-08-15',1),('540','3','C2213692-1 0012',2,'2024-08-15',1),('541','3','C2213794-8 3YS+',2,'2024-08-15',1);
insert into CompraProvedor values('542','4','B2213412-1 SR1',1,'2024-07-21',1),('543','4','C2213150-1 SR1',1,'2024-07-21',1),('544','4','B3210506-1 0036',1,'2024-07-21',1),('545','4','C2213800-1 SR1',1,'2024-07-21',1),('546','4','C2213794-8 3YS+',1,'2024-07-21',1),
('547','4','B2213412-1 SR1',1,'2024-09-21',1),('548','4','C2213150-1 SR1',1,'2024-09-21',1),('549','4','B3210506-1 0036',1,'2024-09-21',1),('550','4','C2213800-1 SR1',1,'2024-09-21',1),('551','4','C2213794-8 3YS+',1,'2024-09-21',1);
insert into CompraProvedor values('552','5','C2213201-1 0012',2,'2024-10-24',1),('553','5','C2213735-1 SR1',2,'2024-10-24',1),('554','5','C2213800-1 SR1',2,'2024-10-24',1),('555','5','B2213412-1 SR1',2,'2024-10-24',1),('556','5','B3210506-1 0036',2,'2024-10-24',1);

select * from Cliente;
select * from CompraCliente;
select * from CompraProvedor;
select * from Producto;
select * from Provedor;
select * from Servicio;
select * from Solacom;
call ObtenerFacturaCompraProvedor('1');
call ObtenerFacturaCompra('DSE109');
SELECT C.DireccionCliente , P.NombreProvedor AS NombreProveedor, G.EstadoCompra AS Compra
FROM CompraCliente G
JOIN Cliente C ON G.IdClienteFK = C.IdCliente
JOIN Provedor P ON G.HarmonizedCodeFK = P.NombreProducto
WHERE G.FechaCompraCliente = '2024-09-21';
delete from Cliente where IdCliente = 'DSE99';
use solacom;
create view ConsultarCliente as select * from Cliente;
create view ConsultarProducto as select * from Producto;
create view ConsultarServicio as select * from Servicio;

select IdCliente,NombreCliente from Cliente where Correo like '%gmail%';


