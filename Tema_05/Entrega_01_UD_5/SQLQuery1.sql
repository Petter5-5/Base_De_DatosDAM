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
CREATE PROCEDURE sp_insertarGrado @nombre VARCHAR(100)
AS
BEGIN
	BEGIN TRY
		IF EXISTS((SELECT id FROM grado WHERE nombre = @nombre))
		BEGIN
			;THROW 50017, 'Error: El grado con ese ID ya existe', 1;
		END
			INSERT INTO grado VALUES (@nombre);
	END TRY
	BEGIN CATCH
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END;
GO

EXEC sp_insertarGrado 'Grado en Ingeniería Agrícola (Plan 2015)';
GO
--Ejercicio_05
CREATE PROCEDURE sp_alumanasMatriculadas @asignatura VARCHAR(100)
AS
BEGIN
	IF EXISTS(SELECT id FROM asignatura WHERE nombre = @asignatura)
	BEGIN
		DECLARE @nombre AS VARCHAR(50),
				@apellido1 AS VARCHAR(50),
				@apellido2 AS VARCHAR(50);
		DECLARE cursor_alumnos CURSOR FOR
			SELECT
				nombre,
				apellido1,
				apellido2
			FROM persona
			WHERE id IN 
			(
				SELECT 
					id_alumno
				FROM alumno_se_matricula_asignatura
				WHERE id_asignatura = 
				(
					SELECT
					id
					FROM asignatura
					WHERE nombre = @asignatura
				)
			)
		OPEN cursor_alumnos;
		FETCH NEXT FROM cursor_alumnos INTO @nombre, @apellido1, @apellido2

		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF((SELECT sexo FROM persona WHERE nombre = @nombre AND apellido1 = @apellido1 AND apellido2 = @apellido2) = 'H')
			BEGIN
				PRINT 'Alumno: ' + @nombre + ' ' + @apellido1 + ' ' + @apellido2;  
			END
			ELSE
			BEGIN
				PRINT 'Alumna: ' + @nombre + ' ' + @apellido1 + ' ' + @apellido2;  
			END
			FETCH NEXT FROM cursor_alumnos INTO @nombre, @apellido1, @apellido2;
		END;
		
		CLOSE cursor_alumnos;
		DEALLOCATE cursor_alumnos;
	END
	ELSE
	BEGIN
		;THROW 50003, 'La asignatura especificada no existe.', 1;
	END
END;	
GO

EXEC sp_alumanasMatriculadas 'Cálculo';
--EJercicio_06









































