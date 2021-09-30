--psql -d template1
--para ver las bd \l

-- Crear una base de datos, considerando las tablas: 
DROP DATABASE biblioteca;

CREATE DATABASE biblioteca;
\c biblioteca;

CREATE TABLE libro (
    id INT PRIMARY KEY,
    ISBN VARCHAR,
    Titulo VARCHAR,
    Q_Paginas VARCHAR,
    cod_autor VARCHAR,
    nombre VARCHAR,
    apellido VARCHAR,
    nacimiento_muerte VARCHAR,
    Tipo_autor VARCHAR,
    dias_prestamo VARCHAR
); 

CREATE TABLE historial(
    id INT PRIMARY KEY,
    socio VARCHAR,
    libro VARCHAR,
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    id_libro INT,
    id_socio INT,
    FOREIGN KEY (id_libro) REFERENCES libro(id),
    FOREIGN KEY (id_socio) REFERENCES socio(id)
);

 CREATE TABLE socio(
     id INT PRIMARY KEY,
     RUT VARCHAR,
     nombre VARCHAR,
     apellido VARCHAR,
     direccion VARCHAR,
     telefono VARCHAR
 );


CREATE TABLE autor(
  autor_id serial PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  fecha_nacimiento VARCHAR(4),
  fecha_fallecimiento VARCHAR(4),
  tipo VARCHAR(100)
);
 

-- Insertar registros en las tablas:
\copy libro FROM 'libro.csv' csv;
\copy socio FROM 'socios.csv' csv;
\copy historial FROM 'historial.csv' csv;

iNSERT INTO autor(autor_id, nombre, apellido, fecha_nacimiento, fecha_fallecimiento, tipo) VALUES (3, 'JOSE', 'SALGADO', '1968', '2020', 'PRINCIPAL');
INSERT INTO autor(autor_id, nombre, apellido, fecha_nacimiento, fecha_fallecimiento, tipo) VALUES (4, 'ANA', 'SALGADO', '1972', '', 'COAUTOR');
INSERT INTO autor(autor_id, nombre, apellido, fecha_nacimiento, fecha_fallecimiento, tipo) VALUES (1, 'ANDRÉS', 'ULLOA', '1982', '', 'PRINCIPAL');
INSERT INTO autor(autor_id, nombre, apellido, fecha_nacimiento, fecha_fallecimiento, tipo) VALUES (2, 'SERGIO', 'MARDONES', '1950', '2012', 'PRINCIPAL');
INSERT INTO autor(autor_id, nombre, apellido, fecha_nacimiento, fecha_fallecimiento, tipo) VALUES (5, 'MARTIN', 'PORTA', '1976', '', 'PRINCIPAL');


Ejercicio 3:
a) Mostrar todos los libros que posean menos de 300 páginas. 

SELECT * FROM libro WHERE q_paginas < '300';

-----------------------------------------------------------------------------------------
b) Mostrar todos los autores que hayan nacido después del 01-01-1970.

SELECT * FROM autor WHERE to_date(fecha_nacimiento, 'yyyy') < '01-01-1970'::date;


----------------------------------------------------------------------------------------------------
c)¿Cuál es el libro más solicitado?

SELECT isbn, COUNT(*) FROM libro GROUP BY isbn;


-----------------------------------------------------------------------------------------------------
d)Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.

SELECT id_socio, (fecha_devolucion - fecha_prestamo) * 100 AS deuda FROM historial;

