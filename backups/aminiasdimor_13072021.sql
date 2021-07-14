--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.20
-- Dumped by pg_dump version 12.3

-- Started on 2021-07-13 20:28:14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 9 (class 2615 OID 16466)
-- Name: iglesias; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA iglesias;


ALTER SCHEMA iglesias OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 16394)
-- Name: seguridad; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA seguridad;


ALTER SCHEMA seguridad OWNER TO postgres;

SET default_tablespace = '';

--
-- TOC entry 269 (class 1259 OID 25128)
-- Name: actividadmisionera; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.actividadmisionera (
    idactividadmisionera integer NOT NULL,
    descripcion character varying(150) DEFAULT NULL::character varying,
    tipo character varying(20) DEFAULT NULL::character varying
);


ALTER TABLE iglesias.actividadmisionera OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 25126)
-- Name: actividadmisionera_idactividadmisionera_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.actividadmisionera_idactividadmisionera_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.actividadmisionera_idactividadmisionera_seq OWNER TO postgres;

--
-- TOC entry 2599 (class 0 OID 0)
-- Dependencies: 268
-- Name: actividadmisionera_idactividadmisionera_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.actividadmisionera_idactividadmisionera_seq OWNED BY iglesias.actividadmisionera.idactividadmisionera;


--
-- TOC entry 275 (class 1259 OID 25162)
-- Name: capacitacion_miembro; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.capacitacion_miembro (
    idcapacitacion integer NOT NULL,
    idmiembro integer,
    anio integer,
    capacitacion character varying(255),
    centro_estudios character varying(255),
    observaciones_capacitacion text
);


ALTER TABLE iglesias.capacitacion_miembro OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 25160)
-- Name: capacitacion_miembro_idcapacitacion_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.capacitacion_miembro_idcapacitacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.capacitacion_miembro_idcapacitacion_seq OWNER TO postgres;

--
-- TOC entry 2600 (class 0 OID 0)
-- Dependencies: 274
-- Name: capacitacion_miembro_idcapacitacion_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.capacitacion_miembro_idcapacitacion_seq OWNED BY iglesias.capacitacion_miembro.idcapacitacion;


--
-- TOC entry 246 (class 1259 OID 16908)
-- Name: cargo_miembro; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.cargo_miembro (
    idcargomiembro integer NOT NULL,
    idmiembro integer NOT NULL,
    idcargo integer NOT NULL,
    idinstitucion integer,
    observaciones_cargo text,
    vigente character(1) DEFAULT NULL::bpchar,
    periodoini integer,
    periodofin integer,
    idiglesia_cargo integer,
    idnivel smallint,
    idlugar smallint,
    tabla character varying(50),
    lugar character varying(100)
);


ALTER TABLE iglesias.cargo_miembro OWNER TO postgres;

--
-- TOC entry 2601 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN cargo_miembro.idlugar; Type: COMMENT; Schema: iglesias; Owner: postgres
--

COMMENT ON COLUMN iglesias.cargo_miembro.idlugar IS 'es el id de la jeraquia correspondiente';


--
-- TOC entry 245 (class 1259 OID 16906)
-- Name: cargo_miembro_idcargomiembro_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.cargo_miembro_idcargomiembro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.cargo_miembro_idcargomiembro_seq OWNER TO postgres;

--
-- TOC entry 2602 (class 0 OID 0)
-- Dependencies: 245
-- Name: cargo_miembro_idcargomiembro_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.cargo_miembro_idcargomiembro_seq OWNED BY iglesias.cargo_miembro.idcargomiembro;


--
-- TOC entry 207 (class 1259 OID 16697)
-- Name: categoriaiglesia; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.categoriaiglesia (
    idcategoriaiglesia integer NOT NULL,
    descripcion character varying(30) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE iglesias.categoriaiglesia OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16695)
-- Name: categoriaiglesia_idcategoriaiglesia_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.categoriaiglesia_idcategoriaiglesia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.categoriaiglesia_idcategoriaiglesia_seq OWNER TO postgres;

--
-- TOC entry 2603 (class 0 OID 0)
-- Dependencies: 206
-- Name: categoriaiglesia_idcategoriaiglesia_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.categoriaiglesia_idcategoriaiglesia_seq OWNED BY iglesias.categoriaiglesia.idcategoriaiglesia;


--
-- TOC entry 197 (class 1259 OID 16562)
-- Name: condicioneclesiastica; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.condicioneclesiastica (
    idcondicioneclesiastica integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE iglesias.condicioneclesiastica OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16560)
-- Name: condicioneclesiastica_idcondicioneclesiastica_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.condicioneclesiastica_idcondicioneclesiastica_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.condicioneclesiastica_idcondicioneclesiastica_seq OWNER TO postgres;

--
-- TOC entry 2604 (class 0 OID 0)
-- Dependencies: 196
-- Name: condicioneclesiastica_idcondicioneclesiastica_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.condicioneclesiastica_idcondicioneclesiastica_seq OWNED BY iglesias.condicioneclesiastica.idcondicioneclesiastica;


--
-- TOC entry 215 (class 1259 OID 16733)
-- Name: condicioninmueble; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.condicioninmueble (
    idcondicioninmueble integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE iglesias.condicioninmueble OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16731)
-- Name: condicioninmueble_idcondicioninmueble_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.condicioninmueble_idcondicioninmueble_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.condicioninmueble_idcondicioninmueble_seq OWNER TO postgres;

--
-- TOC entry 2605 (class 0 OID 0)
-- Dependencies: 214
-- Name: condicioninmueble_idcondicioninmueble_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.condicioninmueble_idcondicioninmueble_seq OWNED BY iglesias.condicioninmueble.idcondicioninmueble;


--
-- TOC entry 267 (class 1259 OID 25119)
-- Name: control_traslados; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.control_traslados (
    idcontrol integer NOT NULL,
    idmiembro integer,
    idiglesiaanterior integer,
    idiglesiaactual integer,
    fecha date,
    carta_traslado character varying(100),
    carta_aceptacion character varying(100),
    estado character(1) DEFAULT '1'::bpchar,
    iddivisionactual smallint,
    pais_idactual smallint,
    idunionactual smallint,
    idmisionactual smallint,
    iddistritomisioneroactual smallint
);


ALTER TABLE iglesias.control_traslados OWNER TO postgres;

--
-- TOC entry 2606 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN control_traslados.estado; Type: COMMENT; Schema: iglesias; Owner: postgres
--

COMMENT ON COLUMN iglesias.control_traslados.estado IS '1 -> pendiente
0 -> trasladado';


--
-- TOC entry 266 (class 1259 OID 25117)
-- Name: control_traslados_idcontrol_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.control_traslados_idcontrol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.control_traslados_idcontrol_seq OWNER TO postgres;

--
-- TOC entry 2607 (class 0 OID 0)
-- Dependencies: 266
-- Name: control_traslados_idcontrol_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.control_traslados_idcontrol_seq OWNED BY iglesias.control_traslados.idcontrol;


--
-- TOC entry 271 (class 1259 OID 25138)
-- Name: controlactmisionera; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.controlactmisionera (
    idcontrolactmisionera integer NOT NULL,
    idactividadmisionera integer,
    anio character(4) DEFAULT NULL::bpchar,
    trimestre integer,
    idiglesia integer,
    semana integer,
    valor numeric(6,0) DEFAULT NULL::numeric,
    asistentes numeric(6,0) DEFAULT NULL::numeric,
    interesados numeric(6,0) DEFAULT NULL::numeric
);


ALTER TABLE iglesias.controlactmisionera OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 25136)
-- Name: controlactmisionera_idcontrolactmisionera_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.controlactmisionera_idcontrolactmisionera_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.controlactmisionera_idcontrolactmisionera_seq OWNER TO postgres;

--
-- TOC entry 2608 (class 0 OID 0)
-- Dependencies: 270
-- Name: controlactmisionera_idcontrolactmisionera_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.controlactmisionera_idcontrolactmisionera_seq OWNED BY iglesias.controlactmisionera.idcontrolactmisionera;


--
-- TOC entry 201 (class 1259 OID 16662)
-- Name: distritomisionero; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.distritomisionero (
    iddistritomisionero integer NOT NULL,
    idmision integer DEFAULT 0 NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying,
    estado character(1) DEFAULT '1'::bpchar NOT NULL
);


ALTER TABLE iglesias.distritomisionero OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16660)
-- Name: distritomisionero_iddistritomisionero_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.distritomisionero_iddistritomisionero_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.distritomisionero_iddistritomisionero_seq OWNER TO postgres;

--
-- TOC entry 2609 (class 0 OID 0)
-- Dependencies: 200
-- Name: distritomisionero_iddistritomisionero_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.distritomisionero_iddistritomisionero_seq OWNED BY iglesias.distritomisionero.iddistritomisionero;


--
-- TOC entry 221 (class 1259 OID 16763)
-- Name: division; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.division (
    iddivision integer NOT NULL,
    descripcion character varying(50),
    estado character(1)
);


ALTER TABLE iglesias.division OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16761)
-- Name: division_iddivision_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.division_iddivision_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.division_iddivision_seq OWNER TO postgres;

--
-- TOC entry 2610 (class 0 OID 0)
-- Dependencies: 220
-- Name: division_iddivision_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.division_iddivision_seq OWNED BY iglesias.division.iddivision;


--
-- TOC entry 225 (class 1259 OID 16787)
-- Name: division_idiomas; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.division_idiomas (
    iddivision integer,
    idioma_id integer,
    di_descripcion character varying(100)
);


ALTER TABLE iglesias.division_idiomas OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16860)
-- Name: historial_altasybajas; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.historial_altasybajas (
    idhistorial integer NOT NULL,
    idmiembro integer,
    responsable integer,
    fecha date,
    observaciones text,
    alta character(1),
    idmotivobaja integer,
    rebautizo character(1) DEFAULT NULL::bpchar,
    usuario character varying(20) DEFAULT NULL::character varying,
    idcondicioneclesiastica character(1),
    tabla character varying(50)
);


ALTER TABLE iglesias.historial_altasybajas OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16858)
-- Name: historial_altasybajas_idhistorial_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.historial_altasybajas_idhistorial_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.historial_altasybajas_idhistorial_seq OWNER TO postgres;

--
-- TOC entry 2611 (class 0 OID 0)
-- Dependencies: 237
-- Name: historial_altasybajas_idhistorial_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.historial_altasybajas_idhistorial_seq OWNED BY iglesias.historial_altasybajas.idhistorial;


--
-- TOC entry 263 (class 1259 OID 25094)
-- Name: historial_traslados; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.historial_traslados (
    idtraslado integer NOT NULL,
    idmiembro integer,
    idiglesiaanterior integer,
    idiglesiaactual integer,
    fecha date,
    idcontrol smallint
);


ALTER TABLE iglesias.historial_traslados OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 25092)
-- Name: historial_traslados_idtraslado_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.historial_traslados_idtraslado_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.historial_traslados_idtraslado_seq OWNER TO postgres;

--
-- TOC entry 2612 (class 0 OID 0)
-- Dependencies: 262
-- Name: historial_traslados_idtraslado_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.historial_traslados_idtraslado_seq OWNED BY iglesias.historial_traslados.idtraslado;


--
-- TOC entry 199 (class 1259 OID 16637)
-- Name: iglesia; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.iglesia (
    idiglesia integer NOT NULL,
    telefono character varying(100) DEFAULT NULL::character varying,
    descripcion character varying(100) DEFAULT ''::character varying NOT NULL,
    referencia character varying(100) DEFAULT NULL::character varying,
    iddistrito integer,
    idcategoriaiglesia integer DEFAULT 0,
    idtipoconstruccion integer DEFAULT 0,
    idtipodocumentacion integer DEFAULT 0,
    idtipoinmueble integer,
    idcondicioninmueble integer,
    area character varying(50) DEFAULT NULL::character varying,
    direccion character varying(100) DEFAULT ''::character varying,
    valor character varying(50) DEFAULT NULL::character varying,
    observaciones text,
    estado character(1) DEFAULT '1'::bpchar NOT NULL,
    iddepartamento smallint,
    idprovincia smallint,
    tipoestructura character varying(255),
    documentopropiedad character varying(255),
    iddivision smallint,
    pais_id smallint,
    idunion smallint,
    idmision smallint,
    iddistritomisionero smallint
);


ALTER TABLE iglesias.iglesia OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16635)
-- Name: iglesia_idiglesia_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.iglesia_idiglesia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.iglesia_idiglesia_seq OWNER TO postgres;

--
-- TOC entry 2613 (class 0 OID 0)
-- Dependencies: 198
-- Name: iglesia_idiglesia_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.iglesia_idiglesia_seq OWNED BY iglesias.iglesia.idiglesia;


--
-- TOC entry 250 (class 1259 OID 24987)
-- Name: institucion; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.institucion (
    idinstitucion integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying,
    sede character varying(50) DEFAULT NULL::character varying,
    "dirección" character varying(50) DEFAULT NULL::character varying,
    telefono character varying(50) DEFAULT NULL::character varying,
    email character varying(150) DEFAULT NULL::character varying
);


ALTER TABLE iglesias.institucion OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 24985)
-- Name: institucion_idinstitucion_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.institucion_idinstitucion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.institucion_idinstitucion_seq OWNER TO postgres;

--
-- TOC entry 2614 (class 0 OID 0)
-- Dependencies: 249
-- Name: institucion_idinstitucion_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.institucion_idinstitucion_seq OWNED BY iglesias.institucion.idinstitucion;


--
-- TOC entry 183 (class 1259 OID 16469)
-- Name: miembro; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.miembro (
    idmiembro integer NOT NULL,
    pais_id_nacionalidad integer DEFAULT 0 NOT NULL,
    iddistritonacimiento integer DEFAULT 0,
    iddistritodomicilio integer,
    idtipodoc integer DEFAULT 0 NOT NULL,
    idestadocivil integer DEFAULT 0 NOT NULL,
    idocupacion integer DEFAULT 0 NOT NULL,
    idgradoinstruccion integer DEFAULT 0 NOT NULL,
    paterno character varying(50) DEFAULT ''::character varying,
    materno character varying(50) DEFAULT NULL::character varying,
    nombres character varying(50) DEFAULT ''::character varying NOT NULL,
    foto character varying(50) DEFAULT NULL::character varying,
    fechanacimiento date NOT NULL,
    lugarnacimiento character varying(30) DEFAULT ''::character varying,
    sexo character(1) DEFAULT ''::bpchar NOT NULL,
    nrodoc character varying(20) DEFAULT ''::character varying NOT NULL,
    direccion character varying(80) DEFAULT NULL::character varying,
    referenciadireccion character varying(100) DEFAULT NULL::character varying,
    telefono character varying(20) DEFAULT NULL::character varying,
    celular character varying(20) DEFAULT NULL::character varying,
    email character varying(100) DEFAULT NULL::character varying,
    emailalternativo character varying(100) DEFAULT NULL::character varying,
    idreligion integer DEFAULT 0,
    fechabautizo date,
    idcondicioneclesiastica integer,
    encargado_recibimiento character varying(6) DEFAULT NULL::character varying,
    observaciones text,
    estado character(1) DEFAULT '1'::bpchar,
    estadoeliminado character(1) DEFAULT '0'::bpchar,
    idiglesia integer,
    fechaingresoiglesia date,
    usuario character varying(20) DEFAULT '1'::character varying,
    fecharegistro timestamp without time zone,
    tipolugarnac character varying(10),
    ciudadnacextranjero character varying(80),
    apellidos character varying(100),
    iddepartamentodomicilio smallint,
    idprovinciadomicilio smallint,
    iddepartamentonacimiento smallint,
    idprovincianacimiento smallint,
    apellido_soltera character varying(100),
    pais_id_nacimiento smallint,
    iddivision smallint,
    pais_id smallint,
    idunion smallint,
    idmision smallint,
    iddistritomisionero smallint,
    tabla_encargado_bautizo character varying(50),
    encargado_bautizo smallint
);


ALTER TABLE iglesias.miembro OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 16467)
-- Name: miembro_idmiembro_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.miembro_idmiembro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.miembro_idmiembro_seq OWNER TO postgres;

--
-- TOC entry 2615 (class 0 OID 0)
-- Dependencies: 182
-- Name: miembro_idmiembro_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.miembro_idmiembro_seq OWNED BY iglesias.miembro.idmiembro;


--
-- TOC entry 205 (class 1259 OID 16680)
-- Name: mision; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.mision (
    idmision integer NOT NULL,
    idunion integer,
    descripcion character varying(60) DEFAULT ''::character varying NOT NULL,
    direccion character varying(200) DEFAULT NULL::character varying,
    estado character(1) DEFAULT '1'::bpchar NOT NULL,
    telefono character varying(80) NOT NULL,
    email character varying(200) NOT NULL
);


ALTER TABLE iglesias.mision OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16678)
-- Name: mision_idmision_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.mision_idmision_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.mision_idmision_seq OWNER TO postgres;

--
-- TOC entry 2616 (class 0 OID 0)
-- Dependencies: 204
-- Name: mision_idmision_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.mision_idmision_seq OWNED BY iglesias.mision.idmision;


--
-- TOC entry 240 (class 1259 OID 16873)
-- Name: motivobaja; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.motivobaja (
    idmotivobaja integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE iglesias.motivobaja OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16871)
-- Name: motivobaja_idmotivobaja_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.motivobaja_idmotivobaja_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.motivobaja_idmotivobaja_seq OWNER TO postgres;

--
-- TOC entry 2617 (class 0 OID 0)
-- Dependencies: 239
-- Name: motivobaja_idmotivobaja_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.motivobaja_idmotivobaja_seq OWNED BY iglesias.motivobaja.idmotivobaja;


--
-- TOC entry 242 (class 1259 OID 16883)
-- Name: otrospastores; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.otrospastores (
    idotrospastores integer NOT NULL,
    idcargo integer,
    nombrecompleto character varying(200) DEFAULT NULL::character varying,
    observaciones text,
    periodo character varying(20) DEFAULT NULL::character varying,
    vigente character(1) DEFAULT NULL::bpchar,
    estado character(1) DEFAULT '1'::bpchar,
    idtipodoc integer,
    nrodoc character varying(20)
);


ALTER TABLE iglesias.otrospastores OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16881)
-- Name: otrospastores_idotrospastores_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.otrospastores_idotrospastores_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.otrospastores_idotrospastores_seq OWNER TO postgres;

--
-- TOC entry 2618 (class 0 OID 0)
-- Dependencies: 241
-- Name: otrospastores_idotrospastores_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.otrospastores_idotrospastores_seq OWNED BY iglesias.otrospastores.idotrospastores;


--
-- TOC entry 248 (class 1259 OID 24972)
-- Name: paises; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.paises (
    pais_id integer NOT NULL,
    pais_descripcion character varying(100),
    estado character(1) DEFAULT 'A'::bpchar,
    idioma_id smallint,
    iddivision smallint,
    direccion character varying(100),
    telefono character varying(50),
    posee_union character(1) DEFAULT 'S'::bpchar
);


ALTER TABLE iglesias.paises OWNER TO postgres;

--
-- TOC entry 2619 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN paises.posee_union; Type: COMMENT; Schema: iglesias; Owner: postgres
--

COMMENT ON COLUMN iglesias.paises.posee_union IS 'S -> si posee union
N -> no posee union';


--
-- TOC entry 234 (class 1259 OID 16842)
-- Name: paises_idiomas; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.paises_idiomas (
    pais_id integer,
    idioma_id integer,
    pai_descripcion character varying(100)
);


ALTER TABLE iglesias.paises_idiomas OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 25051)
-- Name: paises_jerarquia; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.paises_jerarquia (
    pj_id integer NOT NULL,
    pais_id integer,
    pj_descripcion character varying(100),
    pj_item smallint
);


ALTER TABLE iglesias.paises_jerarquia OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 25049)
-- Name: paises_jerarquia_pj_id_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.paises_jerarquia_pj_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.paises_jerarquia_pj_id_seq OWNER TO postgres;

--
-- TOC entry 2620 (class 0 OID 0)
-- Dependencies: 256
-- Name: paises_jerarquia_pj_id_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.paises_jerarquia_pj_id_seq OWNED BY iglesias.paises_jerarquia.pj_id;


--
-- TOC entry 247 (class 1259 OID 24970)
-- Name: paises_pais_id_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.paises_pais_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.paises_pais_id_seq OWNER TO postgres;

--
-- TOC entry 2621 (class 0 OID 0)
-- Dependencies: 247
-- Name: paises_pais_id_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.paises_pais_id_seq OWNED BY iglesias.paises.pais_id;


--
-- TOC entry 195 (class 1259 OID 16553)
-- Name: religion; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.religion (
    idreligion integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE iglesias.religion OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 16551)
-- Name: religion_idreligion_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.religion_idreligion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.religion_idreligion_seq OWNER TO postgres;

--
-- TOC entry 2622 (class 0 OID 0)
-- Dependencies: 194
-- Name: religion_idreligion_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.religion_idreligion_seq OWNED BY iglesias.religion.idreligion;


--
-- TOC entry 255 (class 1259 OID 25040)
-- Name: temp_traslados; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.temp_traslados (
    idtemptraslados integer NOT NULL,
    idmiembro integer NOT NULL,
    idtipodoc integer NOT NULL,
    iddivision integer NOT NULL,
    pais_id integer NOT NULL,
    idunion integer NOT NULL,
    idmision integer NOT NULL,
    iddistritomisionero integer NOT NULL,
    idiglesia integer NOT NULL,
    nrodoc character varying(20) NOT NULL,
    division character varying(100),
    pais character varying(100),
    "union" character varying(100),
    mision character varying(100),
    distritomisionero character varying(100),
    iglesia character varying(100),
    tipo_documento character varying(50),
    usuario_id smallint,
    tipo_traslado integer NOT NULL,
    iddivisiondestino smallint,
    pais_iddestino smallint,
    iduniondestino smallint,
    idmisiondestino smallint,
    iddistritomisionerodestino smallint,
    idiglesiadestino smallint,
    asociado character varying(255)
);


ALTER TABLE iglesias.temp_traslados OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 25038)
-- Name: temp_traslados_idtemptraslados_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.temp_traslados_idtemptraslados_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.temp_traslados_idtemptraslados_seq OWNER TO postgres;

--
-- TOC entry 2623 (class 0 OID 0)
-- Dependencies: 254
-- Name: temp_traslados_idtemptraslados_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.temp_traslados_idtemptraslados_seq OWNED BY iglesias.temp_traslados.idtemptraslados;


--
-- TOC entry 209 (class 1259 OID 16706)
-- Name: tipoconstruccion; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.tipoconstruccion (
    idtipoconstruccion integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE iglesias.tipoconstruccion OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16704)
-- Name: tipoconstruccion_idtipoconstruccion_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.tipoconstruccion_idtipoconstruccion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.tipoconstruccion_idtipoconstruccion_seq OWNER TO postgres;

--
-- TOC entry 2624 (class 0 OID 0)
-- Dependencies: 208
-- Name: tipoconstruccion_idtipoconstruccion_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.tipoconstruccion_idtipoconstruccion_seq OWNED BY iglesias.tipoconstruccion.idtipoconstruccion;


--
-- TOC entry 211 (class 1259 OID 16715)
-- Name: tipodocumentacion; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.tipodocumentacion (
    idtipodocumentacion integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE iglesias.tipodocumentacion OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16713)
-- Name: tipodocumentacion_idtipodocumentacion_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.tipodocumentacion_idtipodocumentacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.tipodocumentacion_idtipodocumentacion_seq OWNER TO postgres;

--
-- TOC entry 2625 (class 0 OID 0)
-- Dependencies: 210
-- Name: tipodocumentacion_idtipodocumentacion_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.tipodocumentacion_idtipodocumentacion_seq OWNED BY iglesias.tipodocumentacion.idtipodocumentacion;


--
-- TOC entry 213 (class 1259 OID 16724)
-- Name: tipoinmueble; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.tipoinmueble (
    idtipoinmueble integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE iglesias.tipoinmueble OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16722)
-- Name: tipoinmueble_idtipoinmueble_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.tipoinmueble_idtipoinmueble_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.tipoinmueble_idtipoinmueble_seq OWNER TO postgres;

--
-- TOC entry 2626 (class 0 OID 0)
-- Dependencies: 212
-- Name: tipoinmueble_idtipoinmueble_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.tipoinmueble_idtipoinmueble_seq OWNED BY iglesias.tipoinmueble.idtipoinmueble;


--
-- TOC entry 203 (class 1259 OID 16673)
-- Name: union; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias."union" (
    idunion integer NOT NULL,
    descripcion character varying(50),
    estado character(1)
);


ALTER TABLE iglesias."union" OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16671)
-- Name: union_idunion_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.union_idunion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.union_idunion_seq OWNER TO postgres;

--
-- TOC entry 2627 (class 0 OID 0)
-- Dependencies: 202
-- Name: union_idunion_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.union_idunion_seq OWNED BY iglesias."union".idunion;


--
-- TOC entry 222 (class 1259 OID 16769)
-- Name: union_paises; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.union_paises (
    idunion integer,
    pais_id integer
);


ALTER TABLE iglesias.union_paises OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 16517)
-- Name: tipodoc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipodoc (
    idtipodoc integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.tipodoc OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 25105)
-- Name: vista_asociados_traslados; Type: VIEW; Schema: iglesias; Owner: postgres
--

CREATE VIEW iglesias.vista_asociados_traslados AS
SELECT m.idmiembro, (((m.apellidos)::text || ', '::text) || (m.nombres)::text) AS asociado, m.idtipodoc, m.nrodoc, d.descripcion AS division, p.pais_descripcion AS pais, u.descripcion AS "union", mi.descripcion AS mision, dm.descripcion AS distritomisionero, i.descripcion AS iglesia, td.descripcion AS tipo_documento, m.iddivision, m.pais_id, m.idunion, m.idmision, m.iddistritomisionero, m.idiglesia FROM (((((((iglesias.miembro m JOIN iglesias.division d ON ((m.iddivision = d.iddivision))) JOIN iglesias.paises p ON ((m.pais_id = p.pais_id))) JOIN iglesias."union" u ON ((m.idunion = u.idunion))) JOIN iglesias.mision mi ON ((m.idmision = mi.idmision))) JOIN iglesias.distritomisionero dm ON ((m.iddistritomisionero = dm.iddistritomisionero))) JOIN iglesias.iglesia i ON ((m.idiglesia = i.idiglesia))) JOIN public.tipodoc td ON ((td.idtipodoc = m.idtipodoc)));


ALTER TABLE iglesias.vista_asociados_traslados OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 25110)
-- Name: vista_jerarquia; Type: VIEW; Schema: iglesias; Owner: postgres
--

CREATE VIEW iglesias.vista_jerarquia AS
SELECT d.descripcion AS division, p.pais_descripcion AS pais, u.descripcion AS "union", mi.descripcion AS mision, dm.descripcion AS distritomisionero, i.descripcion AS iglesia, d.iddivision, p.pais_id, u.idunion, mi.idmision, dm.iddistritomisionero, i.idiglesia FROM ((((((iglesias.division d JOIN iglesias.paises p ON ((d.iddivision = p.iddivision))) JOIN iglesias.union_paises up ON ((up.pais_id = p.pais_id))) JOIN iglesias."union" u ON ((up.idunion = u.idunion))) JOIN iglesias.mision mi ON ((u.idunion = mi.idunion))) JOIN iglesias.distritomisionero dm ON ((mi.idmision = dm.idmision))) JOIN iglesias.iglesia i ON ((dm.iddistritomisionero = i.iddistritomisionero)));


ALTER TABLE iglesias.vista_jerarquia OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16898)
-- Name: cargo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargo (
    idcargo integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying,
    idtipocargo integer,
    estado character(1) DEFAULT NULL::bpchar,
    idnivel smallint
);


ALTER TABLE public.cargo OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 25017)
-- Name: vista_responsables; Type: VIEW; Schema: iglesias; Owner: postgres
--

CREATE VIEW iglesias.vista_responsables AS
SELECT m.idmiembro AS id, (((m.apellidos)::text || ', '::text) || (m.nombres)::text) AS nombres, 'iglesias.miembro'::text AS tabla, td.descripcion AS tipo_documento, m.nrodoc FROM (iglesias.miembro m JOIN public.tipodoc td ON ((td.idtipodoc = m.idtipodoc))) WHERE (m.idmiembro IN (SELECT cargo_miembro.idmiembro FROM iglesias.cargo_miembro WHERE (cargo_miembro.idcargo IS NOT NULL))) UNION ALL SELECT ot.idotrospastores AS id, ot.nombrecompleto AS nombres, 'iglesias.otrospastores'::text AS tabla, td.descripcion AS tipo_documento, ot.nrodoc FROM ((iglesias.otrospastores ot JOIN public.cargo c ON ((c.idcargo = ot.idcargo))) JOIN public.tipodoc td ON ((td.idtipodoc = ot.idtipodoc))) WHERE (ot.idcargo IS NOT NULL);


ALTER TABLE iglesias.vista_responsables OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16896)
-- Name: cargo_idcargo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cargo_idcargo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cargo_idcargo_seq OWNER TO postgres;

--
-- TOC entry 2628 (class 0 OID 0)
-- Dependencies: 243
-- Name: cargo_idcargo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cargo_idcargo_seq OWNED BY public.cargo.idcargo;


--
-- TOC entry 233 (class 1259 OID 16824)
-- Name: condicioninmueble; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.condicioninmueble (
    idcondicioninmueble integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.condicioninmueble OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16822)
-- Name: condicioninmueble_idcondicioninmueble_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.condicioninmueble_idcondicioninmueble_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.condicioninmueble_idcondicioninmueble_seq OWNER TO postgres;

--
-- TOC entry 2629 (class 0 OID 0)
-- Dependencies: 232
-- Name: condicioninmueble_idcondicioninmueble_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.condicioninmueble_idcondicioninmueble_seq OWNED BY public.condicioninmueble.idcondicioninmueble;


--
-- TOC entry 219 (class 1259 OID 16751)
-- Name: departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departamento (
    iddepartamento integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL,
    pais_id integer
);


ALTER TABLE public.departamento OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16749)
-- Name: departamento_iddepartamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departamento_iddepartamento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departamento_iddepartamento_seq OWNER TO postgres;

--
-- TOC entry 2630 (class 0 OID 0)
-- Dependencies: 218
-- Name: departamento_iddepartamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departamento_iddepartamento_seq OWNED BY public.departamento.iddepartamento;


--
-- TOC entry 185 (class 1259 OID 16506)
-- Name: distrito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.distrito (
    iddistrito integer NOT NULL,
    idprovincia integer DEFAULT 0 NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.distrito OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 16504)
-- Name: distrito_iddistrito_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.distrito_iddistrito_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.distrito_iddistrito_seq OWNER TO postgres;

--
-- TOC entry 2631 (class 0 OID 0)
-- Dependencies: 184
-- Name: distrito_iddistrito_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.distrito_iddistrito_seq OWNED BY public.distrito.iddistrito;


--
-- TOC entry 189 (class 1259 OID 16526)
-- Name: estadocivil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadocivil (
    idestadocivil integer NOT NULL,
    descripcion character varying(30) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.estadocivil OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 16524)
-- Name: estadocivil_idestadocivil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estadocivil_idestadocivil_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estadocivil_idestadocivil_seq OWNER TO postgres;

--
-- TOC entry 2632 (class 0 OID 0)
-- Dependencies: 188
-- Name: estadocivil_idestadocivil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estadocivil_idestadocivil_seq OWNED BY public.estadocivil.idestadocivil;


--
-- TOC entry 193 (class 1259 OID 16544)
-- Name: gradoinstruccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gradoinstruccion (
    idgradoinstruccion integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.gradoinstruccion OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 16542)
-- Name: gradoinstruccion_idgradoinstruccion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gradoinstruccion_idgradoinstruccion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gradoinstruccion_idgradoinstruccion_seq OWNER TO postgres;

--
-- TOC entry 2633 (class 0 OID 0)
-- Dependencies: 192
-- Name: gradoinstruccion_idgradoinstruccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gradoinstruccion_idgradoinstruccion_seq OWNED BY public.gradoinstruccion.idgradoinstruccion;


--
-- TOC entry 179 (class 1259 OID 16446)
-- Name: idiomas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idiomas (
    idioma_id integer NOT NULL,
    idioma_codigo character(10),
    idioma_descripcion character varying(50),
    estado character(1) DEFAULT 'A'::bpchar,
    por_defecto character(1) DEFAULT 'N'::bpchar
);


ALTER TABLE public.idiomas OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 16444)
-- Name: idiomas_idioma_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.idiomas_idioma_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.idiomas_idioma_id_seq OWNER TO postgres;

--
-- TOC entry 2634 (class 0 OID 0)
-- Dependencies: 178
-- Name: idiomas_idioma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.idiomas_idioma_id_seq OWNED BY public.idiomas.idioma_id;


--
-- TOC entry 259 (class 1259 OID 25058)
-- Name: nivel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nivel (
    idnivel integer NOT NULL,
    descripcion character varying(50),
    estado character(1) DEFAULT '1'::bpchar,
    idtipocargo smallint
);


ALTER TABLE public.nivel OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 25056)
-- Name: nivel_idnivel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nivel_idnivel_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nivel_idnivel_seq OWNER TO postgres;

--
-- TOC entry 2635 (class 0 OID 0)
-- Dependencies: 258
-- Name: nivel_idnivel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nivel_idnivel_seq OWNED BY public.nivel.idnivel;


--
-- TOC entry 191 (class 1259 OID 16535)
-- Name: ocupacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ocupacion (
    idocupacion integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.ocupacion OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 16533)
-- Name: ocupacion_idocupacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ocupacion_idocupacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ocupacion_idocupacion_seq OWNER TO postgres;

--
-- TOC entry 2636 (class 0 OID 0)
-- Dependencies: 190
-- Name: ocupacion_idocupacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ocupacion_idocupacion_seq OWNED BY public.ocupacion.idocupacion;


--
-- TOC entry 236 (class 1259 OID 16847)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais (
    idpais integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.pais OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16845)
-- Name: pais_idpais_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pais_idpais_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pais_idpais_seq OWNER TO postgres;

--
-- TOC entry 2637 (class 0 OID 0)
-- Dependencies: 235
-- Name: pais_idpais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pais_idpais_seq OWNED BY public.pais.idpais;


--
-- TOC entry 217 (class 1259 OID 16742)
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provincia (
    idprovincia integer NOT NULL,
    iddepartamento integer DEFAULT 0 NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.provincia OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16740)
-- Name: provincia_idprovincia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.provincia_idprovincia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.provincia_idprovincia_seq OWNER TO postgres;

--
-- TOC entry 2638 (class 0 OID 0)
-- Dependencies: 216
-- Name: provincia_idprovincia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.provincia_idprovincia_seq OWNED BY public.provincia.idprovincia;


--
-- TOC entry 252 (class 1259 OID 25000)
-- Name: tipocargo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipocargo (
    idtipocargo integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying,
    posee_nivel character(1) DEFAULT 'N'::bpchar
);


ALTER TABLE public.tipocargo OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 24998)
-- Name: tipocargo_idtipocargo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipocargo_idtipocargo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipocargo_idtipocargo_seq OWNER TO postgres;

--
-- TOC entry 2639 (class 0 OID 0)
-- Dependencies: 251
-- Name: tipocargo_idtipocargo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipocargo_idtipocargo_seq OWNED BY public.tipocargo.idtipocargo;


--
-- TOC entry 227 (class 1259 OID 16797)
-- Name: tipoconstruccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipoconstruccion (
    idtipoconstruccion integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.tipoconstruccion OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16795)
-- Name: tipoconstruccion_idtipoconstruccion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipoconstruccion_idtipoconstruccion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipoconstruccion_idtipoconstruccion_seq OWNER TO postgres;

--
-- TOC entry 2640 (class 0 OID 0)
-- Dependencies: 226
-- Name: tipoconstruccion_idtipoconstruccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipoconstruccion_idtipoconstruccion_seq OWNED BY public.tipoconstruccion.idtipoconstruccion;


--
-- TOC entry 186 (class 1259 OID 16515)
-- Name: tipodoc_idtipodoc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipodoc_idtipodoc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipodoc_idtipodoc_seq OWNER TO postgres;

--
-- TOC entry 2641 (class 0 OID 0)
-- Dependencies: 186
-- Name: tipodoc_idtipodoc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipodoc_idtipodoc_seq OWNED BY public.tipodoc.idtipodoc;


--
-- TOC entry 229 (class 1259 OID 16806)
-- Name: tipodocumentacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipodocumentacion (
    idtipodocumentacion integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.tipodocumentacion OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16804)
-- Name: tipodocumentacion_idtipodocumentacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipodocumentacion_idtipodocumentacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipodocumentacion_idtipodocumentacion_seq OWNER TO postgres;

--
-- TOC entry 2642 (class 0 OID 0)
-- Dependencies: 228
-- Name: tipodocumentacion_idtipodocumentacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipodocumentacion_idtipodocumentacion_seq OWNED BY public.tipodocumentacion.idtipodocumentacion;


--
-- TOC entry 231 (class 1259 OID 16815)
-- Name: tipoinmueble; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipoinmueble (
    idtipoinmueble integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.tipoinmueble OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16813)
-- Name: tipoinmueble_idtipoinmueble_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipoinmueble_idtipoinmueble_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipoinmueble_idtipoinmueble_seq OWNER TO postgres;

--
-- TOC entry 2643 (class 0 OID 0)
-- Dependencies: 230
-- Name: tipoinmueble_idtipoinmueble_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipoinmueble_idtipoinmueble_seq OWNED BY public.tipoinmueble.idtipoinmueble;


--
-- TOC entry 273 (class 1259 OID 25150)
-- Name: trimestre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trimestre (
    idtrimestre integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying,
    fechainicial character varying(5) DEFAULT NULL::character varying,
    fechafinal character varying(5) DEFAULT NULL::character varying,
    nrosemanas integer
);


ALTER TABLE public.trimestre OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 25148)
-- Name: trimestre_idtrimestre_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trimestre_idtrimestre_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trimestre_idtrimestre_seq OWNER TO postgres;

--
-- TOC entry 2644 (class 0 OID 0)
-- Dependencies: 272
-- Name: trimestre_idtrimestre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trimestre_idtrimestre_seq OWNED BY public.trimestre.idtrimestre;


--
-- TOC entry 261 (class 1259 OID 25075)
-- Name: log_sistema; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.log_sistema (
    idlog integer NOT NULL,
    mensaje character varying(250) DEFAULT NULL::character varying,
    fecha timestamp without time zone,
    usuario character varying(20) DEFAULT NULL::character varying,
    nombres character varying(150) DEFAULT NULL::character varying,
    idperfil integer,
    idreferencia integer,
    ip character varying(50),
    operacion character varying(50),
    tabla character varying(50)
);


ALTER TABLE seguridad.log_sistema OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 25073)
-- Name: log_sistema_idlog_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.log_sistema_idlog_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seguridad.log_sistema_idlog_seq OWNER TO postgres;

--
-- TOC entry 2645 (class 0 OID 0)
-- Dependencies: 260
-- Name: log_sistema_idlog_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.log_sistema_idlog_seq OWNED BY seguridad.log_sistema.idlog;


--
-- TOC entry 174 (class 1259 OID 16405)
-- Name: modulos; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.modulos (
    modulo_id integer NOT NULL,
    modulo_nombre character varying(50),
    modulo_icono character varying(50),
    modulo_controlador character varying(50),
    modulo_padre integer,
    modulo_orden integer,
    modulo_route character varying(50),
    estado character(1) DEFAULT 'A'::bpchar
);


