/* INICIO DB */
-- Eliminando la BD por si existe
IF DB_ID('TIENDA_INFORMATICA') is not null
   DROP DATABASE TIENDA_INFORMATICA
GO

-- Creamos la base de datos
CREATE DATABASE TIENDA_INFORMATICA
GO

-- Usamos la base de datos "TIENDA_INFORMATICA"
USE TIENDA_INFORMATICA
GO

/* INICIO */
-- Tablas de la tienda

-- TABLA FABRICANTE
CREATE TABLE FABRICANTE (
	Codigo INT IDENTITY		PRIMARY KEY,
	Nombre NVARCHAR(100)
);
GO

-- TABLA ARTICULOS
CREATE TABLE ARTICULOS (
	Codigo		INT IDENTITY	PRIMARY KEY,
	Nombre		NVARCHAR(100),
	Precio		INT,
	Fabricante	INT,
	FOREIGN KEY (FABRICANTE) REFERENCES FABRICANTE(Codigo)
);
GO

INSERT INTO FABRICANTE (Nombre)
VALUES ('Samsung Electronics');

INSERT INTO FABRICANTE (Nombre)
VALUES ('Apple Inc');

INSERT INTO FABRICANTE (Nombre)
VALUES ('Sony Corporation');

INSERT INTO FABRICANTE (Nombre)
VALUES ('LG Electronics');

SELECT * FROM FABRICANTE

-- insercion de valores para el fabricante Samsung Electronics
INSERT INTO ARTICULOS VALUES
	('Smartphone Galaxy S21', 999.99, 1),
	('Smart TV QLED 55"', 1499.99, 1),
	('Tablet Galaxy Tab S7', 799.99, 1),
	('Refrigerador Side-by-Side', 1999.99, 1),
	('Monitor Gaming Curvo 27"', 599.99, 1)
GO

SELECT * FROM ARTICULOS

-- insercion de valores para el fabricante Apple Inc
INSERT INTO ARTICULOS VALUES
    ('iPhone 13 Pro', 1299.99, 2),
    ('MacBook Pro 16"', 2399.99, 2),
    ('AirPods Pro', 249.99, 2),
    ('Apple Watch Series 6', 399.99, 2),
    ('iPad Pro 12.9"', 1099.99, 2);

-- insercion de valores para el fabricante Sony Corporation
INSERT INTO ARTICULOS VALUES
    ('PlayStation 5', 499.99, 3),
    ('Bocinas inalámbricas', 199.99, 3),
    ('Cámara Alpha a7 III', 1799.99, 3),
    ('Televisor OLED 65"', 2499.99, 3),
    ('Barra de sonido Dolby Atmos', 799.99, 3);

-- insercion de valores para el fabricante LG Electronics
INSERT INTO ARTICULOS VALUES
    ('Lavadora de carga frontal', 899.99, 4),
    ('Reproductor de Blu-ray 4K', 199.99, 4),
    ('Monitor Ultrawide 34"', 699.99, 4),
    ('Horno de microondas', 149.99, 4),
    ('Proyector 4K UHD', 1299.99, 4);
GO

SELECT * FROM ARTICULOS
SELECT Codigo, Nombre FROM FABRICANTE

-- 1.1 Obtener los nombres de los productos de la tienda
SELECT Nombre 
FROM ARTICULOS

-- 1.2 Obtener los nobmres y los precios de los productos de la tienda
SELECT Nombre, Precio FROM ARTICULOS

-- 1.3 Obtener el nombre de los productos cuyo precio sea menor o igual a 200
SELECT Nombre FROM ARTICULOS WHERE Precio > 200

-- 1.4 Obtener todos los datos de los artículos cuyo precio esté entre los 60 y los 120 (ambas cantidades incluidas)
/* Con AND */
SELECT * FROM ARTICULOS
WHERE Precio >= 60 AND Precio <= 120

/* Con BETWEEN */
SELECT * FROM ARTICULOS
WHERE Precio BETWEEN 60 AND 120

-- 1.5 Obtener el nombre y el precio en pesetas (es decir, el precio en euros multiplicado por 166’386)
/* Sin AS */
SELECT Nombre, Precio * 166.386 FROM ARTICULOS

/* Con AS */
SELECT Nombre, Precio * 166.386 AS PrecioPtas FROM ARTICULOS

-- 1.6. Seleccionar el precio medio de todos los productos.
SELECT AVG(Precio) FROM ARTICULOS

-- 1.7. Obtener el precio medio de los artículos cuyo código de fabricante sea 2.
SELECT AVG(Precio) FROM ARTICULOS WHERE Fabricante=2

-- 1.8. Obtener el numero de art´ıculos cuyo precio sea mayor o igual a 180
SELECT COUNT(*) FROM ARTICULOS WHERE Precio >= 180

