-- COMIENZA ENTREGA NRO 1 

/* CON RESPECTO A LAS CORRECCIONES DE LA ENTREGA UNO, CORREGI LAS TABLAS QUE ESTABAN EN PLURAL. EN CUANTO A LA CORRECCIÓN DE QUE QUIERO 
AGREGAR UNA REFERENCIA A UNA TABLA INEXISTENTE, QUIZAS HAYA PASADO ALGO POR LA MANERA EN LA QUE GUARDE EL SCRIPT QUE TAMBIÉN FUE UNA DE LAS
CORRECCIONES, PORQUE SINCERAMENTE A MI ME FUNCIONA TODO PERFECTO, PERO CHEQUEEN POR FAVOR PARA PODER CORREGIR*/

DROP SCHEMA IF EXISTS agrodron;
CREATE SCHEMA agrodron;
USE agrodron;

CREATE TABLE customer(
id_customer INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
name_1 VARCHAR (30) NOT NULL,
last_name VARCHAR (30) NOT NULL,
phone  VARCHAR (15) NOT NULL,
address VARCHAR (50) NOT NULL,
registration_date  DATE
);

ALTER TABLE customer MODIFY phone VARCHAR (15) NOT NULL;
ALTER TABLE customer ADD COLUMN email VARCHAR (30) NOT NULL;



CREATE TABLE location (
id_location INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_customer INT,
hectares INT NOT NULL,
coordinates VARCHAR(50) NOT NULL,
crop_type VARCHAR (35),
soil_condition VARCHAR (30), -- DESCRIPCIÓN DEL SUELO (BUENO, NORMAL, DAÑADO)
CONSTRAINT FK_LOCATION_CUSTOMER FOREIGN KEY (id_customer) REFERENCES customer(id_customer)
);

ALTER TABLE location ADD COLUMN province VARCHAR (50) NOT NULL;
ALTER TABLE location ADD COLUMN city VARCHAR  (50) NOT NULL;




CREATE TABLE drone (
id_drone INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
model VARCHAR (50), -- MODELO DE LOS DRONES
maximum_range VARCHAR (15), -- ALCANCE MAXIMO EN HECTAREAS
ability DECIMAL (10, 2), -- CAPACIDAD EN LITROS QUE POSEE EL DRON
type_of_service VARCHAR (20), -- TIPOS DE SERVICIOS (FERTILIZACIÓN, CONTROL DE PLAGAS , AMBOS )
availability VARCHAR (20) -- DISPONIBILIDAD DE LOS DRONCES (EN SERVICIO, DISPONIBLE, EN MANTENIMIENTO).
);




CREATE TABLE pilot (
id_pilot INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
name_pilot VARCHAR (30) NOT NULL,
last_name_pilot VARCHAR (30) NOT NULL,
phone VARCHAR (15) NOT NULL,
email VARCHAR (50) NOT NULL,
license_type VARCHAR (50), -- TIPO DE LICENCIA DE VUELO (BÁSICA, MEDIA, AVANZADA)
experience VARCHAR (20), -- AÑOS DE EXPERIENCIA 
registration_date DATE
);

CREATE TABLE bill (
id_bill INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_customer INT NOT NULL,
amount DECIMAL (10, 2) NOT NULL,
issue_date DATE NOT NULL,
payment_status VARCHAR (20), -- ESTADO DE PAGO (PENDIENTE , PAGADO)
CONSTRAINT FK_BILL_CUSTOMER FOREIGN KEY (id_customer) REFERENCES customer (id_customer)
);


CREATE TABLE mechanical_technical (
id_technical INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
name_technical VARCHAR (30) NOT NULL,
last_name_technical VARCHAR (40) NOT NULL,
phone INT NOT NULL,
speciality VARCHAR (50), -- especialidad (mantenimiento de drones , electrónica)
registration_date DATE
);

ALTER TABLE mechanical_technical ADD COLUMN email VARCHAR (50) NOT NULL ;
ALTER TABLE mechanical_technical MODIFY COLUMN phone VARCHAR (15) NOT NULL;




CREATE TABLE drone_maintenance (
id_maintenance INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_drone INT NOT NULL,
id_technical INT NOT NULL,
maintenance_date DATE NOT NULL,
report TEXT NOT NULL,
CONSTRAINT FK_DRONE_MAINTENANCE_DRONE FOREIGN KEY (id_drone) REFERENCES drone (id_drone)

);

ALTER TABLE drone_maintenance ADD CONSTRAINT FK_DRONE_MAINTENANCE_MECHANICAL_TECHNICAL FOREIGN KEY (id_technical) REFERENCES mechanical_technical(id_technical);
ALTER TABLE drone_maintenance ADD COLUMN repair_cost FLOAT;

-- AGREGAMOS UNA NUEVA TABLA AL ESQUEMA

CREATE TABLE agro_chemical (
id_agro_chemical INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
type_of_chemical VARCHAR (50) NOT NULL,
price_per_liter DECIMAL(10,2) NOT NULL,
liters_in_stock DECIMAL(10,2),
expiration_date DATE);