ALTER TABLE seguridad.modulos OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 16460)
-- Name: modulos_idiomas; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.modulos_idiomas (
    modulo_id integer,
    idioma_id integer,
    mi_descripcion character varying(100)
);


ALTER TABLE seguridad.modulos_idiomas OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 16403)
-- Name: modulos_modulo_id_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.modulos_modulo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seguridad.modulos_modulo_id_seq OWNER TO postgres;

--
-- TOC entry 2646 (class 0 OID 0)
-- Dependencies: 173
-- Name: modulos_modulo_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.modulos_modulo_id_seq OWNED BY seguridad.modulos.modulo_id;


--
-- TOC entry 172 (class 1259 OID 16397)
-- Name: perfiles; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.perfiles (
    perfil_id integer NOT NULL,
    perfil_descripcion character varying(50),
    estado character(1) DEFAULT 'A'::bpchar
);


ALTER TABLE seguridad.perfiles OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 16463)
-- Name: perfiles_idiomas; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.perfiles_idiomas (
    perfil_id integer,
    idioma_id integer,
    pi_descripcion character varying(100)
);


ALTER TABLE seguridad.perfiles_idiomas OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 16395)
-- Name: perfiles_perfil_id_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.perfiles_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seguridad.perfiles_perfil_id_seq OWNER TO postgres;

--
-- TOC entry 2647 (class 0 OID 0)
-- Dependencies: 171
-- Name: perfiles_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.perfiles_perfil_id_seq OWNED BY seguridad.perfiles.perfil_id;


--
-- TOC entry 177 (class 1259 OID 16425)
-- Name: permisos; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.permisos (
    perfil_id integer NOT NULL,
    modulo_id integer NOT NULL
);


ALTER TABLE seguridad.permisos OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16780)
-- Name: tipoacceso; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.tipoacceso (
    idtipoacceso integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE seguridad.tipoacceso OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16778)
-- Name: tipoacceso_idtipoacceso_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.tipoacceso_idtipoacceso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seguridad.tipoacceso_idtipoacceso_seq OWNER TO postgres;

--
-- TOC entry 2648 (class 0 OID 0)
-- Dependencies: 223
-- Name: tipoacceso_idtipoacceso_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.tipoacceso_idtipoacceso_seq OWNED BY seguridad.tipoacceso.idtipoacceso;


--
-- TOC entry 176 (class 1259 OID 16413)
-- Name: usuarios; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.usuarios (
    usuario_id integer NOT NULL,
    usuario_user character varying(50),
    usuario_pass character varying(200),
    usuario_nombres character varying(100),
    usuario_referencia text,
    perfil_id integer,
    estado character(1) DEFAULT 'A'::bpchar,
    idmiembro smallint,
    idtipoacceso smallint
);


ALTER TABLE seguridad.usuarios OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 16411)
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.usuarios_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seguridad.usuarios_usuario_id_seq OWNER TO postgres;

--
-- TOC entry 2649 (class 0 OID 0)
-- Dependencies: 175
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.usuarios_usuario_id_seq OWNED BY seguridad.usuarios.usuario_id;


--
-- TOC entry 2274 (class 2604 OID 25131)
-- Name: actividadmisionera idactividadmisionera; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.actividadmisionera ALTER COLUMN idactividadmisionera SET DEFAULT nextval('iglesias.actividadmisionera_idactividadmisionera_seq'::regclass);


--
-- TOC entry 2286 (class 2604 OID 25165)
-- Name: capacitacion_miembro idcapacitacion; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.capacitacion_miembro ALTER COLUMN idcapacitacion SET DEFAULT nextval('iglesias.capacitacion_miembro_idcapacitacion_seq'::regclass);


--
-- TOC entry 2249 (class 2604 OID 16911)
-- Name: cargo_miembro idcargomiembro; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.cargo_miembro ALTER COLUMN idcargomiembro SET DEFAULT nextval('iglesias.cargo_miembro_idcargomiembro_seq'::regclass);


--
-- TOC entry 2209 (class 2604 OID 16700)
-- Name: categoriaiglesia idcategoriaiglesia; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.categoriaiglesia ALTER COLUMN idcategoriaiglesia SET DEFAULT nextval('iglesias.categoriaiglesia_idcategoriaiglesia_seq'::regclass);


--
-- TOC entry 2187 (class 2604 OID 16565)
-- Name: condicioneclesiastica idcondicioneclesiastica; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.condicioneclesiastica ALTER COLUMN idcondicioneclesiastica SET DEFAULT nextval('iglesias.condicioneclesiastica_idcondicioneclesiastica_seq'::regclass);


--
-- TOC entry 2217 (class 2604 OID 16736)
-- Name: condicioninmueble idcondicioninmueble; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.condicioninmueble ALTER COLUMN idcondicioninmueble SET DEFAULT nextval('iglesias.condicioninmueble_idcondicioninmueble_seq'::regclass);


--
-- TOC entry 2272 (class 2604 OID 25122)
-- Name: control_traslados idcontrol; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.control_traslados ALTER COLUMN idcontrol SET DEFAULT nextval('iglesias.control_traslados_idcontrol_seq'::regclass);


--
-- TOC entry 2277 (class 2604 OID 25141)
-- Name: controlactmisionera idcontrolactmisionera; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.controlactmisionera ALTER COLUMN idcontrolactmisionera SET DEFAULT nextval('iglesias.controlactmisionera_idcontrolactmisionera_seq'::regclass);


--
-- TOC entry 2200 (class 2604 OID 16665)
-- Name: distritomisionero iddistritomisionero; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.distritomisionero ALTER COLUMN iddistritomisionero SET DEFAULT nextval('iglesias.distritomisionero_iddistritomisionero_seq'::regclass);


--
-- TOC entry 2223 (class 2604 OID 16766)
-- Name: division iddivision; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.division ALTER COLUMN iddivision SET DEFAULT nextval('iglesias.division_iddivision_seq'::regclass);


--
-- TOC entry 2236 (class 2604 OID 16863)
-- Name: historial_altasybajas idhistorial; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.historial_altasybajas ALTER COLUMN idhistorial SET DEFAULT nextval('iglesias.historial_altasybajas_idhistorial_seq'::regclass);


--
-- TOC entry 2271 (class 2604 OID 25097)
-- Name: historial_traslados idtraslado; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.historial_traslados ALTER COLUMN idtraslado SET DEFAULT nextval('iglesias.historial_traslados_idtraslado_seq'::regclass);


--
-- TOC entry 2190 (class 2604 OID 16640)
-- Name: iglesia idiglesia; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.iglesia ALTER COLUMN idiglesia SET DEFAULT nextval('iglesias.iglesia_idiglesia_seq'::regclass);


--
-- TOC entry 2254 (class 2604 OID 24990)
-- Name: institucion idinstitucion; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.institucion ALTER COLUMN idinstitucion SET DEFAULT nextval('iglesias.institucion_idinstitucion_seq'::regclass);


--
-- TOC entry 2149 (class 2604 OID 16472)
-- Name: miembro idmiembro; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.miembro ALTER COLUMN idmiembro SET DEFAULT nextval('iglesias.miembro_idmiembro_seq'::regclass);


--
-- TOC entry 2205 (class 2604 OID 16683)
-- Name: mision idmision; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.mision ALTER COLUMN idmision SET DEFAULT nextval('iglesias.mision_idmision_seq'::regclass);


--
-- TOC entry 2239 (class 2604 OID 16876)
-- Name: motivobaja idmotivobaja; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.motivobaja ALTER COLUMN idmotivobaja SET DEFAULT nextval('iglesias.motivobaja_idmotivobaja_seq'::regclass);


--
-- TOC entry 2241 (class 2604 OID 16886)
-- Name: otrospastores idotrospastores; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.otrospastores ALTER COLUMN idotrospastores SET DEFAULT nextval('iglesias.otrospastores_idotrospastores_seq'::regclass);


--
-- TOC entry 2251 (class 2604 OID 24975)
-- Name: paises pais_id; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.paises ALTER COLUMN pais_id SET DEFAULT nextval('iglesias.paises_pais_id_seq'::regclass);


--
-- TOC entry 2264 (class 2604 OID 25054)
-- Name: paises_jerarquia pj_id; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.paises_jerarquia ALTER COLUMN pj_id SET DEFAULT nextval('iglesias.paises_jerarquia_pj_id_seq'::regclass);


--
-- TOC entry 2185 (class 2604 OID 16556)
-- Name: religion idreligion; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.religion ALTER COLUMN idreligion SET DEFAULT nextval('iglesias.religion_idreligion_seq'::regclass);


--
-- TOC entry 2263 (class 2604 OID 25043)
-- Name: temp_traslados idtemptraslados; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.temp_traslados ALTER COLUMN idtemptraslados SET DEFAULT nextval('iglesias.temp_traslados_idtemptraslados_seq'::regclass);


--
-- TOC entry 2211 (class 2604 OID 16709)
-- Name: tipoconstruccion idtipoconstruccion; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.tipoconstruccion ALTER COLUMN idtipoconstruccion SET DEFAULT nextval('iglesias.tipoconstruccion_idtipoconstruccion_seq'::regclass);


--
-- TOC entry 2213 (class 2604 OID 16718)
-- Name: tipodocumentacion idtipodocumentacion; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.tipodocumentacion ALTER COLUMN idtipodocumentacion SET DEFAULT nextval('iglesias.tipodocumentacion_idtipodocumentacion_seq'::regclass);


--
-- TOC entry 2215 (class 2604 OID 16727)
-- Name: tipoinmueble idtipoinmueble; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.tipoinmueble ALTER COLUMN idtipoinmueble SET DEFAULT nextval('iglesias.tipoinmueble_idtipoinmueble_seq'::regclass);


--
-- TOC entry 2204 (class 2604 OID 16676)
-- Name: union idunion; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias."union" ALTER COLUMN idunion SET DEFAULT nextval('iglesias.union_idunion_seq'::regclass);


--
-- TOC entry 2246 (class 2604 OID 16901)
-- Name: cargo idcargo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargo ALTER COLUMN idcargo SET DEFAULT nextval('public.cargo_idcargo_seq'::regclass);


--
-- TOC entry 2232 (class 2604 OID 16827)
-- Name: condicioninmueble idcondicioninmueble; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.condicioninmueble ALTER COLUMN idcondicioninmueble SET DEFAULT nextval('public.condicioninmueble_idcondicioninmueble_seq'::regclass);


--
-- TOC entry 2221 (class 2604 OID 16754)
-- Name: departamento iddepartamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento ALTER COLUMN iddepartamento SET DEFAULT nextval('public.departamento_iddepartamento_seq'::regclass);


--
-- TOC entry 2174 (class 2604 OID 16509)
-- Name: distrito iddistrito; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distrito ALTER COLUMN iddistrito SET DEFAULT nextval('public.distrito_iddistrito_seq'::regclass);


--
-- TOC entry 2179 (class 2604 OID 16529)
-- Name: estadocivil idestadocivil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadocivil ALTER COLUMN idestadocivil SET DEFAULT nextval('public.estadocivil_idestadocivil_seq'::regclass);


--
-- TOC entry 2183 (class 2604 OID 16547)
-- Name: gradoinstruccion idgradoinstruccion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gradoinstruccion ALTER COLUMN idgradoinstruccion SET DEFAULT nextval('public.gradoinstruccion_idgradoinstruccion_seq'::regclass);


--
-- TOC entry 2146 (class 2604 OID 16449)
-- Name: idiomas idioma_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idiomas ALTER COLUMN idioma_id SET DEFAULT nextval('public.idiomas_idioma_id_seq'::regclass);


--
-- TOC entry 2265 (class 2604 OID 25061)
-- Name: nivel idnivel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel ALTER COLUMN idnivel SET DEFAULT nextval('public.nivel_idnivel_seq'::regclass);


--
-- TOC entry 2181 (class 2604 OID 16538)
-- Name: ocupacion idocupacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ocupacion ALTER COLUMN idocupacion SET DEFAULT nextval('public.ocupacion_idocupacion_seq'::regclass);


--
-- TOC entry 2234 (class 2604 OID 16850)
-- Name: pais idpais; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais ALTER COLUMN idpais SET DEFAULT nextval('public.pais_idpais_seq'::regclass);


--
-- TOC entry 2219 (class 2604 OID 16745)
-- Name: provincia idprovincia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincia ALTER COLUMN idprovincia SET DEFAULT nextval('public.provincia_idprovincia_seq'::regclass);


--
-- TOC entry 2260 (class 2604 OID 25003)
-- Name: tipocargo idtipocargo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipocargo ALTER COLUMN idtipocargo SET DEFAULT nextval('public.tipocargo_idtipocargo_seq'::regclass);


--
-- TOC entry 2226 (class 2604 OID 16800)
-- Name: tipoconstruccion idtipoconstruccion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipoconstruccion ALTER COLUMN idtipoconstruccion SET DEFAULT nextval('public.tipoconstruccion_idtipoconstruccion_seq'::regclass);


--
-- TOC entry 2177 (class 2604 OID 16520)
-- Name: tipodoc idtipodoc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipodoc ALTER COLUMN idtipodoc SET DEFAULT nextval('public.tipodoc_idtipodoc_seq'::regclass);


--
-- TOC entry 2228 (class 2604 OID 16809)
-- Name: tipodocumentacion idtipodocumentacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipodocumentacion ALTER COLUMN idtipodocumentacion SET DEFAULT nextval('public.tipodocumentacion_idtipodocumentacion_seq'::regclass);


--
-- TOC entry 2230 (class 2604 OID 16818)
-- Name: tipoinmueble idtipoinmueble; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipoinmueble ALTER COLUMN idtipoinmueble SET DEFAULT nextval('public.tipoinmueble_idtipoinmueble_seq'::regclass);


--
-- TOC entry 2282 (class 2604 OID 25153)
-- Name: trimestre idtrimestre; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trimestre ALTER COLUMN idtrimestre SET DEFAULT nextval('public.trimestre_idtrimestre_seq'::regclass);


--
-- TOC entry 2267 (class 2604 OID 25078)
-- Name: log_sistema idlog; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.log_sistema ALTER COLUMN idlog SET DEFAULT nextval('seguridad.log_sistema_idlog_seq'::regclass);


--
-- TOC entry 2142 (class 2604 OID 16408)
-- Name: modulos modulo_id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.modulos ALTER COLUMN modulo_id SET DEFAULT nextval('seguridad.modulos_modulo_id_seq'::regclass);


--
-- TOC entry 2140 (class 2604 OID 16400)
-- Name: perfiles perfil_id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.perfiles ALTER COLUMN perfil_id SET DEFAULT nextval('seguridad.perfiles_perfil_id_seq'::regclass);


--
-- TOC entry 2224 (class 2604 OID 16783)
-- Name: tipoacceso idtipoacceso; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tipoacceso ALTER COLUMN idtipoacceso SET DEFAULT nextval('seguridad.tipoacceso_idtipoacceso_seq'::regclass);


--
-- TOC entry 2144 (class 2604 OID 16416)
-- Name: usuarios usuario_id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('seguridad.usuarios_usuario_id_seq'::regclass);


--
-- TOC entry 2586 (class 0 OID 25128)
-- Dependencies: 269
-- Data for Name: actividadmisionera; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.actividadmisionera (idactividadmisionera, descripcion, tipo) FROM stdin;
1	Estudios Bíblicos	semanal
2	Visitas Misioneras	semanal
3	Visitas a enfermos Tratamientos	semanal
4	Visitas a Carceles	semanal
5	Contactos Misioneros	semanal
6	Inscritos al Curso Bíblico	semanal
7	Personas Traidas a la Reunión	semanal
8	Bíblias Regaladas	semanal
9	Libros Regalados	semanal
10	Revistas Repartidas	semanal
11	Volantes	semanal
12	Cartas Misioneras	semanal
13	Clase de Mestros. Esc. Sáb.	semanal
14	Visitas resividas del Ministerio	semanal
15	Reuniones Especiales	actmasiva
16	Pequeños Grupos Misioneros Organizados	actmasiva
17	Grupos Familiares Organizados	actmasiva
18	Misioneros Laicos (actual)	actmasiva
19	Conferencias Públicas	actmasiva2
20	Seminarios	actmasiva2
21	Capacitaciones	actmasiva2
22	Congresos	actmasiva2
23	Lecciones de Escuela Sabática Adultos	materialestudiado
24	Lecciones de Escuela Sabática Niños	materialestudiado
25	Lecciones de Escuela Sabática Infantes	materialestudiado
26	Folleto de Estudio	materialestudiado
27	Boletín Informativo	materialestudiado
\.


--
-- TOC entry 2592 (class 0 OID 25162)
-- Dependencies: 275
-- Data for Name: capacitacion_miembro; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.capacitacion_miembro (idcapacitacion, idmiembro, anio, capacitacion, centro_estudios, observaciones_capacitacion) FROM stdin;
1	7	2021	c	c	\N
2	7	2020	c	c	c
\.


--
-- TOC entry 2566 (class 0 OID 16908)
-- Dependencies: 246
-- Data for Name: cargo_miembro; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.cargo_miembro (idcargomiembro, idmiembro, idcargo, idinstitucion, observaciones_cargo, vigente, periodoini, periodofin, idiglesia_cargo, idnivel, idlugar, tabla, lugar) FROM stdin;
59	14	15	\N	2	1	2021	2024	2	1	\N	\N	\N
60	14	41	\N	ninguna	\N	2021	2025	2	12	4	iglesias.mision	Misión Sur
56	7	3	\N	23	1	2021	2024	1	\N	\N	\N	\N
57	7	5	\N	23	1	2018	2024	1	\N	\N	\N	\N
58	7	3	\N	123	1	2021	2025	1	\N	\N	\N	\N
\.


--
-- TOC entry 2527 (class 0 OID 16697)
-- Dependencies: 207
-- Data for Name: categoriaiglesia; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.categoriaiglesia (idcategoriaiglesia, descripcion) FROM stdin;
1	Iglesia
2	Grupo
3	Filial
4	Aislado/Interesado
\.


--
-- TOC entry 2517 (class 0 OID 16562)
-- Dependencies: 197
-- Data for Name: condicioneclesiastica; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.condicioneclesiastica (idcondicioneclesiastica, descripcion) FROM stdin;
0	Miembro de escuela
1	Bautizado
\.


--
-- TOC entry 2535 (class 0 OID 16733)
-- Dependencies: 215
-- Data for Name: condicioninmueble; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.condicioninmueble (idcondicioninmueble, descripcion) FROM stdin;
1	Construido
2	Semiconstruido
3	En Construcción
4	En Litigio
\.


--
-- TOC entry 2584 (class 0 OID 25119)
-- Dependencies: 267
-- Data for Name: control_traslados; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.control_traslados (idcontrol, idmiembro, idiglesiaanterior, idiglesiaactual, fecha, carta_traslado, carta_aceptacion, estado, iddivisionactual, pais_idactual, idunionactual, idmisionactual, iddistritomisioneroactual) FROM stdin;
5	16	1427	2	2021-07-14	\N	\N	1	1	1	1	1	1
\.


--
-- TOC entry 2588 (class 0 OID 25138)
-- Dependencies: 271
-- Data for Name: controlactmisionera; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.controlactmisionera (idcontrolactmisionera, idactividadmisionera, anio, trimestre, idiglesia, semana, valor, asistentes, interesados) FROM stdin;
236	1	2021	1	2	1	1	\N	\N
237	1	2021	2	2	1	2	\N	\N
238	1	2021	3	2	1	3	\N	\N
239	1	2021	4	2	1	4	\N	\N
\.


--
-- TOC entry 2521 (class 0 OID 16662)
-- Dependencies: 201
-- Data for Name: distritomisionero; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.distritomisionero (iddistritomisionero, idmision, descripcion, estado) FROM stdin;
1	1	San Martín	1
3	5	Paris	1
5	3	Cusco	1
6	4	Tacna	1
7	6	Asunción	1
8	7	Mexico DF	1
9	8	Caracas	1
\.


--
-- TOC entry 2541 (class 0 OID 16763)
-- Dependencies: 221
-- Data for Name: division; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.division (iddivision, descripcion, estado) FROM stdin;
1	Latinoamericana	1
2	Europea	1
\.


--
-- TOC entry 2545 (class 0 OID 16787)
-- Dependencies: 225
-- Data for Name: division_idiomas; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.division_idiomas (iddivision, idioma_id, di_descripcion) FROM stdin;
1	1	Latinoamericana
2	1	Europea
5	1	Asiatica
\.


--
-- TOC entry 2558 (class 0 OID 16860)
-- Dependencies: 238
-- Data for Name: historial_altasybajas; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.historial_altasybajas (idhistorial, idmiembro, responsable, fecha, observaciones, alta, idmotivobaja, rebautizo, usuario, idcondicioneclesiastica, tabla) FROM stdin;
\.


--
-- TOC entry 2582 (class 0 OID 25094)
-- Dependencies: 263
-- Data for Name: historial_traslados; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.historial_traslados (idtraslado, idmiembro, idiglesiaanterior, idiglesiaactual, fecha, idcontrol) FROM stdin;
22	5	2	1427	2021-07-13	\N
23	16	2	1427	2021-07-13	\N
24	14	2	1427	2021-07-13	\N
25	16	1427	2	2021-07-13	\N
26	14	1427	2	2021-07-13	\N
27	5	1427	2	2021-07-13	\N
28	16	2	1427	2021-07-13	\N
29	7	1424	1427	2021-07-13	\N
\.


