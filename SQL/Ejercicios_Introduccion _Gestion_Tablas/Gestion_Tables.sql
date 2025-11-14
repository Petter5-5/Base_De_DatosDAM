CREATE DATABASE Mundo;

use Mundo;

CREATE TABLE Pais(
	idPais INT IDENTITY(1,1),
	nombrePais NVARCHAR(100) NOT NULL,

	CONSTRAINT pk_Pais_idPais PRIMARY KEY(idPais)
);

CREATE TABLE Region(
	idRegion INT IDENTITY(1,1),
	nombreRegion NVARCHAR (300),
	hemisferioRegion NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_Region_idRegion PRIMARY KEY(idRegion),
	CONSTRAINT ch_Region_idRegion CHECK(tipo IN('NORTE', 'SUR'))
);

ALTER TABLE Pais
ADD CONSTRAINT pk_Region_idRegion FOREIGN KEY (idPais) REFERENCES Pais(idPais);

ALTER TABLE Pais
ADD CONSTRAINT ch_Pais_nombrePais CHECK(tipo IN('Italia', 'China', 'India'));

CREATE TABLE Trabajo(
	idTrabajo NVARCHAR(10),
	nombreTrabajo NVARCHAR(35) NOT NULL,
	salarioMIN DECIMAL(2,2),
	salarioMaX DECIMAL(2,2),

	CONSTRAINT pk_Trabajao_idTrabajo PRIMARY KEY(Trabajo),
	CONSTRAINT ch_Trabajo_salarioMax CHECK(SalarioMax BETWEEN 0 AND 25.000)
);