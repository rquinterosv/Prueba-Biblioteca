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
