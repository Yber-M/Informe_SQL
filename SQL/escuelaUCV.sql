use master
go
---eliminando la bd si existe
if DB_ID('BD_ESCUELAUCV') is not null
   drop database bd_escuelaucv
go
--crear bd
create database bd_escuelaucv
go
---activando la bd
use bd_escuelaucv
go
---crear las tablas
create table curso
( idcurso  char(5) not null primary key,
  nombrecurso varchar(15) not null,
  horasteoricas numeric not null,
  horaspracticas numeric not null,
  nivel     char(1) not null,
  grado     char(1) not null
)
go

create table docente
( iddocente  char(5) not null primary key,
  nombre     varchar(25) not null,
  apellidos  varchar(35) not null,
  direccion  varchar(50) not null,
  telefono   varchar(12),
  DNI   varchar(8) not null,
  especialidad varchar(8) not null,
  e_mail     varchar(50),
  sexo       char(1) not null
)
go

create table ubigeo
(  idubigeo  char(6) not null primary key,
   distrito  varchar(35) not null,
   provincia varchar(25) not null,
   departamento varchar(35) not null
)
go

create table alumno
( idalumno  char(5) not null primary key,
  nombre    varchar(25) not null,
  apellidos varchar(35) not null,
  fechanac  datetime  not null,
  telefono  varchar(12),
  sexo      char(1) not null,
  e_mail    varchar(50),
  idubigeo  char(6) not null references ubigeo
)
go

create table promedio
( idalumno  char(5) not null references alumno,
  idcurso   char(5) not null references curso,
  promedio  real,
  primary key(idalumno,idcurso)
)
go

create table asignacion
( iddocente   char(5) not null references docente,
  idcurso     char(5) not null references curso,
  seccion     char(1) not null,
  primary key(iddocente,idcurso)
)
go

create table notas
( idcurso char(5) not null references curso,
  idalumno char(5) not null references alumno,
  b1     float not null,
  b2     float not null,
  b3     float not null,
  b4     float not null,
  promedio float not null,
  primary key(idcurso,idalumno)
)  
go

------RESTRICCIONES--------------
--RESTRICCION POR DEFAULT: PREDETERMINADO
--ASIGNAR EL VALOR CERO AL B1,B2,B3,B4 DE LA TABLA NOTA
ALTER TABLE NOTAS
   ADD CONSTRAINT DF_NOTAB1 DEFAULT 0
FOR B1

ALTER TABLE NOTAS
   ADD CONSTRAINT DF_NOTAB2 DEFAULT 0
FOR B2

ALTER TABLE NOTAS
   ADD CONSTRAINT DF_NOTAB3 DEFAULT 0
FOR B3

ALTER TABLE NOTAS
   ADD CONSTRAINT DF_NOTAB4 DEFAULT 0
FOR B4

ALTER TABLE NOTAS
   ADD CONSTRAINT DF_PROMEDIO DEFAULT 0
FOR PROMEDIO
--ASIGNAR EL VALOR CERO AL CAMPO HORAS TEORICAS DE LA TABLA CURSO
ALTER TABLE CURSO
ADD CONSTRAINT DF_HT DEFAULT 0
FOR HORASTEORICAS
GO
--ASIGNAR EL VALOR CERO AL CAMPO HORAS PRACTICAS DE LA TABLA CURSO
ALTER TABLE CURSO
ADD CONSTRAINT DF_HP DEFAULT 0
FOR HORASPRACTICAS
GO
--ASIGNAR EL VALOR "NO REGISTRA" AL CAMPO EMAIL DE LA TABLA DOCENTE
ALTER TABLE DOCENTE
ADD CONSTRAINT DF_EMAIL DEFAULT 'NO REGISTRA'
FOR E_MAIL
GO
---->RESTRICCION CHECK
--EL CAMPO SEXO DE LA TABLA ALUMNO Y DOCENTE DEBE PERMITIR VALORES F Y M
ALTER TABLE ALUMNO
ADD CONSTRAINT CHK_SEXO CHECK(SEXO LIKE '[FM]')
GO

