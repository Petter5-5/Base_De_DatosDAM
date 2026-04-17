--Ejercicio_01
DECLARE @var1 AS NVARCHAR(255);
SET @var1 = '¡Hola mundo!';
SELECT @var1;
--Ejercicio_02
DECLARE @var2 AS FLOAT = -2;
IF @var2 >= 0
BEGIN
	SELECT ('Este número es positivo') AS INFO, @var2 AS Numero
END
ELSE
	SELECT ('Este número es negativo') AS INFO, @var2 AS Numero
--Ejercicio_03
DECLARE @var3 AS NVARCHAR(55);
DECLARE @var4 AS FLOAT = 1;
IF @var4 > 0
BEGIN
	SET @var3 = 'positivo';	
END
ELSE IF @var4 < 0
BEGIN
	SET @var3 = 'negativo';
END
ELSE
BEGIN
	SET @var3 = 'cero';
END
SELECT @var3 AS RESPUESTA;

--Ejercicio_04
DECLARE @var5 AS FLOAT = 4.999999999;
IF @var5 >= 0 AND @var5 < 5
	SELECT ('Insuficiente') AS INFO, @var5 AS NOTA
ELSE IF @var5 >= 5 AND @var5 < 6
	SELECT ('Aprobado') AS INFO, @var5 AS NOTA
ELSE IF @var5 >= 5 AND @var5 < 7
	SELECT ('Bien') AS INFO, @var5 AS NOTA
ELSE IF @var5 >= 7 AND @var5 < 9
	SELECT ('Notable') AS INFO, @var5 AS NOTA
ELSE IF @var5 >= 9 AND @var5 < 10
	SELECT ('Sobresaliente') AS INFO, @var5 AS NOTA
ELSE
	SELECT ('Nota no es válida') AS INFO, @var5 AS NOTA

--Ejercicio_05
DECLARE @var6 AS FLOAT = 4.999999999;
DECLARE @var7 AS NVARCHAR(55);
IF @var6 >= 0 AND @var6 < 5
	SET @var7 = 'Insuficiente';	
ELSE IF @var6 >= 5 AND @var6 < 6
	SET @var7 = 'Aprobado';	
ELSE IF @var6 >= 5 AND @var6 < 7
	SET @var7 = 'Bien';	
ELSE IF @var6 >= 7 AND @var6 < 9
	SET @var7 = 'Notable';	
ELSE IF @var6 >= 9 AND @var6 < 10
	SET @var7 = 'Sobresaliente';	
ELSE
	SET @var7 = 'La nota no es válida';
SELECT @var7 AS INFO, @var6 AS NOTA

--Ejercicio_06
DECLARE @var8 AS FLOAT = 7.43694;
DECLARE @var9 AS NVARCHAR(55);
SET @var9 = CASE
	WHEN @var8 >= 0 AND @var8 < 5 THEN 'Insuficiente'
	WHEN @var8 >= 5 AND @var8 < 6 THEN 'Aprobado'
	WHEN @var8 >= 5 AND @var8 < 7 THEN 'Bien'
	WHEN @var8 >= 7 AND @var8 < 9 THEN 'Notable'
	WHEN @var8 >= 9 AND @var8 < 10 THEN 'Sobresaliente'
	ELSE 'Nota no es válida'
END;

SELECT @var9 AS INFO, @var8 AS NOTA 

--Ejercicio_07
GO
CREATE FUNCTION dbo.semana(@dia INT)
RETURNS NVARCHAR(55)
AS
BEGIN
	DECLARE @var10 NVARCHAR(55);
	SET @var10 = CASE @dia
		WHEN 1 THEN 'Lunes'
		WHEN 2 THEN 'Martes'
		WHEN 3 THEN 'Miercoles'
		WHEN 4 THEN 'Jueves'
		WHEN 5 THEN 'Viernes'
		WHEN 6 THEN 'Sábado'
		WHEN 7 THEN 'Domingo'
		ELSE'Número no válido'
	END;
	RETURN @var10;
END;
GO

DECLARE @var11 INT = 3;
SELECT dbo.semana(@var11) AS SEMANA_DIA

