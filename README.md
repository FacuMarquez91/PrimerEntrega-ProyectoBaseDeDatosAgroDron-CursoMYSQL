DROP SCHEMA IF EXISTS agrodron;
CREATE SCHEMA agrodron;
USE agrodron;

CREATE TABLE customers(
id_customer INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
name_1 VARCHAR (30) NOT NULL,
last_name VARCHAR (30) NOT NULL,
phone  INT NOT NULL,
address VARCHAR (50) NOT NULL,
registration_date  DATE
);

ALTER TABLE customers MODIFY phone VARCHAR (15) NOT NULL;
ALTER TABLE customers ADD COLUMN email VARCHAR (30) NOT NULL;

INSERT INTO customers (name_1, last_name, phone, address, registration_date, email) 
VALUES 
('Pablo', 'Ortigoza', 3443658974, 'Posadas 450', '2016-12-23', 'pablo32@pepe.com'),
('Andrea', 'Martinez', 3446598456, '3 de febrero 1934', '2019-08-25','andreMartinez@pepe.com'),
('Lautaro', 'Gomez', 344598762, 'Mariano Moreno 89', '2022-05-01','LautiGomez@pepe.com'),
('Oscar', 'Ervitti', 3442596515, 'Artusi 476', '2021-02-04', 'ErvitiOscar@pepe.com'),
('Carlos', 'Echeverría', 3445895614, 'Urquiza 1256', '2017-03-14', 'EcheverriaC@pepe.com'),
('Erica', 'Nisman', 3445987515, 'Alberdi 2376', '2020-06-19','EricaN@pepe.com'),
('Natalia', 'Godoy', 3442598745, 'Sarmiento 23', '1997-11-26','NataliaG@pepe.com'),
('Sandra', 'Mendoza', 3447589823, 'Guemes 2012', '2005-10-08','MendozaSan@pepe.com'),
('Pilar', 'Marquez', 3442515185, '25 de agosto 2289', '2023-05-21','MarquezPili@pepe.com'),
('Guillermo', 'Duarte', 3445686954, 'Pedro Cazzulino 443', '2013-07-10','GuilleDuarte@pepe.com');






CREATE TABLE location (
id_location INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_customer INT,
hectares INT NOT NULL,
coordinates VARCHAR(50) NOT NULL,
crop_type VARCHAR (35),
soil_condition VARCHAR (30), -- DESCRIPCIÓN DEL SUELO (BUENO, NORMAL, DAÑADO)
CONSTRAINT FK_LOCATION_CUSTOMERS FOREIGN KEY (id_customer) REFERENCES customers(id_customer)
);

ALTER TABLE location ADD COLUMN province VARCHAR (30) NOT NULL;
ALTER TABLE location ADD COLUMN city VARCHAR  (50) NOT NULL;

INSERT INTO location (id_customer, hectares, coordinates, crop_type, soil_condition, province, city)  
VALUES  
(1, 50, '-34.6037, -58.3816', 'Soja', 'BUENO', 'Buenos Aires', 'La Plata'),
(2, 120, '-31.4201, -64.1888', 'Maíz', 'NORMAL', 'Córdoba', 'Córdoba'),
(3, 75, '-32.8895, -68.8458', 'Trigo', 'DAÑADO', 'Mendoza', 'Mendoza'),
(4, 30, '-27.4698, -58.8306', 'Girasol', 'MUY DAÑADO', 'Chaco', 'Resistencia'),
(5, 200, '-24.7912, -65.4106', 'Caña de azúcar', 'BUENO', 'Salta', 'Salta'),
(6, 95, '-33.0349, -61.5297', 'Algodón', 'NORMAL', 'Santa Fe', 'Rosario'),
(7, 60, '-36.6167, -64.2833', 'Cebada', 'DAÑADO', 'La Pampa', 'Santa Rosa'),
(8, 150, '-35.4674, -69.5845', 'Sorgo', 'BUENO', 'San Luis', 'San Luis'),
(9, 85, '-29.4111, -66.8507', 'Alfalfa', 'NORMAL', 'La Rioja', 'La Rioja'),
(10, 45, '-34.9214, -57.9545', 'Maní', 'MUY DAÑADO', 'Buenos Aires', 'Mar del Plata');






