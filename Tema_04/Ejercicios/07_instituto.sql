-- Eliminar la base de datos instituto si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'instituto')
BEGIN
    DROP DATABASE instituto;
END;

-- Crear y usar la base de datos instituto
CREATE DATABASE instituto;
USE instituto;
GO

-- Creación de la tabla alumno
CREATE TABLE alumno (
    id INT IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    apellido1 NVARCHAR(100) NOT NULL,
    apellido2 NVARCHAR(100),
    fecha_nacimiento DATE NOT NULL,
    es_repetidor NVARCHAR(2) NOT NULL,
    telefono NVARCHAR(9),
    CONSTRAINT pk_alumno PRIMARY KEY (id),
    CONSTRAINT ck_alumno_es_repetidor CHECK (es_repetidor IN ('sí', 'no'))
);
GO

-- Insertar datos en la tabla alumno
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, telefono) VALUES 
('María', 'Sánchez', 'Pérez', '1990-12-01', 'no', NULL),
('Juan', 'Sáez', 'Vega', '1998-04-02', 'no', '618253876'),
('Pepe', 'Ramírez', 'Gea', '1988-01-03', 'no', NULL),
('Lucía', 'Sánchez', 'Ortega', '1993-06-13', 'sí', '678516294'),
('Paco', 'Martínez', 'López', '1995-11-24', 'no', '692735409'),
('Irene', 'Gutiérrez', 'Sánchez', '1991-03-28', 'sí', NULL),
('Cristina', 'Fernández', 'Ramírez', '1996-09-17', 'no', '628349590'),
('Antonio', 'Carretero', 'Ortega', '1994-05-20', 'sí', '612345633'),
('Manuel', 'Domínguez', 'Hernández', '1999-07-08', 'no', NULL),
('Daniel', 'Moreno', 'Ruiz', '1998-02-03', 'no', NULL);
GO

SELECT * FROM alumno;

--Ejercicio_01
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, telefono) 
VALUES ('Laura', 'Gómez', 'García', '2000-3-15', 'no', '692735409');

--Ejercicio_02
DELETE FROM alumno
WHERE telefono = '692735409';

--Ejercicio_03
UPDATE alumno
SET es_repetidor = 'no'
WHERE nombre = 'Irene' AND apellido1 = 'Gutiérrez' AND apellido2 = 'Sánchez';

--Ejercicio_04
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, telefono) 
VALUES ('Carlos', 'López', 'Martínez', '1997-5-10', 'sí', NULL);

--Ejercicio_05
DELETE FROM alumno
WHERE id = 3;

--Ejercicio_06
UPDATE alumno
SET telefono = '699123456'
WHERE nombre = 'Cristina' AND apellido1 = 'Fernández' AND apellido2 = 'Ramírez';

--Ejercicio_07
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, telefono) 
VALUES ('Raúl', 'Sánchez', 'Ruiz', '1995-12-25', 'no', '622345678');

--Ejercicio_08

BEGIN TRY
	BEGIN TRAN

	DELETE FROM alumno
	WHERE telefono IS NULL;

	COMMIT TRAN
END TRY
BEGIN CATCH
	IF XACT_STATE() <> 0
		ROLLBACK TRAN;
	THROW
END CATCH

--Ejericicio_09
UPDATE alumno
SET apellido1 = 'Sancho'
WHERE apellido1 = 'Sánchez';

--Ejercicio_10
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, telefono) 
VALUES ('Ana', 'Torres', 'García', '1999-11-30', 'sí', '687654321');

--Ejercicio_11
DELETE FROM alumno
WHERE es_repetidor = 'sí';

--Ejercicio_12
BEGIN TRY
	BEGIN TRAN
	
	UPDATE alumno
	SET nombre = 'David'
	WHERE ID = 10;

	COMMIT TRAN
END TRY
BEGIN CATCH
	IF XACT_STATE() <> 0
		ROLLBACK TRAN;
	THROW;
END CATCH

--Ejercicio_13
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, telefono) 
VALUES ('Marta', 'Pérez', 'López', '1993-8-20', 'no', '634567890');

