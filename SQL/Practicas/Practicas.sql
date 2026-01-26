-- Eliminar la base de datos ventas si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'ventas')
BEGIN
    DROP DATABASE ventas;
END;

-- Crear y usar la base de datos ventas
CREATE DATABASE ventas;
USE ventas;
GO

-- Crear la tabla cliente
CREATE TABLE cliente (
    id INT IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    apellido1 NVARCHAR(100) NOT NULL,
    apellido2 NVARCHAR(100),
    ciudad NVARCHAR(100),
    categoria INT,
    CONSTRAINT pk_cliente PRIMARY KEY (id),
    CONSTRAINT chk_categoria CHECK (categoria >= 0)
);

-- Crear la tabla comercial
CREATE TABLE comercial (
    id INT IDENTITY(1,1),
    nombre NVARCHAR(100) NOT NULL,
    apellido1 NVARCHAR(100) NOT NULL,
    apellido2 NVARCHAR(100),
    comision FLOAT,
    CONSTRAINT pk_comercial PRIMARY KEY (id),
    CONSTRAINT chk_comision CHECK (comision >= 0)
);

-- Crear la tabla pedido
CREATE TABLE pedido (
    id INT IDENTITY(1,1),
    total FLOAT NOT NULL,
    fecha DATE,
    id_cliente INT NOT NULL,
    id_comercial INT NOT NULL,
    CONSTRAINT pk_pedido PRIMARY KEY (id),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    CONSTRAINT fk_pedido_comercial FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);
GO

SELECT * FROM cliente;

DELETE FROM cliente
WHERE ciudad = 'Sevilla';

DELETE FROM cliente
WHERE apellido2 IS NOT NULL;

DELETE FROM cliente
WHERE (ciudad = 'Almería' OR ciudad = 'Granada') AND (categoria < 300);

-- Insertar datos en la tabla cliente
INSERT INTO cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES ('Aarón', 'Rivero', 'Gómez', 'Almería', 100);
INSERT INTO cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES ('Adela', 'Salas', 'Díaz', 'Granada', 200);
INSERT INTO cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES ('Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL);
INSERT INTO cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES ('Adrián', 'Suárez', NULL, 'Jaén', 300);
INSERT INTO cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES ('Marcos', 'Loyola', 'Méndez', 'Almería', 200);
INSERT INTO cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES ('María', 'Santana', 'Moreno', 'Cádiz', 100);
INSERT INTO cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES ('Pilar', 'Ruiz', NULL, 'Sevilla', 300);
INSERT INTO cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES ('Pepe', 'Ruiz', 'Santana', 'Huelva', 200);
INSERT INTO cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES ('Guillermo', 'López', 'Gómez', 'Granada', 225);
INSERT INTO cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES ('Daniel', 'Santana', 'Loyola', 'Sevilla', 125);

GO