CREATE TABLE drones (
id_drone INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
model VARCHAR (50), -- MODELO DE LOS DRONES
maximum_range VARCHAR (15), -- ALCANCE MAXIMO EN HECTAREAS
ability DECIMAL (10, 2), -- CAPACIDAD EN LITROS QUE POSEE EL DRON
type_of_service VARCHAR (20) -- TIPOS DE SERVICIOS (FERTILIZACIÓN, CONTROL DE PLAGAS , AMBOS )

);

INSERT INTO drones (model, maximum_range, ability, type_of_service)  
VALUES  
('DJI Agras T30', '30 ha', 30.00, 'FERTILIZACIÓN'),
('XAG P100', '40 ha', 40.50, 'CONTROL DE PLAGAS'),
('Yuneec H520E', '25 ha', 25.75, 'AMBOS'),
('DJI Agras T20', '35 ha', 32.00, 'FERTILIZACIÓN'),
('Parrot Bluegrass', '20 ha', 20.00, 'CONTROL DE PLAGAS'),
('XAG V40', '50 ha', 48.00, 'AMBOS'),
('DJI Phantom 4 RTK', '15 ha', 12.50, 'CONTROL DE PLAGAS'),
('Hylio AG-110', '45 ha', 42.30, 'FERTILIZACIÓN'),
('TTA M6E-1', '55 ha', 53.80, 'AMBOS'),
('XAG R150', '60 ha', 58.90, 'FERTILIZACIÓN');



CREATE TABLE pilots (
id_pilot INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
name_pilot VARCHAR (30) NOT NULL,
last_name_pilot VARCHAR (30) NOT NULL,
phone INT NOT NULL,
email VARCHAR (50) NOT NULL,
license_type VARCHAR (50), -- TIPO DE LICENCIA DE VUELO (BÁSICA, MEDIA, AVANZADA)
experience VARCHAR (20), -- AÑOS DE EXPERIENCIA 
registration_date DATE
);

INSERT INTO pilots (name_pilot, last_name_pilot, phone, email, license_type, experience, registration_date)  
VALUES  
('Carlos', 'Fernández', 344365897, 'c.fernandez@email.com', 'AVANZADA', '10 años', '2015-06-12'),
('María', 'Gómez', 344659845, 'm.gomez@email.com', 'MEDIA', '5 años', '2018-09-23'),
('Javier', 'Pérez', 344598762, 'j.perez@email.com', 'BÁSICA', '2 años', '2021-04-15'),
('Luciana', 'Martínez', 344259651, 'l.martinez@email.com', 'AVANZADA', '12 años', '2013-11-30'),
('Fernando', 'Ruiz', 344589561, 'f.ruiz@email.com', 'MEDIA', '6 años', '2017-07-19'),
('Andrea', 'Sosa', 344598751, 'a.sosa@email.com', 'BÁSICA', '3 años', '2020-02-25'),
('Gustavo', 'Duarte', 344259874, 'g.duarte@email.com', 'AVANZADA', '15 años', '2010-08-05'),
('Patricia', 'Mendoza', 344758982, 'p.mendoza@email.com', 'MEDIA', '8 años', '2016-03-22'),
('Ezequiel', 'Navarro', 344251518, 'e.navarro@email.com', 'BÁSICA', '4 años', '2019-10-11'),
('Valeria', 'Ortiz', 344568695, 'v.ortiz@email.com', 'AVANZADA', '11 años', '2014-05-17');

SELECT * FROM drones;
CREATE TABLE contracted_services (
id_service INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_customer INT NOT NULL,
id_location INT NOT NULL,
id_drone INT NOT NULL,
hiring_date DATE NOT NULL,
type_of_work VARCHAR (50) NOT NULL, 
service_status VARCHAR (50) NOT NULL, -- estado del servicio (pendiente, en proceso, completado)
CONSTRAINT FK_CONTRACTED_SERVICES_CUSTOMERS FOREIGN KEY (id_customer) REFERENCES customers (id_customer),
CONSTRAINT FK_CONTRACTED_SERVICES_LOCATION FOREIGN KEY (id_location) REFERENCES location (id_location),
CONSTRAINT FK_CONTRACTED_SERVICES_DRONES FOREIGN KEY (id_drone) REFERENCES drones (id_drone)
);

