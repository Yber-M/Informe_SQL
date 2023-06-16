-- TRANSACIONES
Create database INFORME2023
go

--Activamos
use INFORME2023
go

/* INICIAMOS */
-- crear una tabla
create table USUARIO(
	cod_user int primary key not null,
	nam_user varchar(50),
	status_user char(1) --est 1:activo | 0:inactivo
)
go

-- Agregando los registro de forma directa
insert into USUARIO values(1, 'MYBER', '1')
---

-- Consulta a la tabla usuario
select * from USUARIO

-- Agregando los registro de forma directa
insert into USUARIO values(2, 'BERMY', '1')
insert into USUARIO values(3, 'JOSEA', '1')
insert into USUARIO values(4, 'JRICH', '1')
insert into USUARIO values(5, 'LOPEZ', '1')
insert into USUARIO values(6, 'EMANU', '1')
insert into USUARIO values(7, 'ZOTOM', '1')
---

-- Agregando de otra forma los registro de tablas
insert into USUARIO(cod_user, nam_user, status_user)
			values(8, 'EPACHES', '1')

insert into USUARIO(cod_user, nam_user, status_user)
			values(9, 'NOTORIBY', '1')

create table USUARIOUCV (
	cod_UCVuser int primary key not null,
	nom_UCVuser varchar(50),
	status_UCVuser char(1)
)
go

-- Insercción Múltiple
insert into USUARIOUCV(cod_UCVuser, nom_UCVuser, status_UCVuser)
		select cod_user, nam_user, status_user
		from USUARIO
		where status_user = '1'
go