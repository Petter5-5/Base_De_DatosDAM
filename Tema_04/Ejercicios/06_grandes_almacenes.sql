-- Eliminar la base de datos grandes_almacenes si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'grandes_almacenes')
BEGIN
    DROP DATABASE grandes_almacenes;
END;

-- Crear y usar la base de datos grandes_almacenes
CREATE DATABASE grandes_almacenes;
USE grandes_almacenes;
GO

-- Creación de la tabla cajero
CREATE TABLE cajero (
   codigo INT NOT NULL,
   nombrecompleto NVARCHAR(255) NOT NULL,
   CONSTRAINT pk_cajero PRIMARY KEY (codigo)
);

-- Creación de la tabla producto
CREATE TABLE producto (
   codigo INT NOT NULL,
   nombre NVARCHAR(100) NOT NULL,
   precio INT,
   CONSTRAINT pk_producto PRIMARY KEY (codigo)
);

-- Creación de la tabla maquina_registradora
CREATE TABLE maquina_registradora (
   codigo INT NOT NULL,
   piso INT,
   CONSTRAINT pk_maquina_registradora PRIMARY KEY (codigo)
);

-- Creación de la tabla venta
CREATE TABLE venta (
   cajero INT NOT NULL,
   maquina INT NOT NULL,
   producto INT NOT NULL,
   CONSTRAINT pk_venta PRIMARY KEY (cajero, maquina, producto),
   CONSTRAINT fk_venta_cajero FOREIGN KEY (cajero) REFERENCES cajero(codigo),
   CONSTRAINT fk_venta_maquina FOREIGN KEY (maquina) REFERENCES maquina_registradora(codigo),
   CONSTRAINT fk_venta_producto FOREIGN KEY (producto) REFERENCES producto(codigo)
);
GO

-- Insertar datos en la tabla cajero
INSERT INTO cajero(codigo, nombrecompleto) 
VALUES (1, 'Michael Rogers'),
       (2, 'Anand Manikutty'),
       (3, 'Carol Smith'),
       (5, 'Mary-Anne Foster'),	
       (6, 'George ODonnell'),
       (7, 'John Doe'),
       (8, 'David Smith'),
       (9, 'Zacary Efron'),
       (10, 'Eric Goldsmith'),
       (11, 'Elizabeth Doe'),
       (12, 'Kumar Swamy'),
       (13, 'Alice Johnson'),
       (14, 'Bob Brown'),
       (15, 'Cathy White'),
       (16, 'Daniel Green'),
       (17, 'Eva Black'),
       (18, 'Frank Blue'),
       (19, 'Grace Yellow'),
       (20, 'Henry Gray'),
       (21, 'Ivy Pink'),
       (22, 'Jack Orange'),
       (23, 'Kathy Purple'),
       (24, 'Leo Cyan'),
       (25, 'Mona Magenta'),
       (26, 'Nina Teal'),
       (27, 'Oscar Brown'),
       (28, 'Paul Red'),
       (29, 'Quinn Silver'),
       (30, 'Rita Gold');

-- Insertar datos en la tabla producto
INSERT INTO producto(codigo, nombre, precio)
VALUES (1, 'Smartphone Samsung Galaxy S21', 799),
       (2, 'Laptop HP Pavilion', 999),
       (3, 'Televisor LG 55" 4K', 599),
       (4, 'Refrigerador Samsung 350L', 1200),
       (5, 'Camiseta Nike Dri-FIT', 29),
       (6, 'Zapatillas Adidas Running', 85),
       (7, 'Audífonos Sony WH-1000XM4', 299),
       (8, 'Promo reloj Apple Watch Series 6', 399),
       (9, 'Tablet Amazon Fire 7', 49),
       (10, 'Microondas Panasonic Inverter Premium', 149),
       (11, 'Colchón Memory Foam King Size', 600),
       (12, 'Lavadora LG 15 kg', 800),
       (13, 'Guitarra Fender Stratocaster', 699),
       (14, 'Juguete LEGO Star Wars', 99),
       (15, 'Cafetera Nespresso Vertuo', 199),
       (16, 'Bicicleta Montaña Trek', 1200),
       (17, 'Perfume Especial Chanel N°5', 115),
       (18, 'Aspiradora Dyson V11', 499),
       (19, 'Router Wi-Fi TP-Link AX6000', 250),
       (20, 'Silla Gamer Razer Iskur', 400),
       (21, 'Licuadora Oster Pro', 89),
       (22, 'Parrilla Eléctrica George Foreman', 69),
       (23, 'Promo camisa Casual Tommy Hilfiger', 55),
       (24, 'Premium Cámara Canon EOS Rebel T7', 450),
       (25, 'Maleta Samsonite Spinner', 120),
       (26, 'Purificador de Aire Philips', 199),
       (27, 'Plancha Premium de Vapor Rowenta', 60),
       (28, 'Promo juego de Ollas T-fal', 75),
       (29, 'Tostadora Hamilton Beach', 30),
       (30, 'Hervidor de Agua Eléctrico Cuisinart', 40);

