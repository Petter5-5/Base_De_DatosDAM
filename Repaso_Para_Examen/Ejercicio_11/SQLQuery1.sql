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

CREATE TABLE empleadoClienteComponentes(
	DNI_empleado NVARCHAR (255) NOT NULL,
	DNI_cliente NVARCHAR (255) NOT NULL,
	codigo_Componentes NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_empleadoClienteComponentes PRIMARY KEY (DNI_empleado, DNI_cliente, codigo_Componentes),
	CONSTRAINT fk_empleadoClienteComponentes_DNI_empleado FOREIGN KEY (DNI_empleado) REFERENCES empleado(DNI),
	CONSTRAINT fk_empleadoClienteComponentes_DNI_cliente FOREIGN KEY (DNI_cliente) REFERENCES empleado(DNI),
	CONSTRAINT fk_empleadoClienteComponentes_codigo_Componentes FOREIGN KEY (codigo_Componentes) REFERENCES Componentes(código_Componentes)
);

CREATE TABLE componente_Equipos(
	codigo_equipo NVARCHAR (255) NOT NULL,
	codigo_Componentes NVARCHAR (255) NOT NULL,
	cantidad INT NOT NULL,

	CONSTRAINT pk_componente_Equipos PRIMARY KEY (codigo_equipo, codigo_Componentes),
	CONSTRAINT fk_componente_Equipos_codigo_equipo FOREIGN KEY (codigo_equipo) REFERENCES equipos(código_equipo),
	CONSTRAINT fk_componente_Equipos_codigo_Componente FOREIGN KEY (codigo_componentes) REFERENCES componentes(código_componentes)
);

CREATE LOGIN gestorEmpleadoLogin
WITH PASSWORD = 'gestorEmpleado1';

CREATE USER gestorEmpleado
FOR LOGIN gestorEmpleadoLogin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON empleado
TO gestorEmpleado
WITH GRANT OPTION;

CREATE LOGIN empleadoLogin
WITH PASSWORD = 'Empleado1';

CREATE USER empleado
FOR LOGIN empleadoLogin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON equipos
TO empleado;

GRANT SELECT, INSERT, UPDATE, DELETE
ON componentes
TO empleado;