INSERT INTO contracted_services (id_customer, id_location, id_drone, hiring_date, type_of_work, service_status)  
VALUES  
(1, 1, 3, '2024-01-10', 'Fertilización de cultivos', 'PENDIENTE'),
(2, 2, 5, '2023-12-15', 'Control de plagas en maíz', 'EN PROCESO'),
(3, 3, 1, '2023-11-20', 'Aplicación de herbicidas', 'COMPLETADO'),
(4, 4, 7, '2024-02-01', 'Monitoreo de suelos', 'PENDIENTE'),
(5, 5, 6, '2023-10-05', 'Fertilización foliar', 'COMPLETADO'),
(6, 6, 2, '2024-01-25', 'Control biológico de plagas', 'EN PROCESO'),
(7, 7, 4, '2023-09-12', 'Siembra de cultivos', 'COMPLETADO'),
(8, 8, 8, '2024-02-02', 'Aplicación de fungicidas', 'PENDIENTE'),
(9, 9, 9, '2023-12-28', 'Fertilización de trigo', 'EN PROCESO'),
(10, 10, 10, '2023-11-08', 'Monitoreo de plagas', 'COMPLETADO');



CREATE TABLE services_completed (
id_service_completed INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_service INT NOT NULL,
id_pilot INT NOT NULL,
date_of_realization DATE NOT NULL,
commets TEXT, -- comentarios sobre el trabajo realizado
CONSTRAINT FK_SERVICES_COMPLETED_CONTRACTED_SERVICES FOREIGN KEY (id_service) REFERENCES contracted_services(id_service)
);

ALTER TABLE services_completed ADD CONSTRAINT FK_SERVICES_COMPLETED_PILOTS FOREIGN KEY (id_pilot) REFERENCES pilots (id_pilot);

INSERT INTO services_completed (id_service, id_pilot, date_of_realization, commets)  
VALUES  
(21, 3, '2024-01-15', 'Fertilización realizada con éxito. No se reportaron problemas durante la aplicación.'),
(22, 5, '2023-12-20', 'Control de plagas exitoso. Se usaron técnicas avanzadas para plagas resistentes.'),
(23, 1, '2023-11-25', 'Herbicidas aplicados correctamente. Se observó una excelente cobertura en la zona.'),
(24, 7, '2024-02-05', 'Monitoreo de suelos completo. Se recolectaron muestras para análisis posteriores.'),
(25, 9, '2023-10-10', 'Fertilización foliar exitosa. Las plantas mostraron signos de mejora rápidamente.'),
(26, 2, '2024-01-30', 'Control biológico de plagas realizado de forma eficaz. Los resultados fueron positivos.'),
(27, 6, '2023-09-18', 'Siembra de cultivos realizada sin complicaciones. El dron cubrió el área adecuadamente.'),
(28, 4, '2024-02-07', 'Aplicación de fungicidas completada. Los cultivos están ahora protegidos contra infecciones.'),
(29, 8, '2023-12-30', 'Fertilización de trigo realizada con éxito. El crecimiento del trigo debería mejorar notablemente.'),
(30, 10, '2023-11-12', 'Monitoreo de plagas realizado con precisión. No se detectaron plagas adicionales');


SELECT * FROM contracted_services;

CREATE TABLE billing (
id_bill INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_customer INT NOT NULL,
amount DECIMAL (10, 2) NOT NULL,
issue_date DATE NOT NULL,
payment_status VARCHAR (20), -- ESTADO DE PAGO (PENDIENTE , PAGADO)
CONSTRAINT FK_BILLING_CUSTOMERS FOREIGN KEY (id_customer) REFERENCES customers (id_customer)
);

INSERT INTO billing (id_customer, amount, issue_date, payment_status)  
VALUES  
(1, 500.00, '2024-01-15', 'PENDIENTE'),
(2, 750.00, '2023-12-20', 'PAGADO'),
(3, 600.50, '2023-11-25', 'PENDIENTE'),
(4, 450.75, '2024-02-05', 'PAGADO'),
(5, 320.00, '2023-10-10', 'PAGADO'),
(6, 890.00, '2024-01-30', 'PAGADO'),
(7, 1000.00, '2023-09-18', 'PENDIENTE'),
(8, 400.00, '2024-02-07', 'PAGADO'),
(9, 620.25, '2023-12-30', 'PENDIENTE'),
(10, 520.00, '2023-11-12', 'PAGADO');