-- Insertar datos en la tabla maquina_registradora
INSERT INTO maquina_registradora(codigo, piso)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 6),
       (7, 7),
       (8, 8),
       (9, 9),
       (10, 10),
       (11, 11),
       (12, 12),
       (13, 13),
       (14, 14),
       (15, 15),
       (16, 16),
       (17, 17),
       (18, 18),
       (19, 19),
       (20, 20),
       (21, 21),
       (22, 22),
       (23, 23),
       (24, 24),
       (25, 25),
       (26, 26),
       (27, 27),
       (28, 28),
       (29, 29),
       (30, 30);

-- Insertar datos en la tabla venta
INSERT INTO venta(cajero, maquina, producto)
VALUES (1, 1, 1),
       (1, 1, 2),
       (2, 12, 1),
       (2, 12, 2),
       (2, 12, 3),
       (3, 13, 4),
       (3, 14, 5),
       (4, 15, 6),
       (4, 15, 7),
       (5, 11, 8),
       (5, 10, 9),
       (6, 1, 10),
       (6, 2, 11),
       (7, 3, 12),
       (7, 4, 13),
       (8, 5, 14),
       (9, 6, 15),
       (10, 7, 16),
       (11, 8, 17),
       (12, 9, 18),
       (13, 10, 19),
       (14, 11, 20),
       (15, 12, 21),
       (16, 13, 22),
       (17, 14, 23),
       (18, 15, 24),
       (19, 16, 25),
       (20, 17, 26),
       (21, 18, 27),
       (22, 19, 28),
       (23, 20, 29),
       (24, 21, 30);
GO

SELECT * FROM producto;

--Ejercicio_01
DELETE FROM venta
WHERE cajero = 1;

DELETE FROM cajero
WHERE codigo = 1;

--Ejercicio_02
ALTER TABLE venta
DROP CONSTRAINT fk_venta_producto;

ALTER TABLE venta
ADD CONSTRAINT fk_venta_producto
FOREIGN KEY (producto)
REFERENCES producto(codigo) 
ON DELETE CASCADE;

DELETE FROM producto
WHERE precio > 100;

--Ejercicio_03
DELETE FROM maquina_registradora
WHERE piso = 2;

--Ejercicio_04
DELETE FROM venta
WHERE cajero = 2;

--Ejercicio_05
BEGIN TRY
	BEGIN TRAN
		
		DELETE FROM producto
		WHERE nombre LIKE 'C%';
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF XACT_STATE() <> 0
		ROLLBACK TRAN;
	THROW;
END CATCH;

--Ejercicio_06
DELETE FROM cajero
WHERE nombrecompleto LIKE 'Kumar%';

--Ejercicio_07
DELETE FROM producto
WHERE precio BETWEEN 50 AND 150;

--Ejercicio_08
DELETE FROM maquina_registradora
WHERE piso BETWEEN 3 AND 4;

--Ejercicio_09
DELETE FROM venta
WHERE producto = 5 OR maquina = 3;

--Ejercicio_10
ALTER TABLE venta
DROP CONSTRAINT fk_venta_cajero;

ALTER TABLE venta
ADD CONSTRAINT fk_venta_cajero
FOREIGN KEY (cajero)
REFERENCES cajero (codigo)
ON DELETE CASCADE;

DELETE FROM cajero
WHERE codigo < 10 AND NOT nombrecompleto LIKE 'Joe%';

--Ejercicio_11
DELETE FROM producto
WHERE precio != 200

--Ejercico_12
DELETE FROM maquina_registradora
WHERE piso < 2;

--Ejercicio_13
DELETE FROM producto
WHERE nombre LIKE '%X'

--Ejercicio_14
UPDATE producto
SET precio = 120
WHERE codigo = 1;

--Ejercicio_15
UPDATE cajero
SET nombrecompleto = 'María López'
WHERE codigo = 2;

--Ejercio_16
UPDATE maquina_registradora
SET piso = 2
WHERE codigo = 3;

--Ejercicio_17
UPDATE producto
SET precio = precio + 10;

--Ejercicio_18
UPDATE producto
SET nombre = 'Oferta'
WHERE nombre LIKE 'Promo%';

--Ejercicio_19
UPDATE cajero
SET nombrecompleto = nombrecompleto + ' Pérez'
WHERE nombrecompleto LIKE 'F%';

--Ejercicio_20
UPDATE producto
SET precio = precio - (precio * 0.1)
WHERE precio BETWEEN 50 AND 100;

--Ejercicio_21
UPDATE producto
SET precio = precio + 15
WHERE nombre LIKE 'Premium%';

--Ejercicio_22
UPDATE cajero
SET nombrecompleto = nombrecompleto + ' (Senior)'
WHERE codigo > 10;

--Ejercicio_23
UPDATE producto
SET precio = precio + 20
WHERE codigo < 10 OR nombre LIKE '%Especial%'

--Ejercicio_24
UPDATE producto
SET precio = 3000
WHERE codigo BETWEEN 5 AND 10;

--Ejercicio_25
UPDATE producto
SET nombre = nombre + ' - EN descuento'
WHERE precio < 30;