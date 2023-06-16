use MARKETPERU
go

-- Funcion AVG
-- Precio unitario promedio de todos los productos 
select AVG(p.PrecioProveedor) as "precio promedio"	
from PRODUCTO p

-- precio unitario promedio de todos los productos que corresponda a la categoría 2
select AVG(p.PrecioProveedor) as "precio promedio categoria 2"
from PRODUCTO p
where p.IdCategoria=4

-- stock de los promedios de los productos cuyo precio unit es mayor a 10
select avg(p.StockActual) as "Promedio stock"
from PRODUCTO p
where p.PrecioProveedor > 10
go

-- Cuenta de los productos registrados en la tabla producto
select COUNT(*) as "cantidad producto"
from PRODUCTO

-- Cuenta los productos despechados a los diferentes locales de la empresa
select count(distinct(g.IdProducto)) as despachos
from GUIA_DETALLE g
go

-- precio mas alto, mas bajo y el promedio
select 
	min(p.PrecioProveedor) as "Precio Barato",
	max(p.PrecioProveedor) as "Precio caro",
	avg(p.PrecioProveedor) as "Precio Promedio"
from PRODUCTO p

-- guias de remision mas reciente y mas antigua
select 
	max(g.FechaSalida) as "Fecha reciente",
	min(g.FechaSalida) as "Fecha antigua"
from guia g
go

-- monto total de los productos saldios de alamce
select sum(g.PrecioVenta*g.Cantidad) as "Monto Total"
from GUIA_DETALLE g
go

-- stock valorado
select p.Nombre,p.PrecioProveedor*p.StockActual as valorizado
from producto p
go

-- Total de unidades despchadas del producto 7
select SUM(g.Cantidad) as "Despachados unidades"
from GUIA_DETALLE g
where g.IdProducto=7
go

-- Clausula group by
-- cantidad de productos registrados para cada categoría
select p.IdCategoria, 
	count(p.IdProducto) as "cant productos"
from PRODUCTO p
group by p.IdCategoria
go

-- cantidad de productos por proveedor para la categoría de 2 y 4
select 
	p.IdCategoria as categoria,
	p.IdProveedor as proveedor,
	COUNT(p.IdProducto) as "cant productos"
from PRODUCTO p
where p.IdCategoria IN (2,4)
group by p.IdCategoria, p.IdProveedor
order by p.IdCategoria asc
select * from CATEGORIA
select * from PROVEEDOR
select * from PRODUCTO

--Monto total despachado por producto
select g.IdProducto, sum(g.PrecioVenta*g.Cantidad) as "Monto total"
from GUIA_DETALLE g
group by g.IdProducto
order by "Monto total" desc
go

-- Productos cuyo monto total despachado es mayor a 20000
select g.IdProducto, 
	sum(g.PrecioVenta*g.Cantidad) as "Monto total"
from GUIA_DETALLE g
group by g.IdProducto
having sum(g.PrecioVenta*g.Cantidad)>20000
order by "Monto total" desc
go

-- mostrando el nombre del producto
select p.IdCategoria, c.Categoria,
	count(p.IdProducto) as "cant productos"
from PRODUCTO p inner join CATEGORIA c on (p.IdCategoria=c.IdCategoria)
group by p.IdCategoria, c.Categoria
go
-------------------------------------------------------------------------

-- Escriba una consulta que muestre  los datos de la cabecera de la 
-- guía de remision número 27 y además su monto total

select g.IdGuia, g.IdLocal, g.FechaSalida,
		monto=sum(x.Cantidad * x.PrecioVenta)
from GUIA g inner join GUIA_DETALLE x on (g.IdGuia = x.IdGuia)
group by g.IdGuia, g.IdLocal, g.FechaSalida
having g.IdGuia=27

go

-- Monto total enviado a cada local
-- Escriba una consulta que muiestre el monto total despachado a cada local
select l.Direccion,
	monto=sum(g.PrecioVenta*g.Cantidad)
from LOCAL l inner join GUIA x on (l.IdLocal=x.IdLocal)
		   inner join GUIA_DETALLE g on (x.IdGuia=g.IdGuia)
group by l.Direccion
go

-- Escriba una consulta que muestre el total de unidades despachadas por mes
-- del producto 27
select 
	YEAR(g.FechaSalida) as Año,
	MONTH(g.FechaSalida) as Mes,
	sum(x.Cantidad) as "Total Unidades"
from GUIA g inner join GUIA_DETALLE x on(g.IdGuia=x.IdGuia)
where x.IdProducto=27
group by YEAR(g.FechaSalida), MONTH(g.FechaSalida)
order by Año, Mes
go

-- Escriba una consulta que muestre el total de unidades menesuales despachadas de cada grupo
-- la consultas debe mostrar el nombre del producto
-- unidades mensuales despachadas de cada producto
select p.Nombre,
	YEAR(g.FechaSalida) as Año,
	MONTH(g.FechaSalida) as Mes,
	sum(x.Cantidad) as "Total Unidades"
from GUIA g inner join GUIA_DETALLE x on(g.IdGuia=x.IdGuia)
			inner join PRODUCTO p on (x.IdProducto=p.IdProducto)
group by p.Nombre, YEAR(g.FechaSalida), MONTH(g.FechaSalida)
order by p.Nombre, Año, Mes
go

-- SUB CONSULTAS(
-- Consulta devuelve el precio promedio de todos los productos
select AVG(p.PrecioProveedor)
from PRODUCTO p
go

-- Diferencia entre el precio promedio y el precio de cada producto
select p.IdProducto, p.Nombre, p.PrecioProveedor,
	   diferencia=p.PrecioProveedor - (select AVG(p.PrecioProveedor)
from PRODUCTO p)
from PRODUCTO p

-- Escriba una consulta que entregue una lista de los productos que
-- despacharon en la fecha que se despacho la última salida del almacen
-- Tenga en cuenta que en dicha fecha se puede haber registrado más de un salida

-- Fehca de la última salida
select max(g.FechaSalida) from guia g
-- Productos que se despacharon en la fehca de la consulta anterior
select distinct x.IdProducto, 
		p.Nombre,
		CONVERT(char(10), g.FechaSalida, 103) as Fecha
from GUIA g inner join GUIA_DETALLE x on(g.IdGuia=x.IdGuia)
			inner join PRODUCTO p on (x.IdProducto=p.IdProducto)
where CONVERT(char(10), g.FechaSalida, 103)=(
select CONVERT(char(10), max(g.FechaSalida), 103) from guia g)
go

select CONVERT(char(10), MAX(g.FechaSalida),103) from guia g

