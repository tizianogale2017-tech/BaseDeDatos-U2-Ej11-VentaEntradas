-- Base de Datos I - Unidad 4 - Ej11: VentaEntradas
-- Script portable (SQLite / MySQL). En SQLite activar antes: PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS TICKET;
DROP TABLE IF EXISTS COMPRA;
DROP TABLE IF EXISTS concierto_sector;
DROP TABLE IF EXISTS SECTOR;
DROP TABLE IF EXISTS CLIENTE;
DROP TABLE IF EXISTS CONCIERTO;
DROP TABLE IF EXISTS RECINTO;

CREATE TABLE RECINTO (
    id_recinto INT PRIMARY KEY,
    codigo_recinto VARCHAR(50) UNIQUE,
    nombre_recinto VARCHAR(50),
    direccion_recinto VARCHAR(100),
    ciudad VARCHAR(50),
    capacidad_maxima INT
);

CREATE TABLE CONCIERTO (
    id_concierto INT PRIMARY KEY,
    id_recinto INT,
    codigo_evento VARCHAR(100) UNIQUE,
    titulo_gira VARCHAR(50),
    fecha_hora_evento DATETIME,
    artista_principal VARCHAR(50),
    estado_evento VARCHAR(100),
    FOREIGN KEY (id_recinto) REFERENCES RECINTO(id_recinto)
);

CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY,
    dni_cliente INT,
    nombre_cliente VARCHAR(50),
    email_cliente VARCHAR(50) UNIQUE,
    contrasena VARCHAR(100),
    telefono_cliente VARCHAR(50),
    fecha_registro DATE
);

CREATE TABLE SECTOR (
    id_sector INT PRIMARY KEY,
    id_recinto INT,
    nombre_sector VARCHAR(50),
    cantidad_localidades INT,
    precio_base DECIMAL(12,2),
    tipo_sector VARCHAR(50),
    es_numerado VARCHAR(100),
    FOREIGN KEY (id_recinto) REFERENCES RECINTO(id_recinto)
);

CREATE TABLE concierto_sector (
    id_conc_sector INT PRIMARY KEY,
    id_concierto INT,
    id_sector INT,
    localidades_habilitadas VARCHAR(100),
    localidades_vendidas INT,
    precio_final DECIMAL(12,2),
    FOREIGN KEY (id_concierto) REFERENCES CONCIERTO(id_concierto),
    FOREIGN KEY (id_sector) REFERENCES SECTOR(id_sector)
);