CREATE TABLE contracted_service (
id_service INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_customer INT NOT NULL,
id_location INT NOT NULL,
id_drone INT NOT NULL,
hiring_date DATE NOT NULL,
type_of_work VARCHAR (50) NOT NULL, 
service_status VARCHAR (50) NOT NULL, -- estado del servicio (pendiente, en proceso, completado)
CONSTRAINT FK_CONTRACTED_SERVICE_CUSTOMER FOREIGN KEY (id_customer) REFERENCES customer (id_customer),
CONSTRAINT FK_CONTRACTED_SERVICE_LOCATION FOREIGN KEY (id_location) REFERENCES location (id_location),
CONSTRAINT FK_CONTRACTED_SERVICE_DRONE FOREIGN KEY (id_drone) REFERENCES drone (id_drone)
);



CREATE TABLE service_completed (
id_service_completed INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_service INT NOT NULL,
id_pilot INT NOT NULL,
date_of_realization DATE NOT NULL,
commets TEXT, -- comentarios sobre el trabajo realizado
CONSTRAINT FK_SERVICE_COMPLETED_CONTRACTED_SERVICE FOREIGN KEY (id_service) REFERENCES contracted_service(id_service) 
);
ALTER TABLE service_completed ADD COLUMN id_location INT;
ALTER TABLE service_completed ADD CONSTRAINT FK_SERVICE_COMPLETED_LOCATION FOREIGN KEY (id_location) REFERENCES location (id_location);

ALTER TABLE service_completed ADD COLUMN id_drone INT;
ALTER TABLE service_completed ADD CONSTRAINT FK_SERVICE_COMPLETED_DRONE FOREIGN KEY (id_drone) REFERENCES drone (id_drone);

ALTER TABLE service_completed ADD CONSTRAINT FK_SERVICE_COMPLETED_PILOT FOREIGN KEY (id_pilot) REFERENCES pilot (id_pilot);

ALTER TABLE service_completed ADD COLUMN liters_used DECIMAL(10,2);
ALTER TABLE service_completed ADD COLUMN id_agro_chemical INT;
ALTER TABLE service_completed ADD CONSTRAINT FK_SERVICE_COMPLETED_AGRO_CHEMICAL FOREIGN KEY (id_agro_chemical) REFERENCES agro_chemical(id_agro_chemical);





-- COMIENZAN ENTREGA NRO 2
 
 -- AGREGAMOS UNA NUEVA TABLA AL ESQUEMA

CREATE TABLE agro_chemical (
id_agro_chemical INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
type_of_chemical VARCHAR (50) NOT NULL,
price_per_liter DECIMAL(10,2) NOT NULL,
liters_in_stock DECIMAL(10,2),
expiration_date DATE);

-- INSERCION DE DATOS A TRAVÉS DE SENTENCIAS


-- INSERCIÓN DE DATOS EN TABLA CUSTOMER

INSERT INTO customer (name_1, last_name, phone, address, registration_date, email) VALUES
('Pablo', 'Ortigoza', '3443658974', 'Posadas 450', '2016-12-23', 'pablo32@pepe.com'),
('Laura', 'Gómez', '1122334455', 'Av. Rivadavia 1000', '2017-03-15', 'laura.gomez@email.com'),
('Carlos', 'Pérez', '2233445566', 'Calle Corrientes 200', '2018-06-20', 'carlos.perez@email.com'),
('Ana', 'Rodríguez', '3344556677', 'Av. Mayo 500', '2019-09-10', 'ana.rodriguez@email.com'),
('Diego', 'López', '4455667788', 'Calle Belgrano 800', '2020-12-05', 'diego.lopez@email.com'),
('María', 'Martínez', '5566778899', 'Av. 9 de Julio 1200', '2021-03-20', 'maria.martinez@email.com'),
('Javier', 'Sánchez', '6677889900', 'Calle San Martín 300', '2022-06-15', 'javier.sanchez@email.com'),
('Sofía', 'González', '7788990011', 'Av. Callao 700', '2023-09-01', 'sofia.gonzalez@email.com'),
('Martín', 'Díaz', '8899001122', 'Calle Córdoba 900', '2015-01-10', 'martin.diaz@email.com'),
('Lucía', 'Fernández', '9900112233', 'Av. Santa Fe 1100', '2016-04-25', 'lucia.fernandez@email.com'),
('Roberto', 'García', '0011223344', 'Calle Entre Ríos 400', '2017-07-30', 'roberto.garcia@email.com'),
('Elena', 'Ruiz', '1122334455', 'Av. Pueyrredón 600', '2018-10-15', 'elena.ruiz@email.com'),
('Andrés', 'Torres', '2233445566', 'Calle Paraná 100', '2019-01-20', 'andres.torres@email.com'),
('Patricia', 'Vargas', '3344556677', 'Av. Corrientes 1300', '2020-04-05', 'patricia.vargas@email.com'),
('Ricardo', 'Jiménez', '4455667788', 'Calle Tucumán 800', '2021-07-20', 'ricardo.jimenez@email.com');


-- INSERCIÓN DE DATOS EN TABLA LOCATION 

