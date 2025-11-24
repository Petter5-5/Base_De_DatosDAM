CREATE DATABASE Pubs;

use Pubs;

CREATE TABLE Localidad(
	código_localidad INT NOT NULL,
	nombre NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_Localidad_código_localidad PRIMARY KEY(código_localidad)
);

CREATE TABLE Pub(
	codigo NVARCHAR (255) NOT NULL,
	licencia_fiscal NVARCHAR (255) NOT NULL,
	domicilio NVARCHAR (255),
	fecha_apertura DATE NOT NULL,
	horario NVARCHAR(255) NOT NULL,
	código_localidad INT NOT NULL,

	CONSTRAINT pk_Pub_codigo PRIMARY KEY (codigo),
	CONSTRAINT ch_Pub_horario CHECK(horario IN('HORARIO1', 'HORARIO2', 'HORARIO3')),
	CONSTRAINT fk_Pub_código_localidad FOREIGN KEY (código_localidad) REFERENCES Localidad(código_localidad)
);

CREATE TABLE Empleado(
	DNI_empleado NVARCHAR (255) NOT NULL,
	nombre NVARCHAR (255) NOT NULL,
	domicilio NVARCHAR (255),

	CONSTRAINT pk_Empleado_DNI_empleado PRIMARY KEY (DNI_empleado),
);

CREATE TABLE Titular(
	DNI_titular NVARCHAR (255) NOT NULL,
	nombre NVARCHAR (255) NOT NULL,
	domicilio NVARCHAR (255),
	codigo_PUB NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_Titular_DNI_titular PRIMARY KEY (DNI_titular),
	CONSTRAINT fk_Titular_codigo_PUB FOREIGN KEY (codigo_PUB) REFERENCES Pub(codigo),
);

CREATE TABLE Articulo(
	codigo_articulo NVARCHAR (255) NOT NULL,
	nombre NVARCHAR (255) NOT NULL,
	cantidad INT NOT NULL,
	precio DECIMAL (7,2) NOT NULL,
	codigo_PUB NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_Articulo_codigo_articulo PRIMARY KEY (codigo_articulo),
	CONSTRAINT fk_Articulo_codigo_PUB FOREIGN KEY (codigo_PUB) REFERENCES Pub(codigo),
	CONSTRAINT ch_Articulo_precio CHECK(precio > 0)
);

CREATE TABLE Pub_Empleado(
	código_Pub NVARCHAR (255) NOT NULL,
	DNI_empleado NVARCHAR (255) NOT NULL,
	funcion NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_Empleado PRIMARY KEY (código_Pub, DNI_empleado, funcion),
	CONSTRAINT fk_Pub_Empleado_código_pub FOREIGN KEY (código_Pub) REFERENCES Pub(codigo),
	CONSTRAINT fk_Pub_Empleado_DNI_empleado FOREIGN KEY (DNI_empleado) REFERENCES Titular(DNI_titular),
	CONSTRAINT ch_Pub_Empleado_funcion CHECK (funcion IN('PUB_EMPLEADO', 'CAMARERO', 'SEGURIDAD', 'LIMPIEZA'))
);

--Apartado_01
CREATE LOGIN administradorPubsLogin
WITH PASSWORD = 'Contraseña_segura9';

CREATE USER administradorPubs
FOR LOGIN administradorPubsLogin;

--Apartado_02
CREATE USER lectorDatos
WITHOUT LOGIN;

--Apartado_03
GRANT SELECT
ON Localidad
TO lectorDatos;

GRANT SELECT
ON Pub
TO lectorDatos;

GRANT SELECT
ON Articulo
TO lectorDatos;

--Apartado_04
CREATE LOGIN gestorArticulosLogin
WITH PASSWORD = 'Password9';

CREATE USER gestorArticulos
FOR LOGIN gestorArticulosLogin;

GRANT SELECT, UPDATE, INSERT
ON Articulo
TO gestorArticulos;

DENY DELETE
ON Articulo
TO gestorArticulos;

--Apartado_05
CREATE LOGIN gestorEmpleadosLogin
WITH PASSWORD = 'Contraseña_segura10';

CREATE USER gestorEmpleados
FOR LOGIN gestorEmpleadosLogin;

GRANT INSERT, UPDATE, DELETE
ON Empleado
TO gestorEmpleados;

GRANT INSERT, UPDATE, DELETE
ON Pub_Empleado
TO gestorEmpleados;

DENY SELECT
ON Articulo
TO gestorEmpleados;

--Apartado_06
GRANT INSERT, UPDATE, DELETE
ON Pub
TO administradorPubs
WITH GRANT OPTION;

--Apartado_07
REVOKE UPDATE
ON Articulo
TO gestorArticulos;

--Apartado_08
DENY ALL
ON Titular
TO lectorDatos;

--Apartado_09
ALTER USER gestorEmpleados
WITH NAME = encargadoPersonal;

ALTER LOGIN gestorEmpleadosLogin
WITH NAME = gestorPersonalLogin;

--Apartado_10
GRANT ALL
ON Titular
TO administradorPubs;

--Apartado_11
DROP USER lectorDatos;