--
-- TOC entry 2519 (class 0 OID 16637)
-- Dependencies: 199
-- Data for Name: iglesia; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.iglesia (idiglesia, telefono, descripcion, referencia, iddistrito, idcategoriaiglesia, idtipoconstruccion, idtipodocumentacion, idtipoinmueble, idcondicioninmueble, area, direccion, valor, observaciones, estado, iddepartamento, idprovincia, tipoestructura, documentopropiedad, iddivision, pais_id, idunion, idmision, iddistritomisionero) FROM stdin;
1		Barranca	esquina con Calle Jerusalen	1292	1	2	2	2	1	0	AV. pampa de lara N° 301	0	fg	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
3		Ventanilla	2° curva	683	2	4	1	0	0	\N	Psje.  9  Mz. I  Lt. 3,  AA.HH. Moisés Wool			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1181		Santa Clara		1235	0	0	0	0	0	\N	Santa Clara	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
6		Huaral	FRENTE MOTOREPUESTOS MUÑOZ	1325	1	2	1	2	3		PSJE. LUIS FALCON 321		dsf	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1178		Olmos		1244	0	0	0	0	0	\N	Olmos	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
10		San Pedro	paradero hogar	1273	2	2	2	2	1		Jr. Ayacucho Mz. J   Lt. 22 PANAMERICANA NORTE  Km. 37 y 1/2 			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
11		Zapallal	PARADERO LA PIEDRA	1273	2	2	4	2	1		Calle las Tunas  Mz. A Lt. 8D			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
44	054-251204	Cayma	la telefónica 	333	1	2	9	5	1	154	Los Arces 242	193949.43	recojer el titulo del concejo	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
47	\N	Chuquibamba	\N	\N	2	1	1	0	0	\N	Chuquibamba			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
48	\N	Ciudad Municipal	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
49	\N	Pachacútec	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
50	\N	Pedregal	\N	\N	2	1	1	0	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
51		Ilo		1499	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
52		moquegua		1482	1	2	6	2	1	117	Calle el Progreso Mz. \\"A\\" 1. Lte 7. 	1,200.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
53		Torata		1780	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
55	\N	Alto Alianza	\N	\N	2	1	1	0	0	\N	Tacna			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
56		San Roque	colegio willan prescon	1782	1	2	6	5	1	360	Jr. Buenos Aires Mz. \\"M\\"  Lote N°-.  9 y10	32,400		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
57	\N	Huaccamole	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
58	\N	Muñapucro	\N	\N	2	1	1	0	0	\N				0	\N	\N	\N	\N	\N	\N	\N	\N	\N
59	\N	Pomabamba	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
60		Andahuaylas		684	3	1	1	0	0	\N				0	\N	\N	\N	\N	\N	\N	\N	\N	\N
62		Calca		684	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
63		Cuzco		684	1	2	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
64	\N	Cusipata	\N	\N	2	0	0	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
65	\N	Huancarani	\N	\N	2	1	1	0	0	\N				0	\N	\N	\N	\N	\N	\N	\N	\N	\N
66	\N	Limatambo	\N	\N	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
67	\N	Quillabamba	\N	\N	3	1	1	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
68	\N	Sicuani	\N	\N	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
69		Azángaro		1609	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
70		Jr. Carabaya		1594	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
72		Juliaca A		1682	1	2	6	5	1	300	Av. Aviacion 717 Urb. Santa Adriana	donación		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
73	\N	Alegría	\N	\N	2	3	1	2	1	1000.24		3560.85	Son Tres Totes	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
76	\N	Mavila	\N	\N	2	1	5	0	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1229		Retamas		1182	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
78		Puerto Maldonado		1471	1	3	1	5	1		CALLE LOS CEDROS Mz . h Lot.6 BARRIO NUEVO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
80		Nuevo San Lorenzo		1215	1	2	9	5	1	220.45	Av. San Antonio Nº 1694, Nvo. San Lorenzo - JLO.	260170.15		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
81		José Pardo		1211	1	0	8	3	0		José Pardo Nº 185			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
82		Medio Mundo		1215	1	2	6	2	1	324	Jayanca Nº 161 - J. L. O.	64040.94		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
83		Tercer Sector		1215	1	2	9	2	3	70.63	José Goicochea Lt. 32 Mz. \\"A\\" Habilitación Urbana Salamanca - JLO.	25000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
84		Santa Ana		1215	1	2	6	2	1	165	San Salvador Nº 1324	30979.20		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1191		Yanas		905	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
87		Roca Eterna		1215	2	0	8	3	0		Entre la Avenida Chiclayo y Bolivar			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
89		Las Brisas		1216	2	0	8	3	0		Agustín Vallejo Zavala Nº 645 			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1184		Chavin de Pariarca		920	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
94		El Bosque		1216	1	2	9	2	2	217.76	Av. Mayta Capac Nº 1881			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
95		Cayaltí		1226	2	2	3	2	3	225	Santa Rosa Baja  Alta frente al parque			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1197		Santiago		601	0	0	0	0	0	\N	caserio santiago (sector chilintón)	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
98		Huaca Rajada		1219	2	0	8	3	0		HUACA RRAJADA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
99		Las Vegas	A UN COSTADO DE LA CARRETERA QUE VA A LAGUNAS	1217	2	0	8	3	0		LAS VEGAS			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
101		Nuevo Mocupe		1217	1	0	7	1	0	1440	CALLE TACNA S/N	6140.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
104		Nueva Esperanza		1217	2	0	5	1	0		Ref. Fundo Fujimori			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
105		Santa Rosa		1224	3	0	8	3	0		Santa Rosa			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
106		Tumbes		1807	1	0	5	1	0		JR. GENERAL MORZAN  N° 505			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
107		Los Geranios		1817	2	1	7	2	3	161	JUAN VELASCO ALVARADO MZ. C LT. 11 AA.HH. LOS GERANEOS			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
108		Villa Primavera		1817	2	1	7	2	1	1000	AA.HH VILLA PRIMAVERA MZ. T III ETAPA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
109	\N	Las Malvinas	\N	\N	2	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
111	\N	Pampas de Hospital	\N	\N	2	3	5	2	3					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
113		La Molina		1530	2	3	5	2	2		CALLE JERUSALEB MZ 33 LT. 3   ASOC. CIVIL DE LA MOLINA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
115		Cieneguillo Sur Alto		1574	2	1	5	2	1		cieneguillo sur			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
116		Corrales Canchaque		1550	2	0	8	3	0		Corrales Canchaque			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
117		 Piura		1530	2	2	6	5	1	201.25	ALEJANDRO TABOADA N° 218 SAN MARTIN	1500.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
118		Sullana		1574	1	2	2	2	1	140.80	CALLE SAN PEDRO MZ B1 LT. 14 BARRIO JESUS MARIA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
119		Chirinos Suyo		1548	1	1	3	2	1	525	C.P. CHIRINOS MZ. 3 LT. 5	50000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
120		La Cruceta		1574	3	0	8	3	0		la cruceta			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
121		Los Cocos		632	1	1	3	2	1	140	LOS COCOS	200.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
122		Tailín		632	1	1	3	2	1	180	TAILIN	200.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
123		La Alfalfilla		632	1	1	5	2	1		LA ALFALFILLA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
124		San Juan de Higuerones		1549	2	1	5	2	1		SAN JUAN DE HIGUERONES			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
125		Shimana		632	2	1	1	2	1	105	SHIMANA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
127		Chicope		1549	2	0	8	3	0		CHICOPE			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1189		SAN CRISTOBAL		905	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
129		Chalanmache		632	2	0	8	3	0		CHALANMACHE			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
130		Los Méjicos		632	2	1	3	2	1	300	LOS MEJICOS	200		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
132		Lipanga		1552	2	0	8	3	0		LIPANGA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
133		La Lima		632	3	0	8	3	0		La Lima			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
134		Progreso		632	3	0	8	3	0		PROGRESO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
135		Lanchez Bajo		658	2	1	3	2	1	448	Lanchez Bajo	20.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
136		Agua Azul		655	2	1	3	2	1	250	AGUA AZUL	800.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
137		La Granadilla		655	2	1	3	2	1	60	LA GRANADILLA	1500.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
138		Montaña de Sequez		655	2	1	3	2	1	682	MONTAÑA DE SEQUEZ	1100.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
139		Pampas de Sequez		655	2	1	3	2	1	170	PAMPA DE SEQUEZ			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
140		El Palmo		655	2	1	5	2	1		EL PALMO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
141		La Florida		655	2	1	3	5	1	499.10	JOSE GALVEZ MZ. 31 LT. 5	2200.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
142		La Laja		655	2	1	7	2	1	126	LA LAJA	70.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
143		Macuaco		655	2	1	7	2	1	650	MACUACO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
144		El Papayo		655	4	0	8	3	0		EL PAPAYO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
145		Cerro Negro		655	2	0	8	3	0		CERRO NEGRO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
146		Succha Pampa		655	2	1	5	2	1		SUCCHA PAMPA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
147		Callualoma		655	2	1	5	2	1		CALLUALOMA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
148		Lanchez C.P.M.		658	2	1	3	1	1	615	LANCHES C.P.M.	200		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
149		Miravalles		658	2	1	7	2	1	120	MIRAVALLES	1000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
150		El Padrio		658	2	1	5	2	1		EL PADRIO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
151		Bebedero		658	2	1	5	2	1		BEBEDERO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
152		El Poleo		658	3	0	8	3	0		EL POLEO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
153		Espinal		655	2	0	8	3	0		ESPINAL			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
154		La Alfalfilla		658	2	1	1	0	0	240	LA ALFALFILLA	100.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
155		Nueva Arica		1219	3	0	8	3	0		NUEVA ARICA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
156		Oyotún		1220	4	0	8	3	0		Oyotún			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
157		Quernoche		655	4	0	8	3	0		QUERNOCHE			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
158		Niepos		658	3	0	8	3	0		NIEPOS			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
159		Huambos		587	1	1	3	5	1	960	Jr. 24 de Junio 	1000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
160	\N	Pan de Azúcar	\N	\N	1	1	5	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
166		Santa Cruz		667	2	0	6	1	0	175	jr. francisco Bolognesi d/n	5100.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
167	\N	El Obraje	\N	\N	2	1	5	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
170		Chococirca		587	1	1	7	2	1	400	Chococirca	100.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
173		Chota		579	2	0	8	3	0		Chota			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
174	\N	Chiribamba	\N	\N	2	0	8	3	0		Chiribamba			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
175	\N	Anguia	\N	\N	3	0	8	3	0		Anguía			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
176		Pauquilla		670	2	1	3	2	1	200	pauquilla			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1417		Ollachea 		1631	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
179	\N	Sogos	\N	\N	3	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
180		Bagua Capital	AV. PRINCIPAL	22	1	2	9	5	1	600	AV. HEROES DEL CENEPA 1832	1200.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
181		Guadalupe	FRENTE A LA PLAZA DE ARMAS	22	1	1	1	2	1	174.54	GUADALUPE	2000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
182		Campo Redondo		44	2	1	1	0	0	\N	CAMPO REDONDO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
184		Chinganza		23	2	1	1	2	1	140	CHINGANZA	600.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
185		El Molino		635	2	1	1	2	1	150	EL MOLINO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
186		Soldado Oliva		23	2	1	1	2	1	600	Soldado Oliva			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
187		Muyo		23	2	1	1	0	0	240	EL MUYO	2400.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
188	\N	Panamá	\N	\N	2	1	1	0	0	\N				0	\N	\N	\N	\N	\N	\N	\N	\N	\N
189		Naranjos		27	2	1	1	2	1	300	NARANJOS	600.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
190		Vista Alegre		23	2	3	1	2	1	244	VISTA ALEGRE	5000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
191	\N	Alenya	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
192		Aramango		23	4	1	1	2	1	80	ARAMANGO	150.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
193		Reposo		22	2	0	7	1	0	750	EL REPOSO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
195		La Papaya		22	4	1	1	0	0	\N	LA PAPAYA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
196		Jaén		624	1	2	6	5	1	560	Jr. Cajamarca N° 812	12000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
197		Chirinos		637	1	2	1	2	1	600	CRIRIÑOS			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
198		Tabacal		626	2	1	1	2	1	200	TABACAL	1000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
199		Platanurco		626	2	1	1	2	1	300	PLATANURCO	500.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
200	\N	Balsal/ Nva. Alianza	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
201		Bellavista		625	1	1	1	2	1	148.70	6 DE AGOSTO CUADRA 1	3331.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
202	\N	El Gilgal	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
203		Monterrico		639	2	1	3	2	1	250	MONTERRICO	1000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
204		Rumipite		639	2	1	3	2	1	380	Rumipite	4000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
205	\N	Flor de Selva	\N	\N	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
206	\N	Morroponcito de Huarango	\N	\N	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
207		Los Ángeles		627	3	1	1	2	1	180	loas ángeles			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
209		Torre de Babel		641	4	1	1	2	1	195	Torre de babel	2000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
210		Chachapoyas		1	1	2	9	5	1	512	TENIENTE NICOLAS ARRIOLA S/N	49844.20		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
211		San Juan de Cheto		4	1	1	1	2	1	153	calle castilla s/n	5000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
212		Cohechán	CAMINO AL C.E. 18113	47	1	1	1	2	1	299.5	COHECHAN	1500.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
213		Chocta		51	1	2	1	2	1	577.76	CHOCTA	5000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
214		Collacruz		11	1	1	1	2	1	1680	COLLACRUZ	2000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
215	\N	San Juan de Cachuc	\N	\N	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
216		Tinas		20	2	1	1	2	1	500	Tinas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
217		Carilda		47	2	1	1	0	0	\N	CARILDA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
218	\N	La Pampa	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
219		Cruz Pata	A UN COSTADO DE LA AV. EL TURISMO	65	2	1	1	2	1	500	CRUZ PARA	2000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
220		Luya		51	2	1	6	2	1	606	LUYA	1000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
221	\N	Ingilpata	\N	\N	4	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
222	\N	Jalca Grande	\N	\N	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
224	\N	Mendoza	\N	\N	4	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
225	\N	Onmia	\N	\N	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
226	\N	Plan Grande	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
228		Nuevo Gualulo		33	1	1	1	0	0	\N	NUEVO GUALULO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
318		La Morada		936	1	2	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
229		Pomacochas		33	1	1	3	2	1	354.62	JR POMACOCHAS MZ. 70 LT. 13	10000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
230		Pedro Ruíz		34	1	2	1	2	1	155	JR. CIRO ALEGRIA S/N			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
233		Chilac		28	1	1	1	2	1	200	Chilac			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
234	\N	San José Alto	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
235		San José Bajo		33	2	1	1	2	1	200	SAN JOSE BAJO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
237	\N	Beirut	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
238	\N	Jumbilla	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
240	\N	Fanre	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
242		La Florida		33	4	1	1	0	0	\N	La Florida			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
243		Tarapoto	Barrio Huayco	1761	1	2	9	5	3		Jr. Ricardo Palma 1076			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
244		La Esperanza	a Espalda del Colegio \\"Niños en Acción\\"	1132	1	1	9	2	1		José María Zapiola Nº 1901			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1218		Alto Trujillo (Barrio 2-B)		1129	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1219		Alto Trujillo B° 4A		1129	0	1	1	2	3		Alto Trujillo B° 4A			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
248	7934408	Pachacutec	Paradero Llantero   Antes del mercado Hatun Inca	683	2	2	9	2	1		Sector B Mz.  G Lt. 16 			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
249		Keiko Sofía	Entrar por Km.  39 Panamericana Norte	683	2	2	9	2	3		Calle el Dorado  Mz. W  Lt 13  Segunda Etapa Pachacutec - Ventanilla			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1174		La Olleria		1242	0	0	0	0	0	\N	La Olleria - Morrope	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
252		Canto Grande	PARADERO 5  Mariscal Cáceres - S.J. Lurigancho	1280	1	3	7	2	1		MZ.  C LT. 8 AA.HH. Jesús de Nazaret			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
253		Santa Clara		1251	2	2	8	3	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
254		Chosica		1251	2	2	8	3	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
255	7266293	Villa El Salvador Sector 6		1290	1	2	6	2	1		MZ.  N  LT. 24  GRUPO 8 			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
256	2920390	Villa El Salvador Sector 1		1290	1	2	6	5	1		MZ.  I  LT. 15 GRUPO 23			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
258		Huertos de Manchay	Av, Manchay, pasando Av, Naranjos , bajar en parad	1271	2	2	1	2	1		Mz.  F 11, Lt.  7  Sector F			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
259		Zárate	DETRAS DE LA IGLESIA CATOLICA	1280	2	2	8	0	0	\N	Jr. Tahuantinsuyo N° 522			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
260		Huacho	POR LA POSTA HUALMAY, 1 CUADRA A LA IZQUIERDA	1369	2	1	1	0	0	\N	PROLONG. GABRIEL AGUILAR 429			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
261		UNIÓN BAJA		1379	2	1	1	0	0	\N	PALPAS			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
262		Paraiso		1292	2	2	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1367		MIRAFLORES		1751	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
269		San Isidro		976	1	2	4	2	1		JR. LIMA 1782			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
270		Pueblo Nuevo		969	1	1	1	0	0	\N	Chincha			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
980		Nanrrá		604	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
276		 Salas		979	1	0	8	3	0		SECTOR LOS BANCARIOS 			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
277	064-385087	Chilca	Altura Av. Próceres Cdra. 10	1009	1	2	9	5	1	520	Jr. Ancash 1165 - Chilca 			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
278		Hualhuas	Paradero: Jr. Lima	1016	1	1	9	2	1	131.60	Av. Alfonso Ugarte 823 - Hualhuas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
279		Bellavista	Referencia: Pasando Estadio	1125	1	1	2	2	1	1,555	Av. Atahualpa s/n Bellavista.		esperando... se inicio tramites en Sunarp de desmembramiento de la Comunidad Campesina de Acac Bellavista, para ser considerados dueños legítimos...	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
280		La Esperanza		1125	1	1	2	2	1	150	Carretera a Caserío Paccha s/n - La Esperanza 		esperando... se inicio tramites en Sunarp de desmembramiento de la Comunidad Campesina de Acac Bellavista, para ser considerados dueños legítimos...	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
281		Huamancaca Chico	Ref: I.E. N° 30111 “Cristo Rey”.	1123	1	0	2	1	0	139.50	Psje. Ramón Castilla s/n Anexo Miraflores			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
282		Cerrito de La Libertad	Ref: Bajar por Psje Los Granizos	1005	1	2	9	2	1	101.70	Psje. Cordillera 175 – Barrio Las Rosas	18,969.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
283		San Juan de Jarpa	Refer: antes de la Garita.	1125	1	1	3	2	1	202.72	Av. Manco Cápac Mz: F, Lote: 3, Barrio Chacapampa.		esperando... se inicio tramites en Sunarp de desmembramiento de la Comunidad Campesina de Jarpa, para ser considerados dueños legítimos...	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
284	064-830453	Pucacocha / Andamarca		1035	1	1	8	3	0	100	Jr. Jorge Chávez Darwin s/n - Plaza Principal de Pucacocha	1000		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
285		San Lorenzo / Jauja	Refer: Viniendo de Huancayo 18 Km antes de Jauja. 	1081	2	0	2	1	0	32	Jr. 2 de Mayo 1174 - (Paradero) Miraflores.			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
286		Pampas / Huancavelica	Refer: Entrada-Policía de Carreteras.	870	3	1	5	3	0		Av. Progreso 775, Tayacaja, Huancavelica.			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
287		Tarma Progreso		1100	1	2	9	5	1		Jr. Bellavista s/n    Barrio el  Progreso.			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
288		Huasahuasi		1103	2	1	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
289		Acracocha		1101	2	0	5	1	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
290		La Oroya		1109	2	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
970		chipaquillo		924	0	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
292		La Campiña		1092	1	2	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
978		Las Tayas		601	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
294		Santa Ana		1049	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
295		Pichanaki	ALT. GRIFO LOZANO	1050	2	1	1	0	0	\N	AV. SANTA ROSA 778			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
296		Portillo Alto		1098	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
297		Sinchi Jaroki		1092	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
298		Atalaya		1827	3	2	8	3	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
300		Huánuco		886	1	2	9	5	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
301		Cabramayo		886	1	1	1	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
302		Cochas		886	1	1	1	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
303		Incajamaná		886	1	1	1	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
304		Llicua		886	1	1	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
305		Salapampa		886	2	1	8	3	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
307		Cauri		887	2	1	8	3	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
308		Margos		886	2	1	8	3	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
309		Taruca		886	2	1	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
310		Colpashpampa		899	2	1	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
311		Cayhuayna		886	2	1	2	2	2					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1196		San Juan de Contumazá		598	0	0	0	0	0	\N	San Juan -- Contumazá	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
314		Ambo		897	2	1	8	3	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
316		Tingo María		929	1	2	9	2	1		jr. yurimaguas 767			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
317		Aucayacu	FRENTE AL COLEGIO SANTA ROSA	932	1	2	2	2	1		JR. HUANCAYO  S/N			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
319		PAMPAMARCA		924	2	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
321		Pueblo Nuevo		932	2	2	2	2	3					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
322		Pueblo Libre		1779	2	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
323		Castillo Grande		929	2	2	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
956		AV. CAMANA		360	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
325		La Florida		936	2	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
957		Espinar		740	0	0	0	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1402		Buenos aires		1752	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1382		ASUNCIÓN		552	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1202		Villa Hermosa		1215	0	0	0	0	0	\N	Villa Hermosa	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1344		ARMANAYACU		1720	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
342		Pinto Recodo		1731	3	0	3	1	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1355		NUEVA VIDA		1721	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1356		PACHIZA	ESQUINA DEL CAMPO DEPORTIVO	1740	0	0	0	0	0	\N	JIRON SAN MARTIN	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1357		PISCUYACU		1723	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1358		NUEVO SAN MARTIN		1738	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1359		SANAMBO		1740	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1360		SANTA INEZ		1739	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1395		Poroto		1135	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1384		La Lucma del Guayabo		559	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1391		Catuay Bajo		1137	0	2	9	2	1				ESTÁ EN PROCESO LA SUB DIVISIÓN	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1392		Chinchango		1156	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1387		Alto Trujillo B 4B		1129	0	2	3	1	3					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1388		Allacday		1160	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
376		Iquitos		1420	1	2	9	5	1		Calle Diego de Almagro n° 714			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
377		Triunfo		1430	3	0	2	1	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
380		Los Claveles		1703	1	2	9	5	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
388		Alamo		1708	2	2	7	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
389		Buenos Aires		1703	2	1	7	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1310		CAMPO ALEGRE		1706	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
392		Sugllaquiro		1703	3	1	7	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
396		Nuevo Jaén		1708	3	2	7	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
397		Rioja 		1752	1	2	9	5	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
398		Nueva Cajamarca		1755	1	2	5	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
399		Alto Mayo		1753	2	1	7	0	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
400		Naranjos		1752	2	2	7	2	3					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
401		San Juan		1753	2	0	0	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
402		La Unión		1755	2	0	5	2	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
403		Nuevo Piura		1703	2	3	1	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
405		Valle Grande 		1754	2	1	5	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
406		San Fernando		1758	3	0	2	1	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
955		Naranjillo		1755	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1372		I.E. SAN MATEO TARAPOTO		1761	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
411		Bajo Espital		22	2	1	1	0	0	\N				0	\N	\N	\N	\N	\N	\N	\N	\N	\N
415	\N	Psje. Huascar	\N	\N	2	0	8	3	0		María Parado de Bellido # 169			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
416		Bethel - La Victoria		1216	1	2	9	2	1	94.67	Av. Pachacute Nº 1184			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
417	\N	Yerba Buena	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
420		El Prisma	al costado del Mercado de Papas-Chicago	1128	1	2	9	2	1	295.41	Mz: C, Lote: 6, Fundo El Prisma	173,344.08		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
421		Huanchaquito Alto	Paradero San Carlos	1131	2	1	1	2	2	119.50	Mz: 4, Lote: 1, Etapa II, San Carlos		CAMBIE LA RAZON SOCIAL EN HIDRANDINA, FALTA GESTIONAR AGUA POTABLE Y DESAGUE Y SANEAR DOCUMENTOS DE PROPIEDAD EN COFOPRI	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1063		Taulís Calquis		655	0	0	0	0	0	\N	Taulis	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
424		El Milagro	a 3 Cuadras de Plaza de Armas de El Milagro	1131	2	2	9	2	1	302.20	Calle Manco Capac Mz: 23, Lote: 22, Sector V.	70367.20		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
425		Laredo	Paradero: Bodega \\"Marilyn\\" por Posta Medica.	1133	2	2	1	2	3	140	Urb. Santa Maria, Etapa I, Mz. C Lt. 9		HAY QUE HACER SUBDIVISIÓN Y NUEVA ESCRITURA PARA INGRESAR A SUNARPP	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
426		Víctor Raúl de Huanchaco	por el Colegio Juana Mujica	1132	1	1	1	5	1		Calle Las Antaras Mz: 75, Lote: 10	3,500.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
427		Valdivia Alta	casa de Joaquín Ramos	1131	2	2	1	1	3		Calle Los Chincheros, Mz: 41, Lote: 11 Sector Valdivia Alta - Víctor Raúl de Huanchaco			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
429		Alto Salaverry (Alto Moche)	altura Paradero 11 de la Panamericana Norte	1136	2	1	9	2	3	198.50	Calle: El Porvenir Mz: J, Lote: 8, Sector I, c/esquina Santa Rosa			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
430		Santa Sofía	frente a Pesqueda, a espalda de una Loza deportiva	1128	2	1	9	2	1	297.45	Calle: 8, Mz: G, Lote: 6. Urb. Popular Santa Sofía	41,180.23	existen 2 lotes, Urb. Popular Santa Sofía, Mz: G, Lotes: 5-A y 6, el 6 ya está en RR.PP, está en proceso el saneamiento del otro lote 5-A.	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
432		Trujillo Centro	a 1/2 Cuadra del Ministerio de Transporte	1128	1	2	9	2	1	226.39	Jr. México Nº 455 interior 4	78,114.95		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
434		Buenos Aires Sur	Frente al Parque La Poza	1138	1	1	9	2	1	334.020	Av. Bolivia Nº 880			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
435		Maracaná		1129	1	1	2	5	3	1548.12	Jr. San Luis 160 - Rio Seco - El Porvenir			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
436		Alan García	por la Pollería \\"Gilberth\\"	1132	1	1	4	2	1		Urb. Tepro Parque Industrial Mz. K Lt. 9	7,000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
437		Florencia Alta	x Grifo \\"Mi Wilmercito\\" entrar 2 cuadras a la Izq	1130	1	2	2	2	3	374.320	Calle: 29 de Junio Nº 2031		AUTOVALUO AL DIA, INAFECTADO DE IMPUESTO PREDIAL MAS NO DE ARBITRIOS MUNICIPALES	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1397		Los Claveles		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
969		Cospán		554	0	0	0	0	0	\N	Cospán	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1320		SANTA ROSA		1704	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1398		Nuevo Huancabamba		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1338		ALTO PONAZA		1750	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1340		NV. CHANCHAMAYO		1751	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1368		N.V LAMBAYEQUE		1749	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
447		Conache	en casa de Hno. Germán y Esperanza	1133	2	1	5	4	2		Conache		PRESTADO POR LA UNICA FAMILIA DEL LUGAR	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
449		La Botella		1140	3	1	1	0	0	\N	Caserío La Botella			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
451		Compartición		1140	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
452		Huabalito		1140	2	1	1	0	0	\N	Caserío Huabalito			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
454		Salinar A		1140	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
457		Paiján	Distrito de Paiján	1143	1	1	1	0	0	\N	Paiján			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
458	943 322 738	Quebrada honda		1140	2	1	1	0	0	\N	Carretera a cascas. Paradero panaderia. El espejo.			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
459		Membrillar A		1140	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
460		Jaguey		1140	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
461		La Planta		1143	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
462		Sausal		1140	1	1	9	0	0		AA.HH. Alto Perú Barrio 2, Mz: 10, Lote: 5			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
463		Mocan		1146	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
464		La Portada		602	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
465		Miragón		1168	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
466		Membrillar B		1140	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
467		Parrapós		1168	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
468		Pampas de Jaguey		1140	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
470		Ascope	Ascope	1139	1	1	9	2	1		Buenos Aires 120			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
471		Huamachuco Centro		1188	1	1	9	0	0		Jr. San Martín 661			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
472		Curgos		1191	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
473		Coipín Bajo		1188	1	1	1	0	0	\N	Caserío Coipín			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
478		Santo Domingo	Distrito Cachicadán	1198	3	1	9	0	0		Caserío Santo Domingo		FALTA SUB DIVIDIR.	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
479		Sazón		1188	2	1	1	0	0	\N	Barrio Sazón			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
480		Cascas		1204	1	1	1	0	0	\N	Cascas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
483		Jolluco	Distrito Cascas	1204	1	1	1	0	0	\N	C.P.M. Jolluco			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
484		Huancay	Dist. Marmot - Prov. Gran Chimú	1204	1	1	1	0	0	\N	Caserío Huancay			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
485		Panamá	Dist. Marmot - Prov. Gran Chimú	1204	2	1	1	0	0	\N	Caserío Panamá			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
486		Pampas de Chepate	Distrito Cascas	1204	1	1	1	0	0	\N	C.P.M. Pampas de Chepate			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
489		La Laguna		1204	2	1	1	0	0	\N	Distrito de Cascas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
490		Tillampú		1204	2	1	1	0	0	\N	Cascas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
491		Llacahuán	se atiende desde Cascas	1160	2	1	1	0	0	\N	Pertenece al Distrito de Otuzco			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
492		El Molino		1204	3	1	1	0	0	\N	Cascas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
493		Palmira		1204	2	1	1	0	0	\N	Cascas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1012		Las Tunas		1204	0	0	0	0	0	\N	Cascas	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
498		Tambo Puquio		1204	2	1	1	0	0	\N	Cascas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
500		Salitre		1204	2	1	1	0	0	\N	Cascas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1237		Portachuelo		1189	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
505		Nueve de Octubre		1204	2	1	1	0	0	\N	Cascas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
509		Pampas del Bao (Paquisha)		1204	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
510		Corlas	Distrito Cascas	1204	2	1	1	0	0	\N	Caserío Corlas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1235		Caucharatay		1189	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
514		Contumazá	Cerca del colegio David León (AGRO)	598	1	1	1	0	0	\N	Jr. Tantarica 115			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
515		Congadipe		601	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
519		Cruz Grande		601	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
521		Choloque		601	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
524		Ayambla		603	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
525		La Succha		601	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
526		Espino Largo		601	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1004		San Martín		1204	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
532		Yetón		602	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1002		Quihuate		554	0	0	0	0	0	\N		\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N
1001		Cortaderas		623	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
535		La Pampa (Guzmango)		601	1	1	1	0	0	\N	Caserío: La Pampa, cerca de Guzmango			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
536		Toledo		603	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1003		Huaycotito		554	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1225		Huayobamba		554	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
542		Guzmango		601	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
545		Cascabamba \\"A\\"		598	3	1	1	0	0	\N	Cascabamba, Contumazá			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1289		PEBAS		1715	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1290		NV-, HUAMACHUCO		1715	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1049		CAMANÁ	CERCA  A LA PANAMERICANA AL ESPALDA DE UN COLEGIO	361	0	0	6	1	0	200	LA RINCONADA DE HUACAPUY MZ  \\"C\\" LOTE 05.	10,000.00	POR CONSTRUIR	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
552	\N	Convento	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
553		Rosas-Cachimarca	Dist. Cochorco - Prov. Sánchez Carrión	1190	1	1	1	0	0	\N	Caserío de Purun Rosas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
554	\N	Uchuy	\N	\N	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
555		Soquián		1190	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
556	\N	Tayango	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
557	\N	Marcabal Grande CENTRO BETEL	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
558		Aricapampa		1190	2	1	9	0	0		Caserio de Aricapampa			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
559	\N	Gloriabamba	\N	\N	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
560		Molino Viejo	Dist. Cochorco - Prov. Sánchez Carrión	1190	2	1	1	0	0	\N	Caserio Molino Viejo			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
561	\N	Uchubamba	\N	\N	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
562	\N	La Pauca	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
563		Vista Florida	Dist. Chillia - Prov. Patáz	1177	2	1	1	0	0	\N	Caserio Vista Florida			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
564		Ganzúl		1192	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
565		Cachipampa		1195	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
567		Vijus	Dist. Patáz - Prov. Patáz	1183	2	1	1	0	0	\N	Caserío Vijus			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
568		Los Alisos	Dist. Parcoy - Prov. Patáz	1182	2	1	1	0	0	\N	Caserio Los Alisos			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
569		La Cienaga	Dist. Patáz - Prov. Patáz	1183	2	1	1	0	0	\N	Caserío La Cienaga			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
570		Zarumilla	Dist. Patáz - Prov. Patáz	1183	3	1	1	0	0	\N	Caserío Zarumilla			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
571		Cardón		1195	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
574		Sartimbamba		1195	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
575		Puente el Oso	orillas del Marañón - Dist. Pataz	1183	2	1	1	0	0	\N	Caserio Puente El Oso			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1255		Cruce el Milagro		1170	0	1	9	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
577		Shin Shil	Dist. Sarín - Prov. Sánchez Carrión	1194	2	1	1	0	0	\N	Caserío de Shin Shil			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
578		Llantén	Distrito de Sarín	1194	2	1	1	0	0	\N	Caserío Llantén			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1248		Pampa Alegre		649	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
580		Nueva Unión	Distrito de Sarín	1194	2	1	1	0	0	\N	Caserío Nueva Unión			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
581		Nueva Esperanza	Por el Caserío Cerpaquino	1194	1	1	9	0	0		Caserío Nueva Esperanza			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
582		Succha Centro	Dist. Cochorco - Prov. Sánchez Carrión	1190	2	1	1	0	0	\N	Caserío Succha Centro			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
583		Sarín	Distrito de Sarín	1194	1	1	1	0	0	\N	Calle: Abelardo Gamarra Rondó s/n			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1249		Choctapampa		574	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
585		Pishauli		1189	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1256		Nuevo Pacasmayo		1173	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
587		Chugay		1189	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1239		Cochorco		1190	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
592		Pijobamba	Dist. Sitabamba - Prov. Stgo. Chuco	1203	1	1	1	0	0	\N	Caserío Pijobamba			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1244		El Chirimoyo		643	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1241		El Cardón		649	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1242		La Cruz Blanca		564	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
596		Hualay	Distrito de Sarín	1194	1	1	3	2	3		Caserío Hualay			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
597		Poc Poc Centro	Distrito de Sarín	1194	1	1	1	0	0	\N	Caserío Poc Poc			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
598		Munmalca	Distrito de Sarín	1194	1	1	1	0	0	\N	Caserío Munmalca			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
599		Nuevo Belén	Distrito de Sarín	1194	1	1	1	0	0	\N	Caserío Nuevo Belén			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
600		Uruspampa	Distrito de Sarín	1194	1	1	1	0	0	\N	Caserío Uruspampa			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
601		Cajamarca	Cajamarca	551	1	1	1	0	0	\N	Diego Ferré 267 - Sta. Elena			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
603		Choropampa Baja	Choropampa	584	1	1	1	0	0	\N	Flavio Castro s/n			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1280		Chala - Bambamarca		621	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
612		Mollepata		552	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
613		Magdalena		559	1	2	3	2	3					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1352		EL DORADO		1720	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
616		La Shayhua		598	3	1	1	0	0	\N	Caserío La Shayua, Dist. y Prov. Contumazá			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
617		Succhabamba		559	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1234		Casgabamba		1194	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1283		Bellavista		598	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
623		Jesús		556	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
624		Choropampa Alta		559	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1295		AMIÑIO		1715	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1292		LA LIBERTAD		1715	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1236		Payures		1203	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1281		San Antonio		598	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
634		Santa Bárbara		558	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1294		ALAO		1715	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
636		Namora		561	4	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
640		La Lima		564	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
645		Cajabamba		563	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
646		Santa Cruz		667	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
647		Campo Alegre		645	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
648		San Marcos		647	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
650		Azufre		643	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
651		El Sauce o Cachachi		564	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
653		Alto Yerba Buena		561	2	1	1	0	0	\N	Alto Yerba Buena			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
654		HUANGASHANGA		570	3	1	5	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1051		Alegria		1473	0	0	0	0	0	\N	Lote 8 Mz. x1. centro poblado Zona 2	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1257		Las Palmeras		1173	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
658		Nueva Jerusalén		636	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
660		Pacay		641	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
662		Bolivar		1147	2	1	1	0	0	\N	Distrito Bolivar			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
663		La Morada		648	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
664		El Triunfo		649	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
665		Malat		649	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
666		La Pauca		643	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
668		Yalén		1147	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
669		Ucuncha		651	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
670		Uchumarca		1151	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
671		San Francisco		551	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
673		Milauya		1147	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
674		El Pozo		1147	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1050		Fundo \\"El Edén\\"	Carretera al Cusco	1474	0	0	0	0	0	50,000	Kilometro 68	Donación		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
676		Celendin		567	3	1	1	0	0	\N	Distrito de Celendín			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
677		Llamactambo		1151	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
678		Callacat		578	2	1	1	0	0	\N	Callacat			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
679		San Vicente de Paúl		1150	1	1	1	0	0	\N	C.P.M. San Vicente de Paul			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1317		PARAISO		1706	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
682		Tembladera		605	1	1	1	0	0	\N	Capital del Distrito Yonán, Contumazá			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
683		San Juán de Dios		1154	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
684		Nueva Jerusalén		1172	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1348		CAMPANILLA		1738	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
686	\N	Ventanillas	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
687		Guadalupe		1171	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
688		Villa Hermosa		1153	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
689		Junín (Chepén)		1153	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1311		CARACHUPA YACO		1706	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1312		CARRIZAL		1706	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1380		Parque Industrial - El Poso		1132	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
693		Zapotal		605	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
694		El Mango	a 30 minutos de Pacasmayo	605	2	1	1	0	0	\N	Fundo El Mango, Distrito de Yonan			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
695		El Truzt		1154	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
696		Santa Victoria		1172	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
697		Pay Pay		605	2	1	1	0	0	\N	Tembladera Capital del Distrito de Yonán, Contumazá			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
698		Yatahual		605	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
699		Salitre		1172	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
700		Pueblo Nuevo		1172	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
701		Miradorcito		1172	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
702	\N	Las Paltas	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
703		Villa los Mártires		1172	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
704		El Sapo		604	3	1	1	0	0	\N	Caserío El Sapo, Distrito Tantaricam, Contumaza			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
705		Pampa Larga		605	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1365		N.V LORETO		1712	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
709		Llallán		605	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
710		Tahuantinsuyo		1172	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
711		Cerro Colorado		1154	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1343		SANTA ROSA		479	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
713		San José de Moro		1172	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
715		El Prado		600	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1264		Chilete		599	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
719		Campo Nuevo	Guadalupito - Virú	1210	2	1	1	0	0	\N	C.P. Campo Nuevo			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
721		San Luis		231	2	1	9	2	2		Mz: H, Lote: 6, AA. HH. San Luis, Santa			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1108		Hualalay		199	0	0	0	0	0	\N	Caserío Hualalay, 	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
724		Chao		1209	2	1	1	0	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1275		Llapa		656	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1291		ROCA FUERTE		1715	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1277		Rodeopampa Alta		656	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
729		Moro		228	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
732		Santa Rosa		231	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
734		Chimbote		224	1	2	9	5	1	135.40	Jr. Libertad 625, Mz: K, Lote: 36,  AA. HH. Pueblo Libre	35,000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1273		Cortadera		623	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1274		La Calzada		656	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
743		Sihuas		233	1	1	4	5	1	830	Distrito de Sihuas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
744		Manta	Distrito de Sihuas	233	1	1	2	2	1	2,073.75	Caserío de Manta		ESTÁ PENDIENTE UNA TRANSFERENCIA DE LA FAMILIA ALEJOS A LA ASOCIACION. SE SACÓ EL CERTIFICADO DE POSESION EN COORDINACION CON EL HNO. TEOFILO ALEJOS. SE HIZO INSCRIPCION DE PREDIOS Y LUEGO INAFECTACIÓN DE IMPUESTO PREDIAL	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1325		SANTA CATALINA		1709	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
747		Satipo		1092	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
748		Shanki		1092	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
947		Villa Rica		1529	0	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1166		Cutervillo		579	0	0	0	0	0	\N	Cutervillo	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
751		Puente Paucartambo		1051	1	0	5	1	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
752		Rio Perla		1049	2	0	2	1	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
753		Muruhuay		1101	2	0	9	1	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
754		Colcamar		46	1	1	1	2	1	112	COLCAMAR			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1070		La Flor		79	0	1	1	2	1	224	La Flor	150		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1319		SAN LORENZO (peaje)		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
758		Limbani   		1688	2	2	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
759		Chicchuy		886	1	1	8	3	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
760	\N	Aislados	\N	\N	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
761		Rio de Oro		934	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
762		Pacota		1776	2	2	2	2	3					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
763		Julio C.Tello		931	2	3	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
764		Cashapampa		924	1	1	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
765		La Primavera		932	2	3	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
766	\N	Nuevo Chirimoto	\N	\N	4	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
767	\N	Itamarati	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
768		Churuyacu		624	2	1	1	0	0	\N				0	\N	\N	\N	\N	\N	\N	\N	\N	\N
1269		Tangay		224	0	1	9	1	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1078		Catillambi		552	0	0	0	0	0	\N	Caserío Catillambi, Dist. Asunción, Prov y Dep. Cajamarca	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
776		Piobamba		574	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
777		Tallambo		561	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
778		San Ignacio		636	2	1	1	0	0	\N	SAN IGNACIO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
779		Guadalupito		1210	2	1	1	0	0	\N	Guadalupito			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
780		Higuerón Pampa		1555	2	1	5	2	1		HIGUERONPAMPA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
781		Nuevo Paraiso		632	2	0	8	3	0		NUEVO PARAISO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
782		Buenos Aires		22	3	1	1	0	0	\N				0	\N	\N	\N	\N	\N	\N	\N	\N	\N
784		Choco Morropon		1561	2	0	8	3	0		chocos morropon			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
786		Pashul		632	2	0	8	3	0		PASHUL			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
787		Mazín		632	2	0	8	3	0		MAZIN			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
788		Tupac Amaru		632	2	1	3	2	3	300	TUPAC AMARU	150.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1167		La Arada Alta		1530	0	0	0	0	0	\N	La Arada Alta	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
792	\N	Querocoto	\N	\N	2	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
793		Challoaracra		587	2	1	7	2	1	128	Chalyoaracra			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
795		Cusilguan 		587	2	1	7	2	1	512	Cusilguan 	5000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
797	\N	San Pedro	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
798		Loma Larga		637	2	1	1	0	0	\N	LOMA LARGA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
799		Las Pirias		629	2	1	1	0	0	\N	LAS PIRIAS			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
800	\N	Virgen del Carmen	\N	\N	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
801		San Francisco		637	3	1	1	0	0	\N	San Francisco			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
802	\N	Las Palmas	\N	\N	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
803	\N	Santa Rosa	\N	\N	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1077		VON HUMBOL		1444	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
806		Coipin Alto		1188	2	1	1	0	0	\N	Caserío Coipín			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
807		Lomas de Wichanzao	ex Paradero de Ramiro Prialé x iglesias.iglesia Israelita	1132	2	1	9	1	3		AA. HH. Lomas de Wichanzo - Sector II, Mz: 3, Lote: 38		FALTA SUB - DIVISIÓN	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
808		Santa Rosa		1548	2	0	8	3	0		santa rosa			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1183		LA ESPERANZA TANTAMAYO		908	0	0	0	0	0	\N	LA ESPERANZA	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
810		El Parco		25	3	1	1	2	1	90	El Parco	90.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
812		Huambocancha		551	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1250		Ciudad de Dios		1171	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
821		Paracoto		552	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1416		Amparani		1595	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1186		VISTA ALEGRE		905	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1066		Nuevo Progreso		54	0	0	0	0	0	\N	Nuevo Progreso	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
825		Fundo Familia Paredes		1172	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1267		Nuevo Horizonte (Buenos Aires)		1155	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1266		Santa Clemencia		224	0	0	0	0	0	\N	AA. HH. Santa Clemencia Jr. Túpac Yupanqui Mz: Ñ, Lote: 2. c/esquina Psje. Pachacútec	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
830		Marcabal Grande Parte Alta		1192	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
831		Calquiche	Dist. Patáz - Prov. Patáz	1183	4	1	1	0	0	\N	Caserío Calquiche			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
832		Santa Ana - Dos de Mayo		574	2	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
833		Las Malvinas-Sto. Domingo		1198	2	1	5	0	0	\N	Las Malvinas			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
835	\N	Monterrey	\N	\N	2	1	1	0	0	\N	Monterey			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
838		AA.HH. Sr. de Los Milagros		982	2	1	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
839		Santa Ana -  Laran		977	2	2	4	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
840		La Tinguiña - ICA		963	2	2	4	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
841		Pomabamba		311	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
842		El Taro		977	3	0	5	2	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1156		CUTIMARCA		904	0	0	0	0	0	\N	TOMAY KICHWA	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1198		LA HUACA		1140	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1195		Esechope		602	0	0	0	0	0	\N	Entre Yetón y Choloque	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
849		Santa Lucia		1779	1	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
850		TOCACHE		1775	1	0	2	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
851		Bambamarca		1775	1	2	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1253		San Pedro de Lloc		1170	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
853		San Miguel de Tulumayo		933	1	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
854		Pucallpa	parque los rojos	1820	1	2	2	5	1		jr. padre amich 190 			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
855		Nolberth		1821	1	3	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
856		Contamana		1459	1	3	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
857		Guineal		1824	1	3	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
858		Neshuya o Monte Alegre		1821	1	0	2	1	3					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
859		Barrio Unido Aguaytia		1826	1	2	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
860		Campo Verde		1821	1	0	2	1	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
861		LEON DE JUDA		1820	1	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
862		Flor del Valle		1820	1	1	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
863		Santa Catalina		1824	1	3	2	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
864		Monte Sinaí		1825	1	3	8	3	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
865		Jericó		1824	1	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
866		luz divina		1826	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
867		Yuyapichis		1825	1	0	8	3	0					0	\N	\N	\N	\N	\N	\N	\N	\N	\N
960		CHULQUI		886	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
869		Cumbre Alegre		1826	1	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
870		Santa Rosa / Misquipata	Refer: Hno. Marcos Camayo.	1125	1	0	2	1	0	112	Carretera a Santa Rosa s/n.			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
871		Liguasnillo		1541	2	0	8	3	0		Liguancillo			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
872		Chupaca	Ref: Cancha Sintética “El Golazo”.	1119	1	0	2	1	0	97	Jr. Antonio Raimondi 205 casi Av. Eternidad.			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
874		1ro de Diciembre		1267	1	3	2	1	3		mz H lt. 5, AA.HH. 1° DE DICIEMBRE			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1254		Limoncarro		1171	0	1	9	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1155		LAS PALMAS		1092	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1404		Tumbaden		666	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
880		Cercado - Succhapampa		658	2	0	8	3	0		Cercado - Succhapampa			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
881	\N	Sotopampa	\N	\N	2	0	8	3	0		Sotopampa			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
882		San Martín de Pangoa		1097	1	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
884	7934408	Costa Azul	Paradero 8  Sector Angamos	683	1	0	9	1	3		Av. La Peruanidad  Mz. P  Lt. 11			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
887		Chontali		626	2	1	8	0	0	\N	Chontali			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
888	\N	Hualatan	\N	\N	2	1	8	0	0	\N	Hualatan			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
889		Agua Azul		626	4	1	1	0	0	\N	AGUA AZUL			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
890		Colasay		627	3	0	8	0	0	\N	Colasay			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
892		Sallique		632	3	0	8	3	0		Sallique			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
891		EMINEL CHANCAY	ENTRANDO POR LECHON DORADO - AL COSTADO DE CLINICA	1329	1	2	9	5	1	45 000	MOLINO HOSPITAL LT. 19 	$75 000		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
894		Silacot	A treinta minutos de Contumazá	598	2	1	1	0	0	\N	Caserío Silacot			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1205		Chachapoyas		224	0	1	9	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
897		Cristal Grande		603	3	1	5	0	0	\N	Cerca del Caserío: \\"La Succha\\"			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1204		Cambio Puente		224	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
899		Calate		598	3	1	5	0	0	\N	Calate - yendo a Chilete			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1226		Las Huertas		554	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
901		Progreso (Tiopampa)		1192	2	1	1	0	0	\N	TIOPAMPA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
902		Los Arenales de la Pradera		1222	2	1	1	2	1	90	Mz. I Lt. 1 - LOS ARENALES DE LA PRADERA	5000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1223		Tablacucho	San Felipe	1204	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
903		Agua Blanca	Dist. Huamachuco	1188	3	1	5	0	0	\N	Caserío Agua Blanca			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
904		Cruz Blanca		1188	3	1	5	0	0	\N	Barrio Cruz Blanca			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
905		Habana		1705	1	2	5	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
906		Jericó		1707	2	3	3	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1411		ZAPOTAL		1153	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
912		Soritor 		1707	1	2	9	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
913	\N	Espinar	\N	\N	3	1	5	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
914	\N	URUBAMBA	\N	\N	3	1	5	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
916		La Totora		643	2	1	5	0	0	\N	LA TOTORA			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
917		Clementina Peralta		1132	2	3	7	1	3		AA. HH. Clementina Peralta			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1062		Remigio Silva		1211	0	0	0	3	0		La Paz  N° 396			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1177		Motupe		1243	0	0	0	0	0	\N	Motupe	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1064		El Porvenir		54	0	0	0	0	0	\N	El Porvenir	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
925		Ampliación Ciudad de Dios-El Porvenir	por Paradero Final de Micros Cortijo: C1, C2, C3	1129	0	1	5	1	3	280.00	AA. HH. Ampliación Ciudad de Dios-Alto Trujillo B° 10 (Ex AA. HH. Túpac Amaru)			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1342		Chala		360	0	0	0	0	0	\N	AAHH Progreso MZ 8 Lt 35	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1168		Santa Elena-Nueva Esperanza		1530	0	0	0	0	0	\N	entre santa elena y nueva esperanza-Partidor	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
929		Calderon		1549	0	1	5	2	1		Calderon			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
930		corire		360	0	0	0	0	0	\N	pedregal aplau 	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
931		Pedrgal Mages	Fundo Huacan  el Bosque	360	0	2	6	1	3	300	Mz. 05 Lte. 16	6000.00		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
932		Chuquibamba	el vallesito	360	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
933		Chala		360	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1187		San Miguel de queroz		905	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1399		Nuevo Jaén		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1054		El Salvador		1153	0	0	0	0	0	\N	Dist. Chepén	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1330		PUEBLO LIBRE		1748	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1326		EL LIMON		1709	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
934		El Porvenir	Colegio San Mateo	1129	0	2	9	2	1	1650.29	Francisco de Zela N° 1551	709,588.52		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1403		Muy Finca PntoCuatro	Entrada punto cuatro	1241	0	0	0	0	0	\N	Marginal	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
935		Victor Raúl del Porvenir		1129	0	2	2	2	2	155.19	Mz: 14, Lote: 9, Etapa II - El Porvenir			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
936		Gran Chimú	cerca a la Plaza de Armas del lugar	1129	0	2	9	2	1	177.73	Independencia N° 1912 - El Porvenir	61,619.55		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1335		KM 45 Valle del Pavo		1750	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1413		San Alejandro		1832	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1333		BARRANCA		1749	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1188		Pachas		908	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1117		China Alta		624	0	0	0	0	0	\N	China Alta	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1159		Balsas		3	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
941		RIMAC	Altura     Cuadra 2 de Tarapacá	1276	0	2	9	5	1		Calle Andres Corzo N° 644 Villacmpa - Rimac - Lima			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
942		Catán		604	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1374		MUÑAPUCRO		260	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1377		San Jose de Quero	Refer: Restaurante \\"El Timoncito\\"	1046	0	0	0	0	0	\N	San Jose de Quero	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1378		Penal de Huamancaca	Av. 28 de Julio s/n.	1123	0	0	0	0	0	\N	Penal de Huamancaca.	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1379		ZUNGARO		1831	0	0	0	0	0	\N	ZUNGARO	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1217		Alto Trujillo (Barrio 1-A)		1129	0	2	9	2	3		MZ. R Lt. 25 Alto Trujillo			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1246		José Sabogal 		649	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1176		Mochumí		1241	0	0	0	0	0	\N	Mochumí	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1172		Batan Grande		1235	0	0	0	0	0	\N	Batan Grande	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1173		Illimo		1239	0	0	0	0	0	\N	Illimo	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1182		Pueblo Nuevo		1814	0	0	0	0	0	\N	pueblo nuevo	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1190		LEGLISH		905	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1407		Jauja		1054	0	0	5	1	0	210				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1371		Nuevo Huaycho 		1192	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
977		El Sienque		603	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
976		Napaty		1092	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
979		Vision El Río		604	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
959		MACARCANCHA		1507	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1199		Querripe		1168	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1203		LA HACIENDA		1258	0	0	0	0	0	\N	PARQUE LA HACIENDA	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
981		El Marín		601	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1035		CHIRIACO		26	0	0	0	4	0		CHIRIACO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
953		MISION	FALTAN   TRASLADAR	1249	0	0	0	0	0	\N	MISIÓN CENTRAL	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
954		TRES  REGIONES		1273	0	2	8	3	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1302		ALIANZA		1433	0	0	0	0	0				ya no existe a sido invadido y por falta de documentos no se a puede recuperar	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
971		Nuevo Nazareth		1779	0	3	2	1	3					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
972		3 de mayo		1779	0	0	8	3	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
973		puente santa rosa		1775	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
974		Chillia	Dist. Chillia - Prov. Patáz	1177	0	0	0	0	0	\N	Distrito de Chillia	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
975		Tayabamba	Dist. Tayabamba - Prov. Patáz	1175	0	0	0	0	0	\N	Distrito de Tayabamba	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1383		QUIVINCHAN		562	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1362		SHEPTE		1739	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1361		SAPOSOA		1720	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
982		Totorillas		601	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
983		Casmán		604	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
984		Chuquimango		604	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
985		Altamisas		604	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
986		Las Rosas		601	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
987		Cholol Alto		604	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
988		Cholol Bajo		604	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
989		La Queserilla		601	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
991		San Isidro		601	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
992		Tupoñe		604	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
994		Lirio Nuevo		603	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1222		Quesera		600	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1005		Santa de Cospán		554	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1006		Santo Domingo		554	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1007		Siracat		554	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1008		Sunchubamba		554	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1009		Pampas de San Isidro		1204	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1354		JUANJUI	ESQUINA COLEGIO HEROES DEL CENEPA	1737	0	0	0	0	0	\N	PROLONGACION LA MERCED CDRA 3	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1353		HUICUNGO		1739	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1351		CUÑUMBUZA		1738	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1350		CRUCE PRADA		1737	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1349		CENTRO AMERICA		1710	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1245		La Quinua		574	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1164		Santo Tomas		1420	0	0	1	1	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1370		Huaycho Viejo		1189	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1247		Colpilla		574	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1243		Chuquibamba		564	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1251		Pacasmayo Centro		1173	0	0	9	2	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1316		MARONA		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1410		Tamburco		259	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1393		Julcan		1156	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1394		Pedregal		1137	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1390		Otuzco		1160	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1408		Santa Rosa		1224	0	0	0	0	0	\N	Carretera central	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1016		La Florida		1755	0	0	5	2	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1279		Yerba Buena		621	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1373	042523529	IGLESIA DE LA ASOCIACION	COLEGIO SAN MATEO	1761	0	0	0	0	0	\N	RICARDO PALMA 1076 EL HUYCO	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1363		SHITARI		1710	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1165		Fila Alta		624	0	0	0	0	0	\N	Fila Alta	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1386		Chochoconda		1188	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1282		El Mote		598	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1130		AÑO NUEVO	PARADERO PARQUE	1258	0	0	0	0	0	\N	JR. JORGE IGNACIO N° 310	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1180		Sandial		1235	0	0	0	0	0	\N	Sandial	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1179		Pomalca		1228	0	0	0	0	0	\N	C.P. La Unión	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1175		Lambayeque		1237	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1171		San Mateo		1139	0	0	0	0	0	\N	Chocope	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1201		ENAVE		1147	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1409		C.P Jelic		643	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1375		IGLESIA DE MISIÓN		1128	0	2	6	6	1		SABOGAL 454			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1026		NV. ESPERANZA (Ponazapa)		1735	0	1	4	2	3		Caserío Ponazapa			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1418		Pampayanamayo		1694	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1158		Tres de Mayo		570	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1423		Chejani		1690	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1420		Ilave		1641	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1169		Callayuc		607	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1068		El Balcon		79	0	1	0	2	1		El Balcon			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1069		Diamante Alto		79	0	2	1	2	1	300	Diamante Alto	800		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1067		Bagua Grande		78	0	1	6	2	1	300	las delicias N° 495	7200		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1028		Cruz del Norte San Benito 		1254	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1406		Rodeopampa Baja		656	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1385		Catudén		598	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1389		Canibamba		1169	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1047		Salinar B	Cruce Membrillar	1140	0	0	0	0	0	\N	Pampa Hermosa-Salinar Bajo	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1346		AUCARARCA		1712	0	0	0	0	0	\N	CARRETERA MARGINAL	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1364		SHAMBUYACO		1749	0	3	1	0	1	200				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1309		ALTO GERILLO		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1412		Buenos Aires / Chupaca		1119	0	0	0	0	0	\N	Cruce de Huachac	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1366		ALFONZO UGARTE		1742	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1034		Nuevo Huancabamba		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1065		Selchocuzco		54	0	0	0	0	0	\N	Selchocuzco	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1303		MIGUEL GRAU KM.40		1433	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1038		San Carlos		1	0	0	0	4	0		San Carglos			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1039		Shipata		46	0	2	5	2	3		Shipata			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1040		NUEVO PROGRESO / MATAPALO		1818	0	3	5	2	1		NUEVO PROGRESO			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1415		Pueblo Libre		1755	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1221		Santiago de Chuco		1196	0	0	0	0	0	\N	Calle Luis de la Puente Uceda 1801 c/esq. Tungsteno	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1115		Udima		655	0	0	0	0	0	\N	Udima	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1116		Monte Cruz		1217	0	0	0	3	0		MONTE CRUZ			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1055		Penal El Milagro		1132	0	0	0	0	0	\N	Dist. La Esperanza	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1096		Los Conquistadores		232	0	0	0	0	0	\N	AA. HH. Los Conquistadores - Nuevo Chimbote	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1095		AISLADOS		1092	0	0	0	0	0	\N	VILLA SOL	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1318		RAMIREZ		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1071		La Florida		78	0	0	0	3	0		La Florida			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1072		La Unión		79	0	0	0	0	0	\N	La Unión	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1073		Quebrada Seca		78	0	1	0	2	1		Quebrada Seca			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1074		El Salao		82	0	2	0	2	3		El Salao			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1075		San Isidro		47	0	1	0	2	1		San isidro			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1076		Tambolic		82	0	1	1	2	1	493	Tambolic	5000		1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1299		ALTO PERU		1715	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1080		San Jorge		551	0	0	0	0	0	\N	C.P. San Jorge, Dist. Cajamarca	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1422	957459877	Desaguadero		1	1	0	0	0	0	44	Jr. Ricardo Palma 509	44	NINGUNA	1	1	1	ESTRUCTURA FUERTE	4444	1	6	6	8	9
1298		ZANANGO		1715	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1297		ZAPATERO		1715	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1296		NV. JAEN		1715	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1286		AYACUCHO		440	0	0	0	0	0	\N	AA.HH. COMPLEJO ARTESANAL MZ. E LT. 3	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1287		Alto Trujillo Barrio 7C		1129	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1086		Lechén		598	0	0	0	0	0	\N	Caserío Lechén, Dist. y Prov. Contumazá	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1087		Lorito Huaz		551	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1088		Esterillas		598	0	0	0	0	0	\N	Caserío Esterillas, Contumazá	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1265		Monte Alegre		650	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1090		Calani		562	0	0	0	0	0	\N	Caserio Calani, Dist. San Juan, Prov, Cajamarca	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1091		La Lucma		615	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1092		El Guayo		598	0	0	0	0	0	\N	C. P. El Guayo, Dist. y Prov. Contumazá	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1293		ALTO ROQUE		1715	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1094		Aranmarca		562	0	0	0	0	0	\N	C.P. Aranmarca, Dist. San Juan, Prov. Cajamarca	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1369		PICOTA		1742	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1268		Pampa Dura		224	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1103		Ahijadero		601	0	0	0	0	0	\N	Pueblo de Ahijadero-Contumazá	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1104		Cascabamba \\"B\\"		598	0	0	0	0	0	\N	Cascabamba, Contumazá	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1227		San Antonio		1139	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1231		Shalar		1189	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1232		Cochabamba		1189	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1306		BARRANQUITA		1433	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1396		Alamo		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1109		Víctor Raúl de Virú	preguntar en Nvo Víctor R.de Virú Mz: J, Lote: 14	1208	0	2	5	4	3		MZ: 4, LOTE: 2, LOS PINOS - PARTE ALTA		PRESTADO POR LA FAMILIA INFANTES-SANDOVAL	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1111		Colpa-Lluychush	después de Lluychush	109	0	0	3	1	0	180.00	Caserío Colpa	200.00	se recibió como donación un lote y una parte comprado por 200.00 nuevos soles al donante: Hn. Federico Portella	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1112		Huaraz		85	0	0	6	1	3				PENDIENTE: INSCRIPCION DE PREDIO EN MUNICIPALIDAD, EXONERAR E INAFECTAR DE IMPUESTOS PREVIO PAGOS RESPECTIVOS.	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1381		Miravalle		656	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1347		BAGAZAN		1740	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1118		Santa Elena		624	0	0	0	0	0	\N	Santa Elena	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1119		Chirinos Cordillera		637	0	0	0	0	0	\N	Chirinos Cordillera	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1120		ajosmayo		655	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1121		Los Olivos		1194	0	0	0	0	0	\N	Caserío Nueva Esperanza	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1301		YURIMAGUAS		1433	0	3	9	2	1					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1206		Florencia de Mora (Baja)	Atrás del colegio municipal	1130	0	2	9	2	3		Calle: 8 de Septiembre Nº 762			1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1276		Pabellón Chico		656	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1272		Alto Perú		666	0	0	0	0	0	\N	Caserío Alto Perú	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1270		Casma		139	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1345		ATAHUALPA		1740	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1300		NV ESPERANZA		1715	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1278		San Pablo		663	0	0	6	1	0					1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1233		Chir Chir		1194	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1122		Huabal		1171	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1123		Nueva Unión		74	0	0	0	0	0	\N	Caserío Nueva Unión	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1124		Huaguil	Dist. Chugay, Prov. Sánchez Carrión	1189	0	0	0	0	0	\N	Caserio Huaguil	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1125		Tiraca		1689	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1126		San Miguel de Phara		1690	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1127		Cocos Lanza	Pais Bolivia	1695	0	0	0	0	0	\N	Cocos Lanza - Bolivia	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1129		Progreso	MERCADO LA CUMBRE	1254	0	0	0	0	0	\N	jr. 3 de octubre N° 323	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1131		COMAS	ESQUINA CON IGNACIO PRADO	1258	0	0	0	0	0	\N	jr. 28 de julio n° 907	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1132	952646985	Parral 	INGRESO POR AV. TUPAC AMARU Y MÉXICO	1258	0	0	0	0	0	\N	av. carabayllo 975  urb. el parral	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1133		ESMIRNA	MANCO INCA,  ALT. HOSPITAL LA SOLIDARIDAD - COMAS	1258	0	0	0	0	0	\N	C. 17 N° 395 URB. CARABAILLO	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1134		ENRIQUE MILLA	COLEGIO ENRIQUE MILLA	1265	0	0	0	0	0	\N	MZ. 114 LT. 31 COMITÉ 6 - LOS OLIVOS	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1135		PRIMERA DE PRO	A 3 CUADRAS DEL PARADERO PRIMERA DE PRO PANAMERICA	1265	0	0	0	0	0	\N	JR. HONESTIDAD # 7951 PRO	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1136	5328063	LOS OLIVOS	CENTRO DE SALUD PRIMAVERA	1265	0	0	0	0	0	\N	C. LOS GUINDONES MZ. A  LT. 5  URB. VIRGEN DE LA PUERTA	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1137	6397430	NARANJAL	AV, MARAÑON  Y AV. UNIVERSITARIA	1265	0	0	0	0	0	\N	MZ. G LT. 26 ASOC. LOS PORTALES DEL NORTE	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1138	4209540	BELLAVISTA CALLAO		679	0	0	0	0	0	\N	mZ. E LT. 33 URB . CONFECCIONES MILITARES	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1140		DOMINICOS		1283	0	0	0	0	0	\N	mz. F LT. 7 LOS DOMINICOS SANTA ROSA	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1141		Huachis-Huari		156	0	0	0	0	0	\N	Distrito de Huachis - Huari	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1321		VALLE HERMOZO		1706	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1322		CALZADA		1704	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1323		JAZMINES		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1324		BELLAVISTA		1709	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1401		Sullaquiro		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1240		Cashapampa		551	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1313		EL SINAI		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1314		NV. SALINAS		1703	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1315		JEPELACIO		1706	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1259		Puente Olivares		1174	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1260		Alto Tamarindo		1171	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1261		Jagüey		1174	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1262		Martha Chávez		1171	0	2	9	1	1				TERRENO DE UNA HECTÁREA Y DEDIA APROX.	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1263		Huáscar		1172	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1224		Lanche / San Felipe	San Felipe	1204	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1258		Verdún		1174	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1327		LA LIBERTAD		1709	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1328		SAN JUAN se san hilarion		1709	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1142		Changomarca		606	0	0	0	0	0	\N	Changomarca	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1143		Chugur		606	0	0	0	0	0	\N	Chugur	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1144		Cochabamba		585	0	0	0	0	0	\N	Cochabamba	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1145		Cutervo		606	0	0	0	0	0	\N	Cutervo	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1146		La Merendana		606	0	0	0	0	0	\N	la merendana	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1147		La succha		606	0	0	0	0	0	\N	La Succha	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1148		Lanche		606	0	0	0	0	0	\N	Lanche	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1149		Llacancate		606	0	0	0	0	0	\N	Llacancate	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1150		Mamabamba		606	0	0	0	0	0	\N	Mamabamba	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1151		Payac		606	0	0	0	0	0	\N	Payac	\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1414		San Juan de Potreros		1707	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
1421		Chijuyo Copapujo		1641	0	0	0	0	0	\N		\N	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
2		Puente Piedra	Grifo Norteño - PANAMERICANA NORTE	1273	1	2	4	5	1		Psje. San Miguel  Cdra. 1,  Mz. A , Lt. 2 			1	\N	\N	\N	\N	1	1	1	1	1
1426		San Pedro de Putina Punco		1	1	0	0	0	0	\N		\N	\N	1	1	1	\N	\N	1	1	1	3	5
1427	957459877	Cabanillas		1	1	1	1	1	1	500	Jr. Ricardo Palma 509	\N	NINGUNA	1	1	1	ESTRUCTURA FUERTE	NRO	1	1	1	1	1
1425	957459877	Puno		1594	1	0	0	0	0	44	Jr. Ricardo Palma 509	44	DD	1	1	1	ESTRUCTURA FUERTE	4444	1	13	5	7	8
1424	957459877	Camarón		1694	1	0	0	0	0	44	Jr. Ricardo Palma 509	\N	F	1	31	202	ESTRUCTURA FUERTE	4444	1	9	3	6	7
\.