--Ejercicio_14
DELETE FROM alumno
WHERE fecha_nacimiento BETWEEN '1900-01-01' AND '1990-01-01';

--Ejercicio_15
UPDATE alumno
SET telefono = '600000000'
WHERE telefono IS NULL;

--Ejercicio_16
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, telefono) 
VALUES ('Javier', 'Rodríguez', 'García', '1992-01-05', 'no', NULL);

--Ejercicio_17
DELETE FROM alumno
WHERE nombre = 'Antonio';

--Ejercicio_18
UPDATE alumno
SET es_repetidor = 'sí'
WHERE fecha_nacimiento BETWEEN '1995-01-01' AND '2077-01-01';

--Ejercicio_19
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, telefono) 
VALUES ('Sofía', 'Martínez', 'Ruiz', '1998-10-010', 'sí', '609876543');

--Ejercicio_20
DELETE FROM alumno
WHERE apellido2 = 'Ortega';

----------
--SELECT--
----------

--Ejercicio_01
SELECT *
FROM alumno
WHERE id = 1;

--Ejercicio_02
SELECT * 
FROM alumno
WHERE telefono = 692735409;

--Ejercicio_03
SELECT * 
FROM alumno
WHERE es_repetidor = 'sí';

--Ejercicio_04
SELECT * 
FROM alumno
WHERE es_repetidor = 'no';

--Ejercicio_05
SELECT * 
FROM alumno
WHERE fecha_nacimiento BETWEEN '1900-01-01' AND '1993-01-01';

--Ejercicio_06
SELECT * 
FROM alumno
WHERE fecha_nacimiento BETWEEN '1994-01-01' AND '2077-01-01';

--Ejercicio_07
SELECT * 
FROM alumno
WHERE (fecha_nacimiento BETWEEN '1994-01-01' AND '2077-01-01') AND es_repetidor = 'no';

--Ejercicio_08
SELECT * 
FROM alumno
WHERE fecha_nacimiento BETWEEN '1998-01-01' AND '1998-12-12';

--Ejercicio_09
SELECT * 
FROM alumno
WHERE (fecha_nacimiento BETWEEN '1900-01-01' AND '1997-12-12') OR (fecha_nacimiento BETWEEN '1999-01-01' AND '2077-01-01');

--Ejercicio_10
SELECT * 
FROM alumno
WHERE fecha_nacimiento BETWEEN '1998-01-01' AND '1998-05-31';

--Ejercicio_11
SELECT nombre AS Nombre ,REVERSE(nombre) AS Nombre_Invertido
FROM alumno;

--Ejercicio_12
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS Nombre_Completo, REVERSE(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS Nombre_Completo_Invertido
FROM alumno;

--Ejercicio_13
SELECT UPPER(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS Nombre_Completo_Mayúsculas, LOWER(REVERSE(CONCAT(nombre, ' ', apellido1, ' ', apellido2))) AS Nombre_Completo_Invertido_Minúsculas
FROM alumno;

--Ejercicio_14
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS Nombre_Completo, LEN(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS Numero_Caracteres
FROM alumno;

--Ejercicio_15
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS Nombre_Completo, LOWER(CONCAT(nombre, '.', apellido1, '@ies.org')) AS Numero_Caracteres
FROM alumno;

--Ejercicio_16
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS Nombre_Completo, LOWER(CONCAT(nombre, '.', apellido1, '@ies.org')) AS Numero_Caracteres, CONCAT(REVERSE(nombre), SUBSTRING(CAST(fecha_nacimiento AS NVARCHAR), 1, 4)) AS Contraseña
FROM alumno;

--Ejercicio_17
SELECT fecha_nacimiento AS Fecha_Completa, SUBSTRING(CAST(fecha_nacimiento AS NVARCHAR),9, 10) AS Dia, SUBSTRING(CAST(fecha_nacimiento AS NVARCHAR), 6, 7) AS Mes, SUBSTRING(CAST(fecha_nacimiento AS NVARCHAR),1, 4) AS Año
FROM alumno;




