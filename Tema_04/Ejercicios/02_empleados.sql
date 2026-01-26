-- Eliminar la base de datos empleados si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'empleados')
BEGIN
    DROP DATABASE empleados;
END;

-- Crear y usar la base de datos empleados
CREATE DATABASE empleados;
USE empleados;
GO

-- Crear la tabla departamento
CREATE TABLE departamento (
   codigo INT NOT NULL,
   nombre NVARCHAR(255) NOT NULL,
   presupuesto DECIMAL(18, 2) NOT NULL,
   gastos DECIMAL(18, 2) NOT NULL, 
   CONSTRAINT pk_departamento PRIMARY KEY (codigo)
);

-- Crear la tabla empleado
CREATE TABLE empleado (
   dni NVARCHAR(9) NOT NULL,
   nombre NVARCHAR(255) NOT NULL,
   apellidos NVARCHAR(255) NOT NULL,
   departamento INT NOT NULL,
   CONSTRAINT pk_empleado PRIMARY KEY (dni),
   CONSTRAINT fk_departamento_codigo FOREIGN KEY(departamento) REFERENCES departamento(codigo)
);
GO

-- Insertar datos en la tabla departamento
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) VALUES (14, 'IT', 65000, 25800);
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) VALUES (37, 'Accounting', 15000, 2500);
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) VALUES (59, 'Human Resources', 240000, 147500);
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) VALUES (77, 'Research', 55000, 28000);

-- Insertar datos en la tabla empleado
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('12323487A', 'Michael', 'Rogers', 14);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('15293448B', 'Anand', 'Manikutty', 14);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('22236488C', 'Carol', 'Smith', 37);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('32658741D', 'Joe', 'Stevens', 37);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('33215471E', 'Mary-Anne', 'Foster', 14);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('33256984F', 'George', 'O''Donnell', 77);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('54652347G', 'John', 'Doe', 59);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('38382980M', 'David', 'Smith', 77);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('65487321H', 'Zacary', 'Efron', 59);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('74568521I', 'Eric', 'Goldsmith', 59);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('84565724J', 'Elizabeth', 'Doe', 14);
INSERT INTO empleado (dni, nombre, apellidos, departamento) VALUES ('84565724K', 'Kumar', 'Swamy', 14);
GO

--Ejercicio_01
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) 
VALUES (34, 'Super Departamento', 9999999000, 5);

--Ejercicio_02
INSERT INTO empleado (dni, nombre, apellidos, departamento) 
VALUES ('84585724K', 'Marcos', 'Torres', 14);

--Ejercicio_03
CREATE TABLE departamento_backup(
	codigo INT NOT NULL,
   nombre NVARCHAR(255) NOT NULL,
   presupuesto DECIMAL(18, 2) NOT NULL,
   gastos DECIMAL(18, 2) NOT NULL, 

   CONSTRAINT pk_backup_departamento PRIMARY KEY (codigo)
);

-- Insertar datos en la tabla departamento
INSERT INTO departamento_backup (codigo, nombre, presupuesto, gastos) VALUES (14, 'IT', 65000, 25800);
INSERT INTO departamento_backup (codigo, nombre, presupuesto, gastos) VALUES (37, 'Accounting', 15000, 2500);
INSERT INTO departamento_backup (codigo, nombre, presupuesto, gastos) VALUES (59, 'Human Resources', 240000, 147500);
INSERT INTO departamento_backup (codigo, nombre, presupuesto, gastos) VALUES (77, 'Research', 55000, 28000);
INSERT INTO departamento_backup (codigo, nombre, presupuesto, gastos) 
VALUES (34, 'Super Departamento', 9999999000, 5);

SELECT * FROM departamento;

--Ejercicio_04
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) 
VALUES (55, 'Estadística', 34, 3);

DELETE FROM departamento 
WHERE nombre = 'Estadística';

--Ejercicio_05
ALTER TABLE empleado
DROP CONSTRAINT fk_departamento_codigo;

ALTER TABLE empleado
ADD CONSTRAINT fk_departamento_codigo 
FOREIGN KEY(departamento) 
REFERENCES departamento(codigo)
ON DELETE CASCADE;

DELETE FROM departamento
WHERE nombre = 'IT';

--Ejercicio_06
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) 
VALUES (14, 'IT', 65000, 25800);

UPDATE departamento
SET codigo = 30
WHERE nombre = 'IT';

--Ejercicio_07
INSERT INTO departamento (codigo, nombre, presupuesto, gastos) 
VALUES (55, 'Estadística', 34, 3);

UPDATE departamento
SET codigo = 40
WHERE nombre = 'Estadística';

--Ejercicio_08
BEGIN TRY
	BEGIN TRAN
		UPDATE departamento
		SET presupuesto += 50000
		WHERE presupuesto < 20000;
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF XACT_STATE() <> 0
		ROLLBACK TRAN;
	THROW;
END CATCH