--
-- TOC entry 2570 (class 0 OID 24987)
-- Dependencies: 250
-- Data for Name: institucion; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.institucion (idinstitucion, descripcion, sede, "dirección", telefono, email) FROM stdin;
1	Unión	\N	\N	\N	\N
2	Misión Central	\N	\N	\N	\N
3	Misión Normedio	\N	\N	\N	\N
4	Misión Norte	\N	\N	\N	\N
5	Misión Oriente	\N	\N	\N	\N
6	Misión Sur	\N	\N	\N	\N
7	Publicaciones Asdimor	\N	\N	\N	\N
8	Colegio San Mateo	\N	\N	\N	\N
9	Asdimor Perú	\N	\N	\N	\N
10	EMINEL	\N	\N	\N	\N
\.


--
-- TOC entry 2503 (class 0 OID 16469)
-- Dependencies: 183
-- Data for Name: miembro; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.miembro (idmiembro, pais_id_nacionalidad, iddistritonacimiento, iddistritodomicilio, idtipodoc, idestadocivil, idocupacion, idgradoinstruccion, paterno, materno, nombres, foto, fechanacimiento, lugarnacimiento, sexo, nrodoc, direccion, referenciadireccion, telefono, celular, email, emailalternativo, idreligion, fechabautizo, idcondicioneclesiastica, encargado_recibimiento, observaciones, estado, estadoeliminado, idiglesia, fechaingresoiglesia, usuario, fecharegistro, tipolugarnac, ciudadnacextranjero, apellidos, iddepartamentodomicilio, idprovinciadomicilio, iddepartamentonacimiento, idprovincianacimiento, apellido_soltera, pais_id_nacimiento, iddivision, pais_id, idunion, idmision, iddistritomisionero, tabla_encargado_bautizo, encargado_bautizo) FROM stdin;
14	0	0	105	1	1	1	1		\N	DICK	miembro_14.jpg	2021-07-01		M	76621455	jr. ricardo palma 507	\N	33333	33333	jm.zs@hotmail.com	\N	1	2021-07-01	\N	\N	NADA	1	0	2	\N	1	2021-07-03 00:00:00	\N	MORALES	GRANDEZ DIAS	2	10	\N	\N	\N	32	1	1	1	1	1	undefined	7
5	3	2	1	1	1	1	1		\N	ROMINA	miembro_5.png	2021-06-21		F	67894444	Jr. Ricardo Palma 509	JR. RICARDO PALMA 509	957459877	959543793	JMANUEL.ZSINARAHUA@GMAIL.COM	JMANUEL.ZSINARAHUA@GMAIL.COM	0	\N	\N	\N	RRR	1	0	2	\N	1	2022-10-20 00:00:00	nacional	TARAPOTO	GATICA LARA	1	1	2	2	\N	32	1	1	1	1	1	\N	\N
6	6	0	1761	1	2	1	1		\N	JUAN CARLOS	miembro_6.png	2021-06-01		M	76621421	JR. RICARDO PALMA 509	JR. RICARDO PALMA 509	957459877	959543799	jm.zs@hotmail.com	\N	0	\N	1	\N	D	0	0	3	\N	admin	2022-10-20 00:00:00	extranjero	\N	RODRIGUES FLORES	22	183	\N	\N	\N	7	1	1	1	1	1	\N	\N
16	0	0	252	1	1	1	1		\N	TONY MARTIN	miembro_16.png	2021-07-06		M	14567888	Jr. Ricardo Palma 509	JR. RICARDO PALMA 509	957459877	959543793	jmanuel.zsinarahua@gmail.com	\N	0	\N	\N	\N	\N	1	0	1427	\N	1	2021-07-08 00:00:00	\N	TARAPOTO	HUANSI SINARAHUA	3	28	\N	\N	\N	32	1	1	1	1	1	\N	\N
3	3	2	1761	1	2	1	1		\N	DAVID ALBERTO	miembro_3.png	2021-06-21		M	78965412	JR. RICARDO PALMA 509	JR. RICARDO PALMA 509	957459877	959543793	JMANUEL.ZSINARAHUA@GMAIL.COM	JMANUEL.ZSINARAHUA@GMAIL.COM	0	\N	1	\N	FF	0	0	1421	\N	admin	2022-10-20 00:00:00	nacional	\N	DURAND FLORES	22	183	2	5	\N	\N	1	9	3	6	7	\N	\N
7	0	0	1249	1	1	1	1		\N	JULISSA	miembro_7.png	2021-06-24		F	01065945	Jr. Ricardo Palma 509	JR. RICARDO PALMA 509	957459877	959543793	jm.zs@hotmail.com	\N	1	2021-06-27	0	\N	DDD	0	0	1427	\N	admin	2021-06-24 00:00:00	\N	TARAPOTO	GRANDEZ DIAZ	31	202	\N	\N	\N	32	1	1	1	1	1	iglesias.miembro	14
\.


--
-- TOC entry 2525 (class 0 OID 16680)
-- Dependencies: 205
-- Data for Name: mision; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.mision (idmision, idunion, descripcion, direccion, estado, telefono, email) FROM stdin;
1	1	Misión Oriente	JR. RICARDO PALMA 509	1	957459877	jmanuel.zsinarahua@gmail.com
5	2	Asociación Este	JR. RICARDO PALMA 509	1	998038402	jm.zs@hotmail.com
3	1	Misión Central	JR. RICARDO PALMA 509	1	957459877	bleonardo.gsinarahua@gmail.com
4	1	Misión Sur	JR. RICARDO PALMA 509	1	936 676 722 - 041750004	soportedetallesperuserver@gmail.com
6	3	Asociación Paraguay	JR. RICARDO PALMA 509	1	957459877	jm.zs@hotmail.com
7	5	Caribeña	JR. RICARDO PALMA 509	1	957459877	jmanuel.zsinarahua@gmail.com
8	6	Llanos-Andes	JR. RICARDO PALMA 509	1	957459877	jmanuel.zsinarahua@gmail.com
\.


--
-- TOC entry 2560 (class 0 OID 16873)
-- Dependencies: 240
-- Data for Name: motivobaja; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.motivobaja (idmotivobaja, descripcion) FROM stdin;
1	Dimisión
2	Disciplina
3	Exclusión
4	Muerte
5	Otros Motivos
\.


--
-- TOC entry 2562 (class 0 OID 16883)
-- Dependencies: 242
-- Data for Name: otrospastores; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.otrospastores (idotrospastores, idcargo, nombrecompleto, observaciones, periodo, vigente, estado, idtipodoc, nrodoc) FROM stdin;
1	1	NUEVO ANCIANO	NADA	\N	1	1	1	123654799
\.


--
-- TOC entry 2568 (class 0 OID 24972)
-- Dependencies: 248
-- Data for Name: paises; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.paises (pais_id, pais_descripcion, estado, idioma_id, iddivision, direccion, telefono, posee_union) FROM stdin;
10	Francia	A	10	2	Jr. Ricardo Palma 509	988 617 534	S
3	Ecuador	A	1	1	JR. RICARDO PALMA 509	936 676 722 - 041750004	S
8	Bolivia	A	1	1	Jr. Ricardo Palma 509	957459877	S
1	Perú	A	3	1	JR. RICARDO PALMA 509	957459877	S
7	Uruguay	A	1	1	Jr. Ricardo Palma 509	957459877	S
6	Venezuela	A	1	1	Jr. Ricardo Palma 509	957459877	S
13	México	A	1	1	Jr. Ricardo Palma 509	957459877	S
9	Paraguay	A	1	1	Jr. Ricardo Palma 509	998038402	N
\.


--
-- TOC entry 2554 (class 0 OID 16842)
-- Dependencies: 234
-- Data for Name: paises_idiomas; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.paises_idiomas (pais_id, idioma_id, pai_descripcion) FROM stdin;
\.


--
-- TOC entry 2576 (class 0 OID 25051)
-- Dependencies: 257
-- Data for Name: paises_jerarquia; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.paises_jerarquia (pj_id, pais_id, pj_descripcion, pj_item) FROM stdin;
1	1	departamento	1
2	1	provincia	2
3	1	distrito	3
6	6	estado	1
7	6	municipio	2
8	6	parroquias	3
9	13	estado	1
10	13	municipio	2
11	9	departamento	1
12	9	municipio	2
\.


--
-- TOC entry 2515 (class 0 OID 16553)
-- Dependencies: 195
-- Data for Name: religion; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.religion (idreligion, descripcion) FROM stdin;
1	Adventista
2	Aminiasdimor
3	Católico
4	Dominical
5	Isrraelita
6	Mormon
7	Otros
8	Reforma
9	Testigo de Jehová
\.


--
-- TOC entry 2574 (class 0 OID 25040)
-- Dependencies: 255
-- Data for Name: temp_traslados; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.temp_traslados (idtemptraslados, idmiembro, idtipodoc, iddivision, pais_id, idunion, idmision, iddistritomisionero, idiglesia, nrodoc, division, pais, "union", mision, distritomisionero, iglesia, tipo_documento, usuario_id, tipo_traslado, iddivisiondestino, pais_iddestino, iduniondestino, idmisiondestino, iddistritomisionerodestino, idiglesiadestino, asociado) FROM stdin;
\.


--
-- TOC entry 2529 (class 0 OID 16706)
-- Dependencies: 209
-- Data for Name: tipoconstruccion; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.tipoconstruccion (idtipoconstruccion, descripcion) FROM stdin;
1	Adobe
2	Ladrillos
3	Madera
\.


--
-- TOC entry 2531 (class 0 OID 16715)
-- Dependencies: 211
-- Data for Name: tipodocumentacion; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.tipodocumentacion (idtipodocumentacion, descripcion) FROM stdin;
1	Documento Privado
2	En Tramite
3	Juez
4	Minuta de Compra Venta
5	No Tiene
6	Notaria
7	Simple
8	Alquilado
9	SUNARP
\.


--
-- TOC entry 2533 (class 0 OID 16724)
-- Dependencies: 213
-- Data for Name: tipoinmueble; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.tipoinmueble (idtipoinmueble, descripcion) FROM stdin;
1	Terreno
2	Templo
3	Alquiler
4	En Uso
5	Templo y Casa Misión
6	Casa Misión
\.


--
-- TOC entry 2523 (class 0 OID 16673)
-- Dependencies: 203
-- Data for Name: union; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias."union" (idunion, descripcion, estado) FROM stdin;
1	Unión Peruana	1
3	Unión Temporal Paraguay	1
2	Unión Francesa	1
5	Unión Mexicana	1
6	Unión Venezolana	1
\.


--
-- TOC entry 2542 (class 0 OID 16769)
-- Dependencies: 222
-- Data for Name: union_paises; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.union_paises (idunion, pais_id) FROM stdin;
1	1
3	9
2	10
4	6
5	13
6	6
\.


--
-- TOC entry 2564 (class 0 OID 16898)
-- Dependencies: 244
-- Data for Name: cargo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cargo (idcargo, descripcion, idtipocargo, estado, idnivel) FROM stdin;
1	Pastor	1	1	\N
2	Obrero	1	1	\N
3	Colportor Oficial	1	0	\N
4	Anciano de Iglesia	2	1	\N
5	Director de Iglesia	2	1	\N
6	Secretario de Iglesia	2	1	\N
7	Tesorero de Iglesia	2	1	\N
8	Director de Escuela Sabática	2	1	\N
9	Maestro de Lección	2	1	\N
10	Maestro de Niños	2	1	\N
11	Director Buen Samaritano	2	1	\N
12	Director de Música	2	1	\N
13	Director de Salud	2	1	\N
14	Director de Jovenes	2	1	\N
16	Vice Presidente	1	1	\N
17	Secretario	1	1	\N
18	Tesorero	1	1	\N
19	Director Colportaje	1	1	\N
20	Director de Obra Misionera	1	1	\N
21	Director de Salud	1	1	\N
22	Director de Familia	1	1	\N
23	Director de Publicaciones	1	1	\N
24	Director de Educación	1	1	\N
42	Colportor Laico	1	0	\N
15	PRESIDENTE	1	1	1
41	DIRECTOR EMINEL	1	1	12
46	MINISTERIAL	1	1	7
45	DIRECTOR BUENSAMARITANO	1	1	8
44	SECRETARIO EMINEL	1	1	9
43	MISIONERO LAICO	1	1	10
29	DELEGADO SUPLENTE	2	1	1
28	DELEGADO TITULAR	2	1	2
27	DIRECTOR DE SEMINARIO	2	1	3
26	DIRECTOR DE JÓVENES	2	1	4
25	DIRECTOR DE MÚSICA	2	1	6
\.


--
-- TOC entry 2553 (class 0 OID 16824)
-- Dependencies: 233
-- Data for Name: condicioninmueble; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.condicioninmueble (idcondicioninmueble, descripcion) FROM stdin;
1	Construido
2	Semiconstruido
3	En Construcción
4	En Litigio
\.


--
-- TOC entry 2539 (class 0 OID 16751)
-- Dependencies: 219
-- Data for Name: departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departamento (iddepartamento, descripcion, pais_id) FROM stdin;
1	AMAZONAS	1
2	ANCASH	1
3	APURIMAC	1
4	AREQUIPA	1
5	AYACUCHO	1
6	CAJAMARCA	1
7	CALLAO	1
8	CUSCO	1
9	HUANCAVELICA	1
10	HUANUCO	1
11	ICA	1
12	JUNIN	1
13	LA LIBERTAD	1
14	LAMBAYEQUE	1
15	LIMA	1
16	LORETO	1
17	MADRE DE DIOS	1
18	MOQUEGUA	1
19	PASCO	1
20	PIURA	1
21	PUNO	1
22	SAN MARTIN	1
23	TACNA	1
24	TUMBES	1
25	UCAYALI	1
29	CIUDAD DE MEXICO	13
30	ESTADO VENEZUELA	6
31	DEPA PARAGUAY	9
\.