--Ejercicio_08

DECLARE @var12 INT = 3;
DECLARE @var13 NVARCHAR(55);
IF @var12 & 2 = 0
	SET @var13 = 'TRUE';
ELSE
	SET @var13 = 'FALSE'
SELECT @var13 AS Mar_o_Impar, @var12 AS Numero
GO

--Ejercicio_09

CREATE FUNCTION dbo.numeroGrande(@n1 FLOAT, @n2 FLOAT, @n3 FLOAT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @resultado FLOAT = @n1;
	IF @resultado < @n2
		SET @resultado = @n2
	IF @resultado < @n3
		SET @resultado = @n3
	RETURN @resultado;
END;

GO

DECLARE @var14 FLOAT = 9.54; 
DECLARE @var15 FLOAT = 6.54; 
DECLARE @var16 FLOAT = 7.54; 

SELECT dbo.numeroGrande(@var14, @var15, @var16) AS Numero_Mayor
GO

--TIENDA INFORMÁTICA
--Ejercicio_01
CREATE FUNCTION dbo.numeroTotalProducto()
RETURNS INT
AS
BEGIN
	DECLARE @numero INT;
	SET @numero = (SELECT COUNT(*) FROM producto);
	RETURN @numero
END;

GO

PRINT 'En la base de datos hay ' + CAST(dbo.numeroTotalProducto() AS NVARCHAR(55)) + ' productos.';
GO
--Ejercicio_02

CREATE FUNCTION dbo.precioMedio(@fab INT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @numero FLOAT;
	SET @numero = (SELECT AVG(precio) FROM producto WHERE @fab = cod_fabricante);
	RETURN @numero
END;

GO
DECLARE @fab INT = 2;
PRINT 'El precio medio de los productos del fabricante ' + CAST(@fab AS NVARCHAR(5)) + ' es: ' + CAST(dbo.precioMedio(@fab) AS NVARCHAR(55));
GO
--Ejercicio_03

CREATE FUNCTION dbo.valorMaximo(@fab INT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @numero FLOAT;
	SET @numero = (SELECT MAX(precio) FROM producto WHERE @fab = cod_fabricante);
	RETURN @numero
END;
GO
DECLARE @fab INT = 3;
PRINT 'El precio máximo de los productos del fabricante ' + CAST(@fab AS NVARCHAR(5)) + ' es: ' + CAST(dbo.valorMaximo(@fab) AS NVARCHAR(55));
GO

--JARDINERIA_V2
--Ejercicio_01


CREATE PROCEDURE sp_pais(@pais NVARCHAR(55))
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @codigo INT,
			@nombre NVARCHAR(255),
			@telefono NVARCHAR(55),
			@ciudad NVARCHAR(255);

	IF EXISTS(
		SELECT 1
		FROM cliente
		WHERE pais = @pais
	)
	BEGIN
		PRINT 'Clientes en ' + @pais + ':'
		DECLARE cursor_cliente CURSOR FOR
		SELECT
			codigo_cliente AS codigo,
			nombre_cliente AS Nombre,
			telefono AS Teléfono,
			ciudad AS Ciudad
		FROM cliente
		WHERE pais = @pais;

		OPEN cursor_cliente
		FETCH NEXT FROM cursor_cliente INTO @codigo, @nombre, @telefono, @ciudad;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT 'Código: ' + CAST(@codigo AS NVARCHAR) + ', ' +
				  'Nombre: ' + @nombre + ', ' +
				  'Teléfono: ' + CAST(@telefono AS NVARCHAR) + ', ' +
				  'Ciudad: ' + @ciudad;
			FETCH NEXT FROM cursor_cliente INTO @codigo, @nombre, @telefono, @ciudad;
		END;

		CLOSE cursor_cliente;
		DEALLOCATE cursor_cliente;
	END;
	ELSE
	BEGIN
		PRINT 'No hay clientes en ' + @pais;
	END;
END;
GO

EXEC sp_pais @pais = 'España';
GO
--Ejercicio_02
CREATE PROCEDURE sp_pago(@pago VARCHAR(40))
AS
BEGIN
	DECLARE 
END;



