--EL CAMPO SEXO DE LA TABLA DOCENTE Y DOCENTE DEBE PERMITIR VALORES F Y M
ALTER TABLE DOCENTE
ADD CONSTRAINT CHK_SEXODOC CHECK(SEXO LIKE '[FM]')
GO

--EL CODIGO DEL ALUMNO DEBE COMENZAR CON LA LETRA A
ALTER TABLE ALUMNO
ADD CONSTRAINT CHK_IDA CHECK (IDALUMNO LIKE 'A[0-9][0-9][0-9][0-9]')
GO


ALTER TABLE DOCENTE
DROP CONSTRAINT DF_EMAIL

ALTER TABLE DOCENTE
ADD CONSTRAINT DF_EMAIL DEFAULT 'NO REGISTRA'
FOR E_MAIL
GO

--EL CODIGO DEL DOCENTE DEBE COMENZAR CON LA LETRA D
ALTER TABLE DOCENTE
ADD CONSTRAINT CHK_IDD CHECK (IDDOCENTE LIKE 'D[0-9][0-9][0-9][0-9]')
GO

--EL CODIGO DEL CURSO DEBE COMENZAR CON LA LETRA C
ALTER TABLE CURSO
ADD CONSTRAINT CHK_IDC CHECK (IDCURSO LIKE 'C[0-9][0-9][0-9][0-9]')
GO
--DEBE ACEPTAR VALOR MAYORES O IGUALES A CERO
ALTER TABLE CURSO
ADD CONSTRAINT CHK_CHT CHECK (HORASTEORICAS>=0)
GO
--EL CAMPO GRADO DEBE ACEPTAR VALORES MAYORES ENTRE 1 Y 6
ALTER TABLE CURSO
ADD CONSTRAINT CHK_GRADO CHECK (GRADO LIKE '[1-6]')
GO
--EL CAMPO NIVEL DEBE ACEPTAR VALOR COMO P Y S
ALTER TABLE CURSO
ADD CONSTRAINT CHK_CNIVEL CHECK (NIVEL IN('P','S'))
GO
--LOS CAMPOS B1 A B4 Y PROMEDIO DE LA TABLA NOTAS DEBE ACEPTAR
--VALORES DE 0 A 20
ALTER TABLE NOTAS
  ADD CONSTRAINT CHK_NB1 CHECK (B1>=0 AND B1<=20),
      CONSTRAINT CHK_NB2 CHECK (B2>=0 AND B2<=20),
	  CONSTRAINT CHK_NB3 CHECK (B3>=0 AND B3<=20),
	  CONSTRAINT CHK_NB4 CHECK (B4>=0 AND B4<=20),
	  CONSTRAINT CHK_NPROM CHECK (PROMEDIO>=0 AND PROMEDIO<=20)
GO
---APLICANDO UNIQUE
--EL CAMPO EMAIL DE LA TABLA DOCENTE DEBE SER UNICO
ALTER TABLE DOCENTE
ADD CONSTRAINT UQ_EMA
UNIQUE(E_MAIL)
GO

--EL CAMPO DIRECCION DE LA TABLA DOCENTE DEBE SER UNICO
ALTER TABLE DOCENTE
ADD CONSTRAINT UQ_DIRECCION
UNIQUE(DIRECCION)
GO

--EL CAMPO DNI DEBE SER UNICO
ALTER TABLE DOCENTE
ADD CONSTRAINT UQ_DNI
UNIQUE(DNI)
GO

--EL CAMPO DEPARTMENTO DE LA TABLA UBIGEO DEBE SER UNICO
ALTER TABLE UBIGEO
ADD CONSTRAINT UQ_DEPA
UNIQUE(DEPARTAMENTO)
GO
--------------------------------------
insert into curso values ('C0001','java',20,30,'P',5)
select * from  curso
insert into curso (idcurso,nombrecurso,nivel,grado)
               values ('C0002','php','S',3)