--
-- TOC entry 2505 (class 0 OID 16506)
-- Dependencies: 185
-- Data for Name: distrito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.distrito (iddistrito, idprovincia, descripcion) FROM stdin;
1	1	CHACHAPOYAS
2	1	ASUNCION
3	1	BALSAS
4	1	CHETO
5	1	CHILIQUIN
6	1	CHUQUIBAMBA
7	1	GRANADA
8	1	HUANCAS
9	1	LA JALCA
10	1	LEIMEBAMBA
11	1	LEVANTO
12	1	MAGDALENA
13	1	MARISCAL CASTILLA
14	1	MOLINOPAMPA
15	1	MONTEVIDEO
16	1	OLLEROS
17	1	QUINJALCA
18	1	SAN FRANCISCO DE DAGUAS
19	1	SAN ISIDRO DE MAINO
20	1	SOLOCO
21	1	SONCHE
22	2	BAGUA
23	2	ARAMANGO
24	2	COPALLIN
25	2	EL PARCO
26	2	IMAZA
27	2	LA PECA
28	3	JUMBILLA
29	3	CHISQUILLA
30	3	CHURUJA
31	3	COROSHA
32	3	CUISPES
33	3	FLORIDA
34	3	JAZAN
35	3	RECTA
36	3	SAN CARLOS
37	3	SHIPASBAMBA
38	3	VALERA
39	3	YAMBRASBAMBA
40	4	NIEVA
41	4	EL CENEPA
42	4	RIO SANTIAGO
43	5	LAMUD
44	5	CAMPORREDONDO
45	5	COCABAMBA
46	5	COLCAMAR
47	5	CONILA
48	5	INGUILPATA
49	5	LONGUITA
50	5	LONYA CHICO
51	5	LUYA
52	5	LUYA VIEJO
53	5	MARIA
54	5	OCALLI
55	5	OCUMAL
56	5	PISUQUIA
57	5	PROVIDENCIA
58	5	SAN CRISTOBAL
59	5	SAN FRANCISCO DEL YESO
60	5	SAN JERONIMO
61	5	SAN JUAN DE LOPECANCHA
62	5	SANTA CATALINA
63	5	SANTO TOMAS
64	5	TINGO
65	5	TRITA
66	6	SAN NICOLAS
67	6	CHIRIMOTO
68	6	COCHAMAL
69	6	HUAMBO
70	6	LIMABAMBA
71	6	LONGAR
72	6	MARISCAL BENAVIDES
73	6	MILPUC
74	6	OMIA
75	6	SANTA ROSA
76	6	TOTORA
77	6	VISTA ALEGRE
78	7	BAGUA GRANDE
79	7	CAJARURO
80	7	CUMBA
81	7	EL MILAGRO
82	7	JAMALCA
83	7	LONYA GRANDE
84	7	YAMON
85	8	HUARAZ
86	8	COCHABAMBA
87	8	COLCABAMBA
88	8	HUANCHAY
89	8	INDEPENDENCIA
90	8	JANGAS
91	8	LA LIBERTAD
92	8	OLLEROS
93	8	PAMPAS
94	8	PARIACOTO
95	8	PIRA
96	8	TARICA
97	9	AIJA
98	9	CORIS
99	9	HUACLLAN
100	9	LA MERCED
101	9	SUCCHA
102	10	LLAMELLIN
103	10	ACZO
104	10	CHACCHO
105	10	CHINGAS
106	10	MIRGAS
107	10	SAN JUAN DE RONTOY
108	11	CHACAS
109	11	ACOCHACA
110	12	CHIQUIAN
111	12	ABELARDO PARDO LEZAMETA
112	12	ANTONIO RAYMONDI
113	12	AQUIA
114	12	CAJACAY
115	12	CANIS
116	12	COLQUIOC
117	12	HUALLANCA
118	12	HUASTA
119	12	HUAYLLACAYAN
120	12	LA PRIMAVERA
121	12	MANGAS
122	12	PACLLON
123	12	SAN MIGUEL DE CORPANQUI
124	12	TICLLOS
125	13	CARHUAZ
126	13	ACOPAMPA
127	13	AMASHCA
128	13	ANTA
129	13	ATAQUERO
130	13	MARCARA
131	13	PARIAHUANCA
132	13	SAN MIGUEL DE ACO
133	13	SHILLA
134	13	TINCO
135	13	YUNGAR
136	14	SAN LUIS
137	14	SAN NICOLAS
138	14	YAUYA
139	15	CASMA
140	15	BUENA VISTA ALTA
141	15	COMANDANTE NOEL
142	15	YAUTAN
143	16	CORONGO
144	16	ACO
145	16	BAMBAS
146	16	CUSCA
147	16	LA PAMPA
148	16	YANAC
149	16	YUPAN
150	17	HUARI
151	17	ANRA
152	17	CAJAY
153	17	CHAVIN DE HUANTAR
154	17	HUACACHI
155	17	HUACCHIS
156	17	HUACHIS
157	17	HUANTAR
158	17	MASIN
159	17	PAUCAS
160	17	PONTO
161	17	RAHUAPAMPA
162	17	RAPAYAN
163	17	SAN MARCOS
164	17	SAN PEDRO DE CHANA
165	17	UCO
166	18	HUARMEY
167	18	COCHAPETI
168	18	CULEBRAS
169	18	HUAYAN
170	18	MALVAS
171	19	CARAZ
172	19	HUALLANCA
173	19	HUATA
174	19	HUAYLAS
175	19	MATO
176	19	PAMPAROMAS
177	19	PUEBLO LIBRE
178	19	SANTA CRUZ
179	19	SANTO TORIBIO
180	19	YURACMARCA
181	20	PISCOBAMBA
182	20	CASCA
183	20	ELEAZAR GUZMAN BARRON
184	20	FIDEL OLIVAS ESCUDERO
185	20	LLAMA
186	20	LLUMPA
187	20	LUCMA
188	20	MUSGA
189	21	OCROS
190	21	ACAS
191	21	CAJAMARQUILLA
192	21	CARHUAPAMPA
193	21	COCHAS
194	21	CONGAS
195	21	LLIPA
196	21	SAN CRISTOBAL DE RAJAN
197	21	SAN PEDRO
198	21	SANTIAGO DE CHILCAS
199	22	CABANA
200	22	BOLOGNESI
201	22	CONCHUCOS
202	22	HUACASCHUQUE
203	22	HUANDOVAL
204	22	LACABAMBA
205	22	LLAPO
206	22	PALLASCA
207	22	PAMPAS
208	22	SANTA ROSA
209	22	TAUCA
210	23	POMABAMBA
211	23	HUAYLLAN
212	23	PAROBAMBA
213	23	QUINUABAMBA
214	24	RECUAY
215	24	CATAC
216	24	COTAPARACO
217	24	HUAYLLAPAMPA
218	24	LLACLLIN
219	24	MARCA
220	24	PAMPAS CHICO
221	24	PARARIN
222	24	TAPACOCHA
223	24	TICAPAMPA
224	25	CHIMBOTE
225	25	CACERES DEL PERU
226	25	COISHCO
227	25	MACATE
228	25	MORO
229	25	NEPEÑA
230	25	SAMANCO
231	25	SANTA
232	25	NUEVO CHIMBOTE
233	26	SIHUAS
234	26	ACOBAMBA
235	26	ALFONSO UGARTE
236	26	CASHAPAMPA
237	26	CHINGALPO
238	26	HUAYLLABAMBA
239	26	QUICHES
240	26	RAGASH
241	26	SAN JUAN
242	26	SICSIBAMBA
243	27	YUNGAY
244	27	CASCAPARA
245	27	MANCOS
246	27	MATACOTO
247	27	QUILLO
248	27	RANRAHIRCA
249	27	SHUPLUY
250	27	YANAMA
251	28	ABANCAY
252	28	CHACOCHE
253	28	CIRCA
254	28	CURAHUASI
255	28	HUANIPACA
256	28	LAMBRAMA
257	28	PICHIRHUA
258	28	SAN PEDRO DE CACHORA
259	28	TAMBURCO
260	29	ANDAHUAYLAS
261	29	ANDARAPA
262	29	CHIARA
263	29	HUANCARAMA
264	29	HUANCARAY
265	29	HUAYANA
266	29	KISHUARA
267	29	PACOBAMBA
268	29	PACUCHA
269	29	PAMPACHIRI
270	29	POMACOCHA
271	29	SAN ANTONIO DE CACHI
272	29	SAN JERONIMO
273	29	SAN MIGUEL DE CHACCRAMPA
274	29	SANTA MARIA DE CHICMO
275	29	TALAVERA
276	29	TUMAY HUARACA
277	29	TURPO
278	29	KAQUIABAMBA
279	30	ANTABAMBA
280	30	EL ORO
281	30	HUAQUIRCA
282	30	JUAN ESPINOZA MEDRANO
283	30	OROPESA
284	30	PACHACONAS
285	30	SABAINO
286	31	CHALHUANCA
287	31	CAPAYA
288	31	CARAYBAMBA
289	31	CHAPIMARCA
290	31	COLCABAMBA
291	31	COTARUSE
292	31	HUAYLLO
293	31	JUSTO APU SAHUARAURA
294	31	LUCRE
295	31	POCOHUANCA
296	31	SAN JUAN DE CHACÑA
297	31	SAÑAYCA
298	31	SORAYA
299	31	TAPAIRIHUA
300	31	TINTAY
301	31	TORAYA
302	31	YANACA
303	32	TAMBOBAMBA
304	32	COTABAMBAS
305	32	COYLLURQUI
306	32	HAQUIRA
307	32	MARA
308	32	CHALLHUAHUACHO
309	33	CHINCHEROS
310	33	ANCO_HUALLO
311	33	COCHARCAS
312	33	HUACCANA
313	33	OCOBAMBA
314	33	ONGOY
315	33	URANMARCA
316	33	RANRACANCHA
317	34	CHUQUIBAMBILLA
318	34	CURPAHUASI
319	34	GAMARRA
320	34	HUAYLLATI
321	34	MAMARA
322	34	MICAELA BASTIDAS
323	34	PATAYPAMPA
324	34	PROGRESO
325	34	SAN ANTONIO
326	34	SANTA ROSA
327	34	TURPAY
328	34	VILCABAMBA
329	34	VIRUNDO
330	34	CURASCO
331	35	AREQUIPA
332	35	ALTO SELVA ALEGRE
333	35	CAYMA
334	35	CERRO COLORADO
335	35	CHARACATO
336	35	CHIGUATA
337	35	JACOBO HUNTER
338	35	LA JOYA
339	35	MARIANO MELGAR
340	35	MIRAFLORES
341	35	MOLLEBAYA
342	35	PAUCARPATA
343	35	POCSI
344	35	POLOBAYA
345	35	QUEQUEÑA
346	35	SABANDIA
347	35	SACHACA
348	35	SAN JUAN DE SIGUAS
349	35	SAN JUAN DE TARUCANI
350	35	SANTA ISABEL DE SIGUAS
351	35	SANTA RITA DE SIGUAS
352	35	SOCABAYA
353	35	TIABAYA
354	35	UCHUMAYO
355	35	VITOR
356	35	YANAHUARA
357	35	YARABAMBA
358	35	YURA
359	35	JOSE LUIS BUSTAMANTE Y RIVERO
360	36	CAMANA
361	36	JOSE MARIA QUIMPER
362	36	MARIANO NICOLAS VALCARCEL
363	36	MARISCAL CACERES
364	36	NICOLAS DE PIEROLA
365	36	OCOÑA
366	36	QUILCA
367	36	SAMUEL PASTOR
368	37	CARAVELI
369	37	ACARI
370	37	ATICO
371	37	ATIQUIPA
372	37	BELLA UNION
373	37	CAHUACHO
374	37	CHALA
375	37	CHAPARRA
376	37	HUANUHUANU
377	37	JAQUI
378	37	LOMAS
379	37	QUICACHA
380	37	YAUCA
381	38	APLAO
382	38	ANDAGUA
383	38	AYO
384	38	CHACHAS
385	38	CHILCAYMARCA
386	38	CHOCO
387	38	HUANCARQUI
388	38	MACHAGUAY
389	38	ORCOPAMPA
390	38	PAMPACOLCA
391	38	TIPAN
392	38	UÑON
393	38	URACA
394	38	VIRACO
395	39	CHIVAY
396	39	ACHOMA
397	39	CABANACONDE
398	39	CALLALLI
399	39	CAYLLOMA
400	39	COPORAQUE
401	39	HUAMBO
402	39	HUANCA
403	39	ICHUPAMPA
404	39	LARI
405	39	LLUTA
406	39	MACA
407	39	MADRIGAL
408	39	SAN ANTONIO DE CHUCA
409	39	SIBAYO
410	39	TAPAY
411	39	TISCO
412	39	TUTI
413	39	YANQUE
414	39	MAJES
415	40	CHUQUIBAMBA
416	40	ANDARAY
417	40	CAYARANI
418	40	CHICHAS
419	40	IRAY
420	40	RIO GRANDE
421	40	SALAMANCA
422	40	YANAQUIHUA
423	41	MOLLENDO
424	41	COCACHACRA
425	41	DEAN VALDIVIA
426	41	ISLAY
427	41	MEJIA
428	41	PUNTA DE BOMBON
429	42	COTAHUASI
430	42	ALCA
431	42	CHARCANA
432	42	HUAYNACOTAS
433	42	PAMPAMARCA
434	42	PUYCA
435	42	QUECHUALLA
436	42	SAYLA
437	42	TAURIA
438	42	TOMEPAMPA
439	42	TORO
440	43	AYACUCHO
441	43	ACOCRO
442	43	ACOS VINCHOS
443	43	CARMEN ALTO
444	43	CHIARA
445	43	OCROS
446	43	PACAYCASA
447	43	QUINUA
448	43	SAN JOSE DE TICLLAS
449	43	SAN JUAN BAUTISTA
450	43	SANTIAGO DE PISCHA
451	43	SOCOS
452	43	TAMBILLO
453	43	VINCHOS
454	43	JESUS NAZARENO
455	44	CANGALLO
456	44	CHUSCHI
457	44	LOS MOROCHUCOS
458	44	MARIA PARADO DE BELLIDO
459	44	PARAS
460	44	TOTOS
461	45	SANCOS
462	45	CARAPO
463	45	SACSAMARCA
464	45	SANTIAGO DE LUCANAMARCA
465	46	HUANTA
466	46	AYAHUANCO
467	46	HUAMANGUILLA
468	46	IGUAIN
469	46	LURICOCHA
470	46	SANTILLANA
471	46	SIVIA
472	46	LLOCHEGUA
473	47	SAN MIGUEL
474	47	ANCO
475	47	AYNA
476	47	CHILCAS
477	47	CHUNGUI
478	47	LUIS CARRANZA
479	47	SANTA ROSA
480	47	TAMBO
481	48	PUQUIO
482	48	AUCARA
483	48	CABANA
484	48	CARMEN SALCEDO
485	48	CHAVIÑA
486	48	CHIPAO
487	48	HUAC-HUAS
488	48	LARAMATE
489	48	LEONCIO PRADO
490	48	LLAUTA
491	48	LUCANAS
492	48	OCAÑA
493	48	OTOCA
494	48	SAISA
495	48	SAN CRISTOBAL
496	48	SAN JUAN
497	48	SAN PEDRO
498	48	SAN PEDRO DE PALCO
499	48	SANCOS
500	48	SANTA ANA DE HUAYCAHUACHO
501	48	SANTA LUCIA
502	49	CORACORA
503	49	CHUMPI
504	49	CORONEL CASTAÑEDA
505	49	PACAPAUSA
506	49	PULLO
507	49	PUYUSCA
508	49	SAN FRANCISCO DE RAVACAYCO
509	49	UPAHUACHO
510	50	PAUSA
511	50	COLTA
512	50	CORCULLA
513	50	LAMPA
514	50	MARCABAMBA
515	50	OYOLO
516	50	PARARCA
517	50	SAN JAVIER DE ALPABAMBA
518	50	SAN JOSE DE USHUA
519	50	SARA SARA
520	51	QUEROBAMBA
521	51	BELEN
522	51	CHALCOS
523	51	CHILCAYOC
524	51	HUACAÑA
525	51	MORCOLLA
526	51	PAICO
527	51	SAN PEDRO DE LARCAY
528	51	SAN SALVADOR DE QUIJE
529	51	SANTIAGO DE PAUCARAY
530	51	SORAS
531	52	HUANCAPI
532	52	ALCAMENCA
533	52	APONGO
534	52	ASQUIPATA
535	52	CANARIA
536	52	CAYARA
537	52	COLCA
538	52	HUAMANQUIQUIA
539	52	HUANCARAYLLA
540	52	HUAYA
541	52	SARHUA
542	52	VILCANCHOS
543	53	VILCAS HUAMAN
544	53	ACCOMARCA
545	53	CARHUANCA
546	53	CONCEPCION
547	53	HUAMBALPA
548	53	INDEPENDENCIA
549	53	SAURAMA
550	53	VISCHONGO
551	54	CAJAMARCA
552	54	ASUNCION
553	54	CHETILLA
554	54	COSPAN
555	54	ENCAÑADA
556	54	JESUS
557	54	LLACANORA
558	54	LOS BAÑOS DEL INCA
559	54	MAGDALENA
560	54	MATARA
561	54	NAMORA
562	54	SAN JUAN
563	55	CAJABAMBA
564	55	CACHACHI
565	55	CONDEBAMBA
566	55	SITACOCHA
567	56	CELENDIN
568	56	CHUMUCH
569	56	CORTEGANA
570	56	HUASMIN
571	56	JORGE CHAVEZ
572	56	JOSE GALVEZ
573	56	MIGUEL IGLESIAS
574	56	OXAMARCA
575	56	SOROCHUCO
576	56	SUCRE
577	56	UTCO
578	56	LA LIBERTAD DE PALLAN
579	57	CHOTA
580	57	ANGUIA
581	57	CHADIN
582	57	CHIGUIRIP
583	57	CHIMBAN
584	57	CHOROPAMPA
585	57	COCHABAMBA
586	57	CONCHAN
587	57	HUAMBOS
588	57	LAJAS
589	57	LLAMA
590	57	MIRACOSTA
591	57	PACCHA
592	57	PION
593	57	QUEROCOTO
594	57	SAN JUAN DE LICUPIS
595	57	TACABAMBA
596	57	TOCMOCHE
597	57	CHALAMARCA
598	58	CONTUMAZA
599	58	CHILETE
600	58	CUPISNIQUE
601	58	GUZMANGO
602	58	SAN BENITO
603	58	SANTA CRUZ DE TOLED
604	58	TANTARICA
605	58	YONAN
606	59	CUTERVO
607	59	CALLAYUC
608	59	CHOROS
609	59	CUJILLO
610	59	LA RAMADA
611	59	PIMPINGOS
612	59	QUEROCOTILLO
613	59	SAN ANDRES DE CUTERVO
614	59	SAN JUAN DE CUTERVO
615	59	SAN LUIS DE LUCMA
616	59	SANTA CRUZ
617	59	SANTO DOMINGO DE LA CAPILLA
618	59	SANTO TOMAS
619	59	SOCOTA
620	59	TORIBIO CASANOVA
621	60	BAMBAMARCA
622	60	CHUGUR
623	60	HUALGAYOC
624	61	JAEN
625	61	BELLAVISTA
626	61	CHONTALI
627	61	COLASAY
628	61	HUABAL
629	61	LAS PIRIAS
630	61	POMAHUACA
631	61	PUCARA
632	61	SALLIQUE
633	61	SAN FELIPE
634	61	SAN JOSE DEL ALTO
635	61	SANTA ROSA
636	62	SAN IGNACIO
637	62	CHIRINOS
638	62	HUARANGO
639	62	LA COIPA
640	62	NAMBALLE
641	62	SAN JOSE DE LOURDES
642	62	TABACONAS
643	63	PEDRO GALVEZ
644	63	CHANCAY
645	63	EDUARDO VILLANUEVA
646	63	GREGORIO PITA
647	63	ICHOCAN
648	63	JOSE MANUEL QUIROZ
649	63	JOSE SABOGAL
650	64	SAN MIGUEL
651	64	BOLIVAR
652	64	CALQUIS
653	64	CATILLUC
654	64	EL PRADO
655	64	LA FLORIDA
656	64	LLAPA
657	64	NANCHOC
658	64	NIEPOS
659	64	SAN GREGORIO
660	64	SAN SILVESTRE DE COCHAN
661	64	TONGOD
662	64	UNION AGUA BLANCA
663	65	SAN PABLO
664	65	SAN BERNARDINO
665	65	SAN LUIS
666	65	TUMBADEN
667	66	SANTA CRUZ
668	66	ANDABAMBA
669	66	CATACHE
670	66	CHANCAYBAÑOS
671	66	LA ESPERANZA
672	66	NINABAMBA
673	66	PULAN
674	66	SAUCEPAMPA
675	66	SEXI
676	66	UTICYACU
677	66	YAUYUCAN
678	67	CALLAO
679	67	BELLAVISTA
680	67	CARMEN DE LA LEGUA REYNOSO
681	67	LA PERLA
682	67	LA PUNTA
683	67	VENTANILLA
684	68	CUSCO
685	68	CCORCA
686	68	POROY
687	68	SAN JERONIMO
688	68	SAN SEBASTIAN
689	68	SANTIAGO
690	68	SAYLLA
691	68	WANCHAQ
692	69	ACOMAYO
693	69	ACOPIA
694	69	ACOS
695	69	MOSOC LLACTA
696	69	POMACANCHI
697	69	RONDOCAN
698	69	SANGARARA
699	70	ANTA
700	70	ANCAHUASI
701	70	CACHIMAYO
702	70	CHINCHAYPUJIO
703	70	HUAROCONDO
704	70	LIMATAMBO
705	70	MOLLEPATA
706	70	PUCYURA
707	70	ZURITE
708	71	CALCA
709	71	COYA
710	71	LAMAY
711	71	LARES
712	71	PISAC
713	71	SAN SALVADOR
714	71	TARAY
715	71	YANATILE
716	72	YANAOCA
717	72	CHECCA
718	72	KUNTURKANKI
719	72	LANGUI
720	72	LAYO
721	72	PAMPAMARCA
722	72	QUEHUE
723	72	TUPAC AMARU
724	73	SICUANI
725	73	CHECACUPE
726	73	COMBAPATA
727	73	MARANGANI
728	73	PITUMARCA
729	73	SAN PABLO
730	73	SAN PEDRO
731	73	TINTA
732	74	SANTO TOMAS
733	74	CAPACMARCA
734	74	CHAMACA
735	74	COLQUEMARCA
736	74	LIVITACA
737	74	LLUSCO
738	74	QUIÑOTA
739	74	VELILLE
740	75	ESPINAR
741	75	CONDOROMA
742	75	COPORAQUE
743	75	OCORURO
744	75	PALLPATA
745	75	PICHIGUA
746	75	SUYCKUTAMBO
747	75	ALTO PICHIGUA
748	76	SANTA ANA
749	76	ECHARATE
750	76	HUAYOPATA
751	76	MARANURA
752	76	OCOBAMBA
753	76	QUELLOUNO
754	76	KIMBIRI
755	76	SANTA TERESA
756	76	VILCABAMBA
757	76	PICHARI
758	77	PARURO
759	77	ACCHA
760	77	CCAPI
761	77	COLCHA
762	77	HUANOQUITE
763	77	OMACHA
764	77	PACCARITAMBO
765	77	PILLPINTO
766	77	YAURISQUE
767	78	PAUCARTAMBO
768	78	CAICAY
769	78	CHALLABAMBA
770	78	COLQUEPATA
771	78	HUANCARANI
772	78	KOSÑIPATA
773	79	URCOS
774	79	ANDAHUAYLILLAS
775	79	CAMANTI
776	79	CCARHUAYO
777	79	CCATCA
778	79	CUSIPATA
779	79	HUARO
780	79	LUCRE
781	79	MARCAPATA
782	79	OCONGATE
783	79	OROPESA
784	79	QUIQUIJANA
785	80	URUBAMBA
786	80	CHINCHERO
787	80	HUAYLLABAMBA
788	80	MACHUPICCHU
789	80	MARAS
790	80	OLLANTAYTAMBO
791	80	YUCAY
792	81	HUANCAVELICA
793	81	ACOBAMBILLA
794	81	ACORIA
795	81	CONAYCA
796	81	CUENCA
797	81	HUACHOCOLPA
798	81	HUAYLLAHUARA
799	81	IZCUCHACA
800	81	LARIA
801	81	MANTA
802	81	MARISCAL CACERES
803	81	MOYA
804	81	NUEVO OCCORO
805	81	PALCA
806	81	PILCHACA
807	81	VILCA
808	81	YAULI
809	81	ASCENSION
810	81	HUANDO
811	82	ACOBAMBA
812	82	ANDABAMBA
813	82	ANTA
814	82	CAJA
815	82	MARCAS
816	82	PAUCARA
817	82	POMACOCHA
818	82	ROSARIO
819	83	LIRCAY
820	83	ANCHONGA
821	83	CALLANMARCA
822	83	CCOCHACCASA
823	83	CHINCHO
824	83	CONGALLA
825	83	HUANCA-HUANCA
826	83	HUAYLLAY GRANDE
827	83	JULCAMARCA
828	83	SAN ANTONIO DE ANTAPARCO
829	83	SANTO TOMAS DE PATA
830	83	SECCLLA
831	84	CASTROVIRREYNA
832	84	ARMA
833	84	AURAHUA
834	84	CAPILLAS
835	84	CHUPAMARCA
836	84	COCAS
837	84	HUACHOS
838	84	HUAMATAMBO
839	84	MOLLEPAMPA
840	84	SAN JUAN
841	84	SANTA ANA
842	84	TANTARA
843	84	TICRAPO
844	85	CHURCAMPA
845	85	ANCO
846	85	CHINCHIHUASI
847	85	EL CARMEN
848	85	LA MERCED
849	85	LOCROJA
850	85	PAUCARBAMBA
851	85	SAN MIGUEL DE MAYOCC
852	85	SAN PEDRO DE CORIS
853	85	PACHAMARCA
854	86	HUAYTARA
855	86	AYAVI
856	86	CORDOVA
857	86	HUAYACUNDO ARMA
858	86	LARAMARCA
859	86	OCOYO
860	86	PILPICHACA
861	86	QUERCO
862	86	QUITO-ARMA
863	86	SAN ANTONIO DE CUSICANCHA
864	86	SAN FRANCISCO DE SANGAYAICO
865	86	SAN ISIDRO
866	86	SANTIAGO DE CHOCORVOS
867	86	SANTIAGO DE QUIRAHUARA
868	86	SANTO DOMINGO DE CAPILLAS
869	86	TAMBO
870	87	PAMPAS
871	87	ACOSTAMBO
872	87	ACRAQUIA
873	87	AHUAYCHA
874	87	COLCABAMBA
875	87	DANIEL HERNANDEZ
876	87	HUACHOCOLPA
877	87	HUARIBAMBA
878	87	ÑAHUIMPUQUIO
879	87	PAZOS
880	87	QUISHUAR
881	87	SALCABAMBA
882	87	SALCAHUASI
883	87	SAN MARCOS DE ROCCHAC
884	87	SURCUBAMBA
885	87	TINTAY PUNCU
886	88	HUANUCO
887	88	AMARILIS
888	88	CHINCHAO
889	88	CHURUBAMBA
890	88	MARGOS
891	88	QUISQUI
892	88	SAN FRANCISCO DE CAYRAN
893	88	SAN PEDRO DE CHAULAN
894	88	SANTA MARIA DEL VALLE
895	88	YARUMAYO
896	88	PILLCO MARCA
897	89	AMBO
898	89	CAYNA
899	89	COLPAS
900	89	CONCHAMARCA
901	89	HUACAR
902	89	SAN FRANCISCO
903	89	SAN RAFAEL
904	89	TOMAY KICHWA
905	90	LA UNION
906	90	CHUQUIS
907	90	MARIAS
908	90	PACHAS
909	90	QUIVILLA
910	90	RIPAN
911	90	SHUNQUI
912	90	SILLAPATA
913	90	YANAS
914	91	HUACAYBAMBA
915	91	CANCHABAMBA
916	91	COCHABAMBA
917	91	PINRA
918	92	LLATA
919	92	ARANCAY
920	92	CHAVIN DE PARIARCA
921	92	JACAS GRANDE
922	92	JIRCAN
923	92	MIRAFLORES
924	92	MONZON
925	92	PUNCHAO
926	92	PUÑOS
927	92	SINGA
928	92	TANTAMAYO
929	93	RUPA-RUPA
930	93	DANIEL ALOMIAS ROBLES
931	93	HERMILIO VALDIZAN
932	93	JOSE CRESPO Y CASTILLO
933	93	LUYANDO
934	93	MARIANO DAMASO BERAUN
935	94	HUACRACHUCO
936	94	CHOLON
937	94	SAN BUENAVENTURA
938	95	PANAO
939	95	CHAGLLA
940	95	MOLINO
941	95	UMARI
942	96	PUERTO INCA
943	96	CODO DEL POZUZO
944	96	HONORIA
945	96	TOURNAVISTA
946	96	YUYAPICHIS
947	97	JESUS
948	97	BAÑOS
949	97	JIVIA
950	97	QUEROPALCA
951	97	RONDOS
952	97	SAN FRANCISCO DE ASIS
953	97	SAN MIGUEL DE CAURI
954	98	CHAVINILLO
955	98	CAHUAC
956	98	CHACABAMBA
957	98	APARICIO POMARES
958	98	JACAS CHICO
959	98	OBAS
960	98	PAMPAMARCA
961	98	CHORAS
962	99	ICA
963	99	LA TINGUIÑA
964	99	LOS AQUIJES
965	99	OCUCAJE
966	99	PACHACUTEC
967	99	PARCONA
968	99	PUEBLO NUEVO
969	99	SALAS
970	99	SAN JOSE DE LOS MOLINOS
971	99	SAN JUAN BAUTISTA
972	99	SANTIAGO
973	99	SUBTANJALLA
974	99	TATE
975	99	YAUCA DEL ROSARIO
976	100	CHINCHA ALTA
977	100	ALTO LARAN
978	100	CHAVIN
979	100	CHINCHA BAJA
980	100	EL CARMEN
981	100	GROCIO PRADO
982	100	PUEBLO NUEVO
983	100	SAN JUAN DE YANAC
984	100	SAN PEDRO DE HUACARPANA
985	100	SUNAMPE
986	100	TAMBO DE MORA
987	101	NAZCA
988	101	CHANGUILLO
989	101	EL INGENIO
990	101	MARCONA
991	101	VISTA ALEGRE
992	102	PALPA
993	102	LLIPATA
994	102	RIO GRANDE
995	102	SANTA CRUZ
996	102	TIBILLO
997	103	PISCO
998	103	HUANCANO
999	103	HUMAY
1000	103	INDEPENDENCIA
1001	103	PARACAS
1002	103	SAN ANDRES
1003	103	SAN CLEMENTE
1004	103	TUPAC AMARU INCA
1005	104	HUANCAYO
1006	104	CARHUACALLANGA
1007	104	CHACAPAMPA
1008	104	CHICCHE
1009	104	CHILCA
1010	104	CHONGOS ALTO
1011	104	CHUPURO
1012	104	COLCA
1013	104	CULLHUAS
1014	104	EL TAMBO
1015	104	HUACRAPUQUIO
1016	104	HUALHUAS
1017	104	HUANCAN
1018	104	HUASICANCHA
1019	104	HUAYUCACHI
1020	104	INGENIO
1021	104	PARIAHUANCA
1022	104	PILCOMAYO
1023	104	PUCARA
1024	104	QUICHUAY
1025	104	QUILCAS
1026	104	SAN AGUSTIN
1027	104	SAN JERONIMO DE TUNAN
1028	104	SAÑO
1029	104	SAPALLANGA
1030	104	SICAYA
1031	104	SANTO DOMINGO DE ACOBAMBA
1032	104	VIQUES
1033	105	CONCEPCION
1034	105	ACO
1035	105	ANDAMARCA
1036	105	CHAMBARA
1037	105	COCHAS
1038	105	COMAS
1039	105	HEROINAS TOLEDO
1040	105	MANZANARES
1041	105	MARISCAL CASTILLA
1042	105	MATAHUASI
1043	105	MITO
1044	105	NUEVE DE JULIO
1045	105	ORCOTUNA
1046	105	SAN JOSE DE QUERO
1047	105	SANTA ROSA DE OCOPA
1048	106	CHANCHAMAYO
1049	106	PERENE
1050	106	PICHANAQUI
1051	106	SAN LUIS DE SHUARO
1052	106	SAN RAMON
1053	106	VITOC
1054	107	JAUJA
1055	107	ACOLLA
1056	107	APATA
1057	107	ATAURA
1058	107	CANCHAYLLO
1059	107	CURICACA
1060	107	EL MANTARO
1061	107	HUAMALI
1062	107	HUARIPAMPA
1063	107	HUERTAS
1064	107	JANJAILLO
1065	107	JULCAN
1066	107	LEONOR ORDOÑEZ
1067	107	LLOCLLAPAMPA
1068	107	MARCO
1069	107	MASMA
1070	107	MASMA CHICCHE
1071	107	MOLINOS
1072	107	MONOBAMBA
1073	107	MUQUI
1074	107	MUQUIYAUYO
1075	107	PACA
1076	107	PACCHA
1077	107	PANCAN
1078	107	PARCO
1079	107	POMACANCHA
1080	107	RICRAN
1081	107	SAN LORENZO
1082	107	SAN PEDRO DE CHUNAN
1083	107	SAUSA
1084	107	SINCOS
1085	107	TUNAN MARCA
1086	107	YAULI
1087	107	YAUYOS
1088	108	JUNIN
1089	108	CARHUAMAYO
1090	108	ONDORES
1091	108	ULCUMAYO
1092	109	SATIPO
1093	109	COVIRIALI
1094	109	LLAYLLA
1095	109	MAZAMARI
1096	109	PAMPA HERMOSA
1097	109	PANGOA
1098	109	RIO NEGRO
1099	109	RIO TAMBO
1100	110	TARMA
1101	110	ACOBAMBA
1102	110	HUARICOLCA
1103	110	HUASAHUASI
1104	110	LA UNION
1105	110	PALCA
1106	110	PALCAMAYO
1107	110	SAN PEDRO DE CAJAS
1108	110	TAPO
1109	111	LA OROYA
1110	111	CHACAPALPA
1111	111	HUAY-HUAY
1112	111	MARCAPOMACOCHA
1113	111	MOROCOCHA
1114	111	PACCHA
1115	111	SANTA BARBARA DE CARHUACAYAN
1116	111	SANTA ROSA DE SACCO
1117	111	SUITUCANCHA
1118	111	YAULI
1119	112	CHUPACA
1120	112	AHUAC
1121	112	CHONGOS BAJO
1122	112	HUACHAC
1123	112	HUAMANCACA CHICO
1124	112	SAN JUAN DE YSCOS
1125	112	SAN JUAN DE JARPA
1126	112	TRES DE DICIEMBRE
1127	112	YANACANCHA
1128	113	TRUJILLO
1129	113	EL PORVENIR
1130	113	FLORENCIA DE MORA
1131	113	HUANCHACO
1132	113	LA ESPERANZA
1133	113	LAREDO
1134	113	MOCHE
1135	113	POROTO
1136	113	SALAVERRY
1137	113	SIMBAL
1138	113	VICTOR LARCO HERRERA
1139	114	ASCOPE
1140	114	CHICAMA
1141	114	CHOCOPE
1142	114	MAGDALENA DE CAO
1143	114	PAIJAN
1144	114	RAZURI
1145	114	SANTIAGO DE CAO
1146	114	CASA GRANDE
1147	115	BOLIVAR
1148	115	BAMBAMARCA
1149	115	CONDORMARCA
1150	115	LONGOTEA
1151	115	UCHUMARCA
1152	115	UCUNCHA
1153	116	CHEPEN
1154	116	PACANGA
1155	116	PUEBLO NUEVO
1156	117	JULCAN
1157	117	CALAMARCA
1158	117	CARABAMBA
1159	117	HUASO
1160	118	OTUZCO
1161	118	AGALLPAMPA
1162	118	CHARAT
1163	118	HUARANCHAL
1164	118	LA CUESTA
1165	118	MACHE
1166	118	PARANDAY
1167	118	SALPO
1168	118	SINSICAP
1169	118	USQUIL
1170	119	SAN PEDRO DE LLOC
1171	119	GUADALUPE
1172	119	JEQUETEPEQUE
1173	119	PACASMAYO
1174	119	SAN JOSE
1175	120	TAYABAMBA
1176	120	BULDIBUYO
1177	120	CHILLIA
1178	120	HUANCASPATA
1179	120	HUAYLILLAS
1180	120	HUAYO
1181	120	ONGON
1182	120	PARCOY
1183	120	PATAZ
1184	120	PIAS
1185	120	SANTIAGO DE CHALLAS
1186	120	TAURIJA
1187	120	URPAY
1188	121	HUAMACHUCO
1189	121	CHUGAY
1190	121	COCHORCO
1191	121	CURGOS
1192	121	MARCABAL
1193	121	SANAGORAN
1194	121	SARIN
1195	121	SARTIMBAMBA
1196	122	SANTIAGO DE CHUCO
1197	122	ANGASMARCA
1198	122	CACHICADAN
1199	122	MOLLEBAMBA
1200	122	MOLLEPATA
1201	122	QUIRUVILCA
1202	122	SANTA CRUZ DE CHUCA
1203	122	SITABAMBA
1204	123	CASCAS
1205	123	LUCMA
1206	123	MARMOT
1207	123	SAYAPULLO
1208	124	VIRU
1209	124	CHAO
1210	124	GUADALUPITO
1211	125	CHICLAYO
1212	125	CHONGOYAPE
1213	125	ETEN
1214	125	ETEN PUERTO
1215	125	JOSE LEONARDO ORTIZ
1216	125	LA VICTORIA
1217	125	LAGUNAS
1218	125	MONSEFU
1219	125	NUEVA ARICA
1220	125	OYOTUN
1221	125	PICSI
1222	125	PIMENTEL
1223	125	REQUE
1224	125	SANTA ROSA
1225	125	SAÑA
1226	125	CAYALTI
1227	125	PATAPO
1228	125	POMALCA
1229	125	PUCALA
1230	125	TUMAN
1231	126	FERREÑAFE
1232	126	CAÑARIS
1233	126	INCAHUASI
1234	126	MANUEL ANTONIO MESONES MURO
1235	126	PITIPO
1236	126	PUEBLO NUEVO
1237	127	LAMBAYEQUE
1238	127	CHOCHOPE
1239	127	ILLIMO
1240	127	JAYANCA
1241	127	MOCHUMI
1242	127	MORROPE
1243	127	MOTUPE
1244	127	OLMOS
1245	127	PACORA
1246	127	SALAS
1247	127	SAN JOSE
1248	127	TUCUME
1249	128	LIMA
1250	128	ANCON
1251	128	ATE
1252	128	BARRANCO
1253	128	BREÑA
1254	128	CARABAYLLO
1255	128	CHACLACAYO
1256	128	CHORRILLOS
1257	128	CIENEGUILLA
1258	128	COMAS
1259	128	EL AGUSTINO
1260	128	INDEPENDENCIA
1261	128	JESUS MARIA
1262	128	LA MOLINA
1263	128	LA VICTORIA
1264	128	LINCE
1265	128	LOS OLIVOS
1266	128	LURIGANCHO
1267	128	LURIN
1268	128	MAGDALENA DEL MAR
1269	128	MAGDALENA VIEJA
1270	128	MIRAFLORES
1271	128	PACHACAMAC
1272	128	PUCUSANA
1273	128	PUENTE PIEDRA
1274	128	PUNTA HERMOSA
1275	128	PUNTA NEGRA
1276	128	RIMAC
1277	128	SAN BARTOLO
1278	128	SAN BORJA
1279	128	SAN ISIDRO
1280	128	SAN JUAN DE LURIGANCHO
1281	128	SAN JUAN DE MIRAFLORES
1282	128	SAN LUIS
1283	128	SAN MARTIN DE PORRES
1284	128	SAN MIGUEL
1285	128	SANTA ANITA
1286	128	SANTA MARIA DEL MAR
1287	128	SANTA ROSA
1288	128	SANTIAGO DE SURCO
1289	128	SURQUILLO
1290	128	VILLA EL SALVADOR
1291	128	VILLA MARIA DEL TRIUNFO
1292	129	BARRANCA
1293	129	PARAMONGA
1294	129	PATIVILCA
1295	129	SUPE
1296	129	SUPE PUERTO
1297	130	CAJATAMBO
1298	130	COPA
1299	130	GORGOR
1300	130	HUANCAPON
1301	130	MANAS
1302	131	CANTA
1303	131	ARAHUAY
1304	131	HUAMANTANGA
1305	131	HUAROS
1306	131	LACHAQUI
1307	131	SAN BUENAVENTURA
1308	131	SANTA ROSA DE QUIVES
1309	132	SAN VICENTE DE CAÑETE
1310	132	ASIA
1311	132	CALANGO
1312	132	CERRO AZUL
1313	132	CHILCA
1314	132	COAYLLO
1315	132	IMPERIAL
1316	132	LUNAHUANA
1317	132	MALA
1318	132	NUEVO IMPERIAL
1319	132	PACARAN
1320	132	QUILMANA
1321	132	SAN ANTONIO
1322	132	SAN LUIS
1323	132	SANTA CRUZ DE FLORES
1324	132	ZUÑIGA
1325	133	HUARAL
1326	133	ATAVILLOS ALTO
1327	133	ATAVILLOS BAJO
1328	133	AUCALLAMA
1329	133	CHANCAY
1330	133	IHUARI
1331	133	LAMPIAN
1332	133	PACARAOS
1333	133	SAN MIGUEL DE ACOS
1334	133	SANTA CRUZ DE ANDAMARCA
1335	133	SUMBILCA
1336	133	VEINTISIETE DE NOVIEMBRE
1337	134	MATUCANA
1338	134	ANTIOQUIA
1339	134	CALLAHUANCA
1340	134	CARAMPOMA
1341	134	CHICLA
1342	134	CUENCA
1343	134	HUACHUPAMPA
1344	134	HUANZA
1345	134	HUAROCHIRI
1346	134	LAHUAYTAMBO
1347	134	LANGA
1348	134	LARAOS
1349	134	MARIATANA
1350	134	RICARDO PALMA
1351	134	SAN ANDRES DE TUPICOCHA
1352	134	SAN ANTONIO
1353	134	SAN BARTOLOME
1354	134	SAN DAMIAN
1355	134	SAN JUAN DE IRIS
1356	134	SAN JUAN DE TANTARANCHE
1357	134	SAN LORENZO DE QUINTI
1358	134	SAN MATEO
1359	134	SAN MATEO DE OTAO
1360	134	SAN PEDRO DE CASTA
1361	134	SAN PEDRO DE HUANCAYRE
1362	134	SANGALLAYA
1363	134	SANTA CRUZ DE COCACHACRA
1364	134	SANTA EULALIA
1365	134	SANTIAGO DE ANCHUCAYA
1366	134	SANTIAGO DE TUNA
1367	134	SANTO DOMINGO DE LOS OLLEROS
1368	134	SURCO
1369	135	HUACHO
1370	135	AMBAR
1371	135	CALETA DE CARQUIN
1372	135	CHECRAS
1373	135	HUALMAY
1374	135	HUAURA
1375	135	LEONCIO PRADO
1376	135	PACCHO
1377	135	SANTA LEONOR
1378	135	SANTA MARIA
1379	135	SAYAN
1380	135	VEGUETA
1381	136	OYON
1382	136	ANDAJES
1383	136	CAUJUL
1384	136	COCHAMARCA
1385	136	NAVAN
1386	136	PACHANGARA
1387	137	YAUYOS
1388	137	ALIS
1389	137	AYAUCA
1390	137	AYAVIRI
1391	137	AZANGARO
1392	137	CACRA
1393	137	CARANIA
1394	137	CATAHUASI
1395	137	CHOCOS
1396	137	COCHAS
1397	137	COLONIA
1398	137	HONGOS
1399	137	HUAMPARA
1400	137	HUANCAYA
1401	137	HUANGASCAR
1402	137	HUANTAN
1403	137	HUAÑEC
1404	137	LARAOS
1405	137	LINCHA
1406	137	MADEAN
1407	137	MIRAFLORES
1408	137	OMAS
1409	137	PUTINZA
1410	137	QUINCHES
1411	137	QUINOCAY
1412	137	SAN JOAQUIN
1413	137	SAN PEDRO DE PILAS
1414	137	TANTA
1415	137	TAURIPAMPA
1416	137	TOMAS
1417	137	TUPE
1418	137	VIÑAC
1419	137	VITIS
1420	138	IQUITOS
1421	138	ALTO NANAY
1422	138	FERNANDO LORES
1423	138	INDIANA
1424	138	LAS AMAZONAS
1425	138	MAZAN
1426	138	NAPO
1427	138	PUNCHANA
1428	138	PUTUMAYO
1429	138	TORRES CAUSANA
1430	138	BELEN
1431	138	SAN JUAN BAUTISTA
1432	138	TENIENTE MANUEL CLAVERO
1433	139	YURIMAGUAS
1434	139	BALSAPUERTO
1435	139	JEBEROS
1436	139	LAGUNAS
1437	139	SANTA CRUZ
1438	139	TENIENTE CESAR LOPEZ ROJAS
1439	140	NAUTA
1440	140	PARINARI
1441	140	TIGRE
1442	140	TROMPETEROS
1443	140	URARINAS
1444	141	RAMON CASTILLA
1445	141	PEBAS
1446	141	YAVARI
1447	141	SAN PABLO
1448	142	REQUENA
1449	142	ALTO TAPICHE
1450	142	CAPELO
1451	142	EMILIO SAN MARTIN
1452	142	MAQUIA
1453	142	PUINAHUA
1454	142	SAQUENA
1455	142	SOPLIN
1456	142	TAPICHE
1457	142	JENARO HERRERA
1458	142	YAQUERANA
1459	143	CONTAMANA
1460	143	INAHUAYA
1461	143	PADRE MARQUEZ
1462	143	PAMPA HERMOSA
1463	143	SARAYACU
1464	143	VARGAS GUERRA
1465	144	BARRANCA
1466	144	CAHUAPANAS
1467	144	MANSERICHE
1468	144	MORONA
1469	144	PASTAZA
1470	144	ANDOAS
1471	145	TAMBOPATA
1472	145	INAMBARI
1473	145	LAS PIEDRAS
1474	145	LABERINTO
1475	146	MANU
1476	146	FITZCARRALD
1477	146	MADRE DE DIOS
1478	146	HUEPETUHE
1479	147	IÑAPARI
1480	147	IBERIA
1481	147	TAHUAMANU
1482	148	MOQUEGUA
1483	148	CARUMAS
1484	148	CUCHUMBAYA
1485	148	SAMEGUA
1486	148	SAN CRISTOBAL
1487	148	TORATA
1488	149	OMATE
1489	149	CHOJATA
1490	149	COALAQUE
1491	149	ICHUÑA
1492	149	LA CAPILLA
1493	149	LLOQUE
1494	149	MATALAQUE
1495	149	PUQUINA
1496	149	QUINISTAQUILLAS
1497	149	UBINAS
1498	149	YUNGA
1499	150	ILO
1500	150	EL ALGARROBAL
1501	150	PACOCHA
1502	151	CHAUPIMARCA
1503	151	HUACHON
1504	151	HUARIACA
1505	151	HUAYLLAY
1506	151	NINACACA
1507	151	PALLANCHACRA
1508	151	PAUCARTAMBO
1509	151	SAN FRANCISCO DE ASIS DE YARUSYACAN
1510	151	SIMON BOLIVAR
1511	151	TICLACAYAN
1512	151	TINYAHUARCO
1513	151	VICCO
1514	151	YANACANCHA
1515	152	YANAHUANCA
1516	152	CHACAYAN
1517	152	GOYLLARISQUIZGA
1518	152	PAUCAR
1519	152	SAN PEDRO DE PILLAO
1520	152	SANTA ANA DE TUSI
1521	152	TAPUC
1522	152	VILCABAMBA
1523	153	OXAPAMPA
1524	153	CHONTABAMBA
1525	153	HUANCABAMBA
1526	153	PALCAZU
1527	153	POZUZO
1528	153	PUERTO BERMUDEZ
1529	153	VILLA RICA
1530	154	PIURA
1531	154	CASTILLA
1532	154	CATACAOS
1533	154	CURA MORI
1534	154	EL TALLAN
1535	154	LA ARENA
1536	154	LA UNION
1537	154	LAS LOMAS
1538	154	TAMBO GRANDE
1539	155	AYABACA
1540	155	FRIAS
1541	155	JILILI
1542	155	LAGUNAS
1543	155	MONTERO
1544	155	PACAIPAMPA
1545	155	PAIMAS
1546	155	SAPILLICA
1547	155	SICCHEZ
1548	155	SUYO
1549	156	HUANCABAMBA
1550	156	CANCHAQUE
1551	156	EL CARMEN DE LA FRONTERA
1552	156	HUARMACA
1553	156	LALAQUIZ
1554	156	SAN MIGUEL DE EL FAIQUE
1555	156	SONDOR
1556	156	SONDORILLO
1557	157	CHULUCANAS
1558	157	BUENOS AIRES
1559	157	CHALACO
1560	157	LA MATANZA
1561	157	MORROPON
1562	157	SALITRAL
1563	157	SAN JUAN DE BIGOTE
1564	157	SANTA CATALINA DE MOSSA
1565	157	SANTO DOMINGO
1566	157	YAMANGO
1567	158	PAITA
1568	158	AMOTAPE
1569	158	ARENAL
1570	158	COLAN
1571	158	LA HUACA
1572	158	TAMARINDO
1573	158	VICHAYAL
1574	159	SULLANA
1575	159	BELLAVISTA
1576	159	IGNACIO ESCUDERO
1577	159	LANCONES
1578	159	MARCAVELICA
1579	159	MIGUEL CHECA
1580	159	QUERECOTILLO
1581	159	SALITRAL
1582	160	PARIÑAS
1583	160	EL ALTO
1584	160	LA BREA
1585	160	LOBITOS
1586	160	LOS ORGANOS
1587	160	MANCORA
1588	161	SECHURA
1589	161	BELLAVISTA DE LA UNION
1590	161	BERNAL
1591	161	CRISTO NOS VALGA
1592	161	VICE
1593	161	RINCONADA LLICUAR
1594	162	PUNO
1595	162	ACORA
1596	162	AMANTANI
1597	162	ATUNCOLLA
1598	162	CAPACHICA
1599	162	CHUCUITO
1600	162	COATA
1601	162	HUATA
1602	162	MAÑAZO
1603	162	PAUCARCOLLA
1604	162	PICHACANI
1605	162	PLATERIA
1606	162	SAN ANTONIO
1607	162	TIQUILLACA
1608	162	VILQUE
1609	163	AZANGARO
1610	163	ACHAYA
1611	163	ARAPA
1612	163	ASILLO
1613	163	CAMINACA
1614	163	CHUPA
1615	163	JOSE DOMINGO CHOQUEHUANCA
1616	163	MUÑANI
1617	163	POTONI
1618	163	SAMAN
1619	163	SAN ANTON
1620	163	SAN JOSE
1621	163	SAN JUAN DE SALINAS
1622	163	SANTIAGO DE PUPUJA
1623	163	TIRAPATA
1624	164	MACUSANI
1625	164	AJOYANI
1626	164	AYAPATA
1627	164	COASA
1628	164	CORANI
1629	164	CRUCERO
1630	164	ITUATA
1631	164	OLLACHEA
1632	164	SAN GABAN
1633	164	USICAYOS
1634	165	JULI
1635	165	DESAGUADERO
1636	165	HUACULLANI
1637	165	KELLUYO
1638	165	PISACOMA
1639	165	POMATA
1640	165	ZEPITA
1641	166	ILAVE
1642	166	CAPAZO
1643	166	PILCUYO
1644	166	SANTA ROSA
1645	166	CONDURIRI
1646	167	HUANCANE
1647	167	COJATA
1648	167	HUATASANI
1649	167	INCHUPALLA
1650	167	PUSI
1651	167	ROSASPATA
1652	167	TARACO
1653	167	VILQUE CHICO
1654	168	LAMPA
1655	168	CABANILLA
1656	168	CALAPUJA
1657	168	NICASIO
1658	168	OCUVIRI
1659	168	PALCA
1660	168	PARATIA
1661	168	PUCARA
1662	168	SANTA LUCIA
1663	168	VILAVILA
1664	169	AYAVIRI
1665	169	ANTAUTA
1666	169	CUPI
1667	169	LLALLI
1668	169	MACARI
1669	169	NUÑOA
1670	169	ORURILLO
1671	169	SANTA ROSA
1672	169	UMACHIRI
1673	170	MOHO
1674	170	CONIMA
1675	170	HUAYRAPATA
1676	170	TILALI
1677	171	PUTINA
1678	171	ANANEA
1679	171	PEDRO VILCA APAZA
1680	171	QUILCAPUNCU
1681	171	SINA
1682	172	JULIACA
1683	172	CABANA
1684	172	CABANILLAS
1685	172	CARACOTO
1686	173	SANDIA
1687	173	CUYOCUYO
1688	173	LIMBANI
1689	173	PATAMBUCO
1690	173	PHARA
1691	173	QUIACA
1692	173	SAN JUAN DEL ORO
1693	173	YANAHUAYA
1694	173	ALTO INAMBARI
1695	173	SAN PEDRO DE PUTINA PUNCO
1696	174	YUNGUYO
1697	174	ANAPIA
1698	174	COPANI
1699	174	CUTURAPI
1700	174	OLLARAYA
1701	174	TINICACHI
1702	174	UNICACHI
1703	175	MOYOBAMBA
1704	175	CALZADA
1705	175	HABANA
1706	175	JEPELACIO
1707	175	SORITOR
1708	175	YANTALO
1709	176	BELLAVISTA
1710	176	ALTO BIAVO
1711	176	BAJO BIAVO
1712	176	HUALLAGA
1713	176	SAN PABLO
1714	176	SAN RAFAEL
1715	177	SAN JOSE DE SISA
1716	177	AGUA BLANCA
1717	177	SAN MARTIN
1718	177	SANTA ROSA
1719	177	SHATOJA
1720	178	SAPOSOA
1721	178	ALTO SAPOSOA
1722	178	EL ESLABON
1723	178	PISCOYACU
1724	178	SACANCHE
1725	178	TINGO DE SAPOSOA
1726	179	LAMAS
1727	179	ALONSO DE ALVARADO
1728	179	BARRANQUITA
1729	179	CAYNARACHI
1730	179	CUÑUMBUQUI
1731	179	PINTO RECODO
1732	179	RUMISAPA
1733	179	SAN ROQUE DE CUMBAZA
1734	179	SHANAO
1735	179	TABALOSOS
1736	179	ZAPATERO
1737	180	JUANJUI
1738	180	CAMPANILLA
1739	180	HUICUNGO
1740	180	PACHIZA
1741	180	PAJARILLO
1742	181	PICOTA
1743	181	BUENOS AIRES
1744	181	CASPISAPA
1745	181	PILLUANA
1746	181	PUCACACA
1747	181	SAN CRISTOBAL
1748	181	SAN HILARION
1749	181	SHAMBOYACU
1750	181	TINGO DE PONASA
1751	181	TRES UNIDOS
1752	182	RIOJA
1753	182	AWAJUN
1754	182	ELIAS SOPLIN VARGAS
1755	182	NUEVA CAJAMARCA
1756	182	PARDO MIGUEL
1757	182	POSIC
1758	182	SAN FERNANDO
1759	182	YORONGOS
1760	182	YURACYACU
1761	183	TARAPOTO
1762	183	ALBERTO LEVEAU
1763	183	CACATACHI
1764	183	CHAZUTA
1765	183	CHIPURANA
1766	183	EL PORVENIR
1767	183	HUIMBAYOC
1768	183	JUAN GUERRA
1769	183	LA BANDA DE SHILCAYO
1770	183	MORALES
1771	183	PAPAPLAYA
1772	183	SAN ANTONIO
1773	183	SAUCE
1774	183	SHAPAJA
1775	184	TOCACHE
1776	184	NUEVO PROGRESO
1777	184	POLVORA
1778	184	SHUNTE
1779	184	UCHIZA
1780	185	TACNA
1781	185	ALTO DE LA ALIANZA
1782	185	CALANA
1783	185	CIUDAD NUEVA
1784	185	INCLAN
1785	185	PACHIA
1786	185	PALCA
1787	185	POCOLLAY
1788	185	SAMA
1789	185	CORONEL GREGORIO ALBARRACIN LANCHIPA
1790	186	CANDARAVE
1791	186	CAIRANI
1792	186	CAMILACA
1793	186	CURIBAYA
1794	186	HUANUARA
1795	186	QUILAHUANI
1796	187	LOCUMBA
1797	187	ILABAYA
1798	187	ITE
1799	188	TARATA
1800	188	HEROES ALBARRACIN
1801	188	ESTIQUE
1802	188	ESTIQUE-PAMPA
1803	188	SITAJARA
1804	188	SUSAPAYA
1805	188	TARUCACHI
1806	188	TICACO
1807	189	TUMBES
1808	189	CORRALES
1809	189	LA CRUZ
1810	189	PAMPAS DE HOSPITAL
1811	189	SAN JACINTO
1812	189	SAN JUAN DE LA VIRGEN
1813	190	ZORRITOS
1814	190	CASITAS
1815	190	CANOAS DE PUNTA SAL
1816	191	ZARUMILLA
1817	191	AGUAS VERDES
1818	191	MATAPALO
1819	191	PAPAYAL
1820	192	CALLERIA
1821	192	CAMPOVERDE
1822	192	IPARIA
1823	192	MASISEA
1824	192	YARINACOCHA
1825	192	NUEVA REQUENA
1826	192	MANANTAY
1827	193	RAYMONDI
1828	193	SEPAHUA
1829	193	TAHUANIA
1830	193	YURUA
1831	194	PADRE ABAD
1832	194	IRAZOLA
1833	194	CURIMANA
1834	195	PURUS
1835	128	PUEBLO LIBRE
1837	201	PARROQUIA VENEZUELA
\.