CREATE TABLE drone_maintenance (
id_maintenance INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
id_drone INT NOT NULL,
id_technical INT NOT NULL,
maintenance_date DATE NOT NULL,
report TEXT NOT NULL,
CONSTRAINT FK_DRONE_MAINTENANCE_DRONES FOREIGN KEY (id_drone) REFERENCES drones (id_drone)

);

ALTER TABLE drone_maintenance ADD CONSTRAINT FK_DRONE_MAINTENANCE_MECHANICAL_TECHNICIANS FOREIGN KEY (id_technical) REFERENCES mechanical_technicians(id_technical);

INSERT INTO drone_maintenance (id_drone, id_technical, maintenance_date, report)  
VALUES  
(1, 3, '2024-01-10', 'Mantenimiento preventivo realizado. Se revisaron las hélices y el sistema de propulsión. Todo en orden.'),
(2, 5, '2023-12-15', 'Reemplazo de batería y revisión del sistema de control. Se realizaron ajustes menores.'),
(3, 2, '2023-11-20', 'Mantenimiento de rutina completado. Se verificó el sistema de cámaras y la calibración del dron.'),
(4, 7, '2024-02-01', 'Reemplazo de sensores y actualización de software. Sin problemas durante la inspección.'),
(5, 6, '2023-10-05', 'Verificación del sistema de navegación. Se calibraron las brújulas y el GPS. Todo en condiciones óptimas.'),
(6, 8, '2024-01-25', 'Inspección de los sistemas eléctricos y mecánicos. Se encontró un fallo menor en el sistema de baterías.'),
(7, 4, '2023-09-12', 'Mantenimiento general realizado. Se limpiaron y ajustaron las hélices. El dron está listo para su uso.'),
(8, 3, '2024-02-02', 'Revisión del sistema de control de vuelo y calibración de cámaras. Todo funciona correctamente.'),
(9, 9, '2023-12-28', 'Reemplazo de piezas desgastadas y ajuste de motores. El dron está en perfecto estado.'),
(10, 10, '2023-11-08', 'Inspección completa realizada. Se encontraron pequeños desgastes en las hélices, pero no afectan el rendimiento.');


CREATE TABLE mechanical_technicians (
id_technical INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
name_technical VARCHAR (30) NOT NULL,
last_name_technical VARCHAR (40) NOT NULL,
phone INT NOT NULL,
speciality VARCHAR (50), -- especialidad (mantenimiento de drones , electrónica)
registration_date DATE
);

ALTER TABLE mechanical_technicians ADD COLUMN email VARCHAR (50) NOT NULL ;
ALTER TABLE mechanical_technicians MODIFY COLUMN phone VARCHAR (15) NOT NULL;

INSERT INTO mechanical_technicians (name_technical, last_name_technical, phone, speciality, registration_date, email) 
VALUES 
('Carlos', 'Pérez', 3445678901, 'Mantenimiento de drones', '2020-05-10', 'carlos.perez@email.com'),
('Ana', 'Martínez', 3446543210, 'Electrónica', '2018-02-15', 'ana.martinez@email.com'),
('Luis', 'Gómez', 3445987532, 'Mantenimiento de drones', '2019-11-25', 'luis.gomez@email.com'),
('Marta', 'Fernández', 3445098764, 'Electrónica', '2021-01-30', 'marta.fernandez@email.com'),
('Pedro', 'Díaz', 3442589634, 'Mantenimiento de drones', '2020-08-05', 'pedro.diaz@email.com'),
('Javier', 'Rodríguez', 3445672345, 'Electrónica', '2022-03-14', 'javier.rodriguez@email.com'),
('Sofia', 'García', 3447890123, 'Mantenimiento de drones', '2017-07-18', 'sofia.garcia@email.com'),
('Diego', 'López', 3447456789, 'Electrónica', '2021-11-02', 'diego.lopez@email.com'),
('Paula', 'Sánchez', 3448790345, 'Mantenimiento de drones', '2019-06-11', 'paula.sanchez@email.com'),
('Antonio', 'Torres', 3446654321, 'Electrónica', '2020-09-25', 'antonio.torres@email.com');