INSERT INTO location (id_customer, hectares, coordinates, crop_type, soil_condition, province, city) VALUES
(1, 50, '-34.6037, -58.3816', 'Soja', 'BUENO', 'Buenos Aires', 'La Plata'),
(2, 30, '-33.4489, -64.0017', 'Maíz', 'NORMAL', 'Córdoba', 'Río Cuarto'),
(3, 70, '-27.4667, -58.9833', 'Trigo', 'DAÑADO', 'Chaco', 'Resistencia'),
(4, 40, '-32.9468, -60.6393', 'Girasol', 'BUENO', 'Santa Fe', 'Rosario'),
(5, 60, '-38.9516, -68.0605', 'Alfalfa', 'NORMAL', 'Neuquén', 'Neuquén'),
(6, 25, '-31.6333, -60.7000', 'Arroz', 'DAÑADO', 'Entre Ríos', 'Paraná'),
(7, 80, '-26.8167, -65.2167', 'Caña de azúcar', 'BUENO', 'Tucumán', 'San Miguel de Tucumán'),
(8, 35, '-33.0244, -71.5510', 'Uvas', 'NORMAL', 'Mendoza', 'Mendoza'),
(9, 55, '-24.1833, -65.3333', 'Tabaco', 'DAÑADO', 'Jujuy', 'San Salvador de Jujuy'),
(10, 45, '-25.5000, -54.6000', 'Yerba mate', 'BUENO', 'Misiones', 'Posadas'),
(11, 75, '-41.1333, -71.3000', 'Frutas finas', 'NORMAL', 'Río Negro', 'Bariloche'),
(12, 20, '-29.1500, -66.8667', 'Olivos', 'DAÑADO', 'La Rioja', 'La Rioja'),
(13, 65, '-28.0000, -66.0000', 'Algodón', 'BUENO', 'Catamarca', 'San Fernando del Valle de Catamarca'),
(14, 30, '-33.6500, -68.3000', 'Ajo', 'NORMAL', 'San Juan', 'San Juan'),
(15, 40, '-34.6158, -58.5030', 'Hortalizas', 'DAÑADO', 'Ciudad Autónoma de Buenos Aires', 'Buenos Aires');

-- INSERCIÓN DE DATOS EN TABLA DRONE

INSERT INTO drone (model, maximum_range, ability, type_of_service, availability) VALUES
('DJI Agras T30', '30 ha', 30.00, 'FERTILIZACIÓN', 'EN SERVICIO'),
('DJI Agras MG-1P', '10 ha', 10.00, 'CONTROL DE PLAGAS', 'DISPONIBLE'),
('DJI Matrice 600 Pro', '50 ha', 50.00, 'FERTILIZACIÓN', 'EN MANTENIMIENTO'),
('DJI Mavic 2 Pro', '5 ha', 5.00, 'CONTROL DE PLAGAS', 'DISPONIBLE'),
('DJI Phantom 4 Pro', '8 ha', 8.00, 'FERTILIZACIÓN', 'EN SERVICIO'),
('DJI Inspire 2', '12 ha', 12.00, 'CONTROL DE PLAGAS', 'EN MANTENIMIENTO'),
('DJI Agras T16', '25 ha', 25.00, 'FERTILIZACIÓN', 'DISPONIBLE'),
('DJI Agras MG-1S', '10 ha', 10.00, 'CONTROL DE PLAGAS', 'EN SERVICIO'),
('DJI Matrice 210 RTK', '40 ha', 40.00, 'FERTILIZACIÓN', 'EN MANTENIMIENTO'),
('DJI Mavic Air 2', '6 ha', 6.00, 'CONTROL DE PLAGAS', 'DISPONIBLE'),
('DJI Phantom 4 RTK', '9 ha', 9.00, 'FERTILIZACIÓN', 'EN SERVICIO'),
('DJI Inspire 1', '11 ha', 11.00, 'CONTROL DE PLAGAS', 'EN MANTENIMIENTO'),
('DJI Agras MG-1', '15 ha', 15.00, 'FERTILIZACIÓN', 'DISPONIBLE'),
('DJI Mavic Mini', '3 ha', 3.00, 'CONTROL DE PLAGAS', 'EN SERVICIO'),
('DJI Matrice 300 RTK', '60 ha', 60.00, 'FERTILIZACIÓN', 'EN MANTENIMIENTO');

-- INSERCIÓN DE DATOS EN TABLA PILOT