--
-- TOC entry 2509 (class 0 OID 16526)
-- Dependencies: 189
-- Data for Name: estadocivil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadocivil (idestadocivil, descripcion) FROM stdin;
1	Soltero(a)
2	Casado(a)
3	Conviviente
4	Viudo(a)
5	Divorciado(a)
\.


--
-- TOC entry 2513 (class 0 OID 16544)
-- Dependencies: 193
-- Data for Name: gradoinstruccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gradoinstruccion (idgradoinstruccion, descripcion) FROM stdin;
1	Superior Univesitario
2	Superior Tecnico
3	Secundaria Completa
4	Secundaria Incompleta
5	Primaria Completa
6	Primaria Incompleta
9	Educación Inicial
7	Sin Instrucción
8	Ninguno
\.


--
-- TOC entry 2499 (class 0 OID 16446)
-- Dependencies: 179
-- Data for Name: idiomas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idiomas (idioma_id, idioma_codigo, idioma_descripcion, estado, por_defecto) FROM stdin;
10	fr        	Frances	A	N
11	pr        	Portugues	A	N
3	en        	Inglés	A	N
1	es        	Español	A	S
\.


--
-- TOC entry 2578 (class 0 OID 25058)
-- Dependencies: 259
-- Data for Name: nivel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nivel (idnivel, descripcion, estado, idtipocargo) FROM stdin;
1	ASOCIACIÓN GENERAL	1	2
2	DIVISIÓN	1	2
3	PAIS	1	2
4	UNIÓN	1	2
8	ASOCIACION GENERAL	1	1
6	DISTRITO MISIONERO	0	2
5	ASOCIACIÓN	1	2
9	DIVISIÓN	1	1
10	PAÍS	1	1
11	UNIÓN	1	1
12	ASOCIACIÓN	1	1
13	DISTRITO MISIONERO	0	1
14	IGLESIA	1	1
7	IGLESIA	1	2
\.


--
-- TOC entry 2511 (class 0 OID 16535)
-- Dependencies: 191
-- Data for Name: ocupacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ocupacion (idocupacion, descripcion) FROM stdin;
1	Abogado(a)
2	Albañil
3	Campesino(a)
4	Carpintero
5	Chofer
6	Colportor
7	Comerciante
8	Desocupado(a)
9	Empleado(a)
10	Empresario(a)
11	Enfermera(o)
12	Estudiante
13	Evanista
14	Fisioterapia
15	Independiente
16	Ingeniero
17	Masoterapia
18	Mecánico
19	Medico
20	Misionero
21	Modista
22	Obrero
23	Otro
24	Panadero
25	Pastor
26	Peluquero
27	Periodista
28	Profesor(a)
29	Sastre
30	Su Casa
31	Zapatero
32	Contador (a)
33	Agricultor
\.


--
-- TOC entry 2556 (class 0 OID 16847)
-- Dependencies: 236
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pais (idpais, descripcion) FROM stdin;
1	Alemania
2	Argentina
3	Australia
4	Bolivia
5	Brasil
6	Canada
7	Chile
8	China
9	Colombia
10	Corea
11	Costa Rica
12	Cuba
13	Ecuador
14	Egipto
15	El Salvador
16	España
17	Estados Unidos
18	Francia
19	Guatemala
20	Haiti
21	Holanda
22	Honduras
23	Inglaterra
24	Italia
25	Japon
26	Mexico
27	Nicaragua
28	Noruega
29	Nueva Zelanda
30	Panama
31	Paraguay
32	Peru
33	Portugal
34	Puerto Rico
35	Republica Dominicana
36	Rusia
37	Uruguay
38	Venezuela
\.


--
-- TOC entry 2537 (class 0 OID 16742)
-- Dependencies: 217
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provincia (idprovincia, iddepartamento, descripcion) FROM stdin;
1	1	CHACHAPOYAS
2	1	BAGUA
3	1	BONGARA
4	1	CONDORCANQUI
5	1	LUYA
6	1	RODRIGUEZ DE MENDOZA
7	1	UTCUBAMBA
8	2	HUARAZ
9	2	AIJA
10	2	ANTONIO RAYMONDI
11	2	ASUNCION
12	2	BOLOGNESI
13	2	CARHUAZ
14	2	CARLOS FERMIN FITZCARRALD
15	2	CASMA
16	2	CORONGO
17	2	HUARI
18	2	HUARMEY
19	2	HUAYLAS
20	2	MARISCAL LUZURIAGA
21	2	OCROS
22	2	PALLASCA
23	2	POMABAMBA
24	2	RECUAY
25	2	SANTA
26	2	SIHUAS
27	2	YUNGAY
28	3	ABANCAY
29	3	ANDAHUAYLAS
30	3	ANTABAMBA
31	3	AYMARAES
32	3	COTABAMBAS
33	3	CHINCHEROS
34	3	GRAU
35	4	AREQUIPA
36	4	CAMANA
37	4	CARAVELI
38	4	CASTILLA
39	4	CAYLLOMA
40	4	CONDESUYOS
41	4	ISLAY
42	4	LA UNION
43	5	HUAMANGA
44	5	CANGALLO
45	5	HUANCA SANCOS
46	5	HUANTA
47	5	LA MAR
48	5	LUCANAS
49	5	PARINACOCHAS
50	5	PAUCAR DEL SARA SARA
51	5	SUCRE
52	5	VICTOR FAJARDO
53	5	VILCAS HUAMAN
54	6	CAJAMARCA
55	6	CAJABAMBA
56	6	CELENDIN
57	6	CHOTA
58	6	CONTUMAZA
59	6	CUTERVO
60	6	HUALGAYOC
61	6	JAEN
62	6	SAN IGNACIO
63	6	SAN MARCOS
64	6	SAN MIGUEL
65	6	SAN PABLO
66	6	SANTA CRUZ
67	7	CALLAO
68	8	CUSCO
69	8	ACOMAYO
70	8	ANTA
71	8	CALCA
72	8	CANAS
73	8	CANCHIS
74	8	CHUMBIVILCAS
75	8	ESPINAR
76	8	LA CONVENCION
77	8	PARURO
78	8	PAUCARTAMBO
79	8	QUISPICANCHI
80	8	URUBAMBA
81	9	HUANCAVELICA
82	9	ACOBAMBA
83	9	ANGARAES
84	9	CASTROVIRREYNA
85	9	CHURCAMPA
86	9	HUAYTARA
87	9	TAYACAJA
88	10	HUANUCO
89	10	AMBO
90	10	DOS DE MAYO
91	10	HUACAYBAMBA
92	10	HUAMALIES
93	10	LEONCIO PRADO
94	10	MARAÑON
95	10	PACHITEA
96	10	PUERTO INCA
97	10	LAURICOCHA
98	10	YAROWILCA
99	11	ICA
100	11	CHINCHA
101	11	NAZCA
102	11	PALPA
103	11	PISCO
104	12	HUANCAYO
105	12	CONCEPCION
106	12	CHANCHAMAYO
107	12	JAUJA
108	12	JUNIN
109	12	SATIPO
110	12	TARMA
111	12	YAULI
112	12	CHUPACA
113	13	TRUJILLO
114	13	ASCOPE
115	13	BOLIVAR
116	13	CHEPEN
117	13	JULCAN
118	13	OTUZCO
119	13	PACASMAYO
120	13	PATAZ
121	13	SANCHEZ CARRION
122	13	SANTIAGO DE CHUCO
123	13	GRAN CHIMU
124	13	VIRU
125	14	CHICLAYO
126	14	FERREÑAFE
127	14	LAMBAYEQUE
128	15	LIMA
129	15	BARRANCA
130	15	CAJATAMBO
131	15	CANTA
132	15	CAÑETE
133	15	HUARAL
134	15	HUAROCHIRI
135	15	HUAURA
136	15	OYON
137	15	YAUYOS
138	16	MAYNAS
139	16	ALTO AMAZONAS
140	16	LORETO
141	16	MARISCAL RAMON CASTILLA
142	16	REQUENA
143	16	UCAYALI
144	16	DATEM DEL MARAÑON
145	17	TAMBOPATA
146	17	MANU
147	17	TAHUAMANU
148	18	MARISCAL NIETO
149	18	GENERAL SANCHEZ CERRO
150	18	ILO
151	19	PASCO
152	19	DANIEL ALCIDES CARRION
153	19	OXAPAMPA
154	20	PIURA
155	20	AYABACA
156	20	HUANCABAMBA
157	20	MORROPON
158	20	PAITA
159	20	SULLANA
160	20	TALARA
161	20	SECHURA
162	21	PUNO
163	21	AZANGARO
164	21	CARABAYA
165	21	CHUCUITO
166	21	EL COLLAO
167	21	HUANCANE
168	21	LAMPA
169	21	MELGAR
170	21	MOHO
171	21	SAN ANTONIO DE PUTINA
172	21	SAN ROMAN
173	21	SANDIA
174	21	YUNGUYO
175	22	MOYOBAMBA
176	22	BELLAVISTA
177	22	EL DORADO
178	22	HUALLAGA
179	22	LAMAS
180	22	MARISCAL CACERES
181	22	PICOTA
182	22	RIOJA
183	22	SAN MARTIN
184	22	TOCACHE
185	23	TACNA
186	23	CANDARAVE
187	23	JORGE BASADRE
188	23	TARATA
189	24	TUMBES
190	24	CONTRALMIRANTE VILLAR
191	24	ZARUMILLA
192	25	CORONEL PORTILLO
193	25	ATALAYA
194	25	PADRE ABAD
195	25	PURUS
200	29	MEXICO DF
201	30	MUNICIPIO VENEZUELA
202	31	MUNI PARAGUAY
\.


--
-- TOC entry 2572 (class 0 OID 25000)
-- Dependencies: 252
-- Data for Name: tipocargo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipocargo (idtipocargo, descripcion, posee_nivel) FROM stdin;
2	OFICIAL	S
1	MINISTERIAL	N
\.


--
-- TOC entry 2547 (class 0 OID 16797)
-- Dependencies: 227
-- Data for Name: tipoconstruccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipoconstruccion (idtipoconstruccion, descripcion) FROM stdin;
1	Adobe
2	Ladrillos
3	Madera
\.


--
-- TOC entry 2507 (class 0 OID 16517)
-- Dependencies: 187
-- Data for Name: tipodoc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipodoc (idtipodoc, descripcion) FROM stdin;
4	Pasaporte
6	Otros
1	Documento de Identidad
2	Certificado de Nacimiento
3	Carnet Extranjeria
5	Tarjeta de Servicio Militar
\.


--
-- TOC entry 2549 (class 0 OID 16806)
-- Dependencies: 229
-- Data for Name: tipodocumentacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipodocumentacion (idtipodocumentacion, descripcion) FROM stdin;
1	Documento Privado
2	En Tramite
3	Juez
4	Minuta de Compra Venta
5	No Tiene
6	Notaria
7	Simple
8	Alquilado
9	SUNARP
\.


--
-- TOC entry 2551 (class 0 OID 16815)
-- Dependencies: 231
-- Data for Name: tipoinmueble; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipoinmueble (idtipoinmueble, descripcion) FROM stdin;
1	Terreno
2	Templo
3	Alquiler
4	En Uso
5	Templo y Casa Misión
6	Casa Misión
\.


--
-- TOC entry 2590 (class 0 OID 25150)
-- Dependencies: 273
-- Data for Name: trimestre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trimestre (idtrimestre, descripcion, fechainicial, fechafinal, nrosemanas) FROM stdin;
1	Primer Trimestre	01/01	31/03	13
2	Segundo Trimestre	01/04	30/06	13
3	Tercer Trimestre	01/07	30/09	13
4	Cuarto Trimestre	01/10	31/12	13
\.


