CREATE DATABASE Tienda;

use Tienda;

CREATE TABLE sección(
	codigo_sección NVARCHAR (255) NOT NULL,
	nombre NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_sección_codigo_sección PRIMARY KEY(codigo_sección)
);

CREATE TABLE empleado(
	DNI NVARCHAR (255) NOT NULL,
	nombre NVARCHAR (255) NOT NULL,
	apellido_1 NVARCHAR (255) NOT NULL,
	apellido_2 NVARCHAR (255),
	codigo_sección NVARCHAR (255) NOT NULL,

	CONSTRAINT ph_empleado_DNI PRIMARY KEY(DNI),
	CONSTRAINT fk_empleado_codigo_sección FOREIGN KEY(codigo_sección) REFERENCES sección(codigo_sección)
);

CREATE TABLE cliente(
	DNI NVARCHAR (255) NOT NULL,
	nombre NVARCHAR (255) NOT NULL,
	apellido_1 NVARCHAR (255) NOT NULL,
	apellido_2 NVARCHAR (255),
	teléfono NVARCHAR (255) NOT NULL,
	provincia NVARCHAR (255),
	ciudades NVARCHAR (255),

	CONSTRAINT pk_cliente_DNI PRIMARY KEY(DNI),
	CONSTRAINT uq_cliente_teléfono UNIQUE (teléfono)
);

CREATE TABLE equipos(
	código_equipo NVARCHAR (255) NOT NULL,
	stock INT NOT NULL,
	descripción NVARCHAR (255),
	precio_venta DECIMAL (7, 2) NOT NULL,
	fecha_operacion DATE NOT NULL,
	cantidad_compra INT NOT NULL,

	CONSTRAINT pk_equipos_código_equipo PRIMARY KEY (código_equipo),
	CONSTRAINT ch_equipos_precio_venta CHECK (precio_venta > 0)
);

CREATE TABLE componentes(
	código_componentes NVARCHAR (255) NOT NULL,
	stock INT NOT NULL,
	descripción NVARCHAR (255),
	precio_venta DECIMAL (7, 2) NOT NULL,
	fecha_operacion DATE NOT NULL,
	cantidad_compra INT NOT NULL,

	CONSTRAINT pk_componentes_código_componentes PRIMARY KEY (código_componentes),
	CONSTRAINT ch_componentes_precio_venta CHECK (precio_venta > 0)
);

CREATE TABLE empleadoClienteEquipos(
	DNI_empleado NVARCHAR (255) NOT NULL,
	DNI_cliente NVARCHAR (255) NOT NULL,
	codigo_equipo NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_empleadoClienteEquipos PRIMARY KEY (DNI_empleado, DNI_cliente, codigo_equipo),
	CONSTRAINT fk_empleadoClienteEquipos_DNI_empleado FOREIGN KEY (DNI_empleado) REFERENCES empleado(DNI),
	CONSTRAINT fk_empleadoClienteEquipos_DNI_cliente FOREIGN KEY (DNI_cliente) REFERENCES empleado(DNI),
	CONSTRAINT fk_empleadoClienteEquipos_codigo_equipo FOREIGN KEY (codigo_equipo) REFERENCES equipos(código_equipo)
);