INSERT INTO pilot (id_pilot, name_pilot, last_name_pilot, phone, email, license_type, experience, registration_date) VALUES
(1, 'Carlos', 'Fernández', '344365897', 'c.fernandez@email.com', 'AVANZADA', '10 años', '2015-06-12'),
(2, 'Laura', 'Martínez', '112233446', 'laura.martinez@email.com', 'MEDIA', '5 años', '2018-09-20'),
(3, 'Juan', 'Gómez', '223344557', 'juan.gomez@email.com', 'BÁSICA', '2 años', '2021-03-10'),
(4, 'Ana', 'Pérez', '334455668', 'ana.perez@email.com', 'AVANZADA', '8 años', '2016-11-05'),
(5, 'Diego', 'Rodríguez', '445566779', 'diego.rodriguez@email.com', 'MEDIA', '4 años', '2019-07-15'),
(6, 'Sofía', 'López', '556677880', 'sofia.lopez@email.com', 'BÁSICA', '1 año', '2022-01-20'),
(7, 'Martín', 'Sánchez', '667788991', 'martin.sanchez@email.com', 'AVANZADA', '12 años', '2014-04-30'),
(8, 'Lucía', 'González', '778899002', 'lucia.gonzalez@email.com', 'MEDIA', '6 años', '2017-12-25'),
(9, 'Roberto', 'Díaz', '889900113', 'roberto.diaz@email.com', 'BÁSICA', '3 años', '2020-08-01'),
(10, 'Elena', 'Ruiz', '990011224', 'elena.ruiz@email.com', 'AVANZADA', '9 años', '2015-02-18'),
(11, 'Andrés', 'Torres', '001122335', 'andres.torres@email.com', 'MEDIA', '7 años', '2018-10-22'),
(12, 'Patricia', 'Vargas', '1122334458', 'patricia.vargas@email.com', 'BÁSICA', '4 años', '2021-05-15'),
(13, 'Ricardo', 'Jiménez', '2233445569', 'ricardo.jimenez@email.com', 'AVANZADA', '11 años', '2013-12-10'),
(14, 'Silvia', 'García', '3344556680', 'silvia.garcia@email.com', 'MEDIA', '8 años', '2016-09-03'),
(15, 'Daniel', 'Hernández', '4455667791', 'daniel.hernandez@email.com', 'BÁSICA', '5 años', '2019-02-28');


-- INSERCIÓN DE DATOS EN TABLA BILL

INSERT INTO bill (id_customer, amount, issue_date, payment_status) VALUES
(1, 800.00, '2024-03-15', 'PAGADO'),
(2, 500.00, '2024-03-20', 'PENDIENTE'),
(3, 1200.00, '2024-03-25', 'PAGADO'),
(4, 700.00, '2024-03-30', 'PENDIENTE'),
(5, 1000.00, '2024-04-05', 'PAGADO'),
(6, 600.00, '2024-04-10', 'PENDIENTE'),
(7, 1500.00, '2024-04-15', 'PAGADO'),
(8, 850.00, '2024-04-20', 'PENDIENTE'),
(9, 1100.00, '2024-04-25', 'PAGADO'),
(10, 750.00, '2024-04-30', 'PENDIENTE'),
(11, 1300.00, '2024-05-05', 'PAGADO'),
(12, 900.00, '2024-05-10', 'PENDIENTE'),
(13, 1600.00, '2024-05-15', 'PAGADO'),
(14, 950.00, '2024-05-20', 'PENDIENTE'),
(15, 1250.00, '2024-05-25', 'PAGADO');


-- INSERCIÓN DE DATOS EN TABLA MECHANICAL_TECHNICAL

INSERT INTO mechanical_technical (name_technical, last_name_technical, phone, speciality, registration_date, email) VALUES
('Carlos', 'Pérez', '3445678901', 'Mantenimiento de drones', '2020-05-10', 'carlos.perez@email.com'),
('Laura', 'Gómez', '1122334456', 'Electrónica', '2019-12-01', 'laura.gomez@email.com'),
('Juan', 'Martínez', '2233445567', 'Mantenimiento de drones', '2021-08-15', 'juan.martinez@email.com'),
('Ana', 'Rodríguez', '3344556678', 'Electrónica', '2018-03-20', 'ana.rodriguez@email.com'),
('Diego', 'López', '4455667789', 'Mantenimiento de drones', '2022-06-30', 'diego.lopez@email.com'),
('Sofía', 'Sánchez', '5566778890', 'Electrónica', '2017-11-10', 'sofia.sanchez@email.com'),
('Martín', 'González', '6677889901', 'Mantenimiento de drones', '2023-04-25', 'martin.gonzalez@email.com'),
('Lucía', 'Díaz', '7788990012', 'Electrónica', '2016-09-05', 'lucia.diaz@email.com'),
('Roberto', 'Ruiz', '8899001123', 'Mantenimiento de drones', '2020-01-15', 'roberto.ruiz@email.com'),
('Elena', 'Torres', '9900112234', 'Electrónica', '2019-05-20', 'elena.torres@email.com'),
('Andrés', 'Vargas', '0011223345', 'Mantenimiento de drones', '2021-12-31', 'andres.vargas@email.com'),
('Patricia', 'Jiménez', '1122334457', 'Electrónica', '2018-08-10', 'patricia.jimenez@email.com'),
('Ricardo', 'García', '2233445568', 'Mantenimiento de drones', '2022-03-25', 'ricardo.garcia@email.com'),
('Silvia', 'Fernández', '3344556679', 'Electrónica', '2017-06-05', 'silvia.fernandez@email.com'),
('Daniel', 'Hernández', '4455667790', 'Mantenimiento de drones', '2023-01-20', 'daniel.hernandez@email.com');




-- INSERCIÓN DE DATOS EN TABLA DRONE_MAINTENANCE

