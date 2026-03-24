-- Crear la base de datos
CREATE DATABASE TeChineoTuLomito;
GO

-- Usar la base de datos
USE TeChineoTuLomito;
GO

-- Crear el esquema (válido, sin guiones)
CREATE SCHEMA TeChineoTuLomito_Schema;
GO

-- Tabla Persona (base)
CREATE TABLE TeChineoTuLomito_Schema.Persona (
    identificacion NVARCHAR(50) NOT NULL PRIMARY KEY,
    nombreCompleto NVARCHAR(200) NOT NULL
);

-- Tabla Cliente (hereda de Persona)
CREATE TABLE TeChineoTuLomito_Schema.Cliente (
    identificacion NVARCHAR(50) NOT NULL PRIMARY KEY,
    provincia NVARCHAR(100) NOT NULL,
    canton NVARCHAR(100) NOT NULL,
    distrito NVARCHAR(100) NOT NULL,
    direccionExacta NVARCHAR(300) NOT NULL,
    telefono NVARCHAR(20) NOT NULL,
    preferenciaContacto BIT NOT NULL,
    CONSTRAINT FK_Cliente_Persona FOREIGN KEY (identificacion)
        REFERENCES Proyecto3_1_1640_0162.Persona(identificacion)
);

-- Tabla Empleado (hereda de Persona)
CREATE TABLE TeChineoTuLomito_Schema.Empleado (
    identificacion NVARCHAR(50) NOT NULL PRIMARY KEY,
    fechaNacimiento DATE NOT NULL,
    fechaContratacion DATE NOT NULL,
    salarioXDia DECIMAL(10,2) NOT NULL,
    fechaRetiro DATE NULL,
    tipoEmpleado NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Empleado_Persona FOREIGN KEY (identificacion)
        REFERENCES Proyecto3_1_1640_0162.Persona(identificacion)
);

-- Tabla Mascota
CREATE TABLE TeChineoTuLomito_Schema.Mascota (
    id INT IDENTITY(1,1) PRIMARY KEY,
    identificacionDueno NVARCHAR(50) NOT NULL,
    especie NVARCHAR(50) NOT NULL,
    raza NVARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    color NVARCHAR(50) NOT NULL,
    ultimaFechaAtencion DATE NULL,
    ultimaFechaVacunacion DATE NULL,
    telefonoDueno NVARCHAR(20) NULL,
    emailDueno NVARCHAR(100) NULL,
    nombreMascota NVARCHAR(100) NOT NULL,
    CONSTRAINT FK_Mascota_Cliente FOREIGN KEY (identificacionDueno)
        REFERENCES Proyecto3_1_1640_0162.Cliente(identificacion)
);

-- Tabla Procedimiento
CREATE TABLE TeChineoTuLomito_Schema.Procedimiento (
    id INT IDENTITY(1,1) PRIMARY KEY,
    tipoProcedimiento NVARCHAR(100) NOT NULL,
    descripcion NVARCHAR(300) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

-- Tabla ProcedimientoAplicado
CREATE TABLE TeChineoTuLomito_Schema.ProcedimientoAplicado (
    idProcedimientoAplicado INT IDENTITY(1,1) PRIMARY KEY,
    idMascota INT NOT NULL,
    idProcedimiento INT NOT NULL,
    precioProcedimientoConImpuesto DECIMAL(10,2) NOT NULL,
    estadoProcedimento NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_ProcedimientoAplicado_Mascota FOREIGN KEY (idMascota)
        REFERENCES TeChineoTuLomito_Schema.Mascota(id),
    CONSTRAINT FK_ProcedimientoAplicado_Procedimiento FOREIGN KEY (idProcedimiento)
        REFERENCES TeChineoTuLomito_Schema.Procedimiento(id)
);

--Poblar la tabla procedimientos de manera forzada desde el Script para que tenga los procedimientos del enunciado del proyecto 1
--Se fuerza la inserción del id que es identity activando el identity_insert

SET IDENTITY_INSERT TeChineoTuLomito_Schema.Procedimiento ON;

INSERT INTO TeChineoTuLomito_Schema.Procedimiento (id, tipoProcedimiento, descripcion, precio)
VALUES
(1, 'Consulta', 'Consulta de mascota', 15000),
(2, 'Consulta en horario especial', 'Consulta de mascota después de las 18:00 hrs de lunes a sábado, o domingo o feriado', 17000),
(3, 'Castración de 0-5 kg', 'Mascota castrada con un peso de 0-5 kg', 35000),
(4, 'Castración de 5-10 kg', 'Mascota castrada con un peso de 5-10 kg', 45000),
(5, 'Castración de 10-20 kg', 'Mascota castrada con un peso de 10-20 kg', 55000),
(6, 'Castración de 20-30 kg', 'Mascota castrada con un peso de 20-30 kg', 80000),
(7, 'Castración de 30-50 kg', 'Mascota castrada con un peso de 30-50 kg', 100000),
(8, 'Cirugía menor', 'Costo por kilo de peso del paciente', 15000),
(9, 'Cirugía mayor', 'Costo por kilo de peso del paciente', 25000),
(10, 'Gromming completo de mascota pequeña', 'Gromming completo de mascota pequeña', 15000),
(11, 'Gromming completo de mascota mediana', 'Gromming completo de mascota mediana', 20000),
(12, 'Gromming completo de mascota grande', 'Gromming completo de mascota grande', 25000),
(13, 'Gromming completo de mascota extra grande', 'Gromming completo de mascota extra grande', 35000),
(14, 'Vacunas Anuales de mascota', 'Vacunas anuales', 40000);

--Se desactiva el identity_insert porque solo se puede tener activado en una tabla de la base de datos a la vez

SET IDENTITY_INSERT TeChineoTuLomito_Schema.Procedimiento OFF;
