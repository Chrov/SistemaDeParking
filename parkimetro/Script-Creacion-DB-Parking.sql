CREATE DATABASE "db-eparking"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
CREATE TABLE IF NOT EXISTS public."Cliente"
(
    "idCliente" serial NOT NULL,
    "Apellido" character varying(50) COLLATE pg_catalog."default",
    "Nombre" character varying(50) COLLATE pg_catalog."default",
    "Dni" character varying(10) COLLATE pg_catalog."default",
    "Password" text COLLATE pg_catalog."default",
    "Email" character varying(200) COLLATE pg_catalog."default",
    "idTipoCliente" integer,
    "IdVehiculo" integer,
    "Activo" boolean,
    CONSTRAINT "Cliente_pkey" PRIMARY KEY ("idCliente"),
    CONSTRAINT "DNI_UK" UNIQUE ("Dni")
);

CREATE TABLE IF NOT EXISTS public."Lugar"
(
    "idLugar" serial NOT NULL,
    "Nivel" integer,
    "Capacidad" integer,
    "idTipoVehiculo" integer,
    CONSTRAINT "Lugar_pkey" PRIMARY KEY ("idLugar")
);

CREATE TABLE IF NOT EXISTS public."Reservas"
(
    "idReservas" serial NOT NULL,
    "FechaHora" date,
    "HorasReservadas" integer,
    "idCliente" integer,
    "DuracionReserva" integer,
    "idTipoReserva" integer,
    "Estado" boolean,
    "idVehiculo" integer,
    "idLugarReservado" integer,
    CONSTRAINT "Reservas_pkey" PRIMARY KEY ("idReservas")
);

CREATE TABLE IF NOT EXISTS public."TipoCliente"
(
    "idTipoCliente" serial NOT NULL,
    "Descripcion" character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT "TipoCliente_pkey" PRIMARY KEY ("idTipoCliente")
);

CREATE TABLE IF NOT EXISTS public."TipoReserva"
(
    "idTipoReserva" serial NOT NULL,
    "Descripcion" character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT "TipoReserva_pkey" PRIMARY KEY ("idTipoReserva")
);

CREATE TABLE IF NOT EXISTS public."TipoVehiculo"
(
    "idTipoVehiculo" serial NOT NULL,
    "Descripcion" character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT "TipoVehiculo_pkey" PRIMARY KEY ("idTipoVehiculo")
);

CREATE TABLE IF NOT EXISTS public."Vehiculo"
(
    "idVehiculo" serial NOT NULL,
    "Patente" character varying(30) COLLATE pg_catalog."default",
    "Color" character varying(30) COLLATE pg_catalog."default",
    "idCliente" integer,
    "Marca" character varying(30) COLLATE pg_catalog."default",
    "Modelo" character varying(50) COLLATE pg_catalog."default",
    "Foto" text COLLATE pg_catalog."default",
    "Descripcion" character varying(50) COLLATE pg_catalog."default",
    "idTipoVehiculo" integer,
    CONSTRAINT "Vehiculo_pkey" PRIMARY KEY ("idVehiculo")
);

ALTER TABLE IF EXISTS public."Cliente"
    ADD CONSTRAINT "Cliente_IdVehiculo_fkey" FOREIGN KEY ("IdVehiculo")
    REFERENCES public."Vehiculo" ("idVehiculo") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public."Cliente"
    ADD CONSTRAINT "Cliente_idTipoCliente_fkey" FOREIGN KEY ("idTipoCliente")
    REFERENCES public."TipoCliente" ("idTipoCliente") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public."Lugar"
    ADD CONSTRAINT "Lugar_idTipoVehiculo_fkey" FOREIGN KEY ("idTipoVehiculo")
    REFERENCES public."TipoVehiculo" ("idTipoVehiculo") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public."Reservas"
    ADD CONSTRAINT "Reservas_idCliente_fkey" FOREIGN KEY ("idCliente")
    REFERENCES public."Cliente" ("idCliente") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public."Reservas"
    ADD CONSTRAINT "Reservas_idLugarReservado_fkey" FOREIGN KEY ("idLugarReservado")
    REFERENCES public."Lugar" ("idLugar") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public."Reservas"
    ADD CONSTRAINT "Reservas_idTipoReserva_fkey" FOREIGN KEY ("idTipoReserva")
    REFERENCES public."TipoReserva" ("idTipoReserva") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public."Reservas"
    ADD CONSTRAINT "Reservas_idVehiculo_fkey" FOREIGN KEY ("idVehiculo")
    REFERENCES public."Vehiculo" ("idVehiculo") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public."Vehiculo"
    ADD CONSTRAINT "Vehiculo_idCliente_fkey" FOREIGN KEY ("idCliente")
    REFERENCES public."Cliente" ("idCliente") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Vehiculo"
    ADD CONSTRAINT "Vehiculo_idTipoVehiculo_fkey" FOREIGN KEY ("idTipoVehiculo")
    REFERENCES public."TipoVehiculo" ("idTipoVehiculo") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

END;