INSERT INTO drone_maintenance (id_drone, id_technical, maintenance_date, report, repair_cost) VALUES
(1, 1, '2024-01-10', 'Mantenimiento preventivo.', 250.00),
(2, 2, '2024-01-15', 'Reparación del motor.', 300.00),
(3, 3, '2024-01-20', 'Mantenimiento preventivo.', 200.00),
(4, 4, '2024-01-25', 'Reparación de hélices.', 150.00),
(5, 5, '2024-01-30', 'Mantenimiento preventivo.', 220.00),
(6, 6, '2024-02-05', 'Reparación del sistema de navegación.', 350.00),
(7, 7, '2024-02-10', 'Mantenimiento preventivo.', 280.00),
(8, 8, '2024-02-15', 'Reparación de la cámara.', 180.00),
(9, 9, '2024-02-20', 'Mantenimiento preventivo.', 230.00),
(10, 10, '2024-02-25', 'Reparación de la batería.', 320.00),
(11, 11, '2024-03-01', 'Mantenimiento preventivo.', 260.00),
(12, 12, '2024-03-05', 'Reparación de los sensores.', 190.00),
(13, 13, '2024-03-10', 'Mantenimiento preventivo.', 210.00),
(14, 14, '2024-03-15', 'Reparación del tren de aterrizaje.', 170.00),
(15, 15, '2024-03-20', 'Mantenimiento preventivo.', 240.00);


-- INSERCIÓN DE DATOS EN TABLA AGRO_CHEMICAL

INSERT INTO agro_chemical (type_of_chemical, price_per_liter, liters_in_stock, expiration_date) VALUES
('Fertilizante Líquido 20-20-20', 18.50, 500.00, '2025-12-31'),
('Pesticida Concentrado X', 25.75, 300.00, '2024-11-30'),
('Herbicida Selectivo Y', 15.20, 400.00, '2026-06-15'),
('Fungicida Z', 22.90, 250.00, '2025-09-30'),
('Insecticida Orgánico A', 30.50, 200.00, '2024-12-31'),
('Abono Foliar B', 12.80, 600.00, '2026-03-31'),
('Regulador de Crecimiento C', 28.30, 350.00, '2025-10-15'),
('Adherente D', 10.90, 700.00, '2024-11-30'),
('Fertilizante Granulado E', 19.60, 450.00, '2026-05-31'),
('Pesticida Natural F', 24.10, 280.00, '2025-12-15'),
('Herbicida No Selectivo G', 16.70, 320.00, '2024-10-31'),
('Fungicida Preventivo H', 21.40, 220.00, '2026-02-28'),
('Insecticida Sistémico I', 29.80, 180.00, '2025-11-15'),
('Acondicionador de Suelo J', 13.50, 550.00, '2024-09-30'),
('Estimulante de Raíces K', 27.20, 380.00, '2026-04-30');



-- INSERCIÓN DE DATOS EN TABLA CONTRACTED_SERVICE

INSERT INTO contracted_service (id_customer, id_location, id_drone, hiring_date, type_of_work, service_status) VALUES
(1, 1, 1, '2024-03-01', 'Fertilización de Soja', 'COMPLETADO'),
(2, 2, 2, '2024-03-05', 'Control de Plagas en Maíz', 'EN PROCESO'),
(3, 3, 3, '2024-03-10', 'Fertilización de Trigo', 'PENDIENTE'),
(4, 4, 4, '2024-03-15', 'Control de Plagas en Girasol', 'COMPLETADO'),
(5, 5, 5, '2024-03-20', 'Fertilización de Alfalfa', 'EN PROCESO'),
(6, 6, 6, '2024-03-25', 'Control de Plagas en Arroz', 'PENDIENTE'),
(7, 7, 7, '2024-03-30', 'Fertilización de Caña de Azúcar', 'COMPLETADO'),
(8, 8, 8, '2024-04-01', 'Control de Plagas en Uvas', 'EN PROCESO'),
(9, 9, 9, '2024-04-05', 'Fertilización de Tabaco', 'PENDIENTE'),
(10, 10, 10, '2024-04-10', 'Control de Plagas en Yerba Mate', 'COMPLETADO'),
(11, 11, 11, '2024-04-15', 'Fertilización de Frutas Finas', 'EN PROCESO'),
(12, 12, 12, '2024-04-20', 'Control de Plagas en Olivos', 'PENDIENTE'),
(13, 13, 13, '2024-04-25', 'Fertilización de Algodón', 'COMPLETADO'),
(14, 14, 14, '2024-04-30', 'Control de Plagas en Ajo', 'EN PROCESO'),
(15, 15, 15, '2024-05-01', 'Fertilización de Hortalizas', 'PENDIENTE');


-- INSERCIÓN DE DATOS EN TABLA SERVICE_COMPLETED

