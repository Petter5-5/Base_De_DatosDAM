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
GO
CREATE PROCEDURE sp_asignarProfesor @nombre VARCHAR(25), @apellido1 VARCHAR(50), @apellido2 VARCHAR(50), @departamento VARCHAR(50)
AS
BEGIN
	IF EXISTS(SELECT id FROM persona WHERE nombre = @nombre AND apellido1 = @apellido1 AND apellido2 = @apellido2)
	BEGIN
		IF EXISTS(SELECT id FROM departamento WHERE nombre = @departamento)
		BEGIN
			INSERT INTO profesor VALUES ((SELECT id FROM persona WHERE nombre = @nombre), (SELECT id FROM departamento WHERE nombre = @departamento));
			IF((SELECT sexo FROM persona WHERE nombre = @nombre) = 'H')
			BEGIN
				PRINT 'El profesor ha sido asignado al departamento correctamente.';
			END
			ELSE
			BEGIN
				PRINT 'La profesora ha sido asignado al departamento correctamente.';
			END
		END
		ELSE
		BEGIN
			;THROW 50015, 'El departamento no existe en la base de datos.', 1;
		END
	END 
	ELSE
	BEGIN
		;THROW 50016, 'La persona no existe en la base de datos o no es profesor/a', 1;
	END
END;
GO

EXEC sp_asignarProfesor 'dw', 'aw', 'dwa', 'Derecho';
GO
--Ejercicio_04
CREATE PROCEDURE sp_insertarGrado @nombre
AS
BEGIN
	BEGIN TRY
		
	END TRY
	BEGIN CATCH
		
	END CATCH
END;
GO

EXEC sp_insertarGrado 'Grado en Ingeniería Agrícola (Plan 2015)';



