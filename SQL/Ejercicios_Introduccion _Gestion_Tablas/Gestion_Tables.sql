CREATE DATABASE Mundo;

use Mundo;

--Ejercicio 01

CREATE TABLE Pais(
	idPais INT IDENTITY(1,1),
	nombrePais NVARCHAR(100) NOT NULL,

	CONSTRAINT pk_Pais_idPais PRIMARY KEY(idPais)
);

--Ejercicio 02

CREATE TABLE Region(
	idRegion INT IDENTITY(1,1),
	nombreRegion NVARCHAR (300),
	hemisferioRegion NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_Region_idRegion PRIMARY KEY(idRegion),
	CONSTRAINT ch_Region_idRegion CHECK(hemisferioRegion IN('NORTE', 'SUR'))
);

--Ejercicio 03

ALTER TABLE Pais
ADD CONSTRAINT fk_Region_idRegion FOREIGN KEY (idPais) REFERENCES Pais(idPais);

--Ejercicio 04

ALTER TABLE Pais
ADD CONSTRAINT ch_Pais_nombrePais CHECK(nombrePais IN('Italia', 'China', 'India'));

--Ejercicio 05

CREATE TABLE Trabajo(
	idTrabajo NVARCHAR(10),
	nombreTrabajo NVARCHAR(35) NOT NULL,
	salarioMIN DECIMAL(2,2),
	salarioMaX DECIMAL(2,2),

	CONSTRAINT pk_Trabajo_idTrabajo PRIMARY KEY(idTrabajo),
	CONSTRAINT ch_Trabajo_salarioMax CHECK(SalarioMax BETWEEN 0 AND 25.000)
);

--Ejercicio 06

CREATE TABLE Trabajador(
	idTrabajador NVARCHAR(9),
	nombreTrabajador NVARCHAR(200),
	apellido1Trabajador NVARCHAR(200),
	apellido2Trabajador NVARCHAR(200),
	fechaNacTrabajador DATE NOT NULL,

	CONSTRAINT pk_Trabajador_idTrabajador PRIMARY KEY(idTrabajador)
);

--Ejercicio 07

CREATE TABLE Historial_Trabajo(
	idTrabajador NVARCHAR(9),
	idTrabajo  NVARCHAR(10),
	fecha_comienzo DATE NOT NULL,
	fecha_finalizacion DATE NOT NULL,

	CONSTRAINT fk_Historial_Trabajo_idTrabajador FOREIGN KEY(idTrabajador) REFERENCES Trabajador(idTrabajador) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Historial_Trabajo_idTrabajo FOREIGN KEY(idTrabajo) REFERENCES Trabajo(idTrabajo)ON DELETE CASCADE ON UPDATE CASCADE
);

--Ejercicio 08

AlTER TABLE Pais
ADD CONSTRAINT uq_Pais_nombrePais UNIQUE (nombrePais);

--Ejercicio 09

ALTER TABLE Trabajo
ADD CONSTRAINT DF_salarioMIN DEFAULT 1500 for salarioMIN;