INSERT INTO service_completed (id_service, id_pilot, date_of_realization, commets, id_location, id_drone, liters_used, id_agro_chemical) VALUES
(1, 1, '2024-03-10', 'Fertilización realizada con éxito.', 1, 1, 40.0, 1),
(4, 4, '2024-03-20', 'Control de plagas realizado sin problemas.', 4, 4, 20.0, 2),
(7, 7, '2024-04-05', 'Fertilización completada.', 7, 7, 50.0, 3),
(10, 10, '2024-04-15', 'Control de plagas finalizado.', 10, 10, 25.0, 4),
(13, 13, '2024-04-30', 'Fertilización exitosa.', 13, 13, 60.0, 5),
(2, 2, '2024-03-12', 'Control de plagas en maíz.', 2, 2, 15.0, 6),
(3, 3, '2024-03-18', 'Fertilización de trigo iniciada.', 3, 3, 35.0, 7),
(5, 5, '2024-03-25', 'Fertilización de alfalfa en curso.', 5, 5, 45.0, 8),
(6, 6, '2024-03-30', 'Control de plagas en arroz.', 6, 6, 30.0, 9),
(8, 8, '2024-04-08', 'Control de plagas en uvas.', 8, 8, 18.0, 10),
(9, 9, '2024-04-12', 'Fertilización de tabaco.', 9, 9, 55.0, 11),
(11, 11, '2024-04-18', 'Fertilización de frutas finas.', 11, 11, 28.0, 12),
(12, 12, '2024-04-22', 'Control de plagas en olivos.', 12, 12, 32.0, 13),
(14, 14, '2024-05-01', 'Control de plagas en ajo.', 14, 14, 22.0, 14),
(15, 15, '2024-05-03', 'Fertilización de hortalizas.', 15, 15, 48.0, 15);







-- CREACIÓN DE VISTAS 

-- Vista VW_PAGOS_PENDIENTES, esta vista involucra diferentes campos de las tablas customer y bill.
-- El objetivo de está tabla es poder obtener de una manera rápida y sencilla los datos de aquellos clientes que tengan un estado de pago pendiente, para así poder enviar un recordatorio de la deuda existente.

CREATE OR REPLACE VIEW vw_pagos_pendientes AS (
SELECT c.id_customer, c.name_1, c.last_name, c.address, c.email, b.payment_status
FROM bill AS b
JOIN customer AS c ON b.id_customer = c.id_customer
WHERE b.payment_status = 'PENDIENTE');


-- Vista VW_SERVICIO_PENDIENTE, esta vista involucra campos de las tablas customer, location y contracted_service.
-- Tiene como objetivo poder visualizar aquellos servicios que se encuentran pendientes a realizar por parte de la empresa.
-- Entrega datos relevantes sobre el cliente como su id, su nombre, email para poder ser contactado, las coordenadas de sus tierras, 
-- cantidad de hectáreas, el tipo de trabajo a realizar y la fecha de contratación del servicio.

CREATE OR REPLACE VIEW vw_servicio_pendiente AS (
SELECT c.id_customer, c.name_1, c.last_name, c.email, l.coordinates, l.hectares, cs.type_of_work, cs.hiring_date ,cs.service_status
FROM contracted_service AS cs
JOIN customer AS c ON cs.id_customer = c.id_customer
JOIN location AS l ON cs.id_customer = l.id_customer
WHERE cs.service_status = 'PENDIENTE');



-- vista VW_PILOTO_SERVICIO_REALIZADO, esta vista involucra las tablas pilot y service_completed
-- Creada con el objetivo de contabilizar los servicios realizados de cada piloto, otorgando datos como el id del piloto, 
-- su nombre y apellido y la fecha de dichos trabajos realizados.

CREATE OR REPLACE VIEW vw_piloto_servicio_realizado AS(
SELECT p.id_pilot, p.name_pilot, p.last_name_pilot, sc.date_of_realization,
    COUNT(sc.id_service_completed) AS total_servicios_realizados
FROM pilot p
LEFT JOIN service_completed sc ON p.id_pilot = sc.id_pilot
GROUP BY p.id_pilot, p.name_pilot, p.last_name_pilot, sc.date_of_realization);


-- CREACIÓN DE FUNCIONES

-- Creación de función FN_INFO_CLIENTE
-- Esta función fué creada con el objetivo de obtener el nombre, el apellido, los servicios contratados y
--  el monto total acumulado de todos los servicios contratados por un cliente, a traves de su id único de cliente.
-- la función retorna un resultado de tipo texto, para crearla pasamos como parametro (p_idCustomer) que se utiliza para comparar
-- y ubicar al cliente a traves de su id, el cual se encuentra vinculado en cada una de las tablas que utilizamos para la función.
-- Generamos 5 variables, la variable 'nombre' y la variable 'apellido' son utilizadas en el primer bloque de código de la función, en ellas se guarda 
-- el nombre y el apellido del cliente buscado a traves de su id. En el segundo bloque lo que se hace es contabilizar la cantidad de servicios
-- contratados relacionados al id del cliente y lo guardamos en la variable 'total_servicios', luego en el bloque siguiente lo que hacemos 
-- es sumar todos los montos que ha abonado el cliente por la cantidad de servicios que ha contratado y lo guardamos en la variable 'monto_total'
-- Por último en la variable resultado concatenamos y guardamos todos los datos previamente guardados en las demas variables,
-- para luego mostrarlos cuando se llame a la función.


DELIMITER //

