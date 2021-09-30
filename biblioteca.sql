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

 CREATE TABLE autor_libro(
     id INT, 
     codi_autor INT,
     autor_id INT,
     FOREIGN KEY (codi_autor) REFERENCES libro(cod_autor)
 );

 CREATE TABLE autor(
     id INT,
     nombre VARCHAR,
     apellido VARCHAR,
     nacimiento_muerte VARCHAR,
     Tipo_autor VARCHAR,
     FOREIGN KEY (id) REFERENCES autor_libro(autor_id)
 );
 

-- Insertar registros en las tablas:
\copy libro FROM 'libro.csv' csv;
\copy socio FROM 'socios.csv' csv;
\copy historial FROM 'historial.csv' csv;

Ejercicio 3:
a) Mostrar todos los libros que posean menos de 300 páginas. 

biblioteca=# SELECT * FROM libros WHERE paginas < 300;

      isbn       |         titulo         | paginas | autor_id | coautor_id 
-----------------+------------------------+---------+----------+------------
 222-2222222-222 | POESÍAS CONTEMPORANEAS |     167 |        1 |           
 444-4444444-444 | MANUAL DE MECÁNICA     |     298 |        5 |           
(2 rows)

-----------------------------------------------------------------------------------------
b) Mostrar todos los autores que hayan nacido después del 01-01-1970.

biblioteca=# SELECT * FROM autor WHERE to_date(fecha_nacimiento, 'yyyy') < '01-01-1970'::date;
 autor_id | nombre | apellido | fecha_nacimiento | fecha_fallecimiento |   tipo    
----------+--------+----------+------------------+---------------------+-----------
        3 | JOSE   | SALGADO  | 1968             | 2020                | PRINCIPAL
        2 | SERGIO | MARDONES | 1950             | 2012                | PRINCIPAL
(2 rows)

----------------------------------------------------------------------------------------------------
c)¿Cuál es el libro más solicitado?

biblioteca=# SELECT isbn, COUNT(*) FROM prestamos GROUP BY isbn;
      isbn       | count 
-----------------+-------
 444-4444444-444 |     2
 111-1111111-111 |     2
 222-2222222-222 |     2
 333-3333333-333 |     1
(4 rows)

-----------------------------------------------------------------------------------------------------
d)Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.

SELECT socio_id, (fecha_devolucion - fecha_prestamo) * 100 AS deuda FROM historial;