--
-- TOC entry 2580 (class 0 OID 25075)
-- Dependencies: 261
-- Data for Name: log_sistema; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.log_sistema (idlog, mensaje, fecha, usuario, nombres, idperfil, idreferencia, ip, operacion, tabla) FROM stdin;
1	\N	2021-07-04 04:35:00	admin	GATICA LARA, ROMINA	1	19	::1	modificar	public.idiomas
2	\N	2021-07-04 13:53:47	admin	GATICA LARA, ROMINA	1	2	::1	insertar	iglesias.temp_traslados
3	\N	2021-07-04 16:31:50	admin	GATICA LARA, ROMINA	1	19	::1	eliminar	public.idiomas
4	\N	2021-07-04 16:35:58	admin	GATICA LARA, ROMINA	1	4	::1	insertar	iglesias.temp_traslados
5	\N	2021-07-04 16:35:58	admin	GATICA LARA, ROMINA	1	5	::1	insertar	iglesias.temp_traslados
6	\N	2021-07-04 16:37:02	admin	GATICA LARA, ROMINA	1	6	::1	insertar	iglesias.temp_traslados
7	\N	2021-07-04 16:37:02	admin	GATICA LARA, ROMINA	1	7	::1	insertar	iglesias.temp_traslados
8	\N	2021-07-04 16:39:27	admin	GATICA LARA, ROMINA	1	8	::1	insertar	iglesias.temp_traslados
9	\N	2021-07-04 16:39:27	admin	GATICA LARA, ROMINA	1	9	::1	insertar	iglesias.temp_traslados
10	\N	2021-07-04 17:46:32	admin	GATICA LARA, ROMINA	1	10	::1	insertar	iglesias.temp_traslados
11	\N	2021-07-04 17:46:32	admin	GATICA LARA, ROMINA	1	11	::1	insertar	iglesias.temp_traslados
12	\N	2021-07-04 17:49:25	admin	GATICA LARA, ROMINA	1	12	::1	insertar	iglesias.temp_traslados
13	\N	2021-07-04 17:49:25	admin	GATICA LARA, ROMINA	1	13	::1	insertar	iglesias.temp_traslados
14	\N	2021-07-04 17:51:39	admin	GATICA LARA, ROMINA	1	14	::1	insertar	iglesias.temp_traslados
15	\N	2021-07-04 17:51:40	admin	GATICA LARA, ROMINA	1	15	::1	insertar	iglesias.temp_traslados
16	\N	2021-07-04 17:55:12	admin	GATICA LARA, ROMINA	1	16	::1	insertar	iglesias.temp_traslados
17	\N	2021-07-04 17:55:12	admin	GATICA LARA, ROMINA	1	17	::1	insertar	iglesias.temp_traslados
18	\N	2021-07-04 17:58:32	admin	GATICA LARA, ROMINA	1	18	::1	insertar	iglesias.temp_traslados
19	\N	2021-07-04 17:58:32	admin	GATICA LARA, ROMINA	1	19	::1	insertar	iglesias.temp_traslados
20	\N	2021-07-04 18:07:18	admin	GATICA LARA, ROMINA	1	20	::1	insertar	iglesias.temp_traslados
21	\N	2021-07-04 18:07:18	admin	GATICA LARA, ROMINA	1	21	::1	insertar	iglesias.temp_traslados
22	\N	2021-07-04 21:34:53	admin	GATICA LARA, ROMINA	1	22	::1	insertar	iglesias.temp_traslados
23	\N	2021-07-04 21:34:53	admin	GATICA LARA, ROMINA	1	23	::1	insertar	iglesias.temp_traslados
24	\N	2021-07-04 21:36:49	admin	GATICA LARA, ROMINA	1	24	::1	insertar	iglesias.temp_traslados
25	\N	2021-07-04 21:36:49	admin	GATICA LARA, ROMINA	1	25	::1	insertar	iglesias.temp_traslados
26	\N	2021-07-04 21:38:38	admin	GATICA LARA, ROMINA	1	26	::1	insertar	iglesias.temp_traslados
27	\N	2021-07-04 21:38:38	admin	GATICA LARA, ROMINA	1	27	::1	insertar	iglesias.temp_traslados
28	\N	2021-07-04 21:39:14	admin	GATICA LARA, ROMINA	1	28	::1	insertar	iglesias.temp_traslados
29	\N	2021-07-04 21:39:14	admin	GATICA LARA, ROMINA	1	29	::1	insertar	iglesias.temp_traslados
30	\N	2021-07-04 21:43:37	admin	GATICA LARA, ROMINA	1	30	::1	insertar	iglesias.temp_traslados
31	\N	2021-07-04 21:43:37	admin	GATICA LARA, ROMINA	1	31	::1	insertar	iglesias.temp_traslados
32	\N	2021-07-04 21:48:00	admin	GATICA LARA, ROMINA	1	32	::1	insertar	iglesias.temp_traslados
33	\N	2021-07-04 21:48:00	admin	GATICA LARA, ROMINA	1	33	::1	insertar	iglesias.temp_traslados
34	\N	2021-07-04 21:48:34	admin	GATICA LARA, ROMINA	1	34	::1	insertar	iglesias.temp_traslados
35	\N	2021-07-04 21:48:34	admin	GATICA LARA, ROMINA	1	35	::1	insertar	iglesias.temp_traslados
36	\N	2021-07-04 21:50:45	admin	GATICA LARA, ROMINA	1	36	::1	insertar	iglesias.temp_traslados
37	\N	2021-07-04 21:50:45	admin	GATICA LARA, ROMINA	1	37	::1	insertar	iglesias.temp_traslados
38	\N	2021-07-04 21:54:38	admin	GATICA LARA, ROMINA	1	38	::1	insertar	iglesias.temp_traslados
39	\N	2021-07-04 21:54:38	admin	GATICA LARA, ROMINA	1	39	::1	insertar	iglesias.temp_traslados
40	\N	2021-07-04 21:56:11	admin	GATICA LARA, ROMINA	1	40	::1	insertar	iglesias.temp_traslados
41	\N	2021-07-04 21:56:11	admin	GATICA LARA, ROMINA	1	41	::1	insertar	iglesias.temp_traslados
42	\N	2021-07-04 21:59:16	admin	GATICA LARA, ROMINA	1	42	::1	insertar	iglesias.temp_traslados
43	\N	2021-07-04 21:59:16	admin	GATICA LARA, ROMINA	1	43	::1	insertar	iglesias.temp_traslados
44	\N	2021-07-04 22:01:32	admin	GATICA LARA, ROMINA	1	44	::1	insertar	iglesias.temp_traslados
45	\N	2021-07-04 22:01:32	admin	GATICA LARA, ROMINA	1	45	::1	insertar	iglesias.temp_traslados
46	\N	2021-07-04 22:05:29	admin	GATICA LARA, ROMINA	1	46	::1	insertar	iglesias.temp_traslados
47	\N	2021-07-04 22:05:29	admin	GATICA LARA, ROMINA	1	47	::1	insertar	iglesias.temp_traslados
48	\N	2021-07-04 22:21:41	admin	GATICA LARA, ROMINA	1	48	::1	insertar	iglesias.temp_traslados
49	\N	2021-07-04 22:21:41	admin	GATICA LARA, ROMINA	1	49	::1	insertar	iglesias.temp_traslados
50	\N	2021-07-04 22:25:55	admin	GATICA LARA, ROMINA	1	50	::1	insertar	iglesias.temp_traslados
51	\N	2021-07-04 22:25:55	admin	GATICA LARA, ROMINA	1	51	::1	insertar	iglesias.temp_traslados
52	\N	2021-07-04 22:27:23	admin	GATICA LARA, ROMINA	1	52	::1	insertar	iglesias.temp_traslados
53	\N	2021-07-04 22:27:23	admin	GATICA LARA, ROMINA	1	53	::1	insertar	iglesias.temp_traslados
54	\N	2021-07-04 22:27:28	admin	GATICA LARA, ROMINA	1	53	::1	eliminar	iglesias.temp_traslados
55	\N	2021-07-04 22:30:43	admin	GATICA LARA, ROMINA	1	54	::1	insertar	iglesias.temp_traslados
56	\N	2021-07-04 22:30:43	admin	GATICA LARA, ROMINA	1	55	::1	insertar	iglesias.temp_traslados
57	\N	2021-07-04 22:30:46	admin	GATICA LARA, ROMINA	1	55	::1	eliminar	iglesias.temp_traslados
58	\N	2021-07-04 22:30:51	admin	GATICA LARA, ROMINA	1	54	::1	eliminar	iglesias.temp_traslados
59	\N	2021-07-04 22:31:37	admin	GATICA LARA, ROMINA	1	56	::1	insertar	iglesias.temp_traslados
60	\N	2021-07-04 22:31:37	admin	GATICA LARA, ROMINA	1	57	::1	insertar	iglesias.temp_traslados
61	\N	2021-07-04 22:31:46	admin	GATICA LARA, ROMINA	1	57	::1	eliminar	iglesias.temp_traslados
62	\N	2021-07-04 22:31:48	admin	GATICA LARA, ROMINA	1	56	::1	eliminar	iglesias.temp_traslados
63	\N	2021-07-04 22:44:33	admin	GATICA LARA, ROMINA	1	58	::1	insertar	iglesias.temp_traslados
64	\N	2021-07-04 22:44:33	admin	GATICA LARA, ROMINA	1	59	::1	insertar	iglesias.temp_traslados
65	\N	2021-07-04 22:47:22	admin	GATICA LARA, ROMINA	1	60	::1	insertar	iglesias.temp_traslados
66	\N	2021-07-04 22:47:22	admin	GATICA LARA, ROMINA	1	61	::1	insertar	iglesias.temp_traslados
67	\N	2021-07-04 23:31:12	admin	GATICA LARA, ROMINA	1	62	::1	insertar	iglesias.temp_traslados
68	\N	2021-07-04 23:31:12	admin	GATICA LARA, ROMINA	1	63	::1	insertar	iglesias.temp_traslados
69	\N	2021-07-04 23:34:08	admin	GATICA LARA, ROMINA	1	64	::1	insertar	iglesias.temp_traslados
70	\N	2021-07-04 23:34:08	admin	GATICA LARA, ROMINA	1	65	::1	insertar	iglesias.temp_traslados
71	\N	2021-07-04 23:37:12	admin	GATICA LARA, ROMINA	1	66	::1	insertar	iglesias.temp_traslados
72	\N	2021-07-04 23:37:12	admin	GATICA LARA, ROMINA	1	67	::1	insertar	iglesias.temp_traslados
73	\N	2021-07-04 23:38:34	admin	GATICA LARA, ROMINA	1	68	::1	insertar	iglesias.temp_traslados
74	\N	2021-07-04 23:38:34	admin	GATICA LARA, ROMINA	1	69	::1	insertar	iglesias.temp_traslados
75	\N	2021-07-05 00:11:43	admin	GATICA LARA, ROMINA	1	70	::1	insertar	iglesias.temp_traslados
76	\N	2021-07-05 00:11:43	admin	GATICA LARA, ROMINA	1	71	::1	insertar	iglesias.temp_traslados
77	\N	2021-07-05 00:14:44	admin	GATICA LARA, ROMINA	1	72	::1	insertar	iglesias.temp_traslados
78	\N	2021-07-05 00:14:44	admin	GATICA LARA, ROMINA	1	73	::1	insertar	iglesias.temp_traslados
79	\N	2021-07-05 00:15:47	admin	GATICA LARA, ROMINA	1	74	::1	insertar	iglesias.temp_traslados
80	\N	2021-07-05 00:15:47	admin	GATICA LARA, ROMINA	1	75	::1	insertar	iglesias.temp_traslados
81	\N	2021-07-05 01:22:49	admin	GATICA LARA, ROMINA	1	76	::1	insertar	iglesias.temp_traslados
82	\N	2021-07-05 01:22:49	admin	GATICA LARA, ROMINA	1	77	::1	insertar	iglesias.temp_traslados
83	\N	2021-07-05 01:25:45	admin	GATICA LARA, ROMINA	1	78	::1	insertar	iglesias.temp_traslados
84	\N	2021-07-05 01:25:45	admin	GATICA LARA, ROMINA	1	79	::1	insertar	iglesias.temp_traslados
85	\N	2021-07-05 01:26:51	admin	GATICA LARA, ROMINA	1	80	::1	insertar	iglesias.temp_traslados
86	\N	2021-07-05 01:26:51	admin	GATICA LARA, ROMINA	1	81	::1	insertar	iglesias.temp_traslados
87	\N	2021-07-05 01:28:06	admin	GATICA LARA, ROMINA	1	82	::1	insertar	iglesias.temp_traslados
88	\N	2021-07-05 01:28:06	admin	GATICA LARA, ROMINA	1	83	::1	insertar	iglesias.temp_traslados
89	\N	2021-07-05 01:29:18	admin	GATICA LARA, ROMINA	1	84	::1	insertar	iglesias.temp_traslados
90	\N	2021-07-05 01:29:18	admin	GATICA LARA, ROMINA	1	85	::1	insertar	iglesias.temp_traslados
91	\N	2021-07-05 01:29:20	admin	GATICA LARA, ROMINA	1	1	::1	insertar	iglesias.historial_traslados
92	\N	2021-07-05 01:29:20	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
93	\N	2021-07-05 01:29:20	admin	GATICA LARA, ROMINA	1	2	::1	insertar	iglesias.historial_traslados
94	\N	2021-07-05 01:29:20	admin	GATICA LARA, ROMINA	1	5	::1	modificar	iglesias.miembro
95	\N	2021-07-05 01:47:02	admin	GATICA LARA, ROMINA	1	86	::1	insertar	iglesias.temp_traslados
96	\N	2021-07-05 01:47:02	admin	GATICA LARA, ROMINA	1	87	::1	insertar	iglesias.temp_traslados
97	\N	2021-07-05 01:47:14	admin	GATICA LARA, ROMINA	1	88	::1	insertar	iglesias.temp_traslados
98	\N	2021-07-05 01:47:14	admin	GATICA LARA, ROMINA	1	89	::1	insertar	iglesias.temp_traslados
99	\N	2021-07-05 01:48:24	admin	GATICA LARA, ROMINA	1	90	::1	insertar	iglesias.temp_traslados
100	\N	2021-07-05 01:48:24	admin	GATICA LARA, ROMINA	1	91	::1	insertar	iglesias.temp_traslados
101	\N	2021-07-05 01:50:54	admin	GATICA LARA, ROMINA	1	92	::1	insertar	iglesias.temp_traslados
102	\N	2021-07-05 01:50:54	admin	GATICA LARA, ROMINA	1	93	::1	insertar	iglesias.temp_traslados
103	\N	2021-07-05 01:50:58	admin	GATICA LARA, ROMINA	1	94	::1	insertar	iglesias.temp_traslados
104	\N	2021-07-05 01:50:58	admin	GATICA LARA, ROMINA	1	95	::1	insertar	iglesias.temp_traslados
105	\N	2021-07-05 01:53:08	admin	GATICA LARA, ROMINA	1	96	::1	insertar	iglesias.temp_traslados
106	\N	2021-07-05 01:53:08	admin	GATICA LARA, ROMINA	1	97	::1	insertar	iglesias.temp_traslados
107	\N	2021-07-05 01:53:14	admin	GATICA LARA, ROMINA	1	98	::1	insertar	iglesias.temp_traslados
108	\N	2021-07-05 01:53:14	admin	GATICA LARA, ROMINA	1	99	::1	insertar	iglesias.temp_traslados
109	\N	2021-07-05 02:22:32	admin	GATICA LARA, ROMINA	1	100	::1	insertar	iglesias.temp_traslados
110	\N	2021-07-05 02:22:32	admin	GATICA LARA, ROMINA	1	101	::1	insertar	iglesias.temp_traslados
111	\N	2021-07-05 02:23:25	admin	GATICA LARA, ROMINA	1	3	::1	insertar	iglesias.historial_traslados
112	\N	2021-07-05 02:23:25	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
113	\N	2021-07-05 02:23:25	admin	GATICA LARA, ROMINA	1	4	::1	insertar	iglesias.historial_traslados
114	\N	2021-07-05 02:23:25	admin	GATICA LARA, ROMINA	1	5	::1	modificar	iglesias.miembro
115	\N	2021-07-05 04:02:59	admin	GATICA LARA, ROMINA	1	102	::1	insertar	iglesias.temp_traslados
116	\N	2021-07-05 04:14:07	admin	GATICA LARA, ROMINA	1	104	::1	insertar	iglesias.temp_traslados
117	\N	2021-07-05 04:14:55	admin	GATICA LARA, ROMINA	1	105	::1	insertar	iglesias.temp_traslados
118	\N	2021-07-05 04:15:01	admin	GATICA LARA, ROMINA	1	106	::1	insertar	iglesias.temp_traslados
119	\N	2021-07-05 04:16:00	admin	GATICA LARA, ROMINA	1	107	::1	insertar	iglesias.temp_traslados
120	\N	2021-07-05 04:16:02	admin	GATICA LARA, ROMINA	1	108	::1	insertar	iglesias.temp_traslados
121	\N	2021-07-05 04:16:05	admin	GATICA LARA, ROMINA	1	109	::1	insertar	iglesias.temp_traslados
122	\N	2021-07-05 04:16:07	admin	GATICA LARA, ROMINA	1	110	::1	insertar	iglesias.temp_traslados
123	\N	2021-07-05 04:16:08	admin	GATICA LARA, ROMINA	1	111	::1	insertar	iglesias.temp_traslados
124	\N	2021-07-05 04:16:10	admin	GATICA LARA, ROMINA	1	112	::1	insertar	iglesias.temp_traslados
125	\N	2021-07-05 04:16:12	admin	GATICA LARA, ROMINA	1	113	::1	insertar	iglesias.temp_traslados
126	\N	2021-07-05 21:18:15	admin	GATICA LARA, ROMINA	1	114	::1	insertar	iglesias.temp_traslados
127	\N	2021-07-05 21:34:59	admin	GATICA LARA, ROMINA	1	108	::1	eliminar	iglesias.temp_traslados
128	\N	2021-07-05 21:35:00	admin	GATICA LARA, ROMINA	1	110	::1	eliminar	iglesias.temp_traslados
129	\N	2021-07-05 21:35:02	admin	GATICA LARA, ROMINA	1	111	::1	eliminar	iglesias.temp_traslados
130	\N	2021-07-05 21:35:03	admin	GATICA LARA, ROMINA	1	112	::1	eliminar	iglesias.temp_traslados
131	\N	2021-07-05 21:35:09	admin	GATICA LARA, ROMINA	1	115	::1	insertar	iglesias.temp_traslados
132	\N	2021-07-05 21:55:14	admin	GATICA LARA, ROMINA	1	5	::1	insertar	iglesias.historial_traslados
133	\N	2021-07-05 21:55:14	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
134	\N	2021-07-05 21:55:14	admin	GATICA LARA, ROMINA	1	6	::1	insertar	iglesias.historial_traslados
135	\N	2021-07-05 21:55:14	admin	GATICA LARA, ROMINA	1	3	::1	modificar	iglesias.miembro
136	\N	2021-07-05 22:20:21	admin	GATICA LARA, ROMINA	1	116	::1	insertar	iglesias.temp_traslados
137	\N	2021-07-05 22:20:22	admin	GATICA LARA, ROMINA	1	117	::1	insertar	iglesias.temp_traslados
138	\N	2021-07-05 22:20:33	admin	GATICA LARA, ROMINA	1	7	::1	insertar	iglesias.historial_traslados
139	\N	2021-07-05 22:20:33	admin	GATICA LARA, ROMINA	1	8	::1	insertar	iglesias.historial_traslados
140	\N	2021-07-05 22:23:33	admin	GATICA LARA, ROMINA	1	118	::1	insertar	iglesias.temp_traslados
141	\N	2021-07-05 22:23:34	admin	GATICA LARA, ROMINA	1	119	::1	insertar	iglesias.temp_traslados
142	\N	2021-07-05 22:23:45	admin	GATICA LARA, ROMINA	1	9	::1	insertar	iglesias.historial_traslados
143	\N	2021-07-05 22:23:45	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
144	\N	2021-07-05 22:23:45	admin	GATICA LARA, ROMINA	1	10	::1	insertar	iglesias.historial_traslados
145	\N	2021-07-05 22:23:45	admin	GATICA LARA, ROMINA	1	7	::1	modificar	iglesias.miembro
146	\N	2021-07-05 22:24:49	admin	GATICA LARA, ROMINA	1	120	::1	insertar	iglesias.temp_traslados
147	\N	2021-07-05 22:27:11	admin	GATICA LARA, ROMINA	1	121	::1	insertar	iglesias.temp_traslados
148	\N	2021-07-05 22:27:11	admin	GATICA LARA, ROMINA	1	122	::1	insertar	iglesias.temp_traslados
149	\N	2021-07-05 22:35:31	admin	GATICA LARA, ROMINA	1	9	::1	modificar	iglesias.paises
150	\N	2021-07-05 22:35:50	admin	GATICA LARA, ROMINA	1	31	::1	insertar	public.departamento
151	\N	2021-07-05 22:36:14	admin	GATICA LARA, ROMINA	1	202	::1	insertar	public.provincia
152	\N	2021-07-05 22:36:47	admin	GATICA LARA, ROMINA	1	1424	::1	modificar	iglesias.iglesia
153	\N	2021-07-05 22:37:24	admin	GATICA LARA, ROMINA	1	11	::1	insertar	iglesias.historial_traslados
154	\N	2021-07-05 22:37:24	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
155	\N	2021-07-05 22:37:24	admin	GATICA LARA, ROMINA	1	12	::1	insertar	iglesias.historial_traslados
156	\N	2021-07-05 22:37:24	admin	GATICA LARA, ROMINA	1	7	::1	modificar	iglesias.miembro
157	\N	2021-07-05 22:41:00	admin	GATICA LARA, ROMINA	1	123	::1	insertar	iglesias.temp_traslados
158	\N	2021-07-05 22:41:00	admin	GATICA LARA, ROMINA	1	124	::1	insertar	iglesias.temp_traslados
159	\N	2021-07-05 22:41:20	admin	GATICA LARA, ROMINA	1	13	::1	insertar	iglesias.historial_traslados
160	\N	2021-07-05 22:41:20	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
161	\N	2021-07-05 22:41:20	admin	GATICA LARA, ROMINA	1	14	::1	insertar	iglesias.historial_traslados
162	\N	2021-07-05 22:41:20	admin	GATICA LARA, ROMINA	1	7	::1	modificar	iglesias.miembro
163	\N	2021-07-05 22:54:26	admin	GATICA LARA, ROMINA	1	125	::1	insertar	iglesias.temp_traslados
164	\N	2021-07-05 22:54:28	admin	GATICA LARA, ROMINA	1	126	::1	insertar	iglesias.temp_traslados
165	\N	2021-07-05 23:01:42	admin	GATICA LARA, ROMINA	1	125	::1	eliminar	iglesias.temp_traslados
166	\N	2021-07-05 23:01:44	admin	GATICA LARA, ROMINA	1	130	::1	insertar	iglesias.temp_traslados
167	\N	2021-07-05 23:03:06	admin	GATICA LARA, ROMINA	1	126	::1	eliminar	iglesias.temp_traslados
168	\N	2021-07-05 23:03:10	admin	GATICA LARA, ROMINA	1	131	::1	insertar	iglesias.temp_traslados
169	\N	2021-07-05 23:03:13	admin	GATICA LARA, ROMINA	1	132	::1	insertar	iglesias.temp_traslados
170	\N	2021-07-06 02:41:08	admin	GATICA LARA, ROMINA	1	1	::1	insertar	iglesias.control_traslados
171	\N	2021-07-06 02:41:08	admin	GATICA LARA, ROMINA	1	1	::1	modificar	iglesias.control_traslados
172	\N	2021-07-06 02:49:53	admin	GATICA LARA, ROMINA	1	133	::1	insertar	iglesias.temp_traslados
173	\N	2021-07-06 02:50:17	admin	GATICA LARA, ROMINA	1	2	::1	insertar	iglesias.control_traslados
174	\N	2021-07-06 02:51:37	admin	GATICA LARA, ROMINA	1	3	::1	insertar	iglesias.control_traslados
175	\N	2021-07-06 02:51:37	admin	GATICA LARA, ROMINA	1	3	::1	modificar	iglesias.control_traslados
176	\N	2021-07-06 04:32:07	admin	GATICA LARA, ROMINA	1	134	::1	insertar	iglesias.temp_traslados
177	\N	2021-07-06 04:32:27	admin	GATICA LARA, ROMINA	1	4	::1	insertar	iglesias.control_traslados
178	\N	2021-07-06 04:32:27	admin	GATICA LARA, ROMINA	1	4	::1	modificar	iglesias.control_traslados
179	\N	2021-07-06 04:36:35	admin	GATICA LARA, ROMINA	1	15	::1	insertar	iglesias.historial_traslados
180	\N	2021-07-06 04:38:27	admin	GATICA LARA, ROMINA	1	4	::1	modificar	iglesias.control_traslados
181	\N	2021-07-06 04:38:27	admin	GATICA LARA, ROMINA	1	16	::1	insertar	iglesias.historial_traslados
182	\N	2021-07-06 04:38:27	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
183	\N	2021-07-06 04:40:54	admin	GATICA LARA, ROMINA	1	4	::1	modificar	iglesias.control_traslados
184	\N	2021-07-06 04:40:54	admin	GATICA LARA, ROMINA	1	17	::1	insertar	iglesias.historial_traslados
185	\N	2021-07-06 04:40:54	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
186	\N	2021-07-06 04:41:33	admin	GATICA LARA, ROMINA	1	4	::1	modificar	iglesias.control_traslados
187	\N	2021-07-06 04:41:33	admin	GATICA LARA, ROMINA	1	18	::1	insertar	iglesias.historial_traslados
188	\N	2021-07-06 04:41:33	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
189	\N	2021-07-06 04:51:08	admin	GATICA LARA, ROMINA	1	4	::1	modificar	iglesias.control_traslados
190	\N	2021-07-06 04:51:08	admin	GATICA LARA, ROMINA	1	19	::1	insertar	iglesias.historial_traslados
191	\N	2021-07-06 04:51:08	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
192	\N	2021-07-06 04:54:43	admin	GATICA LARA, ROMINA	1	4	::1	modificar	iglesias.control_traslados
193	\N	2021-07-06 04:54:43	admin	GATICA LARA, ROMINA	1	20	::1	insertar	iglesias.historial_traslados
194	\N	2021-07-06 04:54:43	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
195	\N	2021-07-06 04:55:57	admin	GATICA LARA, ROMINA	1	4	::1	modificar	iglesias.control_traslados
196	\N	2021-07-06 04:55:57	admin	GATICA LARA, ROMINA	1	21	::1	insertar	iglesias.historial_traslados
197	\N	2021-07-06 04:55:57	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
198	\N	2021-07-06 13:49:18	admin	GATICA LARA, ROMINA	1	30	::1	modificar	seguridad.modulos
211	\N	2021-07-07 02:12:26	admin	GATICA LARA, ROMINA	1	7	::1	modificar	iglesias.miembro
212	\N	2021-07-07 02:12:52	admin	GATICA LARA, ROMINA	1	7	::1	modificar	iglesias.miembro
213	\N	2021-07-07 03:52:20	admin	GATICA LARA, ROMINA	1	2	::1	insertar	iglesias.controlactmisionera
214	\N	2021-07-07 03:52:20	admin	GATICA LARA, ROMINA	1	1	::1	insertar	iglesias.controlactmisionera
215	\N	2021-07-07 03:52:50	admin	GATICA LARA, ROMINA	1	3	::1	insertar	iglesias.controlactmisionera
216	\N	2021-07-07 03:52:50	admin	GATICA LARA, ROMINA	1	4	::1	insertar	iglesias.controlactmisionera
217	\N	2021-07-07 03:52:51	admin	GATICA LARA, ROMINA	1	5	::1	insertar	iglesias.controlactmisionera
218	\N	2021-07-07 03:52:51	admin	GATICA LARA, ROMINA	1	6	::1	insertar	iglesias.controlactmisionera
219	\N	2021-07-07 03:52:52	admin	GATICA LARA, ROMINA	1	7	::1	insertar	iglesias.controlactmisionera
220	\N	2021-07-07 03:52:52	admin	GATICA LARA, ROMINA	1	8	::1	insertar	iglesias.controlactmisionera
221	\N	2021-07-07 03:52:53	admin	GATICA LARA, ROMINA	1	9	::1	insertar	iglesias.controlactmisionera
222	\N	2021-07-07 03:52:53	admin	GATICA LARA, ROMINA	1	10	::1	insertar	iglesias.controlactmisionera
223	\N	2021-07-07 03:52:53	admin	GATICA LARA, ROMINA	1	11	::1	insertar	iglesias.controlactmisionera
224	\N	2021-07-07 03:52:53	admin	GATICA LARA, ROMINA	1	12	::1	insertar	iglesias.controlactmisionera
225	\N	2021-07-07 03:52:54	admin	GATICA LARA, ROMINA	1	13	::1	insertar	iglesias.controlactmisionera
226	\N	2021-07-07 03:52:54	admin	GATICA LARA, ROMINA	1	14	::1	insertar	iglesias.controlactmisionera
227	\N	2021-07-07 03:52:54	admin	GATICA LARA, ROMINA	1	15	::1	insertar	iglesias.controlactmisionera
228	\N	2021-07-07 03:52:54	admin	GATICA LARA, ROMINA	1	16	::1	insertar	iglesias.controlactmisionera
229	\N	2021-07-07 03:52:55	admin	GATICA LARA, ROMINA	1	17	::1	insertar	iglesias.controlactmisionera
230	\N	2021-07-07 03:52:55	admin	GATICA LARA, ROMINA	1	18	::1	insertar	iglesias.controlactmisionera
231	\N	2021-07-07 03:52:55	admin	GATICA LARA, ROMINA	1	19	::1	insertar	iglesias.controlactmisionera
232	\N	2021-07-07 03:52:55	admin	GATICA LARA, ROMINA	1	20	::1	insertar	iglesias.controlactmisionera
233	\N	2021-07-07 03:52:57	admin	GATICA LARA, ROMINA	1	21	::1	insertar	iglesias.controlactmisionera
234	\N	2021-07-07 03:52:57	admin	GATICA LARA, ROMINA	1	22	::1	insertar	iglesias.controlactmisionera
235	\N	2021-07-07 03:52:57	admin	GATICA LARA, ROMINA	1	23	::1	insertar	iglesias.controlactmisionera
236	\N	2021-07-07 03:52:57	admin	GATICA LARA, ROMINA	1	24	::1	insertar	iglesias.controlactmisionera
237	\N	2021-07-07 03:52:57	admin	GATICA LARA, ROMINA	1	25	::1	insertar	iglesias.controlactmisionera
238	\N	2021-07-07 03:52:58	admin	GATICA LARA, ROMINA	1	26	::1	insertar	iglesias.controlactmisionera
239	\N	2021-07-07 03:52:58	admin	GATICA LARA, ROMINA	1	27	::1	insertar	iglesias.controlactmisionera
240	\N	2021-07-07 03:52:58	admin	GATICA LARA, ROMINA	1	28	::1	insertar	iglesias.controlactmisionera
241	\N	2021-07-07 03:53:00	admin	GATICA LARA, ROMINA	1	29	::1	insertar	iglesias.controlactmisionera
242	\N	2021-07-07 03:53:00	admin	GATICA LARA, ROMINA	1	30	::1	insertar	iglesias.controlactmisionera
243	\N	2021-07-07 03:53:01	admin	GATICA LARA, ROMINA	1	31	::1	insertar	iglesias.controlactmisionera
244	\N	2021-07-07 03:53:01	admin	GATICA LARA, ROMINA	1	32	::1	insertar	iglesias.controlactmisionera
245	\N	2021-07-07 03:53:01	admin	GATICA LARA, ROMINA	1	33	::1	insertar	iglesias.controlactmisionera
246	\N	2021-07-07 03:53:01	admin	GATICA LARA, ROMINA	1	34	::1	insertar	iglesias.controlactmisionera
247	\N	2021-07-07 03:53:02	admin	GATICA LARA, ROMINA	1	35	::1	insertar	iglesias.controlactmisionera
248	\N	2021-07-07 03:53:02	admin	GATICA LARA, ROMINA	1	36	::1	insertar	iglesias.controlactmisionera
249	\N	2021-07-07 03:53:03	admin	GATICA LARA, ROMINA	1	37	::1	insertar	iglesias.controlactmisionera
250	\N	2021-07-07 03:53:03	admin	GATICA LARA, ROMINA	1	38	::1	insertar	iglesias.controlactmisionera
251	\N	2021-07-07 03:53:04	admin	GATICA LARA, ROMINA	1	39	::1	insertar	iglesias.controlactmisionera
252	\N	2021-07-07 03:53:04	admin	GATICA LARA, ROMINA	1	40	::1	insertar	iglesias.controlactmisionera
253	\N	2021-07-07 03:53:04	admin	GATICA LARA, ROMINA	1	41	::1	insertar	iglesias.controlactmisionera
254	\N	2021-07-07 03:53:04	admin	GATICA LARA, ROMINA	1	42	::1	insertar	iglesias.controlactmisionera
255	\N	2021-07-07 03:53:05	admin	GATICA LARA, ROMINA	1	43	::1	insertar	iglesias.controlactmisionera
256	\N	2021-07-07 03:53:05	admin	GATICA LARA, ROMINA	1	44	::1	insertar	iglesias.controlactmisionera
257	\N	2021-07-07 03:53:05	admin	GATICA LARA, ROMINA	1	45	::1	insertar	iglesias.controlactmisionera
258	\N	2021-07-07 03:53:05	admin	GATICA LARA, ROMINA	1	46	::1	insertar	iglesias.controlactmisionera
259	\N	2021-07-07 03:53:06	admin	GATICA LARA, ROMINA	1	47	::1	insertar	iglesias.controlactmisionera
260	\N	2021-07-07 03:53:06	admin	GATICA LARA, ROMINA	1	48	::1	insertar	iglesias.controlactmisionera
261	\N	2021-07-07 03:53:07	admin	GATICA LARA, ROMINA	1	49	::1	insertar	iglesias.controlactmisionera
262	\N	2021-07-07 03:53:07	admin	GATICA LARA, ROMINA	1	50	::1	insertar	iglesias.controlactmisionera
263	\N	2021-07-07 03:53:07	admin	GATICA LARA, ROMINA	1	51	::1	insertar	iglesias.controlactmisionera
264	\N	2021-07-07 03:53:07	admin	GATICA LARA, ROMINA	1	52	::1	insertar	iglesias.controlactmisionera
265	\N	2021-07-07 03:53:08	admin	GATICA LARA, ROMINA	1	53	::1	insertar	iglesias.controlactmisionera
266	\N	2021-07-07 03:53:08	admin	GATICA LARA, ROMINA	1	54	::1	insertar	iglesias.controlactmisionera
267	\N	2021-07-07 03:53:09	admin	GATICA LARA, ROMINA	1	55	::1	insertar	iglesias.controlactmisionera
268	\N	2021-07-07 03:53:09	admin	GATICA LARA, ROMINA	1	56	::1	insertar	iglesias.controlactmisionera
269	\N	2021-07-07 03:53:09	admin	GATICA LARA, ROMINA	1	57	::1	insertar	iglesias.controlactmisionera
270	\N	2021-07-07 03:53:09	admin	GATICA LARA, ROMINA	1	58	::1	insertar	iglesias.controlactmisionera
271	\N	2021-07-07 03:53:10	admin	GATICA LARA, ROMINA	1	59	::1	insertar	iglesias.controlactmisionera
272	\N	2021-07-07 03:53:10	admin	GATICA LARA, ROMINA	1	60	::1	insertar	iglesias.controlactmisionera
273	\N	2021-07-07 03:53:11	admin	GATICA LARA, ROMINA	1	61	::1	insertar	iglesias.controlactmisionera
274	\N	2021-07-07 03:53:11	admin	GATICA LARA, ROMINA	1	62	::1	insertar	iglesias.controlactmisionera
275	\N	2021-07-07 03:53:11	admin	GATICA LARA, ROMINA	1	63	::1	insertar	iglesias.controlactmisionera
276	\N	2021-07-07 03:53:11	admin	GATICA LARA, ROMINA	1	64	::1	insertar	iglesias.controlactmisionera
277	\N	2021-07-07 03:53:12	admin	GATICA LARA, ROMINA	1	65	::1	insertar	iglesias.controlactmisionera
278	\N	2021-07-07 03:53:12	admin	GATICA LARA, ROMINA	1	66	::1	insertar	iglesias.controlactmisionera
279	\N	2021-07-07 03:53:12	admin	GATICA LARA, ROMINA	1	67	::1	insertar	iglesias.controlactmisionera
280	\N	2021-07-07 03:53:12	admin	GATICA LARA, ROMINA	1	68	::1	insertar	iglesias.controlactmisionera
281	\N	2021-07-07 03:53:13	admin	GATICA LARA, ROMINA	1	69	::1	insertar	iglesias.controlactmisionera
282	\N	2021-07-07 03:53:13	admin	GATICA LARA, ROMINA	1	70	::1	insertar	iglesias.controlactmisionera
283	\N	2021-07-07 03:54:18	admin	GATICA LARA, ROMINA	1	71	::1	insertar	iglesias.controlactmisionera
284	\N	2021-07-07 03:54:18	admin	GATICA LARA, ROMINA	1	72	::1	insertar	iglesias.controlactmisionera
285	\N	2021-07-07 03:54:27	admin	GATICA LARA, ROMINA	1	73	::1	insertar	iglesias.controlactmisionera
286	\N	2021-07-07 03:54:27	admin	GATICA LARA, ROMINA	1	74	::1	insertar	iglesias.controlactmisionera
287	\N	2021-07-07 03:54:28	admin	GATICA LARA, ROMINA	1	75	::1	insertar	iglesias.controlactmisionera
288	\N	2021-07-07 03:54:28	admin	GATICA LARA, ROMINA	1	76	::1	insertar	iglesias.controlactmisionera
289	\N	2021-07-07 03:54:29	admin	GATICA LARA, ROMINA	1	77	::1	insertar	iglesias.controlactmisionera
290	\N	2021-07-07 03:54:29	admin	GATICA LARA, ROMINA	1	78	::1	insertar	iglesias.controlactmisionera
291	\N	2021-07-07 03:54:30	admin	GATICA LARA, ROMINA	1	79	::1	insertar	iglesias.controlactmisionera
292	\N	2021-07-07 03:54:31	admin	GATICA LARA, ROMINA	1	80	::1	insertar	iglesias.controlactmisionera
293	\N	2021-07-07 03:54:32	admin	GATICA LARA, ROMINA	1	81	::1	insertar	iglesias.controlactmisionera
294	\N	2021-07-07 03:54:35	admin	GATICA LARA, ROMINA	1	82	::1	insertar	iglesias.controlactmisionera
295	\N	2021-07-07 03:54:36	admin	GATICA LARA, ROMINA	1	83	::1	insertar	iglesias.controlactmisionera
296	\N	2021-07-07 03:54:42	admin	GATICA LARA, ROMINA	1	84	::1	insertar	iglesias.controlactmisionera
297	\N	2021-07-07 03:55:40	admin	GATICA LARA, ROMINA	1	85	::1	insertar	iglesias.controlactmisionera
298	\N	2021-07-07 03:57:21	admin	GATICA LARA, ROMINA	1	86	::1	insertar	iglesias.controlactmisionera
299	\N	2021-07-07 03:57:21	admin	GATICA LARA, ROMINA	1	87	::1	insertar	iglesias.controlactmisionera
300	\N	2021-07-07 03:57:22	admin	GATICA LARA, ROMINA	1	88	::1	insertar	iglesias.controlactmisionera
301	\N	2021-07-07 03:57:23	admin	GATICA LARA, ROMINA	1	89	::1	insertar	iglesias.controlactmisionera
302	\N	2021-07-07 03:57:27	admin	GATICA LARA, ROMINA	1	90	::1	insertar	iglesias.controlactmisionera
303	\N	2021-07-07 03:57:32	admin	GATICA LARA, ROMINA	1	91	::1	insertar	iglesias.controlactmisionera
304	\N	2021-07-08 01:24:45	admin	GATICA LARA, ROMINA	1	7	::1	modificar	iglesias.miembro
305	\N	2021-07-08 03:48:05	admin	GATICA LARA, ROMINA	1	92	::1	insertar	iglesias.controlactmisionera
306	\N	2021-07-08 03:48:06	admin	GATICA LARA, ROMINA	1	93	::1	insertar	iglesias.controlactmisionera
307	\N	2021-07-08 03:48:06	admin	GATICA LARA, ROMINA	1	94	::1	insertar	iglesias.controlactmisionera
308	\N	2021-07-08 03:48:07	admin	GATICA LARA, ROMINA	1	95	::1	insertar	iglesias.controlactmisionera
309	\N	2021-07-08 03:48:08	admin	GATICA LARA, ROMINA	1	96	::1	insertar	iglesias.controlactmisionera
310	\N	2021-07-08 03:48:08	admin	GATICA LARA, ROMINA	1	97	::1	insertar	iglesias.controlactmisionera
311	\N	2021-07-08 03:48:09	admin	GATICA LARA, ROMINA	1	98	::1	insertar	iglesias.controlactmisionera
312	\N	2021-07-08 03:48:10	admin	GATICA LARA, ROMINA	1	99	::1	insertar	iglesias.controlactmisionera
313	\N	2021-07-08 03:48:11	admin	GATICA LARA, ROMINA	1	100	::1	insertar	iglesias.controlactmisionera
314	\N	2021-07-08 03:48:12	admin	GATICA LARA, ROMINA	1	101	::1	insertar	iglesias.controlactmisionera
315	\N	2021-07-08 03:48:13	admin	GATICA LARA, ROMINA	1	102	::1	insertar	iglesias.controlactmisionera
316	\N	2021-07-08 03:48:14	admin	GATICA LARA, ROMINA	1	103	::1	insertar	iglesias.controlactmisionera
317	\N	2021-07-08 03:48:16	admin	GATICA LARA, ROMINA	1	104	::1	insertar	iglesias.controlactmisionera
318	\N	2021-07-08 03:48:17	admin	GATICA LARA, ROMINA	1	105	::1	insertar	iglesias.controlactmisionera
319	\N	2021-07-08 03:48:18	admin	GATICA LARA, ROMINA	1	106	::1	insertar	iglesias.controlactmisionera
320	\N	2021-07-08 03:48:19	admin	GATICA LARA, ROMINA	1	107	::1	insertar	iglesias.controlactmisionera
321	\N	2021-07-08 03:48:36	admin	GATICA LARA, ROMINA	1	108	::1	insertar	iglesias.controlactmisionera
322	\N	2021-07-08 03:48:36	admin	GATICA LARA, ROMINA	1	109	::1	insertar	iglesias.controlactmisionera
323	\N	2021-07-08 03:48:36	admin	GATICA LARA, ROMINA	1	110	::1	insertar	iglesias.controlactmisionera
324	\N	2021-07-08 03:48:36	admin	GATICA LARA, ROMINA	1	111	::1	insertar	iglesias.controlactmisionera
325	\N	2021-07-08 03:48:36	admin	GATICA LARA, ROMINA	1	112	::1	insertar	iglesias.controlactmisionera
326	\N	2021-07-08 03:48:36	admin	GATICA LARA, ROMINA	1	113	::1	insertar	iglesias.controlactmisionera
327	\N	2021-07-08 03:48:36	admin	GATICA LARA, ROMINA	1	114	::1	insertar	iglesias.controlactmisionera
328	\N	2021-07-08 03:48:36	admin	GATICA LARA, ROMINA	1	115	::1	insertar	iglesias.controlactmisionera
329	\N	2021-07-08 03:48:36	admin	GATICA LARA, ROMINA	1	116	::1	insertar	iglesias.controlactmisionera
330	\N	2021-07-08 03:48:37	admin	GATICA LARA, ROMINA	1	117	::1	insertar	iglesias.controlactmisionera
331	\N	2021-07-08 03:48:37	admin	GATICA LARA, ROMINA	1	118	::1	insertar	iglesias.controlactmisionera
332	\N	2021-07-08 03:48:37	admin	GATICA LARA, ROMINA	1	119	::1	insertar	iglesias.controlactmisionera
333	\N	2021-07-08 03:48:38	admin	GATICA LARA, ROMINA	1	120	::1	insertar	iglesias.controlactmisionera
334	\N	2021-07-08 03:48:38	admin	GATICA LARA, ROMINA	1	122	::1	insertar	iglesias.controlactmisionera
335	\N	2021-07-08 03:48:38	admin	GATICA LARA, ROMINA	1	121	::1	insertar	iglesias.controlactmisionera
336	\N	2021-07-08 03:48:38	admin	GATICA LARA, ROMINA	1	123	::1	insertar	iglesias.controlactmisionera
337	\N	2021-07-08 03:48:39	admin	GATICA LARA, ROMINA	1	124	::1	insertar	iglesias.controlactmisionera
338	\N	2021-07-08 03:48:39	admin	GATICA LARA, ROMINA	1	125	::1	insertar	iglesias.controlactmisionera
339	\N	2021-07-08 03:48:39	admin	GATICA LARA, ROMINA	1	126	::1	insertar	iglesias.controlactmisionera
340	\N	2021-07-08 03:48:39	admin	GATICA LARA, ROMINA	1	127	::1	insertar	iglesias.controlactmisionera
341	\N	2021-07-08 03:48:39	admin	GATICA LARA, ROMINA	1	128	::1	insertar	iglesias.controlactmisionera
342	\N	2021-07-08 03:48:39	admin	GATICA LARA, ROMINA	1	129	::1	insertar	iglesias.controlactmisionera
343	\N	2021-07-08 03:48:40	admin	GATICA LARA, ROMINA	1	130	::1	insertar	iglesias.controlactmisionera
344	\N	2021-07-08 03:48:40	admin	GATICA LARA, ROMINA	1	131	::1	insertar	iglesias.controlactmisionera
345	\N	2021-07-08 03:48:40	admin	GATICA LARA, ROMINA	1	132	::1	insertar	iglesias.controlactmisionera
346	\N	2021-07-08 03:48:40	admin	GATICA LARA, ROMINA	1	133	::1	insertar	iglesias.controlactmisionera
347	\N	2021-07-08 03:48:40	admin	GATICA LARA, ROMINA	1	134	::1	insertar	iglesias.controlactmisionera
348	\N	2021-07-08 03:48:40	admin	GATICA LARA, ROMINA	1	135	::1	insertar	iglesias.controlactmisionera
349	\N	2021-07-08 03:48:42	admin	GATICA LARA, ROMINA	1	136	::1	insertar	iglesias.controlactmisionera
350	\N	2021-07-08 03:48:42	admin	GATICA LARA, ROMINA	1	137	::1	insertar	iglesias.controlactmisionera
351	\N	2021-07-08 03:48:42	admin	GATICA LARA, ROMINA	1	138	::1	insertar	iglesias.controlactmisionera
352	\N	2021-07-08 03:50:25	admin	GATICA LARA, ROMINA	1	139	::1	insertar	iglesias.controlactmisionera
353	\N	2021-07-08 03:50:25	admin	GATICA LARA, ROMINA	1	140	::1	insertar	iglesias.controlactmisionera
354	\N	2021-07-08 03:50:25	admin	GATICA LARA, ROMINA	1	141	::1	insertar	iglesias.controlactmisionera
355	\N	2021-07-08 03:50:25	admin	GATICA LARA, ROMINA	1	142	::1	insertar	iglesias.controlactmisionera
356	\N	2021-07-08 03:50:25	admin	GATICA LARA, ROMINA	1	143	::1	insertar	iglesias.controlactmisionera
357	\N	2021-07-08 03:50:25	admin	GATICA LARA, ROMINA	1	144	::1	insertar	iglesias.controlactmisionera
358	\N	2021-07-08 03:50:25	admin	GATICA LARA, ROMINA	1	145	::1	insertar	iglesias.controlactmisionera
359	\N	2021-07-08 03:50:34	admin	GATICA LARA, ROMINA	1	146	::1	insertar	iglesias.controlactmisionera
360	\N	2021-07-08 03:50:34	admin	GATICA LARA, ROMINA	1	147	::1	insertar	iglesias.controlactmisionera
361	\N	2021-07-08 03:50:34	admin	GATICA LARA, ROMINA	1	148	::1	insertar	iglesias.controlactmisionera
362	\N	2021-07-08 03:50:34	admin	GATICA LARA, ROMINA	1	150	::1	insertar	iglesias.controlactmisionera
363	\N	2021-07-08 03:50:34	admin	GATICA LARA, ROMINA	1	149	::1	insertar	iglesias.controlactmisionera
364	\N	2021-07-08 03:50:34	admin	GATICA LARA, ROMINA	1	151	::1	insertar	iglesias.controlactmisionera
365	\N	2021-07-08 03:50:34	admin	GATICA LARA, ROMINA	1	152	::1	insertar	iglesias.controlactmisionera
366	\N	2021-07-08 03:52:34	admin	GATICA LARA, ROMINA	1	153	::1	insertar	iglesias.controlactmisionera
367	\N	2021-07-08 03:52:34	admin	GATICA LARA, ROMINA	1	154	::1	insertar	iglesias.controlactmisionera
368	\N	2021-07-08 03:52:34	admin	GATICA LARA, ROMINA	1	155	::1	insertar	iglesias.controlactmisionera
369	\N	2021-07-08 03:52:34	admin	GATICA LARA, ROMINA	1	156	::1	insertar	iglesias.controlactmisionera
370	\N	2021-07-08 03:52:34	admin	GATICA LARA, ROMINA	1	157	::1	insertar	iglesias.controlactmisionera
371	\N	2021-07-08 03:52:34	admin	GATICA LARA, ROMINA	1	158	::1	insertar	iglesias.controlactmisionera
372	\N	2021-07-08 03:52:34	admin	GATICA LARA, ROMINA	1	159	::1	insertar	iglesias.controlactmisionera
373	\N	2021-07-08 03:52:39	admin	GATICA LARA, ROMINA	1	160	::1	insertar	iglesias.controlactmisionera
374	\N	2021-07-08 03:52:39	admin	GATICA LARA, ROMINA	1	161	::1	insertar	iglesias.controlactmisionera
375	\N	2021-07-08 03:52:39	admin	GATICA LARA, ROMINA	1	162	::1	insertar	iglesias.controlactmisionera
376	\N	2021-07-08 03:52:39	admin	GATICA LARA, ROMINA	1	163	::1	insertar	iglesias.controlactmisionera
377	\N	2021-07-08 03:52:39	admin	GATICA LARA, ROMINA	1	164	::1	insertar	iglesias.controlactmisionera
378	\N	2021-07-08 03:52:39	admin	GATICA LARA, ROMINA	1	165	::1	insertar	iglesias.controlactmisionera
379	\N	2021-07-08 03:52:39	admin	GATICA LARA, ROMINA	1	166	::1	insertar	iglesias.controlactmisionera
380	\N	2021-07-08 03:53:47	admin	GATICA LARA, ROMINA	1	167	::1	insertar	iglesias.controlactmisionera
381	\N	2021-07-08 03:53:47	admin	GATICA LARA, ROMINA	1	168	::1	insertar	iglesias.controlactmisionera
382	\N	2021-07-08 03:53:48	admin	GATICA LARA, ROMINA	1	170	::1	insertar	iglesias.controlactmisionera
383	\N	2021-07-08 03:53:48	admin	GATICA LARA, ROMINA	1	171	::1	insertar	iglesias.controlactmisionera
384	\N	2021-07-08 03:53:48	admin	GATICA LARA, ROMINA	1	169	::1	insertar	iglesias.controlactmisionera
385	\N	2021-07-08 03:53:48	admin	GATICA LARA, ROMINA	1	172	::1	insertar	iglesias.controlactmisionera
386	\N	2021-07-08 03:53:48	admin	GATICA LARA, ROMINA	1	173	::1	insertar	iglesias.controlactmisionera
387	\N	2021-07-08 03:54:21	admin	GATICA LARA, ROMINA	1	174	::1	insertar	iglesias.controlactmisionera
388	\N	2021-07-08 03:54:30	admin	GATICA LARA, ROMINA	1	175	::1	insertar	iglesias.controlactmisionera
389	\N	2021-07-08 03:54:36	admin	GATICA LARA, ROMINA	1	176	::1	insertar	iglesias.controlactmisionera
390	\N	2021-07-08 03:54:50	admin	GATICA LARA, ROMINA	1	19	::1	modificar	iglesias.controlactmisionera
391	\N	2021-07-08 03:54:50	admin	GATICA LARA, ROMINA	1	19	::1	modificar	iglesias.controlactmisionera
392	\N	2021-07-08 03:54:50	admin	GATICA LARA, ROMINA	1	19	::1	modificar	iglesias.controlactmisionera
393	\N	2021-07-08 03:54:50	admin	GATICA LARA, ROMINA	1	19	::1	modificar	iglesias.controlactmisionera
394	\N	2021-07-08 03:54:50	admin	GATICA LARA, ROMINA	1	19	::1	modificar	iglesias.controlactmisionera
395	\N	2021-07-08 03:54:50	admin	GATICA LARA, ROMINA	1	19	::1	modificar	iglesias.controlactmisionera
396	\N	2021-07-08 03:54:54	admin	GATICA LARA, ROMINA	1	19	::1	modificar	iglesias.controlactmisionera
397	\N	2021-07-08 03:54:54	admin	GATICA LARA, ROMINA	1	19	::1	modificar	iglesias.controlactmisionera
398	\N	2021-07-08 03:54:54	admin	GATICA LARA, ROMINA	1	19	::1	modificar	iglesias.controlactmisionera
399	\N	2021-07-08 03:54:57	admin	GATICA LARA, ROMINA	1	177	::1	insertar	iglesias.controlactmisionera
400	\N	2021-07-08 03:54:57	admin	GATICA LARA, ROMINA	1	178	::1	insertar	iglesias.controlactmisionera
401	\N	2021-07-08 03:54:57	admin	GATICA LARA, ROMINA	1	179	::1	insertar	iglesias.controlactmisionera
402	\N	2021-07-08 03:55:00	admin	GATICA LARA, ROMINA	1	20	::1	modificar	iglesias.controlactmisionera
403	\N	2021-07-08 03:55:00	admin	GATICA LARA, ROMINA	1	20	::1	modificar	iglesias.controlactmisionera
404	\N	2021-07-08 03:55:00	admin	GATICA LARA, ROMINA	1	20	::1	modificar	iglesias.controlactmisionera
405	\N	2021-07-08 03:55:01	admin	GATICA LARA, ROMINA	1	20	::1	modificar	iglesias.controlactmisionera
406	\N	2021-07-08 03:55:01	admin	GATICA LARA, ROMINA	1	20	::1	modificar	iglesias.controlactmisionera
407	\N	2021-07-08 03:55:01	admin	GATICA LARA, ROMINA	1	20	::1	modificar	iglesias.controlactmisionera
408	\N	2021-07-08 03:55:07	admin	GATICA LARA, ROMINA	1	180	::1	insertar	iglesias.controlactmisionera
410	\N	2021-07-08 03:55:07	admin	GATICA LARA, ROMINA	1	181	::1	insertar	iglesias.controlactmisionera
409	\N	2021-07-08 03:55:07	admin	GATICA LARA, ROMINA	1	182	::1	insertar	iglesias.controlactmisionera
411	\N	2021-07-08 03:55:45	admin	GATICA LARA, ROMINA	1	183	::1	insertar	iglesias.controlactmisionera
412	\N	2021-07-08 03:55:45	admin	GATICA LARA, ROMINA	1	184	::1	insertar	iglesias.controlactmisionera
413	\N	2021-07-08 03:55:45	admin	GATICA LARA, ROMINA	1	185	::1	insertar	iglesias.controlactmisionera
414	\N	2021-07-08 03:55:57	admin	GATICA LARA, ROMINA	1	186	::1	insertar	iglesias.controlactmisionera
415	\N	2021-07-08 03:55:57	admin	GATICA LARA, ROMINA	1	19	::1	modificar	iglesias.controlactmisionera
417	\N	2021-07-08 03:55:57	admin	GATICA LARA, ROMINA	1	188	::1	insertar	iglesias.controlactmisionera
416	\N	2021-07-08 03:55:57	admin	GATICA LARA, ROMINA	1	187	::1	insertar	iglesias.controlactmisionera
418	\N	2021-07-08 03:56:41	admin	GATICA LARA, ROMINA	1	189	::1	insertar	iglesias.controlactmisionera
419	\N	2021-07-08 03:56:43	admin	GATICA LARA, ROMINA	1	190	::1	insertar	iglesias.controlactmisionera
420	\N	2021-07-08 03:56:52	admin	GATICA LARA, ROMINA	1	191	::1	insertar	iglesias.controlactmisionera
421	\N	2021-07-08 03:56:52	admin	GATICA LARA, ROMINA	1	192	::1	insertar	iglesias.controlactmisionera
422	\N	2021-07-08 03:56:53	admin	GATICA LARA, ROMINA	1	193	::1	insertar	iglesias.controlactmisionera
423	\N	2021-07-08 03:56:54	admin	GATICA LARA, ROMINA	1	194	::1	insertar	iglesias.controlactmisionera
424	\N	2021-07-08 03:56:57	admin	GATICA LARA, ROMINA	1	195	::1	insertar	iglesias.controlactmisionera
425	\N	2021-07-08 03:56:58	admin	GATICA LARA, ROMINA	1	196	::1	insertar	iglesias.controlactmisionera
426	\N	2021-07-08 03:57:00	admin	GATICA LARA, ROMINA	1	197	::1	insertar	iglesias.controlactmisionera
427	\N	2021-07-08 03:57:00	admin	GATICA LARA, ROMINA	1	198	::1	insertar	iglesias.controlactmisionera
428	\N	2021-07-08 03:57:02	admin	GATICA LARA, ROMINA	1	199	::1	insertar	iglesias.controlactmisionera
429	\N	2021-07-08 03:57:05	admin	GATICA LARA, ROMINA	1	200	::1	insertar	iglesias.controlactmisionera
430	\N	2021-07-08 03:57:07	admin	GATICA LARA, ROMINA	1	201	::1	insertar	iglesias.controlactmisionera
431	\N	2021-07-08 03:57:07	admin	GATICA LARA, ROMINA	1	202	::1	insertar	iglesias.controlactmisionera
432	\N	2021-07-08 03:57:08	admin	GATICA LARA, ROMINA	1	203	::1	insertar	iglesias.controlactmisionera
433	\N	2021-07-08 03:57:10	admin	GATICA LARA, ROMINA	1	204	::1	insertar	iglesias.controlactmisionera
434	\N	2021-07-08 03:57:14	admin	GATICA LARA, ROMINA	1	205	::1	insertar	iglesias.controlactmisionera
435	\N	2021-07-08 03:57:15	admin	GATICA LARA, ROMINA	1	206	::1	insertar	iglesias.controlactmisionera
436	\N	2021-07-08 03:57:15	admin	GATICA LARA, ROMINA	1	207	::1	insertar	iglesias.controlactmisionera
437	\N	2021-07-08 03:57:15	admin	GATICA LARA, ROMINA	1	208	::1	insertar	iglesias.controlactmisionera
438	\N	2021-07-08 03:57:15	admin	GATICA LARA, ROMINA	1	209	::1	insertar	iglesias.controlactmisionera
439	\N	2021-07-08 03:57:15	admin	GATICA LARA, ROMINA	1	210	::1	insertar	iglesias.controlactmisionera
440	\N	2021-07-08 03:57:16	admin	GATICA LARA, ROMINA	1	211	::1	insertar	iglesias.controlactmisionera
441	\N	2021-07-08 03:57:17	admin	GATICA LARA, ROMINA	1	212	::1	insertar	iglesias.controlactmisionera
442	\N	2021-07-08 03:57:17	admin	GATICA LARA, ROMINA	1	213	::1	insertar	iglesias.controlactmisionera
443	\N	2021-07-08 03:57:18	admin	GATICA LARA, ROMINA	1	214	::1	insertar	iglesias.controlactmisionera
444	\N	2021-07-08 03:57:18	admin	GATICA LARA, ROMINA	1	215	::1	insertar	iglesias.controlactmisionera
445	\N	2021-07-08 03:57:19	admin	GATICA LARA, ROMINA	1	216	::1	insertar	iglesias.controlactmisionera
446	\N	2021-07-08 03:57:19	admin	GATICA LARA, ROMINA	1	217	::1	insertar	iglesias.controlactmisionera
447	\N	2021-07-08 03:57:20	admin	GATICA LARA, ROMINA	1	218	::1	insertar	iglesias.controlactmisionera
448	\N	2021-07-08 03:58:20	admin	GATICA LARA, ROMINA	1	219	::1	insertar	iglesias.controlactmisionera
449	\N	2021-07-08 03:58:20	admin	GATICA LARA, ROMINA	1	220	::1	insertar	iglesias.controlactmisionera
450	\N	2021-07-08 03:58:21	admin	GATICA LARA, ROMINA	1	221	::1	insertar	iglesias.controlactmisionera
451	\N	2021-07-08 03:58:22	admin	GATICA LARA, ROMINA	1	222	::1	insertar	iglesias.controlactmisionera
452	\N	2021-07-08 03:58:22	admin	GATICA LARA, ROMINA	1	223	::1	insertar	iglesias.controlactmisionera
453	\N	2021-07-08 03:58:23	admin	GATICA LARA, ROMINA	1	224	::1	insertar	iglesias.controlactmisionera
454	\N	2021-07-08 03:58:24	admin	GATICA LARA, ROMINA	1	225	::1	insertar	iglesias.controlactmisionera
455	\N	2021-07-08 03:58:24	admin	GATICA LARA, ROMINA	1	226	::1	insertar	iglesias.controlactmisionera
456	\N	2021-07-08 03:58:25	admin	GATICA LARA, ROMINA	1	227	::1	insertar	iglesias.controlactmisionera
457	\N	2021-07-08 03:58:27	admin	GATICA LARA, ROMINA	1	228	::1	insertar	iglesias.controlactmisionera
458	\N	2021-07-08 03:58:27	admin	GATICA LARA, ROMINA	1	21	::1	modificar	iglesias.controlactmisionera
459	\N	2021-07-08 03:58:28	admin	GATICA LARA, ROMINA	1	21	::1	modificar	iglesias.controlactmisionera
464	\N	2021-07-08 21:31:38	admin	GATICA LARA, ROMINA	1	16	::1	insertar	iglesias.miembro
465	\N	2021-07-08 21:31:38	admin	GATICA LARA, ROMINA	1	16	::1	modificar	iglesias.miembro
466	\N	2021-07-10 02:14:20	admin	GATICA LARA, ROMINA	1	5	::1	modificar	public.nivel
467	\N	2021-07-10 02:14:27	admin	GATICA LARA, ROMINA	1	7	::1	insertar	public.nivel
468	\N	2021-07-11 20:42:37	admin	GATICA LARA, ROMINA	1	19	::1	modificar	seguridad.modulos
469	\N	2021-07-11 21:00:05	admin	GATICA LARA, ROMINA	1	45	::1	modificar	public.cargo
470	\N	2021-07-11 21:00:17	admin	GATICA LARA, ROMINA	1	44	::1	modificar	public.cargo
471	\N	2021-07-11 22:04:40	admin	GATICA LARA, ROMINA	1	43	::1	modificar	public.cargo
472	\N	2021-07-11 22:04:52	admin	GATICA LARA, ROMINA	1	41	::1	modificar	public.cargo
473	\N	2021-07-11 22:05:34	admin	GATICA LARA, ROMINA	1	46	::1	modificar	public.cargo
474	\N	2021-07-11 22:05:40	admin	GATICA LARA, ROMINA	1	45	::1	modificar	public.cargo
475	\N	2021-07-11 22:05:45	admin	GATICA LARA, ROMINA	1	44	::1	modificar	public.cargo
476	\N	2021-07-11 22:05:49	admin	GATICA LARA, ROMINA	1	43	::1	modificar	public.cargo
477	\N	2021-07-11 22:05:57	admin	GATICA LARA, ROMINA	1	29	::1	modificar	public.cargo
478	\N	2021-07-11 22:06:05	admin	GATICA LARA, ROMINA	1	28	::1	modificar	public.cargo
479	\N	2021-07-11 22:06:16	admin	GATICA LARA, ROMINA	1	27	::1	modificar	public.cargo
480	\N	2021-07-11 22:06:22	admin	GATICA LARA, ROMINA	1	26	::1	modificar	public.cargo
481	\N	2021-07-11 22:06:30	admin	GATICA LARA, ROMINA	1	25	::1	modificar	public.cargo
482	\N	2021-07-12 00:46:29	admin	GATICA LARA, ROMINA	1	1	::1	modificar	public.tipocargo
483	\N	2021-07-12 02:29:01	admin	GATICA LARA, ROMINA	1	3	::1	modificar	public.nivel
484	\N	2021-07-12 02:29:08	admin	GATICA LARA, ROMINA	1	4	::1	modificar	public.nivel
485	\N	2021-07-12 02:29:15	admin	GATICA LARA, ROMINA	1	4	::1	modificar	public.nivel
486	\N	2021-07-12 02:29:28	admin	GATICA LARA, ROMINA	1	5	::1	modificar	public.nivel
487	\N	2021-07-12 02:29:36	admin	GATICA LARA, ROMINA	1	6	::1	modificar	public.nivel
488	\N	2021-07-12 02:29:41	admin	GATICA LARA, ROMINA	1	7	::1	modificar	public.nivel
489	\N	2021-07-12 02:29:49	admin	GATICA LARA, ROMINA	1	8	::1	modificar	public.nivel
490	\N	2021-07-12 02:29:56	admin	GATICA LARA, ROMINA	1	9	::1	modificar	public.nivel
491	\N	2021-07-12 02:30:02	admin	GATICA LARA, ROMINA	1	10	::1	modificar	public.nivel
492	\N	2021-07-12 02:30:10	admin	GATICA LARA, ROMINA	1	11	::1	modificar	public.nivel
493	\N	2021-07-12 02:30:19	admin	GATICA LARA, ROMINA	1	12	::1	modificar	public.nivel
494	\N	2021-07-12 02:31:19	admin	GATICA LARA, ROMINA	1	13	::1	insertar	public.nivel
495	\N	2021-07-12 02:33:20	admin	GATICA LARA, ROMINA	1	11	::1	modificar	public.nivel
496	\N	2021-07-12 02:33:26	admin	GATICA LARA, ROMINA	1	12	::1	modificar	public.nivel
497	\N	2021-07-12 02:33:34	admin	GATICA LARA, ROMINA	1	6	::1	modificar	public.nivel
498	\N	2021-07-12 02:33:39	admin	GATICA LARA, ROMINA	1	5	::1	modificar	public.nivel
499	\N	2021-07-12 02:33:46	admin	GATICA LARA, ROMINA	1	5	::1	modificar	public.nivel
500	\N	2021-07-12 02:37:11	admin	GATICA LARA, ROMINA	1	9	::1	modificar	public.nivel
501	\N	2021-07-12 02:37:18	admin	GATICA LARA, ROMINA	1	10	::1	modificar	public.nivel
502	\N	2021-07-12 02:37:26	admin	GATICA LARA, ROMINA	1	11	::1	modificar	public.nivel
503	\N	2021-07-12 02:37:32	admin	GATICA LARA, ROMINA	1	12	::1	modificar	public.nivel
504	\N	2021-07-12 02:37:37	admin	GATICA LARA, ROMINA	1	13	::1	modificar	public.nivel
505	\N	2021-07-12 02:37:47	admin	GATICA LARA, ROMINA	1	14	::1	insertar	public.nivel
506	\N	2021-07-12 02:51:22	admin	GATICA LARA, ROMINA	1	7	::1	modificar	public.nivel
507	\N	2021-07-12 03:44:53	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
508	\N	2021-07-12 22:22:36	admin	GATICA LARA, ROMINA	1	34	::1	insertar	seguridad.modulos
509	\N	2021-07-12 22:24:59	admin	GATICA LARA, ROMINA	1	35	::1	insertar	seguridad.modulos
510	\N	2021-07-12 22:25:07	admin	GATICA LARA, ROMINA	1	34	::1	modificar	seguridad.modulos
511	\N	2021-07-12 22:27:18	admin	GATICA LARA, ROMINA	1	34	::1	modificar	seguridad.modulos
512	\N	2021-07-13 03:32:38	admin	GATICA LARA, ROMINA	1	229	::1	insertar	iglesias.controlactmisionera
513	\N	2021-07-13 03:32:44	admin	GATICA LARA, ROMINA	1	230	::1	insertar	iglesias.controlactmisionera
514	\N	2021-07-13 03:32:47	admin	GATICA LARA, ROMINA	1	231	::1	insertar	iglesias.controlactmisionera
515	\N	2021-07-13 03:33:15	admin	GATICA LARA, ROMINA	1	232	::1	insertar	iglesias.controlactmisionera
516	\N	2021-07-13 03:33:41	admin	GATICA LARA, ROMINA	1	233	::1	insertar	iglesias.controlactmisionera
517	\N	2021-07-13 03:33:46	admin	GATICA LARA, ROMINA	1	234	::1	insertar	iglesias.controlactmisionera
518	\N	2021-07-13 03:34:03	admin	GATICA LARA, ROMINA	1	235	::1	insertar	iglesias.controlactmisionera
519	\N	2021-07-13 03:35:52	admin	GATICA LARA, ROMINA	1	236	::1	insertar	iglesias.controlactmisionera
520	\N	2021-07-13 03:35:57	admin	GATICA LARA, ROMINA	1	237	::1	insertar	iglesias.controlactmisionera
521	\N	2021-07-13 03:36:01	admin	GATICA LARA, ROMINA	1	238	::1	insertar	iglesias.controlactmisionera
522	\N	2021-07-13 03:36:08	admin	GATICA LARA, ROMINA	1	239	::1	insertar	iglesias.controlactmisionera
523	\N	2021-07-13 22:34:53	admin	GATICA LARA, ROMINA	1	135	::1	insertar	iglesias.temp_traslados
524	\N	2021-07-13 22:34:53	admin	GATICA LARA, ROMINA	1	136	::1	insertar	iglesias.temp_traslados
525	\N	2021-07-13 22:34:53	admin	GATICA LARA, ROMINA	1	137	::1	insertar	iglesias.temp_traslados
526	\N	2021-07-13 22:35:25	admin	GATICA LARA, ROMINA	1	138	::1	insertar	iglesias.temp_traslados
527	\N	2021-07-13 22:35:25	admin	GATICA LARA, ROMINA	1	139	::1	insertar	iglesias.temp_traslados
528	\N	2021-07-13 22:35:25	admin	GATICA LARA, ROMINA	1	140	::1	insertar	iglesias.temp_traslados
529	\N	2021-07-13 22:38:45	admin	GATICA LARA, ROMINA	1	141	::1	insertar	iglesias.temp_traslados
530	\N	2021-07-13 22:38:45	admin	GATICA LARA, ROMINA	1	142	::1	insertar	iglesias.temp_traslados
531	\N	2021-07-13 22:38:45	admin	GATICA LARA, ROMINA	1	143	::1	insertar	iglesias.temp_traslados
532	\N	2021-07-13 22:40:18	admin	GATICA LARA, ROMINA	1	144	::1	insertar	iglesias.temp_traslados
533	\N	2021-07-13 22:40:18	admin	GATICA LARA, ROMINA	1	145	::1	insertar	iglesias.temp_traslados
534	\N	2021-07-13 22:40:18	admin	GATICA LARA, ROMINA	1	146	::1	insertar	iglesias.temp_traslados
535	\N	2021-07-13 22:44:08	admin	GATICA LARA, ROMINA	1	147	::1	insertar	iglesias.temp_traslados
536	\N	2021-07-13 22:44:08	admin	GATICA LARA, ROMINA	1	148	::1	insertar	iglesias.temp_traslados
537	\N	2021-07-13 22:44:08	admin	GATICA LARA, ROMINA	1	149	::1	insertar	iglesias.temp_traslados
538	\N	2021-07-13 22:49:10	admin	GATICA LARA, ROMINA	1	150	::1	insertar	iglesias.temp_traslados
539	\N	2021-07-13 22:49:10	admin	GATICA LARA, ROMINA	1	151	::1	insertar	iglesias.temp_traslados
540	\N	2021-07-13 22:49:10	admin	GATICA LARA, ROMINA	1	152	::1	insertar	iglesias.temp_traslados
541	\N	2021-07-13 22:50:43	admin	GATICA LARA, ROMINA	1	153	::1	insertar	iglesias.temp_traslados
542	\N	2021-07-13 22:50:43	admin	GATICA LARA, ROMINA	1	154	::1	insertar	iglesias.temp_traslados
543	\N	2021-07-13 22:50:43	admin	GATICA LARA, ROMINA	1	155	::1	insertar	iglesias.temp_traslados
544	\N	2021-07-13 22:55:24	admin	GATICA LARA, ROMINA	1	156	::1	insertar	iglesias.temp_traslados
545	\N	2021-07-13 22:55:24	admin	GATICA LARA, ROMINA	1	157	::1	insertar	iglesias.temp_traslados
546	\N	2021-07-13 22:55:24	admin	GATICA LARA, ROMINA	1	158	::1	insertar	iglesias.temp_traslados
547	\N	2021-07-13 22:57:20	admin	GATICA LARA, ROMINA	1	159	::1	insertar	iglesias.temp_traslados
548	\N	2021-07-13 22:57:20	admin	GATICA LARA, ROMINA	1	160	::1	insertar	iglesias.temp_traslados
549	\N	2021-07-13 22:57:20	admin	GATICA LARA, ROMINA	1	161	::1	insertar	iglesias.temp_traslados
550	\N	2021-07-13 23:00:45	admin	GATICA LARA, ROMINA	1	162	::1	insertar	iglesias.temp_traslados
551	\N	2021-07-13 23:00:45	admin	GATICA LARA, ROMINA	1	163	::1	insertar	iglesias.temp_traslados
552	\N	2021-07-13 23:00:45	admin	GATICA LARA, ROMINA	1	164	::1	insertar	iglesias.temp_traslados
553	\N	2021-07-13 23:02:31	admin	GATICA LARA, ROMINA	1	165	::1	insertar	iglesias.temp_traslados
554	\N	2021-07-13 23:02:31	admin	GATICA LARA, ROMINA	1	166	::1	insertar	iglesias.temp_traslados
555	\N	2021-07-13 23:02:31	admin	GATICA LARA, ROMINA	1	167	::1	insertar	iglesias.temp_traslados
556	\N	2021-07-13 23:04:59	admin	GATICA LARA, ROMINA	1	168	::1	insertar	iglesias.temp_traslados
557	\N	2021-07-13 23:04:59	admin	GATICA LARA, ROMINA	1	169	::1	insertar	iglesias.temp_traslados
558	\N	2021-07-13 23:04:59	admin	GATICA LARA, ROMINA	1	170	::1	insertar	iglesias.temp_traslados
559	\N	2021-07-13 23:47:54	admin	GATICA LARA, ROMINA	1	171	::1	insertar	iglesias.temp_traslados
560	\N	2021-07-13 23:47:55	admin	GATICA LARA, ROMINA	1	172	::1	insertar	iglesias.temp_traslados
561	\N	2021-07-13 23:47:55	admin	GATICA LARA, ROMINA	1	173	::1	insertar	iglesias.temp_traslados
562	\N	2021-07-13 23:48:01	admin	GATICA LARA, ROMINA	1	22	::1	insertar	iglesias.historial_traslados
563	\N	2021-07-13 23:48:02	admin	GATICA LARA, ROMINA	1	5	::1	modificar	iglesias.miembro
564	\N	2021-07-13 23:48:02	admin	GATICA LARA, ROMINA	1	23	::1	insertar	iglesias.historial_traslados
565	\N	2021-07-13 23:48:02	admin	GATICA LARA, ROMINA	1	16	::1	modificar	iglesias.miembro
566	\N	2021-07-13 23:48:02	admin	GATICA LARA, ROMINA	1	24	::1	insertar	iglesias.historial_traslados
567	\N	2021-07-13 23:48:02	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
568	\N	2021-07-13 23:51:14	admin	GATICA LARA, ROMINA	1	174	::1	insertar	iglesias.temp_traslados
569	\N	2021-07-13 23:51:14	admin	GATICA LARA, ROMINA	1	175	::1	insertar	iglesias.temp_traslados
570	\N	2021-07-13 23:51:14	admin	GATICA LARA, ROMINA	1	176	::1	insertar	iglesias.temp_traslados
571	\N	2021-07-13 23:51:16	admin	GATICA LARA, ROMINA	1	25	::1	insertar	iglesias.historial_traslados
572	\N	2021-07-13 23:51:17	admin	GATICA LARA, ROMINA	1	16	::1	modificar	iglesias.miembro
573	\N	2021-07-13 23:51:17	admin	GATICA LARA, ROMINA	1	26	::1	insertar	iglesias.historial_traslados
574	\N	2021-07-13 23:51:17	admin	GATICA LARA, ROMINA	1	14	::1	modificar	iglesias.miembro
575	\N	2021-07-13 23:51:17	admin	GATICA LARA, ROMINA	1	27	::1	insertar	iglesias.historial_traslados
576	\N	2021-07-13 23:51:17	admin	GATICA LARA, ROMINA	1	5	::1	modificar	iglesias.miembro
577	\N	2021-07-13 23:51:30	admin	GATICA LARA, ROMINA	1	177	::1	insertar	iglesias.temp_traslados
578	\N	2021-07-13 23:51:39	admin	GATICA LARA, ROMINA	1	178	::1	insertar	iglesias.temp_traslados
579	\N	2021-07-13 23:53:26	admin	GATICA LARA, ROMINA	1	28	::1	insertar	iglesias.historial_traslados
580	\N	2021-07-13 23:53:26	admin	GATICA LARA, ROMINA	1	16	::1	modificar	iglesias.miembro
581	\N	2021-07-13 23:53:26	admin	GATICA LARA, ROMINA	1	29	::1	insertar	iglesias.historial_traslados
582	\N	2021-07-13 23:53:26	admin	GATICA LARA, ROMINA	1	7	::1	modificar	iglesias.miembro
583	\N	2021-07-14 00:49:14	admin	GATICA LARA, ROMINA	1	179	::1	insertar	iglesias.temp_traslados
584	\N	2021-07-14 00:53:02	admin	GATICA LARA, ROMINA	1	180	::1	insertar	iglesias.temp_traslados
585	\N	2021-07-14 01:01:40	admin	GATICA LARA, ROMINA	1	181	::1	insertar	iglesias.temp_traslados
586	\N	2021-07-14 01:03:14	admin	GATICA LARA, ROMINA	1	182	::1	insertar	iglesias.temp_traslados
587	\N	2021-07-14 01:09:55	admin	GATICA LARA, ROMINA	1	183	::1	insertar	iglesias.temp_traslados
588	\N	2021-07-14 01:10:33	admin	GATICA LARA, ROMINA	1	184	::1	insertar	iglesias.temp_traslados
589	\N	2021-07-14 01:10:47	admin	GATICA LARA, ROMINA	1	5	::1	insertar	iglesias.control_traslados
\.