CREATE FUNCTION fn_info_cliente(p_idCustomer INT) 
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE nombre VARCHAR(30);
    DECLARE apellido VARCHAR(30);
    DECLARE total_servicios INT;
    DECLARE monto_total DECIMAL(10,2);
    DECLARE resultado TEXT;

    SELECT name_1, last_name INTO nombre, apellido
    FROM customer 
    WHERE id_customer = p_idCustomer;

    SELECT COUNT(*) INTO total_servicios
    FROM contracted_service
    WHERE id_customer = p_idCustomer;

    SELECT  SUM(amount) INTO monto_total
    FROM bill
    WHERE id_customer = p_idCustomer;

    SET resultado = CONCAT('Cliente: ', nombre, ' ', apellido, 
                           ' / Servicios Contratados: ', total_servicios, 
                           ' / Monto Total: $', monto_total);
RETURN resultado;
END //

DELIMITER ;

SELECT fn_info_cliente(7);

-- Creación de función FN_COSTO_REPARACIÓN 
-- Creada con el objetivo de llevar un control claro de los gatos mensuales en repuestos  para el mantenimiento de los drones.
-- Creamos la función, la cual finalmente devolvera un dato de tipo texto, pasamos dos parametros de salida (p_mes y p_anio),
-- declaramos dos variables locales (costo_total de tipo float y resultado de tipo texto), generamos la consulta de la suma de los 
-- gastos de reparaciones de la tabla drone_maintenance, utilizando filtros a traves de la sentencia WHERE para obtener los datos de mes y
-- año que queremos saber y se lo asignamos a nuestra variable costo_total. luego en la variable resultado concatenamos el signo $
-- asignamos nuestra variable costo_total que es la que contiene los datos que queremos traer, por último hacemos el retorno de la variable
-- resultado. 

DELIMITER $$
CREATE FUNCTION fn_costo_reparacion (p_mes INT, p_anio INT)
RETURNS TEXT DETERMINISTIC
BEGIN 
	DECLARE costo_total FLOAT; 
    DECLARE resultado TEXT;
    
    SELECT SUM(repair_cost) INTO costo_total
    FROM drone_maintenance
    WHERE MONTH(maintenance_date) = p_mes
	AND YEAR(maintenance_date) = p_anio;
    
    SET resultado = CONCAT ('$', costo_total);
    RETURN (resultado);
END$$

DELIMITER ;

SELECT fn_costo_reparacion(2, 2024) AS costo_febrero;

-- CREACIÓN DE PROCEDIMIENTOS

-- Creación de procedimiento sp_consumo_producto_por_mes
-- creamos el procedimiento para llevar la contabilidad por mes de litros gastados de nuestros productos utilizados para realizar el trabajo.
-- Utilizamos dos paramentros de entrada, luego generamos la consulta, llamando a todos los campos que queremos traer 
-- de las diferentes tablas involucradas, utilizando la función SUM para sumar los litros utilizados y los precios por listros a los que le 
-- asignamos el alias 'costo_total',utilizando JOIN hacemos la UNION entre los datos de ambas tablas. 
-- Luego a traves del filtro WHERE comparamos los datos de realización de servicio, con los datos ingresados
-- en los parametros, si hay registros en el mes y año que ingresamos en los paramentros, nos mostrará los datos que hemos pedido previamente 
-- en el select.
drop procedure sp_consumo_producto_por_mes
DELIMITER //

CREATE PROCEDURE sp_consumo_producto_por_mes(
      IN p_anio INT,
      IN p_mes INT
    
)
BEGIN
    SELECT ac.type_of_chemical, ac.price_per_liter, SUM(sc.liters_used) AS total_litros_utilizados,
           CONCAT('$ ',ROUND(SUM(sc.liters_used * ac.price_per_liter),2)) AS costo_total, p_mes AS mes, p_anio AS anio
    FROM service_completed sc
    JOIN agro_chemical ac ON sc.id_agro_chemical = ac.id_agro_chemical
    WHERE YEAR(sc.date_of_realization) = p_anio
          AND MONTH(sc.date_of_realization) = p_mes
    GROUP BY
        ac.type_of_chemical, ac.price_per_liter;
END //

DELIMITER ;

CALL sp_consumo_producto_por_mes(2024, 4);
CALL sp_consumo_producto_por_mes(2024, 5);

-- CREACIÓN DE PROCEDIMIENTO sp_registro_mantenimiento_dron
-- Creado para poder obtener los datos de mantenimientos de los equipos en un determinado período, que pasamos a traves de parametros fechas. 
-- Se crea el procedimiento, creamos dos parametros de tipo DATE, seleccionamos los campos de las diferentes tablas que queremos traer 
-- en la consulta , y a traves de la sentencia WHERE pasamos el campo donde vamos a buscar y con BETWEEN le damos valores a los parametros,
-- desde y hasta que fecha buscar.

