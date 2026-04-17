--Ejercicio_01
CREATE PROCEDURE sp_insertarDepartamento @nombre NVARCHAR(55)
AS
BEGIN
	INSERT INTO departamento VALUES (@nombre);
END;
GO

EXEC sp_insertarDepartamento 'Astrología';
GO

--Ejercicio_02
CREATE PROCEDURE sp_insertarPersona @nif VARCHAR(9), @nombre VARCHAR(25), @apellido1 VARCHAR(50), @apellido2 VARCHAR(50),@ciudad VARCHAR(25), @direccion VARCHAR(50), @telefono VARCHAR(9), @fecha_nac DATE, @sexo CHAR(1), @tipo VARCHAR(10)
AS
BEGIN
	INSERT INTO persona VALUES(@nif, @nombre, @apellido1, @apellido2, @ciudad, @direccion, @telefono, @fecha_nac, @sexo, @tipo);
END;
GO

EXEC sp_insertarPersona '78598889T', 'Yeray', 'Trejo', 'Sanchez', 'Malaga', 'Av.Barcelona.3', '638058904', '2007-1-3', 'H', 'alumno'; 
GO

--Ejercicio_03