--
-- TOC entry 2494 (class 0 OID 16405)
-- Dependencies: 174
-- Data for Name: modulos; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.modulos (modulo_id, modulo_nombre, modulo_icono, modulo_controlador, modulo_padre, modulo_orden, modulo_route, estado) FROM stdin;
8	Mantenimiento	fa fa-fw fa-cog	#	1	1	C20210618222025	A
2	Perfiles	#	perfiles/index	3	1	C20210618222148	A
7	Modulos	#	modulos/index	3	2	C20210618222158	A
5	Permisos	#	permisos/index	3	4	C20210618222223	A
4	Usuarios	#	usuarios/index	3	3	C20210618222246	A
1	Modulo Padre	#	#	1	10	C20210619155956	A
15	\N	fa fa-fw fa-money	#	1	2	C20210619160115	A
13	\N	fa fa-fw fa-home	#	1	2	C20210619160723	A
16	\N	#	asociados/index	13	1	C20210620221836	A
9	Paises	#	paises/index	8	3	C20210621130214	A
17	\N	#	divisiones/index	8	2	C20210621130728	A
18	\N	#	uniones/index	8	4	C20210621130814	A
10	Idiomas	#	idiomas/index	8	1	C20210621130955	A
20	\N	#	distritos_misioneros/index	8	6	C20210621171421	A
21	\N	#	iglesias/index	8	7	C20210621215134	A
22	\N	#	pastores/index	8	8	C20210629022610	A
23	\N	#	departamentos/index	8	9	C20210702000732	A
24	\N	#	provincias/index	8	10	C20210702000755	A
25	\N	#	distritos/index	8	11	C20210702000824	A
29	\N	#	asociados/curriculum	13	2	C20210702015755	A
3	Seguridad	fa fa-fw fa-lock	#	1	2	C20210618222007	A
26	\N	#	traslados/index	13	3	C20210702015802	A
28	\N	#	traslados/control	13	4	C20210702015806	A
32	\N	#	niveles/index	8	13	C20210702220420	A
33	\N	#	cargos/index	8	14	C20210702221054	A
31	\N	#	tipos_cargo/index	8	12	C20210703013822	A
30	\N	#	actividad_misionera/index	13	5	C20210706134917	A
19	\N	#	misiones/index	8	5	C20210711204236	A
35	\N	fa fa-fw fa-bar-chart-o	#	1	4	C20210712222459	A
34	\N	#	actividad_misionera/reporte	35	1	C20210712222717	A
\.


--
-- TOC entry 2500 (class 0 OID 16460)
-- Dependencies: 180
-- Data for Name: modulos_idiomas; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.modulos_idiomas (modulo_id, idioma_id, mi_descripcion) FROM stdin;
3	1	Seguridad
8	1	Mantenimiento
2	1	Perfiles
7	1	Modulos
5	1	Permisos
4	1	Usuarios
14	1	Gestión de Iglesias
1	1	Modulo Padre
15	1	Gestión de Ingresos
13	1	Gestión de Iglesias
16	1	Asociados
9	1	Paises
17	1	Divisiones
18	1	Uniones
10	1	Idiomas
20	1	Distritos Misioneros
21	1	Iglesias
22	1	Otros Pastores / Ancianos
27	1	Traslados de Asociados <br> Individual o Masivo
23	1	División Política 1
24	1	División Política 2
25	1	División Política 3
29	1	Curriculum
26	1	Traslado de Asociados
28	1	Control de Traslados
32	1	Niveles
33	1	Cargos
31	1	Tipos de Cargo
30	1	Actividad Misionera
19	1	Asociaciones
35	1	Reportes
34	1	Reporte Actividades Misioneras
\.


--
-- TOC entry 2492 (class 0 OID 16397)
-- Dependencies: 172
-- Data for Name: perfiles; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.perfiles (perfil_id, perfil_descripcion, estado) FROM stdin;
1	ADMINISTRADOR	A
2	SUBADMINISTRADOR	A
22	\N	A
\.


--
-- TOC entry 2501 (class 0 OID 16463)
-- Dependencies: 181
-- Data for Name: perfiles_idiomas; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.perfiles_idiomas (perfil_id, idioma_id, pi_descripcion) FROM stdin;
21	1	Secretaria
2	1	Sub Administrador
1	1	Administrador
20	1	Contabilidad
22	1	Contador
\.


--
-- TOC entry 2497 (class 0 OID 16425)
-- Dependencies: 177
-- Data for Name: permisos; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.permisos (perfil_id, modulo_id) FROM stdin;
2	10
2	17
2	9
2	18
2	19
2	20
2	21
2	22
2	23
2	24
2	25
2	16
2	26
2	2
2	7
2	4
2	5
2	34
1	10
1	17
1	9
1	18
1	19
1	20
1	21
1	22
1	23
1	24
1	25
1	31
1	32
1	33
1	16
1	29
1	26
1	28
1	30
1	2
1	7
1	4
1	5
1	34
\.


--
-- TOC entry 2544 (class 0 OID 16780)
-- Dependencies: 224
-- Data for Name: tipoacceso; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.tipoacceso (idtipoacceso, descripcion) FROM stdin;
1	su DISTRITO MISIONERO
2	su MISION
4	su PAIS
5	su DIVISION
3	su UNION
\.


--
-- TOC entry 2496 (class 0 OID 16413)
-- Dependencies: 176
-- Data for Name: usuarios; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.usuarios (usuario_id, usuario_user, usuario_pass, usuario_nombres, usuario_referencia, perfil_id, estado, idmiembro, idtipoacceso) FROM stdin;
10	david	$2y$10$MCgcZl4M20a8Sh7GkobuC.Ts/RsN1jyBknxdiOAUKhi5G3nh88Dti	\N	\N	1	A	3	2
1	admin	$2y$10$N/rkJIj4kKjim3m/0V2JWuHHdfubMw0FUz2lovcD3Usd/a7uAYTq.	admin	admin	1	A	5	2
11	manuel	$2y$10$xFs3cT4A8sdn4cVY4Rc8pupqbl0dZwufyHmMkJ1o18ZwQM8PJZcHC	\N	\N	2	A	6	5
\.


--
-- TOC entry 2650 (class 0 OID 0)
-- Dependencies: 268
-- Name: actividadmisionera_idactividadmisionera_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.actividadmisionera_idactividadmisionera_seq', 1, false);


--
-- TOC entry 2651 (class 0 OID 0)
-- Dependencies: 274
-- Name: capacitacion_miembro_idcapacitacion_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.capacitacion_miembro_idcapacitacion_seq', 2, true);


--
-- TOC entry 2652 (class 0 OID 0)
-- Dependencies: 245
-- Name: cargo_miembro_idcargomiembro_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.cargo_miembro_idcargomiembro_seq', 60, true);


--
-- TOC entry 2653 (class 0 OID 0)
-- Dependencies: 206
-- Name: categoriaiglesia_idcategoriaiglesia_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.categoriaiglesia_idcategoriaiglesia_seq', 1, false);


--
-- TOC entry 2654 (class 0 OID 0)
-- Dependencies: 196
-- Name: condicioneclesiastica_idcondicioneclesiastica_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.condicioneclesiastica_idcondicioneclesiastica_seq', 1, false);


--
-- TOC entry 2655 (class 0 OID 0)
-- Dependencies: 214
-- Name: condicioninmueble_idcondicioninmueble_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.condicioninmueble_idcondicioninmueble_seq', 1, false);


--
-- TOC entry 2656 (class 0 OID 0)
-- Dependencies: 266
-- Name: control_traslados_idcontrol_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.control_traslados_idcontrol_seq', 5, true);


--
-- TOC entry 2657 (class 0 OID 0)
-- Dependencies: 270
-- Name: controlactmisionera_idcontrolactmisionera_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.controlactmisionera_idcontrolactmisionera_seq', 239, true);


--
-- TOC entry 2658 (class 0 OID 0)
-- Dependencies: 200
-- Name: distritomisionero_iddistritomisionero_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.distritomisionero_iddistritomisionero_seq', 9, true);


--
-- TOC entry 2659 (class 0 OID 0)
-- Dependencies: 220
-- Name: division_iddivision_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.division_iddivision_seq', 5, true);


--
-- TOC entry 2660 (class 0 OID 0)
-- Dependencies: 237
-- Name: historial_altasybajas_idhistorial_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.historial_altasybajas_idhistorial_seq', 20, true);


--
-- TOC entry 2661 (class 0 OID 0)
-- Dependencies: 262
-- Name: historial_traslados_idtraslado_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.historial_traslados_idtraslado_seq', 29, true);


--
-- TOC entry 2662 (class 0 OID 0)
-- Dependencies: 198
-- Name: iglesia_idiglesia_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.iglesia_idiglesia_seq', 1434, true);


--
-- TOC entry 2663 (class 0 OID 0)
-- Dependencies: 249
-- Name: institucion_idinstitucion_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.institucion_idinstitucion_seq', 1, false);


--
-- TOC entry 2664 (class 0 OID 0)
-- Dependencies: 182
-- Name: miembro_idmiembro_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.miembro_idmiembro_seq', 16, true);


--
-- TOC entry 2665 (class 0 OID 0)
-- Dependencies: 204
-- Name: mision_idmision_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.mision_idmision_seq', 8, true);


--
-- TOC entry 2666 (class 0 OID 0)
-- Dependencies: 239
-- Name: motivobaja_idmotivobaja_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.motivobaja_idmotivobaja_seq', 1, false);


--
-- TOC entry 2667 (class 0 OID 0)
-- Dependencies: 241
-- Name: otrospastores_idotrospastores_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.otrospastores_idotrospastores_seq', 1, true);


--
-- TOC entry 2668 (class 0 OID 0)
-- Dependencies: 256
-- Name: paises_jerarquia_pj_id_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.paises_jerarquia_pj_id_seq', 12, true);


--
-- TOC entry 2669 (class 0 OID 0)
-- Dependencies: 247
-- Name: paises_pais_id_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.paises_pais_id_seq', 13, true);


--
-- TOC entry 2670 (class 0 OID 0)
-- Dependencies: 194
-- Name: religion_idreligion_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.religion_idreligion_seq', 1, false);


--
-- TOC entry 2671 (class 0 OID 0)
-- Dependencies: 254
-- Name: temp_traslados_idtemptraslados_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.temp_traslados_idtemptraslados_seq', 184, true);


--
-- TOC entry 2672 (class 0 OID 0)
-- Dependencies: 208
-- Name: tipoconstruccion_idtipoconstruccion_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.tipoconstruccion_idtipoconstruccion_seq', 1, false);


--
-- TOC entry 2673 (class 0 OID 0)
-- Dependencies: 210
-- Name: tipodocumentacion_idtipodocumentacion_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.tipodocumentacion_idtipodocumentacion_seq', 1, false);


--
-- TOC entry 2674 (class 0 OID 0)
-- Dependencies: 212
-- Name: tipoinmueble_idtipoinmueble_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.tipoinmueble_idtipoinmueble_seq', 1, false);


--
-- TOC entry 2675 (class 0 OID 0)
-- Dependencies: 202
-- Name: union_idunion_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.union_idunion_seq', 6, true);


--
-- TOC entry 2676 (class 0 OID 0)
-- Dependencies: 243
-- Name: cargo_idcargo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cargo_idcargo_seq', 47, true);


--
-- TOC entry 2677 (class 0 OID 0)
-- Dependencies: 232
-- Name: condicioninmueble_idcondicioninmueble_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.condicioninmueble_idcondicioninmueble_seq', 1, false);


--
-- TOC entry 2678 (class 0 OID 0)
-- Dependencies: 218
-- Name: departamento_iddepartamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departamento_iddepartamento_seq', 31, true);


--
-- TOC entry 2679 (class 0 OID 0)
-- Dependencies: 184
-- Name: distrito_iddistrito_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.distrito_iddistrito_seq', 1837, true);


--
-- TOC entry 2680 (class 0 OID 0)
-- Dependencies: 188
-- Name: estadocivil_idestadocivil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estadocivil_idestadocivil_seq', 1, false);


--
-- TOC entry 2681 (class 0 OID 0)
-- Dependencies: 192
-- Name: gradoinstruccion_idgradoinstruccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gradoinstruccion_idgradoinstruccion_seq', 1, false);


--
-- TOC entry 2682 (class 0 OID 0)
-- Dependencies: 178
-- Name: idiomas_idioma_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.idiomas_idioma_id_seq', 19, true);


--
-- TOC entry 2683 (class 0 OID 0)
-- Dependencies: 258
-- Name: nivel_idnivel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nivel_idnivel_seq', 14, true);


--
-- TOC entry 2684 (class 0 OID 0)
-- Dependencies: 190
-- Name: ocupacion_idocupacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ocupacion_idocupacion_seq', 1, false);


--
-- TOC entry 2685 (class 0 OID 0)
-- Dependencies: 235
-- Name: pais_idpais_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pais_idpais_seq', 1, false);


--
-- TOC entry 2686 (class 0 OID 0)
-- Dependencies: 216
-- Name: provincia_idprovincia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.provincia_idprovincia_seq', 202, true);


--
-- TOC entry 2687 (class 0 OID 0)
-- Dependencies: 251
-- Name: tipocargo_idtipocargo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipocargo_idtipocargo_seq', 22, true);


--
-- TOC entry 2688 (class 0 OID 0)
-- Dependencies: 226
-- Name: tipoconstruccion_idtipoconstruccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipoconstruccion_idtipoconstruccion_seq', 1, false);


--
-- TOC entry 2689 (class 0 OID 0)
-- Dependencies: 186
-- Name: tipodoc_idtipodoc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipodoc_idtipodoc_seq', 1, false);


--
-- TOC entry 2690 (class 0 OID 0)
-- Dependencies: 228
-- Name: tipodocumentacion_idtipodocumentacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipodocumentacion_idtipodocumentacion_seq', 1, false);


--
-- TOC entry 2691 (class 0 OID 0)
-- Dependencies: 230
-- Name: tipoinmueble_idtipoinmueble_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipoinmueble_idtipoinmueble_seq', 1, false);


--
-- TOC entry 2692 (class 0 OID 0)
-- Dependencies: 272
-- Name: trimestre_idtrimestre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trimestre_idtrimestre_seq', 1, false);


--
-- TOC entry 2693 (class 0 OID 0)
-- Dependencies: 260
-- Name: log_sistema_idlog_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.log_sistema_idlog_seq', 589, true);


--
-- TOC entry 2694 (class 0 OID 0)
-- Dependencies: 173
-- Name: modulos_modulo_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.modulos_modulo_id_seq', 35, true);


--
-- TOC entry 2695 (class 0 OID 0)
-- Dependencies: 171
-- Name: perfiles_perfil_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.perfiles_perfil_id_seq', 22, true);


--
-- TOC entry 2696 (class 0 OID 0)
-- Dependencies: 223
-- Name: tipoacceso_idtipoacceso_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.tipoacceso_idtipoacceso_seq', 1, false);


--
-- TOC entry 2697 (class 0 OID 0)
-- Dependencies: 175
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.usuarios_usuario_id_seq', 11, true);


--
-- TOC entry 2374 (class 2606 OID 25135)
-- Name: actividadmisionera actividadmisionera_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.actividadmisionera
    ADD CONSTRAINT actividadmisionera_pkey PRIMARY KEY (idactividadmisionera);


--
-- TOC entry 2380 (class 2606 OID 25170)
-- Name: capacitacion_miembro capacitacion_miembro_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.capacitacion_miembro
    ADD CONSTRAINT capacitacion_miembro_pkey PRIMARY KEY (idcapacitacion);


--
-- TOC entry 2356 (class 2606 OID 16917)
-- Name: cargo_miembro cargo_miembro_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.cargo_miembro
    ADD CONSTRAINT cargo_miembro_pkey PRIMARY KEY (idcargomiembro, idmiembro, idcargo);


--
-- TOC entry 2320 (class 2606 OID 16703)
-- Name: categoriaiglesia categoriaiglesia_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.categoriaiglesia
    ADD CONSTRAINT categoriaiglesia_pkey PRIMARY KEY (idcategoriaiglesia);


--
-- TOC entry 2312 (class 2606 OID 16568)
-- Name: condicioneclesiastica condicioneclesiastica_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.condicioneclesiastica
    ADD CONSTRAINT condicioneclesiastica_pkey PRIMARY KEY (idcondicioneclesiastica);


--
-- TOC entry 2328 (class 2606 OID 16739)
-- Name: condicioninmueble condicioninmueble_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.condicioninmueble
    ADD CONSTRAINT condicioninmueble_pkey PRIMARY KEY (idcondicioninmueble);


--
-- TOC entry 2372 (class 2606 OID 25124)
-- Name: control_traslados control_traslados_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.control_traslados
    ADD CONSTRAINT control_traslados_pkey PRIMARY KEY (idcontrol);


--
-- TOC entry 2376 (class 2606 OID 25147)
-- Name: controlactmisionera controlactmisionera_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.controlactmisionera
    ADD CONSTRAINT controlactmisionera_pkey PRIMARY KEY (idcontrolactmisionera);


--
-- TOC entry 2316 (class 2606 OID 16670)
-- Name: distritomisionero distritomisionero_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.distritomisionero
    ADD CONSTRAINT distritomisionero_pkey PRIMARY KEY (iddistritomisionero);


--
-- TOC entry 2334 (class 2606 OID 16768)
-- Name: division division_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.division
    ADD CONSTRAINT division_pkey PRIMARY KEY (iddivision);


--
-- TOC entry 2348 (class 2606 OID 16870)
-- Name: historial_altasybajas historial_altasybajas_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.historial_altasybajas
    ADD CONSTRAINT historial_altasybajas_pkey PRIMARY KEY (idhistorial);


--
-- TOC entry 2370 (class 2606 OID 25099)
-- Name: historial_traslados historial_traslados_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.historial_traslados
    ADD CONSTRAINT historial_traslados_pkey PRIMARY KEY (idtraslado);


--
-- TOC entry 2314 (class 2606 OID 16656)
-- Name: iglesia iglesia_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.iglesia
    ADD CONSTRAINT iglesia_pkey PRIMARY KEY (idiglesia);


--
-- TOC entry 2360 (class 2606 OID 24997)
-- Name: institucion institucion_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.institucion
    ADD CONSTRAINT institucion_pkey PRIMARY KEY (idinstitucion);


--
-- TOC entry 2298 (class 2606 OID 16503)
-- Name: miembro miembro_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.miembro
    ADD CONSTRAINT miembro_pkey PRIMARY KEY (idmiembro);


--
-- TOC entry 2318 (class 2606 OID 16691)
-- Name: mision mision_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.mision
    ADD CONSTRAINT mision_pkey PRIMARY KEY (idmision);


--
-- TOC entry 2350 (class 2606 OID 16879)
-- Name: motivobaja motivobaja_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.motivobaja
    ADD CONSTRAINT motivobaja_pkey PRIMARY KEY (idmotivobaja);


--
-- TOC entry 2352 (class 2606 OID 16895)
-- Name: otrospastores otrospastores_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.otrospastores
    ADD CONSTRAINT otrospastores_pkey PRIMARY KEY (idotrospastores);


--
-- TOC entry 2358 (class 2606 OID 24979)
-- Name: paises paises_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.paises
    ADD CONSTRAINT paises_pkey PRIMARY KEY (pais_id);


--
-- TOC entry 2310 (class 2606 OID 16559)
-- Name: religion religion_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.religion
    ADD CONSTRAINT religion_pkey PRIMARY KEY (idreligion);


--
-- TOC entry 2364 (class 2606 OID 25116)
-- Name: temp_traslados temp_traslados_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.temp_traslados
    ADD CONSTRAINT temp_traslados_pkey PRIMARY KEY (idmiembro, idtipodoc, iddivision, pais_id, idunion, idmision, iddistritomisionero, idiglesia, nrodoc, tipo_traslado);


--
-- TOC entry 2322 (class 2606 OID 16712)
-- Name: tipoconstruccion tipoconstruccion_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.tipoconstruccion
    ADD CONSTRAINT tipoconstruccion_pkey PRIMARY KEY (idtipoconstruccion);


--
-- TOC entry 2324 (class 2606 OID 16721)
-- Name: tipodocumentacion tipodocumentacion_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.tipodocumentacion
    ADD CONSTRAINT tipodocumentacion_pkey PRIMARY KEY (idtipodocumentacion);


--
-- TOC entry 2326 (class 2606 OID 16730)
-- Name: tipoinmueble tipoinmueble_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.tipoinmueble
    ADD CONSTRAINT tipoinmueble_pkey PRIMARY KEY (idtipoinmueble);


--
-- TOC entry 2354 (class 2606 OID 16905)
-- Name: cargo cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargo
    ADD CONSTRAINT cargo_pkey PRIMARY KEY (idcargo);


--
-- TOC entry 2344 (class 2606 OID 16830)
-- Name: condicioninmueble condicioninmueble_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.condicioninmueble
    ADD CONSTRAINT condicioninmueble_pkey PRIMARY KEY (idcondicioninmueble);


--
-- TOC entry 2332 (class 2606 OID 16757)
-- Name: departamento departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_pkey PRIMARY KEY (iddepartamento);


--
-- TOC entry 2300 (class 2606 OID 16513)
-- Name: distrito distrito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distrito
    ADD CONSTRAINT distrito_pkey PRIMARY KEY (iddistrito);


--
-- TOC entry 2304 (class 2606 OID 16532)
-- Name: estadocivil estadocivil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadocivil
    ADD CONSTRAINT estadocivil_pkey PRIMARY KEY (idestadocivil);


--
-- TOC entry 2308 (class 2606 OID 16550)
-- Name: gradoinstruccion gradoinstruccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gradoinstruccion
    ADD CONSTRAINT gradoinstruccion_pkey PRIMARY KEY (idgradoinstruccion);


--
-- TOC entry 2296 (class 2606 OID 16451)
-- Name: idiomas idiomas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idiomas
    ADD CONSTRAINT idiomas_pkey PRIMARY KEY (idioma_id);


--
-- TOC entry 2366 (class 2606 OID 25063)
-- Name: nivel nivel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel
    ADD CONSTRAINT nivel_pkey PRIMARY KEY (idnivel);


--
-- TOC entry 2306 (class 2606 OID 16541)
-- Name: ocupacion ocupacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ocupacion
    ADD CONSTRAINT ocupacion_pkey PRIMARY KEY (idocupacion);


--
-- TOC entry 2346 (class 2606 OID 16853)
-- Name: pais pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (idpais);


--
-- TOC entry 2330 (class 2606 OID 16748)
-- Name: provincia provincia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincia
    ADD CONSTRAINT provincia_pkey PRIMARY KEY (idprovincia);


--
-- TOC entry 2362 (class 2606 OID 25006)
-- Name: tipocargo tipocargo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipocargo
    ADD CONSTRAINT tipocargo_pkey PRIMARY KEY (idtipocargo);


--
-- TOC entry 2338 (class 2606 OID 16803)
-- Name: tipoconstruccion tipoconstruccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipoconstruccion
    ADD CONSTRAINT tipoconstruccion_pkey PRIMARY KEY (idtipoconstruccion);


--
-- TOC entry 2302 (class 2606 OID 16523)
-- Name: tipodoc tipodoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipodoc
    ADD CONSTRAINT tipodoc_pkey PRIMARY KEY (idtipodoc);


--
-- TOC entry 2340 (class 2606 OID 16812)
-- Name: tipodocumentacion tipodocumentacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipodocumentacion
    ADD CONSTRAINT tipodocumentacion_pkey PRIMARY KEY (idtipodocumentacion);


--
-- TOC entry 2342 (class 2606 OID 16821)
-- Name: tipoinmueble tipoinmueble_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipoinmueble
    ADD CONSTRAINT tipoinmueble_pkey PRIMARY KEY (idtipoinmueble);


--
-- TOC entry 2378 (class 2606 OID 25158)
-- Name: trimestre trimestre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trimestre
    ADD CONSTRAINT trimestre_pkey PRIMARY KEY (idtrimestre);


--
-- TOC entry 2368 (class 2606 OID 25083)
-- Name: log_sistema log_sistema_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.log_sistema
    ADD CONSTRAINT log_sistema_pkey PRIMARY KEY (idlog);


--
-- TOC entry 2290 (class 2606 OID 16410)
-- Name: modulos modulos_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.modulos
    ADD CONSTRAINT modulos_pkey PRIMARY KEY (modulo_id);


--
-- TOC entry 2288 (class 2606 OID 16402)
-- Name: perfiles perfiles_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.perfiles
    ADD CONSTRAINT perfiles_pkey PRIMARY KEY (perfil_id);


--
-- TOC entry 2294 (class 2606 OID 16429)
-- Name: permisos permisos_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.permisos
    ADD CONSTRAINT permisos_pkey PRIMARY KEY (perfil_id, modulo_id);


--
-- TOC entry 2336 (class 2606 OID 16786)
-- Name: tipoacceso tipoacceso_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tipoacceso
    ADD CONSTRAINT tipoacceso_pkey PRIMARY KEY (idtipoacceso);


--
-- TOC entry 2292 (class 2606 OID 16421)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id);


--
-- TOC entry 2381 (class 2606 OID 16430)
-- Name: modulos fk_padres_modulos; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.modulos
    ADD CONSTRAINT fk_padres_modulos FOREIGN KEY (modulo_padre) REFERENCES seguridad.modulos(modulo_id);


--
-- TOC entry 2598 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2021-07-13 20:28:15

--
-- PostgreSQL database dump complete
--