DELIMITER //
CREATE PROCEDURE sp_registro_mantenimiento_dron(
	IN p_fecha_inicial DATE,
    IN p_fecha_final DATE
)
BEGIN
	SELECT dm.id_maintenance, d.id_drone, mt.name_technical, mt.last_name_technical, dm.maintenance_date, dm.report, dm.repair_cost 
    FROM drone_maintenance dm
    JOIN drone d ON dm.id_drone = d.id_drone
    JOIN mechanical_technical mt ON dm.id_technical = mt.id_technical
	WHERE dm.maintenance_date 
    BETWEEN p_fecha_inicial 
    AND p_fecha_final
    ORDER BY maintenance_date ASC;
END //
DELIMITER ;


CALL sp_registro_mantenimiento_dron ('2023-12-12', '2024-07-19');


-- CREACION DE TRIGGERS 

-- Trigger TRG_ACTUALIZAR_STOCK_AGROQUIMICOS 
-- Creado para llevar el control de consumo en litros de productos agroquimicos y a su vez controlar el stock disponible de los mismos. 

DELIMITER //
CREATE TRIGGER trg_actualizar_stock_agroquimicos
	AFTER INSERT ON service_completed
	FOR EACH ROW
BEGIN
    UPDATE agro_chemical
    SET liters_in_stock = liters_in_stock - NEW.liters_used
    WHERE id_agro_chemical = NEW.id_agro_chemical;
END //
DELIMITER ;


 -- ESTE COMENTARIO ES UNA CONSULTA Y UN INSERT UTILIZADO COMO PRUEBA DE FUNCIONAMIENTO DEL TRIGGER
/*SELECT id_agro_chemical, type_of_chemical, liters_in_stock
FROM agro_chemical
WHERE id_agro_chemical = 3;

INSERT INTO service_completed (id_service, id_pilot, date_of_realization, commets, id_location, id_drone, liters_used, id_agro_chemical)
VALUES (11, 5, '2024-03-10', 'Prueba de trigger', 11, 4, 70.0, 3); */


CREATE TABLE IF NOT EXISTS CONTRACTED_SERVICE_AUDITORIA (
    id_cs_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    accion VARCHAR (15),
    nombre_tabla VARCHAR (50),
    usuario VARCHAR (70),
    fecha_modificacion DATETIME
);

CREATE TABLE IF NOT EXISTS CONTRACTED_SERVICE_AUDITORIA_2 (
    id_cs_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    camponuevo_campoanterior VARCHAR (200),
    accion VARCHAR (15),
    nombre_tabla VARCHAR (50),
    usuario VARCHAR (70),
    fecha_modificacion DATETIME
);

DELIMITER //


CREATE TRIGGER trg_contracted_service_auditoria
AFTER UPDATE ON contracted_service
FOR EACH ROW
BEGIN
    INSERT INTO CONTRACTED_SERVICE_AUDITORIA (accion, nombre_tabla, usuario, fecha_modificacion) 
    VALUES ('UPDATE', 'CONTRACTED_SERVICE', USER(), NOW());
END //
DELIMITER ;

DELIMITER //


CREATE TRIGGER trg_contracted_service_auditoria_2
AFTER UPDATE ON contracted_service
FOR EACH ROW
BEGIN
    IF OLD.service_status <> NEW.service_status THEN
        INSERT INTO CONTRACTED_SERVICE_AUDITORIA_2 (camponuevo_campoanterior, accion, nombre_tabla, usuario, fecha_modificacion) 
        VALUES (CONCAT('CAMPO NUEVO: ', NEW.service_status, ', ID_NUEVO: ', NEW.id_service, ', CAMPO ANTERIOR: ', OLD.service_status, ', ID_ANTERIOR: ', OLD.id_service),
                'UPDATE',
                'CONTRACTED_SERVICE',
                USER(),
                NOW());
    END IF;
END //
DELIMITER ;


SELECT id_service, service_status FROM contracted_service WHERE id_service = 2;

SELECT * FROM CONTRACTED_SERVICE_AUDITORIA WHERE id_cs_auditoria = 2;

SELECT * FROM CONTRACTED_SERVICE_AUDITORIA_2 WHERE id_cs_auditoria = 2;

UPDATE contracted_service SET service_status = 'COMPLETADO' WHERE id_service = 2;


/* DEJO ESTE COMENTARIO CON RESPECTO A MI ULTIMO TRIGGER, TODO PARECE ESTAR BIEN O AL MENOS NO CONSIGO ENCONTRAR EL ERROR, SI PODRÍAN 
CORREGIRMELO SERÍA GENIAL. TENGO CREADAS AMBAS TABLAS DE AUDITORIAS Y ME APARECEN VACIAS CUANDO LAS CONSULTO, COMO DEBERÍA SER, PERO
CUANDO QUIERO HACER EL UPDATE PARA CAMBIAR EL REGISTRO DEL CAMPO Y VER COMO REACCIONAN LAS TABLAS DE AUDITORÍAS, ME TIRA ESTE ERROR
'Error Code: 1146. Table 'agrodron.contracted_service_audit' doesn't exist'. NO TENGO NINGUNA TABLA CREADA DE ESA MANERA, POR LO CUAL 
ME RESULTA BASTANTE RARO, O NO ME ESTARÍA DANDO CUENTA DE LO QUE SUCEDE. ES MARTES 8:23 PM Y ME QUEDO SIN TIEMPO POR ESO ENTREGO DE ESTA MANERA.