CREATE TABLE COMPRA (
    id_compra INT PRIMARY KEY,
    id_cliente INT,
    numero_compra VARCHAR(50),
    fecha_compra DATE,
    hora_compra TIME,
    monto_total DECIMAL(12,2),
    medio_pago VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE TICKET (
    id_ticket INT PRIMARY KEY,
    id_compra INT,
    id_conc_sector INT,
    codigo_ticket VARCHAR(50) UNIQUE,
    fila VARCHAR(100),
    numero_asiento VARCHAR(100),
    precio_pagado DECIMAL(12,2),
    estado_ticket VARCHAR(100),
    FOREIGN KEY (id_compra) REFERENCES COMPRA(id_compra),
    FOREIGN KEY (id_conc_sector) REFERENCES concierto_sector(id_conc_sector)
);

-- Datos de RECINTO
INSERT INTO RECINTO (id_recinto, codigo_recinto, nombre_recinto, ciudad, capacidad_maxima) VALUES (1, 'REC-01', 'Estadio Malvinas Argentinas', 'Mendoza', 40000);
INSERT INTO RECINTO (id_recinto, codigo_recinto, nombre_recinto, ciudad, capacidad_maxima) VALUES (2, 'REC-03', 'Teatro Independencia', 'Mendoza', 1500);
INSERT INTO RECINTO (id_recinto, codigo_recinto, nombre_recinto, ciudad, capacidad_maxima) VALUES (3, 'REC-04', 'Hipódromo de Palermo', 'Buenos Aires', 25000);
INSERT INTO RECINTO (id_recinto, codigo_recinto, nombre_recinto, ciudad, capacidad_maxima) VALUES (4, 'REC-05', 'Orfeo Superdomo', 'Córdoba', 10000);

-- Datos de CONCIERTO
INSERT INTO CONCIERTO (id_concierto, id_recinto, titulo_gira, fecha_hora_evento, artista_principal) VALUES (1, 1, 'Gira Raíces', '2026-11-14 21:00', 'Los Andariegos');
INSERT INTO CONCIERTO (id_concierto, id_recinto, titulo_gira, fecha_hora_evento, artista_principal) VALUES (2, 1, 'Tour Cuyo Rock', '2026-12-05 20:30', 'Cuyo Rock Band');
INSERT INTO CONCIERTO (id_concierto, id_recinto, titulo_gira, fecha_hora_evento, artista_principal) VALUES (3, 2, 'Jazz de Cámara', '2026-12-12 21:00', 'Cuarteto Sur');
INSERT INTO CONCIERTO (id_concierto, id_recinto, titulo_gira, fecha_hora_evento, artista_principal) VALUES (4, 4, 'Mundo Eléctrico', '2026-12-19 21:30', 'Electro Mendoza');

-- Datos de CLIENTE
INSERT INTO CLIENTE (id_cliente, dni_cliente, nombre_cliente, email_cliente, telefono_cliente) VALUES (1, 32111000, 'Valeria Gómez', 'vgomez@mail.com', '261-6001001');
INSERT INTO CLIENTE (id_cliente, dni_cliente, nombre_cliente, email_cliente, telefono_cliente) VALUES (2, 33222111, 'Esteban Ríos', 'erios@mail.com', '261-6001002');
INSERT INTO CLIENTE (id_cliente, dni_cliente, nombre_cliente, email_cliente, telefono_cliente) VALUES (3, 35444333, 'Nicolás Soria', 'nsoria@mail.com', '261-6001004');
INSERT INTO CLIENTE (id_cliente, dni_cliente, nombre_cliente, email_cliente, telefono_cliente) VALUES (4, 36555444, 'Carolina Paz', 'cpaz@mail.com', '261-6001005');

-- Datos de SECTOR
INSERT INTO SECTOR (id_sector, id_recinto, nombre_sector, tipo_sector, precio_base) VALUES (1, 1, 'Platea Baja', 'Numerado', 40000);
INSERT INTO SECTOR (id_sector, id_recinto, nombre_sector, tipo_sector, precio_base) VALUES (2, 1, 'Campo', 'General', 22000);
INSERT INTO SECTOR (id_sector, id_recinto, nombre_sector, tipo_sector, precio_base) VALUES (3, 2, 'Palco', 'Numerado', 55000);
INSERT INTO SECTOR (id_sector, id_recinto, nombre_sector, tipo_sector, precio_base) VALUES (4, 4, 'Campo', 'General', 25000);

-- Datos de concierto_sector
INSERT INTO concierto_sector (id_conc_sector, id_concierto, id_sector, precio_final, localidades_vendidas) VALUES (1, 1, 1, 45000, 8000);
INSERT INTO concierto_sector (id_conc_sector, id_concierto, id_sector, precio_final, localidades_vendidas) VALUES (2, 1, 2, 25000, 20000);
INSERT INTO concierto_sector (id_conc_sector, id_concierto, id_sector, precio_final, localidades_vendidas) VALUES (3, 3, 3, 60000, 300);
INSERT INTO concierto_sector (id_conc_sector, id_concierto, id_sector, precio_final, localidades_vendidas) VALUES (4, 4, 4, 28000, 7000);

-- Datos de COMPRA
INSERT INTO COMPRA (id_compra, id_cliente, numero_compra, monto_total, medio_pago) VALUES (1, 1, 'C-1001', 45000, 'Tarjeta');
INSERT INTO COMPRA (id_compra, id_cliente, numero_compra, monto_total, medio_pago) VALUES (2, 2, 'C-1002', 25000, 'Débito');
INSERT INTO COMPRA (id_compra, id_cliente, numero_compra, monto_total, medio_pago) VALUES (3, 1, 'C-1004', 60000, 'Tarjeta');
INSERT INTO COMPRA (id_compra, id_cliente, numero_compra, monto_total, medio_pago) VALUES (4, 4, 'C-1005', 28000, 'Débito');

-- Datos de TICKET
INSERT INTO TICKET (id_ticket, id_compra, id_conc_sector, precio_pagado, codigo_ticket) VALUES (1, 1, 1, 45000, 'TK-0001');
INSERT INTO TICKET (id_ticket, id_compra, id_conc_sector, precio_pagado, codigo_ticket) VALUES (2, 2, 2, 25000, 'TK-0002');
INSERT INTO TICKET (id_ticket, id_compra, id_conc_sector, precio_pagado, codigo_ticket) VALUES (3, 3, 3, 60000, 'TK-0004');
INSERT INTO TICKET (id_ticket, id_compra, id_conc_sector, precio_pagado, codigo_ticket) VALUES (4, 4, 4, 28000, 'TK-0005');