-- 1.9. Obtener el nombre y precio de los art´ıculos cuyo precio sea mayor o igual a 180 ¤ y 
-- ordenarlos descendentemente por precio, y luego ascendentemente por nombre.
SELECT Nombre, Precio FROM ARTICULOS
WHERE Precio >= 180
ORDER BY Precio DESC, Nombre

-- 1.10. Obtener un listado completo de artículos, incluyendo por cada artículo los datos del artículo y de su fabricante.
/* Sin INNER JOIN */
SELECT * FROM ARTICULOS, FABRICANTE
WHERE ARTICUlOS.Fabricante= FABRICANTE.Codigo

/* Con INNER JOIN */
SELECT * FROM ARTICULOS INNER JOIN FABRICANTE
ON ARTICULOS.Fabricante = FABRICANTE.Codigo	
/* Sin INNER JOIN */

--1.11. Obtener un listado de art´ıculos, incluyendo el nombre del art´ıculo, su precio, y el
--nombre de su fabricante
SELECT ARTICULOS.Nombre, Precio, FABRICANTE.Nombre FROM
ARTICULOS, FABRICANTE

WHERE ARTICULOS.Fabricante = FABRICANTE.Codigo

/* Con INNER JOIN */
SELECT ARTICULOS.Nombre, Precio, FABRICANTE.Nombre FROM
ARTICULOS INNER JOIN FABRICANTE
ON ARTICULOS.Fabricante = FABRICANTE.Codigo

-- 1.12. Obtener el precio medio de los productos de cada fabricante, mostrando solo los
-- c´ odigos de fabricante.
SELECT AVG(Precio), Fabricante FROM ARTICULOS
GROUP BY Fabricante


-- 1.13. Obtener el precio medio de los productos de cada fabricante, mostrando el nombre
-- del fabricante.
/* Sin INNER JOIN */
SELECT AVG(Precio), FABRICANTE.Nombre FROM ARTICULOS, FABRICANTE
	WHERE ARTICULOS.Fabricante = FABRICANTE.Codigo
GROUP BY FABRICANTE.Nombre
/* Con INNER JOIN */
SELECT AVG(Precio), FABRICANTE.Nombre FROM ARTICULOS INNER JOIN FABRICANTE
	ON ARTICULOS.Fabricante = FABRICANTE.Codigo
GROUP BY FABRICANTE.Nombre
 
-- 1.14. Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio medio
-- sea mayor o igual a 150 ¤.
/* Sin INNER JOIN */
SELECT AVG(Precio), FABRICANTE.Nombre FROM ARTICULOS, FABRICANTE
	WHERE ARTICULOS.Fabricante = FABRICANTE.Codigo
GROUP BY FABRICANTE.Nombre HAVING AVG(Precio) >= 150
/* Con INNER JOIN */
SELECT AVG(Precio), FABRICANTE.Nombre FROM ARTICULOS INNER JOIN FABRICANTE
	ON ARTICULOS.Fabricante = FABRICANTE.Codigo
GROUP BY FABRICANTE.Nombre HAVING AVG(Precio) >= 150

-- 1.15. Obtener el nombre y precio del art´ıculo m´ as barato.
SELECT Nombre, Precio 
	FROM ARTICULOS
	WHERE Precio = (SELECT MIN(Precio) FROM ARTICULOS)

-- 1.16. Obtener una lista con el nombre y precio de los art´ıculos m´ as caros de cada proveedor (incluyendo el nombre del proveedor).
/* Sin INNER JOIN */
SELECT A.Nombre, A.Precio, F.Nombre
	FROM ARTICULOS A, FABRICANTE F
	WHERE A.Fabricante = F.Codigo
		AND A.Precio =
		(
			SELECT MAX(A.Precio)
				FROM ARTICULOS A
				WHERE A.Fabricante = F.Codigo
		)
/* Con INNER JOIN */
SELECT A.Nombre, A.Precio, F.Nombre
	FROM ARTICULOS A INNER JOIN FABRICANTE F
	ON A.Fabricante = F.Codigo
		AND A.Precio =
		(
			SELECT MAX(A.Precio)
			FROM ARTICULOS A
			WHERE A.Fabricante = F.Codigo
		)
-- 1.17. An˜adir un nuevo producto: Altavoces de 70 ¤ (del fabricante 2)
INSERT INTO ARTICULOS( Nombre , Precio , Fabricante)
	VALUES ( 'Altavoces' , 70 , 2 )

--1.18. Cambiar el nombre del producto 8 a ’Impresora Laser’
UPDATE ARTICULOS
	SET Nombre = 'Impresora Laser'
	WHERE Codigo = 8
-- 1.19. Aplicar un descuento del 10 % (multiplicar el precio por 0’9) a todos los productos.
UPDATE ARTICULOS
	SET Precio = Precio * 0.9

-- 1.20. Aplicar un descuento de 10 ¤ a todos los productos cuyo precio sea
-- mayor o iguala 120 ¤.
UPDATE ARTICULOS
	SET Precio = Precio - 10
	WHERE Precio >= 120