CREATE DATABASE Pubs;

use Pubs;

CREATE TABLE Localidad(
	codigo_localidad INT NOT NULL,
	nombre NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_Localidad_codigo_localidad PRIMARY KEY(codigo_localidad)
);

CREATE TABLE Pub(
	codigo NVARCHAR (255) NOT NULL,
	licencia_fiscal NVARCHAR (255) NOT NULL,
	domicilio NVARCHAR (255),
	fecha_apertura DATE NOT NULL,
	horario NVARCHAR(255) NOT NULL,
	codigo_localidad INT NOT NULL,

	CONSTRAINT pk_Pub_codigo PRIMARY KEY (codigo),
	CONSTRAINT ch_Pub_horario CHECK(horario IN('HORARIO1', 'HORARIO2', 'HORARIO3')),
	CONSTRAINT fk_Pub_coddigo_localidad FOREIGN KEY (codigo_localidad) REFERENCES Localidad(codigo_localidad)
);