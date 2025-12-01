CREATE DATABASE agenciaVuelo;

USE agenciaVuelo;

CREATE TABLE cliente(
	DNI NVARCHAR (255) NOT NULL,
	nombre NVARCHAR (255) NOT NULL,
	apellido1 NVARCHAR (255) NOT NULL,
	apellido2 NVARCHAR (255) NOT NULL,
	teléfono NVARCHAR (255) NOT NULL,
	correo_electrónico NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_cliente_DNI PRIMARY KEY (DNI),
	CONSTRAINT uq_cliente_teléfono UNIQUE (teléfono)
);

CREATE TABLE sucursal(
	código_Sucursal NVARCHAR (255) NOT NULL,
	ciudad NVARCHAR (255) NOT NULL,
	provincia NVARCHAR (255) NOT NULL,
	teléfono1 NVARCHAR (255) NOT NULL,
	dirección NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_sucursal_código_Sucursal PRIMARY KEY (código_Sucursal),
	CONSTRAINT uq_cliente_teléfono1 UNIQUE (teléfono1)
);

CREATE TABLE hospedaje(
	código_Hospedaje NVARCHAR (255) NOT NULL,
	ciudad NVARCHAR (255) NOT NULL,
	nombre NVARCHAR (255) NOT NULL,
	provincia NVARCHAR (255) NOT NULL,
	teléfono NVARCHAR (255) NOT NULL,
	dirección NVARCHAR (255) NOT NULL,
	categoría INT NOT NULL,

	CONSTRAINT pk_hospedaje_código_Hospedaje PRIMARY KEY (código_Hospedaje), 
);

CREATE TABLE vuelo(
	código_Vuelo NVARCHAR (255) NOT NULL,
	fecha_Salida DATE NOT NULL,
	hora_Salida TIME NOT NULL,
	fecha_Llegada DATE NOT NULL,
	hora_Llegada TIME NOT NULL,
	origen NVARCHAR (255) NOT NULL,
	destino NVARCHAR (255) NOT NULL,
	número_Plazas INT NOT NULL,

	CONSTRAINT pk_vuelo_código_Vuelo PRIMARY KEY (código_Vuelo),
	CONSTRAINT ch_vuelo_origen_destino CHECK (origen != destino),
	CONSTRAINT ch_vuelo_número_plazas CHECK (número_plazas > 0)
);

CREATE TABLE clienteSucursalHospedaje(
	DNI NVARCHAR (255) NOT NULL,
	código_Sucursal NVARCHAR (255) NOT NULL,
	código_Hospedaje NVARCHAR (255) NOT NULL,
	régimen_Hospedaje NVARCHAR (255) NOT NULL,
	fecha_Entrada DATE NOT NULL,
	fecha_Salida DATE NOT NULL,

	CONSTRAINT pk_clienteSucursalHospedaje PRIMARY KEY (DNI, código_sucursal, código_hospedaje),
	CONSTRAINT fk_clienteSucursalHospedaje_DNI FOREIGN KEY (DNI) REFERENCES cliente(DNI),
	CONSTRAINT fk_clienteSucursalHospedaje_código_Sucursal FOREIGN KEY (código_Sucursal) REFERENCES sucursal(código_Sucursal),
	CONSTRAINT fk_clienteSucursalHospedaje_código_Hospedaje FOREIGN KEY (código_Hospedaje) REFERENCES hospedaje(código_Hospedaje),
	CONSTRAINT ch_clienteSucursalHospedaje_fecha_Entrada_Salida CHECK (fecha_Entrada != fecha_Salida)
);

CREATE TABLE clienteSucursalVuelo(
	DNI NVARCHAR (255) NOT NULL,
	código_Sucursal NVARCHAR (255) NOT NULL,
	código_Vuelo NVARCHAR (255) NOT NULL,
	tipo_Plaza NVARCHAR (255) NOT NULL,

	CONSTRAINT pk_clienteSucursalVuelo PRIMARY KEY (DNI, código_sucursal, código_Vuelo),
	CONSTRAINT fk_clienteSucursalVuelo_DNI FOREIGN KEY (DNI) REFERENCES cliente(DNI),
	CONSTRAINT fk_clienteSucursalVuelo_código_Sucursal FOREIGN KEY (código_Sucursal) REFERENCES sucursal(código_Sucursal),
	CONSTRAINT fk_clienteSucursalVuelo_código_Hospedaje FOREIGN KEY (código_Vuelo) REFERENCES vuelo(código_Vuelo),
);

