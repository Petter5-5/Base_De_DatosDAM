CREATE DATABASE Biblioteca;

use Biblioteca;

CREATE TABLE Autor(
	idAutor INT IDENTITY (1,1),
	nombreAutor NVARCHAR (150) NOT NULL,
	nacionalidad NVARCHAR (100),

	CONSTRAINT pk_Autor_idAutor PRIMARY KEY (idAutor)
);

CREATE TABLE Libro(
	idLibro INT IDENTITY (1,1),
	titulo NVARCHAR (200) NOT NULL,
	anioPublicacion INT,
	idAutor INT,
	stock INT,

	CONSTRAINT pk_Libro_idLibro PRIMARY KEY (idLibro),
	CONSTRAINT ch_Libro_anioPublicacion CHECK(anioPublicacion BETWEEN 1500 AND 2025),
	CONSTRAINT fk_Libro_idAutor FOREIGN KEY (idAutor) REFERENCES Autor(idAutor)
);

CREATE TABLE Usuario(
	idUsuario INT IDENTITY (1,1),
	nombreUsuario NVARCHAR (100) NOT NULL,
	correoElectronico NVARCHAR (200) NOT NULL,
	fechaRegistro DATE,

	CONSTRAINT pk_Usuario_idUsuario PRIMARY KEY(idUsuario),
	CONSTRAINT uq_Usuario_correoElectronico UNIQUE (correoElectronico)
);

ALTER TABLE Usuario
ADD CONSTRAINT df_Usuario_fechaRegistro DEFAULT GETDATE() FOR fechaRegistro;

CREATE TABLE Prestamo (
	idPrestamo INT IDENTITY (1,1),
	idUsuario INT,
	idLibro INT,
	fechaInicio DATE NOT NULL,
	fechaFin DATE NOT NULL,

	CONSTRAINT pk_Prestamo_idPrestamo PRIMARY KEY (idPrestamo),
	CONSTRAINT fk_Prestamo_idUsuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario),
	CONSTRAINT fk_Prestamo_idLibro FOREIGN KEY (idLibro) REFERENCES Libro(idLibro),
	CONSTRAINT ch_Prestamo_fechaFin CHECK(fechaFin > fechaInicio)
);