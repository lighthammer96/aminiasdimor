--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.20
-- Dumped by pg_dump version 12.3

-- Started on 2021-09-16 17:39:13

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
-- TOC entry 7 (class 2615 OID 33200)
-- Name: iglesias; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA iglesias;


ALTER SCHEMA iglesias OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 33201)
-- Name: seguridad; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA seguridad;


ALTER SCHEMA seguridad OWNER TO postgres;

--
-- TOC entry 297 (class 1255 OID 33202)
-- Name: fn_mostrar_jerarquia(character varying, character varying, integer, integer); Type: FUNCTION; Schema: iglesias; Owner: postgres
--

CREATE FUNCTION iglesias.fn_mostrar_jerarquia(in_select character varying, in_where character varying, in_idioma_id integer, in_idioma_id_defecto integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    jerarquia VARCHAR;
		sql VARCHAR;
BEGIN
	sql = 'SELECT (' || in_select || ') AS select  FROM (SELECT /*d.descripcion AS division, */
        CASE WHEN di.di_descripcion IS NULL THEN
        (SELECT di_descripcion FROM iglesias.division_idiomas WHERE iddivision=d.iddivision AND idioma_id='|| in_idioma_id_defecto ||')
        ELSE di.di_descripcion END AS division, 
        p.pais_descripcion AS pais, u.descripcion AS union,
        mi.descripcion AS mision, dm.descripcion AS distritomisionero, i.descripcion AS iglesia,
        d.iddivision, p.pais_id, u.idunion, mi.idmision, dm.iddistritomisionero, i.idiglesia
        FROM  iglesias.division AS d  
        LEFT JOIN iglesias.division_idiomas AS di on(di.iddivision=d.iddivision AND di.idioma_id='|| in_idioma_id ||')
        INNER JOIN iglesias.paises AS p ON(d.iddivision=p.iddivision)
        INNER JOIN iglesias.union_paises AS up ON(up.pais_id=p.pais_id)
        INNER JOIN iglesias.union AS u ON(up.idunion=u.idunion)
        INNER JOIN iglesias.mision AS mi ON(u.idunion=mi.idunion)
        INNER JOIN iglesias.distritomisionero AS dm ON(mi.idmision=dm.idmision)
        INNER JOIN iglesias.iglesia AS i ON(dm.iddistritomisionero=i.iddistritomisionero)
        WHERE ' || in_where || ' LIMIT 1 ) AS s';
	
    EXECUTE sql INTO jerarquia;
		return jerarquia;
END
$$;


ALTER FUNCTION iglesias.fn_mostrar_jerarquia(in_select character varying, in_where character varying, in_idioma_id integer, in_idioma_id_defecto integer) OWNER TO postgres;

SET default_tablespace = '';

--
-- TOC entry 171 (class 1259 OID 33203)
-- Name: actividadmisionera; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.actividadmisionera (
    idactividadmisionera integer NOT NULL,
    descripcion character varying(150) DEFAULT NULL::character varying,
    tipo character varying(20) DEFAULT NULL::character varying
);


ALTER TABLE iglesias.actividadmisionera OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 33208)
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
-- TOC entry 2657 (class 0 OID 0)
-- Dependencies: 172
-- Name: actividadmisionera_idactividadmisionera_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.actividadmisionera_idactividadmisionera_seq OWNED BY iglesias.actividadmisionera.idactividadmisionera;


--
-- TOC entry 173 (class 1259 OID 33210)
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
-- TOC entry 174 (class 1259 OID 33216)
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
-- TOC entry 2658 (class 0 OID 0)
-- Dependencies: 174
-- Name: capacitacion_miembro_idcapacitacion_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.capacitacion_miembro_idcapacitacion_seq OWNED BY iglesias.capacitacion_miembro.idcapacitacion;


--
-- TOC entry 175 (class 1259 OID 33218)
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
    lugar character varying(100),
    condicion character(1),
    tiempo character(1)
);


ALTER TABLE iglesias.cargo_miembro OWNER TO postgres;

--
-- TOC entry 2659 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN cargo_miembro.idlugar; Type: COMMENT; Schema: iglesias; Owner: postgres
--

COMMENT ON COLUMN iglesias.cargo_miembro.idlugar IS 'es el id de la jeraquia correspondiente';


--
-- TOC entry 2660 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN cargo_miembro.condicion; Type: COMMENT; Schema: iglesias; Owner: postgres
--

COMMENT ON COLUMN iglesias.cargo_miembro.condicion IS 'R -> remunerado
N -> no remunerado';


--
-- TOC entry 2661 (class 0 OID 0)
-- Dependencies: 175
-- Name: COLUMN cargo_miembro.tiempo; Type: COMMENT; Schema: iglesias; Owner: postgres
--

COMMENT ON COLUMN iglesias.cargo_miembro.tiempo IS 'C -> tiempo completo
P -> tiempo parcial';


--
-- TOC entry 176 (class 1259 OID 33225)
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
-- TOC entry 2662 (class 0 OID 0)
-- Dependencies: 176
-- Name: cargo_miembro_idcargomiembro_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.cargo_miembro_idcargomiembro_seq OWNED BY iglesias.cargo_miembro.idcargomiembro;


--
-- TOC entry 177 (class 1259 OID 33227)
-- Name: categoriaiglesia; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.categoriaiglesia (
    idcategoriaiglesia integer NOT NULL,
    descripcion character varying(30) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE iglesias.categoriaiglesia OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 33231)
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
-- TOC entry 2663 (class 0 OID 0)
-- Dependencies: 178
-- Name: categoriaiglesia_idcategoriaiglesia_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.categoriaiglesia_idcategoriaiglesia_seq OWNED BY iglesias.categoriaiglesia.idcategoriaiglesia;


--
-- TOC entry 179 (class 1259 OID 33233)
-- Name: condicioneclesiastica; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.condicioneclesiastica (
    idcondicioneclesiastica integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE iglesias.condicioneclesiastica OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 33237)
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
-- TOC entry 2664 (class 0 OID 0)
-- Dependencies: 180
-- Name: condicioneclesiastica_idcondicioneclesiastica_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.condicioneclesiastica_idcondicioneclesiastica_seq OWNED BY iglesias.condicioneclesiastica.idcondicioneclesiastica;


--
-- TOC entry 181 (class 1259 OID 33239)
-- Name: condicioninmueble; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.condicioninmueble (
    idcondicioninmueble integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE iglesias.condicioninmueble OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 33243)
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
-- TOC entry 2665 (class 0 OID 0)
-- Dependencies: 182
-- Name: condicioninmueble_idcondicioninmueble_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.condicioninmueble_idcondicioninmueble_seq OWNED BY iglesias.condicioninmueble.idcondicioninmueble;


--
-- TOC entry 183 (class 1259 OID 33245)
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
-- TOC entry 2666 (class 0 OID 0)
-- Dependencies: 183
-- Name: COLUMN control_traslados.estado; Type: COMMENT; Schema: iglesias; Owner: postgres
--

COMMENT ON COLUMN iglesias.control_traslados.estado IS '1 -> pendiente

0 -> trasladado

2 -> rechazado';


--
-- TOC entry 184 (class 1259 OID 33249)
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
-- TOC entry 2667 (class 0 OID 0)
-- Dependencies: 184
-- Name: control_traslados_idcontrol_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.control_traslados_idcontrol_seq OWNED BY iglesias.control_traslados.idcontrol;


--
-- TOC entry 185 (class 1259 OID 33251)
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
    interesados numeric(6,0) DEFAULT NULL::numeric,
    mes smallint,
    fecha_inicial date,
    fecha_final date,
    planes text,
    informe_espiritual text,
    iddivision smallint,
    pais_id smallint,
    idunion smallint,
    idmision smallint,
    iddistritomisionero smallint
);


ALTER TABLE iglesias.controlactmisionera OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 33261)
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
-- TOC entry 2668 (class 0 OID 0)
-- Dependencies: 186
-- Name: controlactmisionera_idcontrolactmisionera_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.controlactmisionera_idcontrolactmisionera_seq OWNED BY iglesias.controlactmisionera.idcontrolactmisionera;


--
-- TOC entry 187 (class 1259 OID 33263)
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
-- TOC entry 188 (class 1259 OID 33269)
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
-- TOC entry 2669 (class 0 OID 0)
-- Dependencies: 188
-- Name: distritomisionero_iddistritomisionero_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.distritomisionero_iddistritomisionero_seq OWNED BY iglesias.distritomisionero.iddistritomisionero;


--
-- TOC entry 189 (class 1259 OID 33271)
-- Name: division; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.division (
    iddivision integer NOT NULL,
    descripcion character varying(50),
    estado character(1)
);


ALTER TABLE iglesias.division OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 33274)
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
-- TOC entry 2670 (class 0 OID 0)
-- Dependencies: 190
-- Name: division_iddivision_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.division_iddivision_seq OWNED BY iglesias.division.iddivision;


--
-- TOC entry 191 (class 1259 OID 33276)
-- Name: division_idiomas; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.division_idiomas (
    iddivision integer,
    idioma_id integer,
    di_descripcion character varying(100)
);


ALTER TABLE iglesias.division_idiomas OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 33279)
-- Name: educacion_miembro; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.educacion_miembro (
    ideducacionmiembro integer NOT NULL,
    idmiembro integer,
    institucion character varying(255),
    nivelestudios character varying(255),
    profesion character varying(255),
    estado character varying(255),
    observacion text
);


ALTER TABLE iglesias.educacion_miembro OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 33285)
-- Name: educacion_miembro_ideducacionmiembro_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.educacion_miembro_ideducacionmiembro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.educacion_miembro_ideducacionmiembro_seq OWNER TO postgres;

--
-- TOC entry 2671 (class 0 OID 0)
-- Dependencies: 193
-- Name: educacion_miembro_ideducacionmiembro_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.educacion_miembro_ideducacionmiembro_seq OWNED BY iglesias.educacion_miembro.ideducacionmiembro;


--
-- TOC entry 194 (class 1259 OID 33287)
-- Name: eleccion; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.eleccion (
    ideleccion integer NOT NULL,
    fecha date,
    fechaanterior date,
    supervisor character varying(255),
    feligresiaanterior integer,
    feligresiaactual integer,
    delegados integer,
    tiporeunion character(1) NOT NULL,
    comentarios text,
    periodoini smallint,
    periodofin smallint,
    iddivision smallint,
    pais_id smallint,
    idunion smallint,
    idmision smallint,
    iddistritomisionero smallint,
    idiglesia smallint
);


ALTER TABLE iglesias.eleccion OWNER TO postgres;

--
-- TOC entry 2672 (class 0 OID 0)
-- Dependencies: 194
-- Name: COLUMN eleccion.tiporeunion; Type: COMMENT; Schema: iglesias; Owner: postgres
--

COMMENT ON COLUMN iglesias.eleccion.tiporeunion IS 'O -> Reunion Ordinaria
E -> Reunion Extraordinaria';


--
-- TOC entry 195 (class 1259 OID 33293)
-- Name: eleccion_ideleccion_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.eleccion_ideleccion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.eleccion_ideleccion_seq OWNER TO postgres;

--
-- TOC entry 2673 (class 0 OID 0)
-- Dependencies: 195
-- Name: eleccion_ideleccion_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.eleccion_ideleccion_seq OWNED BY iglesias.eleccion.ideleccion;


--
-- TOC entry 196 (class 1259 OID 33295)
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
-- TOC entry 197 (class 1259 OID 33303)
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
-- TOC entry 2674 (class 0 OID 0)
-- Dependencies: 197
-- Name: historial_altasybajas_idhistorial_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.historial_altasybajas_idhistorial_seq OWNED BY iglesias.historial_altasybajas.idhistorial;


--
-- TOC entry 198 (class 1259 OID 33305)
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
-- TOC entry 199 (class 1259 OID 33308)
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
-- TOC entry 2675 (class 0 OID 0)
-- Dependencies: 199
-- Name: historial_traslados_idtraslado_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.historial_traslados_idtraslado_seq OWNED BY iglesias.historial_traslados.idtraslado;


--
-- TOC entry 200 (class 1259 OID 33310)
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
    direccion text DEFAULT ''::character varying,
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
-- TOC entry 201 (class 1259 OID 33326)
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
-- TOC entry 2676 (class 0 OID 0)
-- Dependencies: 201
-- Name: iglesia_idiglesia_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.iglesia_idiglesia_seq OWNED BY iglesias.iglesia.idiglesia;


--
-- TOC entry 202 (class 1259 OID 33328)
-- Name: institucion; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.institucion (
    idinstitucion integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying,
    sede character varying(50) DEFAULT NULL::character varying,
    "dirección" character varying(50) DEFAULT NULL::character varying,
    telefono character varying(50) DEFAULT NULL::character varying,
    email character varying(150) DEFAULT NULL::character varying,
    iddivision smallint,
    pais_id smallint,
    idunion smallint,
    idmision smallint,
    iddistritomisionero smallint,
    idiglesia smallint,
    nombre character varying(255),
    tipo character varying(50)
);


ALTER TABLE iglesias.institucion OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 33339)
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
-- TOC entry 2677 (class 0 OID 0)
-- Dependencies: 203
-- Name: institucion_idinstitucion_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.institucion_idinstitucion_seq OWNED BY iglesias.institucion.idinstitucion;


--
-- TOC entry 204 (class 1259 OID 33341)
-- Name: laboral_miembro; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.laboral_miembro (
    idlaboralmiembro integer NOT NULL,
    idmiembro integer,
    cargo character varying(255),
    sector character varying(255),
    institucionlaboral character varying(255),
    fechainicio date,
    fechafin date,
    periodoini smallint,
    periodofin smallint
);


ALTER TABLE iglesias.laboral_miembro OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 33347)
-- Name: laboral_miembro_idlaboralmiembro_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.laboral_miembro_idlaboralmiembro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.laboral_miembro_idlaboralmiembro_seq OWNER TO postgres;

--
-- TOC entry 2678 (class 0 OID 0)
-- Dependencies: 205
-- Name: laboral_miembro_idlaboralmiembro_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.laboral_miembro_idlaboralmiembro_seq OWNED BY iglesias.laboral_miembro.idlaboralmiembro;


--
-- TOC entry 206 (class 1259 OID 33349)
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
    encargado_bautizo smallint,
    observaciones_bautizo text,
    idiomas character varying(255),
    texto_bautismal character varying(255),
    pais_iddomicilio integer
);


ALTER TABLE iglesias.miembro OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 33378)
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
-- TOC entry 2679 (class 0 OID 0)
-- Dependencies: 207
-- Name: miembro_idmiembro_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.miembro_idmiembro_seq OWNED BY iglesias.miembro.idmiembro;


--
-- TOC entry 208 (class 1259 OID 33380)
-- Name: mision; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.mision (
    idmision integer NOT NULL,
    idunion integer,
    descripcion character varying(60) DEFAULT ''::character varying,
    direccion character varying(200) DEFAULT NULL::character varying,
    estado character(1) DEFAULT '1'::bpchar,
    telefono character varying(80),
    email character varying(200),
    fax character varying(200)
);


ALTER TABLE iglesias.mision OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 33389)
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
-- TOC entry 2680 (class 0 OID 0)
-- Dependencies: 209
-- Name: mision_idmision_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.mision_idmision_seq OWNED BY iglesias.mision.idmision;


--
-- TOC entry 210 (class 1259 OID 33391)
-- Name: motivobaja; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.motivobaja (
    idmotivobaja integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE iglesias.motivobaja OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 33395)
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
-- TOC entry 2681 (class 0 OID 0)
-- Dependencies: 211
-- Name: motivobaja_idmotivobaja_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.motivobaja_idmotivobaja_seq OWNED BY iglesias.motivobaja.idmotivobaja;


--
-- TOC entry 212 (class 1259 OID 33397)
-- Name: otras_propiedades; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.otras_propiedades (
    idotrapropiedad integer NOT NULL,
    descripcion character varying(255),
    cantidad integer,
    tipo character varying(50),
    iddivision integer,
    pais_id integer,
    idunion integer,
    idmision integer,
    iddistritomisionero integer,
    idiglesia integer
);


ALTER TABLE iglesias.otras_propiedades OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 33400)
-- Name: otras_propiedades_ idotrapropiedad_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias."otras_propiedades_ idotrapropiedad_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias."otras_propiedades_ idotrapropiedad_seq" OWNER TO postgres;

--
-- TOC entry 2682 (class 0 OID 0)
-- Dependencies: 213
-- Name: otras_propiedades_ idotrapropiedad_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias."otras_propiedades_ idotrapropiedad_seq" OWNED BY iglesias.otras_propiedades.idotrapropiedad;


--
-- TOC entry 214 (class 1259 OID 33402)
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
-- TOC entry 215 (class 1259 OID 33412)
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
-- TOC entry 2683 (class 0 OID 0)
-- Dependencies: 215
-- Name: otrospastores_idotrospastores_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.otrospastores_idotrospastores_seq OWNED BY iglesias.otrospastores.idotrospastores;


--
-- TOC entry 216 (class 1259 OID 33414)
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
-- TOC entry 2684 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN paises.posee_union; Type: COMMENT; Schema: iglesias; Owner: postgres
--

COMMENT ON COLUMN iglesias.paises.posee_union IS 'S -> si posee union

N -> no posee union';


--
-- TOC entry 217 (class 1259 OID 33419)
-- Name: paises_idiomas; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.paises_idiomas (
    pais_id integer,
    idioma_id integer,
    pai_descripcion character varying(100)
);


ALTER TABLE iglesias.paises_idiomas OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 33422)
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
-- TOC entry 219 (class 1259 OID 33425)
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
-- TOC entry 2685 (class 0 OID 0)
-- Dependencies: 219
-- Name: paises_jerarquia_pj_id_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.paises_jerarquia_pj_id_seq OWNED BY iglesias.paises_jerarquia.pj_id;


--
-- TOC entry 220 (class 1259 OID 33427)
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
-- TOC entry 2686 (class 0 OID 0)
-- Dependencies: 220
-- Name: paises_pais_id_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.paises_pais_id_seq OWNED BY iglesias.paises.pais_id;


--
-- TOC entry 221 (class 1259 OID 33429)
-- Name: parentesco_miembro; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.parentesco_miembro (
    idparentescomiembro integer NOT NULL,
    idmiembro integer,
    idparentesco integer,
    idpais integer,
    nombres character varying(255),
    idtipodoc integer,
    nrodoc character varying(20),
    fechanacimiento date,
    lugarnacimiento character varying(255)
);


ALTER TABLE iglesias.parentesco_miembro OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 33435)
-- Name: parentesco_miembro_idparentescomiembro_seq; Type: SEQUENCE; Schema: iglesias; Owner: postgres
--

CREATE SEQUENCE iglesias.parentesco_miembro_idparentescomiembro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE iglesias.parentesco_miembro_idparentescomiembro_seq OWNER TO postgres;

--
-- TOC entry 2687 (class 0 OID 0)
-- Dependencies: 222
-- Name: parentesco_miembro_idparentescomiembro_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.parentesco_miembro_idparentescomiembro_seq OWNED BY iglesias.parentesco_miembro.idparentescomiembro;


--
-- TOC entry 223 (class 1259 OID 33437)
-- Name: religion; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.religion (
    idreligion integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE iglesias.religion OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 33441)
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
-- TOC entry 2688 (class 0 OID 0)
-- Dependencies: 224
-- Name: religion_idreligion_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.religion_idreligion_seq OWNED BY iglesias.religion.idreligion;


--
-- TOC entry 225 (class 1259 OID 33443)
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
-- TOC entry 226 (class 1259 OID 33449)
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
-- TOC entry 2689 (class 0 OID 0)
-- Dependencies: 226
-- Name: temp_traslados_idtemptraslados_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.temp_traslados_idtemptraslados_seq OWNED BY iglesias.temp_traslados.idtemptraslados;


--
-- TOC entry 227 (class 1259 OID 33451)
-- Name: union; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias."union" (
    idunion integer NOT NULL,
    descripcion character varying(50),
    estado character(1) DEFAULT '1'::bpchar,
    direccion character varying(200),
    telefono character varying(200),
    email character varying(200),
    fax character varying(200)
);


ALTER TABLE iglesias."union" OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 33458)
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
-- TOC entry 2690 (class 0 OID 0)
-- Dependencies: 228
-- Name: union_idunion_seq; Type: SEQUENCE OWNED BY; Schema: iglesias; Owner: postgres
--

ALTER SEQUENCE iglesias.union_idunion_seq OWNED BY iglesias."union".idunion;


--
-- TOC entry 229 (class 1259 OID 33460)
-- Name: union_paises; Type: TABLE; Schema: iglesias; Owner: postgres
--

CREATE TABLE iglesias.union_paises (
    idunion integer,
    pais_id integer
);


ALTER TABLE iglesias.union_paises OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 33463)
-- Name: tipodoc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipodoc (
    idtipodoc integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.tipodoc OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 33467)
-- Name: vista_asociados_traslados; Type: VIEW; Schema: iglesias; Owner: postgres
--

CREATE VIEW iglesias.vista_asociados_traslados AS
SELECT m.idmiembro, (((m.apellidos)::text || ', '::text) || (m.nombres)::text) AS asociado, m.idtipodoc, m.nrodoc, d.descripcion AS division, p.pais_descripcion AS pais, u.descripcion AS "union", mi.descripcion AS mision, dm.descripcion AS distritomisionero, i.descripcion AS iglesia, td.descripcion AS tipo_documento, m.iddivision, m.pais_id, m.idunion, m.idmision, m.iddistritomisionero, m.idiglesia FROM (((((((iglesias.miembro m JOIN iglesias.division d ON ((m.iddivision = d.iddivision))) JOIN iglesias.paises p ON ((m.pais_id = p.pais_id))) JOIN iglesias."union" u ON ((m.idunion = u.idunion))) JOIN iglesias.mision mi ON ((m.idmision = mi.idmision))) JOIN iglesias.distritomisionero dm ON ((m.iddistritomisionero = dm.iddistritomisionero))) JOIN iglesias.iglesia i ON ((m.idiglesia = i.idiglesia))) JOIN public.tipodoc td ON ((td.idtipodoc = m.idtipodoc)));


ALTER TABLE iglesias.vista_asociados_traslados OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 33472)
-- Name: vista_jerarquia; Type: VIEW; Schema: iglesias; Owner: postgres
--

CREATE VIEW iglesias.vista_jerarquia AS
SELECT d.descripcion AS division, p.pais_descripcion AS pais, u.descripcion AS "union", mi.descripcion AS mision, dm.descripcion AS distritomisionero, i.descripcion AS iglesia, d.iddivision, p.pais_id, u.idunion, mi.idmision, dm.iddistritomisionero, i.idiglesia FROM ((((((iglesias.division d JOIN iglesias.paises p ON ((d.iddivision = p.iddivision))) JOIN iglesias.union_paises up ON ((up.pais_id = p.pais_id))) JOIN iglesias."union" u ON ((up.idunion = u.idunion))) JOIN iglesias.mision mi ON ((u.idunion = mi.idunion))) JOIN iglesias.distritomisionero dm ON ((mi.idmision = dm.idmision))) JOIN iglesias.iglesia i ON ((dm.iddistritomisionero = i.iddistritomisionero)));


ALTER TABLE iglesias.vista_jerarquia OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 33477)
-- Name: cargo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargo (
    idcargo integer NOT NULL,
    descripcion character varying(255) DEFAULT NULL::character varying,
    idtipocargo integer,
    estado character(1) DEFAULT NULL::bpchar,
    idnivel smallint
);


ALTER TABLE public.cargo OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 33482)
-- Name: vista_responsables; Type: VIEW; Schema: iglesias; Owner: postgres
--

CREATE VIEW iglesias.vista_responsables AS
SELECT m.idmiembro AS id, (((m.apellidos)::text || ', '::text) || (m.nombres)::text) AS nombres, 'iglesias.miembro'::text AS tabla, td.descripcion AS tipo_documento, m.nrodoc FROM (iglesias.miembro m JOIN public.tipodoc td ON ((td.idtipodoc = m.idtipodoc))) WHERE (m.idmiembro IN (SELECT cargo_miembro.idmiembro FROM iglesias.cargo_miembro WHERE (cargo_miembro.idcargo IS NOT NULL))) UNION ALL SELECT ot.idotrospastores AS id, ot.nombrecompleto AS nombres, 'iglesias.otrospastores'::text AS tabla, td.descripcion AS tipo_documento, ot.nrodoc FROM ((iglesias.otrospastores ot JOIN public.cargo c ON ((c.idcargo = ot.idcargo))) JOIN public.tipodoc td ON ((td.idtipodoc = ot.idtipodoc))) WHERE (ot.idcargo IS NOT NULL);


ALTER TABLE iglesias.vista_responsables OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 33487)
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
-- TOC entry 2691 (class 0 OID 0)
-- Dependencies: 235
-- Name: cargo_idcargo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cargo_idcargo_seq OWNED BY public.cargo.idcargo;


--
-- TOC entry 236 (class 1259 OID 33489)
-- Name: condicioninmueble; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.condicioninmueble (
    idcondicioninmueble integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.condicioninmueble OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 33493)
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
-- TOC entry 2692 (class 0 OID 0)
-- Dependencies: 237
-- Name: condicioninmueble_idcondicioninmueble_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.condicioninmueble_idcondicioninmueble_seq OWNED BY public.condicioninmueble.idcondicioninmueble;


--
-- TOC entry 238 (class 1259 OID 33495)
-- Name: departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departamento (
    iddepartamento integer NOT NULL,
    descripcion text DEFAULT ''::character varying NOT NULL,
    pais_id integer
);


ALTER TABLE public.departamento OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 33502)
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
-- TOC entry 2693 (class 0 OID 0)
-- Dependencies: 239
-- Name: departamento_iddepartamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departamento_iddepartamento_seq OWNED BY public.departamento.iddepartamento;


--
-- TOC entry 240 (class 1259 OID 33504)
-- Name: distrito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.distrito (
    iddistrito integer NOT NULL,
    idprovincia integer DEFAULT 0 NOT NULL,
    descripcion text DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.distrito OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 33512)
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
-- TOC entry 2694 (class 0 OID 0)
-- Dependencies: 241
-- Name: distrito_iddistrito_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.distrito_iddistrito_seq OWNED BY public.distrito.iddistrito;


--
-- TOC entry 242 (class 1259 OID 33514)
-- Name: estadocivil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estadocivil (
    idestadocivil integer NOT NULL,
    descripcion character varying(30) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.estadocivil OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 33518)
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
-- TOC entry 2695 (class 0 OID 0)
-- Dependencies: 243
-- Name: estadocivil_idestadocivil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estadocivil_idestadocivil_seq OWNED BY public.estadocivil.idestadocivil;


--
-- TOC entry 244 (class 1259 OID 33520)
-- Name: gradoinstruccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gradoinstruccion (
    idgradoinstruccion integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.gradoinstruccion OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 33524)
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
-- TOC entry 2696 (class 0 OID 0)
-- Dependencies: 245
-- Name: gradoinstruccion_idgradoinstruccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gradoinstruccion_idgradoinstruccion_seq OWNED BY public.gradoinstruccion.idgradoinstruccion;


--
-- TOC entry 246 (class 1259 OID 33526)
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
-- TOC entry 247 (class 1259 OID 33531)
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
-- TOC entry 2697 (class 0 OID 0)
-- Dependencies: 247
-- Name: idiomas_idioma_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.idiomas_idioma_id_seq OWNED BY public.idiomas.idioma_id;


--
-- TOC entry 248 (class 1259 OID 33533)
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
-- TOC entry 249 (class 1259 OID 33537)
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
-- TOC entry 2698 (class 0 OID 0)
-- Dependencies: 249
-- Name: nivel_idnivel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nivel_idnivel_seq OWNED BY public.nivel.idnivel;


--
-- TOC entry 250 (class 1259 OID 33539)
-- Name: ocupacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ocupacion (
    idocupacion integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.ocupacion OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 33543)
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
-- TOC entry 2699 (class 0 OID 0)
-- Dependencies: 251
-- Name: ocupacion_idocupacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ocupacion_idocupacion_seq OWNED BY public.ocupacion.idocupacion;


--
-- TOC entry 252 (class 1259 OID 33545)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais (
    idpais integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.pais OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 33549)
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
-- TOC entry 2700 (class 0 OID 0)
-- Dependencies: 253
-- Name: pais_idpais_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pais_idpais_seq OWNED BY public.pais.idpais;


--
-- TOC entry 254 (class 1259 OID 33551)
-- Name: parentesco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parentesco (
    idparentesco integer NOT NULL,
    descripcion character varying(100),
    estado character(1) DEFAULT '1'::bpchar
);


ALTER TABLE public.parentesco OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 33555)
-- Name: parentesco_idparentesco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.parentesco_idparentesco_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parentesco_idparentesco_seq OWNER TO postgres;

--
-- TOC entry 2701 (class 0 OID 0)
-- Dependencies: 255
-- Name: parentesco_idparentesco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parentesco_idparentesco_seq OWNED BY public.parentesco.idparentesco;


--
-- TOC entry 256 (class 1259 OID 33557)
-- Name: procesos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.procesos (
    proceso_id integer NOT NULL,
    proceso_total_elementos_procesar integer,
    proceso_numero_elementos_procesados integer,
    proceso_porcentaje_actual_progreso double precision,
    proceso_fecha_comienzo timestamp without time zone,
    proceso_fecha_actualizacion timestamp without time zone,
    proceso_tiempo_transcurrido character varying(200)
);


ALTER TABLE public.procesos OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 33560)
-- Name: procesos_proceso_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.procesos_proceso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.procesos_proceso_id_seq OWNER TO postgres;

--
-- TOC entry 2702 (class 0 OID 0)
-- Dependencies: 257
-- Name: procesos_proceso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.procesos_proceso_id_seq OWNED BY public.procesos.proceso_id;


--
-- TOC entry 258 (class 1259 OID 33562)
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provincia (
    idprovincia integer NOT NULL,
    iddepartamento integer DEFAULT 0 NOT NULL,
    descripcion text NOT NULL
);


ALTER TABLE public.provincia OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 33569)
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
-- TOC entry 2703 (class 0 OID 0)
-- Dependencies: 259
-- Name: provincia_idprovincia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.provincia_idprovincia_seq OWNED BY public.provincia.idprovincia;


--
-- TOC entry 260 (class 1259 OID 33571)
-- Name: tipocargo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipocargo (
    idtipocargo integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying,
    posee_nivel character(1) DEFAULT 'N'::bpchar
);


ALTER TABLE public.tipocargo OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 33576)
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
-- TOC entry 2704 (class 0 OID 0)
-- Dependencies: 261
-- Name: tipocargo_idtipocargo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipocargo_idtipocargo_seq OWNED BY public.tipocargo.idtipocargo;


--
-- TOC entry 262 (class 1259 OID 33578)
-- Name: tipoconstruccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipoconstruccion (
    idtipoconstruccion integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.tipoconstruccion OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 33582)
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
-- TOC entry 2705 (class 0 OID 0)
-- Dependencies: 263
-- Name: tipoconstruccion_idtipoconstruccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipoconstruccion_idtipoconstruccion_seq OWNED BY public.tipoconstruccion.idtipoconstruccion;


--
-- TOC entry 264 (class 1259 OID 33584)
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
-- TOC entry 2706 (class 0 OID 0)
-- Dependencies: 264
-- Name: tipodoc_idtipodoc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipodoc_idtipodoc_seq OWNED BY public.tipodoc.idtipodoc;


--
-- TOC entry 265 (class 1259 OID 33586)
-- Name: tipodocumentacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipodocumentacion (
    idtipodocumentacion integer NOT NULL,
    descripcion character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.tipodocumentacion OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 33590)
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
-- TOC entry 2707 (class 0 OID 0)
-- Dependencies: 266
-- Name: tipodocumentacion_idtipodocumentacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipodocumentacion_idtipodocumentacion_seq OWNED BY public.tipodocumentacion.idtipodocumentacion;


--
-- TOC entry 267 (class 1259 OID 33592)
-- Name: tipoinmueble; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipoinmueble (
    idtipoinmueble integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE public.tipoinmueble OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 33596)
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
-- TOC entry 2708 (class 0 OID 0)
-- Dependencies: 268
-- Name: tipoinmueble_idtipoinmueble_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipoinmueble_idtipoinmueble_seq OWNED BY public.tipoinmueble.idtipoinmueble;


--
-- TOC entry 269 (class 1259 OID 33598)
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
-- TOC entry 270 (class 1259 OID 33604)
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
-- TOC entry 2709 (class 0 OID 0)
-- Dependencies: 270
-- Name: trimestre_idtrimestre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trimestre_idtrimestre_seq OWNED BY public.trimestre.idtrimestre;


--
-- TOC entry 271 (class 1259 OID 33606)
-- Name: vista_division_politica; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vista_division_politica AS
SELECT d.descripcion AS departamento, p.descripcion AS provincia, dd.descripcion AS distrito, d.iddepartamento, p.idprovincia, dd.iddistrito FROM ((public.departamento d LEFT JOIN public.provincia p ON ((d.iddepartamento = p.iddepartamento))) LEFT JOIN public.distrito dd ON ((dd.idprovincia = p.idprovincia)));


ALTER TABLE public.vista_division_politica OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 33610)
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
-- TOC entry 273 (class 1259 OID 33619)
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
-- TOC entry 2710 (class 0 OID 0)
-- Dependencies: 273
-- Name: log_sistema_idlog_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.log_sistema_idlog_seq OWNED BY seguridad.log_sistema.idlog;


--
-- TOC entry 274 (class 1259 OID 33621)
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
-- TOC entry 275 (class 1259 OID 33625)
-- Name: modulos_idiomas; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.modulos_idiomas (
    modulo_id integer,
    idioma_id integer,
    mi_descripcion character varying(100)
);


ALTER TABLE seguridad.modulos_idiomas OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 33628)
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
-- TOC entry 2711 (class 0 OID 0)
-- Dependencies: 276
-- Name: modulos_modulo_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.modulos_modulo_id_seq OWNED BY seguridad.modulos.modulo_id;


--
-- TOC entry 277 (class 1259 OID 33630)
-- Name: perfiles; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.perfiles (
    perfil_id integer NOT NULL,
    perfil_descripcion character varying(50),
    estado character(1) DEFAULT 'A'::bpchar
);


ALTER TABLE seguridad.perfiles OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 33634)
-- Name: perfiles_idiomas; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.perfiles_idiomas (
    perfil_id integer,
    idioma_id integer,
    pi_descripcion character varying(100)
);


ALTER TABLE seguridad.perfiles_idiomas OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 33637)
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
-- TOC entry 2712 (class 0 OID 0)
-- Dependencies: 279
-- Name: perfiles_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.perfiles_perfil_id_seq OWNED BY seguridad.perfiles.perfil_id;


--
-- TOC entry 280 (class 1259 OID 33639)
-- Name: permisos; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.permisos (
    perfil_id integer NOT NULL,
    modulo_id integer NOT NULL
);


ALTER TABLE seguridad.permisos OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 33642)
-- Name: tipoacceso; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.tipoacceso (
    idtipoacceso integer NOT NULL,
    descripcion character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE seguridad.tipoacceso OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 33646)
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
-- TOC entry 2713 (class 0 OID 0)
-- Dependencies: 282
-- Name: tipoacceso_idtipoacceso_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.tipoacceso_idtipoacceso_seq OWNED BY seguridad.tipoacceso.idtipoacceso;


--
-- TOC entry 283 (class 1259 OID 33648)
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
-- TOC entry 284 (class 1259 OID 33655)
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
-- TOC entry 2714 (class 0 OID 0)
-- Dependencies: 284
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.usuarios_usuario_id_seq OWNED BY seguridad.usuarios.usuario_id;


--
-- TOC entry 2181 (class 2604 OID 33657)
-- Name: actividadmisionera idactividadmisionera; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.actividadmisionera ALTER COLUMN idactividadmisionera SET DEFAULT nextval('iglesias.actividadmisionera_idactividadmisionera_seq'::regclass);


--
-- TOC entry 2182 (class 2604 OID 33658)
-- Name: capacitacion_miembro idcapacitacion; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.capacitacion_miembro ALTER COLUMN idcapacitacion SET DEFAULT nextval('iglesias.capacitacion_miembro_idcapacitacion_seq'::regclass);


--
-- TOC entry 2184 (class 2604 OID 33659)
-- Name: cargo_miembro idcargomiembro; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.cargo_miembro ALTER COLUMN idcargomiembro SET DEFAULT nextval('iglesias.cargo_miembro_idcargomiembro_seq'::regclass);


--
-- TOC entry 2186 (class 2604 OID 33660)
-- Name: categoriaiglesia idcategoriaiglesia; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.categoriaiglesia ALTER COLUMN idcategoriaiglesia SET DEFAULT nextval('iglesias.categoriaiglesia_idcategoriaiglesia_seq'::regclass);


--
-- TOC entry 2188 (class 2604 OID 33661)
-- Name: condicioneclesiastica idcondicioneclesiastica; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.condicioneclesiastica ALTER COLUMN idcondicioneclesiastica SET DEFAULT nextval('iglesias.condicioneclesiastica_idcondicioneclesiastica_seq'::regclass);


--
-- TOC entry 2190 (class 2604 OID 33662)
-- Name: condicioninmueble idcondicioninmueble; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.condicioninmueble ALTER COLUMN idcondicioninmueble SET DEFAULT nextval('iglesias.condicioninmueble_idcondicioninmueble_seq'::regclass);


--
-- TOC entry 2192 (class 2604 OID 33663)
-- Name: control_traslados idcontrol; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.control_traslados ALTER COLUMN idcontrol SET DEFAULT nextval('iglesias.control_traslados_idcontrol_seq'::regclass);


--
-- TOC entry 2197 (class 2604 OID 33664)
-- Name: controlactmisionera idcontrolactmisionera; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.controlactmisionera ALTER COLUMN idcontrolactmisionera SET DEFAULT nextval('iglesias.controlactmisionera_idcontrolactmisionera_seq'::regclass);


--
-- TOC entry 2201 (class 2604 OID 33665)
-- Name: distritomisionero iddistritomisionero; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.distritomisionero ALTER COLUMN iddistritomisionero SET DEFAULT nextval('iglesias.distritomisionero_iddistritomisionero_seq'::regclass);


--
-- TOC entry 2202 (class 2604 OID 33666)
-- Name: division iddivision; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.division ALTER COLUMN iddivision SET DEFAULT nextval('iglesias.division_iddivision_seq'::regclass);


--
-- TOC entry 2203 (class 2604 OID 33667)
-- Name: educacion_miembro ideducacionmiembro; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.educacion_miembro ALTER COLUMN ideducacionmiembro SET DEFAULT nextval('iglesias.educacion_miembro_ideducacionmiembro_seq'::regclass);


--
-- TOC entry 2204 (class 2604 OID 33668)
-- Name: eleccion ideleccion; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.eleccion ALTER COLUMN ideleccion SET DEFAULT nextval('iglesias.eleccion_ideleccion_seq'::regclass);


--
-- TOC entry 2207 (class 2604 OID 33669)
-- Name: historial_altasybajas idhistorial; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.historial_altasybajas ALTER COLUMN idhistorial SET DEFAULT nextval('iglesias.historial_altasybajas_idhistorial_seq'::regclass);


--
-- TOC entry 2208 (class 2604 OID 33670)
-- Name: historial_traslados idtraslado; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.historial_traslados ALTER COLUMN idtraslado SET DEFAULT nextval('iglesias.historial_traslados_idtraslado_seq'::regclass);


--
-- TOC entry 2219 (class 2604 OID 33671)
-- Name: iglesia idiglesia; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.iglesia ALTER COLUMN idiglesia SET DEFAULT nextval('iglesias.iglesia_idiglesia_seq'::regclass);


--
-- TOC entry 2225 (class 2604 OID 33672)
-- Name: institucion idinstitucion; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.institucion ALTER COLUMN idinstitucion SET DEFAULT nextval('iglesias.institucion_idinstitucion_seq'::regclass);


--
-- TOC entry 2226 (class 2604 OID 33673)
-- Name: laboral_miembro idlaboralmiembro; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.laboral_miembro ALTER COLUMN idlaboralmiembro SET DEFAULT nextval('iglesias.laboral_miembro_idlaboralmiembro_seq'::regclass);


--
-- TOC entry 2250 (class 2604 OID 33674)
-- Name: miembro idmiembro; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.miembro ALTER COLUMN idmiembro SET DEFAULT nextval('iglesias.miembro_idmiembro_seq'::regclass);


--
-- TOC entry 2254 (class 2604 OID 33675)
-- Name: mision idmision; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.mision ALTER COLUMN idmision SET DEFAULT nextval('iglesias.mision_idmision_seq'::regclass);


--
-- TOC entry 2256 (class 2604 OID 33676)
-- Name: motivobaja idmotivobaja; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.motivobaja ALTER COLUMN idmotivobaja SET DEFAULT nextval('iglesias.motivobaja_idmotivobaja_seq'::regclass);


--
-- TOC entry 2257 (class 2604 OID 33677)
-- Name: otras_propiedades idotrapropiedad; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.otras_propiedades ALTER COLUMN idotrapropiedad SET DEFAULT nextval('iglesias."otras_propiedades_ idotrapropiedad_seq"'::regclass);


--
-- TOC entry 2262 (class 2604 OID 33678)
-- Name: otrospastores idotrospastores; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.otrospastores ALTER COLUMN idotrospastores SET DEFAULT nextval('iglesias.otrospastores_idotrospastores_seq'::regclass);


--
-- TOC entry 2265 (class 2604 OID 33679)
-- Name: paises pais_id; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.paises ALTER COLUMN pais_id SET DEFAULT nextval('iglesias.paises_pais_id_seq'::regclass);


--
-- TOC entry 2266 (class 2604 OID 33680)
-- Name: paises_jerarquia pj_id; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.paises_jerarquia ALTER COLUMN pj_id SET DEFAULT nextval('iglesias.paises_jerarquia_pj_id_seq'::regclass);


--
-- TOC entry 2267 (class 2604 OID 33681)
-- Name: parentesco_miembro idparentescomiembro; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.parentesco_miembro ALTER COLUMN idparentescomiembro SET DEFAULT nextval('iglesias.parentesco_miembro_idparentescomiembro_seq'::regclass);


--
-- TOC entry 2269 (class 2604 OID 33682)
-- Name: religion idreligion; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.religion ALTER COLUMN idreligion SET DEFAULT nextval('iglesias.religion_idreligion_seq'::regclass);


--
-- TOC entry 2270 (class 2604 OID 33683)
-- Name: temp_traslados idtemptraslados; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.temp_traslados ALTER COLUMN idtemptraslados SET DEFAULT nextval('iglesias.temp_traslados_idtemptraslados_seq'::regclass);


--
-- TOC entry 2272 (class 2604 OID 33684)
-- Name: union idunion; Type: DEFAULT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias."union" ALTER COLUMN idunion SET DEFAULT nextval('iglesias.union_idunion_seq'::regclass);


--
-- TOC entry 2277 (class 2604 OID 33685)
-- Name: cargo idcargo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargo ALTER COLUMN idcargo SET DEFAULT nextval('public.cargo_idcargo_seq'::regclass);


--
-- TOC entry 2279 (class 2604 OID 33686)
-- Name: condicioninmueble idcondicioninmueble; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.condicioninmueble ALTER COLUMN idcondicioninmueble SET DEFAULT nextval('public.condicioninmueble_idcondicioninmueble_seq'::regclass);


--
-- TOC entry 2281 (class 2604 OID 33687)
-- Name: departamento iddepartamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento ALTER COLUMN iddepartamento SET DEFAULT nextval('public.departamento_iddepartamento_seq'::regclass);


--
-- TOC entry 2284 (class 2604 OID 33688)
-- Name: distrito iddistrito; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distrito ALTER COLUMN iddistrito SET DEFAULT nextval('public.distrito_iddistrito_seq'::regclass);


--
-- TOC entry 2286 (class 2604 OID 33689)
-- Name: estadocivil idestadocivil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadocivil ALTER COLUMN idestadocivil SET DEFAULT nextval('public.estadocivil_idestadocivil_seq'::regclass);


--
-- TOC entry 2288 (class 2604 OID 33690)
-- Name: gradoinstruccion idgradoinstruccion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gradoinstruccion ALTER COLUMN idgradoinstruccion SET DEFAULT nextval('public.gradoinstruccion_idgradoinstruccion_seq'::regclass);


--
-- TOC entry 2291 (class 2604 OID 33691)
-- Name: idiomas idioma_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idiomas ALTER COLUMN idioma_id SET DEFAULT nextval('public.idiomas_idioma_id_seq'::regclass);


--
-- TOC entry 2293 (class 2604 OID 33692)
-- Name: nivel idnivel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel ALTER COLUMN idnivel SET DEFAULT nextval('public.nivel_idnivel_seq'::regclass);


--
-- TOC entry 2295 (class 2604 OID 33693)
-- Name: ocupacion idocupacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ocupacion ALTER COLUMN idocupacion SET DEFAULT nextval('public.ocupacion_idocupacion_seq'::regclass);


--
-- TOC entry 2297 (class 2604 OID 33694)
-- Name: pais idpais; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais ALTER COLUMN idpais SET DEFAULT nextval('public.pais_idpais_seq'::regclass);


--
-- TOC entry 2299 (class 2604 OID 33695)
-- Name: parentesco idparentesco; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parentesco ALTER COLUMN idparentesco SET DEFAULT nextval('public.parentesco_idparentesco_seq'::regclass);


--
-- TOC entry 2300 (class 2604 OID 33696)
-- Name: procesos proceso_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procesos ALTER COLUMN proceso_id SET DEFAULT nextval('public.procesos_proceso_id_seq'::regclass);


--
-- TOC entry 2302 (class 2604 OID 33697)
-- Name: provincia idprovincia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincia ALTER COLUMN idprovincia SET DEFAULT nextval('public.provincia_idprovincia_seq'::regclass);


--
-- TOC entry 2305 (class 2604 OID 33698)
-- Name: tipocargo idtipocargo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipocargo ALTER COLUMN idtipocargo SET DEFAULT nextval('public.tipocargo_idtipocargo_seq'::regclass);


--
-- TOC entry 2307 (class 2604 OID 33699)
-- Name: tipoconstruccion idtipoconstruccion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipoconstruccion ALTER COLUMN idtipoconstruccion SET DEFAULT nextval('public.tipoconstruccion_idtipoconstruccion_seq'::regclass);


--
-- TOC entry 2274 (class 2604 OID 33700)
-- Name: tipodoc idtipodoc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipodoc ALTER COLUMN idtipodoc SET DEFAULT nextval('public.tipodoc_idtipodoc_seq'::regclass);


--
-- TOC entry 2309 (class 2604 OID 33701)
-- Name: tipodocumentacion idtipodocumentacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipodocumentacion ALTER COLUMN idtipodocumentacion SET DEFAULT nextval('public.tipodocumentacion_idtipodocumentacion_seq'::regclass);


--
-- TOC entry 2311 (class 2604 OID 33702)
-- Name: tipoinmueble idtipoinmueble; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipoinmueble ALTER COLUMN idtipoinmueble SET DEFAULT nextval('public.tipoinmueble_idtipoinmueble_seq'::regclass);


--
-- TOC entry 2315 (class 2604 OID 33703)
-- Name: trimestre idtrimestre; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trimestre ALTER COLUMN idtrimestre SET DEFAULT nextval('public.trimestre_idtrimestre_seq'::regclass);


--
-- TOC entry 2319 (class 2604 OID 33704)
-- Name: log_sistema idlog; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.log_sistema ALTER COLUMN idlog SET DEFAULT nextval('seguridad.log_sistema_idlog_seq'::regclass);


--
-- TOC entry 2321 (class 2604 OID 33705)
-- Name: modulos modulo_id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.modulos ALTER COLUMN modulo_id SET DEFAULT nextval('seguridad.modulos_modulo_id_seq'::regclass);


--
-- TOC entry 2323 (class 2604 OID 33706)
-- Name: perfiles perfil_id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.perfiles ALTER COLUMN perfil_id SET DEFAULT nextval('seguridad.perfiles_perfil_id_seq'::regclass);


--
-- TOC entry 2325 (class 2604 OID 33707)
-- Name: tipoacceso idtipoacceso; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tipoacceso ALTER COLUMN idtipoacceso SET DEFAULT nextval('seguridad.tipoacceso_idtipoacceso_seq'::regclass);


--
-- TOC entry 2327 (class 2604 OID 33708)
-- Name: usuarios usuario_id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('seguridad.usuarios_usuario_id_seq'::regclass);


--
-- TOC entry 2541 (class 0 OID 33203)
-- Dependencies: 171
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
28	Libros	dexterna
29	Revistas	dexterna
30	Volantes	dexterna
31	Lecciones de E. S.	dinterna
32	El Guar. Del Sab.	dinterna
33	Ancla Juvenil	dinterna
34	Reuniones juveniles	actjuveniles
35	Sábados juveniles	actjuveniles
36	Fin de sem. Juveniles	actjuveniles
37	Seminarios juveniles	actjuveniles
38	Congresos juveniles	actjuveniles
39	textos	textos
\.


--
-- TOC entry 2543 (class 0 OID 33210)
-- Dependencies: 173
-- Data for Name: capacitacion_miembro; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.capacitacion_miembro (idcapacitacion, idmiembro, anio, capacitacion, centro_estudios, observaciones_capacitacion) FROM stdin;
\.


--
-- TOC entry 2545 (class 0 OID 33218)
-- Dependencies: 175
-- Data for Name: cargo_miembro; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.cargo_miembro (idcargomiembro, idmiembro, idcargo, idinstitucion, observaciones_cargo, vigente, periodoini, periodofin, idiglesia_cargo, idnivel, idlugar, tabla, lugar, condicion, tiempo) FROM stdin;
\.


--
-- TOC entry 2547 (class 0 OID 33227)
-- Dependencies: 177
-- Data for Name: categoriaiglesia; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.categoriaiglesia (idcategoriaiglesia, descripcion) FROM stdin;
1	Iglesia
2	Grupo
3	Filial
4	Aislado/Interesado
0	No Determinado
5	Campo
\.


--
-- TOC entry 2549 (class 0 OID 33233)
-- Dependencies: 179
-- Data for Name: condicioneclesiastica; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.condicioneclesiastica (idcondicioneclesiastica, descripcion) FROM stdin;
0	Miembro de escuela
1	Bautizado
\.


--
-- TOC entry 2551 (class 0 OID 33239)
-- Dependencies: 181
-- Data for Name: condicioninmueble; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.condicioninmueble (idcondicioninmueble, descripcion) FROM stdin;
1	Construido
2	Semiconstruido
3	En Construcción
4	En Litigio
\.


--
-- TOC entry 2553 (class 0 OID 33245)
-- Dependencies: 183
-- Data for Name: control_traslados; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.control_traslados (idcontrol, idmiembro, idiglesiaanterior, idiglesiaactual, fecha, carta_traslado, carta_aceptacion, estado, iddivisionactual, pais_idactual, idunionactual, idmisionactual, iddistritomisioneroactual) FROM stdin;
\.


--
-- TOC entry 2555 (class 0 OID 33251)
-- Dependencies: 185
-- Data for Name: controlactmisionera; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.controlactmisionera (idcontrolactmisionera, idactividadmisionera, anio, trimestre, idiglesia, semana, valor, asistentes, interesados, mes, fecha_inicial, fecha_final, planes, informe_espiritual, iddivision, pais_id, idunion, idmision, iddistritomisionero) FROM stdin;
\.


--
-- TOC entry 2557 (class 0 OID 33263)
-- Dependencies: 187
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
10	9	Metrofrontera	1
11	9	Magdalena Medio	1
12	9	Central	1
13	9	Caribe 1	1
14	9	Caribe 2	1
15	10	Boyaca	1
16	10	Capital	1
17	10	Cunditolima	1
18	10	Llanos	1
19	11	Antioquia	1
20	11	Caldas 1	1
21	11	Caldas 2	1
22	11	Valle	1
23	12	Huila	1
24	12	Caqueta	1
25	12	Putumayo	1
26	12	Suroccidente	1
27	13	Distrito 1	1
28	13	Distrito 2	1
29	13	Distrito 3	1
30	13	Distrito 4	1
31	13	Galápagos	1
32	14	Montevideo	1
33	14	Delta del Tigre	1
34	14	Pando 	1
35	14	Rosario	1
36	15	Sur	1
37	15	Norte	1
38	15	Occidente	1
39	15	Noroccidente	1
40	16	Norte Grande	1
41	16	Norte Chico	1
42	16	Metropolitano	1
43	16	Biobio	1
44	16	Araucania	1
45	16	Los Ríos	1
46	17	Cochabamba	1
47	18	La Paz	1
48	19	Potosi	1
49	19	Tarija	1
50	20	Santa Cruz	1
51	20	Trinidad	1
52	21	Distrito 1	1
53	21	Distrito 2	1
54	21	Distrito 3	1
55	21	Distrito 4	1
\.


--
-- TOC entry 2559 (class 0 OID 33271)
-- Dependencies: 189
-- Data for Name: division; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.division (iddivision, descripcion, estado) FROM stdin;
1		1
0		1
\.


--
-- TOC entry 2561 (class 0 OID 33276)
-- Dependencies: 191
-- Data for Name: division_idiomas; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.division_idiomas (iddivision, idioma_id, di_descripcion) FROM stdin;
2	1	Europea
5	1	Asiatica
1	1	Latinoamerica
6	1	Africana
0	1	No Determinado
\.


--
-- TOC entry 2562 (class 0 OID 33279)
-- Dependencies: 192
-- Data for Name: educacion_miembro; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.educacion_miembro (ideducacionmiembro, idmiembro, institucion, nivelestudios, profesion, estado, observacion) FROM stdin;
\.


--
-- TOC entry 2564 (class 0 OID 33287)
-- Dependencies: 194
-- Data for Name: eleccion; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.eleccion (ideleccion, fecha, fechaanterior, supervisor, feligresiaanterior, feligresiaactual, delegados, tiporeunion, comentarios, periodoini, periodofin, iddivision, pais_id, idunion, idmision, iddistritomisionero, idiglesia) FROM stdin;
\.


--
-- TOC entry 2566 (class 0 OID 33295)
-- Dependencies: 196
-- Data for Name: historial_altasybajas; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.historial_altasybajas (idhistorial, idmiembro, responsable, fecha, observaciones, alta, idmotivobaja, rebautizo, usuario, idcondicioneclesiastica, tabla) FROM stdin;
\.


--
-- TOC entry 2568 (class 0 OID 33305)
-- Dependencies: 198
-- Data for Name: historial_traslados; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.historial_traslados (idtraslado, idmiembro, idiglesiaanterior, idiglesiaactual, fecha, idcontrol) FROM stdin;
\.


--
-- TOC entry 2570 (class 0 OID 33310)
-- Dependencies: 200
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
451		Compartición		1140	3	1	1	0	0	\N				1	\N	\N	\N	\N	\N	\N	\N	\N	\N
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
807		Lomas de Wichanzao	ex Paradero de Ramiro Prialé x iglesias.iglesias.iglesia Israelita	1132	2	1	9	1	3		AA. HH. Lomas de Wichanzo - Sector II, Mz: 3, Lote: 38		FALTA SUB - DIVISIÓN	1	\N	\N	\N	\N	\N	\N	\N	\N	\N
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
1425	957459877	Puno		1594	1	0	0	0	0	44	Jr. Ricardo Palma 509	44	DD	1	1	1	ESTRUCTURA FUERTE	4444	1	13	5	7	8
1424	957459877	Camarón		1694	1	0	0	0	0	44	Jr. Juan Vargas 405	\N	F	1	31	202	ESTRUCTURA FUERTE	4444	1	9	3	6	7
1427	957459877	Cabanillas		1	1	1	1	1	1	500	Jr. Ricardo Palma 509	\N	NINGUNA	1	1	1	ESTRUCTURA FUERTE	NRO	1	1	1	1	1
1428	\N	Gaitan	\N	0	1	0	0	\N	\N	\N		\N	\N	1	67	1064	\N	\N	1	15	7	9	10
1429	\N	Cúcuta	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	9	10
1430	\N	Villa Del Rosario	\N	0	1	0	0	\N	\N	\N		\N	\N	1	64	1042	\N	\N	1	15	7	9	10
1431	\N	Lebrija	\N	0	4	0	0	\N	\N	\N		\N	\N	1	67	1102	\N	\N	1	15	7	9	10
1432	\N	Malaga	\N	0	4	0	0	\N	\N	\N		\N	\N	1	67	1105	\N	\N	1	15	7	9	10
1433	\N	Rionegro	\N	0	4	0	0	\N	\N	\N		\N	\N	1	47	341	\N	\N	1	15	7	9	10
1434	\N	Matanza	\N	0	4	0	0	\N	\N	\N		\N	\N	1	67	1106	\N	\N	1	15	7	9	10
1435	\N	Aburrido	\N	0	4	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	9	10
1436	\N	Socorro	\N	0	4	0	0	\N	\N	\N		\N	\N	1	67	1129	\N	\N	1	15	7	9	10
1437	\N	Bucaramanga	\N	0	4	0	0	\N	\N	\N		\N	\N	1	67	1064	\N	\N	1	15	7	9	10
1438	\N	Los Patios	\N	0	4	0	0	\N	\N	\N		\N	\N	1	64	1026	\N	\N	1	15	7	9	10
1439	\N	Barrancabermeja	\N	0	1	0	0	\N	\N	\N		\N	\N	1	67	1068	\N	\N	1	15	7	9	11
1440	\N	San Pablo Bolivar	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	9	11
1441	\N	Santa Rosa Bolivar	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	9	11
1442	\N	Cimitarra	\N	0	2	0	0	\N	\N	\N		\N	\N	1	67	1077	\N	\N	1	15	7	9	11
1443	\N	El Guamo	\N	0	2	0	0	\N	\N	\N		\N	\N	1	50	438	\N	\N	1	15	7	9	11
1444	\N	San Juan	\N	0	2	0	0	\N	\N	\N		\N	\N	1	242	2964	\N	\N	1	15	7	9	11
1445	\N	La Gorgona	\N	0	4	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	9	11
1446	\N	Puerto Wilches	\N	0	4	0	0	\N	\N	\N		\N	\N	1	67	1119	\N	\N	1	15	7	9	11
1447	\N	Montecarmelo	\N	0	4	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	9	11
1448	\N	San Alberto	\N	0	1	0	0	\N	\N	\N		\N	\N	1	55	688	\N	\N	1	15	7	9	12
1449	\N	Trinidad	\N	0	1	0	0	\N	\N	\N		\N	\N	1	55	688	\N	\N	1	15	7	9	12
1450	\N	21 De Abril	\N	0	1	0	0	\N	\N	\N		\N	\N	1	55	688	\N	\N	1	15	7	9	12
1451	\N	Monserrate	\N	0	1	0	0	\N	\N	\N		\N	\N	1	55	688	\N	\N	1	15	7	9	12
1452	\N	Ocaña	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	9	12
1453	\N	Pailitas	\N	0	2	0	0	\N	\N	\N		\N	\N	1	55	683	\N	\N	1	15	7	9	12
1454	\N	Aguachica	\N	0	4	0	0	\N	\N	\N		\N	\N	1	55	688	\N	\N	1	15	7	9	12
1455	\N	Barranquilla	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	9	13
1456	\N	Valledupar	\N	0	1	0	0	\N	\N	\N		\N	\N	1	55	667	\N	\N	1	15	7	9	13
1457	\N	Cartagena	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	9	13
1458	\N	Pueblo Bello	\N	0	2	0	0	\N	\N	\N		\N	\N	1	55	685	\N	\N	1	15	7	9	13
1459	\N	Sabanalarga	\N	0	2	0	0	\N	\N	\N		\N	\N	1	47	342	\N	\N	1	15	7	9	13
1460	\N	Santa Marta	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	9	13
1461	\N	Santo Tomas	\N	0	2	0	0	\N	\N	\N		\N	\N	1	48	399	\N	\N	1	15	7	9	13
1462	\N	Sincelejo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	68	1138	\N	\N	1	15	7	9	14
1463	\N	Magangué	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	9	14
1464	\N	Cerete	\N	0	2	0	0	\N	\N	\N		\N	\N	1	56	695	\N	\N	1	15	7	9	14
1465	\N	Monteria	\N	0	2	0	0	\N	\N	\N		\N	\N	1	56	692	\N	\N	1	15	7	9	14
1466	\N	San Gregorio	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	9	14
1467	\N	San Mateo	\N	0	2	0	0	\N	\N	\N		\N	\N	1	51	551	\N	\N	1	15	7	9	14
1468	\N	Pueblo Rico	\N	0	2	0	0	\N	\N	\N		\N	\N	1	66	1061	\N	\N	1	15	7	9	14
1469	\N	Providencia	\N	0	2	0	0	\N	\N	\N		\N	\N	1	63	989	\N	\N	1	15	7	9	14
1470	\N	Santana	\N	0	2	0	0	\N	\N	\N		\N	\N	1	51	554	\N	\N	1	15	7	9	14
1471	\N	Caucasia	\N	0	4	0	0	\N	\N	\N		\N	\N	1	47	291	\N	\N	1	15	7	9	14
1472	\N	Sogamoso	\N	0	1	0	0	\N	\N	\N		\N	\N	1	51	564	\N	\N	1	15	7	10	15
1473	\N	Ubate	\N	0	1	0	0	\N	\N	\N		\N	\N	1	57	817	\N	\N	1	15	7	10	15
1474	\N	Barbosa-Santana	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	10	15
1475	\N	Garagoa-Juntas	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	10	15
1476	\N	Chiquinquirá	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	10	15
1477	\N	Bravo Páez	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	10	16
1478	\N	Kennedy	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	10	16
1479	\N	El Portal	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	10	16
1480	\N	Leticia	\N	0	2	0	0	\N	\N	\N		\N	\N	1	75	1273	\N	\N	1	15	7	10	16
1481	\N	Caparrapi	\N	0	2	0	0	\N	\N	\N		\N	\N	1	57	729	\N	\N	1	15	7	10	16
1482	\N	Viota	\N	0	4	0	0	\N	\N	\N		\N	\N	1	57	825	\N	\N	1	15	7	10	16
1483	\N	Cundinamarca	\N	0	4	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	10	16
1484	\N	Quebradanegra	\N	0	4	0	0	\N	\N	\N		\N	\N	1	57	785	\N	\N	1	15	7	10	16
1485	\N	La Mesa	\N	0	4	0	0	\N	\N	\N		\N	\N	1	57	764	\N	\N	1	15	7	10	16
1486	\N	Fusagasuga	\N	0	1	0	0	\N	\N	\N		\N	\N	1	57	747	\N	\N	1	15	7	10	17
1487	\N	Girardot	\N	0	1	0	0	\N	\N	\N		\N	\N	1	57	752	\N	\N	1	15	7	10	17
1488	\N	Ibagué	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	10	17
1489	\N	San Bernardo	\N	0	2	0	0	\N	\N	\N		\N	\N	1	57	791	\N	\N	1	15	7	10	17
1490	\N	Icononzo	\N	0	2	0	0	\N	\N	\N		\N	\N	1	69	1180	\N	\N	1	15	7	10	17
1491	\N	Guamitos	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	10	17
1492	\N	Varsovia	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	10	17
1493	\N	Pueblo Nuevo	\N	0	2	0	0	\N	\N	\N		\N	\N	1	56	707	\N	\N	1	15	7	10	17
1494	\N	Guamo	\N	0	2	0	0	\N	\N	\N		\N	\N	1	69	1177	\N	\N	1	15	7	10	17
1495	\N	Los Alpes	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	10	17
1496	\N	Villavicencio	\N	0	1	0	0	\N	\N	\N		\N	\N	1	62	925	\N	\N	1	15	7	10	18
1497	\N	Acacias	\N	0	1	0	0	\N	\N	\N		\N	\N	1	62	926	\N	\N	1	15	7	10	18
1498	\N	Granada	\N	0	1	0	0	\N	\N	\N		\N	\N	1	47	309	\N	\N	1	15	7	10	18
1499	\N	Tame	\N	0	1	0	0	\N	\N	\N		\N	\N	1	71	1244	\N	\N	1	15	7	10	18
1500	\N	Fortul	\N	0	1	0	0	\N	\N	\N		\N	\N	1	71	1241	\N	\N	1	15	7	10	18
1501	\N	Saravena	\N	0	1	0	0	\N	\N	\N		\N	\N	1	71	1243	\N	\N	1	15	7	10	18
1502	\N	Aguazul	\N	0	2	0	0	\N	\N	\N		\N	\N	1	72	1246	\N	\N	1	15	7	10	18
1503	\N	Turbo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	47	369	\N	\N	1	15	7	11	19
1504	\N	Apartadó	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	19
1505	\N	Medellín	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	19
1506	\N	Kennedy	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	19
1507	\N	Don Matias	\N	0	1	0	0	\N	\N	\N		\N	\N	1	47	299	\N	\N	1	15	7	11	19
1508	\N	San Roque	\N	0	1	0	0	\N	\N	\N		\N	\N	1	47	355	\N	\N	1	15	7	11	19
1509	\N	Quibdó	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	19
1510	\N	Armas	\N	0	4	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	19
1511	\N	Peque	\N	0	4	0	0	\N	\N	\N		\N	\N	1	47	334	\N	\N	1	15	7	11	19
1512	\N	Santa Fe De Antioquia	\N	0	4	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	19
1513	\N	Lejanias	\N	0	4	0	0	\N	\N	\N		\N	\N	1	62	940	\N	\N	1	15	7	11	19
1514	\N	Dosquebradas	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	20
1515	\N	Cartago	\N	0	1	0	0	\N	\N	\N		\N	\N	1	70	1212	\N	\N	1	15	7	11	20
1516	\N	Alcalá	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	20
1517	\N	Tebaida	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	20
1518	\N	Calarcá	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	20
1519	\N	Manizales	\N	0	1	0	0	\N	\N	\N		\N	\N	1	52	590	\N	\N	1	15	7	11	20
1520	\N	Aranzazu	\N	0	2	0	0	\N	\N	\N		\N	\N	1	52	593	\N	\N	1	15	7	11	20
1521	\N	Manzanares	\N	0	2	0	0	\N	\N	\N		\N	\N	1	52	599	\N	\N	1	15	7	11	20
1522	\N	Santa Rosa	\N	0	1	0	0	\N	\N	\N		\N	\N	1	50	460	\N	\N	1	15	7	11	20
1523	\N	Neira	\N	0	2	0	0	\N	\N	\N		\N	\N	1	52	603	\N	\N	1	15	7	11	20
1524	\N	Quinchia	\N	0	1	0	0	\N	\N	\N		\N	\N	1	66	1062	\N	\N	1	15	7	11	21
1525	\N	Insetes	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	21
1526	\N	Anserma	\N	0	1	0	0	\N	\N	\N		\N	\N	1	52	592	\N	\N	1	15	7	11	21
1527	\N	Irra	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	21
1528	\N	Cali	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	22
1529	\N	Tuluá	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	22
1530	\N	Morroplancho	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	22
1531	\N	La Union	\N	0	1	0	0	\N	\N	\N		\N	\N	1	4	42	\N	\N	1	15	7	11	22
1532	\N	Zarzal	\N	0	4	0	0	\N	\N	\N		\N	\N	1	70	1237	\N	\N	1	15	7	11	22
1533	\N	Toro	\N	0	4	0	0	\N	\N	\N		\N	\N	1	70	1229	\N	\N	1	15	7	11	22
1534	\N	El Cremal	\N	0	4	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	22
1535	\N	Campoalegre	\N	0	4	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	22
1536	\N	Corinto	\N	0	2	0	0	\N	\N	\N		\N	\N	1	54	639	\N	\N	1	15	7	11	22
1537	\N	Palmira	\N	0	4	0	0	\N	\N	\N		\N	\N	1	70	1224	\N	\N	1	15	7	11	22
1538	\N	Jamundi	\N	0	4	0	0	\N	\N	\N		\N	\N	1	70	1221	\N	\N	1	15	7	11	22
1539	\N	Yumbo	\N	0	4	0	0	\N	\N	\N		\N	\N	1	70	1236	\N	\N	1	15	7	11	22
1540	\N	Puente Velez	\N	0	4	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	22
1541	\N	Tocota	\N	0	4	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	22
1542	\N	Melenas	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	22
1543	\N	Salonica	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	22
1544	\N	Puente Loro	\N	0	4	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	11	22
1545	\N	Neiva	\N	0	1	0	0	\N	\N	\N		\N	\N	1	59	854	\N	\N	1	15	7	12	23
1546	\N	Planadas	\N	0	2	0	0	\N	\N	\N		\N	\N	1	69	1190	\N	\N	1	15	7	12	23
1547	\N	Garzon	\N	0	1	0	0	\N	\N	\N		\N	\N	1	59	864	\N	\N	1	15	7	12	23
1548	\N	Acevedo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	59	855	\N	\N	1	15	7	12	23
1549	\N	Pitalito	\N	0	1	0	0	\N	\N	\N		\N	\N	1	59	876	\N	\N	1	15	7	12	23
1550	\N	Algeciras	\N	0	1	0	0	\N	\N	\N		\N	\N	1	59	858	\N	\N	1	15	7	12	23
1551	\N	Piedramarcada	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	12	23
1552	\N	Palermo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	59	874	\N	\N	1	15	7	12	23
1553	\N	Canoas	\N	0	1	0	0	\N	\N	\N		\N	\N	1	343	9874	\N	\N	1	15	7	12	23
1554	\N	La Plata	\N	0	1	0	0	\N	\N	\N		\N	\N	1	59	870	\N	\N	1	15	7	12	23
1555	\N	Guayabal	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	12	23
1556	\N	Santana	\N	0	4	0	0	\N	\N	\N		\N	\N	1	51	554	\N	\N	1	15	7	12	23
1557	\N	Florencia	\N	0	1	0	0	\N	\N	\N		\N	\N	1	53	617	\N	\N	1	15	7	12	24
1558	\N	Curillo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	53	621	\N	\N	1	15	7	12	24
1559	\N	Valparaíso	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	12	24
1560	\N	San Vicente	\N	0	1	0	0	\N	\N	\N		\N	\N	1	47	356	\N	\N	1	15	7	12	24
1561	\N	La Macarena	\N	0	1	0	0	\N	\N	\N		\N	\N	1	62	938	\N	\N	1	15	7	12	24
1562	\N	San Vicente	\N	0	1	0	0	\N	\N	\N		\N	\N	1	47	356	\N	\N	1	15	7	12	24
1563	\N	Belen	\N	0	2	0	0	\N	\N	\N		\N	\N	1	51	474	\N	\N	1	15	7	12	24
1564	\N	Mocoa	\N	0	1	0	0	\N	\N	\N		\N	\N	1	73	1262	\N	\N	1	15	7	12	25
1565	\N	Orito	\N	0	1	0	0	\N	\N	\N		\N	\N	1	73	1264	\N	\N	1	15	7	12	25
1566	\N	La Hormiga	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	12	25
1567	\N	Puerto Leguizamo	\N	0	2	0	0	\N	\N	\N		\N	\N	1	73	1268	\N	\N	1	15	7	12	25
1568	\N	Perlas	\N	0	2	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	12	25
1569	\N	Popayan	\N	0	1	0	0	\N	\N	\N		\N	\N	1	54	632	\N	\N	1	15	7	12	26
1570	\N	Pasto	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	15	7	12	26
1571	\N	El Llano	\N	0	1	0	0	\N	\N	\N		\N	\N	1	268	3251	\N	\N	1	15	7	12	26
1572	\N	San Felipe	\N	0	1	0	0	\N	\N	\N		\N	\N	1	76	1284	\N	\N	1	15	7	12	26
1573	\N	Ambato	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1574	\N	Cevallos	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1575	\N	Cojimies	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1576	\N	El Valle	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1577	\N	Esmeraldas	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1578	\N	Golondrinas	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1579	\N	Ibarra	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1580	\N	Juan Eulogio	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1581	\N	La Concordia	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1582	\N	La Magdalena	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1583	\N	Las Mercedes	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1584	\N	Monte Bello	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1585	\N	Pastocalle	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1586	\N	Pimampiro	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1587	\N	Puerto Quito	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1588	\N	Puerto Rico	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1589	\N	Quero	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1590	\N	Tabacundo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1591	\N	Tulcán	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1592	\N	Unidad Nacional	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	27
1593	\N	Babahoyo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1594	\N	Bahía	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1595	\N	Chone	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1596	\N	Durán	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1597	\N	El Deseo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1598	\N	Guabito	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1599	\N	Guasmo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1600	\N	Guayaquil	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1601	\N	La Maná	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1602	\N	Libertad	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1603	\N	Manta	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1604	\N	Mata de Cacao	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1605	\N	Portoviejo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1606	\N	Quevedo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1607	\N	Ventanas	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	28
1608	\N	Arenillas	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1609	\N	Nueva Unida Sur	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1610	\N	Catamayo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1611	\N	Cuenca	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1612	\N	Cumbe	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1613	\N	Huaquillas	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1614	\N	Km 31	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1615	\N	Loja	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1616	\N	Machala	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1617	\N	Naranjito	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1618	\N	Reyes Vega	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1619	\N	Torres Causana	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1620	\N	Vilcabamba	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	29
1621	\N	Coca	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	30
1622	\N	Conambo	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	30
1623	\N	Joya de los Sachas	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	30
1624	\N	Lago Agrio	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	30
1625	\N	Las Mercedes	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	30
1626	\N	Loreto	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	30
1627	\N	Shushufindi	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	30
1628	\N	Santa Cruz	\N	0	1	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	3	8	13	31
1629	\N	Montevideo	\N	0	1	0	0	\N	\N	\N	Comercio 2286 esquina Agustín Sosa	\N	\N	1	0	0	\N	\N	1	7	9	14	32
1630	\N	Delta	\N	0	1	0	0	\N	\N	\N	Samoa manzana 76 solar 28	\N	\N	1	0	0	\N	\N	1	7	9	14	33
1631	\N	Pando	\N	0	1	0	0	\N	\N	\N	Camino las Piedritas s/n ruta 7 km 32,5	\N	\N	1	0	0	\N	\N	1	7	9	14	34
1632	\N	Rosario	\N	0	1	0	0	\N	\N	\N	Grito de Asencio n° 170	\N	\N	1	0	0	\N	\N	1	7	9	14	35
1633	\N	Chimaltenango	\N	0	1	0	0	\N	\N	\N	07 avenida Sociedad Mision, zona 8,  Chimaltenango	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1634	\N	Jutiapa	\N	0	1	0	0	\N	\N	\N	zona 3 de Jutiapa	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1635	\N	Campo Comapa	\N	0	5	0	0	\N	\N	\N	Aldea El Carrizal, Comapa Jutiapa	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1636	\N	Campo de San Luis Jilotepeque	\N	0	5	0	0	\N	\N	\N	Aldea Los Olivos San Luis Jilotepeque Jalapa.	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1637	\N	Campo San Diego	\N	0	5	0	0	\N	\N	\N	Aldea Los Olivos San Luis Jilotepeque Jalapa.	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1638	\N	La Repegua	\N	0	1	0	0	\N	\N	\N	Colonia la Repegua,Santo Tomás de Castilla, Puerto Barrios  Izabal	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1639	\N	Morales	\N	0	1	0	0	\N	\N	\N	Colonia Santa Barbara, Morales Izabal	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1640	\N	Placa I	\N	0	1	0	0	\N	\N	\N	Placa uno  entre rios puerto barrios izabal	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1641	\N	San José Pinula	\N	0	1	0	0	\N	\N	\N	Sector 1 Lote 14 Los achotes Aldea El Platanar	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1642	\N	Villa Nueva	\N	0	1	0	0	\N	\N	\N	0 avenida "D" 1-59 zona 6, colonia herores de villa nueva	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1643	\N	Zona 18	\N	0	1	0	0	\N	\N	\N	Lote No.46, Seccion el Mirador, Colonia las ilusiones, zona 18	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1644	\N	Zona 7	\N	0	1	0	0	\N	\N	\N	9a. Calle 3-24 zona 7 colonia landívar	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1645	\N	Zona 2	\N	0	1	0	0	\N	\N	\N	8 av  0-62 zona 2 barrio moderno	\N	\N	1	0	0	\N	\N	1	19	10	15	35
1646	\N	Coatepeque	\N	0	1	0	0	\N	\N	\N	9. avenida 8-05 zona 4, Barrio Candelaria, Coatepeque Quetzaltenango	\N	\N	1	0	0	\N	\N	1	19	10	15	36
1647	\N	Campo Finca la fe	\N	0	5	0	0	\N	\N	\N	Colonia de la Reforma, departamento de San Marcos	\N	\N	1	0	0	\N	\N	1	19	10	15	36
1648	\N	Las Trochas	\N	0	1	0	0	\N	\N	\N	Trocha 2 calle vieja nueva concepción, Escuintla	\N	\N	1	0	0	\N	\N	1	19	10	15	36
1649	\N	Pueblo Nuevo	\N	0	1	0	0	\N	\N	\N	Pueblo Nuevo Suchitepéquez, cantón el Mangal zona 0 calle principal.	\N	\N	1	0	0	\N	\N	1	19	10	15	36
1650	\N	Puerto de San José	\N	0	1	0	0	\N	\N	\N	7 Calle Lote 15 Nazareth Peñate, Puerto San Jose	\N	\N	1	0	0	\N	\N	1	19	10	15	36
1651	\N	Reposo	\N	0	1	0	0	\N	\N	\N	Parselamiento el Reposo sector B parsela B-46,Génova costacuca, Quetzaltenango	\N	\N	1	0	0	\N	\N	1	19	10	15	36
1652	\N	Tecún Umán	\N	0	1	0	0	\N	\N	\N	12 calle 3 y 4 ave. Zina 3. Colonia La Verde, Tecun Uman San Marcos	\N	\N	1	0	0	\N	\N	1	19	10	15	36
1653	\N	Tiquisate	\N	0	1	0	0	\N	\N	\N	12 calle 4-14 zona 2, Tiquisate	\N	\N	1	0	0	\N	\N	1	19	10	15	36
1654	\N	Cobán	\N	0	1	0	0	\N	\N	\N	10 avenida 2-70 zona 3, Barrio San Juan Acalá, Cobán, Alta Verapaz	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1655	\N	Campo las Cruces Péten	\N	0	5	0	0	\N	\N	\N	Municipio de Dolores Peten	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1656	\N	Miramar	\N	0	1	0	0	\N	\N	\N	Miramar lote 1 Panzós Alta Verapaz	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1657	\N	Naranjales	\N	0	1	0	0	\N	\N	\N	Finca los Naranjales Municipio de Senahú Alta Verapaz.	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1658	\N	Playa Grande	\N	0	1	0	0	\N	\N	\N	Lote 486 zona 2 Playa Grande Ixcàn Quiche.	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1659	\N	Campo Póptun	\N	0	5	0	0	\N	\N	\N	aldea poptún, Petén	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1660	\N	Raxón S.M. Panzos	\N	0	1	0	0	\N	\N	\N	Parcelamiento Raxon San, Marcos municipio de Panzós Alta verapaz\n\nMarcos municipio de Panzós Alta verapaz\n\nParcelamiento Raxon San \n\nMarcos municipio de Panzós Alta verapaz\n\nParcelamiento Raxon San \n\nMarcos municipio de Panzós Alta verapaz	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1661	\N	Roberto Barrios	\N	0	1	0	0	\N	\N	\N	Palenque Chiapas, Roberto Barrios mexico.	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1662	\N	Salacuin	\N	0	1	0	0	\N	\N	\N	Sector 3, Aldea salacuim coban, Alta Verapaz.	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1663	\N	San Benito	\N	0	1	0	0	\N	\N	\N	Calzada Virgilio Rodriguez Macal, Barrio 3 de Abril, San Benito Petén	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1664	\N	San Vicente	\N	0	1	0	0	\N	\N	\N	Caserío San Vicente 2 Municipio de la Tinta Alta Verapaz.	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1665	\N	Teleman	\N	0	1	0	0	\N	\N	\N	Aldea teleman municipio de panzos A V .barrio el centro	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1666	\N	Trinidad	\N	0	1	0	0	\N	\N	\N	Colonia la Trinidad II carcha, Alta Verapaz	\N	\N	1	0	0	\N	\N	1	19	10	15	37
1667	\N	El Mirador	\N	0	1	0	0	\N	\N	\N	Aldea Nueva San Antonio, de San Carlos Sija, Quetzaltenango	\N	\N	1	0	0	\N	\N	1	19	10	15	38
1668	\N	Quetzaltenango zona 3	\N	0	1	0	0	\N	\N	\N	13 avenida "A" 8-42 Quetzaltenango	\N	\N	1	0	0	\N	\N	1	19	10	15	38
1669	\N	Quetzaltenango zona 5	\N	0	1	0	0	\N	\N	\N	Diagonal 15, 7-68 zona 5 Quetzaltenango.	\N	\N	1	0	0	\N	\N	1	19	10	15	38
1670	\N	Rachoaquel	\N	0	1	0	0	\N	\N	\N	Chuiaj caserío rachoaquel, aldea xequemeyá, municipio de momostenango, dpto. de Totonicapan	\N	\N	1	0	0	\N	\N	1	19	10	15	38
1671	\N	San Carlos Sija	\N	0	1	0	0	\N	\N	\N	Aldea Chuicabal, Quetzaltenango	\N	\N	1	0	0	\N	\N	1	19	10	15	38
1672	\N	Campo Pachute	\N	0	5	0	0	\N	\N	\N	Aldea Chuicabal, Quetzaltenango	\N	\N	1	0	0	\N	\N	1	19	10	15	38
1673	\N	Campo Sibilia	\N	0	5	0	0	\N	\N	\N	Aldea Chuicabal, Quetzaltenango	\N	\N	1	0	0	\N	\N	1	19	10	15	38
1674	\N	Campo Chuicabal	\N	0	5	0	0	\N	\N	\N	Aldea Chiucabal, municipio de sibilia departamento de Quetzaltenango	\N	\N	1	0	0	\N	\N	1	19	10	15	38
1675	\N	San Ramón	\N	0	1	0	0	\N	\N	\N	Cantón San Ramón,  San Cristóbal Totonicapan	\N	\N	1	0	0	\N	\N	1	19	10	15	38
1676	\N	Totonicapán	\N	0	1	0	0	\N	\N	\N	10 avenida Final zona 3 (por los baños antiguos)Totonicapan Totonicapan	\N	\N	1	0	0	\N	\N	1	19	10	15	38
1677	\N	Xexacmalja	\N	0	1	0	0	\N	\N	\N	Canton Xesacmalja, sector 1 frente a la escuela, Totonicapan, Totonicapan	\N	\N	1	0	0	\N	\N	1	19	10	15	38
1678	\N	Xetena	\N	0	1	0	0	\N	\N	\N	Carretera San vicente Nuevabaj (enfrente de la gasolina), Totonicapan, Totonicapan	\N	\N	1	0	0	\N	\N	1	19	10	15	38
1679	\N	Campo de Sololá	\N	0	5	0	0	\N	\N	\N		\N	\N	1	0	0	\N	\N	1	19	10	15	39
1680	\N	Chiché	\N	0	1	0	0	\N	\N	\N	Barrio la Joya, Chiché Quiché	\N	\N	1	0	0	\N	\N	1	19	10	15	39
1681	\N	Chichicastenango	\N	0	1	0	0	\N	\N	\N	Km. 148 Chulumal primero chichicastenango, Quiché	\N	\N	1	0	0	\N	\N	1	19	10	15	39
1682	\N	Chiul	\N	0	1	0	0	\N	\N	\N	Aldea Chiul (frente a una farmacia municio), Cunén Quiche	\N	\N	1	0	0	\N	\N	1	19	10	15	39
1683	\N	El Mamaj	\N	0	1	0	0	\N	\N	\N	Canton Mamaj Aldea Chujuyub, Santa Cruz del Quiche .	\N	\N	1	0	0	\N	\N	1	19	10	15	39
1684	\N	Las Minas	\N	0	1	0	0	\N	\N	\N	Canton las minas aldea chujuyub, departamento del quiche.	\N	\N	1	0	0	\N	\N	1	19	10	15	39
1685	\N	Nebaj	\N	0	1	0	0	\N	\N	\N	Canton jactzal Nebaj el Quiche , Calle que va al rastro\nCalle que va al rastro	\N	\N	1	0	0	\N	\N	1	19	10	15	39
1686	\N	Salinas	\N	0	1	0	0	\N	\N	\N	Segundo centro, Salinas magdalenas sacapulas, Quiché	\N	\N	1	0	0	\N	\N	1	19	10	15	39
1687	\N	Santa Cruz del Quiché	\N	0	1	0	0	\N	\N	\N	3 avenida 2 calle zona 1, Santa Cruz del Quiché	\N	\N	1	0	0	\N	\N	1	19	10	15	39
1688	\N	Santa Elena	\N	0	1	0	0	\N	\N	\N	Canton Mixcolajá, municipio de San Andrés Sajcabajá, departamento de Quiché	\N	\N	1	0	0	\N	\N	1	19	10	15	39
1689	\N	Tierra Caliente	\N	0	1	0	0	\N	\N	\N	Cantón Los Reyes, Aldea chujuyub el Quiché	\N	\N	1	0	0	\N	\N	1	19	10	15	39
1690	\N	Xatinap I	\N	0	1	0	0	\N	\N	\N	El Puente Xatinap Primero, Quiché	\N	\N	1	0	0	\N	\N	1	19	10	15	39
1691	\N	Alto Hospicio	\N	0	0	0	0	\N	\N	\N	Calle Alemania Mz 94 Sitio 7  Sector la Pampa	\N	\N	1	0	0	\N	\N	1	14	11	16	40
1692	\N	Calama	\N	0	0	0	0	\N	\N	\N	Pasaje Colonia Oriente 3442 Población: René Schneider	\N	\N	1	0	0	\N	\N	1	14	11	16	40
1693	\N	Antofagasta	\N	0	0	0	0	\N	\N	\N	Campamento Américas Unidas – Casa 25	\N	\N	1	0	0	\N	\N	1	14	11	16	40
1694	\N	Vallenar	\N	0	0	0	0	\N	\N	\N	Manutara 2393 Esquina Guacolda, Población: Rafael Torre Blanca	\N	\N	1	0	0	\N	\N	1	14	11	16	41
1695	\N	La Serena	\N	0	0	0	0	\N	\N	\N	Calle Fotógrafo Mario Alegría 3494, Población: El Toqui Compañía	\N	\N	1	0	0	\N	\N	1	14	11	16	41
1696	\N	Santiago	\N	0	0	0	0	\N	\N	\N	Club Hípico 5181. Comuna: Pedro Aguirre Cerda	\N	\N	1	0	0	\N	\N	1	14	11	16	42
1697	\N	Santiago Norte	\N	0	0	0	0	\N	\N	\N	Isabel Riquelme 4576. Comuna: Renca	\N	\N	1	0	0	\N	\N	1	14	11	16	42
1698	\N	Talagante	\N	0	0	0	0	\N	\N	\N	Pasaje Los Suspiros 1149. Villa: Las Hortensias	\N	\N	1	0	0	\N	\N	1	14	11	16	42
1699	\N	San Sebastián	\N	0	0	0	0	\N	\N	\N	Calle: 3ra Sur 137 Entre París y Fin de Loteo. Cartagena	\N	\N	1	0	0	\N	\N	1	14	11	16	42
1700	\N	Doñihue	\N	0	0	0	0	\N	\N	\N	Pasaje Juan Pablo 1 Nro. 43.  Villa Carlos Schneider Rancagua	\N	\N	1	0	0	\N	\N	1	14	11	16	42
1701	\N	Curicó	\N	0	0	0	0	\N	\N	\N	Río Huasco 49 Población: Sol de Septiembre	\N	\N	1	0	0	\N	\N	1	14	11	16	42
1702	\N	Talca	\N	0	0	0	0	\N	\N	\N	11 Oriente 27 Población: Cristi Gallo	\N	\N	1	0	0	\N	\N	1	14	11	16	42
1703	\N	Linares	\N	0	0	0	0	\N	\N	\N	Abranquil 068  Población: Yerba Buena	\N	\N	1	0	0	\N	\N	1	14	11	16	42
1704	\N	Longaví	\N	0	0	0	0	\N	\N	\N	Población: Villa Nueva Pasaje Los Boldos Con Los Sauces Casa 1	\N	\N	1	0	0	\N	\N	1	14	11	16	42
1705	\N	Arauco	\N	0	0	0	0	\N	\N	\N	Israel 46 Población: Belén	\N	\N	1	0	0	\N	\N	1	14	11	16	43
1706	\N	Cañete	\N	0	0	0	0	\N	\N	\N	Tucapel Senda 2 Villa Magisterio S/N	\N	\N	1	0	0	\N	\N	1	14	11	16	43
1707	\N	Quidico	\N	0	0	0	0	\N	\N	\N	Avenida Costanera S/N	\N	\N	1	0	0	\N	\N	1	14	11	16	43
1708	\N	Chillán	\N	0	0	0	0	\N	\N	\N	Ignacio Serrano 255 interior. Chillán Viejo	\N	\N	1	0	0	\N	\N	1	14	11	16	43
1709	\N	Chiguayante-Penco-Las Quilas	\N	0	0	0	0	\N	\N	\N	Victor Burgos 22, detrás del Easy	\N	\N	1	0	0	\N	\N	1	14	11	16	43
1710	\N	Los Ángeles	\N	0	0	0	0	\N	\N	\N	Las Azaleas 759  Población:  Santiago Bueras	\N	\N	1	0	0	\N	\N	1	14	11	16	44
1711	\N	Temuco	\N	0	0	0	0	\N	\N	\N	Inés de Suarez 310 Pedro de Valdivia	\N	\N	1	0	0	\N	\N	1	14	11	16	44
1712	\N	Labranza	\N	0	0	0	0	\N	\N	\N	Villa: Los Apóstoles Calle: Esperanza 1011	\N	\N	1	0	0	\N	\N	1	14	11	16	44
1713	\N	Río Claro	\N	0	0	0	0	\N	\N	\N	San Miguel de Unihue	\N	\N	1	0	0	\N	\N	1	14	11	16	44
1714	\N	Repocura	\N	0	0	0	0	\N	\N	\N	Repocura	\N	\N	1	0	0	\N	\N	1	14	11	16	44
1715	\N	Laja	\N	0	0	0	0	\N	\N	\N	Los Acacias 89	\N	\N	1	0	0	\N	\N	1	14	11	16	44
1716	\N	Katrirrehue	\N	0	0	0	0	\N	\N	\N	Comuna: De Saavedra	\N	\N	1	0	0	\N	\N	1	14	11	16	44
1717	\N	San José de la Mariquina	\N	0	0	0	0	\N	\N	\N	Ernesto Riquelme 1201	\N	\N	1	0	0	\N	\N	1	14	11	16	45
1733	\N	Central Pucara	\N	0	1	0	0	\N	\N	\N	Calle Innominada y Av. Panamericana	\N	\N	1	0	0	\N	\N	1	8	12	17	46
1734	\N	Quillacollo	\N	0	1	0	0	\N	\N	\N	Z. Llauquenquiri lado del cementerio	\N	\N	1	0	0	\N	\N	1	8	12	17	46
1735	\N	1ro de mayo	\N	0	1	0	0	\N	\N	\N	Z. 1ro de Mayo	\N	\N	1	0	0	\N	\N	1	8	12	17	46
1736	\N	Sacaba	\N	0	1	0	0	\N	\N	\N	Av. America y Carretera Chapare	\N	\N	1	0	0	\N	\N	1	8	12	17	46
1737	\N	Tolata	\N	0	1	0	0	\N	\N	\N	Carretera Punata, de la rotonda 4 cuadras norte	\N	\N	1	0	0	\N	\N	1	8	12	17	46
1738	\N	Punata	\N	0	1	0	0	\N	\N	\N	Z. Chilcar chico	\N	\N	1	0	0	\N	\N	1	8	12	17	46
1739	\N	Curiuma	\N	0	1	0	0	\N	\N	\N	Z. Coriuma	\N	\N	1	0	0	\N	\N	1	8	12	17	46
1740	\N	Ivirgarzama	\N	0	1	0	0	\N	\N	\N	Av. Santa cruz	\N	\N	1	0	0	\N	\N	1	8	12	17	46
1741	\N	Quintanilla	\N	0	1	0	0	\N	\N	\N	Av. Quintanilla soasu antes de ex said	\N	\N	1	0	0	\N	\N	1	8	12	18	47
1742	\N	La Fortuna	\N	0	1	0	0	\N	\N	\N	Carretera Copacabana Zona la Fortuna	\N	\N	1	0	0	\N	\N	1	8	12	18	47
1743	\N	Viacha	\N	0	1	0	0	\N	\N	\N	Av. Bolivar entre calle 3	\N	\N	1	0	0	\N	\N	1	8	12	18	47
1744	\N	Ancocala	\N	0	1	0	0	\N	\N	\N	Carretera desaguadero comunidad ancocala	\N	\N	1	0	0	\N	\N	1	8	12	18	47
1745	\N	Rio Seco	\N	0	1	0	0	\N	\N	\N	Calle Luis espinal y Av. Juan Pablo II	\N	\N	1	0	0	\N	\N	1	8	12	18	47
1746	\N	Villa Coroico	\N	0	1	0	0	\N	\N	\N	Comunidad Villa Coroico plena carretra	\N	\N	1	0	0	\N	\N	1	8	12	18	47
1747	\N	Muñecas	\N	0	1	0	0	\N	\N	\N	Colonia Muñecas	\N	\N	1	0	0	\N	\N	1	8	12	18	47
1748	\N	Caranavi	\N	0	1	0	0	\N	\N	\N	Calle Kennedi entre calle 2	\N	\N	1	0	0	\N	\N	1	8	12	18	47
1749	\N	Llallagua	\N	0	1	0	0	\N	\N	\N	Comunidad Llallagua	\N	\N	1	0	0	\N	\N	1	8	12	19	48
1750	\N	Potosi	\N	0	1	0	0	\N	\N	\N	Z. Potosi Alto	\N	\N	1	0	0	\N	\N	1	8	12	19	48
1751	\N	Tarija	\N	0	1	0	0	\N	\N	\N	Carretera San Mateo	\N	\N	1	0	0	\N	\N	1	8	12	19	49
1752	\N	Santa Cruz	\N	0	1	0	0	\N	\N	\N	Calle Virgen de Cotoca y Av. El Mechero	\N	\N	1	0	0	\N	\N	1	8	12	20	50
1753	\N	Trinidad	\N	0	1	0	0	\N	\N	\N	Av. Ejercito y calle La paz	\N	\N	1	0	0	\N	\N	1	8	12	20	51
1754	\N	Esteli	\N	0	1	0	0	\N	\N	\N	De donde fue el cine Nancy 2 cuadras al oeste	\N	\N	1	0	0	\N	\N	1	21	13	21	52
1755	\N	San Luis	\N	0	1	0	0	\N	\N	\N	Comunidad San Luis - Esteli	\N	\N	1	0	0	\N	\N	1	21	13	21	52
1756	\N	Somoto	\N	0	1	0	0	\N	\N	\N	Frente a Petronic - Somoto	\N	\N	1	0	0	\N	\N	1	21	13	21	52
1757	\N	Las Chilcas	\N	0	1	0	0	\N	\N	\N	Comunidad Las Chilcas - Esteli	\N	\N	1	0	0	\N	\N	1	21	13	21	52
1758	\N	El Peñasco	\N	0	1	0	0	\N	\N	\N	Comunidad El Peñasco - Esteli	\N	\N	1	0	0	\N	\N	1	21	13	21	52
1759	\N	San Antonio	\N	0	1	0	0	\N	\N	\N	Comunidad San Antonio - Esteli	\N	\N	1	0	0	\N	\N	1	21	13	21	52
1760	\N	Telpaneca	\N	0	1	0	0	\N	\N	\N	Comunidad Telpaneca - Somoto	\N	\N	1	0	0	\N	\N	1	21	13	21	52
1761	\N	Sebaco	\N	0	1	0	0	\N	\N	\N	De los graneros 2 c al este y 1 al sur - Sebaco	\N	\N	1	0	0	\N	\N	1	21	13	21	52
1762	\N	San Miguel - El Vijao	\N	0	1	0	0	\N	\N	\N	Comunidad San Miguel El Vijao - Matagalpa	\N	\N	1	0	0	\N	\N	1	21	13	21	53
1763	\N	San Martín - El Vijao	\N	0	1	0	0	\N	\N	\N	Comunidad San Martín - La Dalia	\N	\N	1	0	0	\N	\N	1	21	13	21	53
1764	\N	La Dalia	\N	0	1	0	0	\N	\N	\N	De la Catedral 2c al este, y 1/2c al norte	\N	\N	1	0	0	\N	\N	1	21	13	21	53
1765	\N	Piedra Luna	\N	0	1	0	0	\N	\N	\N	Comunidad Piedra Luna contiguo a la escuela - La Dalia	\N	\N	1	0	0	\N	\N	1	21	13	21	53
1766	\N	El Tigre	\N	0	1	0	0	\N	\N	\N	Comunidad El Tigre - La Dalia	\N	\N	1	0	0	\N	\N	1	21	13	21	53
1767	\N	Coyolar	\N	0	1	0	0	\N	\N	\N	Comunidad Coyolar - La Dalia	\N	\N	1	0	0	\N	\N	1	21	13	21	53
1768	\N	Matagalpa	\N	0	1	0	0	\N	\N	\N	Costado oeste de maxi pali Matagalpa	\N	\N	1	0	0	\N	\N	1	21	13	21	53
1769	\N	Piedra Colorada	\N	0	1	0	0	\N	\N	\N	Comunidad Piedra Colorada - Bocay - Jinotega	\N	\N	1	0	0	\N	\N	1	21	13	21	53
1770	\N	Los Molejones	\N	0	1	0	0	\N	\N	\N	Comunidad Los Molejones - Jinotega	\N	\N	1	0	0	\N	\N	1	21	13	21	53
1771	\N	Nueva Guinea	\N	0	1	0	0	\N	\N	\N	Del mercado costado sur 5 c al norte	\N	\N	1	0	0	\N	\N	1	21	13	21	54
1772	\N	El Rama	\N	0	1	0	0	\N	\N	\N	Rotonda El Rama 500 vrs al este	\N	\N	1	0	0	\N	\N	1	21	13	21	54
1773	\N	La Fonseca	\N	0	1	0	0	\N	\N	\N	Comunidad San Antonio La Fonseca - Nueva Guinea	\N	\N	1	0	0	\N	\N	1	21	13	21	54
1774	\N	Juigalpa	\N	0	1	0	0	\N	\N	\N	De Remasa 1 c al oeste	\N	\N	1	0	0	\N	\N	1	21	13	21	54
1775	\N	Cuapa	\N	0	1	0	0	\N	\N	\N	Del centro de salud 200 vrs arriba	\N	\N	1	0	0	\N	\N	1	21	13	21	54
1776	\N	Santo Tomás	\N	0	1	0	0	\N	\N	\N	Frente a los lavanderos - Santo Tomás	\N	\N	1	0	0	\N	\N	1	21	13	21	54
1777	\N	Nuevo León	\N	0	1	0	0	\N	\N	\N	De la comunal  100 vrs a Nueva Vista - Santo Tomás	\N	\N	1	0	0	\N	\N	1	21	13	21	54
1778	\N	Camoapa	\N	0	1	0	0	\N	\N	\N	Salida a Matamba 1/2 c al sur y 80 vrs al oeste	\N	\N	1	0	0	\N	\N	1	21	13	21	54
1779	\N	El Laurel Galan	\N	0	1	0	0	\N	\N	\N	Comunidad Laurel Galan - Managua	\N	\N	1	0	0	\N	\N	1	21	13	21	55
1780	\N	Belén Managua	\N	0	1	0	0	\N	\N	\N	Bo 14 de Septiembre, de la antena de Claro 2c y 1/2c arriba	\N	\N	1	0	0	\N	\N	1	21	13	21	55
1781	\N	Evenecer Managua	\N	0	1	0	0	\N	\N	\N	De los Semáforos del Madroño 3 c al sur	\N	\N	1	0	0	\N	\N	1	21	13	21	55
1782	\N	Soledad	\N	0	1	0	0	\N	\N	\N	Empalme de Santa Teresa 1 c al sur y 1 al este - Carazo	\N	\N	1	0	0	\N	\N	1	21	13	21	55
1783	\N	Posoltega	\N	0	1	0	0	\N	\N	\N	De donde fueron los rieles 1c al sur, 1c al oeste y 1/2c al sur	\N	\N	1	0	0	\N	\N	1	21	13	21	55
1784	\N	León	\N	0	1	0	0	\N	\N	\N	Urbanizadora Metropolitana en León	\N	\N	1	0	0	\N	\N	1	21	13	21	55
\.


--
-- TOC entry 2572 (class 0 OID 33328)
-- Dependencies: 202
-- Data for Name: institucion; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.institucion (idinstitucion, descripcion, sede, "dirección", telefono, email, iddivision, pais_id, idunion, idmision, iddistritomisionero, idiglesia, nombre, tipo) FROM stdin;
\.


--
-- TOC entry 2574 (class 0 OID 33341)
-- Dependencies: 204
-- Data for Name: laboral_miembro; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.laboral_miembro (idlaboralmiembro, idmiembro, cargo, sector, institucionlaboral, fechainicio, fechafin, periodoini, periodofin) FROM stdin;
\.


--
-- TOC entry 2576 (class 0 OID 33349)
-- Dependencies: 206
-- Data for Name: miembro; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.miembro (idmiembro, pais_id_nacionalidad, iddistritonacimiento, iddistritodomicilio, idtipodoc, idestadocivil, idocupacion, idgradoinstruccion, paterno, materno, nombres, foto, fechanacimiento, lugarnacimiento, sexo, nrodoc, direccion, referenciadireccion, telefono, celular, email, emailalternativo, idreligion, fechabautizo, idcondicioneclesiastica, encargado_recibimiento, observaciones, estado, estadoeliminado, idiglesia, fechaingresoiglesia, fecharegistro, tipolugarnac, ciudadnacextranjero, apellidos, iddepartamentodomicilio, idprovinciadomicilio, iddepartamentonacimiento, idprovincianacimiento, apellido_soltera, pais_id_nacimiento, iddivision, pais_id, idunion, idmision, iddistritomisionero, tabla_encargado_bautizo, encargado_bautizo, observaciones_bautizo, idiomas, texto_bautismal, pais_iddomicilio) FROM stdin;
\.


--
-- TOC entry 2578 (class 0 OID 33380)
-- Dependencies: 208
-- Data for Name: mision; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.mision (idmision, idunion, descripcion, direccion, estado, telefono, email, fax) FROM stdin;
1	1	Misión Oriente	JR. RICARDO PALMA 509	1	957459877	jmanuel.zsinarahua@gmail.com	\N
3	1	Misión Central	JR. RICARDO PALMA 509	1	957459877	bleonardo.gsinarahua@gmail.com	\N
4	1	Misión Sur	JR. RICARDO PALMA 509	1	936 676 722 - 041750004	soportedetallesperuserver@gmail.com	\N
6	3	Asociación Paraguay	JR. RICARDO PALMA 509	1	957459877	jm.zs@hotmail.com	\N
7	5	Caribeña	JR. RICARDO PALMA 509	1	957459877	jmanuel.zsinarahua@gmail.com	\N
8	6	Llanos-Andes	JR. RICARDO PALMA 509	1	957459877	jmanuel.zsinarahua@gmail.com	\N
9	7	Nororiental	\N	1	\N	\N	\N
10	7	Central	\N	1	\N	\N	\N
11	7	Occidental	\N	1	\N	\N	\N
12	7	Sur	\N	1	\N	\N	\N
13	8	Ecuatoriana	\N	1	\N	\N	\N
14	9	Uruguaya	\N	1	\N	\N	\N
15	10	Guatemalteca	\N	1	\N	\N	\N
16	11	Chilena	\N	1	\N	\N	\N
5	7	Asociación Este	JR. RICARDO PALMA 509	1	998038402	jm.zs@hotmail.com	\N
17	12	Mision Central	\N	1	\N	\N	\N
18	12	Mision Oeste	\N	1	\N	\N	\N
19	12	Mision Sur	\N	1	\N	\N	\N
20	12	Mision Oriente	\N	1	\N	\N	\N
21	13	Nicaragüense	\N	1	\N	\N	\N
0	0	No Determinado	\N	1	\N	\N	\N
\.


--
-- TOC entry 2580 (class 0 OID 33391)
-- Dependencies: 210
-- Data for Name: motivobaja; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.motivobaja (idmotivobaja, descripcion) FROM stdin;
1	Dimisión
3	Exclusión
4	Muerte
5	Otros Motivos
6	Renuncia
2	Indisciplina
\.


--
-- TOC entry 2582 (class 0 OID 33397)
-- Dependencies: 212
-- Data for Name: otras_propiedades; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.otras_propiedades (idotrapropiedad, descripcion, cantidad, tipo, iddivision, pais_id, idunion, idmision, iddistritomisionero, idiglesia) FROM stdin;
\.


--
-- TOC entry 2584 (class 0 OID 33402)
-- Dependencies: 214
-- Data for Name: otrospastores; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.otrospastores (idotrospastores, idcargo, nombrecompleto, observaciones, periodo, vigente, estado, idtipodoc, nrodoc) FROM stdin;
\.


--
-- TOC entry 2586 (class 0 OID 33414)
-- Dependencies: 216
-- Data for Name: paises; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.paises (pais_id, pais_descripcion, estado, idioma_id, iddivision, direccion, telefono, posee_union) FROM stdin;
13	México	A	1	1	Jr. Ricardo Palma 509	957459877	S
9	Paraguay	A	1	1	Jr. Ricardo Palma 509	998038402	N
15	Colombia	A	1	1	Jr. Ricardo Palma 509	957459877	S
16	El Salvador	A	1	1	Jr. Ricardo Palma 509	957459877	S
17	Costa Rica	A	1	1	Jr. Ricardo Palma 509	957459877	S
6	Venezuela	A	1	1	Jr. Ricardo Palma 509	957459877	S
8	Bolivia	A	1	1	Jr. Ricardo Palma 509	957459877	S
18	Panama	A	1	1	Jr. Ricardo Palma 509	957459877	S
20	Honduras	A	1	1	Jr. Ricardo Palma 509	957459877	S
21	Nicaragua	A	1	1	Jr. Ricardo Palma 509	957459877	S
22	Argentina	A	1	1	Jr. Ricardo Palma 509	957459877	S
23	Brasil	A	1	1	Jr. Ricardo Palma 509	957459877	S
0	No Determinado	A	1	0	\N	\N	S
14	Chile	A	1	1	Jr. Ricardo Palma 509	957459877	N
3	Ecuador	A	1	1	JR. RICARDO PALMA 509	936 676 722 - 041750004	N
7	Uruguay	A	1	1	Jr. Ricardo Palma 509	957459877	N
19	Guatemala	A	1	1	Jr. Ricardo Palma 509	957459877	N
10	Francia	A	2	0	Jr. Ricardo Palma 509	988 617 534	S
1	Perú	A	1	1	JR. RICARDO PALMA 509	957459877	S
\.


--
-- TOC entry 2587 (class 0 OID 33419)
-- Dependencies: 217
-- Data for Name: paises_idiomas; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.paises_idiomas (pais_id, idioma_id, pai_descripcion) FROM stdin;
\.


--
-- TOC entry 2588 (class 0 OID 33422)
-- Dependencies: 218
-- Data for Name: paises_jerarquia; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.paises_jerarquia (pj_id, pais_id, pj_descripcion, pj_item) FROM stdin;
1	1	departamento	1
2	1	provincia	2
3	1	distrito	3
9	13	estado	1
10	13	municipio	2
11	9	departamento	1
12	9	municipio	2
19	15	departamento	1
20	15	municipio	2
24	16	departamento	1
25	16	distrito	2
26	16	municipio	3
27	17	provincia	1
28	17	canton	2
29	17	distrito	3
30	6	estado	1
31	6	municipio	2
32	6	parroquia	3
35	8	departamento	1
36	8	provincia	2
37	8	municipio	3
38	18	provincia_comarca	1
39	18	distrito	2
40	18	corregimientos	3
43	20	departamento	1
44	20	municipio	2
45	21	departamento	1
46	21	municipio	2
47	22	provincia	1
48	22	departamento_partido	2
49	22	municipio	3
50	23	estado	1
51	23	municipio	2
52	14	region	1
53	14	provincia	2
54	14	comuna	3
55	3	provincia	1
56	3	canton	2
57	3	parroquia	3
58	7	departamento	1
59	7	municipio	2
60	19	departamento	1
61	19	municipio	2
\.


--
-- TOC entry 2591 (class 0 OID 33429)
-- Dependencies: 221
-- Data for Name: parentesco_miembro; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.parentesco_miembro (idparentescomiembro, idmiembro, idparentesco, idpais, nombres, idtipodoc, nrodoc, fechanacimiento, lugarnacimiento) FROM stdin;
\.


--
-- TOC entry 2593 (class 0 OID 33437)
-- Dependencies: 223
-- Data for Name: religion; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.religion (idreligion, descripcion) FROM stdin;
1	Adventista
3	Católico
4	Dominical
5	Isrraelita
6	Mormon
7	Otros
8	Reforma
9	Testigo de Jehová
0	No Determinado
2	SMI
\.


--
-- TOC entry 2595 (class 0 OID 33443)
-- Dependencies: 225
-- Data for Name: temp_traslados; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.temp_traslados (idtemptraslados, idmiembro, idtipodoc, iddivision, pais_id, idunion, idmision, iddistritomisionero, idiglesia, nrodoc, division, pais, "union", mision, distritomisionero, iglesia, tipo_documento, usuario_id, tipo_traslado, iddivisiondestino, pais_iddestino, iduniondestino, idmisiondestino, iddistritomisionerodestino, idiglesiadestino, asociado) FROM stdin;
\.


--
-- TOC entry 2597 (class 0 OID 33451)
-- Dependencies: 227
-- Data for Name: union; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias."union" (idunion, descripcion, estado, direccion, telefono, email, fax) FROM stdin;
1	Unión Peruana	1	\N	\N	\N	\N
3	Unión Temporal Paraguay	1	\N	\N	\N	\N
5	Unión Mexicana	1	\N	\N	\N	\N
6	Unión Venezolana	1	\N	\N	\N	\N
11	Union Temporal Chilena	1	\N	\N	\N	\N
10	Union Temporal Guatemalteca	1	\N	\N	\N	\N
9	Union Temporal Uruguaya	1	\N	\N	\N	\N
8	Union Temporal Ecuatoriana	1	\N	\N	\N	\N
7	Colombiana	1	\N	\N	\N	\N
13	Union Temporal Nicaragua	1	\N	\N	\N	\N
12	Union Temporal Boliviana	1	\N	\N	\N	\N
0	No Determinado	1	\N	\N	\N	\N
\.


--
-- TOC entry 2599 (class 0 OID 33460)
-- Dependencies: 229
-- Data for Name: union_paises; Type: TABLE DATA; Schema: iglesias; Owner: postgres
--

COPY iglesias.union_paises (idunion, pais_id) FROM stdin;
1	1
3	9
4	6
5	13
6	6
11	14
10	19
9	7
8	3
7	15
2	0
13	21
12	8
0	0
\.


--
-- TOC entry 2601 (class 0 OID 33477)
-- Dependencies: 233
-- Data for Name: cargo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cargo (idcargo, descripcion, idtipocargo, estado, idnivel) FROM stdin;
8	Director de Escuela Sabática	2	1	\N
11	Director Buen Samaritano	2	1	\N
18	Tesorero	2	1	1
29	Delegado Suplente	2	1	1
28	Delegado Titular	2	1	2
45	Director Buensamaritano	1	1	8
25	Director de Música	2	1	6
27	Director de Seminario	2	1	3
44	Secretario Eminel	1	1	9
41	Director Eminel	1	1	12
26	Director de Jóvenes	2	1	4
43	Misionero Laico	1	1	10
15	Presidente	1	1	1
48	Divisionarios	2	1	1
49	Directores de Ministerios	2	1	1
50	Directores de Departamento	2	1	1
51	Miembros del Comité	2	1	1
52	Auditor(es)	2	1	1
53	Comité de Finanzas	2	1	1
54	Presidente	2	1	2
55	Vicepresidente	2	1	2
56	Secretario	2	1	2
57	Tesorero	2	1	2
58	Miembro/s del Comité	2	1	2
59	Presidente	2	1	4
60	Vicepresidente	2	1	4
61	Secretario	2	1	4
62	Tesorero	2	1	4
63	Presidentes de Asociación	2	1	4
5	Director de Iglesia	2	1	7
6	Secretario de Iglesia	2	1	7
4	Anciano de Iglesia	1	1	14
46	Ministerial	1	1	8
65	Director de Escuela Sabatica	2	1	7
67	Comité de Iglesia	2	1	7
68	Delegado a la Asociación	2	1	7
69	Presidente	2	1	5
19	Director Colportaje	2	1	4
71	Director de Obra Misionera	2	1	4
73	Director de Editorial	2	1	4
75	Nombre de la Editorial	2	1	4
76	Nombre de la Editorial	2	1	5
77	Diácono/Director de Dorcas	2	1	4
21	Director de Salud	2	1	4
24	Director de Educación	2	1	4
80	Auditor 1	2	1	4
81	Auditor 2	2	1	5
82	Comité de Unión	2	1	4
83	Comité de Asociación	2	1	5
84	Comité Ejecutivo	2	1	4
85	Comité Ejecutivo	2	1	5
86	Comité de Finanzas	2	1	4
87	Comité de Finanzas	2	1	5
88	Comité Literario	2	1	4
89	Comité Literario	2	1	5
90	Comité de Salud	2	1	4
91	Comité de Salud	2	1	5
94	Delegado Substituto	2	1	4
93	Delegado	2	1	5
92	Delegado	2	1	4
95	Delegado Substituto	2	1	5
96	Auditor 1	2	1	5
97	Auditor 2	2	1	4
98	Vicepresidente	2	1	5
99	Secretario	2	1	5
100	Tesorero	2	1	5
101	Ministro	1	1	12
103	Empleado de Oficina	2	1	5
104	Anciano de Iglesia	1	1	12
22	Director de Familia	2	1	1
121	Director de Educación	2	1	1
122	Director de Salud u Obra Médico Misionera	2	1	1
3	Colportor	1	1	12
102	Obrero Bíblico	1	1	12
123	Director de Dorcas o Buen Samaritano 	2	1	1
1	Pastor	1	1	8
106	Diácono con Bendición	1	1	12
23	Director de Publicaciones	2	1	1
124	Director de Multimedia	2	1	1
7	Tesorero	2	1	7
16	Vice Presidente Primero	2	1	1
107	Vice Presidente Segundo	2	1	1
17	Secretario Primero	2	1	1
108	Secretario Segundo	2	1	1
109	Presidente de la División Norteamerica-Caribe	2	1	1
110	Presidente de la División Latinoamericana	2	1	1
111	Presidente de la División Europea	2	1	1
112	Presidente de la División Africana	2	1	1
113	Presidente de la División Asiática	2	1	1
114	Presidente de la División Oceania 	2	1	1
115	Director del Ministerio Misionero	2	1	1
116	Director del Ministerio Social	2	1	1
117	Director del Ministerio de Ayuda	2	1	1
118	Director de Obra Misionera o Evangelismo	2	1	1
119	Director de Colportaje	2	1	1
120	Director de Jóvenes	2	1	1
125	Ingeniero/Arquitecto de la Asociación General	2	1	1
126	Director del Departamento de Obra Misionera o Evangelismo	2	1	4
127	Director del Departamento de Colportaje	2	1	4
128	Director del Departamento de Niños	2	1	4
129	Director del Departamento de Jóvenes	2	1	4
130	Director del Departamento de Familia	2	1	4
131	Director del Departamento de Educación	2	1	4
132	Director del Departamento de Salud u Obra Médico Misionera	2	1	4
133	Director del Departamento del Buen Samaritano	2	1	4
134	Director del Departamento de Publicaciones o Editorial	2	1	4
135	Director del Departamento de Música	2	1	4
136	Director del Departamento de Multimedia	2	1	4
137	Auditor (es) o Revisor (es) de Cuentas	2	1	4
138	Miembros del Comité Literario	2	1	4
72	Director del Departamento de Obra Misionera o Evangelismo	2	1	5
70	Director del Departamento de Colportaje	2	1	5
14	Director del Departamento de Jóvenes	2	1	5
13	Director del Departamento de Salud u Obra Médico Misionera	2	1	5
66	Director del Departamento de Jóvenes	2	1	7
64	Diácono/Diaconisa	2	1	7
9	Maestro(s) de Escuela Sabática	2	1	7
10	Maestro(s) de Escuela Sabática Infantil	2	1	7
139	Miembros del Comité de Finanzas	2	1	4
140	Miembros del Comité Plenario (o Directivo) de la Unión	2	1	4
141	Delegados a la Asociación General	2	1	4
79	Director del Departamento de Educación	2	1	5
78	Director del Departamento de Dorcas o Buen Samaritano	2	1	5
74	Director del Departamento de Publicaciones o Editorial	2	1	5
142	Director del Departamento de Niños	2	1	5
143	Director del Departamento de Familia	2	1	5
12	Director del Departamento de Música	2	1	5
144	Director del Departamento de Multimedia	2	1	5
145	Auditor (es) o Revisor (es) de Cuentas	2	1	5
146	Delegados a la Unión o a la Asociación General	2	1	5
147	El Comité Plenario	2	1	5
20	Director del Departamento de Obra Misionera o Evangelismo	2	1	7
148	Anciano de Iglesia	2	1	7
149	Subdirector de Iglesia	2	1	7
150	Secretario de Escuela Sabática	2	1	7
151	Director del Departamento de Niños	2	1	7
152	Director del Departamento de Familia	2	1	7
153	Director del Departamento de Educación	2	1	7
154	Director del Departamento de Salud u Obra Médico Misionera	2	1	7
155	Director del Departamento de Buen Samaritano o Dorcas	2	1	7
156	Director del Departamento de Música	2	1	7
157	Director del Departamento de Multimedia	2	1	7
\.


--
-- TOC entry 2603 (class 0 OID 33489)
-- Dependencies: 236
-- Data for Name: condicioninmueble; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.condicioninmueble (idcondicioninmueble, descripcion) FROM stdin;
1	Construido
2	Semiconstruido
3	En Construcción
4	En Litigio
\.


--
-- TOC entry 2605 (class 0 OID 33495)
-- Dependencies: 238
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
32	Arica y Parinacota	14
33	Tarapacá	14
34	Antofagasta	14
35	Atacama	14
36	Coquimbo	14
37	Valparaíso	14
38	Región del Libertador Gral. Bernardo O’Higgins	14
39	Región del Maule	14
40	Región del Biobío	14
41	Región de la Araucanía	14
42	Región de Los Ríos	14
43	Región de Los Lagos	14
44	Región Aisén del Gral. Carlos Ibáñez del Campo	14
45	Región de Magallanes y de la Antártica Chilena	14
46	Región Metropolitana de Santiago	14
47	Antioquia	15
48	Atlantico	15
49	Santa Fe de Bogotá	15
50	Bolivar	15
51	Boyaca	15
52	Caldas	15
53	Caqueta	15
54	Cauca	15
55	Cesar	15
56	Cordova	15
57	Cundinamarca	15
58	Choco	15
59	Huila	15
60	La Guajira	15
61	Magdalena	15
62	Meta	15
63	Nariño	15
64	Norte de Santander	15
65	Quindio	15
66	Risaralda	15
67	Santander	15
68	Sucre	15
69	Tolima	15
70	Valle	15
71	Arauca	15
72	Casanare	15
73	Putumayo	15
74	San Andres	15
75	Amazonas	15
76	Guainia	15
77	Guaviare	15
78	Vaupes	15
79	Vichada	15
80	AZUAY	3
81	BOLIVAR	3
82	CAÑAR	3
83	CARCHI	3
84	COTOPAXI	3
85	CHIMBORAZO	3
86	EL ORO	3
87	ESMERALDAS	3
88	GUAYAS	3
89	IMBABURA	3
90	LOJA	3
91	LOS RIOS	3
92	MANABI	3
93	MORONA SANTIAGO	3
94	NAPO	3
95	PASTAZA	3
96	PICHINCHA	3
97	TUNGURAHUA	3
98	ZAMORA CHINCHIPE	3
99	GALAPAGOS	3
100	SUCUMBIOS	3
101	ORELLANA	3
102	NTO DOMINGO DE LOS TSACHIL	3
103	SANTA ELENA	3
104	ZONAS NO DELIMITADAS	3
105	Ahuachapán	16
106	Sonsonate	16
107	Santa Ana	16
108	Chalatenango	16
109	La Libertad	16
110	San Salvador	16
111	Cuscatlán	16
112	La Paz	16
113	Cabañas	16
114	San Vicente	16
115	Usulután	16
116	San Miguel	16
117	Morazán	16
118	La Unión	16
119	SAN JOSE	17
120	ALAJUELA	17
121	CARTAGO	17
122	HEREDIA	17
123	GUANACASTE	17
124	PUNTARENAS	17
125	LIMON	17
126	Amazonas	6
127	Anzoátegui	6
128	Apure	6
129	Aragua	6
130	Barinas	6
131	Bolívar	6
132	Carabobo	6
133	Cojedes	6
134	Delta Amacuro	6
135	Distrito Capital	6
136	Falcón	6
137	Guárico	6
138	La Guaira	6
139	Lara	6
140	Mérida	6
141	Miranda	6
142	Monagas	6
143	Nueva Esparta	6
144	Portuguesa	6
145	Sucre	6
146	Táchira	6
147	Trujillo	6
148	Yaracuy	6
149	Zulia	6
151	Artigas	7
152	Canelones	7
153	Cerro Largo	7
154	Colonia	7
155	Durazno	7
156	Flores	7
157	Florida	7
158	Lavalleja	7
159	Maldonado	7
160	Montevideo	7
161	Paysandú	7
162	Río Negro	7
163	Rivera	7
164	Rocha	7
165	Salto	7
166	San José	7
167	Soriano	7
168	Tacuarembó	7
169	Treinta y Tres	7
170	Alto Paraguay	9
171	Alto Paraná	9
172	Amambay	9
173	Asunción	9
174	Boquerón	9
175	Caaguazú	9
176	Caazapá	9
177	Canindeyú	9
178	Central	9
179	Concepción	9
180	Cordillera	9
181	Guairá	9
182	Itapúa	9
183	Misiones	9
184	Ñeembucú	9
185	Paraguarí	9
186	Presidente Hayes	9
187	San Pedro	9
188	Beni	8
189	Chuquisaca	8
190	Cochabamba	8
191	La Paz	8
192	Oruro	8
193	Pando	8
194	Potosí	8
195	Santa Cruz	8
196	Tarija	8
197	Bocas del Toro	18
198	Chiriquí	18
199	Coclé	18
200	Colón	18
201	Darién	18
202	Herrera	18
203	Los Santos	18
204	Panamá	18
205	Panamá Oeste	18
206	Veraguas	18
207	Emberá-Wounaan	18
208	Guna Yala	18
209	Naso Tjër Di	18
210	Ngäbe-Buglé	18
211	Alta Verapaz	19
212	Baja Verapaz	19
213	Chimaltenango	19
214	Chiquimula	19
215	El Progreso	19
216	Escuintla	19
217	Guatemala	19
218	Huehuetenango	19
219	Izabal	19
220	Jalapa	19
221	Jutiapa	19
222	Petén	19
223	Quetzaltenango	19
224	Quiché	19
225	Retalhuleu	19
226	Sacatepéquez	19
227	San Marcos	19
228	Santa Rosa	19
229	Sololá	19
230	Suchitepéquez	19
231	Totonicapán	19
232	Zacapa	19
233	Atlántida	20
234	Colón	20
235	Comayagua	20
236	Copán	20
237	Cortés	20
238	Choluteca	20
239	El Paraíso	20
240	Francisco Morazán	20
241	Gracias a Dios	20
242	Intibucá	20
243	Islas de la Bahía	20
244	La Paz	20
245	Lempira	20
246	Ocotepeque	20
247	Olancho	20
248	Santa Bárbara	20
249	Valle	20
250	Yoro	20
251	Boaco	21
252	Carazo	21
253	Chinandega	21
254	Chontales	21
255	Costa Caribe Norte	21
256	Costa Caribe Sur	21
257	Estelí	21
258	Granada	21
259	Jinotega	21
260	León	21
261	Madriz	21
262	Managua	21
263	Masaya	21
264	Matagalpa	21
265	Nueva Segovia	21
266	Río San Juan	21
267	Rivas	21
268	AGUASCALIENTES	13
269	BAJA CALIFORNIA	13
270	BAJA CALIFORNIA SUR	13
271	CAMPECHE	13
272	CHIAPAS	13
273	CHIHUAHUA	13
274	CIUDAD DE MÉXICO	13
275	COAHULIA	13
276	COLIMA	13
277	DURANGO	13
278	GUANAJUATO	13
279	GUERRERO	13
280	HIDALGO	13
281	JALISCO	13
282	ESTADO DE MÉXICO	13
283	MICHOACÁN	13
284	MORELOS	13
285	NAYARIT	13
286	NUEVO LEÓN	13
287	OAXACA	13
288	PUEBLA	13
289	QUERÉTARO	13
290	QUINTANA ROO	13
291	SAN LUIS POTOSÍ	13
292	SINALOA	13
293	SONORA	13
294	TABASCO	13
295	TAMAULIPAS	13
296	TLAXCALA	13
297	VERACRUZ	13
298	YUCATÁN	13
299	ZACATECAS	13
300	Buenos Aires	22
301	Catamarca	22
302	Chaco	22
303	Chubut	22
304	Córdoba	22
305	Corrientes	22
306	Entre Ríos	22
307	Formosa	22
308	Jujuy	22
309	La Pampa	22
310	La Rioja	22
311	Mendoza	22
312	Misiones	22
313	Neuquén	22
314	Río Negro	22
315	Salta	22
316	San Juan	22
317	San Luis	22
318	Santa Cruz	22
319	Santa Fe	22
320	Santiago del Estero	22
321	Tierra del Fuego	22
322	Tucumán	22
323	Acre	23
324	Alagoas	23
325	Amapá	23
326	Amazonas	23
327	Bahía	23
328	Ceará	23
329	Distrito Federal	23
330	Espírito Santo	23
331	Goiás	23
332	Maranhão	23
333	Mato Grosso	23
334	Mato Grosso del Sur	23
335	Minas Gerais	23
336	Pará	23
337	Paraíba	23
338	Paraná	23
339	Pernambuco	23
340	Piauí	23
341	Río de Janeiro	23
342	Río Grande del Norte	23
343	Río Grande del Sur	23
344	Rondonia	23
345	Roraima	23
346	Santa Catarina	23
347	Sergipe	23
348	Tocantins	23
349	São Paulo	23
0	No Determinado	0
\.


--
-- TOC entry 2607 (class 0 OID 33504)
-- Dependencies: 240
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
1838	203	Arica
1839	203	Camarones
1840	204	Putre
1841	204	General Lagos
1842	205	Iquique
1843	205	Alto Hospicio
1844	206	Pozo Almonte
1845	206	Camiña
1846	206	Colchane
1847	206	Huara
1848	206	Pica
1849	207	Antofagasta
1850	207	Mejillones
1851	207	Sierra Gorda
1852	207	Taltal
1853	208	Calama
1854	208	Ollagüe
1855	208	San Pedro de Atacama
1856	209	Tocopilla
1857	209	María Elena
1858	210	Copiapó
1859	210	Caldera
1860	210	Tierra Amarilla
1861	211	Chañaral
1862	211	Diego de Almagro
1863	212	Vallenar
1864	212	Alto del Carmen
1865	212	Freirina
1866	212	Huasco
1867	213	La Serena
1868	213	Coquimbo
1869	213	Andacollo
1870	213	La Higuera
1871	213	Paiguano
1872	213	Vicuña
1873	214	Illapel
1874	214	Canela
1875	214	Los Vilos
1876	214	Salamanca
1877	215	Ovalle
1878	215	Combarbalá
1879	215	Monte Patria
1880	215	Punitaqui
1881	215	Río Hurtado
1882	216	Valparaíso
1883	216	Casablanca
1884	216	Concón
1885	216	Juan Fernández
1886	216	Puchuncaví
1887	216	Quintero
1888	216	Viña del Mar
1889	217	Isla de Pascua
1890	218	Los Andes
1891	218	Calle Larga
1892	218	Rinconada
1893	218	San Esteban
1894	219	La Ligua
1895	219	Cabildo
1896	219	Papudo
1897	219	Petorca
1898	219	Zapallar
1899	220	Quillota
1900	220	Calera
1901	220	Hijuelas
1902	220	La Cruz
1903	220	Nogales
1904	221	San Antonio
1905	221	Algarrobo
1906	221	Cartagena
1907	221	El Quisco
1908	221	El Tabo
1909	221	Santo Domingo
1910	222	San Felipe
1911	222	Catemu
1912	222	Llaillay
1913	222	Panquehue
1914	222	Putaendo
1915	222	Santa María
1916	223	Quilpué
1917	223	Limache
1918	223	Olmué
1919	223	Villa Alemana
1920	224	Rancagua
1921	224	Codegua
1922	224	Coinco
1923	224	Coltauco
1924	224	Doñihue
1925	224	Graneros
1926	224	Las Cabras
1927	224	Machalí
1928	224	Malloa
1929	224	Mostazal
1930	224	Olivar
1931	224	Peumo
1932	224	Pichidegua
1933	224	Quinta de Tilcoco
1934	224	Rengo
1935	224	Requínoa
1936	224	San Vicente
1937	225	Pichilemu
1938	225	La Estrella
1939	225	Litueche
1940	225	Marchihue
1941	225	Navidad
1942	225	Paredones
1943	226	San Fernando
1944	226	Chépica
1945	226	Chimbarongo
1946	226	Lolol
1947	226	Nancagua
1948	226	Palmilla
1949	226	Peralillo
1950	226	Placilla
1951	226	Pumanque
1952	226	Santa Cruz
1953	227	Talca
1954	227	Constitución
1955	227	Curepto
1956	227	Empedrado
1957	227	Maule
1958	227	Pelarco
1959	227	Pencahue
1960	227	Río Claro
1961	227	San Clemente
1962	227	San Rafael
1963	228	Cauquenes
1964	228	Chanco
1965	228	Pelluhue
1966	229	Curicó
1967	229	Hualañé
1968	229	Licantén
1969	229	Molina
1970	229	Rauco
1971	229	Romeral
1972	229	Sagrada Familia
1973	229	Teno
1974	229	Vichuquén
1975	230	Linares
1976	230	Colbún
1977	230	Longaví
1978	230	Parral
1979	230	Retiro
1980	230	San Javier
1981	230	Villa Alegre
1982	230	Yerbas Buenas
1983	231	Concepción
1984	231	Coronel
1985	231	Chiguayante
1986	231	Florida
1987	231	Hualqui
1988	231	Lota
1989	231	Penco
1990	231	San Pedro de la Paz
1991	231	Santa Juana
1992	231	Talcahuano
1993	231	Tomé
1994	231	Hualpén
1995	232	Lebu
1996	232	Arauco
1997	232	Cañete
1998	232	Contulmo
1999	232	Curanilahue
2000	232	Los Álamos
2001	232	Tirúa
2002	233	Los Ángeles
2003	233	Antuco
2004	233	Cabrero
2005	233	Laja
2006	233	Mulchén
2007	233	Nacimiento
2008	233	Negrete
2009	233	Quilaco
2010	233	Quilleco
2011	233	San Rosendo
2012	233	Santa Bárbara
2013	233	Tucapel
2014	233	Yumbel
2015	233	Alto Biobío
2016	234	Chillán
2017	234	Bulnes
2018	234	Cobquecura
2019	234	Coelemu
2020	234	Coihueco
2021	234	Chillán Viejo
2022	234	El Carmen
2023	234	Ninhue
2024	234	Ñiquén
2025	234	Pemuco
2026	234	Pinto
2027	234	Portezuelo
2028	234	Quillón
2029	234	Quirihue
2030	234	Ránquil
2031	234	San Carlos
2032	234	San Fabián
2033	234	San Ignacio
2034	234	San Nicolás
2035	234	Treguaco
2036	234	Yungay
2037	235	Temuco
2038	235	Carahue
2039	235	Cunco
2040	235	Curarrehue
2041	235	Freire
2042	235	Galvarino
2043	235	Gorbea
2044	235	Lautaro
2045	235	Loncoche
2046	235	Melipeuco
2047	235	Nueva Imperial
2048	235	Padre las Casas
2049	235	Perquenco
2050	235	Pitrufquén
2051	235	Pucón
2052	235	Saavedra
2053	235	Teodoro Schmidt
2054	235	Toltén
2055	235	Vilcún
2056	235	Villarrica
2057	235	Cholchol
2058	236	Angol
2059	236	Collipulli
2060	236	Curacautín
2061	236	Ercilla
2062	236	Lonquimay
2063	236	Los Sauces
2064	236	Lumaco
2065	236	Purén
2066	236	Renaico
2067	236	Traiguén
2068	236	Victoria
2069	237	Valdivia
2070	237	Corral
2071	237	Lanco
2072	237	Los Lagos
2073	237	Máfil
2074	237	Mariquina
2075	237	Paillaco
2076	237	Panguipulli
2077	238	La Unión
2078	238	Futrono
2079	238	Lago Ranco
2080	238	Río Bueno
2081	239	Puerto Montt
2082	239	Calbuco
2083	239	Cochamó
2084	239	Fresia
2085	239	Frutillar
2086	239	Los Muermos
2087	239	Llanquihue
2088	239	Maullín
2089	239	Puerto Varas
2090	240	Castro
2091	240	Ancud
2092	240	Chonchi
2093	240	Curaco de Vélez
2094	240	Dalcahue
2095	240	Puqueldón
2096	240	Queilén
2097	240	Quellón
2098	240	Quemchi
2099	240	Quinchao
2100	241	Osorno
2101	241	Puerto Octay
2102	241	Purranque
2103	241	Puyehue
2104	241	Río Negro
2105	241	San Juan de la Costa
2106	241	San Pablo
2107	242	Chaitén
2108	242	Futaleufú
2109	242	Hualaihué
2110	242	Palena
2111	243	Coihaique
2112	243	Lago Verde
2113	244	Aisén
2114	244	Cisnes
2115	244	Guaitecas
2116	245	Cochrane
2117	245	O’Higgins
2118	245	Tortel
2119	246	Chile Chico
2120	246	Río Ibáñez
2121	247	Punta Arenas
2122	247	Laguna Blanca
2123	247	Río Verde
2124	247	San Gregorio
2125	248	Cabo de Hornos (Ex Navarino)
2126	248	Antártica
2127	249	Porvenir
2128	249	Primavera
2129	249	Timaukel
2130	250	Natales
2131	250	Torres del Paine
2132	251	Santiago
2133	251	Cerrillos
2134	251	Cerro Navia
2135	251	Conchalí
2136	251	El Bosque
2137	251	Estación Central
2138	251	Huechuraba
2139	251	Independencia
2140	251	La Cisterna
2141	251	La Florida
2142	251	La Granja
2143	251	La Pintana
2144	251	La Reina
2145	251	Las Condes
2146	251	Lo Barnechea
2147	251	Lo Espejo
2148	251	Lo Prado
2149	251	Macul
2150	251	Maipú
2151	251	Ñuñoa
2152	251	Pedro Aguirre Cerda
2153	251	Peñalolén
2154	251	Providencia
2155	251	Pudahuel
2156	251	Quilicura
2157	251	Quinta Normal
2158	251	Recoleta
2159	251	Renca
2160	251	San Joaquín
2161	251	San Miguel
2162	251	San Ramón
2163	251	Vitacura
2164	252	Puente Alto
2165	252	Pirque
2166	252	San José de Maipo
2167	253	Colina
2168	253	Lampa
2169	253	Tiltil
2170	254	San Bernardo
2171	254	Buin
2172	254	Calera de Tango
2173	254	Paine
2174	255	Melipilla
2175	255	Alhué
2176	255	Curacaví
2177	255	María Pinto
2178	255	San Pedro
2179	256	Talagante
2180	256	El Monte
2181	256	Isla de Maipo
2182	256	Padre Hurtado
2183	1302	BELLAVISTA
2184	1302	CAÑARIBAMBA
2185	1302	EL BATÁN
2186	1302	EL SAGRARIO
2187	1302	EL VECINO
2188	1302	GIL RAMÍREZ DÁVALOS
2189	1302	HUAYNACÁPAC
2190	1302	MACHÁNGARA
2191	1302	MONAY
2192	1302	SAN BLAS
2193	1302	SAN SEBASTIÁN
2194	1302	SUCRE
2195	1302	TOTORACOCHA
2196	1302	YANUNCAY
2197	1302	HERMANO MIGUEL
2198	1302	CUENCA
2199	1302	BAÑOS
2200	1302	CUMBE
2201	1302	CHAUCHA
2202	1302	CHECA (JIDCAY)
2203	1302	CHIQUINTAD
2204	1302	LLACAO
2205	1302	MOLLETURO
2206	1302	NULTI
2207	1302	OCTAVIO CORDERO PALACIOS (SANTA ROSA)
2208	1302	PACCHA
2209	1302	QUINGEO
2210	1302	RICAURTE
2211	1302	SAN JOAQUÍN
2212	1302	SANTA ANA
2213	1302	SAYAUSÍ
2214	1302	SIDCAY
2215	1302	SININCAY
2216	1302	TARQUI
2217	1302	TURI
2218	1302	VALLE
2219	1302	VICTORIA DEL PORTETE (IRQUIS)
2220	1303	GIRÓN
2221	1303	ASUNCIÓN
2222	1303	SAN GERARDO
2223	1304	GUALACEO
2224	1304	CHORDELEG
2225	1304	DANIEL CÓRDOVA TORAL (EL ORIENTE)
2226	1304	JADÁN
2227	1304	MARIANO MORENO
2228	1304	PRINCIPAL
2229	1304	REMIGIO CRESPO TORAL (GÚLAG)
2230	1304	SAN JUAN
2231	1304	ZHIDMAD
2232	1304	LUIS CORDERO VEGA
2233	1304	SIMÓN BOLÍVAR (CAB. EN GAÑANZOL)
2234	1305	NABÓN
2235	1305	COCHAPATA
2236	1305	EL PROGRESO (CAB.EN ZHOTA)
2237	1305	LAS NIEVES (CHAYA)
2238	1305	OÑA
2239	1306	PAUTE
2240	1306	AMALUZA
2241	1306	BULÁN (JOSÉ VÍCTOR IZQUIERDO)
2242	1306	CHICÁN (GUILLERMO ORTEGA)
2243	1306	EL CABO
2244	1306	GUACHAPALA
2245	1306	GUARAINAG
2246	1306	PALMAS
2247	1306	PAN
2248	1306	SAN CRISTÓBAL (CARLOS ORDÓÑEZ LAZO)
2249	1306	SEVILLA DE ORO
2250	1306	TOMEBAMBA
2251	1306	DUG DUG
2252	1307	PUCARÁ
2253	1307	CAMILO PONCE ENRÍQUEZ (CAB. EN RÍO 7 DE MOLLEPONGO
2254	1307	SAN RAFAEL DE SHARUG
2255	1308	SAN FERNANDO
2256	1308	CHUMBLÍN
2257	1309	SANTA ISABEL (CHAGUARURCO)
2258	1309	ABDÓN CALDERÓN (LA UNIÓN)
2259	1309	EL CARMEN DE PIJILÍ
2260	1309	ZHAGLLI (SHAGLLI)
2261	1309	SAN SALVADOR DE CAÑARIBAMBA
2262	1310	SIGSIG
2263	1310	CUCHIL (CUTCHIL)
2264	1310	GIMA
2265	1310	GUEL
2266	1310	LUDO
2267	1310	SAN BARTOLOMÉ
2268	1310	SAN JOSÉ DE RARANGA
2269	1311	SAN FELIPE DE OÑA CABECERA CANTONAL
2270	1311	SUSUDEL
2271	1312	LA UNIÓN
2272	1312	LUIS GALARZA ORELLANA (CAB.EN DELEGSOL)
2273	1312	SAN MARTÍN DE PUZHIO
2274	1313	EL PAN
2275	1313	SAN VICENTE
2276	1316	CAMILO PONCE ENRÍQUEZ
2277	1317	ÁNGEL POLIBIO CHÁVES
2278	1317	GABRIEL IGNACIO VEINTIMILLA
2279	1317	GUANUJO
2280	1317	GUARANDA
2281	1317	FACUNDO VELA
2282	1317	JULIO E. MORENO (CATANAHUÁN GRANDE)
2283	1317	LAS NAVES
2284	1317	SALINAS
2285	1317	SAN LORENZO
2286	1317	SAN SIMÓN (YACOTO)
2287	1317	SANTA FÉ (SANTA FÉ)
2288	1317	SIMIÁTUG
2289	1317	SAN LUIS DE PAMBIL
2290	1318	CHILLANES
2291	1318	SAN JOSÉ DEL TAMBO (TAMBOPAMBA)
2292	1319	SAN JOSÉ DE CHIMBO
2293	1319	ASUNCIÓN (ASANCOTO)
2294	1319	CALUMA
2295	1319	MAGDALENA (CHAPACOTO)
2296	1319	TELIMBELA
2297	1320	ECHEANDÍA
2298	1321	SAN MIGUEL
2299	1321	BALSAPAMBA
2300	1321	BILOVÁN
2301	1321	RÉGULO DE MORA
2302	1321	SAN PABLO (SAN PABLO DE ATENAS)
2303	1321	SANTIAGO
2304	1323	LAS MERCEDES
2305	1324	AURELIO BAYAS MARTÍNEZ
2306	1324	AZOGUES
2307	1324	BORRERO
2308	1324	SAN FRANCISCO
2309	1324	COJITAMBO
2310	1324	DÉLEG
2311	1324	GUAPÁN
2312	1324	JAVIER LOYOLA (CHUQUIPATA)
2313	1324	LUIS CORDERO
2314	1324	PINDILIG
2315	1324	RIVERA
2316	1324	SOLANO
2317	1324	TADAY
2318	1325	BIBLIÁN
2319	1325	NAZÓN (CAB. EN PAMPA DE DOMÍNGUEZ)
2320	1325	SAN FRANCISCO DE SAGEO
2321	1325	TURUPAMBA
2322	1325	JERUSALÉN
2323	1326	CAÑAR
2324	1326	CHONTAMARCA
2325	1326	CHOROCOPTE
2326	1326	GENERAL MORALES (SOCARTE)
2327	1326	GUALLETURO
2328	1326	HONORATO VÁSQUEZ (TAMBO VIEJO)
2329	1326	INGAPIRCA
2330	1326	JUNCAL
2331	1326	SAN ANTONIO
2332	1326	SUSCAL
2333	1326	TAMBO
2334	1326	ZHUD
2335	1326	VENTURA
2336	1326	DUCUR
2337	1327	LA TRONCAL
2338	1327	MANUEL J. CALLE
2339	1327	PANCHO NEGRO
2340	1328	EL TAMBO
2341	1331	GONZÁLEZ SUÁREZ
2342	1331	TULCÁN
2343	1331	EL CARMELO (EL PUN)
2344	1331	HUACA
2345	1331	JULIO ANDRADE (OREJUELA)
2346	1331	MALDONADO
2347	1331	PIOTER
2348	1331	TOBAR DONOSO (LA BOCANA DE CAMUMBÍ)
2349	1331	TUFIÑO
2350	1331	URBINA (TAYA)
2351	1331	EL CHICAL
2352	1331	MARISCAL SUCRE
2353	1331	SANTA MARTHA DE CUBA
2354	1332	BOLÍVAR
2355	1332	GARCÍA MORENO
2356	1332	LOS ANDES
2357	1332	MONTE OLIVO
2358	1332	SAN VICENTE DE PUSIR
2359	1332	SAN RAFAEL
2360	1333	EL ÁNGEL
2361	1333	27 DE SEPTIEMBRE
2362	1333	EL ANGEL
2363	1333	EL GOALTAL
2364	1333	LA LIBERTAD (ALIZO)
2365	1333	SAN ISIDRO
2366	1334	MIRA (CHONTAHUASI)
2367	1334	CONCEPCIÓN
2368	1334	JIJÓN Y CAAMAÑO (CAB. EN RÍO BLANCO)
2369	1334	JUAN MONTALVO (SAN IGNACIO DE QUIL)
2370	1335	SAN JOSÉ
2371	1335	SAN GABRIEL
2372	1335	CRISTÓBAL COLÓN
2373	1335	CHITÁN DE NAVARRETE
2374	1335	FERNÁNDEZ SALVADOR
2375	1335	LA PAZ
2376	1335	PIARTAL
2377	1337	ELOY ALFARO (SAN FELIPE)
2378	1337	IGNACIO FLORES (PARQUE FLORES)
2379	1337	JUAN MONTALVO (SAN SEBASTIÁN)
2380	1337	LA MATRIZ
2381	1337	SAN BUENAVENTURA
2382	1337	LATACUNGA
2383	1337	ALAQUES (ALÁQUEZ)
2384	1337	BELISARIO QUEVEDO (GUANAILÍN)
2385	1337	GUAITACAMA (GUAYTACAMA)
2386	1337	JOSEGUANGO BAJO
2387	1337	LAS PAMPAS
2388	1337	MULALÓ
2389	1337	11 DE NOVIEMBRE (ILINCHISI)
2390	1337	POALÓ
2391	1337	SAN JUAN DE PASTOCALLE
2392	1337	SIGCHOS
2393	1337	TANICUCHÍ
2394	1337	TOACASO
2395	1337	PALO QUEMADO
2396	1338	EL CARMEN
2397	1338	LA MANÁ
2398	1338	EL TRIUNFO
2399	1338	GUASAGANDA (CAB.EN GUASAGANDA
2400	1338	PUCAYACU
2401	1339	EL CORAZÓN
2402	1339	MORASPUNGO
2403	1339	PINLLOPATA
2404	1339	RAMÓN CAMPAÑA
2405	1340	PUJILÍ
2406	1340	ANGAMARCA
2407	1340	CHUCCHILÁN (CHUGCHILÁN)
2408	1340	GUANGAJE
2409	1340	ISINLIBÍ (ISINLIVÍ)
2410	1340	LA VICTORIA
2411	1340	PILALÓ
2412	1340	TINGO
2413	1340	ZUMBAHUA
2414	1341	ANTONIO JOSÉ HOLGUÍN (SANTA LUCÍA)
2415	1341	CUSUBAMBA
2416	1341	MULALILLO
2417	1341	MULLIQUINDIL (SANTA ANA)
2418	1341	PANSALEO
2419	1342	SAQUISILÍ
2420	1342	CANCHAGUA
2421	1342	CHANTILÍN
2422	1342	COCHAPAMBA
2423	1343	CHUGCHILLÁN
2424	1343	ISINLIVÍ
2425	1344	LIZARZABURU
2426	1344	VELASCO
2427	1344	VELOZ
2428	1344	YARUQUÍES
2429	1344	RIOBAMBA
2430	1344	CACHA (CAB. EN MACHÁNGARA)
2431	1344	CALPI
2432	1344	CUBIJÍES
2433	1344	FLORES
2434	1344	LICÁN
2435	1344	LICTO
2436	1344	PUNGALÁ
2437	1344	PUNÍN
2438	1344	QUIMIAG
2439	1344	SAN LUIS
2440	1345	ALAUSÍ
2441	1345	ACHUPALLAS
2442	1345	CUMANDÁ
2443	1345	GUASUNTOS
2444	1345	HUIGRA
2445	1345	MULTITUD
2446	1345	PISTISHÍ (NARIZ DEL DIABLO)
2447	1345	PUMALLACTA
2448	1345	SEVILLA
2449	1345	SIBAMBE
2450	1345	TIXÁN
2451	1346	CAJABAMBA
2452	1346	SICALPA
2453	1346	VILLA LA UNIÓN (CAJABAMBA)
2454	1346	CAÑI
2455	1346	COLUMBE
2456	1346	JUAN DE VELASCO (PANGOR)
2457	1346	SANTIAGO DE QUITO (CAB. EN SAN ANTONIO DE QUITO)
2458	1347	CHAMBO
2459	1348	CHUNCHI
2460	1348	CAPZOL
2461	1348	COMPUD
2462	1348	GONZOL
2463	1348	LLAGOS
2464	1349	GUAMOTE
2465	1349	CEBADAS
2466	1349	PALMIRA
2467	1350	EL ROSARIO
2468	1350	GUANO
2469	1350	GUANANDO
2470	1350	ILAPO
2471	1350	LA PROVIDENCIA
2472	1350	SAN ANDRÉS
2473	1350	SAN GERARDO DE PACAICAGUÁN
2474	1350	SAN ISIDRO DE PATULÚ
2475	1350	SAN JOSÉ DEL CHAZO
2476	1350	SANTA FÉ DE GALÁN
2477	1350	VALPARAÍSO
2478	1351	PALLATANGA
2479	1352	PENIPE
2480	1352	EL ALTAR
2481	1352	MATUS
2482	1352	PUELA
2483	1352	SAN ANTONIO DE BAYUSHIG
2484	1352	LA CANDELARIA
2485	1352	BILBAO (CAB.EN QUILLUYACU)
2486	1354	MACHALA
2487	1354	PUERTO BOLÍVAR
2488	1354	NUEVE DE MAYO
2489	1354	EL CAMBIO
2490	1354	EL RETIRO
2491	1355	ARENILLAS
2492	1355	CHACRAS
2493	1355	LA LIBERTAD
2494	1355	LAS LAJAS (CAB. EN LA VICTORIA)
2495	1355	PALMALES
2496	1355	CARCABÓN
2497	1356	AYAPAMBA
2498	1356	CORDONCILLO
2499	1356	MILAGRO
2500	1356	SAN JUAN DE CERRO AZUL
2501	1357	BALSAS
2502	1357	BELLAMARÍA
2503	1358	CHILLA
2504	1359	EL GUABO
2505	1359	BARBONES (SUCRE)
2506	1359	LA IBERIA
2507	1359	TENDALES (CAB.EN PUERTO TENDALES)
2508	1359	RÍO BONITO
2509	1360	ECUADOR
2510	1360	EL PARAÍSO
2511	1360	HUALTACO
2512	1360	MILTON REYES
2513	1360	UNIÓN LOJANA
2514	1360	HUAQUILLAS
2515	1361	MARCABELÍ
2516	1361	EL INGENIO
2517	1362	LOMA DE FRANCO
2518	1362	OCHOA LEÓN (MATRIZ)
2519	1362	TRES CERRITOS
2520	1362	PASAJE
2521	1362	BUENAVISTA
2522	1362	CASACAY
2523	1362	LA PEAÑA
2524	1362	PROGRESO
2525	1362	UZHCURRUMI
2526	1362	CAÑAQUEMADA
2527	1363	LA SUSAYA
2528	1363	PIÑAS GRANDE
2529	1363	PIÑAS
2530	1363	CAPIRO (CAB. EN LA CAPILLA DE CAPIRO)
2531	1363	LA BOCANA
2532	1363	MOROMORO (CAB. EN EL VADO)
2533	1363	PIEDRAS
2534	1363	SAN ROQUE (AMBROSIO MALDONADO)
2535	1363	SARACAY
2536	1364	PORTOVELO
2537	1364	CURTINCAPA
2538	1364	MORALES
2539	1364	SALATÍ
2540	1365	SANTA ROSA
2541	1365	PUERTO JELÍ
2542	1365	BALNEARIO JAMBELÍ (SATÉLITE)
2543	1365	JUMÓN (SATÉLITE)
2544	1365	NUEVO SANTA ROSA
2545	1365	JAMBELÍ
2546	1365	LA AVANZADA
2547	1365	TORATA
2548	1365	VICTORIA
2549	1366	ZARUMA
2550	1366	ABAÑÍN
2551	1366	ARCAPAMBA
2552	1366	GUANAZÁN
2553	1366	GUIZHAGUIÑA
2554	1366	HUERTAS
2555	1366	MALVAS
2556	1366	MULUNCAY GRANDE
2557	1366	SINSAO
2558	1366	SALVIAS
2559	1367	PLATANILLOS
2560	1367	VALLE HERMOSO
2561	1368	BARTOLOMÉ RUIZ (CÉSAR FRANCO CARRIÓN)
2562	1368	5 DE AGOSTO
2563	1368	ESMERALDAS
2564	1368	LUIS TELLO (LAS PALMAS)
2565	1368	SIMÓN PLATA TORRES
2566	1368	ATACAMES
2567	1368	CAMARONES (CAB. EN SAN VICENTE)
2568	1368	CRNEL. CARLOS CONCHA TORRES (CAB.EN HUELE)
2569	1368	CHINCA
2570	1368	CHONTADURO
2571	1368	CHUMUNDÉ
2572	1368	LAGARTO
2573	1368	MAJUA
2574	1368	MONTALVO (CAB. EN HORQUETA)
2575	1368	RÍO VERDE
2576	1368	ROCAFUERTE
2577	1368	SAN MATEO
2578	1368	SÚA (CAB. EN LA BOCANA)
2579	1368	TABIAZO
2580	1368	TACHINA
2581	1368	TONCHIGÜE
2582	1368	VUELTA LARGA
2583	1369	VALDEZ (LIMONES)
2584	1369	ANCHAYACU
2585	1369	ATAHUALPA (CAB. EN CAMARONES)
2586	1369	BORBÓN
2587	1369	LA TOLA
2588	1369	LUIS VARGAS TORRES (CAB. EN PLAYA DE ORO)
2589	1369	PAMPANAL DE BOLÍVAR
2590	1369	SAN FRANCISCO DE ONZOLE
2591	1369	SANTO DOMINGO DE ONZOLE
2592	1369	SELVA ALEGRE
2593	1369	TELEMBÍ
2594	1369	COLÓN ELOY DEL MARÍA
2595	1369	SAN JOSÉ DE CAYAPAS
2596	1369	TIMBIRÉ
2597	1370	MUISNE
2598	1370	DAULE
2599	1370	GALERA
2600	1370	QUINGUE (OLMEDO PERDOMO FRANCO)
2601	1370	SALIMA
2602	1370	SAN GREGORIO
2603	1370	SAN JOSÉ DE CHAMANGA (CAB.EN CHAMANGA)
2604	1371	ROSA ZÁRATE (QUININDÉ)
2605	1371	CUBE
2606	1371	CHURA (CHANCAMA) (CAB. EN EL YERBERO)
2607	1371	MALIMPIA
2608	1371	VICHE
2609	1372	ALTO TAMBO (CAB. EN GUADUAL)
2610	1372	ANCÓN (PICHANGAL) (CAB. EN PALMA REAL)
2611	1372	CALDERÓN
2612	1372	CARONDELET
2613	1372	5 DE JUNIO (CAB. EN UIMBI)
2614	1372	MATAJE (CAB. EN SANTANDER)
2615	1372	SAN JAVIER DE CACHAVÍ (CAB. EN SAN JAVIER)
2616	1372	SANTA RITA
2617	1372	TAMBILLO
2618	1372	TULULBÍ (CAB. EN RICAURTE)
2619	1372	URBINA
2620	1373	TONSUPA
2621	1374	RIOVERDE
2622	1375	LA CONCORDIA
2623	1375	MONTERREY
2624	1375	LA VILLEGAS
2625	1375	PLAN PILOTO
2626	1376	AYACUCHO
2627	1376	BOLÍVAR (SAGRARIO)
2628	1376	CARBO (CONCEPCIÓN)
2629	1376	FEBRES CORDERO
2630	1376	LETAMENDI
2631	1376	NUEVE DE OCTUBRE
2632	1376	OLMEDO (SAN ALEJO)
2633	1376	ROCA
2634	1376	URDANETA
2635	1376	XIMENA
2636	1376	PASCUALES
2637	1376	GUAYAQUIL
2638	1376	CHONGÓN
2639	1376	JUAN GÓMEZ RENDÓN (PROGRESO)
2640	1376	MORRO
2641	1376	PLAYAS (GRAL. VILLAMIL)
2642	1376	POSORJA
2643	1376	PUNÁ
2644	1376	TENGUEL
2645	1377	ALFREDO BAQUERIZO MORENO (JUJÁN)
2646	1378	BALAO
2647	1379	BALZAR
2648	1380	COLIMES
2649	1380	SAN JACINTO
2650	1381	LA AURORA (SATÉLITE)
2651	1381	BANIFE
2652	1381	EMILIANO CAICEDO MARCOS
2653	1381	MAGRO
2654	1381	PADRE JUAN BAUTISTA AGUIRRE
2655	1381	SANTA CLARA
2656	1381	VICENTE PIEDRAHITA
2657	1381	ISIDRO AYORA (SOLEDAD)
2658	1381	JUAN BAUTISTA AGUIRRE (LOS TINTOS)
2659	1381	LAUREL
2660	1381	LIMONAL
2661	1381	LOMAS DE SARGENTILLO
2662	1381	LOS LOJAS (ENRIQUE BAQUERIZO MORENO)
2663	1381	PIEDRAHITA (NOBOL)
2664	1382	ELOY ALFARO (DURÁN)
2665	1382	EL RECREO
2666	1383	VELASCO IBARRA (EL EMPALME)
2667	1383	GUAYAS (PUEBLO NUEVO)
2668	1385	CHOBO
2669	1385	GENERAL ELIZALDE (BUCAY)
2670	1385	MARISCAL SUCRE (HUAQUES)
2671	1385	ROBERTO ASTUDILLO (CAB. EN CRUCE DE VENECIA)
2672	1386	NARANJAL
2673	1386	JESÚS MARÍA
2674	1386	SAN CARLOS
2675	1386	SANTA ROSA DE FLANDES
2676	1386	TAURA
2677	1387	NARANJITO
2678	1388	PALESTINA
2679	1389	PEDRO CARBO
2680	1389	VALLE DE LA VIRGEN
2681	1389	SABANILLA
2682	1390	SAMBORONDÓN
2683	1390	LA PUNTILLA (SATÉLITE)
2684	1390	TARIFA
2685	1391	SANTA LUCÍA
2686	1392	BOCANA
2687	1392	CANDILEJOS
2688	1392	CENTRAL
2689	1392	PARAÍSO
2690	1392	EL SALITRE (LAS RAMAS)
2691	1392	GRAL. VERNAZA (DOS ESTEROS)
2692	1392	LA VICTORIA (ÑAUZA)
2693	1392	JUNQUILLAL
2694	1393	SAN JACINTO DE YAGUACHI
2695	1393	CRNEL. LORENZO DE GARAICOA (PEDREGAL)
2696	1393	CRNEL. MARCELINO MARIDUEÑA (SAN CARLOS)
2697	1393	GRAL. PEDRO J. MONTERO (BOLICHE)
2698	1393	SIMÓN BOLÍVAR
2699	1393	YAGUACHI VIEJO (CONE)
2700	1393	VIRGEN DE FÁTIMA
2701	1394	GENERAL VILLAMIL (PLAYAS)
2702	1395	CRNEL.LORENZO DE GARAICOA (PEDREGAL)
2703	1396	CORONEL MARCELINO MARIDUEÑA (SAN CARLOS)
2704	1398	NARCISA DE JESÚS
2705	1399	GENERAL ANTONIO ELIZALDE (BUCAY)
2706	1400	ISIDRO AYORA
2707	1401	CARANQUI
2708	1401	GUAYAQUIL DE ALPACHACA
2709	1401	SAGRARIO
2710	1401	LA DOLOROSA DEL PRIORATO
2711	1401	SAN MIGUEL DE IBARRA
2712	1401	AMBUQUÍ
2713	1401	ANGOCHAGUA
2714	1401	CAROLINA
2715	1401	LA ESPERANZA
2716	1401	LITA
2717	1402	ANDRADE MARÍN (LOURDES)
2718	1402	ATUNTAQUI
2719	1402	IMBAYA (SAN LUIS DE COBUENDO)
2720	1402	SAN FRANCISCO DE NATABUELA
2721	1402	SAN JOSÉ DE CHALTURA
2722	1402	SAN ROQUE
2723	1403	COTACACHI
2724	1403	APUELA
2725	1403	GARCÍA MORENO (LLURIMAGUA)
2726	1403	IMANTAG
2727	1403	PEÑAHERRERA
2728	1403	PLAZA GUTIÉRREZ (CALVARIO)
2729	1403	QUIROGA
2730	1403	6 DE JULIO DE CUELLAJE (CAB. EN CUELLAJE)
2731	1403	VACAS GALINDO (EL CHURO) (CAB.EN SAN MIGUEL ALTO
2732	1404	JORDÁN
2733	1404	OTAVALO
2734	1404	DR. MIGUEL EGAS CABEZAS (PEGUCHE)
2735	1404	EUGENIO ESPEJO (CALPAQUÍ)
2736	1404	PATAQUÍ
2737	1404	SAN JOSÉ DE QUICHINCHE
2738	1404	SAN JUAN DE ILUMÁN
2739	1404	SAN PABLO
2740	1404	SELVA ALEGRE (CAB.EN SAN MIGUEL DE PAMPLONA)
2741	1405	PIMAMPIRO
2742	1405	CHUGÁ
2743	1405	MARIANO ACOSTA
2744	1405	SAN FRANCISCO DE SIGSIPAMBA
2745	1406	URCUQUÍ CABECERA CANTONAL
2746	1406	CAHUASQUÍ
2747	1406	LA MERCED DE BUENOS AIRES
2748	1406	PABLO ARENAS
2749	1406	TUMBABIRO
2750	1407	LOJA
2751	1407	CHANTACO
2752	1407	CHUQUIRIBAMBA
2753	1407	EL CISNE
2754	1407	GUALEL
2755	1407	JIMBILLA
2756	1407	MALACATOS (VALLADOLID)
2757	1407	SAN LUCAS
2758	1407	SAN PEDRO DE VILCABAMBA
2759	1407	TAQUIL (MIGUEL RIOFRÍO)
2760	1407	VILCABAMBA (VICTORIA)
2761	1407	YANGANA (ARSENIO CASTILLO)
2762	1407	QUINARA
2763	1408	CARIAMANGA
2764	1408	CHILE
2765	1408	COLAISACA
2766	1408	EL LUCERO
2767	1408	UTUANA
2768	1408	SANGUILLÍN
2769	1409	CATAMAYO
2770	1409	CATAMAYO (LA TOMA)
2771	1409	GUAYQUICHUMA
2772	1409	SAN PEDRO DE LA BENDITA
2773	1409	ZAMBI
2774	1410	CELICA
2775	1410	CRUZPAMBA (CAB. EN CARLOS BUSTAMANTE)
2776	1410	CHAQUINAL
2777	1410	12 DE DICIEMBRE (CAB. EN ACHIOTES)
2778	1410	PINDAL (FEDERICO PÁEZ)
2779	1410	POZUL (SAN JUAN DE POZUL)
2780	1410	TNTE. MAXIMILIANO RODRÍGUEZ LOAIZA
2781	1411	CHAGUARPAMBA
2782	1411	SANTA RUFINA
2783	1411	AMARILLOS
2784	1412	JIMBURA
2785	1412	SANTA TERESITA
2786	1412	27 DE ABRIL (CAB. EN LA NARANJA)
2787	1412	EL AIRO
2788	1413	GONZANAMÁ
2789	1413	CHANGAIMINA (LA LIBERTAD)
2790	1413	FUNDOCHAMBA
2791	1413	NAMBACOLA
2792	1413	PURUNUMA (EGUIGUREN)
2793	1413	QUILANGA (LA PAZ)
2794	1413	SACAPALCA
2795	1413	SAN ANTONIO DE LAS ARADAS (CAB. EN LAS ARADAS)
2796	1414	GENERAL ELOY ALFARO (SAN SEBASTIÁN)
2797	1414	MACARÁ (MANUEL ENRIQUE RENGEL SUQUILANDA)
2798	1414	MACARÁ
2799	1414	LARAMA
2800	1414	SABIANGO (LA CAPILLA)
2801	1415	CATACOCHA
2802	1415	LOURDES
2803	1415	CANGONAMÁ
2804	1415	GUACHANAMÁ
2805	1415	LA TINGUE
2806	1415	LAURO GUERRERO
2807	1415	OLMEDO (SANTA BÁRBARA)
2808	1415	ORIANGA
2809	1415	CASANGA
2810	1415	YAMANA
2811	1416	ALAMOR
2812	1416	CIANO
2813	1416	EL ARENAL
2814	1416	EL LIMO (MARIANA DE JESÚS)
2815	1416	MERCADILLO
2816	1416	VICENTINO
2817	1417	SARAGURO
2818	1417	EL PARAÍSO DE CELÉN
2819	1417	EL TABLÓN
2820	1417	LLUZHAPA
2821	1417	MANÚ
2822	1417	SAN ANTONIO DE QUMBE (CUMBE)
2823	1417	SAN PABLO DE TENTA
2824	1417	SAN SEBASTIÁN DE YÚLUC
2825	1417	URDANETA (PAQUISHAPA)
2826	1417	SUMAYPAMBA
2827	1418	SOZORANGA
2828	1418	NUEVA FÁTIMA
2829	1418	TACAMOROS
2830	1419	ZAPOTILLO
2831	1419	MANGAHURCO (CAZADEROS)
2832	1419	GARZAREAL
2833	1419	LIMONES
2834	1419	PALETILLAS
2835	1419	BOLASPAMBA
2836	1420	PINDAL
2837	1420	12 DE DICIEMBRE (CAB.EN ACHIOTES)
2838	1420	MILAGROS
2839	1421	QUILANGA
2840	1422	OLMEDO
2841	1423	CLEMENTE BAQUERIZO
2842	1423	DR. CAMILO PONCE
2843	1423	BARREIRO
2844	1423	EL SALTO
2845	1423	BABAHOYO
2846	1423	BARREIRO (SANTA RITA)
2847	1423	CARACOL
2848	1423	FEBRES CORDERO (LAS JUNTAS)
2849	1423	PIMOCHA
2850	1424	BABA
2851	1424	GUARE
2852	1424	ISLA DE BEJUCAL
2853	1425	MONTALVO
2854	1426	PUEBLOVIEJO
2855	1426	PUERTO PECHICHE
2856	1427	QUEVEDO
2857	1427	SAN CAMILO
2858	1427	GUAYACÁN
2859	1427	NICOLÁS INFANTE DÍAZ
2860	1427	SAN CRISTÓBAL
2861	1427	SIETE DE OCTUBRE
2862	1427	24 DE MAYO
2863	1427	VENUS DEL RÍO QUEVEDO
2864	1427	VIVA ALFARO
2865	1427	BUENA FÉ
2866	1427	MOCACHE
2867	1427	VALENCIA
2868	1428	CATARAMA
2869	1429	10 DE NOVIEMBRE
2870	1429	VENTANAS
2871	1429	QUINSALOMA
2872	1429	ZAPOTAL
2873	1429	CHACARITA
2874	1429	LOS ÁNGELES
2875	1430	VINCES
2876	1430	ANTONIO SOTOMAYOR (CAB. EN PLAYAS DE VINCES)
2877	1430	PALENQUE
2878	1432	SAN JACINTO DE BUENA FÉ
2879	1432	7 DE AGOSTO
2880	1432	11 DE OCTUBRE
2881	1432	PATRICIA PILAR
2882	1436	PORTOVIEJO
2883	1436	12 DE MARZO
2884	1436	COLÓN
2885	1436	PICOAZÁ
2886	1436	ANDRÉS DE VERA
2887	1436	FRANCISCO PACHECO
2888	1436	18 DE OCTUBRE
2889	1436	ABDÓN CALDERÓN (SAN FRANCISCO)
2890	1436	ALHAJUELA (BAJO GRANDE)
2891	1436	CRUCITA
2892	1436	PUEBLO NUEVO
2893	1436	RIOCHICO (RÍO CHICO)
2894	1436	SAN PLÁCIDO
2895	1436	CHIRIJOS
2896	1436	CALCETA
2897	1436	MEMBRILLO
2898	1437	CHONE
2899	1437	BOYACÁ
2900	1437	CANUTO
2901	1437	CONVENTO
2902	1437	CHIBUNGA
2903	1437	ELOY ALFARO
2904	1438	4 DE DICIEMBRE
2905	1438	WILFRIDO LOOR MOREIRA (MAICITO)
2906	1438	SAN PEDRO DE SUMA
2907	1439	FLAVIO ALFARO
2908	1439	SAN FRANCISCO DE NOVILLO (CAB. EN
2909	1439	ZAPALLO
2910	1440	DR. MIGUEL MORÁN LUCIO
2911	1440	MANUEL INOCENCIO PARRALES Y GUALE
2912	1440	SAN LORENZO DE JIPIJAPA
2913	1440	JIPIJAPA
2914	1440	AMÉRICA
2915	1440	EL ANEGADO (CAB. EN ELOY ALFARO)
2916	1440	JULCUY
2917	1440	MACHALILLA
2918	1440	MEMBRILLAL
2919	1440	PEDRO PABLO GÓMEZ
2920	1440	PUERTO DE CAYO
2921	1440	PUERTO LÓPEZ
2922	1441	JUNÍN
2923	1442	LOS ESTEROS
2924	1442	MANTA
2925	1442	SANTA MARIANITA (BOCA DE PACOCHE)
2926	1443	ANIBAL SAN ANDRÉS
2927	1443	MONTECRISTI
2928	1443	EL COLORADO
2929	1443	GENERAL ELOY ALFARO
2930	1443	LEONIDAS PROAÑO
2931	1443	JARAMIJÓ
2932	1443	LA PILA
2933	1444	PAJÁN
2934	1444	CAMPOZANO (LA PALMA DE PAJÁN)
2935	1444	CASCOL
2936	1444	GUALE
2937	1444	LASCANO
2938	1445	PICHINCHA
2939	1445	BARRAGANETE
2940	1447	LODANA
2941	1447	SANTA ANA DE VUELTA LARGA
2942	1447	HONORATO VÁSQUEZ (CAB. EN VÁSQUEZ)
2943	1447	SAN PABLO (CAB. EN PUEBLO NUEVO)
2944	1448	BAHÍA DE CARÁQUEZ
2945	1448	LEONIDAS PLAZA GUTIÉRREZ
2946	1448	CANOA
2947	1448	COJIMÍES
2948	1448	CHARAPOTÓ
2949	1448	10 DE AGOSTO
2950	1448	JAMA
2951	1448	PEDERNALES
2952	1449	TOSAGUA
2953	1449	BACHILLERO
2954	1449	ANGEL PEDRO GILER (LA ESTANCILLA)
2955	1450	NOBOA
2956	1450	ARQ. SIXTO DURÁN BALLÉN
2957	1451	ATAHUALPA
2958	1452	SALANGO
2959	1456	MACAS
2960	1456	ALSHI (CAB. EN 9 DE OCTUBRE)
2961	1456	CHIGUAZA
2962	1456	GENERAL PROAÑO
2963	1456	HUASAGA (CAB.EN WAMPUIK)
2964	1456	MACUMA
2965	1456	SEVILLA DON BOSCO
2966	1456	SINAÍ
2967	1456	TAISHA
2968	1456	ZUÑA (ZÚÑAC)
2969	1456	TUUTINENTZA
2970	1456	CUCHAENTZA
2971	1456	SAN JOSÉ DE MORONA
2972	1456	RÍO BLANCO
2973	1457	GUALAQUIZA
2974	1457	MERCEDES MOLINA
2975	1457	AMAZONAS (ROSARIO DE CUYES)
2976	1457	BERMEJOS
2977	1457	BOMBOIZA
2978	1457	CHIGÜINDA
2979	1457	NUEVA TARQUI
2980	1457	SAN MIGUEL DE CUYES
2981	1457	EL IDEAL
2982	1458	GENERAL LEONIDAS PLAZA GUTIÉRREZ (LIMÓN)
2983	1458	INDANZA
2984	1458	PAN DE AZÚCAR
2985	1458	SAN ANTONIO (CAB. EN SAN ANTONIO CENTRO
2986	1458	SAN CARLOS DE LIMÓN (SAN CARLOS DEL
2987	1458	SAN JUAN BOSCO
2988	1458	SAN MIGUEL DE CONCHAY
2989	1458	SANTA SUSANA DE CHIVIAZA (CAB. EN CHIVIAZA)
2990	1458	YUNGANZA (CAB. EN EL ROSARIO)
2991	1459	PALORA (METZERA)
2992	1459	ARAPICOS
2993	1459	CUMANDÁ (CAB. EN COLONIA AGRÍCOLA SEVILLA DEL ORO)
2994	1459	HUAMBOYA
2995	1459	SANGAY (CAB. EN NAYAMANACA)
2996	1460	SANTIAGO DE MÉNDEZ
2997	1460	COPAL
2998	1460	CHUPIANZA
2999	1460	PATUCA
3000	1460	SAN LUIS DE EL ACHO (CAB. EN EL ACHO)
3001	1460	TAYUZA
3002	1460	SAN FRANCISCO DE CHINIMBIMI
3003	1461	SUCÚA
3004	1461	HUAMBI
3005	1461	LOGROÑO
3006	1461	YAUPI
3007	1461	SANTA MARIANITA DE JESÚS
3008	1462	PABLO SEXTO
3009	1463	SAN CARLOS DE LIMÓN
3010	1463	SAN JACINTO DE WAKAMBEIS
3011	1463	SANTIAGO DE PANANZA
3012	1464	HUASAGA (CAB. EN WAMPUIK)
3013	1464	PUMPUENTSA
3014	1465	SHIMPIS
3015	1468	TENA
3016	1468	AHUANO
3017	1468	CARLOS JULIO AROSEMENA TOLA (ZATZA-YACU)
3018	1468	CHONTAPUNTA
3019	1468	PANO
3020	1468	PUERTO MISAHUALLI
3021	1468	PUERTO NAPO
3022	1468	TÁLAG
3023	1468	SAN JUAN DE MUYUNA
3024	1469	ARCHIDONA
3025	1469	AVILA
3026	1469	COTUNDO
3027	1469	LORETO
3028	1469	SAN PABLO DE USHPAYACU
3029	1469	PUERTO MURIALDO
3030	1470	EL CHACO
3031	1470	GONZALO DíAZ DE PINEDA (EL BOMBÓN)
3032	1470	LINARES
3033	1470	OYACACHI
3034	1470	SARDINAS
3035	1471	BAEZA
3036	1471	COSANGA
3037	1471	CUYUJA
3038	1471	PAPALLACTA
3039	1471	SAN FRANCISCO DE BORJA (VIRGILIO DÁVILA)
3040	1471	SAN JOSÉ DEL PAYAMINO
3041	1471	SUMACO
3042	1472	CARLOS JULIO AROSEMENA TOLA
3043	1473	PUYO
3044	1473	ARAJUNO
3045	1473	CANELOS
3046	1473	CURARAY
3047	1473	DIEZ DE AGOSTO
3048	1473	FÁTIMA
3049	1473	MONTALVO (ANDOAS)
3050	1473	POMONA
3051	1473	RÍO CORRIENTES
3052	1473	RÍO TIGRE
3053	1473	SARAYACU
3054	1473	SIMÓN BOLÍVAR (CAB. EN MUSHULLACTA)
3055	1473	TENIENTE HUGO ORTIZ
3056	1473	VERACRUZ (INDILLAMA) (CAB. EN INDILLAMA)
3057	1474	MERA
3058	1474	MADRE TIERRA
3059	1474	SHELL
3060	1477	BELISARIO QUEVEDO
3061	1477	CARCELÉN
3062	1477	CENTRO HISTÓRICO
3063	1477	COMITÉ DEL PUEBLO
3064	1477	COTOCOLLAO
3065	1477	CHILIBULO
3066	1477	CHILLOGALLO
3067	1477	CHIMBACALLE
3068	1477	EL CONDADO
3069	1477	GUAMANÍ
3070	1477	IÑAQUITO
3071	1477	ITCHIMBÍA
3072	1477	KENNEDY
3073	1477	LA ARGELIA
3074	1477	LA CONCEPCIÓN
3075	1477	LA ECUATORIANA
3076	1477	LA FERROVIARIA
3077	1477	LA MAGDALENA
3078	1477	LA MENA
3079	1477	PONCEANO
3080	1477	PUENGASÍ
3081	1477	QUITUMBE
3082	1477	RUMIPAMBA
3083	1477	SAN BARTOLO
3084	1477	SAN ISIDRO DEL INCA
3085	1477	SOLANDA
3086	1477	TURUBAMBA
3087	1477	QUITO DISTRITO METROPOLITANO
3088	1477	ALANGASÍ
3089	1477	AMAGUAÑA
3090	1477	CALACALÍ
3091	1477	CONOCOTO
3092	1477	CUMBAYÁ
3093	1477	CHAVEZPAMBA
3094	1477	CHECA
3095	1477	EL QUINCHE
3096	1477	GUALEA
3097	1477	GUANGOPOLO
3098	1477	GUAYLLABAMBA
3099	1477	LA MERCED
3100	1477	LLANO CHICO
3101	1477	LLOA
3102	1477	MINDO
3103	1477	NANEGAL
3104	1477	NANEGALITO
3105	1477	NAYÓN
3106	1477	NONO
3107	1477	PACTO
3108	1477	PEDRO VICENTE MALDONADO
3109	1477	PERUCHO
3110	1477	PIFO
3111	1477	PÍNTAG
3112	1477	POMASQUI
3113	1477	PUÉLLARO
3114	1477	PUEMBO
3115	1477	SAN JOSÉ DE MINAS
3116	1477	SAN MIGUEL DE LOS BANCOS
3117	1477	TABABELA
3118	1477	TUMBACO
3119	1477	YARUQUÍ
3120	1477	ZAMBIZA
3121	1477	PUERTO QUITO
3122	1478	AYORA
3123	1478	CAYAMBE
3124	1478	JUAN MONTALVO
3125	1478	ASCÁZUBI
3126	1478	CANGAHUA
3127	1478	OLMEDO (PESILLO)
3128	1478	OTÓN
3129	1478	SANTA ROSA DE CUZUBAMBA
3130	1479	MACHACHI
3131	1479	ALÓAG
3132	1479	ALOASÍ
3133	1479	CUTUGLAHUA
3134	1479	EL CHAUPI
3135	1479	MANUEL CORNEJO ASTORGA (TANDAPI)
3136	1479	UYUMBICHO
3137	1480	TABACUNDO
3138	1480	MALCHINGUÍ
3139	1480	TOCACHI
3140	1480	TUPIGACHI
3141	1481	SANGOLQUÍ
3142	1481	SAN PEDRO DE TABOADA
3143	1481	SANGOLQUI
3144	1481	COTOGCHOA
3145	1485	ATOCHA – FICOA
3146	1485	CELIANO MONGE
3147	1485	HUACHI CHICO
3148	1485	HUACHI LORETO
3149	1485	LA PENÍNSULA
3150	1485	MATRIZ
3151	1485	PISHILATA
3152	1485	AMBATO
3153	1485	AMBATILLO
3154	1485	ATAHUALPA (CHISALATA)
3155	1485	AUGUSTO N. MARTÍNEZ (MUNDUGLEO)
3156	1485	CONSTANTINO FERNÁNDEZ (CAB. EN CULLITAHUA)
3157	1485	HUACHI GRANDE
3158	1485	IZAMBA
3159	1485	JUAN BENIGNO VELA
3160	1485	PASA
3161	1485	PICAIGUA
3162	1485	PILAGÜÍN (PILAHÜÍN)
3163	1485	QUISAPINCHA (QUIZAPINCHA)
3164	1485	SAN BARTOLOMÉ DE PINLLOG
3165	1485	SAN FERNANDO (PASA SAN FERNANDO)
3166	1485	TOTORAS
3167	1485	CUNCHIBAMBA
3168	1485	UNAMUNCHO
3169	1486	BAÑOS DE AGUA SANTA
3170	1486	LLIGUA
3171	1486	RÍO NEGRO
3172	1486	ULBA
3173	1487	CEVALLOS
3174	1488	MOCHA
3175	1488	PINGUILÍ
3176	1489	PATATE
3177	1489	LOS ANDES (CAB. EN POATUG)
3178	1489	SUCRE (CAB. EN SUCRE-PATATE URCU)
3179	1490	QUERO
3180	1490	YANAYACU - MOCHAPATA (CAB. EN YANAYACU)
3181	1491	PELILEO
3182	1491	PELILEO GRANDE
3183	1491	BENÍTEZ (PACHANLICA)
3184	1491	COTALÓ
3185	1491	CHIQUICHA (CAB. EN CHIQUICHA GRANDE)
3186	1491	EL ROSARIO (RUMICHACA)
3187	1491	GARCÍA MORENO (CHUMAQUI)
3188	1491	GUAMBALÓ (HUAMBALÓ)
3189	1491	SALASACA
3190	1492	CIUDAD NUEVA
3191	1492	PÍLLARO
3192	1492	BAQUERIZO MORENO
3193	1492	EMILIO MARÍA TERÁN (RUMIPAMBA)
3194	1492	MARCOS ESPINEL (CHACATA)
3195	1492	PRESIDENTE URBINA (CHAGRAPAMBA -PATZUCUL)
3196	1492	SAN JOSÉ DE POALÓ
3197	1492	SAN MIGUELITO
3198	1493	TISALEO
3199	1493	QUINCHICOTO
3200	1494	EL LIMÓN
3201	1494	ZAMORA
3202	1494	CUMBARATZA
3203	1494	GUADALUPE
3204	1494	IMBANA (LA VICTORIA DE IMBANA)
3205	1494	PAQUISHA
3206	1494	TIMBARA
3207	1494	ZUMBI
3208	1494	SAN CARLOS DE LAS MINAS
3209	1495	ZUMBA
3210	1495	CHITO
3211	1495	EL CHORRO
3212	1495	EL PORVENIR DEL CARMEN
3213	1495	LA CHONTA
3214	1495	PALANDA
3215	1495	PUCAPAMBA
3216	1495	SAN FRANCISCO DEL VERGEL
3217	1495	VALLADOLID
3218	1496	GUAYZIMI
3219	1496	ZURMI
3220	1496	NUEVO PARAÍSO
3221	1497	28 DE MAYO (SAN JOSÉ DE YACUAMBI)
3222	1497	TUTUPALI
3223	1498	YANTZAZA (YANZATZA)
3224	1498	CHICAÑA
3225	1498	EL PANGUI
3226	1498	LOS ENCUENTROS
3227	1499	EL GUISME
3228	1499	PACHICUTZA
3229	1499	TUNDAYME
3230	1500	TRIUNFO-DORADO
3231	1500	PANGUINTZA
3232	1501	LA CANELA
3233	1502	NUEVO QUITO
3234	1503	PUERTO BAQUERIZO MORENO
3235	1503	EL PROGRESO
3236	1503	A SANTA MARÍA (FLOREANA) (CAB. EN PTO. VELASCO IBARR
3237	1504	PUERTO VILLAMIL
3238	1504	TOMÁS DE BERLANGA (SANTO TOMÁS)
3239	1505	PUERTO AYORA
3240	1505	SANTA ROSA (INCLUYE LA ISLA BALTRA)
3241	1506	NUEVA LOJA
3242	1506	CUYABENO
3243	1506	DURENO
3244	1506	GENERAL FARFÁN
3245	1506	TARAPOA
3246	1506	EL ENO
3247	1506	PACAYACU
3248	1506	SANTA CECILIA
3249	1506	AGUAS NEGRAS
3250	1507	EL DORADO DE CASCALES
3251	1507	EL REVENTADOR
3252	1507	GONZALO PIZARRO
3253	1507	LUMBAQUÍ
3254	1507	PUERTO LIBRE
3255	1507	SANTA ROSA DE SUCUMBÍOS
3256	1508	PUERTO EL CARMEN DEL PUTUMAYO
3257	1508	PALMA ROJA
3258	1508	PUERTO BOLÍVAR (PUERTO MONTÚFAR)
3259	1508	PUERTO RODRÍGUEZ
3260	1508	SANTA ELENA
3261	1509	SHUSHUFINDI
3262	1509	LIMONCOCHA
3263	1509	PAÑACOCHA
3264	1509	SAN ROQUE (CAB. EN SAN VICENTE)
3265	1509	SAN PEDRO DE LOS COFANES
3266	1509	SIETE DE JULIO
3267	1510	LA BONITA
3268	1510	EL PLAYÓN DE SAN FRANCISCO
3269	1510	LA SOFÍA
3270	1510	ROSA FLORIDA
3271	1510	SANTA BÁRBARA
3272	1513	PUERTO FRANCISCO DE ORELLANA (EL COCA)
3273	1513	DAYUMA
3274	1513	TARACOA (NUEVA ESPERANZA: YUCA)
3275	1513	ALEJANDRO LABAKA
3276	1513	EL DORADO
3277	1513	EL EDÉN
3278	1513	INÉS ARANGO (CAB. EN WESTERN)
3279	1513	LA BELLEZA
3280	1513	NUEVO PARAÍSO (CAB. EN UNIÓN
3281	1513	SAN JOSÉ DE GUAYUSA
3282	1513	SAN LUIS DE ARMENIA
3283	1514	TIPITINI
3284	1514	NUEVO ROCAFUERTE
3285	1514	CAPITÁN AUGUSTO RIVADENEYRA
3286	1514	CONONACO
3287	1514	SANTA MARÍA DE HUIRIRIMA
3288	1514	TIPUTINI
3289	1514	YASUNÍ
3290	1515	LA JOYA DE LOS SACHAS
3291	1515	ENOKANQUI
3292	1515	POMPEYA
3293	1515	SAN SEBASTIÁN DEL COCA
3294	1515	LAGO SAN PEDRO
3295	1515	TRES DE NOVIEMBRE
3296	1515	UNIÓN MILAGREÑA
3297	1516	AVILA (CAB. EN HUIRUNO)
3298	1516	SAN JOSÉ DE PAYAMINO
3299	1516	SAN JOSÉ DE DAHUANO
3300	1516	SAN VICENTE DE HUATICOCHA
3301	1517	ABRAHAM CALAZACÓN
3302	1517	BOMBOLÍ
3303	1517	CHIGUILPE
3304	1517	RÍO TOACHI
3305	1517	SANTO DOMINGO DE LOS COLORADOS
3306	1517	ZARACAY
3307	1517	ALLURIQUÍN
3308	1517	PUERTO LIMÓN
3309	1517	LUZ DE AMÉRICA
3310	1517	SAN JACINTO DEL BÚA
3311	1517	EL ESFUERZO
3312	1517	SANTA MARÍA DEL TOACHI
3313	1518	BALLENITA
3314	1518	COLONCHE
3315	1518	CHANDUY
3316	1518	MANGLARALTO
3317	1518	SIMÓN BOLÍVAR (JULIO MORENO)
3318	1518	SAN JOSÉ DE ANCÓN
3319	1520	CARLOS ESPINOZA LARREA
3320	1520	GRAL. ALBERTO ENRÍQUEZ GALLO
3321	1520	VICENTE ROCAFUERTE
3322	1520	ANCONCITO
3323	1520	JOSÉ LUIS TAMAYO (MUEY)
3324	1521	LAS GOLONDRINAS
3325	1522	MANGA DEL CURA
3326	1523	Ahuachapán
3327	1523	Tacuba
3328	1523	Concepción de Ataco
3329	1523	San Pedro Puxtla
3330	1523	Apaneca
3331	1523	Jujutla
3332	1523	San Francisco Menéndez
3333	1523	Guaymango
3334	1524	Atiquizaya
3335	1524	Turín
3336	1524	San Lorenzo
3337	1524	El Refugio
3338	1525	Sonsonate
3339	1525	Nahuizalco
3340	1525	Acajutla
3341	1525	San Antonio del Monte
3342	1525	Santo Domingo de Guzmán
3343	1525	Sonzacate
3344	1525	Nahuilingo
3345	1526	Izalco
3346	1526	Armenia
3347	1526	San Julián
3348	1526	Santa Isabel Ishuatán
3349	1526	Cuisnahuat
3350	1526	Caluco
3351	1527	Juayúa
3352	1527	Santa Catarina Masahuat
3353	1527	Salcoatitán
3354	1528	Santa Ana
3355	1528	Coatepeque
3356	1528	Texistepeque
3357	1528	El Congo
3358	1529	Chalchuapa
3359	1529	Candelaria de La Frontera
3360	1529	San Sebastián Salitrillo
3361	1529	El Porvenir
3362	1530	Metapán
3363	1530	Santiago de La Frontera
3364	1530	Masahuat
3365	1530	Santa Rosa Guachipilín
3366	1530	San Antonio Pajonal
3367	1531	Chalatenango
3368	1531	Arcatao
3369	1531	Concepción Quezaltepeque
3370	1531	San Miguel de Mercedes
3371	1531	San Francisco Lempa
3372	1531	San Isidro Labrado
3373	1531	Nueva Trinidad
3374	1531	Nombre de Jesús
3375	1531	San Antonio Los Ranchos
3376	1531	El Carrizal
3377	1531	San Antonio de La Cruz
3378	1531	Las Vueltas
3379	1531	Potonico
3380	1531	San Luis del Carmen
3381	1531	Azacualpa
3382	1531	Cancasque
3383	1531	Ojos de Agua
3384	1531	Las Flores
3385	1532	Tejutla
3386	1532	Nueva Concepción
3387	1532	La Palma
3388	1532	Citalá
3389	1532	La Reina
3390	1532	San Ignacio
3391	1532	Agua Caliente
3392	1533	Dulce Nombre de María
3393	1533	San Fernando
3394	1533	La Laguna
3395	1533	El Paraíso
3396	1533	San Francisco Morazán
3397	1533	San Rafael
3398	1533	Comalapa
3399	1534	Nueva San Salvador
3400	1534	Jayaque
3401	1534	La Libertad
3402	1534	Zaragoza
3403	1534	Antiguo Cuscatlan
3404	1534	Comasagua
3405	1534	Teotepeque
3406	1534	Huizúcar
3407	1534	Tepecoyo
3408	1534	Colón
3409	1534	San José Villanueva
3410	1534	Tamanique
3411	1534	Chiltuipan
3412	1534	Nuevo Cuscatlan
3413	1534	Talnique
3414	1534	Jicalapa
3415	1534	Sacacoyo
3416	1535	Quezaltepeque
3417	1535	San Pablo Tacachico
3418	1536	San Juan Opico
3419	1537	San Salvador
3420	1537	Mejicanos
3421	1537	Soyapango
3422	1537	Delgado
3423	1537	Ayutuxtepeque
3424	1537	Cuscatancingo
3425	1538	Tonacatepeque
3426	1538	Guazapa
3427	1538	San Martín
3428	1538	Apopa
3429	1538	Nejapa
3430	1538	Aguilares
3431	1538	Ilopango
3432	1538	El Paisnal
3433	1539	Santo Tomás
3434	1539	San Marcos
3435	1539	Panchimalco
3436	1539	Santiago Texacuangos
3437	1539	Rosario de Mora
3438	1540	Cojutepeque
3439	1540	San Rafael Perulapán
3440	1540	San Rafael Cedros
3441	1540	Tenancingo
3442	1540	Candelaria
3443	1540	San Cristóbal
3444	1540	San Bartolomé Perulapía
3445	1540	Monte San Juan
3446	1540	El Carmen
3447	1540	Santa Cruz Michapa
3448	1540	San Ramón
3449	1540	El Rosario
3450	1540	Santa Cruz Analquito
3451	1541	Suchitoto
3452	1541	San José Guayabal
3453	1541	Oratorio de Concepción
3454	1542	Zacatecoluca
3455	1542	Santiago Nonualco
3456	1542	San Juan Nonualco
3457	1542	San Rafael obrajuelo
3458	1542	San Luis La Herradura
3459	1543	Olocuilta
3460	1543	San Juan Talpa
3461	1543	Cuyultitán
3462	1543	San Luis Talpa
3463	1543	San Francisco Chinameca
3464	1544	San Pedro Nonualco
3465	1544	Santa María Ostuma
3466	1544	San Emigdio
3467	1544	Paraíso de Osorio
3468	1544	Jerusalén
3469	1544	Mercedes La Ceiba
3470	1545	Tapahuaca
3471	1545	San Pedro Masahuat
3472	1545	San Miguel Tepezontes
3473	1545	San Juan Tepezontes
3474	1545	San Antonio Masahuat
3475	1546	Sensuntepeque
3476	1546	Victoria
3477	1546	Dolores
3478	1546	San Isidro
3479	1546	Guacotecti
3480	1547	Ilobasco
3481	1547	Tejutepeque
3482	1547	Jutiapa
3483	1547	Cinquera
3484	1548	San Vicente
3485	1548	Apastepeque
3486	1548	Guadalupe
3487	1548	Tecoluca
3488	1548	Verapaz
3489	1548	Tepetitán
3490	1548	San Cayetano Istepeque
3491	1549	San Sebastián
3492	1549	Santo Domingo
3493	1549	San Esteban Catarina
3494	1549	San Idelfonso
3495	1549	Santa Clara
3496	1550	Usulután
3497	1550	Jiquilisco
3498	1550	Santa Elena
3499	1550	Santa María
3500	1550	Jucuarán
3501	1550	Puerto El Triunfo
3502	1550	Concepción Batres
3503	1550	Ereguayquín
3504	1550	Ozatlán
3505	1550	San Dionisio
3506	1551	Santiago de María
3507	1551	Alegría
3508	1551	Tecapán
3509	1551	California
3510	1552	Berlín
3511	1552	Mercedes Umaña
3512	1552	San Agustín
3513	1552	San Francisco Javier
3514	1553	Jucuapa
3515	1553	Estanzuelas
3516	1553	El Triunfo
3517	1553	Nueva Granada
3518	1553	San Buenaventura
3519	1554	San Miguel
3520	1554	Ciudad Barrios
3521	1554	Chapeltique
3522	1554	Moncagua
3523	1554	Chirilagua
3524	1554	Uluazapa
3525	1554	Quelepa
3526	1554	Comacarán
3527	1555	Chinameca
3528	1555	San Rafael Oriente
3529	1555	Nueva Guadalupe
3530	1555	El Tránsito
3531	1555	Lolotique
3532	1555	San Jorge
3533	1556	Sesorí
3534	1556	San Luis de La Reina
3535	1556	Carolina
3536	1556	San Gerardo
3537	1556	Nuevo Edén de San Juan
3538	1556	San Antonio
3539	1557	San Francisco Gotera
3540	1557	Jocoro
3541	1557	Guatajiagua
3542	1557	Sociedad
3543	1557	San Carlos
3544	1557	Chilanga
3545	1557	El Divisadero
3546	1557	Yamabal
3547	1557	Sensembra
3548	1557	Lolotiquillo
3549	1558	Jocoaitique
3550	1558	Meanguera
3551	1558	Arambala
3552	1558	Perquín
3553	1558	Torola
3554	1558	Joateca
3555	1559	Osicala
3556	1559	Corinto
3557	1559	Cacaopera
3558	1559	San Simón
3559	1559	Yoloaiquín
3560	1559	Delicias de Concepción
3561	1559	Gualococti
3562	1560	La Unión
3563	1560	San Alejo
3564	1560	Yucuaiquin
3565	1560	Conchagua
3566	1560	Intipucá
3567	1560	San José
3568	1560	Yayantique
3569	1560	Bolivar
3570	1560	Meanguera del Golfo
3571	1561	Santa Rosa de Lima
3572	1561	Pasaquina
3573	1561	Anamorós
3574	1561	Nueva Esparta
3575	1561	El Sauce
3576	1561	Concepción de Oriente
3577	1561	Polorós
3578	1562	Carmen
3579	1562	Merced
3580	1562	Hospital
3581	1562	Catedral
3582	1562	Zapote
3583	1562	San Francisco de Dos Ríos
3584	1562	Uruca
3585	1562	Mata Redonda
3586	1562	Pavas
3587	1562	Hatillo
3588	1562	San Sebastián
3589	1563	Escazú
3590	1563	San Antonio
3591	1563	San Rafael
3592	1564	Desamparados
3593	1564	San Miguel
3594	1564	San Juan de Dios
3595	1564	San Rafael Arriba
3596	1564	Frailes
3597	1564	Patarrá
3598	1564	San Cristóbal
3599	1564	Rosario
3600	1564	Damas
3601	1564	San Rafael Abajo
3602	1564	Gravilias
3603	1564	Los Guido
3604	1565	Santiago
3605	1565	Mercedes Sur
3606	1565	Barbacoas
3607	1565	Grifo Alto
3608	1565	Candelaria
3609	1565	Desamparaditos
3610	1565	Chires
3611	1566	San Marcos
3612	1566	San Lorenzo
3613	1566	San Carlos
3614	1567	Aserrí
3615	1567	Tarbaca o Praga
3616	1567	Vuelta de Jorco
3617	1567	San Gabriel
3618	1567	La Legua
3619	1567	Monterrey
3620	1567	Salitrillos
3621	1568	Colón
3622	1568	Guayabo
3623	1568	Tabarcia
3624	1568	Piedras Negras
3625	1568	Picagres
3626	1569	Guadalupe
3627	1569	San Francisco
3628	1569	Calle Blancos
3629	1569	Mata de Plátano
3630	1569	Ipís
3631	1569	Rancho Redondo
3632	1569	Purral
3633	1570	Santa Ana
3634	1570	Salitral
3635	1570	Pozos o Concepción
3636	1570	Uruca o San Joaquín
3637	1570	Piedades
3638	1570	Brasil
3639	1571	Alajuelita
3640	1571	San Josecito
3641	1571	Concepción
3642	1571	San Felipe
3643	1572	San Isidro
3644	1572	Dulce Nombre o Jesús
3645	1572	Patalillo
3646	1572	Cascajal
3647	1573	San Ignacio
3648	1573	Guaitil
3649	1573	Palmichal
3650	1573	Cangrejal
3651	1573	Sabanillas
3652	1574	San Juan
3653	1574	Cinco Esquinas
3654	1574	Anselmo Llorente
3655	1574	León XIII
3656	1574	Colima
3657	1575	San Vicente
3658	1575	San Jerónimo
3659	1575	La Trinidad
3660	1576	San Pedro
3661	1576	Sabanilla
3662	1576	Mercedes o Betania
3663	1577	San Pablo
3664	1577	San Juan de Mata
3665	1577	San Luis
3666	1577	Carara
3667	1578	Santa María
3668	1578	Jardín
3669	1578	Copey
3670	1579	General
3671	1579	Daniel Flores
3672	1579	Rivas
3673	1579	Platanares
3674	1579	Pejibaye
3675	1579	Cajón o Carmen
3676	1579	Barú
3677	1579	Río Nuevo
3678	1579	Páramo
3679	1580	San Andrés
3680	1580	Llano Bonito
3681	1580	Santa Cruz
3682	1581	Alajuela
3683	1581	San José
3684	1581	Carrizal
3685	1581	Guácima
3686	1581	Río Segundo
3687	1581	Turrucares
3688	1581	Tambor
3689	1581	La Garita
3690	1581	Sarapiquí
3691	1582	San Ramón
3692	1582	Piedades Norte
3693	1582	Piedades Sur
3694	1582	Angeles
3695	1582	Alfaro
3696	1582	Volio
3697	1582	Zapotal
3698	1582	San Isidro de Peñas Blancas
3699	1583	Grecia
3700	1583	San Roque
3701	1583	Tacares
3702	1583	Río Cuarto
3703	1583	Puente Piedra
3704	1583	Bolívar
3705	1584	San Mateo
3706	1584	Desmonte
3707	1584	Jesús María
3708	1585	Atenas
3709	1585	Jesús
3710	1585	Mercedes
3711	1585	Santa Eulalia
3712	1585	Escobal
3713	1586	Naranjo
3714	1586	Cirrí Sur
3715	1587	Palmares
3716	1587	Zaragoza
3717	1587	Buenos Aires
3718	1587	Esquipulas
3719	1587	La Granja
3720	1588	Carrillos
3721	1588	Sabana Redonda
3722	1589	Orotina
3723	1589	Mastate
3724	1589	Hacienda Vieja
3725	1589	Coyolar
3726	1589	Ceiba
3727	1590	Quesada
3728	1590	Florencia
3729	1590	Buenavista
3730	1590	Aguas Zarcas
3731	1590	Venecia
3732	1590	Pital
3733	1590	Fortuna
3734	1590	Tigra
3735	1590	Palmera
3736	1590	Venado
3737	1590	Cutris
3738	1590	Pocosol
3739	1591	Zarcero
3740	1591	Laguna
3741	1591	Tapezco
3742	1591	Palmira
3743	1591	Brisas
3744	1592	Sarchí Norte
3745	1592	Sarchí Sur
3746	1592	Toro Amarillo
3747	1592	Rodríguez
3748	1593	Upala
3749	1593	Aguas Claras
3750	1593	San José o Pizote
3751	1593	Bijagua
3752	1593	Delicias
3753	1593	Dos Ríos
3754	1593	Yolillal
3755	1594	Los Chiles
3756	1594	Caño Negro
3757	1594	Amparo
3758	1594	San Jorge
3759	1595	Cote
3760	1596	Oriental
3761	1596	Occidental
3762	1596	San Nicolás
3763	1596	Aguacaliente  (San Francisco)
3764	1596	Guadalupe  (Arenilla)
3765	1596	Corralillo
3766	1596	Tierra Blanca
3767	1596	Dulce Nombre
3768	1596	Llano Grande
3769	1596	Quebradilla
3770	1597	Paraíso
3771	1597	Orosi
3772	1597	Cachí
3773	1597	Llanos de Sta Lucia
3774	1598	Tres Ríos
3775	1598	San Diego
3776	1598	Río Azul
3777	1599	Juan Viñas
3778	1599	Tucurrique
3779	1600	Turrialba
3780	1600	La Suiza
3781	1600	Peralta
3782	1600	Santa Teresita
3783	1600	Pavones
3784	1600	Tuis
3785	1600	Tayutic
3786	1600	Santa Rosa
3787	1600	Tres Equis
3788	1600	La Isabel
3789	1600	Chirripo
3790	1601	Pacayas
3791	1601	Cervantes
3792	1601	Capellades
3793	1602	Cot
3794	1602	Potrero Cerrado
3795	1602	Cipreses
3796	1603	El Tejar
3797	1603	Tobosi
3798	1603	Patio de Agua
3799	1604	Heredia
3800	1604	Ulloa
3801	1604	Vara Blanca
3802	1605	Barva
3803	1605	Santa Lucía
3804	1605	San José de la Montaña
3805	1606	Santo Domingo
3806	1606	Paracito
3807	1606	Santo Tomás
3808	1606	Tures
3809	1606	Pará
3810	1607	Santa Bárbara
3811	1607	Santo Domingo del Roble
3812	1607	Puraba
3813	1610	La Rivera
3814	1610	Asunción
3815	1611	San Joaquín
3816	1611	Barrantes
3817	1611	Llorente
3818	1613	Puerto Viejo
3819	1613	La Virgen
3820	1613	Horquetas
3821	1613	Llanuras del Gaspar
3822	1613	Cureña
3823	1614	Liberia
3824	1614	Cañas Dulces
3825	1614	Mayorga
3826	1614	Nacascolo
3827	1614	Curubande
3828	1615	Nicoya
3829	1615	Mansión
3830	1615	Quebrada Honda
3831	1615	Sámara
3832	1615	Nosara
3833	1615	Belén de Nosarita
3834	1616	Bolsón
3835	1616	Veintisiete de Abril
3836	1616	Tempate
3837	1616	Cartagena
3838	1616	Cuajiniquil
3839	1616	Diriá
3840	1616	Cabo Velas
3841	1616	Tamarindo
3842	1617	Bagaces
3843	1617	Mogote
3844	1617	Río Naranjo
3845	1618	Filadelfia
3846	1618	Sardinal
3847	1618	Belén
3848	1619	Cañas
3849	1619	Bebedero
3850	1619	Porozal
3851	1620	Juntas
3852	1620	Sierra
3853	1620	Colorado
3854	1621	Tilarán
3855	1621	Quebrada Grande
3856	1621	Tronadora
3857	1621	Líbano
3858	1621	Tierras Morenas
3859	1621	Arenal
3860	1622	Carmona
3861	1622	Santa Rita
3862	1622	Porvenir
3863	1622	Bejuco
3864	1623	La Cruz
3865	1623	Santa Cecilia
3866	1623	Garita
3867	1623	Santa Elena
3868	1624	Hojancha
3869	1624	Monte Romo
3870	1624	Puerto Carrillo
3871	1624	Huacas
3872	1625	Puntarenas
3873	1625	Pitahaya
3874	1625	Chomes
3875	1625	Lepanto
3876	1625	Paquera
3877	1625	Manzanillo
3878	1625	Guacimal
3879	1625	Barranca
3880	1625	Monte Verde
3881	1625	Isla del Coco
3882	1625	Cóbano
3883	1625	Chacarita
3884	1625	Chira (Isla)
3885	1625	Acapulco
3886	1625	El Roble
3887	1625	Arancibia
3888	1626	Espíritu Santo
3889	1626	San Juan Grande
3890	1626	Macacona
3891	1627	Volcán
3892	1627	Potrero Grande
3893	1627	Boruca
3894	1627	Pilas
3895	1627	Colinas o Bajo de Maíz
3896	1627	Chánguena
3897	1627	Bioley
3898	1627	Brunka
3899	1628	Miramar
3900	1628	Unión
3901	1629	Puerto Cortés
3902	1629	Palmar
3903	1629	Sierpe
3904	1629	Bahía Ballena
3905	1629	Piedras Blancas
3906	1630	Quepos
3907	1630	Savegre
3908	1630	Naranjito
3909	1631	Golfito
3910	1631	Puerto Jiménez
3911	1631	Guaycará
3912	1631	Pavones o Villa Conte
3913	1632	San Vito
3914	1632	Sabalito
3915	1632	Agua Buena
3916	1632	Limoncito
3917	1632	Pittier
3918	1633	Parrita
3919	1634	Corredores
3920	1634	La Cuesta
3921	1634	Paso Canoas
3922	1634	Laurel
3923	1635	Jacó
3924	1635	Tárcoles
3925	1636	Limón
3926	1636	Valle  La Estrella
3927	1636	Río Blanco
3928	1636	Matama
3929	1637	Guápiles
3930	1637	Jiménez
3931	1637	Rita
3932	1637	Roxana
3933	1637	Cariari
3934	1638	Siquirres
3935	1638	Pacuarito
3936	1638	Florida
3937	1638	Germania
3938	1638	Cairo
3939	1638	Alegría
3940	1639	Bratsi
3941	1639	Sixaola
3942	1639	Cahuita
3943	1639	Telire
3944	1640	Matina
3945	1640	Batán
3946	1640	Carrandí
3947	1641	Guácimo
3948	1641	Pocora
3949	1641	Río Jiménez
3950	1642	Alto Orinoco
3951	1642	Huachamacare Acanaña
3952	1642	Marawaka Toky Shamanaña
3953	1642	Mavaka Mavaka
3954	1642	Sierra Parima Parimabé
3955	1643	Caname Guarinuma
3956	1643	Ucata Laja Lisa
3957	1643	Yapacana Macuruco
3958	1644	Fernando Girón Tovar
3959	1644	Luis Alberto Gómez
3960	1644	Pahueña Limón de Parhueña
3961	1644	Platanillal Platanillal
3962	1645	Guayapo
3963	1645	Munduapo
3964	1645	Samariapo
3965	1645	Sipapo
3966	1646	Alto Ventuari
3967	1646	Bajo Ventuari
3968	1646	Medio Ventuari
3969	1647	Comunidad
3970	1647	Victorino
3971	1648	Casiquiare
3972	1648	Cocuy
3973	1648	San Carlos de Río Negro
3974	1648	Solano
3975	1649	Anaco
3976	1649	San Joaquín
3977	1650	Aragua de Barcelona
3978	1650	Cachipo
3979	1651	El Morro
3980	1651	Lechería
3981	1652	Puerto Píritu
3982	1652	San Miguel
3983	1652	Sucre
3984	1653	Atapirire
3985	1653	Boca del Pao
3986	1653	El Pao
3987	1653	Pariaguán
3988	1654	Santa Bárbara
3989	1654	Valle de Guanape
3990	1655	Calatrava
3991	1655	El Chaparro
3992	1655	Tomás Alfaro
3993	1656	Chorrerón
3994	1656	Guanta
3995	1657	Mamo
3996	1657	Soledad
3997	1658	Mapire
3998	1658	Piar
3999	1658	San Diego de Cabrutica
4000	1658	Santa Clara
4001	1658	Uverito
4002	1658	Zuata
4003	1659	Pozuelos
4004	1659	Puerto La Cruz
4005	1660	Onoto
4006	1660	San Pablo
4007	1661	El Carito
4008	1661	La Romereña
4009	1661	San Mateo
4010	1661	Santa Inés
4011	1662	Clarines
4012	1662	Guanape
4013	1662	Sabana de Uchire
4014	1663	Cantaura
4015	1663	Libertador
4016	1663	Santa Rosa
4017	1663	Urica
4018	1664	Píritu
4019	1664	San Francisco
4020	1665	San José de Guanipa
4021	1666	Boca de Chávez
4022	1666	Boca de Uchire
4023	1667	Pueblo Nuevo
4024	1667	Santa Ana
4025	1668	Bergantín
4026	1668	Caigua
4027	1668	El Carmen
4028	1668	El Pilar
4029	1668	Naricual
4030	1668	San Crsitóbal
4031	1669	Edmundo Barrios
4032	1669	Miguel Otero Silva
4033	1670	Achaguas
4034	1670	Apurito
4035	1670	El Yagual
4036	1670	Guachara
4037	1670	Mucuritas
4038	1670	Queseras del medio
4039	1671	Biruaca
4040	1672	Bruzual
4041	1672	Mantecal
4042	1672	Quintero
4043	1672	Rincón Hondo
4044	1672	San Vicente
4045	1673	Aramendi
4046	1673	El Amparo
4047	1673	Guasdualito
4048	1673	San Camilo
4049	1673	Urdaneta
4050	1674	Codazzi
4051	1674	Cunaviche
4052	1674	San Juan de Payara
4053	1675	Elorza
4054	1675	La Trinidad
4055	1676	El Recreo
4056	1676	Peñalver
4057	1676	San Fernando
4058	1676	San Rafael de Atamaica
4059	1677	Andrés Eloy Blanco
4060	1677	Choroní
4061	1677	Joaquín Crespo
4062	1677	José Casanova Godoy
4063	1677	Las Delicias
4064	1677	Los Tacarigua
4065	1677	Madre María de San José
4066	1677	Pedro José Ovalles
4067	1678	Bolívar
4068	1679	Camatagua
4069	1679	Carmen de Cura
4070	1680	Francisco de Miranda
4071	1680	Moseñor Feliciano González
4072	1680	Santa Rita
4073	1681	Santa Cruz
4074	1682	Castor Nieves Ríos
4075	1682	José Félix Ribas
4076	1682	Las Guacamayas
4077	1682	Pao de Zárate
4078	1683	José Rafael Revenga
4079	1684	Palo Negro
4080	1684	San Martín de Porres
4081	1685	Caña de Azúcar
4082	1685	El Limón
4083	1686	Ocumare de la Costa
4084	1687	Güiripa
4085	1687	Ollas de Caramacate
4086	1687	San Casimiro
4087	1687	Valle Morín
4088	1688	San Sebastían
4089	1689	Alfredo Pacheco Miranda
4090	1689	Arevalo Aponte
4091	1689	Chuao
4092	1689	Samán de Güere
4093	1689	Turmero
4094	1690	Santos Michelena
4095	1690	Tiara
4096	1691	Bella Vista
4097	1691	Cagua
4098	1692	Tovar
4099	1693	Las Peñitas
4100	1693	San Francisco de Cara
4101	1693	Taguay
4102	1694	Augusto Mijares
4103	1694	Magdaleno
4104	1694	San Francisco de Asís
4105	1694	Valles de Tucutunemo
4106	1694	Zamora
4107	1695	Juan Antonio Rodríguez Domínguez
4108	1695	Sabaneta
4109	1696	El Cantón
4110	1696	Puerto Vivas
4111	1696	Santa Cruz de Guacas
4112	1697	Andrés Bello
4113	1697	Nicolás Pulido
4114	1697	Ticoporo
4115	1698	Arismendi
4116	1698	Guadarrama
4117	1698	La Unión
4118	1698	San Antonio
4119	1699	Alberto Arvelo Larriva
4120	1699	Alto Barinas
4121	1699	Barinas
4122	1699	Corazón de Jesús
4123	1699	Dominga Ortiz de Páez
4124	1699	Manuel Palacio Fajardo
4125	1699	Ramón Ignacio Méndez
4126	1699	Rómulo Betancourt
4127	1699	San Silvestre
4128	1699	Santa Lucía
4129	1699	Torumos
4130	1699	Altamira de Cáceres
4131	1699	Barinitas
4132	1699	Calderas
4133	1700	Barrancas
4134	1700	El Socorro
4135	1700	Mazparrito
4136	1701	José Ignacio del Pumar
4137	1701	Pedro Briceño Méndez
4138	1702	El Real
4139	1702	Guasimitos
4140	1702	La Luz
4141	1702	Obispos
4142	1703	Ciudad Bolívia
4143	1703	José Ignacio Briceño
4144	1703	Páez
4145	1704	Dolores
4146	1704	Libertad
4147	1704	Palacio Fajardo
4148	1705	Ciudad de Nutrias
4149	1705	El Regalo
4150	1705	Puerto Nutrias
4151	1705	Santa Catalina
4152	1706	Barceloneta
4153	1706	Raúl Leoni
4154	1707	5 de Julio
4155	1707	Cachamay
4156	1707	Chirica
4157	1707	Dalla Costa
4158	1707	Once de Abril
4159	1707	Pozo Verde
4160	1707	Simón Bolívar
4161	1707	Unare
4162	1707	Universidad
4163	1707	Vista al Sol
4164	1707	Yocoima
4165	1708	Altagracia
4166	1708	Ascensión Farreras
4167	1708	Cedeño
4168	1708	Guaniamo
4169	1708	La Urbana
4170	1708	Pijiguaos
4171	1709	El Callao
4172	1710	Gran Sabana
4173	1710	Ikabarú
4174	1711	Agua Salada
4175	1711	Catedral
4176	1711	José Antonio Páez
4177	1711	La Sabanita
4178	1711	Marhuanta
4179	1711	Orinoco
4180	1711	Panapana
4181	1711	Vista Hermosa
4182	1711	Zea
4183	1712	Padre Pedro Chien
4184	1712	Río Grande
4185	1713	Pedro Cova
4186	1714	Roscio
4187	1714	Salóm
4188	1715	San Isidro
4189	1715	Sifontes
4190	1715	Aripao
4191	1715	Guarataro
4192	1715	Las Majadas
4193	1715	Moitaco
4194	1716	Bejuma
4195	1716	Canoabo
4196	1717	Carabobo
4197	1717	Güigüe
4198	1717	Tacarigua
4199	1718	Aguas Calientes
4200	1718	Mariara
4201	1719	Ciudad Alianza
4202	1719	Guacara
4203	1719	Yagua
4204	1720	Morón
4205	1720	Independencia
4206	1720	Tocuyito
4207	1721	Los Guayos
4208	1722	Miranda
4209	1723	Montalbán
4210	1724	Naguanagua
4211	1725	Bartolomé Salóm
4212	1725	Borburata
4213	1725	Democracia
4214	1725	Fraternidad
4215	1725	Goaigoaza
4216	1725	Juan José Flores
4217	1725	Patanemo
4218	1725	Unión
4219	1726	San Diego
4220	1728	Candelaria
4221	1728	Miguel Peña
4222	1728	Negro Primero
4223	1728	Rafael Urdaneta
4224	1728	San Blas
4225	1728	San José
4226	1729	Cojedes
4227	1729	Juan de Mata Suárez
4228	1730	El Baúl
4229	1731	La Aguadita
4230	1731	Macapo
4231	1733	Libertad de Cojedes
4232	1733	Rómulo Gallegos
4233	1734	Juan Ángel Bravo
4234	1734	Manuel Manrique
4235	1734	San Carlos de Austria
4236	1735	General en Jefe José Laurencio Silva
4237	1736	Tinaquillo
4238	1737	Almirante Luis Brión
4239	1737	Curiapo
4240	1737	Francisco Aniceto Lugo
4241	1737	Manuel Renaud
4242	1737	Padre Barral
4243	1737	Santos de Abelgas
4244	1738	Cinco de Julio
4245	1738	Imataca
4246	1738	Juan Bautista Arismendi
4247	1738	Manuel Piar
4248	1739	Luis Beltrán Prieto Figueroa
4249	1739	Pedernales
4250	1740	José Vidal Marcano
4251	1740	Juan Millán
4252	1740	Leonardo Ruíz Pineda
4253	1740	Mariscal Antonio José de Sucre
4254	1740	Monseñor Argimiro García
4255	1740	San José (Delta Amacuro)
4256	1740	San Rafael (Delta Amacuro)
4257	1740	Virgen del Valle
4258	1740	23 de enero
4259	1740	Antímano
4260	1740	Caricuao
4261	1740	Coche
4262	1740	El Junquito
4263	1740	El Paraíso
4264	1740	El Valle
4265	1740	La Candelaria
4266	1740	La Pastora
4267	1740	La Vega
4268	1740	Macarao
4269	1740	San Agustín
4270	1740	San Bernardino
4271	1740	San Juan
4272	1740	San Pedro
4273	1740	Santa Rosalía
4274	1740	Santa Teresa
4275	1740	Sucre (Catia)
4276	1741	Capadare
4277	1741	San Juan de los Cayos
4278	1741	Aracua
4279	1741	La Peña
4280	1741	San Luis
4281	1742	Bariro
4282	1742	Borojó
4283	1742	Capatárida
4284	1742	Guajiro
4285	1742	Seque
4286	1742	Valle de Eroa
4287	1742	Zazárida
4288	1743	Cacique Manaure
4289	1744	Carirubana
4290	1744	Norte
4291	1744	Urbana Punta Cardón
4292	1745	Acurigua
4293	1745	Guaibacoa
4294	1745	La Vela de Coro
4295	1745	Las Calderas
4296	1745	Macoruca
4297	1746	Dabajuro
4298	1747	Agua Clara
4299	1747	Avaria
4300	1747	Pedregal
4301	1747	Piedra Grande
4302	1747	Purureche
4303	1748	Adaure
4304	1748	Adícora
4305	1748	Baraived
4306	1748	Buena Vista
4307	1748	El Hato
4308	1748	El Vínculo
4309	1748	Jadacaquiva
4310	1748	Moruy
4311	1749	Agua Larga
4312	1749	Churuguara
4313	1749	El Paují
4314	1749	Mapararí
4315	1750	Agua Linda
4316	1750	Araurima
4317	1750	Jacura
4318	1751	Boca de Aroa
4319	1751	Tucacas
4320	1752	Judibana
4321	1752	Los Taques
4322	1753	Casigua
4323	1753	Mene de Mauroa
4324	1753	San Félix
4325	1753	Guzmán Guillermo
4326	1753	Mitare
4327	1753	Río Seco
4328	1753	San Gabriel
4329	1754	Boca del Tocuyo
4330	1754	Chichiriviche
4331	1754	Tocuyo de la Costa
4332	1755	Palmasola
4333	1756	Cabure
4334	1756	Colina
4335	1756	Curimagua
4336	1756	San José de la Costa
4337	1757	Pecaya
4338	1758	Tocópero
4339	1759	El Charal
4340	1759	Las Vegas del Tuy
4341	1759	Santa Cruz de Bucaral
4342	1760	Urumaco
4343	1760	La Ciénaga
4344	1760	La Soledad
4345	1760	Pueblo Cumarebo
4346	1760	Puerto Cumarebo
4347	1761	Camaguán
4348	1761	Puerto Miranda
4349	1762	Chaguaramas
4350	1763	San Rafael de Laya
4351	1763	Tucupido
4352	1764	Altagracia de Orituco
4353	1764	Carlos Soublette
4354	1764	Libertad de Orituco
4355	1764	Paso Real de Macaira
4356	1764	San Francisco de Macaira
4357	1764	San Francisco Javier de Lezama
4358	1764	San Rafael de Orituco
4359	1765	Cantaclaro
4360	1765	Parapara
4361	1765	San Juan de los Morros
4362	1766	El Sombrero
4363	1766	Sosa
4364	1767	Cabruta
4365	1767	Las Mercedes
4366	1767	Santa Rita de Manapire
4367	1768	Espino
4368	1768	Valle de la Pascua
4369	1769	Ortiz
4370	1769	San Francisco de Tiznados
4371	1769	San José de Tiznados
4372	1769	San Lorenzo de Tiznados
4373	1770	San José de Unare
4374	1770	Zaraza
4375	1771	Cazorla
4376	1771	Guayabal
4377	1772	San José de Guaribe
4378	1772	Uveral
4379	1773	Altamira
4380	1773	Santa María de Ipire
4381	1774	Capital Urbana Calabozo
4382	1774	El Calvario
4383	1774	El Rastro
4384	1774	Guardatinajas
4385	1775	Caraballeda
4386	1775	Carayaca
4387	1775	Caruao Chuspa
4388	1775	Catia La Mar
4389	1775	El Junko
4390	1775	La Guaira
4391	1775	Macuto
4392	1775	Maiquetía
4393	1775	Naiguatá
4394	1775	Urimare
4395	1775	Pío Tamayo
4396	1775	Quebrada Honda de Guache
4397	1775	Yacambú
4398	1776	Fréitez
4399	1776	José María Blanco
4400	1777	Aguedo Felipe Alvarado
4401	1777	Concepción
4402	1777	El Cují
4403	1777	Juan de Villegas
4404	1777	Juárez
4405	1777	Tamaca
4406	1778	Coronel Mariano Peraza 
4407	1778	Cuara
4408	1778	Diego de Lozada
4409	1778	José Bernardo Dorante
4410	1778	Juan Bautista Rodríguez
4411	1778	Paraíso de San José
4412	1778	Tintorero
4413	1779	Anzoátegui
4414	1779	Guarico
4415	1779	Hilario Luna y Luna
4416	1779	Humocaro Alto
4417	1779	Humocaro Bajo
4418	1779	Morán
4419	1780	Agua Viva
4420	1780	Cabudare
4421	1780	José Gregorio Bastidas
4422	1781	Buría
4423	1781	Gustavo Vegas León
4424	1781	Sarare
4425	1782	Antonio Díaz
4426	1782	Camacaro
4427	1782	Castañeda
4428	1782	Cecilio Zubillaga
4429	1782	Chiquinquirá
4430	1782	El Blanco
4431	1782	Espinoza de los Monteros
4432	1782	Heriberto Arroyo
4433	1782	Lara
4434	1782	Manuel Morillo
4435	1782	Montaña Verde
4436	1782	Montes de Oca
4437	1782	Reyes Vargas
4438	1782	Torres
4439	1782	Trinidad Samuel
4440	1782	Moroturo
4441	1782	Siquisique
4442	1782	Xaguas
4443	1783	Gabriel Picón González
4444	1783	Héctor Amable Mora
4445	1783	José Nucete Sardi
4446	1783	Presidente Betancourt
4447	1783	Presidente Páez
4448	1783	Presidente Rómulo Gallegos
4449	1783	Pulido Méndez
4450	1784	La Azulita
4451	1785	Mesa Bolívar
4452	1785	Mesa de Las Palmas
4453	1785	Santa Cruz de Mora
4454	1786	Aricagua
4455	1787	Canagua
4456	1787	Capurí
4457	1787	Chacantá
4458	1787	El Molino
4459	1787	Guaimaral
4460	1787	Mucuchachí
4461	1787	Mucutuy
4462	1788	Acequias
4463	1788	Fernández Peña
4464	1788	Jají
4465	1788	La Mesa
4466	1788	Matriz
4467	1788	San José del Sur
4468	1789	Florencio Ramírez
4469	1789	Tucaní
4470	1790	Las Piedras
4471	1790	Santo Domingo
4472	1791	Guaraque
4473	1791	Mesa de Quintero
4474	1791	Río Negro
4475	1792	Arapuey
4476	1792	Palmira
4477	1793	San Cristóbal de Torondoy
4478	1793	Torondoy
4479	1793	Antonio Spinetti Dini
4480	1793	Arias
4481	1793	Caracciolo Parra Pérez
4482	1793	Domingo Peña
4483	1793	El Llano
4484	1793	Gonzalo Picón Febres
4485	1793	Jacinto Plaza
4486	1793	Juan Rodríguez Suárez
4487	1793	Lasso de la Vega
4488	1793	Los Nevados
4489	1793	Mariano Picón Salas
4490	1793	Milla
4491	1793	Osuna Rodríguez
4492	1793	Sagrario
4493	1793	La Venta
4494	1793	Piñango
4495	1793	Timotes
4496	1794	Eloy Paredes
4497	1794	San Rafael de Alcázar
4498	1794	Santa Elena de Arenales
4499	1795	Santa María de Caparo
4500	1796	Pueblo Llano
4501	1797	Cacute
4502	1797	La Toma
4503	1797	Mucuchíes
4504	1797	Mucurubá
4505	1797	San Rafael
4506	1798	Bailadores
4507	1798	Gerónimo Maldonado
4508	1799	Tabay
4509	1799	Chiguará
4510	1799	Estánquez
4511	1799	La Trampa
4512	1799	Lagunillas
4513	1799	Pueblo Nuevo del Sur
4514	1800	María de la Concepción Palacios Blanco
4515	1800	Nueva Bolivia
4516	1800	Santa Apolonia
4517	1801	Caño El Tigre
4518	1802	Aragüita
4519	1802	Arévalo González
4520	1802	Capaya
4521	1802	Caucagua
4522	1802	El Café
4523	1802	Marizapa
4524	1802	Panaquire
4525	1802	Ribas
4526	1802	Cumbo
4527	1802	San José de Barlovento
4528	1803	El Cafetal
4529	1803	Las Minas
4530	1803	Nuestra Señora del Rosario
4531	1804	Curiepe
4532	1804	Higuerote
4533	1804	Tacarigua de Brión
4534	1805	Mamporal
4535	1806	Carrizal
4536	1807	Chacao
4537	1808	Charallave
4538	1808	Las Brisas
4539	1809	El Hatillo
4540	1810	Altagracia de la Montaña
4541	1810	Cecilio Acosta
4542	1810	El Jarillo
4543	1810	Los Teques
4544	1810	Paracotos
4545	1810	Tácata
4546	1810	Cartanal
4547	1810	Santa Teresa del Tuy
4548	1811	La Democracia
4549	1811	Ocumare del Tuy
4550	1812	San Antonio de los Altos
4551	1812	El Guapo
4552	1812	Paparo
4553	1812	Río Chico
4554	1812	San Fernando del Guapo
4555	1812	Tacarigua de la Laguna
4556	1813	Santa Lucía del Tuy
4557	1814	Cúpira
4558	1814	Machurucuto
4559	1815	Guarenas
4560	1815	San Antonio de Yare
4561	1815	San Francisco de Yare
4562	1815	Caucagüita
4563	1815	Filas de Mariche
4564	1815	La Dolorita
4565	1815	Leoncio Martínez
4566	1815	Petare
4567	1815	Cúa
4568	1815	Nueva Cúa
4569	1815	Guatire
4570	1815	San Antonio de Maturín
4571	1815	San Francisco de Maturín
4572	1816	Aguasay
4573	1816	Caripito
4574	1817	Caripe
4575	1817	El Guácharo
4576	1817	La Guanota
4577	1817	Sabana de Piedra
4578	1817	Teresen
4579	1817	Areo
4580	1817	Capital Cedeño
4581	1817	San Félix de Cantalicio
4582	1817	Viento Fresco
4583	1817	El Tejero
4584	1817	Punta de Mata
4585	1817	Las Alhuacas
4586	1817	Tabasca
4587	1817	Temblador
4588	1818	Alto de los Godos
4589	1818	Boquerón
4590	1818	El Corozo
4591	1818	El Furrial
4592	1818	Jusepín
4593	1818	La Cruz
4594	1818	La Pica
4595	1818	Las Cocuizas
4596	1818	San Simón
4597	1818	Aparicio
4598	1818	Aragua de Maturín
4599	1818	Chaguamal
4600	1818	El Pinto
4601	1818	Guanaguana
4602	1818	La Toscana
4603	1818	Taguaya
4604	1819	Quiriquire
4605	1821	Los Barrancos de Fajardo
4606	1822	Uracoa
4607	1823	Antolín del Campo
4608	1824	San Juan Bautista
4609	1824	Zabala
4610	1825	Francisco Fajardo
4611	1825	García
4612	1826	Guevara
4613	1826	Matasiete
4614	1827	Aguirre
4615	1827	Maneiro
4616	1828	Adrián
4617	1828	Juan Griego
4618	1828	Yaguaraparo
4619	1829	Porlamar
4620	1830	Boca de Río
4621	1830	San Francisco de Macanao
4622	1831	Los Baleales
4623	1831	Tubores
4624	1832	Vicente Fuentes
4625	1832	Villalba
4626	1833	Capital Araure
4627	1833	Río Acarigua
4628	1834	Capital Esteller
4629	1835	Córdoba
4630	1835	Guanare
4631	1835	San José de la Montaña
4632	1835	San Juan de Guanaguanare
4633	1835	Virgen de la Coromoto
4634	1836	Divina Pastora
4635	1836	Guanarito
4636	1836	Trinidad de la Capilla
4637	1837	Monseñor José Vicente de Unda
4638	1837	Peña Blanca
4639	1838	Aparición
4640	1838	Capital Ospino
4641	1838	La Estación
4642	1838	Payara
4643	1838	Pimpinela
4644	1838	Ramón Peraza
4645	1839	Caño Delgadito
4646	1839	Papelón
4647	1840	Antolín Tovar
4648	1840	San Genaro de Boconoito
4649	1841	San Rafael de Onoto
4650	1841	Santa Fe
4651	1841	Thermo Morles
4652	1842	Florida
4653	1842	San José de Saguaz
4654	1842	San Rafael de Palo Alzado
4655	1842	Uvencio Antonio Velásquez
4656	1842	Villa Rosa
4657	1843	Canelones
4658	1843	San Isidro Labrador
4659	1843	Turén
4660	1843	Mariño
4661	1844	San José de Aerocuar
4662	1844	Tavera Acosta
4663	1844	Antonio José de Sucre
4664	1844	El Morro de Puerto Santo
4665	1844	Puerto Santo
4666	1844	Río Caribe
4667	1844	San Juan de las Galdonas
4668	1845	El Rincón
4669	1845	General Francisco Antonio Váquez
4670	1845	Guaraúnos
4671	1845	Tunapuicito
4672	1846	Maracapana
4673	1847	El Paujil
4674	1848	Chacopata
4675	1848	Cruz Salmerón Acosta
4676	1848	Manicuare
4677	1848	Campo Elías
4678	1848	Tunapuy
4679	1848	Campo Claro
4680	1848	Irapa
4681	1848	Maraval
4682	1848	San Antonio de Irapa
4683	1848	Soro
4684	1849	Mejía
4685	1850	Arenas
4686	1850	Cogollar
4687	1850	Cumanacoa
4688	1850	San Lorenzo
4689	1851	Catuaro
4690	1851	Rendón
4691	1851	San Cruz
4692	1851	Santa María
4693	1851	Villa Frontado (Muelle de Cariaco)
4694	1851	Ayacucho
4695	1851	Gran Mariscal
4696	1851	Valentín Valiente
4697	1852	Bideau
4698	1852	Cristóbal Colón
4699	1852	Güiria
4700	1852	Punta de Piedras
4701	1853	Antonio Rómulo Costa
4702	1854	Rivas Berti
4703	1854	San Pedro del Río
4704	1854	General Juan Vicente Gómez
4705	1854	Isaías Medina Angarita
4706	1854	Palotal
4707	1855	Amenodoro Ángel Lamus
4708	1855	Cárdenas
4709	1855	La Florida
4710	1857	Alberto Adriani
4711	1857	Fernández Feo
4712	1858	Boca de Grita
4713	1858	García de Hevia
4714	1859	Guásimos
4715	1859	Juan Germán Roscio
4716	1859	Román Cárdenas
4717	1860	Emilio Constantino Guerrero
4718	1860	Jáuregui
4719	1860	Monseñor Miguel Antonio Salas
4720	1861	José María Vargas
4721	1862	Bramón
4722	1862	Junín
4723	1862	La Petrólea
4724	1862	Quinimarí
4725	1862	Cipriano Castro
4726	1862	Manuel Felipe Rugeles
4727	1862	Doradas
4728	1862	Emeterio Ochoa
4729	1862	San Joaquín de Navay
4730	1863	Constitución
4731	1863	Lobatera
4732	1864	Michelena
4733	1865	La Palmita
4734	1865	Panamericano
4735	1866	Nueva Arcadia
4736	1866	Pedro María Ureña
4737	1867	Delicias
4738	1868	Boconó
4739	1868	Hernández
4740	1868	Samuel Darío Maldonado
4741	1869	Dr. Francisco Romero Lobo
4742	1869	La Concordia
4743	1869	Pedro María Morantes
4744	1869	San Sebastián
4745	1870	San Judas Tadeo
4746	1871	Seboruco
4747	1871	Simón Rodríguez
4748	1871	Eleazar López Contreras
4749	1872	Torbes
4750	1873	Juan Pablo Peñalosa
4751	1873	Potosí
4752	1873	Uribante
4753	1873	Araguaney
4754	1873	El Jaguito
4755	1873	La Esperanza
4756	1873	Santa Isabel
4757	1874	Burbusay
4758	1874	General Ribas
4759	1874	Guaramacal
4760	1874	Monseñor Jáuregui
4761	1874	Mosquey
4762	1874	Rafael Rangel
4763	1874	Vega de Guaramacal
4764	1874	Cheregüé
4765	1874	Granados
4766	1874	Sabana Grande
4767	1875	Arnoldo Gabaldón
4768	1875	Bolivia
4769	1875	Carrillo
4770	1875	Cegarra
4771	1875	Chejendé
4772	1875	Manuel Salvador Ulloa
4773	1876	Carache
4774	1876	Cuicas
4775	1876	La Concepción
4776	1876	Panamericana
4777	1877	Escuque
4778	1877	Sabana Libre
4779	1878	Los Caprichos
4780	1880	El Progreso
4781	1880	La Ceiba
4782	1880	Tres de Febrero
4783	1880	Agua Caliente
4784	1880	Agua Santa
4785	1880	El Cenizo
4786	1880	El Dividive
4787	1880	Valerita
4788	1881	Monte Carmelo
4789	1881	Santa María del Horcón
4790	1882	El Baño
4791	1882	Jalisco
4792	1882	Motatán
4793	1883	Flor de Patria
4794	1883	La Paz
4795	1883	Pampán
4796	1884	Pampanito
4797	1884	Pampanito II
4798	1885	Betijoque
4799	1885	José Gregorio Hernández
4800	1885	La Pueblita
4801	1885	Los Cedros
4802	1886	Antonio Nicolás Briceño
4803	1886	Campo Alegre
4804	1886	Carvajal
4805	1886	José Leonardo Suárez
4806	1886	Sabana de Mendoza
4807	1886	Valmore Rodríguez
4808	1887	Andrés Linares
4809	1887	Cristóbal Mendoza
4810	1887	Cruz Carrillo
4811	1887	Monseñor Carrillo
4812	1887	Tres Esquinas
4813	1887	Cabimbú
4814	1887	Jajó
4815	1887	La Mesa de Esnujaque
4816	1887	La Quebrada
4817	1887	Santiago
4818	1887	Tuñame
4819	1888	Juan Ignacio Montilla
4820	1888	La Beatriz
4821	1888	La Puerta
4822	1888	Mendoza del Valle de Momboy
4823	1888	Mercedes Díaz
4824	1889	Arístides Bastidas
4825	1890	Chivacoa
4826	1891	Cocorote
4827	1893	El Guayabo
4828	1893	Farriar
4829	1895	Manuel Monge
4830	1896	Nirgua
4831	1896	Temerla
4832	1897	San Andrés
4833	1897	Yaritagua
4834	1898	Albarico
4835	1898	San Felipe
4836	1898	San Javier
4837	1899	Urachiche
4838	1900	Isla de Toas
4839	1900	Monagas
4840	1901	General Urdaneta
4841	1901	Manuel Guanipa Matos
4842	1901	Marcelino Briceño
4843	1901	San Timoteo
4844	1902	Ambrosio
4845	1902	Arístides Calvani
4846	1902	Carmen Herrera
4847	1902	Germán Ríos Linares
4848	1902	Jorge Hernández
4849	1902	La Rosa
4850	1902	Punta Gorda
4851	1902	San Benito
4852	1903	Encontrados
4853	1903	Udón Pérez
4854	1904	Moralito
4855	1904	San Carlos del Zulia
4856	1904	Santa Cruz del Zulia
4857	1904	Urribarrí
4858	1905	Carlos Quevedo
4859	1905	Francisco Javier Pulgar
4860	1905	Guamo-Gavilanes
4861	1906	José Ramón Yépez
4862	1906	Mariano Parra León
4863	1907	Barí
4864	1907	Jesús María Semprún
4865	1908	El Carmelo
4866	1908	Potreritos
4867	1909	Alonso de Ojeda
4868	1909	Campo Lara
4869	1909	Venezuela
4870	1910	Bartolomé de las Casas
4871	1910	San José de Perijá
4872	1911	La Sierrita
4873	1911	Las Parcelas
4874	1911	Luis de Vicente
4875	1911	Monseñor Marcos Sergio Godoy
4876	1911	Ricaurte
4877	1911	Tamare
4878	1912	Antonio Borjas Romero
4879	1912	Cacique Mara
4880	1912	Carracciolo Parra Pérez
4881	1912	Coquivacoa
4882	1912	Cristo de Aranza
4883	1912	Francisco Eugenio Bustamante
4884	1912	Idelfonzo Vásquez
4885	1912	Juana de Ávila
4886	1912	Luis Hurtado Higuera
4887	1912	Manuel Dagnino
4888	1912	Olegario Villalobos
4889	1912	Venancio Pulgar
4890	1912	Ana María Campos
4891	1912	Faría
4892	1912	Alta Guajira
4893	1912	Elías Sánchez Rubio
4894	1912	Guajira
4895	1912	Sinamaica
4896	1913	Donaldo García
4897	1913	El Rosario
4898	1913	Sixto Zambrano
4899	1913	Domitila Flores
4900	1913	El Bajo
4901	1913	Francisco Ochoa
4902	1913	Los Cortijos
4903	1913	Marcial Hernández
4904	1914	El Mene
4905	1914	José Cenobio Urribarrí
4906	1914	Pedro Lucas Urribarrí
4907	1914	Rafael Maria Baralt
4908	1914	Bobures
4909	1914	El Batey
4910	1914	Gibraltar
4911	1914	Heras
4912	1914	Monseñor Arturo Álvarez
4913	1915	La Victoria
4914	2297	San Javier
4915	2297	Trinidad
4916	2298	Reyes
4917	2298	Rurrenabaque
4918	2298	San Borja
4919	2298	Santa Rosa
4920	2299	Baures
4921	2299	Huacaraje
4922	2299	Magdalena
4923	2300	Puerto Siles
4924	2300	San Joaquín
4925	2300	San Ramón
4926	2301	Loreto
4927	2301	San Andrés
4928	2302	San Ignacio
4929	2303	Guayaramerín
4930	2303	Riberalta
4931	2304	Exaltación
4932	2304	Santa Ana
4933	2305	Tarvita
4934	2305	Villa Azurduy
4935	2306	Villa Serrano
4936	2307	Monteagudo
4937	2307	San Pablo de Huacareta
4938	2308	Huacaya
4939	2308	Macharetí
4940	2308	Villa Vaca Guzmán (Muyupampa)
4941	2309	Camargo
4942	2309	Incahuasi
4943	2309	San Lucas
4944	2309	Villa Charcas
4945	2310	Poroma
4946	2310	Sucre
4947	2310	Yotala
4948	2311	Camataqui (Villa Abecia)
4949	2311	Culpina
4950	2311	Las Carreras
4951	2312	El Villar
4952	2312	Padilla
4953	2312	Sopachuy
4954	2312	Tomina
4955	2312	Villa Alcalá
4956	2313	Tarabuco
4957	2313	Yamparáez
4958	2314	Icla
4959	2314	Presto
4960	2314	Villa Mojocoya
4961	2314	Villa Zudañez
4962	2315	Arani
4963	2315	Vacas
4964	2316	Arque
4965	2316	Tacopaya
4966	2317	Cocapata
4967	2317	Independencia
4968	2317	Morochata
4969	2318	Bolívar
4970	2319	Aiquile
4971	2319	Omereque
4972	2319	Pasorapa
4973	2320	Capinota
4974	2320	Santivañez
4975	2320	Sicaya
4976	2321	Chimoré
4977	2321	Entre Ríos (Bulo Bulo)
4978	2321	Pocona
4979	2321	Pojo
4980	2321	Puerto Villarroel
4981	2321	Totora
4982	2321	Cochabamba
4983	2322	Colomi
4984	2322	Sacaba
4985	2322	Villa Tunari
4986	2323	Anzaldo
4987	2323	Arbieto
4988	2323	Sacabamba
4989	2323	Tarata
4990	2324	Cliza
4991	2324	Toco
4992	2324	Tolata
4993	2325	Alalay
4994	2325	Mizque
4995	2325	Vila Vila
4996	2326	Cuchumuela (Villa Gualberto Villarroel)
4997	2326	Punata
4998	2326	San Benito
4999	2326	Tacachi
5000	2326	Villa Rivero
5001	2327	Colcapirhua
5002	2327	Quillacollo
5003	2327	Sipe Sipe
5004	2327	Tiquipaya
5005	2327	Vinto
5006	2328	Tapacarí
5007	2329	Shinahota
5008	2329	Tiraque
5009	2330	Ixiamas
5010	2330	San Buenaventura
5011	2331	Ayo Ayo
5012	2331	Calamarca
5013	2331	Collana
5014	2331	Colquencha
5015	2331	Patacamaya
5016	2331	Sica Sica
5017	2331	Umala
5018	2332	Curva
5019	2332	Gral. Juan José Perez (Charazani)
5020	2333	Escoma
5021	2333	Humanata
5022	2333	Mocomoco
5023	2333	Puerto Acosta
5024	2333	Puerto Carabuco
5025	2334	Alto Beni
5026	2334	Caranavi
5027	2335	Apolo
5028	2335	Pelechuco
5029	2336	Catacora
5030	2336	Santiago de Machaca
5031	2337	Chacarilla
5032	2337	Papel Pampa
5033	2337	San Pedro de Curahuara
5034	2338	Desaguadero
5035	2338	Guaqui
5036	2338	Jesús de Machaca
5037	2338	San Andrés de Machaca
5038	2338	Taraco
5039	2338	Tiahuanacu
5040	2338	Viacha
5041	2339	Cajuata
5042	2339	Colquiri
5043	2339	Ichoca
5044	2339	Inquisivi
5045	2339	Licoma Pampa
5046	2339	Quime
5047	2340	Combaya
5048	2340	Guanay
5049	2340	Mapiri
5050	2340	Quiabaya
5051	2340	Sorata
5052	2340	Tacacoma
5053	2340	Teoponte
5054	2340	Tipuani
5055	2341	Cairoma
5056	2341	Luribay
5057	2341	Malla
5058	2341	Sapahaqui
5059	2341	Yaco
5060	2342	Batallas
5061	2342	Laja
5062	2342	Pucarani
5063	2342	Puerto Pérez
5064	2343	Copacabana
5065	2343	San Pedro de Tiquina
5066	2343	Tito Yupanqui
5067	2344	Aucapata
5068	2344	Ayata
5069	2344	Chuma
5070	2345	Achocalla
5071	2345	El Alto
5072	2345	La Paz
5073	2345	Mecapaca
5074	2345	Palca
5075	2346	Coripata
5076	2346	Coroico
5077	2347	Achacachi
5078	2347	Ancoraimes
5079	2347	Chua Cocani
5080	2347	Huarina
5081	2347	Huatajata
5082	2347	Santiago de Huata
5083	2348	Calacoto
5084	2348	Caquiaviri
5085	2348	Charaña
5086	2348	Comanche
5087	2348	Coro Coro
5088	2348	Nazacara de Pacajes
5089	2348	Santiago de Callapa
5090	2348	Waldo Ballivián
5091	2349	Chulumani
5092	2349	Irupana
5093	2349	La Asunta
5094	2349	Palos Blancos
5095	2349	Yanacachi
5096	2350	Challapata
5097	2350	Santuario de Quillacas
5098	2351	Choquecota
5099	2351	Corque
5100	2351	Caracollo
5101	2351	El Choro
5102	2351	Oruro
5103	2351	Soracachi (Paria)
5104	2352	Pampa Aullagas
5105	2352	Salinas de Garci Mendoza
5106	2353	Cruz de Machacamarca
5107	2353	Escara
5108	2353	Esmeralda
5109	2353	Huachacalla
5110	2353	Yunguyo del Litoral
5111	2354	Carangas
5112	2354	La Rivera
5113	2354	Todos Santos
5114	2355	Santiago de Huayllamarca
5115	2356	Machacamarca
5116	2356	Villa Huanuni
5117	2357	Antequera
5118	2357	Pazña
5119	2357	Villa Poopó
5120	2359	Chipaya
5121	2359	Coipasa
5122	2359	Sabaya
5123	2360	Curahuara de Carangas
5124	2360	Turco
5125	2361	Toledo
5126	2362	Santiago de Huari
5127	2363	Andamarca
5128	2363	Belén de Andamarca
5129	2364	Eucaliptus
5130	2365	Humaita (Ingavi)
5131	2365	Santa Rosa del Abuná
5132	2366	Nueva Esperanza
5133	2366	Santos Mercado (Reserva)
5134	2366	Villa Nueva (Loma Alta)
5135	2367	Blanca Flor (San Lorenzo)
5136	2367	El Sena
5137	2367	Puerto Gonzalo Moreno
5138	2368	Filadelfia
5139	2368	Puerto Rico
5140	2368	San Pedro
5141	2369	Bella Flor
5142	2369	Bolpebra
5143	2369	Cobija
5144	2369	Porvenir
5145	2370	Caripuyo
5146	2370	Sacaca
5147	2371	Porco
5148	2371	Tomave
5149	2371	Uyuni
5150	2372	San Pedro de Buena Vista
5151	2372	Toro Toro
5152	2373	Colquechaca
5153	2373	Ocurí
5154	2373	Pocoata
5155	2373	Ravelo
5156	2374	Betanzos
5157	2374	Chaquí
5158	2374	Tacobamba
5159	2375	Llica
5160	2375	Tahua
5161	2376	San Agustín
5162	2377	Acasio
5163	2377	Arampampa
5164	2378	Caiza "D"
5165	2378	Ckochas
5166	2378	Puna
5167	2379	Villazón
5168	2380	Cotagaita
5169	2380	Vitichi
5170	2381	Colcha "K"
5171	2381	San Pedro de Quemes
5172	2382	Chayanta
5173	2382	Chuquihuta Ayllu Jucumani
5174	2382	Llallagua
5175	2382	Uncía
5176	2383	Atocha
5177	2383	Tupiza
5178	2384	Mojinete
5179	2384	San Antonio de Esmoruco
5180	2384	San Pablo de Lipez
5181	2385	Belén de Urmiri
5182	2385	Potosí
5183	2385	Tinguipaya
5184	2385	Villa de Yocalla
5185	2386	Cotoca
5186	2386	El Torno
5187	2386	La Guardia
5188	2386	Porongo (Ayacucho)
5189	2386	Santa Cruz de la Sierra
5190	2387	San Matías
5191	2388	Comarapa
5192	2388	Saipina
5193	2389	Pailón
5194	2389	Roboré
5195	2389	San José
5196	2390	Boyuibe
5197	2390	Cabezas
5198	2390	Camiri
5199	2390	Charagua
5200	2390	Cuevo
5201	2390	Gutiérrez
5202	2390	Lagunillas
5203	2391	Mairana
5204	2391	Pampa Grande
5205	2391	Quirusillas
5206	2391	Samaipata
5207	2392	Carmen Rivero Torres
5208	2392	Puerto Quijarro
5209	2392	Puerto Suárez
5210	2393	Ascención de Guarayos
5211	2393	El Puente
5212	2393	Urubichá
5213	2394	Buena Vista
5214	2394	San Carlos
5215	2394	San Juan
5216	2394	Yapacaní
5217	2395	Concepción
5218	2395	Cuatro Cañadas
5219	2395	San Antonio de Lomerío
5220	2395	San Julián
5221	2396	Gral. Saavedra
5222	2396	Mineros
5223	2396	Montero
5224	2396	Puerto Fernández Alonso
5225	2397	Colpa Bélgica
5226	2397	Portachuelo
5227	2397	Santa Rosa del Sara
5228	2398	El Trigal
5229	2398	Moro Moro
5230	2398	Postrervalle
5231	2398	Pucará
5232	2398	Vallegrande
5233	2399	San Miguel
5234	2399	San Rafael
5235	2400	Okinawa
5236	2400	Warnes
5237	2401	Bermejo
5238	2401	Padcaya
5239	2402	Uriondo (Concepción)
5240	2402	Yunchará
5241	2403	Entre Ríos
5242	2403	Tarija
5243	2404	Caraparí
5244	2404	Villamontes
5245	2404	Yacuiba
5246	2406	Almirante
5247	2406	Bajo Culubre
5248	2406	Barriada Guaymí
5249	2406	Barrio Francés
5250	2406	Cauchero
5251	2406	Ceiba
5252	2406	Miraflores
5253	2406	Nance de Riscó
5254	2406	Valle de Aguas Arriba
5255	2406	Valle de Riscó
5256	2407	Bastimentos
5257	2407	Bocas del Toro
5258	2407	Boca del Drago
5259	2407	Punta Laurel
5260	2407	Tierra Oscura
5261	2407	San Cristóbal
5262	2408	Barriada 4 de Abril
5263	2408	Barranco Adentro
5264	2408	Changuinola
5265	2408	Cochigro
5266	2408	El Empalme
5267	2408	El Silencio
5268	2408	Finca 4
5269	2408	Finca 6
5270	2408	Finca 12
5271	2408	Finca 30
5272	2408	Finca 51
5273	2408	Finca 60
5274	2408	Finca 66
5275	2408	Guabito
5276	2408	La Gloria
5277	2408	La Mesa
5278	2408	Las Delicias
5279	2408	Las Tablas
5280	2409	Bajo Cedro
5281	2409	Chiriquí Grande
5282	2409	Miramar
5283	2409	Punta Peña
5284	2409	Punta Robalo
5285	2409	Rambala
5286	2410	Alanje
5287	2410	Divalá
5288	2410	Canta Gallo
5289	2410	El Tejar
5290	2410	Guarumal
5291	2410	Nuevo México
5292	2410	Querévalo
5293	2410	Palo Grande
5294	2410	Santo Tomás
5295	2411	Baco
5296	2411	Limones
5297	2411	Progreso
5298	2411	Puerto Armuelles
5299	2411	Rodolfo Aguilar Delgado
5300	2411	El Palmar
5301	2411	Manaca
5302	2412	Bágala
5303	2412	Boquerón
5304	2412	Cordillera
5305	2412	Guabal
5306	2412	Guayabal
5307	2412	Paraíso
5308	2412	Pedregal
5309	2412	Tijeras
5310	2413	Alto Boquete
5311	2413	Bajo Boquete
5312	2413	Caldera
5313	2413	Jaramillo
5314	2413	Los Naranjos
5315	2413	Palmira
5316	2414	Aserrío de Gariché
5317	2414	Bugaba
5318	2414	El Bongo
5319	2414	Gómez
5320	2414	La Concepción
5321	2414	La Estrella
5322	2414	San Andrés
5323	2414	Santa Marta
5324	2414	Santa Rosa
5325	2414	Santo Domingo
5326	2414	Sortová
5327	2414	Solano
5328	2414	San Isidro
5329	2415	Bijagual
5330	2415	Cochea
5331	2415	Chiriquí
5332	2415	Guacá
5333	2415	Las Lomas
5334	2415	San Carlos
5335	2415	David
5336	2415	David Este
5337	2415	David Sur
5338	2415	San Pablo Nuevo
5339	2415	San Pablo Viejo
5340	2416	Dolega
5341	2416	Dos Ríos
5342	2416	Los Algarrobos
5343	2416	Los Anastacios
5344	2416	Potrerillos
5345	2416	Potrerillos Abajo
5346	2416	Rovira
5347	2416	Tinajas
5348	2417	Gualaca
5349	2417	Hornito
5350	2417	Los Angeles
5351	2417	Paja de Sombrero
5352	2417	Rincón
5353	2418	El Nancito
5354	2418	El Porvenir
5355	2418	El Puerto
5356	2418	Remedios
5357	2418	Santa Lucía
5358	2419	Breñón
5359	2419	Cañas Gordas
5360	2419	Dominical
5361	2419	Monte Lirio
5362	2419	Plaza de Caisán
5363	2419	Río Sereno
5364	2419	Santa Cruz
5365	2419	Santa Clara
5366	2420	Las Lajas
5367	2420	Lajas Adentro
5368	2420	Juay
5369	2420	San Félix
5370	2421	Boca Chica
5371	2421	Boca del Monte
5372	2421	Horconcitos
5373	2421	San Juan
5374	2421	San Lorenzo
5375	2422	Volcán
5376	2422	Cerro Punta
5377	2422	Cuesta de Piedra
5378	2422	Nueva California
5379	2422	Paso Ancho
5380	2423	Bella Vista
5381	2423	Cerro Viejo
5382	2423	El Cristo
5383	2423	Justo Fidel Palacios
5384	2423	Lajas de Tolé
5385	2423	Potrero de Caña
5386	2423	Quebrada de Piedra
5387	2423	Tolé
5388	2423	Veladero
5389	2424	Aguadulce
5390	2424	Barrios Unidos
5391	2424	El Roble
5392	2424	El Hato de San Juan de Dios
5393	2424	Pocrí
5394	2424	Pueblos Unidos
5395	2424	Virgen del Carmen
5396	2425	Antón
5397	2425	Caballero
5398	2425	Cabuya
5399	2425	El Chirú
5400	2425	El Retiro
5401	2425	El Valle
5402	2425	Juan Díaz
5403	2425	Río Hato
5404	2425	San Juan de Dios
5405	2425	Santa Rita
5406	2426	El Harino
5407	2426	El Potrero
5408	2426	La Pintada
5409	2426	Llano Grande
5410	2426	Piedras Gordas
5411	2426	Llano Norte
5412	2427	Capellanía
5413	2427	El Caño
5414	2427	Guzmán
5415	2427	Las Huacas
5416	2427	Natá
5417	2427	Toza
5418	2427	Villarreal
5419	2428	El Copé
5420	2428	El Picacho
5421	2428	La Pava
5422	2428	Olá
5423	2429	Cañaveral
5424	2429	Coclé
5425	2429	Chiguirí Arriba
5426	2429	El Coco
5427	2429	Pajonal
5428	2429	Penonomé
5429	2429	Río Grande
5430	2429	Río Indio
5431	2429	Toabré
5432	2429	Tulú
5433	2430	Barrio Norte
5434	2430	Barrio Sur
5435	2430	Buena Vista
5436	2430	Cativá
5437	2430	Ciricito
5438	2430	Cristóbal
5439	2430	Cristóbal Este
5440	2430	Escobal
5441	2430	Limón
5442	2430	Nueva Providencia
5443	2430	Puerto Pilón
5444	2430	Sabanitas
5445	2430	Salamanca
5446	2431	Achiote
5447	2431	El Guabo
5448	2431	La Encantada
5449	2431	Nuevo Chagres
5450	2431	Palmas Bellas
5451	2431	Piña
5452	2431	Salud
5453	2432	Coclé del Norte
5454	2432	El Guásimo
5455	2432	Gobea
5456	2432	Miguel de la Borda
5457	2433	Cacique
5458	2433	Garrote
5459	2433	Isla Grande
5460	2433	María Chiquita
5461	2433	Portobelo
5462	2434	Cuango
5463	2434	Nombre de Dios
5464	2434	Palenque
5465	2434	Playa Chiquita
5466	2434	Santa Isabel
5467	2434	Viento Frío
5468	2435	San José del General
5469	2435	San Juan de Turbe
5470	2435	Nueva Esperanza
5471	2436	Camogantí
5472	2436	Chepigana
5473	2436	Garachiné
5474	2436	Jaqué
5475	2436	La Palma
5476	2436	Puerto Piña
5477	2436	Sambú
5478	2436	Setegantí
5479	2436	Taimatí
5480	2436	Tucutí
5481	2437	Boca de Cupe
5482	2437	El Real de Santa María
5483	2437	Metetí
5484	2437	Paya
5485	2437	Pinogana
5486	2437	Púcuro
5487	2437	Yape
5488	2437	Yaviza
5489	2437	Wargandí
5490	2438	Agua Fría
5491	2438	Cucunatí
5492	2438	Río Congo
5493	2438	Río Congo Arriba
5494	2438	Río Iglesias
5495	2438	Santa Fe
5496	2438	Zapallal
5497	2439	Chitré
5498	2439	La Arena
5499	2439	Llano Bonito
5500	2439	San Juan Bautista
5501	2439	Monagrillo
5502	2440	Chepo
5503	2440	Chumical
5504	2440	El Toro
5505	2440	Las Minas
5506	2440	Leones
5507	2440	Quebrada del Rosario
5508	2440	Quebrada El Ciprián
5509	2441	El Capurí
5510	2441	El Calabacito
5511	2441	El Cedro
5512	2441	La Pitaloza
5513	2441	Las Llanas
5514	2441	Los Cerritos
5515	2441	Los Cerros de Paja
5516	2441	Los Pozos
5517	2442	Cerro Largo
5518	2442	El Tijera
5519	2442	Entradero del Castillo
5520	2442	Los Llanos
5521	2442	Menchaca
5522	2442	Peñas Chatas
5523	2442	Ocú
5524	2443	Los Castillos
5525	2443	Llano de la Cruz
5526	2443	París
5527	2443	Parita
5528	2443	Portobelillo
5529	2443	Potuga
5530	2444	El Barrero
5531	2444	El Pedregoso
5532	2444	El Ciruelo
5533	2444	El Pájaro
5534	2444	Las Cabras
5535	2444	Pesé
5536	2444	Rincón Hondo
5537	2444	Sabanagrande
5538	2445	Chupampa
5539	2445	El Rincón
5540	2445	El Limón
5541	2445	Los Canelos
5542	2445	Santa María
5543	2446	El Espinal
5544	2446	El Hato
5545	2446	El Macano
5546	2446	Guararé
5547	2446	Guararé Arriba
5548	2446	La Enea
5549	2446	La Pasera
5550	2446	Las Trancas
5551	2446	Llano Abajo
5552	2446	Perales
5553	2447	Bajo Corral
5554	2447	Bayano
5555	2447	El Carate
5556	2447	El Cocal
5557	2447	El Manantial
5558	2447	El Muñoz
5559	2447	El Sesteadero
5560	2447	La Laja
5561	2447	La Miel
5562	2447	La Tiza
5563	2447	Las Palmitas
5564	2447	Las Tablas Abajo
5565	2447	Nuario
5566	2447	Peña Blanca
5567	2447	Río Hondo
5568	2447	San José
5569	2447	San Miguel
5570	2447	Valle Rico
5571	2447	Vallerriquito
5572	2448	El Ejido
5573	2448	La Colorada
5574	2448	La Espigadilla
5575	2448	La Villa de Los Santos
5576	2448	Las Cruces
5577	2448	Las Guabas
5578	2448	Los Ángeles
5579	2448	Los Olivos
5580	2448	Llano Largo
5581	2448	Santa Ana
5582	2448	Tres Quebradas
5583	2448	Villa Lourdes
5584	2448	Agua Buena
5585	2449	Bahía Honda
5586	2449	Bajos de Güera
5587	2449	Corozal
5588	2449	Chupá
5589	2449	Espino Amarillo
5590	2449	Las Palmas
5591	2449	Llano de Piedras
5592	2449	Macaracas
5593	2449	Mogollón
5594	2450	Los Asientos
5595	2450	Mariabé
5596	2450	Oria Arriba
5597	2450	Pedasí
5598	2450	Purio
5599	2451	El Cañafístulo
5600	2451	Lajamina
5601	2451	Paritilla
5602	2452	Altos de Güera
5603	2452	Cambutal
5604	2452	Cañas
5605	2452	El Bebedero
5606	2452	El Cacao
5607	2452	El Cortezo
5608	2452	Flores
5609	2452	Guánico
5610	2452	Isla de Cañas
5611	2452	La Tronosa
5612	2452	Tonosí
5613	2453	La Ensenada
5614	2453	La Esmeralda
5615	2453	La Guinea
5616	2453	Pedro González
5617	2453	Saboga
5618	2454	Cañita
5619	2454	Chepillo
5620	2454	El Llano
5621	2454	Las Margaritas
5622	2454	Santa Cruz de Chinina
5623	2454	Tortí
5624	2454	Madugandí
5625	2455	Brujas
5626	2455	Chimán
5627	2455	Gonzalo Vásquez
5628	2455	Pásiga
5629	2455	Unión Santeña
5630	2456	24 de Diciembre
5631	2456	Alcalde Díaz
5632	2456	Ancón
5633	2456	Betania
5634	2456	Calidonia
5635	2456	Caimitillo
5636	2456	Chilibre
5637	2456	Curundú
5638	2456	Don Bosco
5639	2456	El Chorrillo
5640	2456	Ernesto Córdoba Campos
5641	2456	Las Cumbres
5642	2456	Las Garzas
5643	2456	Las Mañanitas
5644	2456	Pacora
5645	2456	Parque Lefevre
5646	2456	Pueblo Nuevo
5647	2456	Río Abajo
5648	2456	San Felipe
5649	2456	San Francisco
5650	2456	San Martín
5651	2456	Tocumen
5652	2457	Amelia Denis de Icaza
5653	2457	Arnulfo Arias
5654	2457	Belisario Frías
5655	2457	Belisario Porras
5656	2457	José Domingo Espinar
5657	2457	Mateo Iturralde
5658	2457	Omar Torrijos
5659	2457	Rufina Alfaro
5660	2457	Victoriano Lorenzo
5661	2458	Otoque Occidente
5662	2458	Otoque Oriente
5663	2458	Taboga
5664	2459	Arraiján
5665	2459	Burunga
5666	2459	Cerro Silvestre
5667	2459	Juan Demóstenes Arosemena
5668	2459	Nuevo Emperador
5669	2459	Veracruz
5670	2459	Vista Alegre
5671	2460	Caimito
5672	2460	Campana
5673	2460	Capira
5674	2460	Cermeño
5675	2460	Cirí de Los Sotos
5676	2460	Cirí Grande
5677	2460	La Trinidad
5678	2460	Las Ollas Arriba
5679	2460	Lídice
5680	2460	Villa Carmen
5681	2460	Villa Rosario
5682	2461	Bejuco
5683	2461	Buenos Aires
5684	2461	Chame
5685	2461	Chicá
5686	2461	El Líbano
5687	2461	Nueva Gorgona
5688	2461	Punta Chame
5689	2461	Sajalices
5690	2461	Sorá
5691	2462	Amador
5692	2462	Arosemena
5693	2462	Barrio Balboa
5694	2462	Barrio Colón
5695	2462	El Arado
5696	2462	Feuillet
5697	2462	Guadalupe
5698	2462	Herrera
5699	2462	Hurtado
5700	2462	Iturralde
5701	2462	La Represa
5702	2462	Los Díaz
5703	2462	Mendoza
5704	2462	Obaldía
5705	2462	Playa Leona
5706	2462	Puerto Caimito
5707	2463	El Espino
5708	2463	El Higo
5709	2463	Guayabito
5710	2463	La Ermita
5711	2463	La Laguna
5712	2463	Las Uvas
5713	2463	Los Llanitos
5714	2464	Atalaya
5715	2464	El Barrito
5716	2464	La Carrillo
5717	2464	La Montañuela
5718	2464	San Antonio
5719	2465	Barnizal
5720	2465	Calobre
5721	2465	Chitra
5722	2465	El Cocla
5723	2465	La Raya de Calobre
5724	2465	La Tetilla
5725	2465	La Yeguada
5726	2465	Las Guías
5727	2465	Monjarás
5728	2466	Cañazas
5729	2466	Cerro de Plata
5730	2466	El Aromillo
5731	2466	El Picador
5732	2466	Los Valles
5733	2466	San Marcelo
5734	2467	Bisvalles
5735	2467	Boró
5736	2467	Los Milagros
5737	2467	San Bartolo
5738	2468	Cerro de Casa
5739	2468	El María
5740	2468	El Prado
5741	2468	Lolá
5742	2468	Manuel E. Amador Terrero
5743	2468	Pixvae
5744	2468	Puerto Vidal
5745	2468	San Martín de Porres
5746	2468	Viguí
5747	2468	Zapotillo
5748	2469	Arenas
5749	2469	Mariato
5750	2469	Quebro
5751	2469	Tebario
5752	2470	Cébaco
5753	2470	Costa Hermosa
5754	2470	Gobernadora
5755	2470	La Garceana
5756	2470	Montijo
5757	2470	Pilón
5758	2470	Unión del Norte
5759	2471	Catorce de Noviembre
5760	2471	Río de Jesús
5761	2471	Utira
5762	2472	Corral Falso
5763	2472	Los Hatillos
5764	2472	Remance
5765	2472	Calovébora
5766	2472	El Alto
5767	2472	El Cuay
5768	2472	El Pantano
5769	2472	Gatuncito
5770	2472	Río Luis
5771	2472	Rubén Cantú
5772	2473	Canto del Llano
5773	2473	Carlos Santana Ávila
5774	2473	Edwin Fábrega
5775	2473	La Peña
5776	2473	La Raya de Santa María
5777	2473	Nuevo Santiago
5778	2473	Ponuga
5779	2473	San Pedro del Espino
5780	2473	Santiago
5781	2473	Santiago Este
5782	2473	Santiago Sur
5783	2473	Rodrigo Luque
5784	2473	Urracá
5785	2474	Cativé
5786	2474	El Marañón
5787	2474	Hicaco
5788	2474	La Soledad
5789	2474	La Trinchera
5790	2474	Quebrada de Oro
5791	2474	Rodeo Viejo
5792	2474	Soná
5793	2475	Cirilo Guaynora
5794	2475	Lajas Blancas
5795	2475	Manuel Ortega
5796	2476	Jingurudó
5797	2476	Río Sabalo
5798	2477	Ailigandí
5799	2477	Narganá
5800	2477	Puerto Obaldía
5801	2477	Tubualá
5802	2478	Bonyik
5803	2478	San San Drui
5804	2478	El Teribe
5805	2479	Boca de Balsa
5806	2479	Cerro Banco
5807	2479	Cerro Patena
5808	2479	Camarón Arriba
5809	2479	Emplanada de Chorcha
5810	2479	Nämnoní
5811	2479	Niba
5812	2479	Soloy
5813	2480	Bisira
5814	2480	Calante
5815	2480	Kankintú
5816	2480	Guoroní
5817	2480	Mününí
5818	2480	Piedra Roja
5819	2480	Tolote
5820	2481	Bahía Azul
5821	2481	Kusapín
5822	2481	Río Chiriquí
5823	2481	Tobobé
5824	2482	Cascabel
5825	2482	Hato Corotú
5826	2482	Hato Culantro
5827	2482	Hato Pilón
5828	2482	Hato Jobo
5829	2482	Hato Julí
5830	2482	Quebrada de Loro
5831	2482	Salto Dupí
5832	2483	Alto Caballero
5833	2483	Bakama
5834	2483	Cerro Caña
5835	2483	Cerro Puerco
5836	2483	Chichica
5837	2483	Krüa
5838	2483	Maraca
5839	2483	Nibra
5840	2483	Roka
5841	2483	Sitio Prado
5842	2483	Umaní
5843	2483	Diko
5844	2483	Kikari
5845	2483	Dikeri
5846	2483	Mreeni
5847	2484	Cerro Iglesias
5848	2484	Hato Chamí
5849	2484	Jädeberi
5850	2484	Lajero
5851	2484	Susama
5852	2485	Agua de Salud
5853	2485	Alto de Jesús
5854	2485	Cerro Pelado
5855	2485	El Bale
5856	2485	El Paredón
5857	2485	El Piro
5858	2485	Güibale
5859	2485	El Peñón
5860	2485	El Piro N°2
5861	2486	Burí
5862	2486	Guariviara
5863	2486	Man Creek
5864	2486	Samboa
5865	2486	Tuwai
5866	2487	Alto Bilingüe
5867	2487	Loma Yuca
5868	2487	San Pedrito
5869	2487	Valle Bonito
5870	5559	Carhué
5871	5559	Colonia San Miguel Arcángel
5872	5559	Delfín Huergo
5873	5559	Espartillar
5874	5559	Esteban Agustín Gascón
5875	5559	La Pala
5876	5559	Maza
5877	5559	Rivera
5878	5559	Yutuyaco
5879	5560	Adolfo Gonzales Chaves (Est. Chaves)
5880	5560	De la Garma
5881	5560	Juan E. Barra
5882	5560	Vásquez
5883	5561	Alberti (Est. Andrés Vaccarezza)
5884	5561	Coronel Seguí
5885	5561	Mechita
5886	5561	Pla
5887	5561	Villa Grisolía (Est. Achupallas)
5888	5561	Villa María
5889	5561	Villa Ortiz (Est. Coronel Mom)
5890	5562	Almirante Brown (Adrogué)
5891	5563	Arrecifes
5892	5563	Todd
5893	5563	Viña
5894	5564	Avellaneda
5895	5565	Ayacucho
5896	5565	La Constancia
5897	5565	Solanet
5898	5565	Udaquiola
5899	5566	16 de Julio
5900	5566	Ariel
5901	5566	Azul
5902	5566	Cacharí
5903	5566	Chillar
5904	5567	Bahía Blanca
5905	5567	Cabildo
5906	5567	General Daniel Cerri (Est. General Cerri)
5907	5568	Balcarce
5908	5568	Los Pinos
5909	5568	Napaleofú
5910	5568	Ramos Otero
5911	5568	San Agustín
5912	5568	Villa Laguna La Brava
5913	5569	Baradero
5914	5569	Irineo Portela
5915	5569	Santa Coloma
5916	5569	Villa Alsina (Est. Alsina)
5917	5570	Barker
5918	5570	Benito Juárez (Est. Juárez)
5919	5570	López
5920	5570	Tedín Uriburu
5921	5570	Villa Cacique (Est. Alfredo Fortabat)
5922	5571	Berazategui
5923	5572	Berisso
5924	5573	Hale
5925	5573	Juan F. Ibarra
5926	5573	Paula
5927	5573	Pirovano
5928	5573	San Carlos de Bolívar (Est. Bolívar)
5929	5573	Urdampilleta
5930	5573	Villa Lynch Pueyrredón
5931	5574	Asamblea
5932	5574	Bragado
5933	5574	Comodoro Py
5934	5574	General O'Brien
5935	5574	Irala
5936	5574	La Limpia
5937	5574	Máximo Fernández (Est. Juan F. Salaberry)
5938	5574	Mechita (Est. Mecha)
5939	5574	Olascoaga
5940	5574	Warnes
5941	5575	Altamirano
5942	5575	Barrio El Mirador
5943	5575	Barrio Las Golondrinas
5944	5575	Barrio Los Bosquecitos
5945	5575	Barrio Parque Las Acacias
5946	5575	Campos de Roca
5947	5575	Club de Campo las Malvinas
5948	5575	Coronel Brandsen
5949	5575	Gómez
5950	5575	Jeppener
5951	5575	Oliden
5952	5575	Posada de Los Lagos
5953	5575	Samborombón
5954	5576	Comuna 1
5955	5576	Comuna 10
5956	5576	Comuna 11
5957	5576	Comuna 12
5958	5576	Comuna 13
5959	5576	Comuna 14
5960	5576	Comuna 15
5961	5576	Comuna 2
5962	5576	Comuna 3
5963	5576	Comuna 4
5964	5576	Comuna 5
5965	5576	Comuna 6
5966	5576	Comuna 7
5967	5576	Comuna 8
5968	5576	Comuna 9
5969	5577	Barrio Los Pioneros (Barrio Tavella)
5970	5577	Campana
5971	5577	Chacras del Río Luján
5972	5577	Lomas del Río Luján (Est. Río Luján)
5973	5577	Los Cardales
5974	5578	Alejandro Petión
5975	5578	Barrio El Taladro
5976	5578	Cañuelas
5977	5578	Gobernador Udaondo
5978	5578	Máximo Paz (- Barrio Belgrano)
5979	5578	Santa Rosa
5980	5578	Uribelarrea
5981	5578	Vicente Casares
5982	5579	Capitán Sarmiento
5983	5579	La Luisa
5984	5580	Bellocq
5985	5580	Cadret
5986	5580	Carlos Casares
5987	5580	Colonia Mauricio
5988	5580	Hortensia
5989	5580	La Sofía
5990	5580	Mauricio Hirsch
5991	5580	Moctezuma
5992	5580	Ordoqui
5993	5580	Santo Tomas
5994	5580	Smith
5995	5581	Carlos Tejedor
5996	5581	Colonia Seré
5997	5581	Curarú
5998	5581	Timote
5999	5581	Tres Algarrobos (Est. Cuenca)
6000	5582	Carmen de Areco
6001	5582	Pueblo Gouin
6002	5582	Tres Sargentos
6003	5583	Castelli
6004	5583	Centro Guerrero
6005	5583	Cerro de la Gloria
6006	5584	Castilla
6007	5584	Chacabuco
6008	5584	Los Ángeles
6009	5584	O'Higgins
6010	5584	Rawson
6011	5585	Barrio Lomas Altas
6012	5585	Chascomús
6013	5585	Laguna Vitel
6014	5585	Manuel J. Cobo (Est. Lezama)
6015	5585	Villa Parque Girado
6016	5586	Benitez
6017	5586	Chivilcoy
6018	5586	Emilio Ayarza
6019	5586	Gorostiaga
6020	5586	La Rica
6021	5586	Moquehuá
6022	5586	Ramón Biaus
6023	5586	San Sebastián
6024	5587	Colón
6025	5587	Pearson
6026	5587	Sarasa
6027	5587	Villa Manuel Pomar (El Arbolito)
6028	5588	Bajo Hondo
6029	5588	Balneario Pehuen-Có
6030	5588	Pago Chico (Villa del Mar)
6031	5588	Punta Alta (Est. Almirante Solier)
6032	5588	Villa General Arias (Est. Kilómetro 638)
6033	5589	Aparicio
6034	5589	Coronel Dorrego
6035	5589	El Perdido (Est. José A. Guisasola)
6036	5589	Faro
6037	5589	Irene
6038	5589	Marisol
6039	5589	Oriente
6040	5589	Paraje la Ruta
6041	5589	San Román
6042	5590	Coronel Pringles (Est. Pringles)
6043	5590	El Divisorio
6044	5590	El Pensamiento
6045	5590	Indio Rico
6046	5590	Lartigau
6047	5591	Cascadas
6048	5591	Coronel Suárez
6049	5591	Cura Malal
6050	5591	D'Orbigny
6051	5591	Huanguelén
6052	5591	Pasman
6053	5591	San José
6054	5591	Santa María
6055	5591	Santa Trinidad
6056	5591	Villa La Arcadia
6057	5592	Andant
6058	5592	Arboledas
6059	5592	Daireaux
6060	5592	La Larga
6061	5592	Salazar
6062	5593	Dolores
6063	5593	Sevigne
6064	5594	Ensenada
6065	5595	Escobar (Belén de Escobar)
6066	5596	Esteban Echeverría (Monte Grande)
6067	5597	Arroyo de la Cruz
6068	5597	Capilla del Señor (Est. Capilla)
6069	5597	Diego Gaynor
6070	5597	Parada Orlando
6071	5597	Parada Robles (- Pavón)
6072	5598	Ezeiza
6073	5599	Florencio Varela
6074	5600	Blaquier
6075	5600	Florentino Ameghino
6076	5600	Porvenir
6077	5601	Centinela del Mar
6078	5601	Comandante Nicanor Otamendi
6079	5601	Mar del Sur
6080	5601	Mechongué
6081	5601	Miramar
6082	5602	General Alvear
6083	5603	Arribeños
6084	5603	Ascensión
6085	5603	Estación Arenales
6086	5603	Ferré
6087	5603	General Arenales
6088	5603	La Angelita
6089	5603	La Trinidad
6090	5604	General Belgrano
6091	5604	Gorchs
6092	5605	General Guido
6093	5605	Labardén
6094	5606	General Juan Madariaga
6095	5607	General La Madrid
6096	5607	La Colina
6097	5607	Las Martinetas
6098	5607	Líbano
6099	5607	Pontaut
6100	5608	General Hornos
6101	5608	General Las Heras (Est. Las Heras)
6102	5608	La Choza
6103	5608	Plomer
6104	5608	Villars
6105	5609	General Lavalle
6106	5609	Pavón
6107	5610	Barrio Río Salado
6108	5610	Loma Verde
6109	5610	Ranchos
6110	5610	Villanueva (Ap. Río Salado)
6111	5611	Colonia San Ricardo (Est. Iriarte)
6112	5611	General Pinto
6113	5611	Germania (Est. Mayor José Orellano)
6114	5611	Gunther
6115	5611	Villa Francia (Est. Coronel Granada)
6116	5611	Villa Roth (Est. Ingeniero Balbín)
6117	5612	Barrio El Boquerón
6118	5612	Barrio La Gloria
6119	5612	Barrio Santa Paula
6120	5612	Batán
6121	5612	Chapadmalal
6122	5612	El Marquesado
6123	5612	Estación Chapadmalal
6124	5612	Mar del Plata
6125	5612	Sierra de los Padres
6126	5613	General Rodríguez
6127	5614	General San Martín
6128	5615	Baigorrita
6129	5615	La Delfina
6130	5615	Los Toldos
6131	5615	San Emilio
6132	5615	Zavalía
6133	5616	Banderaló
6134	5616	Cañada Seca
6135	5616	Coronel Charlone
6136	5616	Emilio V. Bunge
6137	5616	General Villegas (Est. Villegas)
6138	5616	Massey (Est. Elordi)
6139	5616	Pichincha
6140	5616	Piedritas
6141	5616	Santa Eleodora
6142	5616	Santa Regina
6143	5616	Villa Saboya
6144	5616	Villa Sauze
6145	5617	Arroyo Venado
6146	5617	Casbas
6147	5617	Garré
6148	5617	Guaminí
6149	5617	Laguna Alsina (Est. Bonifacio)
6150	5618	Henderson
6151	5618	Herrera Vegas
6152	5619	Hurlingham
6153	5620	Ituzaingó
6154	5621	José C. Paz
6155	5622	Agustín Roca
6156	5622	Agustina
6157	5622	Balneario Laguna de Gómez
6158	5622	Fortín Tiburcio
6159	5622	Junín
6160	5622	Laplacette
6161	5622	Morse
6162	5622	Paraje La Agraria
6163	5622	Saforcada
6164	5623	Las Toninas
6165	5623	Mar de Ajó (- San Bernardo)
6166	5623	San Clemente del Tuyú
6167	5623	Santa Teresita (- Mar del Tuyú)
6168	5624	La Matanza (San Justo)
6169	5625	Country Club El Rodeo
6170	5625	Ignacio Correas
6171	5625	La Plata
6172	5625	Lomas de Copello
6173	5625	Ruta Sol (incl. Barrio El Peligro)
6174	5626	Lanús
6175	5627	Laprida
6176	5627	Pueblo Nuevo
6177	5627	Pueblo San Jorge
6178	5628	Coronel Boerr
6179	5628	El Trigo
6180	5628	Las Flores
6181	5628	Pardo
6182	5629	Alberdi Viejo
6183	5629	El Dorado
6184	5629	Fortín Acha
6185	5629	Juan Bautista Alberdi (Est. Alberdi)
6186	5629	Leandro N. Alem
6187	5629	Vedia
6188	5630	Arenaza
6189	5630	Bayauca
6190	5630	Bermúdez
6191	5630	Carlos Salas
6192	5630	Coronel Martínez de Hoz (Ap. Kilómetro 322)
6193	5630	El Triunfo
6194	5630	Las Toscas
6195	5630	Lincoln
6196	5630	Pasteur
6197	5630	Roberts
6198	5630	Triunvirato
6199	5631	Arenas Verdes
6200	5631	Licenciado Matienzo
6201	5631	Lobería
6202	5631	Pieres
6203	5631	San Manuel
6204	5631	Tamangueyú
6205	5632	Antonio Carboni
6206	5632	Elvira
6207	5632	Laguna de Lobos
6208	5632	Lobos
6209	5632	Salvador María
6210	5633	Lomas de Zamora
6211	5634	Carlos Keen
6212	5634	Club de Campo Los Puentes
6213	5634	Luján
6214	5634	Olivera
6215	5634	Torres
6216	5635	Atalaya
6217	5635	General Mansilla (Est. Bartolomé Bavio)
6218	5635	Los Naranjos
6219	5635	Magdalena
6220	5635	Roberto J. Payró
6221	5635	Vieytes
6222	5636	Las Armas
6223	5636	Maipú
6224	5636	Santo Domingo
6225	5637	Malvinas Argentinas (Los Polvorines)
6226	5638	Coronel Vidal
6227	5638	General Pirán
6228	5638	La Armonía
6229	5638	Mar Chiquita
6230	5638	Mar de Cobo
6231	5638	Santa Clara del Mar
6232	5638	Vivoratá
6233	5639	Barrio Santa Rosa
6234	5639	Marcos Paz
6235	5640	Goldney
6236	5640	Gowland
6237	5640	Jorge Born (Tomás Jofré)
6238	5640	Mercedes
6239	5641	Merlo
6240	5642	Abbott
6241	5642	San Miguel del Monte (Est. Monte)
6242	5642	Zenón Videla Dorna
6243	5643	Balneario Sauce Grande
6244	5643	Monte Hermoso
6245	5644	Moreno
6246	5645	Morón
6247	5646	José Juan Almeyra
6248	5646	Las Marianas
6249	5646	Navarro
6250	5646	Villa Moll (Est. Moll)
6251	5647	Claraz
6252	5647	Energia
6253	5647	Juan Nepomuceno Fernández
6254	5647	Necochea (- Quequén)
6255	5647	Nicanor Olivera (Est. La Dulce)
6256	5647	Ramón Santamarina
6257	5648	12 de Octubre
6258	5648	9 de Julio (Nueve de Julio)
6259	5648	Alfredo Demarchi (Est. Facundo Quiroga)
6260	5648	Carlos María Naón
6261	5648	Dudignac
6262	5648	La Aurora (Est. La Niña)
6263	5648	Manuel B. Gonnet (Est. French)
6264	5648	Marcelino Ugarte (Est. Dennehy)
6265	5648	Morea
6266	5648	Norumbega
6267	5648	Patricios
6268	5648	Villa Fournier (Est. 9 de Julio Sud)
6269	5649	Blancagrande
6270	5649	Colonia Nievas
6271	5649	Colonia San Miguel
6272	5649	Espigas
6273	5649	Hinojo
6274	5649	Olavarría
6275	5649	Recalde
6276	5649	Santa Luisa
6277	5649	Sierra Chica
6278	5649	Sierras Bayas
6279	5649	Villa Alfredo Fortabat (Loma Negra)
6280	5649	Villa La Serranía
6281	5650	Bahía San Blas
6282	5650	Cardenal Cagliero
6283	5650	Carmen de Patagones
6284	5650	José B. Casas
6285	5650	Juan A. Pradere
6286	5650	Stroeder
6287	5650	Villalonga
6288	5651	Capitán Castro
6289	5651	Francisco Madero
6290	5651	Inocencio Sosa
6291	5651	Juan José Paso
6292	5651	Magdala
6293	5651	Mones Cazón
6294	5651	Nueva Plata
6295	5651	Pehuajó
6296	5651	San Bernardo (Est. Guanaco)
6297	5651	San Esteban (Chiclana)
6298	5652	Bocayuva
6299	5652	De Bary
6300	5652	Pellegrini
6301	5653	Acevedo
6302	5653	Fontezuela
6303	5653	Guerrico
6304	5653	Juan A. de la Peña
6305	5653	Juan Anchorena (Est. Urquiza)
6306	5653	La Violeta
6307	5653	Manuel Ocampo
6308	5653	Mariano Benítez
6309	5653	Mariano H. Alfonzo (Est. San Patricio)
6310	5653	Pergamino
6311	5653	Pinzón
6312	5653	Rancagua
6313	5653	Villa Angélica (Est. El Socorro)
6314	5653	Villa San José
6315	5654	Casalins
6316	5654	Pila
6317	5655	Pilar
6318	5656	Pinamar
6319	5657	Presidente Perón (Guernica)
6320	5658	17 de Agosto
6321	5658	Azopardo
6322	5658	Bordenave
6323	5658	Darregueira
6324	5658	Estela
6325	5658	Felipe Solá
6326	5658	López Lecube
6327	5658	Puan
6328	5658	San Germán
6329	5658	Villa Castelar (Est. Erize)
6330	5658	Villa Iris
6331	5659	Alvarez Jonte
6332	5659	Pipinas
6333	5659	Punta Indio
6334	5659	Verónica
6335	5660	Quilmes
6336	5661	El Paraíso
6337	5661	Las Bahamas
6338	5661	Pérez Millán
6339	5661	Ramallo
6340	5661	Villa General Savio (Est. Sánchez)
6341	5661	Villa Ramallo
6342	5662	Rauch
6343	5663	América
6344	5663	Fortín Olavarría
6345	5663	González Moreno
6346	5663	Mira Pampa
6347	5663	Roosevelt
6348	5663	San Mauricio
6349	5663	Sansinena
6350	5663	Sundblad
6351	5664	La Beba
6352	5664	Las Carabelas
6353	5664	Los Indios
6354	5664	Rafael Obligado
6355	5664	Roberto Cano
6356	5664	Rojas
6357	5664	Sol de Mayo
6358	5664	Villa Manuel Pomar
6359	5665	Carlos Beguerie
6360	5665	Roque Pérez
6361	5666	Arroyo Corto
6362	5666	Colonia San Martín
6363	5666	Dufaur
6364	5666	Goyena
6365	5666	Las Encadenadas
6366	5666	Pigüé
6367	5666	Saavedra
6368	5667	Álvarez de Toledo
6369	5667	Cazón
6370	5667	Del Carril
6371	5667	Polvaredas
6372	5667	Saladillo
6373	5668	Quenumá
6374	5668	Salliqueló
6375	5669	Arroyo Dulce
6376	5669	Berdier
6377	5669	Gahan
6378	5669	Inés Indart
6379	5669	La Invencible
6380	5669	Salto
6381	5670	Azcuénaga
6382	5670	Culullú
6383	5670	Franklin
6384	5670	San Andrés de Giles
6385	5670	Solís
6386	5670	Villa Espil
6387	5670	Villa Ruiz
6388	5671	Duggan
6389	5671	San Antonio de Areco
6390	5671	Villa Lía
6391	5672	Balneario San Cayetano
6392	5672	Ochandío
6393	5672	San Cayetano
6394	5673	San Fernando
6395	5674	San Isidro
6396	5675	San Miguel
6397	5676	Conesa
6398	5676	Erézcano
6399	5676	General Rojo
6400	5676	La Emilia
6401	5676	San Nicolás de los Arroyos
6402	5676	Villa Esperanza
6403	5677	Gobernador Castro
6404	5677	Ingeniero Moneta
6405	5677	Obligado
6406	5677	Pueblo Doyle
6407	5677	Río Tala
6408	5677	San Pedro
6409	5677	Santa Lucía
6410	5678	San Vicente
6411	5679	General Rivas
6412	5679	Suipacha
6413	5680	De la Canal
6414	5680	Gardey
6415	5680	María Ignacia (Est. Vela)
6416	5680	Tandil
6417	5681	Crotto
6418	5681	Tapalqué
6419	5681	Velloso
6420	5682	Tigre
6421	5683	General Conesa
6422	5684	Chasicó
6423	5684	La Gruta (Villa Serrana)
6424	5684	Saldungaray
6425	5684	Sierra de la Ventana
6426	5684	Tornquist
6427	5684	Tres Picos
6428	5684	Villa Ventana
6429	5685	30 de Agosto (Treinta de Agosto)
6430	5685	Berutti
6431	5685	Girodias
6432	5685	La Carreta
6433	5685	Trenque Lauquen
6434	5685	Trongé
6435	5686	Balneario Orense
6436	5686	Claromecó
6437	5686	Copetonas
6438	5686	Micaela Cascallares (Est. Cascallares)
6439	5686	Orense
6440	5686	Reta
6441	5686	San Francisco de Bellocq
6442	5686	San Mayol
6443	5686	Tres Arroyos
6444	5686	Villa Rodríguez (Est. Barrow)
6445	5687	Tres de Febrero (Caseros)
6446	5688	Ingeniero Thompson
6447	5688	Tres Lomas
6448	5689	25 de Mayo (Villa Veinticinco de Mayo)
6449	5689	Agustín Mosconi
6450	5689	Del Valle
6451	5689	Ernestina
6452	5689	Gobernador Ugarte
6453	5689	Lucas Monteverde
6454	5689	Norberto de la Riestra
6455	5689	Pedernales
6456	5689	San Enrique
6457	5689	Valdés
6458	5690	Vicente López (Olivos)
6459	5691	Mar Azul
6460	5691	Villa Gesell
6461	5692	Argerich
6462	5692	Colonia San Adolfo
6463	5692	Country Los Medanos
6464	5692	Hilario Ascasubi
6465	5692	Juan Cousté (Est. Algarrobo)
6466	5692	Mayor Buratovich
6467	5692	Médanos
6468	5692	Pedro Luro
6469	5692	Teniente Origone
6470	5693	Country Club El Casco
6471	5693	Escalada
6472	5693	Lima
6473	5693	Zárate
6474	5694	Chuchucaruana
6475	5694	Colpes
6476	5694	El Bolsón
6477	5694	El Rodeo
6478	5694	Huaycama
6479	5694	La Puerta
6480	5694	Las Chacritas
6481	5694	Las Juntas
6482	5694	Los Castillos
6483	5694	Los Talas
6484	5694	Los Varela
6485	5694	Singuil
6486	5695	Ancasti
6487	5695	Anquincila
6488	5695	La Candelaria
6489	5695	La Majada
6490	5696	Amanao
6491	5696	Andalgalá
6492	5696	Chaquiago
6493	5696	Choya
6494	5696	El Alamito
6495	5696	El Lindero
6496	5696	El Potrero
6497	5696	La Aguada
6498	5697	Antofagasta de la Sierra
6499	5697	Antofalla
6500	5697	El Peñón
6501	5697	Los Nacimientos
6502	5698	Barranca Larga
6503	5698	Belén
6504	5698	Cóndor Huasi
6505	5698	Corral Quemado
6506	5698	El Durazno
6507	5698	Farallón Negro
6508	5698	Hualfín
6509	5698	Jacipunco
6510	5698	La Puntilla
6511	5698	Londres
6512	5698	Puerta de Corral Quemado
6513	5698	Puerta de San José
6514	5698	Villa Vil
6515	5699	Adolfo E. Carranza
6516	5699	Balde de la Punta
6517	5699	Capayán
6518	5699	Chumbicha
6519	5699	Colonia del Valle
6520	5699	Colonia Nueva Coneta
6521	5699	Concepción
6522	5699	Coneta
6523	5699	El Bañado
6524	5699	Huillapima
6525	5699	Miraflores
6526	5699	San Martín
6527	5699	San Pablo
6528	5700	Catamarca (San Fernando del Valle de Catamarca)
6529	5700	El Pantanillo
6530	5701	El Alto
6531	5701	Guayamba
6532	5701	Infanzón
6533	5701	Los Corrales
6534	5701	Tapso
6535	5701	Vilismán
6536	5702	Collagasta
6537	5702	Pomancillo Este
6538	5702	Pomancillo Oeste
6539	5702	Villa Las Pirquitas
6540	5703	Casa de Piedra
6541	5703	El Aybal
6542	5703	El Divisadero
6543	5703	El Quimilo
6544	5703	Esquiú
6545	5703	Icaño
6546	5703	La Dorada
6547	5703	La Guardia
6548	5703	Las Esquinas
6549	5703	Las Palmitas
6550	5703	Quirós
6551	5703	Ramblones
6552	5703	Recreo
6553	5703	San Antonio
6554	5704	Amadores
6555	5704	El Rosario
6556	5704	La Bajada
6557	5704	La Higuera
6558	5704	La Merced
6559	5704	La Viña
6560	5704	Las Lajas
6561	5704	Monte Potrero
6562	5704	Palo Labrado
6563	5704	Villa de Balcozna
6564	5705	Apoyaco
6565	5705	Colana
6566	5705	El Pajonal (Est. Pomán)
6567	5705	Joyango
6568	5705	Mutquín
6569	5705	Pomán
6570	5705	Rincón
6571	5705	Saujil
6572	5705	Siján
6573	5706	Andalhualá
6574	5706	Caspichango
6575	5706	Chañar Punco
6576	5706	El Cajón
6577	5706	El Desmonte
6578	5706	El Puesto
6579	5706	Famatanca
6580	5706	Fuerte Quemado
6581	5706	La Hoyada
6582	5706	La Loma
6583	5706	Las Mojarras
6584	5706	Loro Huasi
6585	5706	Punta de Balasto
6586	5706	Yapes
6587	5707	Alijilán
6588	5707	Bañado de Ovanta
6589	5707	Las Cañas
6590	5707	Lavalle
6591	5707	Los Altos
6592	5707	Manantiales
6593	5707	San Pedro (San Pedro de Guasayán)
6594	5708	Anillaco
6595	5708	Antinaco
6596	5708	Banda de Lucero
6597	5708	Cerro Negro
6598	5708	Copacabana
6599	5708	Cordobita
6600	5708	Costa de Reyes
6601	5708	El Pueblito
6602	5708	El Salado
6603	5708	Fiambalá
6604	5708	Los Balverdis
6605	5708	Medanitos
6606	5708	Palo Blanco
6607	5708	Punta del Agua
6608	5708	Tatón
6609	5708	Tinogasta
6610	5709	El Portezuelo
6611	5709	Las Tejas
6612	5709	Santa Cruz
6613	5709	Concepción del Bermejo
6614	5709	Los Frentones
6615	5709	Pampa del Infierno
6616	5709	Río Muerto
6617	5709	Taco Pozo
6618	5710	General Vedia
6619	5710	Isla del Cerrito
6620	5710	La Leonesa
6621	5710	Las Palmas
6622	5710	Puerto Bermejo Nuevo
6623	5710	Puerto Bermejo Viejo
6624	5710	Puerto Eva Perón
6625	5710	Charata
6626	5711	Presidencia Roque Sáenz Peña
6627	5712	Gancedo
6628	5712	General Capdevila
6629	5712	General Pinedo
6630	5712	Mesón de Fierro
6631	5712	Pampa Landriel
6632	5713	Hermoso Campo
6633	5713	Itín
6634	5714	Chorotis
6635	5714	Santa Sylvina
6636	5714	Venados Grandes
6637	5714	Corzuela
6638	5715	La Escondida
6639	5715	La Verde
6640	5715	Lapachito
6641	5715	Makallé
6642	5716	El Espinillo
6643	5716	El Sauzal
6644	5716	El Sauzalito
6645	5716	Fortín Lavalle
6646	5716	Fuerte Esperanza
6647	5716	Juan José Castelli
6648	5716	Nueva Pompeya
6649	5716	Villa Río Bermejito
6650	5716	Wichí
6651	5716	Zaparinqui
6652	5717	Avia Terai
6653	5717	Campo Largo
6654	5717	Fortín Las Chuñas
6655	5717	Napenay
6656	5718	Colonia Popular
6657	5718	Estación General Obligado
6658	5718	Laguna Blanca
6659	5718	Puerto Tirol
6660	5719	Ciervo Petiso
6661	5719	General José de San Martín
6662	5719	La Eduvigis
6663	5719	Laguna Limpia
6664	5719	Pampa Almirón
6665	5719	Pampa del Indio
6666	5719	Presidencia Roca
6667	5719	Selvas del Río de Oro
6668	5719	Tres Isletas
6669	5720	Coronel Du Graty
6670	5720	Enrique Urién
6671	5720	Villa Ángela
6672	5720	Las Breñas
6673	5721	La Clotilde
6674	5721	La Tigra
6675	5721	San Bernardo
6676	5722	Presidencia de la Plaza
6677	5723	Barrio de los Pescadores
6678	5723	Colonia Benítez
6679	5723	Margarita Belén
6680	5724	Quitilipi
6681	5724	Villa El Palmar
6682	5724	Barranqueras
6683	5724	Basail
6684	5724	Colonia Baranda
6685	5724	Fontana
6686	5724	Puerto Vilelas
6687	5724	Resistencia
6688	5725	Samuhú
6689	5725	Villa Berthet
6690	5726	Capitán Solari
6691	5726	Colonia Elisa
6692	5726	Colonias Unidas
6693	5726	Ingeniero Barbet
6694	5726	Las Garcitas
6695	5727	Charadai
6696	5727	Cote Lai
6697	5727	Haumonía
6698	5727	Horquilla
6699	5727	La Sabana
6700	5727	Colonia Aborigen
6701	5727	Machagai
6702	5727	Napalpí
6703	5728	Arroyo Verde
6704	5728	Puerto Madryn
6705	5728	Puerto Pirámides
6706	5728	Quinta El Mirador
6707	5728	Reserva Area Protegida El Doradillo
6708	5729	Buenos Aires Chico
6709	5729	Cholila
6710	5729	Costa del Chubut
6711	5729	Cushamen Centro
6712	5729	El Hoyo
6713	5729	El Maitén
6714	5729	Epuyén
6715	5729	Fofo Cahuel
6716	5729	Gualjaina
6717	5729	Lago Epuyén
6718	5729	Lago Puelo
6719	5729	Leleque
6720	5730	Astra
6721	5730	Bahía Bustamante
6722	5730	Comodoro Rivadavia
6723	5730	Diadema Argentina
6724	5730	Rada Tilly
6725	5730	Camarones
6726	5730	Garayalde
6727	5731	Aldea Escolar (Losrápidos)
6728	5731	Corcovado
6729	5731	Esquel
6730	5731	Lago Rosario
6731	5731	Los Cipreses
6732	5731	Trevelin
6733	5731	Villa Futalaufquen
6734	5732	28 de Julio
6735	5732	Dique Florentino Ameghino
6736	5732	Dolavon
6737	5732	Gaiman
6738	5733	Blancuntre
6739	5733	El Escorial
6740	5733	Gastre
6741	5733	Lagunita Salada
6742	5733	Yala Laubat
6743	5734	Aldea Epulef
6744	5734	Carrenleufú
6745	5734	Colan Conhué
6746	5734	Paso del Sapo
6747	5734	Tecka
6748	5735	El Mirasol
6749	5735	Las Plumas
6750	5736	Cerro Cóndor
6751	5736	Los Altares
6752	5736	Paso de Indios
6753	5737	Playa Magagna
6754	5737	Playa Unión
6755	5737	Trelew
6756	5738	Aldea Apeleg
6757	5738	Aldea Beleiro
6758	5738	Alto Río Senguer
6759	5738	Doctor Ricardo Rojas
6760	5738	Facundo
6761	5738	Lago Blanco
6762	5738	Río Mayo
6763	5739	Buen Pasto
6764	5739	Sarmiento
6765	5740	Doctor Oscar Atilio Viglione (Frontera de Río Pico)
6766	5740	Gobernador Costa
6767	5740	José de San Martín
6768	5740	Río Pico
6769	5741	Gan Gan
6770	5741	Telsen
6771	5742	Amboy
6772	5742	Cañada del Sauce
6773	5742	Capilla Vieja
6774	5742	El Corcovado - El Torreón
6775	5742	Embalse
6776	5742	La Cruz
6777	5742	La Cumbrecita
6778	5742	Las Bajadas
6779	5742	Las Caleras
6780	5742	Los Cóndores
6781	5742	Los Molinos
6782	5742	Los Reartes
6783	5742	Lutti
6784	5742	Parque Calmayo
6785	5742	Río de los Sauces
6786	5742	San Ignacio (Loteo San Javier)
6787	5742	Santa Rosa de Calamuchita
6788	5742	Segunda Usina
6789	5742	Solar de los Molinos
6790	5742	Villa Alpina
6791	5742	Villa Amancay
6792	5742	Villa Berna
6793	5742	Villa Ciudad Parque Los Reartes
6794	5742	Villa del Dique
6795	5742	Villa El Tala
6796	5742	Villa General Belgrano
6797	5742	Villa La Rivera
6798	5742	Villa Quillinzo
6799	5742	Villa Rumipal
6800	5742	Villa Yacanto (Yacanto de Calamuchita)
6801	5742	Córdoba
6802	5742	Agua de Oro
6803	5742	Ascochinga
6804	5742	Barrio Nuevo Rio Ceballos
6805	5742	Canteras El Sauce
6806	5742	Casa Bamba
6807	5742	Colonia Caroya
6808	5742	Colonia Tirolesa
6809	5742	Colonia Vicente Agüero
6810	5742	Country Chacras de la Villa (- Country San Isidro)
6811	5742	El Manzano
6812	5742	Estación Colonia Tirolesa
6813	5742	General Paz
6814	5742	Jesús María
6815	5742	La Calera
6816	5742	La Granja
6817	5742	La Morada
6818	5742	Las Corzuelas
6819	5742	Los Molles
6820	5742	Malvinas Argentinas
6821	5742	Mendiolaza
6822	5742	Mi Granja
6823	5742	Pajas Blancas
6824	5742	Río Ceballos
6825	5742	Saldán
6826	5742	Salsipuedes
6827	5742	Santa Elena
6828	5742	Tinoco
6829	5742	Unquillo
6830	5742	Villa Allende
6831	5742	Villa Cerro Azul
6832	5742	Villa Corazon de Maria
6833	5742	Villa El Fachinal (- Parque Norte - Guiñazú Norte)
6834	5742	Villa Los Llanos (- Juárez Celman)
6835	5743	Alto de los Quebrachos
6836	5743	Bañado de Soto
6837	5743	Canteras Quilpo
6838	5743	Cruz de Caña
6839	5743	Cruz del Eje
6840	5743	El Brete
6841	5743	El Rincón
6842	5743	Guanaco Muerto
6843	5743	La Banda
6844	5743	La Batea
6845	5743	Las Cañadas
6846	5743	Las Playas
6847	5743	Los Chañaritos
6848	5743	Media Naranja
6849	5743	Paso Viejo
6850	5743	San Marcos Sierra
6851	5743	Serrezuela
6852	5743	Tuclame
6853	5743	Villa de Soto
6854	5744	Del Campillo
6855	5744	Estación Lecueder
6856	5744	Hipólito Bouchard (Buchardo)
6857	5744	Huinca Renancó
6858	5744	Italó
6859	5744	Mattaldi
6860	5744	Nicolás Bruzzone
6861	5744	Onagoity
6862	5744	Pincén
6863	5744	Ranqueles
6864	5744	Santa Magdalena (Est. Jovita)
6865	5744	Villa Huidobro
6866	5744	Villa Sarmiento
6867	5744	Villa Valeria
6868	5744	Arroyo Algodón
6869	5744	Arroyo Cabral
6870	5744	Ausonia
6871	5744	Chazón
6872	5744	Etruria
6873	5744	La Laguna
6874	5744	La Palestina
6875	5744	La Playosa
6876	5744	Luca
6877	5744	Pasco
6878	5744	Sanabria
6879	5744	Silvio Pellico
6880	5744	Ticino
6881	5744	Tío Pujio
6882	5744	Villa Albertina
6883	5744	Villa Nueva
6884	5744	Villa Oeste
6885	5745	Cañada de Río Pinto
6886	5745	Chuña
6887	5745	Deán Funes
6888	5745	Esquina del Alambre
6889	5745	Los Pozos
6890	5745	Olivares de San Nicolás
6891	5745	Quilino
6892	5745	San Pedro de Toyos
6893	5745	Villa Gutiérrez
6894	5745	Villa Quilino
6895	5746	Alejandro Roca (Est. Alejandro)
6896	5746	Assunta
6897	5746	Bengolea
6898	5746	Carnerillo
6899	5746	Charras
6900	5746	El Rastreador
6901	5746	General Cabrera
6902	5746	General Deheza
6903	5746	Huanchillas
6904	5746	La Carlota
6905	5746	Los Cisnes
6906	5746	Olaeta
6907	5746	Pacheco de Melo
6908	5746	Paso del Durazno
6909	5746	Santa Eufemia
6910	5746	Ucacha
6911	5746	Villa Reducción
6912	5747	Alejo Ledesma
6913	5747	Arias
6914	5747	Camilo Aldao
6915	5747	Capitán General Bernardo O'Higgins
6916	5747	Cavanagh
6917	5747	Colonia Barge
6918	5747	Colonia Italiana
6919	5747	Colonia Veinticinco
6920	5747	Corral de Bustos
6921	5747	Cruz Alta
6922	5747	General Baldissera
6923	5747	General Roca
6924	5747	Guatimozín
6925	5747	Inriville
6926	5747	Isla Verde
6927	5747	Leones
6928	5747	Los Surgentes
6929	5747	Marcos Juárez
6930	5747	Monte Buey
6931	5747	Saira
6932	5747	Villa Elisa
6933	5748	Ciénaga del Coro
6934	5748	El Chacho
6935	5748	Estancia de Guadalupe
6936	5748	Guasapampa
6937	5748	La Playa
6938	5748	San Carlos Minas
6939	5748	Talaini
6940	5748	Tosno
6941	5749	Chancaní
6942	5749	Los Talares
6943	5749	Salsacate
6944	5749	San Gerónimo
6945	5749	Tala Cañada
6946	5749	Taninga
6947	5749	Villa de Pocho
6948	5750	General Levalle
6949	5750	La Cesira
6950	5750	Laboulaye
6951	5750	Leguizamón
6952	5750	Melo
6953	5750	Río Bamba
6954	5750	Rosales
6955	5750	San Joaquín
6956	5750	Serrano
6957	5750	Villa Rossi
6958	5751	Barrio Santa Isabel
6959	5751	Bialet Massé
6960	5751	Cabalango
6961	5751	Capilla del Monte
6962	5751	Casa Grande
6963	5751	Charbonier
6964	5751	Cosquín
6965	5751	Cuesta Blanca
6966	5751	Estancia Vieja
6967	5751	Huerta Grande
6968	5751	La Cumbre
6969	5751	La Falda
6970	5751	Las Jarillas
6971	5751	Los Cocos
6972	5751	Mallín
6973	5751	Mayu Sumaj
6974	5751	Quebrada de Luna
6975	5751	San Antonio de Arredondo
6976	5751	San Esteban
6977	5751	San Roque
6978	5751	Santa María de Punilla
6979	5751	Tala Huasi
6980	5751	Tanti
6981	5751	Valle Hermoso
6982	5751	Villa Carlos Paz
6983	5751	Villa Flor Serrana
6984	5751	Villa Giardino
6985	5751	Villa Lago Azul
6986	5751	Villa Parque Síquiman
6987	5751	Villa Río Icho Cruz
6988	5751	Villa San José (San José de los Ríos)
6989	5751	Villa Santa Cruz del Lago
6990	5752	Achiras
6991	5752	Adelia María
6992	5752	Alcira (Gigena)
6993	5752	Alpa Corral
6994	5752	Berrotarán
6995	5752	Bulnes
6996	5752	Chaján
6997	5752	Chucul
6998	5752	Coronel Baigorria
6999	5752	Coronel Moldes
7000	5752	Elena
7001	5752	La Carolina
7002	5752	La Cautiva
7003	5752	La Gilda
7004	5752	Las Acequias
7005	5752	Las Albahacas
7006	5752	Las Higueras
7007	5752	Las Peñas (Sud)
7008	5752	Las Vertientes
7009	5752	Malena
7010	5752	Monte de los Gauchos
7011	5752	Río Cuarto
7012	5752	Sampacho
7013	5752	San Basilio
7014	5752	Santa Catalina (Holmberg)
7015	5752	Suco
7016	5752	Tosquitas
7017	5752	Vicuña Mackenna
7018	5752	Villa El Chacay
7019	5752	Villa Santa Eugenia
7020	5752	Washington
7021	5753	Atahona
7022	5753	Cañada de Machado
7023	5753	Capilla de los Remedios
7024	5753	Chalacea
7025	5753	Colonia Las Cuatro Esquinas
7026	5753	Diego de Rojas
7027	5753	El Alcalde (Est. Tala Norte)
7028	5753	El Crispín
7029	5753	Esquina
7030	5753	Kilómetro 658
7031	5753	La Para
7032	5753	La Posta
7033	5753	La Quinta
7034	5753	Las Gramillas
7035	5753	Las Saladas
7036	5753	Maquinista Gallini
7037	5753	Monte Cristo
7038	5753	Monte del Rosario
7039	5753	Obispo Trejo
7040	5753	Piquillín
7041	5753	Plaza de Mercedes
7042	5753	Pueblo Comechingones
7043	5753	Río Primero
7044	5753	Sagrada Familia
7045	5753	Santa Rosa de Río Primero
7046	5753	Villa Fontana
7047	5754	Cerro Colorado
7048	5754	Chañar Viejo
7049	5754	Eufrasio Loza
7050	5754	Gutemberg
7051	5754	La Rinconada
7052	5754	Los Hoyos
7053	5754	Puesto de Castro
7054	5754	Rayo Cortado
7055	5754	San Pedro de Gütemberg
7056	5754	Sebastián Elcano
7057	5754	Villa Candelaria
7058	5754	Villa de María
7059	5755	Calchín
7060	5755	Calchín Oeste
7061	5755	Capilla del Carmen
7062	5755	Carrilobo
7063	5755	Colazo
7064	5755	Colonia Videla
7065	5755	Costa Sacate
7066	5755	Impira
7067	5755	Laguna Larga
7068	5755	Las Junturas
7069	5755	Luque
7070	5755	Manfredi
7071	5755	Matorrales
7072	5755	Oncativo
7073	5755	Pozo del Molle
7074	5755	Río Segundo
7075	5755	Santiago Temple
7076	5755	Villa del Rosario
7077	5756	Ámbul
7078	5756	Arroyo Los Patos
7079	5756	El Huayco
7080	5756	La Cortadera
7081	5756	Las Calles
7082	5756	Las Oscuras
7083	5756	Las Rabonas
7084	5756	Los Callejones
7085	5756	Mina Clavero
7086	5756	Mussi
7087	5756	Nono
7088	5756	Panaholma
7089	5756	San Huberto
7090	5756	San Lorenzo
7091	5756	Sauce Arriba
7092	5756	Tasna
7093	5756	Villa Cura Brochero
7094	5757	Conlara
7095	5757	Cruz Caña
7096	5757	Dos Arroyos
7097	5757	La Paz
7098	5757	La Población
7099	5757	La Ramada
7100	5757	La Travesía
7101	5757	Las Chacras
7102	5757	Las Tapias
7103	5757	Loma Bola
7104	5757	Los Cerrillos
7105	5757	Los Hornillos
7106	5757	Luyaba
7107	5757	Quebracho Ladeado
7108	5757	Quebrada de los Pozos
7109	5757	San Javier y Yacanto
7110	5757	Villa de Las Rosas
7111	5757	Villa Dolores
7112	5757	Villa La Viña
7113	5758	Alicia
7114	5758	Altos de Chipión
7115	5758	Arroyito
7116	5758	Balnearia
7117	5758	Brinkmann
7118	5758	Colonia 10 de Julio
7119	5758	Colonia Anita
7120	5758	Colonia Iturraspe
7121	5758	Colonia Las Pichanas
7122	5758	Colonia Marina
7123	5758	Colonia Prosperidad
7124	5758	Colonia San Bartolomé
7125	5758	Colonia San Pedro
7126	5758	Colonia Santa María
7127	5758	Colonia Valtelina
7128	5758	Colonia Vignaud
7129	5758	Devoto
7130	5758	El Arañado
7131	5758	El Fortín
7132	5758	El Fuertecito
7133	5758	El Tío
7134	5758	Estación Luxardo
7135	5758	Freyre
7136	5758	La Francia
7137	5758	La Paquita
7138	5758	La Tordilla
7139	5758	Las Varas
7140	5758	Las Varillas
7141	5758	Marull
7142	5758	Morteros
7143	5758	Plaza Luxardo
7144	5758	Plaza San Francisco
7145	5758	Porteña
7146	5758	Quebracho Herrado
7147	5758	Sacanta
7148	5758	San Francisco
7149	5758	Saturnino María Laspiur
7150	5758	Seeber
7151	5758	Toro Pujio
7152	5758	Tránsito
7153	5758	Villa Concepción del Tío
7154	5758	Villa del Tránsito
7155	5758	Villa San Esteban
7156	5758	Alta Gracia
7157	5758	Anisacate
7158	5758	Barrio Gilbert (- Tejas Tres; 1° de Mayo)
7159	5758	Bouwer
7160	5758	Campos del Virrey
7161	5758	Caseros Centro
7162	5758	Causana
7163	5758	Costa Azul
7164	5758	Despeñaderos
7165	5758	Dique Chico
7166	5758	El Potrerillo
7167	5758	Falda del Cañete
7168	5758	Falda del Carmen
7169	5758	José de la Quintana
7170	5758	La Boca del Río
7171	5758	La Carbonada
7172	5758	La Paisanita
7173	5758	La Perla
7174	5758	La Rancherita y Las Cascadas
7175	5758	La Serranita
7176	5758	Los Cedros
7177	5758	Lozada
7178	5758	Malagueño
7179	5758	Monte Ralo
7180	5758	Potrero de Garay
7181	5758	Rafael García
7182	5758	San Clemente
7183	5758	San Nicolás (- Tierra Alta)
7184	5758	Socavones
7185	5758	Toledo
7186	5758	Valle Alegre
7187	5758	Valle de Anisacate
7188	5758	Villa Ciudad de América (Loteo Diego de Rojas)
7189	5758	Villa del Prado
7190	5758	Villa La Bolsa
7191	5758	Villa Los Aromos
7192	5758	Villa Parque Santa Ana
7193	5758	Villa San Isidro
7194	5758	Villa Sierras de Oro
7195	5758	Yocsina
7196	5759	Caminiaga
7197	5759	Chuña Huasi
7198	5759	Pozo Nuevo
7199	5759	San Francisco del Chañar
7200	5760	Almafuerte
7201	5760	Colonia Almada
7202	5760	Corralito
7203	5760	Dalmacio Vélez
7204	5760	General Fotheringham
7205	5760	Hernando
7206	5760	James Craik
7207	5760	Las Isletillas
7208	5760	Las Perdices
7209	5760	Los Zorros
7210	5760	Oliva
7211	5760	Pampayasta Norte
7212	5760	Pampayasta Sur
7213	5760	Río Tercero
7214	5760	Tancacha
7215	5760	Villa Ascasubi
7216	5761	Candelaria Sur
7217	5761	Cañada de Luque
7218	5761	Capilla de Sitón
7219	5761	La Pampa
7220	5761	Las Peñas
7221	5761	Los Mistoles
7222	5761	Santa Catalina
7223	5761	Simbolar
7224	5761	Sinsacate
7225	5761	Villa del Totoral
7226	5762	Churqui Cañada
7227	5762	El Tuscal
7228	5762	Las Arrias
7229	5762	Lucio V. Mansilla
7230	5762	Rosario del Saladillo
7231	5762	San José de la Dormida
7232	5762	San José de las Salinas
7233	5762	San Pedro Norte
7234	5762	Villa Tulumba
7235	5763	Aldea Santa María
7236	5763	Alto Alegre
7237	5763	Ana Zumarán
7238	5763	Ballesteros
7239	5763	Ballesteros Sur
7240	5763	Bell Ville
7241	5763	Benjamín Gould
7242	5763	Canals
7243	5763	Chilibroste
7244	5763	Cintra
7245	5763	Colonia Bismarck
7246	5763	Colonia Bremen
7247	5763	Idiazábal
7248	5763	Justiniano Posse
7249	5763	Laborde
7250	5763	Monte Leña
7251	5763	Monte Maíz
7252	5763	Morrison
7253	5763	Noetinger
7254	5763	Ordóñez
7255	5763	Pascanas
7256	5763	Pueblo Italiano
7257	5763	Ramón J. Cárcano
7258	5763	San Antonio de Litín
7259	5763	San Marcos
7260	5763	San Severo
7261	5763	Viamonte
7262	5763	Villa Los Patos
7263	5763	Wenceslao Escalante
7264	5764	Bella Vista
7265	5765	Berón de Astrada
7266	5765	Yahapé
7267	5765	Corrientes
7268	5765	Laguna Brava
7269	5765	Riachuelo
7270	5766	Tabay
7271	5766	Tatacuá
7272	5767	Cazadores Correntinos
7273	5767	Curuzú Cuatiá
7274	5767	Perugorría
7275	5768	El Sombrero
7276	5768	Empedrado
7277	5769	Pueblo Libertador
7278	5769	Alvear
7279	5769	Estación Torrent
7280	5769	Itá Ibaté
7281	5769	Lomas de Vallejos
7282	5769	Nuestra Señora del Rosario de Caá Catí
7283	5769	Palmar Grande
7284	5770	Carolina
7285	5770	Goya
7286	5771	Itatí
7287	5771	Ramada Paso
7288	5771	Colonia Liebig's
7289	5771	San Carlos
7290	5771	Villa Olivari
7291	5772	Cruz de los Milagros
7292	5772	Gobernador Juan E. Martínez
7293	5772	Villa Córdoba
7294	5772	Yatayti Calle
7295	5773	Mburucuyá
7296	5773	Felipe Yofre
7297	5773	Mariano I. Loza (Est. Justino Solari)
7298	5774	Colonia Libertad
7299	5774	Estación Libertad
7300	5774	Juan Pujol
7301	5774	Mocoretá
7302	5774	Monte Caseros
7303	5774	Parada Acuña
7304	5774	Parada Labougle
7305	5775	Bonpland
7306	5775	Parada Pucheta
7307	5775	Paso de los Libres
7308	5775	Tapebicuá
7309	5776	Saladas
7310	5777	Ingenio Primer Correntino
7311	5777	Paso de la Patria
7312	5777	San Cosme
7313	5777	Santa Ana
7314	5778	San Luis del Palmar
7315	5779	Colonia Carlos Pellegrini
7316	5779	Guaviraví
7317	5779	Yapeyú
7318	5779	Loreto
7319	5780	9 de Julio (Est. Pueblo 9 de Julio)
7320	5780	Chavarría
7321	5780	Colonia Pando
7322	5780	Pedro R. Fernández (Est. Manuel F. Mantilla)
7323	5781	Garruchos
7324	5781	Gobernador Igr. Valentín Virasoro
7325	5781	José Rafael Gómez (Garabí)
7326	5781	Santo Tomé
7327	5782	Sauce
7328	5782	Arroyo Barú
7329	5782	Colonia Hugues
7330	5782	Hambis
7331	5782	Hocker
7332	5782	La Clarita
7333	5782	Pueblo Cazes
7334	5782	Pueblo Liebig's
7335	5782	Ubajay
7336	5783	Calabacilla
7337	5783	Clodomiro Ledesma
7338	5783	Colonia Ayuí
7339	5783	Colonia General Roca
7340	5783	Concordia
7341	5783	Estación Yeruá
7342	5783	Estación Yuquerí
7343	5783	Estancia Grande (Colonia Yeruá)
7344	5783	La Criolla
7345	5783	Los Charrúas
7346	5783	Nueva Escocia
7347	5783	Osvaldo Magnasco
7348	5783	Pedernal
7349	5783	Puerto Yeruá
7350	5784	Aldea Brasilera
7351	5784	Aldea Grapschental
7352	5784	Aldea Protestante
7353	5784	Aldea Salto
7354	5784	Aldea San Francisco
7355	5784	Aldea Spatzenkutter
7356	5784	Aldea Valle María
7357	5784	Colonia Ensayo
7358	5784	Diamante
7359	5784	Estación Camps
7360	5784	General Alvear (Puerto Alvear)
7361	5784	General Racedo (El Carmen)
7362	5784	General Ramírez
7363	5784	La Juanita
7364	5784	Las Jaulas
7365	5784	Paraje La Virgen
7366	5784	Puerto Las Cuevas
7367	5784	Villa Libertador San Martín
7368	5785	Chajarí
7369	5785	Colonia Alemana
7370	5785	Colonia La Argentina
7371	5785	Colonia Peña
7372	5785	Federación
7373	5785	Los Conquistadores
7374	5785	San Jaime de la Frontera
7375	5785	San Ramón
7376	5786	Aldea San Isidro (El Cimarrón)
7377	5786	Conscripto Bernardi
7378	5786	Federal
7379	5786	Nueva Vizcaya
7380	5786	Sauce de Luna
7381	5787	San José de Feliciano
7382	5787	San Víctor
7383	5788	Aldea Asunción
7384	5788	Estación Lazo
7385	5788	General Galarza
7386	5788	Gualeguay
7387	5788	Puerto Ruiz
7388	5789	Aldea San Antonio
7389	5789	Aldea San Juan
7390	5789	Enrique Carbó
7391	5789	Estación Escriña
7392	5789	Faustino M. Parera
7393	5789	General Almada
7394	5789	Gilbert
7395	5789	Gualeguaychú
7396	5789	Irazusta
7397	5789	Larroque
7398	5789	Pastor Britos
7399	5789	Pueblo General Belgrano
7400	5789	Urdinarrain
7401	5790	Ceibas
7402	5790	Ibicuy
7403	5790	Villa Paranacito
7404	5790	Bovril
7405	5790	Colonia Avigdor
7406	5790	El Solar
7407	5790	Piedras Blancas
7408	5790	Pueblo Arrúa (Est. Alcaraz)
7409	5790	San Gustavo
7410	5790	Sir Leonard
7411	5791	Aranguren
7412	5791	Betbeder
7413	5791	Don Cristóbal
7414	5791	Febré
7415	5791	Hernández
7416	5791	Lucas González
7417	5791	Nogoyá
7418	5791	XX de Setiembre
7419	5792	Aldea María Luisa
7420	5792	Aldea San Rafael
7421	5792	Aldea Santa Rosa
7422	5792	Cerrito
7423	5792	Colonia Avellaneda
7424	5792	Colonia Crespo
7425	5792	Crespo
7426	5792	El Palenque
7427	5792	El Pingo
7428	5792	El Ramblón
7429	5792	Hasenkamp
7430	5792	Hernandarias
7431	5792	La Picada
7432	5792	Las Tunas
7433	5792	María Grande
7434	5792	Oro Verde
7435	5792	Paraná
7436	5792	Pueblo Bellocq (Est. Las Garzas)
7437	5792	Pueblo Brugo
7438	5792	Pueblo General San Martín
7439	5792	San Benito
7440	5792	Sauce Montrull
7441	5792	Sauce Pinto
7442	5792	Seguí
7443	5792	Sosa
7444	5792	Tabossi
7445	5792	Tezanos Pinto
7446	5792	Viale
7447	5792	Villa Gobernador Luis F. Etchevehere
7448	5792	Villa Urquiza
7449	5793	General Campos
7450	5793	San Salvador
7451	5794	Altamirano Sur
7452	5794	Durazno
7453	5794	Estación Arroyo Clé
7454	5794	Gobernador Echagüe
7455	5794	Gobernador Mansilla
7456	5794	Gobernador Sola
7457	5794	Guardamonte
7458	5794	Las Guachas
7459	5794	Maciá
7460	5794	Rosario del Tala
7461	5795	1º de Mayo (Primero de Mayo)
7462	5795	Basavilbaso
7463	5795	Caseros
7464	5795	Colonia Elía
7465	5795	Concepción del Uruguay
7466	5795	Herrera
7467	5795	Las Moscas
7468	5795	Líbaros
7469	5795	Pronunciamiento
7470	5795	Rocamora
7471	5795	Santa Anita
7472	5795	Villa Mantero
7473	5795	Villa San Justo
7474	5795	Villa San Marcial (Est. Gobernador Urquiza)
7475	5796	Antelo
7476	5796	Molino Doll
7477	5796	Victoria
7478	5797	Estación Raíces
7479	5797	Ingeniero Miguel Sajaroff
7480	5797	Jubileo
7481	5797	Paso de la Laguna
7482	5797	Villa Clara
7483	5797	Villa Domínguez
7484	5797	Villaguay
7485	5797	Fortín Soledad
7486	5797	Guadalcazar
7487	5797	Laguna Yema
7488	5797	Lamadrid
7489	5797	Los Chiriguanos
7490	5797	Pozo de Maza
7491	5797	Pozo del Mortero
7492	5797	Vaca Perdida
7493	5798	Colonia Pastoril
7494	5798	Formosa
7495	5798	Gran Guardia
7496	5798	Mariano Boedo
7497	5798	Mojón de Fierro
7498	5798	San Hilario
7499	5798	Villa del Carmen
7500	5799	Banco Payaguá
7501	5799	General Lucio Victorio Mansilla
7502	5799	Herradura
7503	5799	San Francisco de Laishi
7504	5799	Tatané
7505	5799	Villa Escolar
7506	5800	Ingeniero Guillermo N. Juárez
7507	5801	Bartolomé de las Casas
7508	5801	Colonia Sarmiento
7509	5801	Comandante Fontana
7510	5801	El Recreo
7511	5801	Estanislao del Campo
7512	5801	Fortín Cabo 1º Lugones
7513	5801	Fortín Sargento 1º Leyes
7514	5801	Ibarreta
7515	5801	Juan G. Bazán
7516	5801	Las Lomitas
7517	5801	Posta Cambio Zalazar
7518	5801	Pozo del Tigre
7519	5801	San Martín I
7520	5801	San Martín II
7521	5801	Subteniente Perín
7522	5801	Villa General Güemes
7523	5801	Villa General Manuel Belgrano
7524	5802	Buena Vista
7525	5802	Laguna Gallo
7526	5802	Misión Tacaaglé
7527	5802	Portón Negro
7528	5802	Tres Lagunas
7529	5803	Clorinda
7530	5803	Laguna Naick-Neck
7531	5803	Palma Sola
7532	5803	Puerto Pilcomayo
7533	5803	Riacho He-He
7534	5803	Riacho Negro
7535	5803	Siete Palmas
7536	5804	Colonia Campo Villafañe (Mayor Vicente Villafañe)
7537	5804	El Colorado
7538	5804	Palo Santo
7539	5804	Pirané
7540	5804	Villa Kilómetro 213 (Villa Dos Trece)
7541	5805	El Potrillo
7542	5805	El Quebracho
7543	5805	General Mosconi
7544	5806	Abdón Castro Tolay
7545	5806	Abra Pampa
7546	5806	Abralaite
7547	5806	Agua de Castilla
7548	5806	Casabindo
7549	5806	Cochinoca
7550	5806	La Redonda
7551	5806	Puesto del Marquéz
7552	5806	Quebraleña
7553	5806	Quera
7554	5806	Rinconadillas
7555	5806	San Francisco de Alfarcito
7556	5806	Santa Ana de la Puna
7557	5806	Santuario de Tres Pozos
7558	5806	Tambillos
7559	5806	Tusaquillas
7560	5807	Guerrero
7561	5807	La Almona
7562	5807	León
7563	5807	Lozano (Ap. Chañi)
7564	5807	Ocloyas
7565	5807	San Salvador de Jujuy (Est. Jujuy)
7566	5807	Tesorero
7567	5807	Yala
7568	5808	Aguas Calientes
7569	5808	Barrio El Milagro (La Ovejería)
7570	5808	Barrio La Unión
7571	5808	El Carmen
7572	5808	Los Lapachos (Est. Maquinista Veró)
7573	5808	Loteo San Vicente
7574	5808	Monterrico
7575	5808	Pampa Blanca
7576	5808	Perico
7577	5808	Puesto Viejo
7578	5808	San Juancito
7579	5809	Aparzo
7580	5809	Cianzo
7581	5809	Coctaca
7582	5809	El Aguilar
7583	5809	Hipólito Yrigoyen (Est. Iturbe)
7584	5809	Humahuaca
7585	5809	Palca de Aparzo
7586	5809	Palca de Varas
7587	5809	Rodero
7588	5809	Tres Cruces
7589	5809	Uquía (Est. Senador Pérez)
7590	5810	Bananal
7591	5810	Bermejito
7592	5810	Caimancito
7593	5810	Calilegua
7594	5810	Chalicán
7595	5810	Fraile Pintado
7596	5810	Libertad
7597	5810	Libertador General San Martín (Est. Ledesma)
7598	5810	Paulina
7599	5810	Yuto
7600	5811	Carahunco
7601	5811	Centro Forestal
7602	5811	Palpalá (Est. Gral. Manuel N. Savio)
7603	5812	Casa Colorada
7604	5812	Coyaguaima
7605	5812	Lagunillas de Farallón
7606	5812	Liviara
7607	5812	Loma Blanca
7608	5812	Nuevo Pirquitas (Mina Pirquitas)
7609	5812	Orosmayo
7610	5812	Rinconada
7611	5813	El Ceibal
7612	5813	Los Alisos
7613	5813	Loteo Navea (Los Alisos)
7614	5813	Nuestra Señora del Rosario
7615	5813	Arrayanal
7616	5813	Arroyo Colorado
7617	5813	Don Emilio
7618	5813	El Acheral
7619	5813	El Quemado
7620	5813	La Esperanza
7621	5813	La Manga
7622	5813	La Mendieta
7623	5813	Palos Blancos
7624	5813	Parapetí
7625	5813	Rodeíto
7626	5813	Rosario de Río Grande (Barro Negro)
7627	5813	San Lucas
7628	5813	San Pedro (Est. San Pedro de Jujuy)
7629	5813	Sauzal
7630	5814	El Fuerte
7631	5814	El Piquete
7632	5814	El Talar
7633	5814	Puente Lavayén
7634	5814	Santa Clara
7635	5814	Vinalito
7636	5815	Casira
7637	5815	Ciénega de Paicone
7638	5815	Cieneguillas
7639	5815	Cusi Cusi
7640	5815	El Angosto
7641	5815	La Ciénega
7642	5815	Misarrumi
7643	5815	Oratorio
7644	5815	Paicone
7645	5815	San Juan de Oros
7646	5815	Yoscaba
7647	5816	Catua
7648	5816	Coranzulí
7649	5816	El Toro
7650	5816	Huáncar
7651	5816	Jama
7652	5816	Mina Providencia
7653	5816	Olacapato
7654	5816	Olaroz Chico
7655	5816	Pastos Chicos
7656	5816	Puesto Sey
7657	5816	San Juan de Quillaqués
7658	5816	Susques
7659	5817	Colonia San José
7660	5817	Huacalera
7661	5817	Juella
7662	5817	Maimará
7663	5817	Tilcara
7664	5818	Bárcena
7665	5818	El Moreno
7666	5818	Puerta de Colorados
7667	5818	Purmamarca
7668	5818	Tumbaya
7669	5818	Volcán
7670	5819	Caspalá
7671	5819	Pampichuela
7672	5819	Valle Colorado
7673	5819	Valle Grande
7674	5820	Barrios
7675	5820	Cangrejillos
7676	5820	El Cóndor
7677	5820	La Intermedia
7678	5820	La Quiaca
7679	5820	Llulluchayoc
7680	5820	Pumahuasi
7681	5820	Yavi
7682	5820	Yavi Chico
7683	5821	Doblas
7684	5821	Macachín
7685	5821	Miguel Riglos
7686	5821	Rolón
7687	5821	Tomás Manuel de Anchorena
7688	5822	Anzoátegui
7689	5822	La Adela
7690	5822	Anguil
7691	5823	Catriló
7692	5823	La Gloria
7693	5823	Lonquimay
7694	5823	Uriburu
7695	5824	Santa Isabel
7696	5825	Bernardo Larroudé
7697	5825	Ceballos
7698	5825	Coronel Hilario Lagos (Est. Aguas Buenas)
7699	5825	Intendente Alvear
7700	5825	Sarah
7701	5825	Vértiz
7702	5826	Algarrobo del Águila
7703	5826	La Humada
7704	5827	Conhelo
7705	5827	Eduardo Castex
7706	5827	Mauricio Mayer
7707	5827	Monte Nievas
7708	5827	Rucanelo
7709	5827	Winifreda
7710	5828	Gobernador Duval
7711	5828	Puelches
7712	5829	Alpachiri
7713	5829	General Manuel J. Campos
7714	5829	Guatraché
7715	5829	Perú
7716	5829	Santa Teresa
7717	5830	Abramo
7718	5830	Bernasconi
7719	5830	General San Martín (Est. Villa Alba)
7720	5830	Hucal
7721	5830	Jacinto Aráuz
7722	5831	Cuchillo-Có
7723	5832	La Reforma
7724	5832	Limay Mahuida
7725	5833	Carro Quemado
7726	5833	Loventué
7727	5833	Luan Toro
7728	5833	Telén
7729	5833	Victorica
7730	5834	Agustoni
7731	5834	Dorila
7732	5834	General Pico
7733	5834	Speluzzi
7734	5834	Trebolares
7735	5835	Puelén
7736	5836	Colonia Barón
7737	5836	Miguel Cané
7738	5836	Quemú Quemú
7739	5836	Relmo
7740	5836	Villa Mirasol
7741	5837	Caleufú
7742	5837	Ingeniero Foster
7743	5837	La Maruja
7744	5837	Parera
7745	5837	Pichi Huinca
7746	5837	Quetrequén
7747	5837	Rancul
7748	5838	Adolfo Van Praet
7749	5838	Alta Italia
7750	5838	Damián Maisonave (Est. Simson)
7751	5838	Embajador Martini
7752	5838	Falucho
7753	5838	Ingeniero Luiggi
7754	5838	Ojeda
7755	5838	Realicó
7756	5839	Cachirulo
7757	5839	Naicó
7758	5839	Toay
7759	5840	Arata
7760	5840	Metileo
7761	5840	Trenel
7762	5841	Ataliva Roca
7763	5841	Chacharramendi
7764	5841	General Acha
7765	5841	Quehué
7766	5841	Unanué
7767	5842	Aimogasta
7768	5842	Arauco
7769	5842	Bañado de los Pantanos
7770	5842	Estación Mazán
7771	5842	Termas Santa Teresita
7772	5842	Villa Mazán
7773	5842	La Rioja
7774	5843	Aminga
7775	5843	Anjullón
7776	5843	Chuquis
7777	5843	Pinchas
7778	5843	Santa Vera Cruz
7779	5844	Chamical
7780	5844	Polco
7781	5845	Chilecito
7782	5845	Colonia Anguinán
7783	5845	Colonia Catinzaco
7784	5845	Colonia Malligasta
7785	5845	Colonia Vichigasta
7786	5845	Guanchín
7787	5845	Malligasta
7788	5845	Miranda
7789	5845	Nonogasta
7790	5845	San Nicolás
7791	5845	Santa Florentina
7792	5845	Sañogasta
7793	5845	Tilimuqui
7794	5845	Vichigasta
7795	5846	Aicuña
7796	5846	Guandacol
7797	5846	Los Palacios
7798	5846	Pagancillo
7799	5846	Villa Unión
7800	5847	Alto Carrizal
7801	5847	Angulos
7802	5847	Bajo Carrizal
7803	5847	Campanas
7804	5847	Chañarmuyo
7805	5847	Famatina
7806	5847	La Cuadra
7807	5847	Pituil
7808	5847	Plaza Vieja
7809	5848	Punta de los Llanos
7810	5848	Tama
7811	5848	Castro Barros
7812	5848	Chañar
7813	5848	Olta
7814	5849	Malanzán
7815	5849	Nácate
7816	5849	Portezuelo
7817	5850	Villa Castelli
7818	5851	Ambil
7819	5851	Colonia Ortiz de Ocampo
7820	5851	Milagro
7821	5851	Olpas
7822	5851	Santa Rita de Catuna
7823	5851	Ulapes
7824	5851	Amaná
7825	5851	Patquía
7826	5852	Chepes
7827	5852	Desiderio Tello
7828	5853	Salicas (- San Blas)
7829	5854	Villa Sanagasta
7830	5855	Jagüé
7831	5855	Villa San José de Vinchina
7832	5855	Mendoza
7833	5855	Bowen
7834	5855	Carmensa
7835	5855	Los Compartos
7836	5856	Godoy Cruz
7837	5857	Colonia Segovia
7838	5857	Guaymallén (Villa Nueva)
7839	5857	La Primavera
7840	5857	Los Corralitos
7841	5857	Puente de Hierro
7842	5857	Ingeniero Giagnoni
7843	5857	La Colonia
7844	5857	Los Barriales
7845	5857	Medrano
7846	5857	Phillips
7847	5857	Rodríguez Peña
7848	5857	Desaguadero
7849	5857	Villa Antigua
7850	5858	Blanco Encalada
7851	5858	Jocolí
7852	5858	Las Cuevas
7853	5858	Las Heras
7854	5858	Los Penitentes
7855	5858	Puente del Inca
7856	5858	Punta de Vacas
7857	5858	Uspallata
7858	5858	3 de Mayo
7859	5858	Barrio Alto del Olvido
7860	5858	Barrio Jocolí II
7861	5858	Barrio La Palmera
7862	5858	Barrio La Pega
7863	5858	Barrio Lagunas de Bartoluzzi
7864	5858	Barrio Los Jarilleros
7865	5858	Barrio Los Olivos
7866	5858	Barrio Virgen del Rosario
7867	5858	Costa de Araujo
7868	5858	El Paramillo
7869	5858	El Vergel
7870	5858	Ingeniero Gustavo André
7871	5858	Jocolí Viejo
7872	5858	Las Violetas
7873	5858	Villa Tulumaya
7874	5859	Agrelo
7875	5859	Barrio Perdriel IV
7876	5859	Cacheuta
7877	5859	Costa Flores
7878	5859	El Carrizal
7879	5859	El Salto
7880	5859	Las Compuertas
7881	5859	Las Vegas
7882	5859	Luján de Cuyo
7883	5859	Perdriel
7884	5859	Potrerillos
7885	5859	Ugarteche
7886	5859	Barrancas
7887	5859	Barrio Jesús de Nazaret
7888	5859	Cruz de Piedra
7889	5859	El Pedregal
7890	5859	Fray Luis Beltrán
7891	5859	Rodeo del Medio
7892	5859	Russell
7893	5859	Villa Teresa
7894	5860	Agua Escondida
7895	5860	Las Leñas
7896	5860	Malargüe
7897	5860	Andrade
7898	5860	Barrio Cooperativa Los Campamentos
7899	5860	Barrio Rivadavia
7900	5860	El Mirador
7901	5860	La Central
7902	5860	La Florida
7903	5860	La Libertad
7904	5860	Los Árboles
7905	5860	Los Campamentos
7906	5860	Mundo Nuevo
7907	5860	Reducción de Abajo
7908	5860	Rivadavia
7909	5860	Santa María de Oro
7910	5861	Barrio Carrasco
7911	5861	Barrio El Cepillo
7912	5861	Eugenio Bustos
7913	5861	La Consulta
7914	5861	Pareditas
7915	5861	Alto Verde
7916	5861	Barrio Chivilcoy
7917	5861	Barrio Emanuel
7918	5861	Barrio la Estación
7919	5861	Barrio Los Charabones
7920	5861	Barrio Nuestra Señora de Fátima
7921	5861	Chapanay
7922	5861	El Espino
7923	5861	Montecaseros
7924	5861	Nueva California (Est. Moluches)
7925	5861	Tres Porteñas
7926	5862	Barrio Campos El Toledano
7927	5862	Barrio El Nevado
7928	5862	Barrio Empleados de Comercio
7929	5862	Barrio Intendencia
7930	5862	Capitán Montoya
7931	5862	Cuadro Benegas
7932	5862	El Nihuil
7933	5862	El Sosneado
7934	5862	El Tropezón
7935	5862	Goudge
7936	5862	Jaime Prats
7937	5862	La Llave Nueva
7938	5862	Las Malvinas
7939	5862	Los Reyunos
7940	5862	Monte Comán
7941	5862	Pobre Diablo
7942	5862	Rama Caída
7943	5862	Real del Padre
7944	5862	Salto de las Rosas
7945	5862	San Rafael
7946	5862	Villa Atuel
7947	5862	Villa Atuel Norte
7948	5862	Barrio 12 de Octubre
7949	5862	Barrio María Auxiliadora
7950	5862	Barrio Molina Cabrera
7951	5862	La Dormida
7952	5862	Las Catitas
7953	5863	Barrio San Cayetano
7954	5863	Campo Los Andes
7955	5863	Colonia Las Rosas
7956	5863	Los Sauces
7957	5863	Tunuyán
7958	5863	Vista Flores
7959	5864	Barrio Belgrano Norte
7960	5864	Cordón del Plata
7961	5864	El Peral
7962	5864	El Zampal
7963	5864	La Arboleda
7964	5864	Tupungato
7965	5865	Apóstoles
7966	5865	Azara
7967	5865	Barrio Rural
7968	5865	Estación Apóstoles
7969	5865	Pindapoy
7970	5865	Rincón de Azara (Puerto Azara)
7971	5865	Tres Capones
7972	5866	Aristóbulo del Valle
7973	5866	Campo Grande
7974	5866	Dos de Mayo
7975	5866	Dos de Mayo Núcleo III (Barrio Bernardino Rivadavia)
7976	5866	Kilómetro 17
7977	5866	Pueblo Illia
7978	5866	Salto Encantado
7979	5867	Barrio del Lago
7980	5867	Candelaria
7981	5867	Cerro Corá
7982	5867	Mártires
7983	5867	Profundidad
7984	5867	Puerto Santa Ana
7985	5867	Barrio Nuevo Garupa
7986	5867	Garupá
7987	5867	Nemesio Parma
7988	5867	Posadas
7989	5867	Posadas (Expansión)
7990	5867	Barra Concepción
7991	5867	Concepción de la Sierra
7992	5867	La Corita
7993	5868	9 de Julio Kilómetro 20 (Nueve de Julio Kilómetro 20)
7994	5868	9 de Julio Kilómetro 28 (Nueve de Julio Kilómetro 28)
7995	5868	Colonia Victoria
7996	5868	Eldorado
7997	5868	María Magdalena (Colonia Delicia)
7998	5868	Nueva Delicia
7999	5868	Puerto Mado
8000	5868	Puerto Pinares
8001	5868	Santiago de Liniers
8002	5868	Villa Roulet
8003	5869	Bernardo de Irigoyen
8004	5869	Caburei
8005	5869	Comandante Andresito (Almirante Brown)
8006	5869	Dos Hermanas
8007	5869	Integración
8008	5869	Piñalito Norte
8009	5869	Puerto Andresito
8010	5869	Puerto Deseado
8011	5870	El Soberbio
8012	5870	Fracrán
8013	5871	Colonia Wanda
8014	5871	Puerto Esperanza
8015	5871	Puerto Iguazú
8016	5871	Puerto Libertad
8017	5871	Villa Cooperativa
8018	5871	Arroyo del Medio
8019	5871	Caá - Yarí
8020	5871	Cerro Azul
8021	5871	Gobernador López
8022	5871	Olegario V. Andrade
8023	5871	Villa Libertad (Municipio Caá Yarí)
8024	5871	Capioví
8025	5871	Copioviciño
8026	5871	El Alcázar
8027	5871	Garuhapé
8028	5871	Mbopicuá
8029	5871	Puerto Leoni
8030	5871	Puerto Rico
8031	5871	Ruiz de Montoya
8032	5871	San Alberto
8033	5871	San Gotardo
8034	5871	San Miguel (Garuhapé-Mi)
8035	5871	Villa Akerman
8036	5871	Villa Urrutia
8037	5872	Barrio Cuatro Bocas
8038	5872	Barrio Guatambú
8039	5872	Barrio Itá
8040	5872	Caraguatay
8041	5872	Laharrague
8042	5872	Montecarlo
8043	5872	Piray Kilómetro 18
8044	5872	Puerto Piray
8045	5872	Tarumá
8046	5872	Villa Parodi
8047	5873	Barrio Escuela 461
8048	5873	Barrio Escuela 633
8049	5873	Campo Ramón
8050	5873	Campo Viera
8051	5873	Colonia Alberdi
8052	5873	Guaraní
8053	5873	Los Helechos
8054	5873	Oberá
8055	5873	Panambí
8056	5873	Panambí Kilómetro 15
8057	5873	Panambí Kilómetro 8
8058	5873	Villa Bonita
8059	5874	Barrio Tungoil
8060	5874	Colonia Polana
8061	5874	Corpus
8062	5874	Domingo Savio
8063	5874	General Urquiza
8064	5874	Gobernador Roca
8065	5874	Helvecia (Barrio Eva Perón)
8066	5874	Hipólito Yrigoyen
8067	5874	Jardín América
8068	5874	Oasis
8069	5874	Roca Chica
8070	5874	San Ignacio
8071	5874	Santo Pipó
8072	5874	Itacaruaré
8073	5874	Mojón Grande
8074	5874	San Javier
8075	5874	Cruce Caballero
8076	5874	Paraíso
8077	5874	Piñalito Sur
8078	5874	Tobuna
8079	5874	Alba Posse
8080	5874	Alicia Alta
8081	5874	Alicia Baja
8082	5874	Colonia Aurora
8083	5874	San Francisco de Asís
8084	5874	Santa Rita
8085	5875	Aluminé
8086	5875	Moquehue
8087	5875	Villa Pehuenia
8088	5876	Aguada San Roque
8089	5876	Añelo
8090	5876	San Patricio del Chañar
8091	5877	Las Coloradas
8092	5878	Chos Malal
8093	5878	Tricao Malal
8094	5878	Villa del Curi Leuvú
8095	5879	Piedra del Águila
8096	5879	Santo Tomás
8097	5880	11 de Octubre
8098	5880	Barrio Ruca Luhé
8099	5880	Centenario
8100	5880	Cutral Có
8101	5880	El Chocón (Barrio Llequen)
8102	5880	Mari Menuco
8103	5880	Neuquén
8104	5880	Plaza Huincul
8105	5880	Plottier
8106	5880	Senillosa
8107	5880	Villa El Chocón
8108	5880	Vista Alegre Norte
8109	5880	Vista Alegre Sur
8110	5881	Junín de los Andes
8111	5882	San Martín de los Andes
8112	5882	Villa Lago Meliquina
8113	5883	Chorriaca
8114	5883	Loncopué
8115	5884	Villa La Angostura
8116	5884	Villa Traful
8117	5884	Andacollo
8118	5884	Huinganco
8119	5884	Las Ovejas
8120	5884	Los Miches
8121	5884	Manzano Amargo
8122	5884	Varvarco
8123	5884	Villa Nahueve
8124	5885	Caviahue
8125	5885	Copahue
8126	5885	El Cholar
8127	5885	El Huecú
8128	5885	Taquimilán
8129	5886	Buta Ranquil
8130	5886	Octavio Pico
8131	5886	Rincón de los Sauces
8132	5887	El Sauce
8133	5887	Paso Aguerre
8134	5887	Picún Leufú
8135	5888	Bajada del Agrio
8136	5888	La Buitrera
8137	5888	Quili Malal
8138	5889	Los Catutos
8139	5889	Mariano Moreno
8140	5889	Ramón M. Castro
8141	5889	Zapala
8142	5889	Bahía Creek
8143	5889	El Juncal
8144	5889	Guardia Mitre
8145	5889	La Lobería
8146	5889	Loteo Costa de Río
8147	5889	Pozo Salado
8148	5889	Viedma
8149	5889	Barrio Unión
8150	5889	Chelforó
8151	5889	Chimpay
8152	5889	Choele Choel
8153	5889	Coronel Belisle
8154	5889	Darwin
8155	5889	Lamarque
8156	5889	Luis Beltrán
8157	5889	Pomona
8158	5890	Arelauquen
8159	5890	Barrio El Pilar
8160	5890	Colonia Suiza
8161	5890	El Foyel
8162	5890	Mallin Ahogado
8163	5890	Río Villegas
8164	5890	San Carlos de Bariloche
8165	5890	Villa Catedral
8166	5890	Villa Los Coihues
8167	5890	Villa Mascardi
8168	5891	Barrio Colonia Conesa
8169	5891	Barrio Planta Compresora de Gas
8170	5892	Aguada Guzmán
8171	5892	Cerro Policía
8172	5892	El Cuy
8173	5892	Las Perlas
8174	5892	Mencué
8175	5892	Naupa Huen
8176	5892	Paso Córdova (Paso Córdoba)
8177	5892	Valle Azul
8178	5892	Allen
8179	5892	Barda del Medio
8180	5892	Barrio Blanco
8181	5892	Barrio Calle Ciega Nº 10
8182	5892	Barrio Calle Ciega Nº 6
8183	5892	Barrio Canale
8184	5892	Barrio Chacra Monte
8185	5892	Barrio Costa Este
8186	5892	Barrio Costa Linda
8187	5892	Barrio Costa Oeste
8188	5892	Barrio Destacamento
8189	5892	Barrio El Labrador
8190	5892	Barrio El Maruchito
8191	5892	Barrio El Petróleo
8192	5892	Barrio Emergente
8193	5892	Barrio Fátima
8194	5892	Barrio Frontera
8195	5892	Barrio Guerrico
8196	5892	Barrio Isla 10
8197	5892	Barrio La Barda
8198	5892	Barrio La Costa (Municipio General Roca)
8199	5892	Barrio La Costa (Municipio Ingeniero Huergo)
8200	5892	Barrio La Defensa
8201	5892	Barrio la Herradura
8202	5892	Barrio La Ribera - Barrio Apycar
8203	5892	Barrio Luisillo
8204	5892	Barrio Mar del Plata
8205	5892	Barrio María Elvira
8206	5892	Barrio Moño Azul
8207	5892	Barrio Mosconi
8208	5892	Barrio Norte (Municipio de Cinco Saltos)
8209	5892	Barrio Pinar
8210	5892	Barrio Porvenir
8211	5892	Barrio Puente 83
8212	5892	Barrio Santa Lucía
8213	5892	Barrio Santa Rita
8214	5892	Catriel
8215	5892	Cervantes
8216	5892	Chichinales
8217	5892	Cinco Saltos
8218	5892	Cipolletti
8219	5892	Contralmirante Cordero
8220	5892	Ferri
8221	5892	General Enrique Godoy
8222	5892	General Fernández Oro
8223	5892	Ingeniero Luis A. Huergo
8224	5892	Ingeniero Otto Krause
8225	5892	Mainqué
8226	5892	Paraje Arroyón (Bajo San Cayetano)
8227	5892	Península Ruca Co
8228	5892	Puente Cero (Barrio Las Angustias)
8229	5892	Sargento Vidal
8230	5892	Villa Alberdi
8231	5892	Villa del Parque
8232	5892	Villa Manzano
8233	5892	Villa Regina
8234	5892	Comicó
8235	5892	Cona Niyeu
8236	5892	Ministro Ramos Mexía
8237	5892	Prahuaniyeu
8238	5892	Sierra Colorada
8239	5892	Treneta
8240	5892	Yaminué
8241	5893	Las Bayas
8242	5893	Mamuel Choique
8243	5893	Ñorquincó
8244	5893	Ojos de Agua
8245	5893	Río Chico (Est. Cerro Mesa)
8246	5894	Barrio Esperanza
8247	5894	Colonia Juliá y Echarren
8248	5894	Juventud Unida
8249	5894	Pichi Mahuida
8250	5894	Río Colorado
8251	5894	Salto Andersen
8252	5895	Cañadón Chileno
8253	5895	Comallo
8254	5895	Dina Huapi
8255	5895	Ñirihuau
8256	5895	Pilcaniyeu
8257	5895	Pilquiniyeu del Limay
8258	5895	Villa Llanquín
8259	5895	El Empalme
8260	5895	Las Grutas
8261	5895	Playas Doradas
8262	5895	Puerto San Antonio Este
8263	5895	Punta Colorada
8264	5895	Saco Viejo
8265	5895	San Antonio Oeste
8266	5895	Sierra Grande
8267	5896	Aguada Cecilio
8268	5896	Arroyo Los Berros
8269	5896	Arroyo Ventana
8270	5896	Nahuel Niyeu
8271	5896	Sierra Pailemán
8272	5896	Valcheta
8273	5896	Aguada de Guerra
8274	5896	Clemente Onelli
8275	5896	Colan Conhue
8276	5896	El Caín
8277	5896	Ingeniero Jacobacci
8278	5896	Los Menucos
8279	5896	Maquinchao
8280	5896	Mina Santa Teresita
8281	5896	Pilquiniyeu
8282	5897	Apolinario Saravia
8283	5897	Ceibalito
8284	5897	Centro 25 de Junio
8285	5897	Coronel Mollinedo
8286	5897	Coronel Olleros
8287	5897	El Quebrachal
8288	5897	Gaona
8289	5897	General Pizarro
8290	5897	Joaquín V. González
8291	5897	Las Lajitas
8292	5897	Luis Burela
8293	5897	Macapillo
8294	5897	Nuestra Señora de Talavera
8295	5897	Piquete Cabado
8296	5897	Río del Valle
8297	5897	Tolloche
8298	5898	Cachi
8299	5898	Payogasta
8300	5899	Cafayate
8301	5899	Tolombóm
8302	5899	Atocha
8303	5899	La Ciénaga y Barrio San Rafael
8304	5899	Las Costas
8305	5899	Salta
8306	5899	Villa San Lorenzo
8307	5900	Cerrillos
8308	5900	Villa Los Álamos (- El Congreso - Las Tunas)
8309	5901	Barrio Finca la Maroma
8310	5901	Barrio la Rotonda
8311	5901	Barrio Santa Teresita
8312	5901	Chicoana
8313	5901	El Carril
8314	5901	Campo Santo
8315	5901	Cobos
8316	5901	El Bordo
8317	5901	General Güemes
8318	5902	Aguaray
8319	5902	Campamento Vespucio
8320	5902	Campichuelo
8321	5902	Campo Durán
8322	5902	Capiazuti
8323	5902	Carboncito
8324	5902	Coronel Cornejo
8325	5902	Dragones
8326	5902	Embarcación
8327	5902	General Ballivián
8328	5902	Hickman
8329	5902	Misión Chaqueña
8330	5902	Misión El Cruce (- El Milagro - El Jardín de San Martín)
8331	5902	Misión Kilómetro 6
8332	5902	Pacará
8333	5902	Padre Lozano
8334	5902	Piquirenda
8335	5902	Profesor Salvador Mazza
8336	5902	Tartagal
8337	5902	Tobantirenda
8338	5902	Tranquitas
8339	5902	Yacuy
8340	5903	Guachipas
8341	5904	Iruya
8342	5904	Isla de Cañas
8343	5904	Pueblo Viejo
8344	5905	La Caldera
8345	5905	Vaqueros
8346	5906	El Jardín
8347	5906	El Tala
8348	5907	Cobres
8349	5907	La Poma
8350	5908	Ampascachi
8351	5908	Cabra Corral
8352	5908	Talapampa
8353	5909	San Antonio de los Cobres
8354	5909	Santa Rosa de los Pastos Grandes
8355	5909	Tolar Grande
8356	5910	El Galpón
8357	5910	El Tunal
8358	5910	Lumbreras
8359	5910	Metán Viejo
8360	5910	Río Piedras
8361	5910	San José de Metán
8362	5910	San José de Orquera
8363	5911	Molinos
8364	5911	Seclantás
8365	5912	Aguas Blancas
8366	5912	Colonia Santa Rosa
8367	5912	El Tabacal
8368	5912	Pichanal
8369	5912	San Ramón de la Nueva Orán
8370	5912	Urundel
8371	5912	Alto de la Sierra
8372	5912	Capitán Juan Pagé
8373	5912	Coronel Juan Solá
8374	5912	Hito 1
8375	5912	La Unión
8376	5912	Los Blancos
8377	5912	Pluma de Pato
8378	5912	Santa Victoria Este
8379	5913	Antilla
8380	5913	Copo Quile
8381	5913	El Naranjo
8382	5913	El Potrero (Apeadero Cochabamba)
8383	5913	Rosario de la Frontera
8384	5913	San Felipe
8385	5914	Campo Quijano
8386	5914	La Merced del Encón
8387	5914	La Silleta
8388	5914	Rosario de Lerma
8389	5914	Angastaco
8390	5914	Animaná
8391	5914	El Barrial
8392	5915	Acoyte
8393	5915	Campo La Cruz
8394	5915	Nazareno
8395	5915	Poscaya
8396	5915	Santa Victoria
8397	5916	Villa General San Martín (- Campo Afuera)
8398	5917	Villa El Salvador (- Villa Sefair)
8399	5918	Barreal (- Villa Pituil)
8400	5918	Calingasta
8401	5918	Tamberías
8402	5918	San Juan
8403	5919	Barrio Justo P. Castro IV
8404	5919	Bermejo
8405	5919	Caucete
8406	5919	Las Talas - Los Médanos
8407	5919	Marayes
8408	5919	Pie de Palo
8409	5919	Vallecito
8410	5919	Villa Independencia
8411	5920	Chimbas
8412	5921	Angualasto
8413	5921	Iglesia
8414	5921	Pismanta
8415	5921	Rodeo
8416	5921	Tudcum
8417	5922	El Médano
8418	5922	Gran China
8419	5922	Huaco
8420	5922	Mogna
8421	5922	Niquivil
8422	5922	Pampa Vieja
8423	5922	San José de Jáchal
8424	5922	Villa Malvinas Argentinas
8425	5922	Villa Mercedes
8426	5922	Alto de Sierra
8427	5922	Colonia Fiorito
8428	5923	Barrio Municipal
8429	5923	Barrio Ruta 40
8430	5923	Carpintería
8431	5923	Las Piedritas
8432	5923	Quinto Cuartel
8433	5923	Villa Aberastain (- La Rinconada)
8434	5923	Villa Barboza (- Villa Nacusi)
8435	5923	Villa Centenario
8436	5923	Rawson (Villa Krause)
8437	5923	Villa Bolaños (Médano de Oro)
8438	5923	Barrio Sadop (- Bella Vista)
8439	5923	Dos Acequias (Est. Los Angacos)
8440	5923	San Isidro (Est. Los Angacos)
8441	5923	Villa del Salvador
8442	5923	Villa Dominguito (Est. Puntilla Blanca)
8443	5923	Villa Don Bosco (Est. Angaco Sud)
8444	5923	Villa San Martín
8445	5924	Cañada Honda
8446	5924	Cienaguita
8447	5924	Colonia Fiscal
8448	5924	Divisadero
8449	5924	Guanacache
8450	5924	Las Lagunas
8451	5924	Los Berros
8452	5924	Punta del Médano
8453	5924	Villa Media Agua
8454	5925	Villa Ibáñez
8455	5926	Astica
8456	5926	Balde del Rosario
8457	5926	Chucuma
8458	5926	Los Baldecitos
8459	5926	Usno
8460	5926	Villa San Agustín
8461	5926	El Encón
8462	5926	Tupelí
8463	5926	Villa Borjas (- La Chimbera)
8464	5926	Villa El Tango
8465	5926	Villa Santa Rosa
8466	5927	Villa Basilio Nievas
8467	5927	Quines
8468	5927	San Francisco del Monte de Oro
8469	5928	Nogolí
8470	5928	Villa de la Quebrada
8471	5928	Villa General Roca
8472	5928	Concarán
8473	5928	Cortaderas
8474	5928	Naschel
8475	5928	Papagayos
8476	5928	Renca
8477	5928	Tilisarao
8478	5928	Villa Larca
8479	5928	El Trapiche
8480	5928	Estancia Grande
8481	5928	Fraga
8482	5928	La Toma
8483	5928	Río Grande
8484	5928	Riocito
8485	5929	Juan Jorba
8486	5929	Juan Llerena
8487	5929	Justo Daract
8488	5929	La Punilla
8489	5929	Lavaisse
8490	5929	Nación Ranquel
8491	5929	San José del Morro
8492	5929	Villa Reynolds
8493	5929	Villa Salles
8494	5930	Anchorena
8495	5930	Arizona
8496	5930	Bagual
8497	5930	Batavia
8498	5930	Buena Esperanza
8499	5930	Fortín El Patria
8500	5930	Fortuna
8501	5930	La Maroma
8502	5930	Los Overos
8503	5930	Martín de Loyola
8504	5930	Nahuel Mapá
8505	5930	Navia
8506	5930	Nueva Galia
8507	5930	Unión
8508	5930	Cerro de Oro
8509	5930	Lafinur
8510	5930	Los Cajones
8511	5930	Santa Rosa del Conlara
8512	5930	Talita
8513	5931	Alto Pelado
8514	5931	Alto Pencoso
8515	5931	Balde
8516	5931	Beazley
8517	5931	Cazador
8518	5931	Chosmes
8519	5931	El Volcán
8520	5931	Jarilla
8521	5931	Juana Koslay
8522	5931	La Punta
8523	5931	Mosmota
8524	5931	Potrero de los Funes
8525	5931	Salinas del Bebedero
8526	5931	San Jerónimo
8527	5931	San Luis
8528	5931	Zanjitas
8529	5931	La Vertiente
8530	5931	Las Aguadas
8531	5931	Paso Grande
8532	5931	Potrerillo
8533	5931	Villa de Praga
8534	5932	Comandante Luis Piedrabuena
8535	5932	Puerto Santa Cruz
8536	5933	Caleta Olivia
8537	5933	Cañadón Seco
8538	5933	Fitz Roy
8539	5933	Jaramillo
8540	5933	Koluel Kaike
8541	5933	Pico Truncado
8542	5933	Tellier
8543	5934	28 de Noviembre (Veintiocho de Noviembre)
8544	5934	El Turbio (Est. Gobernador Mayer)
8545	5934	Julia Dufour
8546	5934	Mina 3
8547	5934	Río Gallegos
8548	5934	Rospentek
8549	5934	Yacimientos Río Turbio
8550	5935	El Calafate
8551	5935	El Chaltén
8552	5935	Tres Lagos
8553	5936	Los Antiguos
8554	5936	Perito Moreno
8555	5937	Puerto San Julián
8556	5938	Bajo Caracoles
8557	5938	Gobernador Gregores
8558	5938	Armstrong
8559	5938	Bouquet
8560	5938	Las Parejas
8561	5938	Las Rosas
8562	5938	Montes de Oca
8563	5938	Tortugas
8564	5939	Arequito
8565	5939	Arteaga
8566	5939	Berabevú
8567	5939	Bigand
8568	5939	Casilda
8569	5939	Chabás
8570	5939	Chañar Ladeado
8571	5939	Gödeken
8572	5939	Los Nogales
8573	5939	Los Quirquinchos
8574	5939	San José de la Esquina
8575	5939	Sanford
8576	5939	Villada
8577	5940	Aldao (Est. Casablanca)
8578	5940	Angélica
8579	5940	Ataliva
8580	5940	Aurelia
8581	5940	Barrios Acapulco y Veracruz
8582	5940	Bauer y Sigel
8583	5940	Bella Italia
8584	5940	Castellanos
8585	5940	Colonia Bicha
8586	5940	Colonia Cello
8587	5940	Colonia Margarita
8588	5940	Colonia Raquel
8589	5940	Coronel Fraga
8590	5940	Egusquiza
8591	5940	Esmeralda
8592	5940	Estación Clucellas
8593	5940	Estación Saguier
8594	5940	Eusebia y Carolina
8595	5940	Eustolia
8596	5940	Frontera
8597	5940	Garibaldi
8598	5940	Humberto Primo
8599	5940	Josefina
8600	5940	Lehmann
8601	5940	María Juana
8602	5940	Nueva Lehmann
8603	5940	Plaza Clucellas
8604	5940	Plaza Saguier
8605	5940	Presidente Roca
8606	5940	Pueblo Marini
8607	5940	Rafaela
8608	5940	Ramona
8609	5940	Santa Clara de Saguier
8610	5940	Sunchales
8611	5940	Susana
8612	5940	Tacural
8613	5940	Vila
8614	5940	Villa Josefina
8615	5940	Virginia
8616	5940	Zenón Pereyra
8617	5941	Alcorta
8618	5941	Barrio Arroyo del Medio
8619	5941	Barrio Mitre
8620	5941	Bombal
8621	5941	Cañada Rica
8622	5941	Cepeda
8623	5941	Empalme Villa Constitución
8624	5941	Firmat
8625	5941	General Gelly
8626	5941	Godoy
8627	5941	Juan Bernabé Molina
8628	5941	Juncal
8629	5941	La Vanguardia
8630	5941	Máximo Paz (Est. Paz)
8631	5941	Pavón Arriba
8632	5941	Peyrano
8633	5941	Rueda
8634	5941	Sargento Cabral
8635	5941	Stephenson
8636	5941	Theobald
8637	5941	Villa Constitución
8638	5942	Cayastá
8639	5942	Helvecia
8640	5942	Los Zapallos
8641	5942	Saladero Mariano Cabal
8642	5942	Santa Rosa de Calchines
8643	5943	Aarón Castellanos (Est. Castellanos)
8644	5943	Amenábar
8645	5943	Cafferata
8646	5943	Cañada del Ucle
8647	5943	Carmen
8648	5943	Carreras
8649	5943	Chapuy
8650	5943	Chovet
8651	5943	Christophersen
8652	5943	Diego de Alvear
8653	5943	Elortondo
8654	5943	Hughes
8655	5943	La Chispa
8656	5943	Labordeboy
8657	5943	Lazzarino
8658	5943	Maggiolo
8659	5943	María Teresa
8660	5943	Melincué (Est. San Urbano)
8661	5943	Miguel Torres
8662	5943	Murphy
8663	5943	Rufino
8664	5943	San Eduardo
8665	5943	San Francisco de Santa Fe
8666	5943	San Gregorio
8667	5943	Sancti Spiritu
8668	5943	Teodelina
8669	5943	Venado Tuerto
8670	5943	Villa Cañás
8671	5943	Wheelwright
8672	5944	Arroyo Ceibal
8673	5944	Avellaneda (Est. Ewald)
8674	5944	Berna
8675	5944	El Arazá
8676	5944	El Rabón
8677	5944	Florencia
8678	5944	Guadalupe Norte
8679	5944	Ingeniero Chanourdie
8680	5944	La Isleta
8681	5944	La Sarita
8682	5944	Lanteri
8683	5944	Las Garzas
8684	5944	Los Laureles
8685	5944	Malabrigo
8686	5944	Paraje San Manuel
8687	5944	Puerto Reconquista
8688	5944	Reconquista
8689	5944	San Antonio de Obligado
8690	5944	Tacuarendí (Emb. Kilómetro 421)
8691	5944	Villa Ana
8692	5944	Villa Guillermina
8693	5944	Villa Ocampo
8694	5945	Barrio Cicarelli
8695	5945	Bustinza
8696	5945	Cañada de Gómez
8697	5945	Carrizales (Est. Clarke)
8698	5945	Classon
8699	5945	Colonia Médici
8700	5945	Correa
8701	5945	Larguía
8702	5945	Lucio V. López
8703	5945	Oliveros
8704	5945	Pueblo Andino
8705	5945	Salto Grande
8706	5945	Serodino
8707	5945	Totoras
8708	5945	Villa Eloísa
8709	5945	Villa la Rivera (Comuna Oliveros) (Villa La Ribera)
8710	5945	Villa la Rivera (Comuna Pueblo Andino) (Villa La Ribera)
8711	5945	Ángel Gallardo
8712	5945	Arroyo Aguiar
8713	5945	Arroyo Leyes
8714	5945	Cabal
8715	5945	Campo Andino
8716	5945	Candioti
8717	5945	Emilia
8718	5945	Laguna Paiva
8719	5945	Llambi Campbell
8720	5945	Monte Vera
8721	5945	Nelson
8722	5945	Paraje Chaco Chico
8723	5945	Paraje La Costa
8724	5945	Rincón Potrero
8725	5945	San José del Rincón
8726	5945	Santa Fe
8727	5945	Sauce Viejo
8728	5945	Villa Laura (Est. Constituyentes)
8729	5946	Cavour
8730	5946	Cululú
8731	5946	Elisa
8732	5946	Empalme San Carlos
8733	5946	Esperanza
8734	5946	Felicia
8735	5946	Franck
8736	5946	Grutly
8737	5946	Hipatia
8738	5946	Humboldt
8739	5946	Jacinto L. Aráuz
8740	5946	La Pelada
8741	5946	María Luisa
8742	5946	Matilde
8743	5946	Nuevo Torino
8744	5946	Plaza Matilde
8745	5946	Progreso
8746	5946	Providencia
8747	5946	Sa Pereira
8748	5946	San Carlos Centro
8749	5946	San Carlos Norte
8750	5946	San Carlos Sud
8751	5946	San Jerónimo del Sauce
8752	5946	San Jerónimo Norte
8753	5946	San Mariano
8754	5946	Santa Clara de Buena Vista
8755	5946	Esteban Rams
8756	5946	Gato Colorado
8757	5946	Gregoria Pérez de Denis (Est. El Nochero)
8758	5946	Logroño
8759	5946	Montefiore
8760	5946	Pozo Borrado
8761	5946	Santa Margarita
8762	5946	Tostado
8763	5946	Villa Minetti
8764	5947	Acebal
8765	5947	Albarellos
8766	5947	Álvarez
8767	5947	Arbilla
8768	5947	Arminda
8769	5947	Arroyo Seco
8770	5947	Carmen del Sauce
8771	5947	Coronel Bogado
8772	5947	Coronel Rodolfo S. Domínguez
8773	5947	Cuatro Esquinas
8774	5947	El Caramelo
8775	5947	Fighiera
8776	5947	Funes
8777	5947	General Lagos
8778	5947	Granadero Baigorria
8779	5947	Ibarlucea
8780	5947	Kilómetro 101
8781	5947	Los Muchachos - La Alborada
8782	5947	Monte Flores
8783	5947	Pérez
8784	5947	Piñero (Est. Erasto)
8785	5947	Pueblo Esther
8786	5947	Pueblo Muñoz (Est. Bernard)
8787	5947	Pueblo Uranga
8788	5947	Puerto Arroyo Seco
8789	5947	Rosario
8790	5947	Soldini
8791	5947	Villa Amelia
8792	5947	Villa del Plata
8793	5947	Villa Gobernador Gálvez
8794	5947	Zavalla
8795	5948	Aguará Grande
8796	5948	Ambrosetti
8797	5948	Arrufó
8798	5948	Balneario La Verde
8799	5948	Capivara
8800	5948	Ceres
8801	5948	Colonia Ana
8802	5948	Colonia Bossi
8803	5948	Colonia Rosa
8804	5948	Constanza
8805	5948	Curupaytí
8806	5948	Hersilia
8807	5948	Huanqueros
8808	5948	La Cabral
8809	5948	La Lucila
8810	5948	La Rubia
8811	5948	Las Avispas
8812	5948	Las Palmeras
8813	5948	Moisés Ville
8814	5948	Monigotes
8815	5948	Ñanducita
8816	5948	Palacios
8817	5948	San Cristóbal
8818	5948	San Guillermo
8819	5948	Santurce
8820	5948	Soledad
8821	5948	Suardi
8822	5948	Villa Saralegui
8823	5948	Villa Trinidad
8824	5948	Alejandra
8825	5948	Cacique Ariacaiquín
8826	5948	Colonia Durán
8827	5948	La Brava
8828	5948	Romang
8829	5949	Arocena
8830	5949	Balneario Monje
8831	5949	Barrio Caima
8832	5949	Barrio El Pacaá - Barrio Comipini
8833	5949	Bernardo de Irigoyen (Est. Irigoyen)
8834	5949	Casalegno
8835	5949	Centeno
8836	5949	Coronda
8837	5949	Desvío Arijón
8838	5949	Díaz
8839	5949	Gaboto
8840	5949	Gálvez
8841	5949	Gessler
8842	5949	Irigoyen
8843	5949	Larrechea
8844	5949	Loma Alta
8845	5949	López (Est. San Martín de Tours)
8846	5949	Maciel
8847	5949	Monje
8848	5949	Puerto Aragón
8849	5949	San Eugenio
8850	5949	San Fabián
8851	5949	San Genaro
8852	5949	San Genaro Norte
8853	5949	Angeloni
8854	5949	Cayastacito
8855	5949	Colonia Dolores
8856	5949	Esther
8857	5949	Gobernador Crespo
8858	5949	La Criolla (Est. Cañadita)
8859	5949	La Penca y Caraguatá
8860	5949	Marcelino Escalada
8861	5949	Naré
8862	5949	Pedro Gómez Cello
8863	5949	Ramayón
8864	5949	San Justo
8865	5949	San Martín Norte
8866	5949	Silva (Est. Abipones)
8867	5949	Vera y Pintado (Est. Guaraníes)
8868	5949	Videla
8869	5949	Aldao
8870	5949	Capitán Bermúdez
8871	5949	Carcarañá
8872	5949	Coronel Arnold
8873	5949	Fuentes
8874	5949	Luis Palacios (Est. La Salada)
8875	5949	Puerto General San Martín
8876	5949	Pujato
8877	5949	Ricardone
8878	5949	Roldán
8879	5949	San Jerónimo Sud
8880	5949	Timbúes
8881	5949	Villa Elvira
8882	5949	Villa Mugueta
8883	5949	Cañada Rosquín
8884	5949	Carlos Pellegrini
8885	5949	Casas
8886	5949	Castelar
8887	5949	Colonia Belgrano
8888	5949	Crispi
8889	5949	El Trébol
8890	5949	Landeta
8891	5949	Las Bandurrias
8892	5949	Las Petacas
8893	5949	Los Cardos
8894	5949	María Susana
8895	5949	Piamonte
8896	5949	San Jorge
8897	5949	San Martín de las Escobas
8898	5949	Sastre
8899	5949	Traill
8900	5949	Wildermuth (Est. Granadero B. Bustos)
8901	5950	Calchaquí
8902	5950	Cañada Ombú
8903	5950	Colmena
8904	5950	Fortín Olmos
8905	5950	Garabato
8906	5950	Golondrina
8907	5950	Intiyaco
8908	5950	Kilómetro 115
8909	5950	La Gallareta
8910	5950	Los Amores
8911	5950	Margarita
8912	5950	Paraje 29
8913	5950	Pozo de los Indios
8914	5950	Pueblo Santa Lucía
8915	5950	Tartagal (Est. El Tajamar)
8916	5950	Toba
8917	5950	Vera (Est. Gobernador Vera)
8918	5951	Argentina
8919	5951	Casares
8920	5951	Malbrán
8921	5951	Villa General Mitre (Est. Pinto)
8922	5952	Campo Gallo
8923	5952	Coronel Manuel L. Rico
8924	5952	Donadeu
8925	5952	Sacháyoj
8926	5952	Santos Lugares
8927	5953	Estación Atamisqui
8928	5953	Medellín
8929	5953	Villa Atamisqui
8930	5953	Colonia Dora
8931	5953	Lugones
8932	5953	Real Sayana
8933	5953	Villa Mailín
8934	5954	Abra Grande
8935	5954	Antajé
8936	5954	Ardiles
8937	5954	Cañada Escobar
8938	5954	Chaupi Pozo
8939	5954	Clodomira
8940	5954	Huyamampa
8941	5954	La Aurora
8942	5954	La Dársena
8943	5954	Los Quiroga
8944	5954	Los Soria
8945	5954	Tramo 16
8946	5954	Tramo 20
8947	5954	Bandera
8948	5954	Cuatro Bocas
8949	5954	Fortín Inca
8950	5954	Guardia Escolta
8951	5954	El Deán
8952	5954	El Mojón
8953	5954	El Zanjón
8954	5954	Los Cardozos
8955	5954	Maco
8956	5954	Maquito
8957	5954	Morales
8958	5954	Puesto de San Antonio
8959	5954	Santiago del Estero
8960	5954	Vuelta de la Barranca
8961	5954	Yanda
8962	5955	Ancaján
8963	5955	Estación La Punta
8964	5955	Frías
8965	5955	Villa La Punta
8966	5956	El Caburé
8967	5956	La Firmeza
8968	5956	Los Pirpintos
8969	5956	Los Tigres
8970	5956	Monte Quemado
8971	5956	Nueva Esperanza
8972	5956	Pampa de los Guanacos
8973	5956	San José del Boquerón
8974	5956	Urutaú
8975	5957	Bandera Bajada
8976	5957	Caspi Corral
8977	5957	Colonia San Juan
8978	5957	El Crucero
8979	5957	Kilómetro 30
8980	5957	La Cañada
8981	5957	La Invernada
8982	5957	Minerva
8983	5957	Vaca Huañuna
8984	5957	Villa Figueroa
8985	5958	Añatuya
8986	5958	Averías
8987	5958	Estación Tacañitas
8988	5958	La Nena
8989	5958	Los Juríes
8990	5958	Tomás Young
8991	5960	El Arenal
8992	5960	El Bobadal
8993	5960	El Charco
8994	5960	Gramilla
8995	5960	Isca Yacu
8996	5960	Isca Yacu Semaul
8997	5960	Pozo Hondo
8998	5961	El Cuadrado
8999	5961	Matará
9000	5961	Suncho Corral
9001	5961	Vilelas
9002	5961	Yuchán
9003	5962	Villa San Martín (Est. Loreto)
9004	5963	Aerolito
9005	5963	Alhuampa
9006	5963	Hasse
9007	5963	Hernán Mejía Miraval
9008	5963	Las Tinajas
9009	5963	Lilo Viejo
9010	5963	Patay
9011	5963	Pueblo Pablo Torelo (Est. Otumpa)
9012	5963	Quimilí
9013	5963	Roversi
9014	5963	Tintina
9015	5963	Weisburd
9016	5964	El 49
9017	5964	Sol de Julio
9018	5964	Villa Ojo de Agua
9019	5964	Las Delicias
9020	5964	Pozo Betbeder
9021	5964	Rapelli
9022	5965	Ramírez de Velazco
9023	5965	Sumampa
9024	5965	Sumampa Viejo
9025	5966	Chañar Pozo de Abajo
9026	5966	Chauchillas
9027	5966	Colonia Tinco
9028	5966	La Nueva Donosa
9029	5966	Los Miranda
9030	5966	Los Núñez
9031	5966	Mansupa
9032	5966	Pozuelos
9033	5966	Rodeo de Valdez
9034	5966	Termas de Río Hondo
9035	5966	Villa Giménez
9036	5966	Villa Río Hondo
9037	5966	Villa Turística del Embalse
9038	5966	Vinará
9039	5966	Colonia Alpina
9040	5966	Palo Negro
9041	5966	Selva
9042	5967	Beltrán
9043	5967	Colonia El Simbolar
9044	5967	Fernández
9045	5967	Ingeniero Forres (Est. Chaguar Punco)
9046	5967	Vilmer
9047	5968	Chilca Juliana
9048	5968	Los Telares
9049	5968	Villa Salavina
9050	5968	Brea Pozo
9051	5968	Estación Robles
9052	5968	Estación Taboada
9053	5968	Garza
9054	5969	Árraga
9055	5969	Nueva Francia
9056	5969	Simbol
9057	5969	Sumamao
9058	5969	Villa Silípica
9059	5970	Tolhuin
9060	5971	Laguna Escondida
9061	5971	Ushuaia
9062	5972	7 de Abril (Siete de Abril)
9063	5972	Barrio San Jorge
9064	5972	El Chañar
9065	5972	Garmendia
9066	5972	Macomitas
9067	5972	Piedrabuena
9068	5972	Villa Benjamín Aráoz
9069	5972	Villa Burruyacú
9070	5972	Villa Padre Monti
9071	5972	San Miguel de Tucumán (Est. Tucumán)
9072	5973	Arcadia
9073	5973	Barrio San Roque
9074	5973	Iltico
9075	5973	Medinas
9076	5974	Alderetes
9077	5974	Banda del Río Salí
9078	5974	Colombres
9079	5974	Colonia Mayo - Barrio La Milagrosa
9080	5974	Delfín Gallo
9081	5974	El Bracho
9082	5974	Las Cejas
9083	5974	Los Ralos
9084	5974	Ranchillos
9085	5974	San Andrés
9086	5975	Barrio Casa Rosada
9087	5975	Campo de Herrera
9088	5975	Famaillá
9089	5975	Ingenio Fronterita
9090	5976	Graneros
9091	5976	Taco Ralo
9092	5977	Juan Bautista Alberdi
9093	5977	Villa Belgrano
9094	5978	La Cocha
9095	5978	San José de La Cocha
9096	5979	Estación Aráoz
9097	5979	Los Puestos
9098	5979	Manuel García Fernández
9099	5979	Pala Pala
9100	5979	Santa Rosa de Leales
9101	5979	Villa de Leales
9102	5979	Villa Fiad (- Ingenio Leales)
9103	5980	Barrio San Felipe
9104	5980	El Manantial
9105	5980	Ingenio San Pablo
9106	5980	La Reducción
9107	5980	Lules
9108	5981	Acheral
9109	5981	Capitán Cáceres
9110	5981	Monteros
9111	5981	Pueblo Independencia (Santa Rosa y Los Rojo)
9112	5981	Río Seco
9113	5981	Sargento Moya
9114	5981	Soldado Maldonado
9115	5981	Teniente Berdina
9116	5981	Villa Quinteros
9117	5981	Aguilares
9118	5981	Los Sarmientos
9119	5981	Río Chico
9120	5981	Villa Clodomiro Hileret
9121	5982	Monteagudo
9122	5982	Nueva Trinidad
9123	5982	Simoca
9124	5982	Villa Chicligasta
9125	5983	Amaicha del Valle
9126	5983	Colalao del Valle
9127	5983	El Mollar
9128	5983	Tafí del Valle
9129	5984	Barrio El Cruce
9130	5984	Barrio Lomas de Tafí
9131	5984	Barrio Mutual San Martín
9132	5984	Barrio Parada 14
9133	5984	Barrio U.T.A. II
9134	5984	Diagonal Norte (- Luz y Fuerza - Los Pocitos - Villa Nueva Italia)
9135	5984	El Cadillal
9136	5984	Tafí Viejo
9137	5984	Villa Las Flores
9138	5984	Villa Mariano Moreno (- El Colmenar)
9139	5985	Choromoro
9140	5985	San Pedro de Colalao
9141	5985	Villa de Trancas
9142	5986	Barrio San José III
9143	5986	Villa Carmela (Cebil Redondo)
0	0	No Determinado
\.


--
-- TOC entry 2609 (class 0 OID 33514)
-- Dependencies: 242
-- Data for Name: estadocivil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estadocivil (idestadocivil, descripcion) FROM stdin;
1	Soltero(a)
2	Casado(a)
3	Conviviente
4	Viudo(a)
5	Divorciado(a)
0	No Determinado
\.


--
-- TOC entry 2611 (class 0 OID 33520)
-- Dependencies: 244
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
0	No Determinado
\.


--
-- TOC entry 2613 (class 0 OID 33526)
-- Dependencies: 246
-- Data for Name: idiomas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idiomas (idioma_id, idioma_codigo, idioma_descripcion, estado, por_defecto) FROM stdin;
1	es        	Español	A	S
2	en        	Inglés	A	N
\.


--
-- TOC entry 2615 (class 0 OID 33533)
-- Dependencies: 248
-- Data for Name: nivel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nivel (idnivel, descripcion, estado, idtipocargo) FROM stdin;
1	ASOCIACIÓN GENERAL	1	2
2	DIVISIÓN	1	2
4	UNIÓN	1	2
8	ASOCIACION GENERAL	1	1
6	DISTRITO MISIONERO	0	2
5	ASOCIACIÓN	1	2
9	DIVISIÓN	1	1
11	UNIÓN	1	1
12	ASOCIACIÓN	1	1
13	DISTRITO MISIONERO	0	1
14	IGLESIA	1	1
7	IGLESIA	1	2
10	PAÍS	0	1
3	PAIS	0	2
\.


--
-- TOC entry 2617 (class 0 OID 33539)
-- Dependencies: 250
-- Data for Name: ocupacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ocupacion (idocupacion, descripcion) FROM stdin;
2	Albañil
4	Carpintero
5	Chofer
6	Colportor
7	Comerciante
12	Estudiante
13	Evanista
14	Fisioterapia
15	Independiente
16	Ingeniero
17	Masoterapia
18	Mecánico
19	Medico
21	Modista
23	Otro
24	Panadero
25	Pastor
26	Peluquero
27	Periodista
29	Sastre
30	Su Casa
31	Zapatero
33	Agricultor
1	Abogado
3	Campesino
8	Desocupado
9	Empleado
10	Empresario
11	Enfermera
28	Profesor
32	Contador
0	No Determinado
22	Obrero Misionero
\.


--
-- TOC entry 2619 (class 0 OID 33545)
-- Dependencies: 252
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
33	Portugal
34	Puerto Rico
35	Republica Dominicana
36	Rusia
37	Uruguay
38	Venezuela
32	Perú
0	No Determinado
\.


--
-- TOC entry 2621 (class 0 OID 33551)
-- Dependencies: 254
-- Data for Name: parentesco; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parentesco (idparentesco, descripcion, estado) FROM stdin;
1	Esposo(a)	1
2	Hijo(a)	1
3	Tío(a)	1
4	Papá	1
5	Mamá	1
6	Abuelo(a)	1
7	Sobrino(a)	1
8	Suegro(a)	1
9	Yerno	1
10	Nuera	1
11	Nieto(a)	1
12	Hermano(a)	1
13	Cuñado(a)	1
\.


--
-- TOC entry 2623 (class 0 OID 33557)
-- Dependencies: 256
-- Data for Name: procesos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.procesos (proceso_id, proceso_total_elementos_procesar, proceso_numero_elementos_procesados, proceso_porcentaje_actual_progreso, proceso_fecha_comienzo, proceso_fecha_actualizacion, proceso_tiempo_transcurrido) FROM stdin;
\.


--
-- TOC entry 2625 (class 0 OID 33562)
-- Dependencies: 258
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
203	32	Arica
204	32	Parinacota
205	33	Iquique
206	33	Tamarugal
207	34	Antofagasta
208	34	El Loa
209	34	Tocopilla
210	35	Copiapó
211	35	Chañaral
212	35	Huasco
213	36	Elqui
214	36	Choapa
215	36	Limarí
216	37	Valparaíso
217	37	Isla de Pascua
218	37	Los Andes
219	37	Petorca
220	37	Quillota
221	37	San Antonio
222	37	San Felipe de Aconcagua
223	37	Marga Marga
224	38	Cachapoal
225	38	Cardenal Caro
226	38	Colchagua
227	39	Talca
228	39	Cauquenes
229	39	Curicó
230	39	Linares
231	40	Concepción
232	40	Arauco
233	40	Biobío
234	40	Ñuble
235	41	Cautín
236	41	Malleco
237	42	Valdivia
238	42	Ranco
239	43	Llanquihue
240	43	Chiloé
241	43	Osorno
242	43	Palena
243	44	Coihaique
244	44	Aisén
245	44	Capitán Prat
246	44	General Carrera
247	45	Magallanes
248	45	Antártica Chilena
249	45	Tierra del Fuego
250	45	Última Esperanza
251	46	Santiago
252	46	Cordillera
253	46	Chacabuco
254	46	Maipo
255	46	Melipilla
256	46	Talagante
257	47	MEDELLIN
258	47	ABEJORRAL
259	47	ABRIAQUI
260	47	ALEJANDRIA
261	47	AMAGA
262	47	AMALFI
263	47	ANDES
264	47	ANGELOPOLIS
265	47	ANGOSTURA
266	47	ANORI
267	47	ANTIOQUIA
268	47	ANZA
269	47	APARTADO
270	47	ARBOLETES
271	47	ARGELIA
272	47	ARMENIA
273	47	BARBOSA
274	47	BELMIRA
275	47	BELLO
276	47	BETANIA
277	47	BETULIA
278	47	BOLIVAR
279	47	BRICEÑO
280	47	BURITICA
281	47	CACERES
282	47	CAICEDO
283	47	CALDAS
284	47	CAMPAMENTO
285	47	CAÑASGORDAS
286	47	CARACOLI
287	47	CARAMANTA
288	47	CAREPA
289	47	CARMEN DE VIBORAL
290	47	CAROLINA
291	47	CAUCASIA
292	47	CHIGORODO
293	47	CISNEROS
294	47	COCORNA
295	47	CONCEPCION
296	47	CONCORDIA
297	47	COPACABANA
298	47	DABEIBA
299	47	DON MATIAS
300	47	EBEJICO
301	47	EL BAGRE
302	47	ENTRERRIOS
303	47	ENVIGADO
304	47	FREDONIA
305	47	FRONTINO
306	47	GIRALDO
307	47	GIRARDOTA
308	47	GOMEZ PLATA
309	47	GRANADA
310	47	GUADALUPE
311	47	GUARNE
312	47	GUATAPE
313	47	HELICONIA
314	47	HISPANIA
315	47	ITAGUI
316	47	ITUANGO
317	47	JARDIN
318	47	JERICO
319	47	LA CEJA
320	47	LA ESTRELLA
321	47	LA PINTADA
322	47	LA UNION
323	47	LIBORINA
324	47	MACEO
325	47	MARINILLA
326	47	MONTEBELLO
327	47	MURINDO
328	47	MUTATA
329	47	NARIÑO
330	47	NECOCLI
331	47	NECHI
332	47	OLAYA
333	47	PEÑOL
334	47	PEQUE
335	47	PUEBLORRICO
336	47	PUERTO BERRIO
337	47	PUERTO NARE (LA MAGDALENA)
338	47	PUERTO TRIUNFO
339	47	REMEDIOS
340	47	RETIRO
341	47	RIONEGRO
342	47	SABANALARGA
343	47	SABANETA
344	47	SALGAR
345	47	SAN ANDRES
346	47	SAN CARLOS
347	47	SAN FRANCISCO
348	47	SAN JERONIMO
349	47	SAN JOSE DE LA MONTAÑA
350	47	SAN JUAN DE URABA
351	47	SAN LUIS
352	47	SAN PEDRO
353	47	SAN PEDRO DE URABA
354	47	SAN RAFAEL
355	47	SAN ROQUE
356	47	SAN VICENTE
357	47	SANTA BARBARA
358	47	SANTA ROSA DE OSOS
359	47	SANTO DOMINGO
360	47	SANTUARIO
361	47	SEGOVIA
362	47	SONSON
363	47	SOPETRAN
364	47	TAMESIS
365	47	TARAZA
366	47	TARSO
367	47	TITIRIBI
368	47	TOLEDO
369	47	TURBO
370	47	URAMITA
371	47	URRAO
372	47	VALDIVIA
373	47	VALPARAISO
374	47	VEGACHI
375	47	VENECIA
376	47	VIGIA DEL FUERTE
377	47	YALI
378	47	YARUMAL
379	47	YOLOMBO
380	47	YONDO
381	47	ZARAGOZA
382	48	BARRANQUILLA (DISTRITO ESPECIAL, INDUSTRIAL Y PORTUARIO DE BARRANQUILLA)
383	48	BARANOA
384	48	CAMPO DE LA CRUZ
385	48	CANDELARIA
386	48	GALAPA
387	48	JUAN DE ACOSTA
388	48	LURUACO
389	48	MALAMBO
390	48	MANATI
391	48	PALMAR DE VARELA
392	48	PIOJO
393	48	POLO NUEVO
394	48	PONEDERA
395	48	PUERTO COLOMBIA
396	48	REPELON
397	48	SABANAGRANDE
398	48	SANTA LUCIA
399	48	SANTO TOMAS
400	48	SOLEDAD
401	48	SUAN
402	48	TUBARA
403	48	USIACURI
404	49	SANTA FE DE BOGOTA, D. C.
405	49	SANTAFE DE BOGOTA D.C.- USAQUEN
406	49	SANTAFE DE BOGOTA D.C.- CHAPINERO
407	49	SANTAFE DE BOGOTA D.C.- SANTA FE
408	49	SANTAFE DE BOGOTA D.C.- SAN CRISTOBAL
409	49	SANTAFE DE BOGOTA D.C.- USME
410	49	SANTAFE DE BOGOTA D.C.- TUNJUELITO
411	49	SANTAFE DE BOGOTA D.C.- BOSA
412	49	SANTAFE DE BOGOTA D.C.- KENNEDY
413	49	SANTAFE DE BOGOTA D.C.- FONTIBON
414	49	SANTAFE DE BOGOTA D.C.- ENGATIVA
415	49	SANTAFE DE BOGOTA D.C.- SUBA
416	49	SANTAFE DE BOGOTA D.C.- BARRIOS UNIDOS
417	49	SANTAFE DE BOGOTA D.C.- TEUSAQUILLO
418	49	SANTAFE DE BOGOTA D.C.- MARTIRES
419	49	SANTAFE DE BOGOTA D.C.- ANTONIO NARIÑO
420	49	SANTAFE DE BOGOTA D.C.- PUENTE ARANDA
421	49	SANTAFE DE BOGOTA D.C.- CANDELARIA
422	49	SANTAFE DE BOGOTA D.C.- RAFAEL URIBE
423	49	SANTAFE DE BOGOTA D.C.- CIUDAD BOLIVAR
424	49	SANTAFE DE BOGOTA D.C.- SUMAPAZ
425	50	CARTAGENA (DISTRITO TURISTICO Y CULTURAL DE CARTAGENA)
426	50	ACHI
427	50	ALTOS DEL ROSARIO
428	50	ARENAL
429	50	ARJONA
430	50	ARROYOHONDO
431	50	BARRANCO DE LOBA
432	50	CALAMAR
433	50	CANTAGALLO
434	50	CICUCO
435	50	CORDOBA
436	50	CLEMENCIA
437	50	EL CARMEN DE BOLIVAR
438	50	EL GUAMO
439	50	EL PEÑON
440	50	HATILLO DE LOBA
441	50	MAGANGUE
442	50	MAHATES
443	50	MARGARITA
444	50	MARIA LA BAJA
445	50	MONTECRISTO
446	50	MOMPOS
447	50	MORALES
448	50	PINILLOS
449	50	REGIDOR
450	50	RIO VIEJO
451	50	SAN CRISTOBAL
452	50	SAN ESTANISLAO
453	50	SAN FERNANDO
454	50	SAN JACINTO
455	50	SAN JACINTO DEL CAUCA
456	50	SAN JUAN NEPOMUCENO
457	50	SAN MARTIN DE LOBA
458	50	SAN PABLO
459	50	SANTA CATALINA
460	50	SANTA ROSA
461	50	SANTA ROSA DEL SUR
462	50	SIMITI
463	50	SOPLAVIENTO
464	50	TALAIGUA NUEVO
465	50	TIQUISIO (PUERTO RICO)
466	50	TURBACO
467	50	TURBANA
468	50	VILLANUEVA
469	50	ZAMBRANO
470	51	TUNJA
471	51	ALMEIDA
472	51	AQUITANIA
473	51	ARCABUCO
474	51	BELEN
475	51	BERBEO
476	51	BETEITIVA
477	51	BOAVITA
478	51	BOYACA
479	51	BUENAVISTA
480	51	BUSBANZA
481	51	CAMPOHERMOSO
482	51	CERINZA
483	51	CHINAVITA
484	51	CHIQUINQUIRA
485	51	CHISCAS
486	51	CHITA
487	51	CHITARAQUE
488	51	CHIVATA
489	51	CIENEGA
490	51	COMBITA
491	51	COPER
492	51	CORRALES
493	51	COVARACHIA
494	51	CUBARA
495	51	CUCAITA
496	51	CUITIVA
497	51	CHIQUIZA
498	51	CHIVOR
499	51	DUITAMA
500	51	EL COCUY
501	51	EL ESPINO
502	51	FIRAVITOBA
503	51	FLORESTA
504	51	GACHANTIVA
505	51	GAMEZA
506	51	GARAGOA
507	51	GUACAMAYAS
508	51	GUATEQUE
509	51	GUAYATA
510	51	GUICAN
511	51	IZA
512	51	JENESANO
513	51	LABRANZAGRANDE
514	51	LA CAPILLA
515	51	LA VICTORIA
516	51	LA UVITA
517	51	VILLA DE LEIVA
518	51	MACANAL
519	51	MARIPI
520	51	MIRAFLORES
521	51	MONGUA
522	51	MONGUI
523	51	MONIQUIRA
524	51	MOTAVITA
525	51	MUZO
526	51	NOBSA
527	51	NUEVO COLON
528	51	OICATA
529	51	OTANCHE
530	51	PACHAVITA
531	51	PAEZ
532	51	PAIPA
533	51	PAJARITO
534	51	PANQUEBA
535	51	PAUNA
536	51	PAYA
537	51	PAZ DEL RIO
538	51	PESCA
539	51	PISBA
540	51	PUERTO BOYACA
541	51	QUIPAMA
542	51	RAMIRIQUI
543	51	RAQUIRA
544	51	RONDON
545	51	SABOYA
546	51	SACHICA
547	51	SAMACA
548	51	SAN EDUARDO
549	51	SAN JOSE DE PARE
550	51	SAN LUIS DE GACENO
551	51	SAN MATEO
552	51	SAN MIGUEL DE SEMA
553	51	SAN PABLO DE BORBUR
554	51	SANTANA
555	51	SANTA MARIA
556	51	SANTA ROSA DE VITERBO
557	51	SANTA SOFIA
558	51	SATIVANORTE
559	51	SATIVASUR
560	51	SIACHOQUE
561	51	SOATA
562	51	SOCOTA
563	51	SOCHA
564	51	SOGAMOSO
565	51	SOMONDOCO
566	51	SORA
567	51	SOTAQUIRA
568	51	SORACA
569	51	SUSACON
570	51	SUTAMARCHAN
571	51	SUTATENZA
572	51	TASCO
573	51	TENZA
574	51	TIBANA
575	51	TIBASOSA
576	51	TINJACA
577	51	TIPACOQUE
578	51	TOCA
579	51	TOGUI
580	51	TOPAGA
581	51	TOTA
582	51	TUNUNGUA
583	51	TURMEQUE
584	51	TUTA
585	51	TUTASA
586	51	UMBITA
587	51	VENTAQUEMADA
588	51	VIRACACHA
589	51	ZETAQUIRA
590	52	MANIZALES
591	52	AGUADAS
592	52	ANSERMA
593	52	ARANZAZU
594	52	BELALCAZAR
595	52	CHINCHINA
596	52	FILADELFIA
597	52	LA DORADA
598	52	LA MERCED
599	52	MANZANARES
600	52	MARMATO
601	52	MARQUETALIA
602	52	MARULANDA
603	52	NEIRA
604	52	NORCASIA
605	52	PACORA
606	52	PALESTINA
607	52	PENSILVANIA
608	52	RIOSUCIO
609	52	RISARALDA
610	52	SALAMINA
611	52	SAMANA
612	52	SAN JOSE
613	52	SUPIA
614	52	VICTORIA
615	52	VILLAMARIA
616	52	VITERBO
617	53	FLORENCIA
618	53	ALBANIA
619	53	BELEN DE LOS ANDAQUIES
620	53	CARTAGENA DEL CHAIRA
621	53	CURILLO
622	53	EL DONCELLO
623	53	EL PAUJIL
624	53	LA MONTAÑITA
625	53	MILAN
626	53	MORELIA
627	53	PUERTO RICO
628	53	SAN JOSE DE FRAGUA
629	53	SAN  VICENTE DEL CAGUAN
630	53	SOLANO
631	53	SOLITA
632	54	POPAYAN
633	54	ALMAGUER
634	54	BALBOA
635	54	BUENOS AIRES
636	54	CAJIBIO
637	54	CALDONO
638	54	CALOTO
639	54	CORINTO
640	54	EL TAMBO
641	54	GUAPI
642	54	INZA
643	54	JAMBALO
644	54	LA SIERRA
645	54	LA VEGA
646	54	LOPEZ (MICAY)
647	54	MERCADERES
648	54	MIRANDA
649	54	PADILLA
650	54	PAEZ (BELALCAZAR)
651	54	PATIA (EL BORDO)
652	54	PIAMONTE
653	54	PIENDAMO
654	54	PUERTO TEJADA
655	54	PURACE (COCONUCO)
656	54	ROSAS
657	54	SAN SEBASTIAN
658	54	SANTANDER DE QUILICHAO
659	54	SILVIA
660	54	SOTARA (PAISPAMBA)
661	54	SUAREZ
662	54	TIMBIO
663	54	TIMBIQUI
664	54	TORIBIO
665	54	TOTORO
666	54	VILLARICA
667	55	VALLEDUPAR
668	55	AGUACHICA
669	55	AGUSTIN CODAZZI
670	55	ASTREA
671	55	BECERRIL
672	55	BOSCONIA
673	55	CHIMICHAGUA
674	55	CHIRIGUANA
675	55	CURUMANI
676	55	EL COPEY
677	55	EL PASO
678	55	GAMARRA
679	55	GONZALEZ
680	55	LA GLORIA
681	55	LA JAGUA IBIRICO
682	55	MANAURE (BALCON DEL CESAR)
683	55	PAILITAS
684	55	PELAYA
685	55	PUEBLO BELLO
686	55	RIO DE ORO
687	55	LA PAZ (ROBLES)
688	55	SAN ALBERTO
689	55	SAN DIEGO
690	55	SAN MARTIN
691	55	TAMALAMEQUE
692	56	MONTERIA
693	56	AYAPEL
694	56	CANALETE
695	56	CERETE
696	56	CHIMA
697	56	CHINU
698	56	CIENAGA DE ORO
699	56	COTORRA
700	56	LA APARTADA
701	56	LORICA
702	56	LOS CORDOBAS
703	56	MOMIL
704	56	MONTELIBANO
705	56	MOÑITOS
706	56	PLANETA RICA
707	56	PUEBLO NUEVO
708	56	PUERTO ESCONDIDO
709	56	PUERTO LIBERTADOR
710	56	PURISIMA
711	56	SAHAGUN
712	56	SAN ANDRES SOTAVENTO
713	56	SAN ANTERO
714	56	SAN BERNARDO DEL VIENTO
715	56	SAN PELAYO
716	56	TIERRALTA
717	56	VALENCIA
718	57	AGUA DE DIOS
719	57	ALBAN
720	57	ANAPOIMA
721	57	ANOLAIMA
722	57	ARBELAEZ
723	57	BELTRAN
724	57	BITUIMA
725	57	BOJACA
726	57	CABRERA
727	57	CACHIPAY
728	57	CAJICA
729	57	CAPARRAPI
730	57	CAQUEZA
731	57	CARMEN DE CARUPA
732	57	CHAGUANI
733	57	CHIA
734	57	CHIPAQUE
735	57	CHOACHI
736	57	CHOCONTA
737	57	COGUA
738	57	COTA
739	57	CUCUNUBA
740	57	EL COLEGIO
741	57	EL ROSAL
742	57	FACATATIVA
743	57	FOMEQUE
744	57	FOSCA
745	57	FUNZA
746	57	FUQUENE
747	57	FUSAGASUGA
748	57	GACHALA
749	57	GACHANCIPA
750	57	GACHETA
751	57	GAMA
752	57	GIRARDOT
753	57	GUACHETA
754	57	GUADUAS
755	57	GUASCA
756	57	GUATAQUI
757	57	GUATAVITA
758	57	GUAYABAL DE SIQUIMA
759	57	GUAYABETAL
760	57	GUTIERREZ
761	57	JERUSALEN
762	57	JUNIN
763	57	LA CALERA
764	57	LA MESA
765	57	LA PALMA
766	57	LA PEÑA
767	57	LENGUAZAQUE
768	57	MACHETA
769	57	MADRID
770	57	MANTA
771	57	MEDINA
772	57	MOSQUERA
773	57	NEMOCON
774	57	NILO
775	57	NIMAIMA
776	57	NOCAIMA
777	57	VENECIA (OSPINA PEREZ)
778	57	PACHO
779	57	PAIME
780	57	PANDI
781	57	PARATEBUENO
782	57	PASCA
783	57	PUERTO SALGAR
784	57	PULI
785	57	QUEBRADANEGRA
786	57	QUETAME
787	57	QUIPILE
788	57	APULO (RAFAEL REYES)
789	57	RICAURTE
790	57	SAN  ANTONIO DEL TEQUENDAMA
791	57	SAN BERNARDO
792	57	SAN CAYETANO
793	57	SAN JUAN DE RIOSECO
794	57	SASAIMA
795	57	SESQUILE
796	57	SIBATE
797	57	SILVANIA
798	57	SIMIJACA
799	57	SOACHA
800	57	SOPO
801	57	SUBACHOQUE
802	57	SUESCA
803	57	SUPATA
804	57	SUSA
805	57	SUTATAUSA
806	57	TABIO
807	57	TAUSA
808	57	TENA
809	57	TENJO
810	57	TIBACUY
811	57	TIBIRITA
812	57	TOCAIMA
813	57	TOCANCIPA
814	57	TOPAIPI
815	57	UBALA
816	57	UBAQUE
817	57	UBATE
818	57	UNE
819	57	UTICA
820	57	VERGARA
821	57	VIANI
822	57	VILLAGOMEZ
823	57	VILLAPINZON
824	57	VILLETA
825	57	VIOTA
826	57	YACOPI
827	57	ZIPACON
828	57	ZIPAQUIRA
829	58	QUIBDO (SAN FRANCISCO DE QUIBDO)
830	58	ACANDI
831	58	ALTO BAUDO (PIE DE PATO)
832	58	ATRATO
833	58	BAGADO
834	58	BAHIA SOLANO (MUTIS)
835	58	BAJO BAUDO (PIZARRO)
836	58	BOJAYA (BELLAVISTA)
837	58	CANTON DE SAN PABLO (MANAGRU)
838	58	CONDOTO
839	58	EL CARMEN DE ATRATO
840	58	LITORAL DEL BAJO SAN JUAN (SANTA GENOVEVA DE DOCORDO)
841	58	ISTMINA
842	58	JURADO
843	58	LLORO
844	58	MEDIO ATRATO
845	58	MEDIO BAUDO
846	58	NOVITA
847	58	NUQUI
848	58	RIOQUITO
849	58	SAN JOSE DEL PALMAR
850	58	SIPI
851	58	TADO
852	58	UNGUIA
853	58	UNION PANAMERICANA
854	59	NEIVA
855	59	ACEVEDO
856	59	AGRADO
857	59	AIPE
858	59	ALGECIRAS
859	59	ALTAMIRA
860	59	BARAYA
861	59	CAMPOALEGRE
862	59	COLOMBIA
863	59	ELIAS
864	59	GARZON
865	59	GIGANTE
866	59	HOBO
867	59	IQUIRA
868	59	ISNOS (SAN JOSE DE ISNOS)
869	59	LA ARGENTINA
870	59	LA PLATA
871	59	NATAGA
872	59	OPORAPA
873	59	PAICOL
874	59	PALERMO
875	59	PITAL
876	59	PITALITO
877	59	RIVERA
878	59	SALADOBLANCO
879	59	SAN AGUSTIN
880	59	SUAZA
881	59	TARQUI
882	59	TESALIA
883	59	TELLO
884	59	TERUEL
885	59	TIMANA
886	59	VILLAVIEJA
887	59	YAGUARA
888	60	RIOHACHA
889	60	BARRANCAS
890	60	DIBULLA
891	60	DISTRACCION
892	60	EL MOLINO
893	60	FONSECA
894	60	HATONUEVO
895	60	LA JAGUA DEL PILAR
896	60	MAICAO
897	60	MANAURE
898	60	SAN JUAN DEL CESAR
899	60	URIBIA
900	60	URUMITA
901	61	SANTA MARTA (DISTRITO TURISTICO, CULTURAL E HISTORICODE SANTA MARTA)
902	61	ALGARROBO
903	61	ARACATACA
904	61	ARIGUANI (EL DIFICIL)
905	61	CERRO SAN ANTONIO
906	61	CHIVOLO
907	61	CIENAGA
908	61	EL BANCO
909	61	EL PIÑON
910	61	EL RETEN
911	61	FUNDACION
912	61	GUAMAL
913	61	PEDRAZA
914	61	PIJIÑO DEL CARMEN (PIJIÑO)
915	61	PIVIJAY
916	61	PLATO
917	61	PUEBLOVIEJO
918	61	REMOLINO
919	61	SABANAS DE SAN ANGEL
920	61	SAN SEBASTIAN DE BUENAVISTA
921	61	SAN ZENON
922	61	SANTA ANA
923	61	SITIONUEVO
924	61	TENERIFE
925	62	VILLAVICENCIO
926	62	ACACIAS
927	62	BARRANCA DE UPIA
928	62	CABUYARO
929	62	CASTILLA LA NUEVA
930	62	SAN LUIS DE CUBARRAL
931	62	CUMARAL
932	62	EL CALVARIO
933	62	EL CASTILLO
934	62	EL DORADO
935	62	FUENTE DE ORO
936	62	MAPIRIPAN
937	62	MESETAS
938	62	LA MACARENA
939	62	LA URIBE
940	62	LEJANIAS
941	62	PUERTO CONCORDIA
942	62	PUERTO GAITAN
943	62	PUERTO LOPEZ
944	62	PUERTO LLERAS
945	62	RESTREPO
946	62	SAN CARLOS DE GUAROA
947	62	SAN  JUAN DE ARAMA
948	62	SAN JUANITO
949	62	VISTAHERMOSA
950	63	PASTO (SAN JUAN DE PASTO)
951	63	ALBAN (SAN JOSE)
952	63	ALDANA
953	63	ANCUYA
954	63	ARBOLEDA (BERRUECOS)
955	63	BARBACOAS
956	63	BUESACO
957	63	COLON (GENOVA)
958	63	CONSACA
959	63	CONTADERO
960	63	CUASPUD (CARLOSAMA)
961	63	CUMBAL
962	63	CUMBITARA
963	63	CHACHAGUI
964	63	EL CHARCO
965	63	EL PEÑOL
966	63	EL ROSARIO
967	63	EL TABLON
968	63	FUNES
969	63	GUACHUCAL
970	63	GUAITARILLA
971	63	GUALMATAN
972	63	ILES
973	63	IMUES
974	63	IPIALES
975	63	LA CRUZ
976	63	LA FLORIDA
977	63	LA LLANADA
978	63	LA TOLA
979	63	LEIVA
980	63	LINARES
981	63	LOS ANDES (SOTOMAYOR)
982	63	MAGUI (PAYAN)
983	63	MALLAMA (PIEDRANCHA)
984	63	OLAYA HERRERA (BOCAS DE SATINGA)
985	63	OSPINA
986	63	FRANCISCO PIZARRO (SALAHONDA)
987	63	POLICARPA
988	63	POTOSI
989	63	PROVIDENCIA
990	63	PUERRES
991	63	PUPIALES
992	63	ROBERTO PAYAN (SAN JOSE)
993	63	SAMANIEGO
994	63	SANDONA
995	63	SAN LORENZO
996	63	SAN PEDRO DE CARTAGO
997	63	SANTA BARBARA (ISCUANDE)
998	63	SANTA CRUZ (GUACHAVES)
999	63	SAPUYES
1000	63	TAMINANGO
1001	63	TANGUA
1002	63	TUMACO
1003	63	TUQUERRES
1004	63	YACUANQUER
1005	64	CUCUTA
1006	64	ABREGO
1007	64	ARBOLEDAS
1008	64	BOCHALEMA
1009	64	BUCARASICA
1010	64	CACOTA
1011	64	CACHIRA
1012	64	CHINACOTA
1013	64	CHITAGA
1014	64	CONVENCION
1015	64	CUCUTILLA
1016	64	DURANIA
1017	64	EL CARMEN
1018	64	EL TARRA
1019	64	EL ZULIA
1020	64	GRAMALOTE
1021	64	HACARI
1022	64	HERRAN
1023	64	LABATECA
1024	64	LA ESPERANZA
1025	64	LA PLAYA
1026	64	LOS PATIOS
1027	64	LOURDES
1028	64	MUTISCUA
1029	64	OCAÑA
1030	64	PAMPLONA
1031	64	PAMPLONITA
1032	64	PUERTO SANTANDER
1033	64	RAGONVALIA
1034	64	SALAZAR
1035	64	SAN CALIXTO
1036	64	SANTIAGO
1037	64	SARDINATA
1038	64	SILOS
1039	64	TEORAMA
1040	64	TIBU
1041	64	VILLACARO
1042	64	VILLA DEL ROSARIO
1043	65	CALARCA
1044	65	CIRCASIA
1045	65	FILANDIA
1046	65	GENOVA
1047	65	LA TEBAIDA
1048	65	MONTENEGRO
1049	65	PIJAO
1050	65	QUIMBAYA
1051	65	SALENTO
1052	66	PEREIRA
1053	66	APIA
1054	66	BELEN DE UMBRIA
1055	66	DOS QUEBRADAS
1056	66	GUATICA
1057	66	LA CELIA
1058	66	LA VIRGINIA
1059	66	MARSELLA
1060	66	MISTRATO
1061	66	PUEBLO RICO
1062	66	QUINCHIA
1063	66	SANTA ROSA DE CABAL
1064	67	BUCARAMANGA
1065	67	AGUADA
1066	67	ARATOCA
1067	67	BARICHARA
1068	67	BARRANCABERMEJA
1069	67	CALIFORNIA
1070	67	CAPITANEJO
1071	67	CARCASI
1072	67	CEPITA
1073	67	CERRITO
1074	67	CHARALA
1075	67	CHARTA
1076	67	CHIPATA
1077	67	CIMITARRA
1078	67	CONFINES
1079	67	CONTRATACION
1080	67	COROMORO
1081	67	CURITI
1082	67	EL CARMEN DE CHUCURY
1083	67	EL GUACAMAYO
1084	67	EL PLAYON
1085	67	ENCINO
1086	67	ENCISO
1087	67	FLORIAN
1088	67	FLORIDABLANCA
1089	67	GALAN
1090	67	GAMBITA
1091	67	GIRON
1092	67	GUACA
1093	67	GUAPOTA
1094	67	GUAVATA
1095	67	GUEPSA
1096	67	HATO
1097	67	JESUS MARIA
1098	67	JORDAN
1099	67	LA BELLEZA
1100	67	LANDAZURI
1101	67	LA PAZ
1102	67	LEBRIJA
1103	67	LOS SANTOS
1104	67	MACARAVITA
1105	67	MALAGA
1106	67	MATANZA
1107	67	MOGOTES
1108	67	MOLAGAVITA
1109	67	OCAMONTE
1110	67	OIBA
1111	67	ONZAGA
1112	67	PALMAR
1113	67	PALMAS DEL SOCORRO
1114	67	PARAMO
1115	67	PIEDECUESTA
1116	67	PINCHOTE
1117	67	PUENTE NACIONAL
1118	67	PUERTO PARRA
1119	67	PUERTO WILCHES
1120	67	SABANA DE TORRES
1121	67	SAN BENITO
1122	67	SAN GIL
1123	67	SAN JOAQUIN
1124	67	SAN JOSE DE MIRANDA
1125	67	SAN MIGUEL
1126	67	SAN VICENTE DE CHUCURI
1127	67	SANTA HELENA DEL OPON
1128	67	SIMACOTA
1129	67	SOCORRO
1130	67	SUAITA
1131	67	SUCRE
1132	67	SURATA
1133	67	TONA
1134	67	VALLE SAN JOSE
1135	67	VELEZ
1136	67	VETAS
1137	67	ZAPATOCA
1138	68	SINCELEJO
1139	68	CAIMITO
1140	68	COLOSO (RICAURTE)
1141	68	COROZAL
1142	68	CHALAN
1143	68	GALERAS (NUEVA GRANADA)
1144	68	GUARANDA
1145	68	LOS PALMITOS
1146	68	MAJAGUAL
1147	68	MORROA
1148	68	OVEJAS
1149	68	PALMITO
1150	68	SAMPUES
1151	68	SAN BENITO ABAD
1152	68	SAN JUAN DE BETULIA
1153	68	SAN MARCOS
1154	68	SAN ONOFRE
1155	68	SINCE
1156	68	TOLU
1157	68	TOLUVIEJO
1158	69	IBAGUE
1159	69	ALPUJARRA
1160	69	ALVARADO
1161	69	AMBALEMA
1162	69	ANZOATEGUI
1163	69	ARMERO (GUAYABAL)
1164	69	ATACO
1165	69	CAJAMARCA
1166	69	CARMEN APICALA
1167	69	CASABIANCA
1168	69	CHAPARRAL
1169	69	COELLO
1170	69	COYAIMA
1171	69	CUNDAY
1172	69	DOLORES
1173	69	ESPINAL
1174	69	FALAN
1175	69	FLANDES
1176	69	FRESNO
1177	69	GUAMO
1178	69	HERVEO
1179	69	HONDA
1180	69	ICONONZO
1181	69	LERIDA
1182	69	LIBANO
1183	69	MARIQUITA
1184	69	MELGAR
1185	69	MURILLO
1186	69	NATAGAIMA
1187	69	ORTEGA
1188	69	PALOCABILDO
1189	69	PIEDRAS
1190	69	PLANADAS
1191	69	PRADO
1192	69	PURIFICACION
1193	69	RIOBLANCO
1194	69	RONCESVALLES
1195	69	ROVIRA
1196	69	SALDAÑA
1197	69	SAN ANTONIO
1198	69	SANTA ISABEL
1199	69	VALLE DE SAN JUAN
1200	69	VENADILLO
1201	69	VILLAHERMOSA
1202	69	VILLARRICA
1203	70	CALI (SANTIAGO DE CALI)
1204	70	ALCALA
1205	70	ANDALUCIA
1206	70	ANSERMANUEVO
1207	70	BUENAVENTURA
1208	70	BUGA
1209	70	BUGALAGRANDE
1210	70	CAICEDONIA
1211	70	CALIMA (DARIEN)
1212	70	CARTAGO
1213	70	DAGUA
1214	70	EL AGUILA
1215	70	EL CAIRO
1216	70	EL CERRITO
1217	70	EL DOVIO
1218	70	FLORIDA
1219	70	GINEBRA
1220	70	GUACARI
1221	70	JAMUNDI
1222	70	LA CUMBRE
1223	70	OBANDO
1224	70	PALMIRA
1225	70	PRADERA
1226	70	RIOFRIO
1227	70	ROLDANILLO
1228	70	SEVILLA
1229	70	TORO
1230	70	TRUJILLO
1231	70	TULUA
1232	70	ULLOA
1233	70	VERSALLES
1234	70	VIJES
1235	70	YOTOCO
1236	70	YUMBO
1237	70	ZARZAL
1238	71	ARAUCA
1239	71	ARAUQUITA
1240	71	CRAVO NORTE
1241	71	FORTUL
1242	71	PUERTO RONDON
1243	71	SARAVENA
1244	71	TAME
1245	72	YOPAL
1246	72	AGUAZUL
1247	72	CHAMEZA
1248	72	HATO COROZAL
1249	72	LA SALINA
1250	72	MANI
1251	72	MONTERREY
1252	72	NUNCHIA
1253	72	OROCUE
1254	72	PAZ DE ARIPORO
1255	72	PORE
1256	72	RECETOR
1257	72	SACAMA
1258	72	SAN LUIS DE PALENQUE
1259	72	TAMARA
1260	72	TAURAMENA
1261	72	TRINIDAD
1262	73	MOCOA
1263	73	COLON
1264	73	ORITO
1265	73	PUERTO ASIS
1266	73	PUERTO CAICEDO
1267	73	PUERTO GUZMAN
1268	73	PUERTO LEGUIZAMO
1269	73	SIBUNDOY
1270	73	SAN MIGUEL (LA DORADA)
1271	73	LA HORMIGA (VALLE DEL GUAMUEZ)
1272	73	VILLAGARZON
1273	75	LETICIA
1274	75	EL ENCANTO
1275	75	LA CHORRERA
1276	75	LA PEDRERA
1277	75	MIRITI-PARANA
1278	75	PUERTO ALEGRIA
1279	75	PUERTO ARICA
1280	75	PUERTO NARIÑO
1281	75	TARAPACA
1282	76	PUERTO INIRIDA
1283	76	BARRANCO MINAS
1284	76	SAN FELIPE
1285	76	LA GUADALUPE
1286	76	CACAHUAL
1287	76	PANA PANA (CAMPO ALEGRE)
1288	76	MORICHAL (MORICHAL NUEVO)
1289	77	SAN JOSE DEL GUAVIARE
1290	77	EL RETORNO
1291	78	MITU
1292	78	CARURU
1293	78	PACOA
1294	78	TARAIRA
1295	78	PAPUNAUA (MORICHAL)
1296	78	YAVARATE
1297	79	PUERTO CARREÑO
1298	79	LA PRIMAVERA
1299	79	SANTA RITA
1300	79	SANTA ROSALIA
1301	79	SAN JOSE DE OCUNE
1302	80	CUENCA
1303	80	GIRÓN
1304	80	GUALACEO
1305	80	NABÓN
1306	80	PAUTE
1307	80	PUCARA
1308	80	SAN FERNANDO
1309	80	SANTA ISABEL
1310	80	SIGSIG
1311	80	OÑA
1312	80	CHORDELEG
1313	80	EL PAN
1314	80	SEVILLA DE ORO
1315	80	GUACHAPALA
1316	80	CAMILO PONCE ENRÍQUEZ
1317	81	GUARANDA
1318	81	CHILLANES
1319	81	CHIMBO
1320	81	ECHEANDÍA
1321	81	SAN MIGUEL
1322	81	CALUMA
1323	81	LAS NAVES
1324	82	AZOGUES
1325	82	BIBLIÁN
1326	82	CAÑAR
1327	82	LA TRONCAL
1328	82	EL TAMBO
1329	82	DÉLEG
1330	82	SUSCAL
1331	83	TULCÁN
1332	83	BOLÍVAR
1333	83	ESPEJO
1334	83	MIRA
1335	83	MONTÚFAR
1336	83	SAN PEDRO DE HUACA
1337	84	LATACUNGA
1338	84	LA MANÁ
1339	84	PANGUA
1340	84	PUJILI
1341	84	SALCEDO
1342	84	SAQUISILÍ
1343	84	SIGCHOS
1344	85	RIOBAMBA
1345	85	ALAUSI
1346	85	COLTA
1347	85	CHAMBO
1348	85	CHUNCHI
1349	85	GUAMOTE
1350	85	GUANO
1351	85	PALLATANGA
1352	85	PENIPE
1353	85	CUMANDÁ
1354	86	MACHALA
1355	86	ARENILLAS
1356	86	ATAHUALPA
1357	86	BALSAS
1358	86	CHILLA
1359	86	EL GUABO
1360	86	HUAQUILLAS
1361	86	MARCABELÍ
1362	86	PASAJE
1363	86	PIÑAS
1364	86	PORTOVELO
1365	86	SANTA ROSA
1366	86	ZARUMA
1367	86	LAS LAJAS
1368	87	ESMERALDAS
1369	87	ELOY ALFARO
1370	87	MUISNE
1371	87	QUININDÉ
1372	87	SAN LORENZO
1373	87	ATACAMES
1374	87	RIOVERDE
1375	87	LA CONCORDIA
1376	88	GUAYAQUIL
1377	88	ALFREDO BAQUERIZO MORENO (JUJÁN)
1378	88	BALAO
1379	88	BALZAR
1380	88	COLIMES
1381	88	DAULE
1382	88	DURÁN
1383	88	EL EMPALME
1384	88	EL TRIUNFO
1385	88	MILAGRO
1386	88	NARANJAL
1387	88	NARANJITO
1388	88	PALESTINA
1389	88	PEDRO CARBO
1390	88	SAMBORONDÓN
1391	88	SANTA LUCÍA
1392	88	SALITRE (URBINA JADO)
1393	88	SAN JACINTO DE YAGUACHI
1394	88	PLAYAS
1395	88	SIMÓN BOLÍVAR
1396	88	ORONEL MARCELINO MARIDUE
1397	88	LOMAS DE SARGENTILLO
1398	88	NOBOL
1399	88	GENERAL ANTONIO ELIZALDE
1400	88	ISIDRO AYORA
1401	89	IBARRA
1402	89	ANTONIO ANTE
1403	89	COTACACHI
1404	89	OTAVALO
1405	89	PIMAMPIRO
1406	89	SAN MIGUEL DE URCUQUÍ
1407	90	LOJA
1408	90	CALVAS
1409	90	CATAMAYO
1410	90	CELICA
1411	90	CHAGUARPAMBA
1412	90	ESPÍNDOLA
1413	90	GONZANAMÁ
1414	90	MACARÁ
1415	90	PALTAS
1416	90	PUYANGO
1417	90	SARAGURO
1418	90	SOZORANGA
1419	90	ZAPOTILLO
1420	90	PINDAL
1421	90	QUILANGA
1422	90	OLMEDO
1423	91	BABAHOYO
1424	91	BABA
1425	91	MONTALVO
1426	91	PUEBLOVIEJO
1427	91	QUEVEDO
1428	91	URDANETA
1429	91	VENTANAS
1430	91	VÍNCES
1431	91	PALENQUE
1432	91	BUENA FÉ
1433	91	VALENCIA
1434	91	MOCACHE
1435	91	QUINSALOMA
1436	92	PORTOVIEJO
1437	92	CHONE
1438	92	EL CARMEN
1439	92	FLAVIO ALFARO
1440	92	JIPIJAPA
1441	92	JUNÍN
1442	92	MANTA
1443	92	MONTECRISTI
1444	92	PAJÁN
1445	92	PICHINCHA
1446	92	ROCAFUERTE
1447	92	SANTA ANA
1448	92	SUCRE
1449	92	TOSAGUA
1450	92	24 DE MAYO
1451	92	PEDERNALES
1452	92	PUERTO LÓPEZ
1453	92	JAMA
1454	92	JARAMIJÓ
1455	92	SAN VICENTE
1456	93	MORONA
1457	93	GUALAQUIZA
1458	93	LIMÓN INDANZA
1459	93	PALORA
1460	93	SANTIAGO
1461	93	SUCÚA
1462	93	HUAMBOYA
1463	93	SAN JUAN BOSCO
1464	93	TAISHA
1465	93	LOGROÑO
1466	93	PABLO SEXTO
1467	93	TIWINTZA
1468	94	TENA
1469	94	ARCHIDONA
1470	94	EL CHACO
1471	94	QUIJOS
1472	94	ARLOS JULIO AROSEMENA TOL
1473	95	PASTAZA
1474	95	MERA
1475	95	SANTA CLARA
1476	95	ARAJUNO
1477	96	QUITO
1478	96	CAYAMBE
1479	96	MEJIA
1480	96	PEDRO MONCAYO
1481	96	RUMIÑAHUI
1482	96	SAN MIGUEL DE LOS BANCOS
1483	96	PEDRO VICENTE MALDONADO
1484	96	PUERTO QUITO
1485	97	AMBATO
1486	97	BAÑOS DE AGUA SANTA
1487	97	CEVALLOS
1488	97	MOCHA
1489	97	PATATE
1490	97	QUERO
1491	97	SAN PEDRO DE PELILEO
1492	97	SANTIAGO DE PÍLLARO
1493	97	TISALEO
1494	98	ZAMORA
1495	98	CHINCHIPE
1496	98	NANGARITZA
1497	98	YACUAMBI
1498	98	YANTZAZA (YANZATZA)
1499	98	EL PANGUI
1500	98	CENTINELA DEL CÓNDOR
1501	98	PALANDA
1502	98	PAQUISHA
1503	99	SAN CRISTÓBAL
1504	99	ISABELA
1505	99	SANTA CRUZ
1506	100	LAGO AGRIO
1507	100	GONZALO PIZARRO
1508	100	PUTUMAYO
1509	100	SHUSHUFINDI
1510	100	SUCUMBÍOS
1511	100	CASCALES
1512	100	CUYABENO
1513	101	ORELLANA
1514	101	AGUARICO
1515	101	LA JOYA DE LOS SACHAS
1516	101	LORETO
1517	102	SANTO DOMINGO
1518	103	SANTA ELENA
1519	103	LA LIBERTAD
1520	103	SALINAS
1521	104	LAS GOLONDRINAS
1522	104	MANGA DEL CURA
1523	105	Ahuachapán
1524	105	Atiquizaya
1525	106	Sonsonate
1526	106	Izalco
1527	106	Juayúa
1528	107	Santa Ana
1529	107	Chalchuapa
1530	107	Metapán
1531	108	Chalatenango
1532	108	Tejutla
1533	108	Dulce Nombre de María
1534	109	Nueva San Salvador
1535	109	Quezaltepeque
1536	109	San Juan Opico
1537	110	San Salvador
1538	110	Tonacatepeque
1539	110	Santo Tomás
1540	111	Cojutepeque
1541	111	Suchitoto
1542	112	Zacatecoluca
1543	112	Olocuilta
1544	112	San Pedro Nonualco
1545	112	San Pedro Masahuat
1546	113	Sensuntepeque
1547	113	Ilobasco
1548	114	San Vicente
1549	114	San Sebastián
1550	115	Usulután
1551	115	Santiago de María
1552	115	Berlín
1553	115	Jucuapa
1554	116	San Miguel
1555	116	Chinameca
1556	116	Sesorí
1557	117	San Francisco Gotera
1558	117	Jocoaitique
1559	117	Osicala
1560	118	La Unión
1561	118	Santa Rosa de Lima
1562	119	SAN JOSE
1563	119	ESCAZU
1564	119	DESAMPARADOS
1565	119	PURISCAL
1566	119	TARRAZU
1567	119	ASERRI
1568	119	MORA
1569	119	GOICOECHEA
1570	119	SANTA ANA
1571	119	ALAJUELITA
1572	119	CORONADO
1573	119	ACOSTA
1574	119	TIBAS
1575	119	MORAVIA
1576	119	MONTES DE OCA
1577	119	TURRUBARES
1578	119	DOTA
1579	119	PEREZ ZELEDON
1580	119	LEON CORTES
1581	120	ALAJUELA
1582	120	SAN RAMON
1583	120	GRECIA
1584	120	SAN MATEO
1585	120	ATENAS
1586	120	NARANJO
1587	120	PALMARES
1588	120	POAS
1589	120	OROTINA
1590	120	SAN CARLOS
1591	120	ALFARO RUIZ
1592	120	VALVERDE VEGA
1593	120	UPALA
1594	120	LOS CHILES
1595	120	GUATUSO
1596	121	CARTAGO
1597	121	PARAISO
1598	121	LA UNION
1599	121	JIMENEZ
1600	121	TURRIALBA
1601	121	ALVARADO
1602	121	OREAMUNO
1603	121	EL GUARCO
1604	122	HEREDIA
1605	122	BARVA
1606	122	SANTO DOMINGO
1607	122	SANTA BARBARA
1608	122	SAN RAFAEL
1609	122	SAN ISIDRO
1610	122	BELEN
1611	122	FLORES
1612	122	SAN PABLO
1613	122	SARAPIQUI
1614	123	LIBERIA
1615	123	NICOYA
1616	123	SANTA CRUZ
1617	123	BAGACES
1618	123	CARRILLO
1619	123	CAÑAS
1620	123	ABANGARES
1621	123	TILARAN
1622	123	NANDAYURE
1623	123	LA CRUZ
1624	123	HOJANCHA
1625	124	PUNTARENAS
1626	124	ESPARZA
1627	124	BUENOS AIRES
1628	124	MONTES DE ORO
1629	124	OSA
1630	124	AGUIRRE
1631	124	GOLFITO
1632	124	COTO BRUS
1633	124	PARRITA
1634	124	CORREDORES
1635	124	GARABITO
1636	125	LIMON
1637	125	POCOCI
1638	125	SIQUIRRES
1639	125	TALAMANCA
1640	125	MATINA
1641	125	GUACIMO
1642	126	Alto Orinoco
1643	126	Atabapo
1644	126	Atures
1645	126	Autana
1646	126	Manapiare
1647	126	Maroa
1648	126	Río Negro
1649	127	Anaco
1650	127	Aragua
1651	127	Diego Bautista Urbaneja
1652	127	Fernando Peñalver
1653	127	Francisco de Miranda
1654	127	Francisco Del Carmen Carvajal
1655	127	General Sir Arthur McGregor
1656	127	Guanta
1657	127	Independencia
1658	127	José Gregorio Monagas
1659	127	Juan Antonio Sotillo
1660	127	Juan Manuel Cajigal
1661	127	Libertad
1662	127	Manuel Ezequiel Bruzual
1663	127	Pedro María Freites
1664	127	Píritu
1665	127	San José de Guanipa
1666	127	San Juan de Capistrano
1667	127	Santa Ana
1668	127	Simón Bolívar
1669	127	Simón Rodríguez
1670	128	Achaguas
1671	128	Biruaca
1672	128	Muñóz
1673	128	Páez
1674	128	Pedro Camejo
1675	128	Rómulo Gallegos
1676	128	San Fernando
1677	129	Atanasio Girardot
1678	129	Bolívar
1679	129	Camatagua
1680	129	Francisco Linares Alcántara
1681	129	José Ángel Lamas
1682	129	José Félix Ribas
1683	129	José Rafael Revenga
1684	129	Libertador
1685	129	Mario Briceño Iragorry
1686	129	Ocumare de la Costa de Oro
1687	129	San Casimiro
1688	129	San Sebastián
1689	129	Santiago Mariño
1690	129	Santos Michelena
1691	129	Sucre
1692	129	Tovar
1693	129	Urdaneta
1694	129	Zamora
1695	130	Alberto Arvelo Torrealba
1696	130	Andrés Eloy Blanco
1697	130	Antonio José de Sucre
1698	130	Arismendi
1699	130	Barinas
1700	130	Cruz Paredes
1701	130	Ezequiel Zamora
1702	130	Obispos
1703	130	Pedraza
1704	130	Rojas
1705	130	Sosa
1706	131	Angostura (Raúl Leoni)
1707	131	Caroní
1708	131	Cedeño
1709	131	El Callao
1710	131	Gran Sabana
1711	131	Heres
1712	131	Padre Pedro Chien
1713	131	Piar
1714	131	Roscio
1715	131	Sifontes
1716	132	Bejuma
1717	132	Carlos Arvelo
1718	132	Diego Ibarra
1719	132	Guacara
1720	132	Juan José Mora
1721	132	Los Guayos
1722	132	Miranda
1723	132	Montalbán
1724	132	Naguanagua
1725	132	Puerto Cabello
1726	132	San Diego
1727	132	San Joaquín
1728	132	Valencia
1729	133	Anzoátegui
1730	133	Girardot
1731	133	Lima Blanco
1732	133	Pao de San Juan Bautista
1733	133	Ricaurte
1734	133	San Carlos
1735	133	Tinaco
1736	133	Tinaquillo
1737	134	Antonio Díaz
1738	134	Casacoima
1739	134	Pedernales
1740	134	Tucupita
1741	136	Acosta
1742	136	Buchivacoa
1743	136	Cacique Manaure
1744	136	Carirubana
1745	136	Colina
1746	136	Dabajuro
1747	136	Democracia
1748	136	Falcón
1749	136	Federación
1750	136	Jacura
1751	136	José Laurencio Silva
1752	136	Los Taques
1753	136	Mauroa
1754	136	Monseñor Iturriza
1755	136	Palmasola
1756	136	Petit
1757	136	San Francisco
1758	136	Tocópero
1759	136	Unión
1760	136	Urumaco
1761	137	Camaguán
1762	137	Chaguaramas
1763	137	El Socorro
1764	137	José Tadeo Monagas
1765	137	Juan Germán Roscio
1766	137	Julián Mellado
1767	137	Las Mercedes
1768	137	Leonardo Infante
1769	137	Ortíz
1770	137	Pedro Zaraza
1771	137	San Gerónimo de Guayabal
1772	137	San José de Guaribe
1773	137	Santa María de Ipire
1774	137	Sebastián Francisco de Miranda
1775	138	Vargas
1776	139	Crespo
1777	139	Iribarren
1778	139	Jiménez
1779	139	Morán
1780	139	Palavecino
1781	139	Simón Planas
1782	139	Torres
1783	140	Alberto Adriani
1784	140	Andrés Bello
1785	140	Antonio Pinto Salinas
1786	140	Aricagua
1787	140	Arzobispo Chacón
1788	140	Campo Elías
1789	140	Caracciolo Parra Olmedo
1790	140	Cardenal Quintero
1791	140	Guaraque
1792	140	Julio César Salas
1793	140	Justo Briceño
1794	140	Obispo Ramos de Lora
1795	140	Padre Noguera
1796	140	Pueblo Llano
1797	140	Rangel
1798	140	Rivas Dávila
1799	140	Santos Marquina
1800	140	Tulio Febres Cordero
1801	140	Zea
1802	141	Acevedo
1803	141	Baruta
1804	141	Brión
1805	141	Buroz
1806	141	Carrizal
1807	141	Chacao
1808	141	Cristóbal Rojas
1809	141	El Hatillo
1810	141	Guaicaipuro
1811	141	Lander
1812	141	Los Salias
1813	141	Paz Castillo
1814	141	Pedro Gual
1815	141	Plaza
1816	142	Aguasay
1817	142	Caripe
1818	142	Maturín
1819	142	Punceres
1820	142	Santa Bárbara
1821	142	Sotillo
1822	142	Uracoa
1823	143	Antolín del Campo
1824	143	Díaz
1825	143	García
1826	143	Gómez
1827	143	Maneiro
1828	143	Marcano
1829	143	Mariño
1830	143	Península de Macanao
1831	143	Tubores
1832	143	Villalba
1833	144	Araure
1834	144	Esteller
1835	144	Guanare
1836	144	Guanarito
1837	144	Monseñor José Vicente de Unda
1838	144	Ospino
1839	144	Papelón
1840	144	San Genaro de Boconoíto
1841	144	San Rafael de Onoto
1842	144	Santa Rosalía
1843	144	Turén
1844	145	Andrés Mata
1845	145	Benítez
1846	145	Bermúdez
1847	145	Cajigal
1848	145	Cruz Salmerón Acosta
1849	145	Mejía
1850	145	Montes
1851	145	Ribero
1852	145	Valdéz
1853	146	Antonio Rómulo Costa
1854	146	Ayacucho
1855	146	Cárdenas
1856	146	Córdoba
1857	146	Fernández Feo
1858	146	García de Hevia
1859	146	Guásimos
1860	146	Jáuregui
1861	146	José María Vargas
1862	146	Junín
1863	146	Lobatera
1864	146	Michelena
1865	146	Panamericano
1866	146	Pedro María Ureña
1867	146	Rafael Urdaneta
1868	146	Samuel Darío Maldonado
1869	146	San Cristóbal
1870	146	San Judas Tadeo
1871	146	Seboruco
1872	146	Torbes
1873	146	Uribante
1874	147	Boconó
1875	147	Candelaria
1876	147	Carache
1877	147	Escuque
1878	147	José Felipe Márquez Cañizalez
1879	147	Juan Vicente Campos Elías
1880	147	La Ceiba
1881	147	Monte Carmelo
1882	147	Motatán
1883	147	Pampán
1884	147	Pampanito
1885	147	Rafael Rangel
1886	147	San Rafael de Carvajal
1887	147	Trujillo
1888	147	Valera
1889	148	Arístides Bastidas
1890	148	Bruzual
1891	148	Cocorote
1892	148	José Antonio Páez
1893	148	José Joaquín Veroes
1894	148	La Trinidad
1895	148	Manuel Monge
1896	148	Nirgua
1897	148	Peña
1898	148	San Felipe
1899	148	Urachiche
1900	149	Almirante Padilla
1901	149	Baralt
1902	149	Cabimas
1903	149	Catatumbo
1904	149	Colón
1905	149	Francisco Javier Pulgar
1906	149	Jesús Enrique Losada
1907	149	Jesús María Semprún
1908	149	La Cañada de Urdaneta
1909	149	Lagunillas
1910	149	Machiques de Perijá
1911	149	Mara
1912	149	Maracaibo
1913	149	Rosario de Perijá
1914	149	Santa Rita
1915	149	Valmore Rodríguez
1917	151	Baltasar Brum
1918	151	Bella Unión
1919	151	Tomás Gomensoro
1920	152	18 de Mayo
1921	152	Aguas Corrientes
1922	152	Atlántida
1923	152	Barros Blancos
1924	152	Canelones
1925	152	Ciudad de la Costa
1926	152	Colonia Nicolich
1927	152	Empalme Olmos
1928	152	La Floresta
1929	152	La Paz
1930	152	Las Piedras
1931	152	Los Cerrillos
1932	152	Migues
1933	152	Montes
1934	152	Pando
1935	152	Parque del Plata
1936	152	Paso Carrasco
1937	152	Progreso
1938	152	Salinas
1939	152	San Antonio
1940	152	San Bautista
1941	152	San Jacinto
1942	152	San Ramón
1943	152	Santa Lucía
1944	152	Santa Rosa
1945	152	Sauce
1946	152	Soca
1947	152	Suárez
1948	152	Tala
1949	152	Toledo
1950	153	Aceguá
1951	153	Arbolito
1952	153	Arévalo
1953	153	Bañado de Medina
1954	153	Centurión
1955	153	Cerro de las Cuentas
1956	153	Fraile Muerto
1957	153	Isidoro Noblía
1958	153	Las Cañas
1959	153	Plácido Rosas
1960	153	Quebracho
1961	153	Ramón Trigo
1962	153	Río Branco
1963	153	Tres Islas
1964	153	Tupambaé
1965	154	Carmelo
1966	154	Colonia Valdense
1967	154	Florencio Sánchez
1968	154	Juan L. Lacaze
1969	154	Colonia Miguelete
1970	154	Nueva Helvecia
1971	154	Nueva Palmira
1972	154	Ombúes de Lavalle
1973	154	Rosario
1974	154	Tarariras
1975	155	Sarandí del Yí
1976	155	Villa del Carmen
1977	156	Ismael Cortinas
1978	157	Casupá
1979	157	Fray Marcos
1980	157	Sarandí Grande
1981	158	José Batlle y Ordóñez
1982	158	José Pedro Varela
1983	158	Mariscala
1984	158	Solís de Mataojo
1985	159	Aiguá
1986	159	Garzón
1987	159	Maldonado
1988	159	Pan de Azúcar
1989	159	Piriápolis
1990	159	Punta del Este
1991	159	San Carlos
1992	159	Solís Grande
1993	160	Municipio A
1994	160	Municipio B
1995	160	Municipio C
1996	160	Municipio CH
1997	160	Municipio D
1998	160	Municipio E
1999	160	Municipio F
2000	160	Municipio G
2001	161	Chapicuy
2002	161	Guichón
2003	161	Lorenzo Geyres
2004	161	Piedras Coloradas
2005	161	Porvenir
2006	161	Tambores
2007	162	Nuevo Berlín
2008	162	San Javier
2009	162	Young
2010	163	Minas de Corrales
2011	163	Tranqueras
2012	163	Vichadero
2013	164	Castillos
2014	164	Chuy
2015	164	La Paloma
2016	164	Lascano
2017	165	Colonia Lavalleja
2018	165	Mataojo
2019	165	Pueblo Belén
2020	165	Pueblo Rincón de Valentín
2021	165	Pueblo San Antonio
2022	165	Villa Constitución
2023	166	Ciudad del Plata
2024	166	Ecilda Paullier
2025	166	Libertad
2026	166	Rodríguez
2027	167	Cardona
2028	167	Dolores
2029	167	José Enrique Rodó
2030	167	Palmitas
2031	168	Ansina
2032	168	Paso de los Toros
2033	168	San Gregorio de Polanco
2034	169	Cerro Chato
2035	169	General Enrique Martínez
2036	169	Rincón
2037	169	Santa Clara de Olimar
2038	169	Vergara
2039	170	Bahía Negra
2040	170	Capitán Carmelo Peralta
2041	170	Fuerte Olimpo
2042	170	Puerto Casado
2043	171	Ciudad del Este
2044	171	Doctor Juan León Mallorquín
2045	171	Doctor Raúl Peña
2046	171	Domingo Martínez de Irala
2047	171	Hernandarias
2048	171	Iruña
2049	171	Itakyry
2050	171	Juan Emiliano O'Leary
2051	171	Los Cedrales
2052	171	Mbaracayú
2053	171	Minga Guazú
2054	171	Minga Porá
2055	171	Naranjal
2056	171	Ñacunday
2057	171	Presidente Franco
2058	171	San Alberto
2059	171	Santa Fe del Paraná
2060	171	Santa Rita
2061	171	Santa Rosa del Monday
2062	171	Tavapy
2063	171	Yguazú
2064	172	Bella Vista Norte
2065	172	Capitán Bado
2066	172	Cerro Corá
2067	172	Karapaí
2068	172	Pedro Juan Caballero
2069	172	Zanja Pytá
2070	173	Asunción
2071	174	Boquerón
2072	174	Filadelfia
2073	174	Loma Plata
2074	174	Mariscal José Félix Estigarribia
2075	175	Caaguazú
2076	175	Carayaó
2077	175	Coronel Oviedo
2078	175	Doctor Cecilio Báez
2079	175	Doctor Juan Eulogio Estigarribia
2080	175	Doctor Juan Manuel Frutos
2081	175	José Domingo Ocampos
2082	175	La Pastora
2083	175	Mariscal Francisco Solano López
2084	175	Nueva Londres
2085	175	Nueva Toledo
2086	175	Raúl Arsenio Oviedo
2087	175	Regimiento de Infantería Tres Corrales
2088	175	Repatriación
2089	175	San José de los Arroyos
2090	175	Santa Rosa del Mbutuy
2091	175	Simón Bolívar
2092	175	Tembiaporá
2093	175	Tres de Febrero
2094	175	Vaquería
2095	175	Yhú
2096	176	Abaí
2097	176	Buena Vista
2098	176	Caazapá
2099	176	Doctor Moisés Santiago Bertoni
2100	176	Fulgencio Yegros
2101	176	General Higinio Morínigo
2102	176	Maciel
2103	176	San Juan Nepomuceno
2104	176	Tavaí
2105	176	Tres de Mayo
2106	176	Yuty
2107	177	Corpus Christi
2108	177	Curuguaty
2109	177	General Francisco Caballero Álvarez
2110	177	Itanará
2111	177	Katueté
2112	177	La Paloma del Espíritu Santo
2113	177	Laurel
2114	177	Maracaná
2115	177	Nueva Esperanza
2116	177	Puerto Adela
2117	177	Salto del Guairá
2118	177	Villa Ygatimí
2119	177	Yasy Cañy
2120	177	Yby Pytá
2121	177	Ybyrarobaná
2122	177	Ypejhú
2123	178	Areguá
2124	178	Capiatá
2125	178	Fernando de la Mora
2126	178	Guarambaré
2127	178	Itá
2128	178	Itauguá
2129	178	Julián Augusto Saldívar
2130	178	Lambaré
2131	178	Limpio
2132	178	Luque
2133	178	Mariano Roque Alonso
2134	178	Nueva Italia
2135	178	Ñemby
2136	178	San Antonio
2137	178	San Lorenzo
2138	178	Villa Elisa
2139	178	Villeta
2140	178	Ypacaraí
2141	178	Ypané
2142	179	Arroyito
2143	179	Azotey
2144	179	Belén
2145	179	Concepción
2146	179	Horqueta
2147	179	Loreto
2148	179	Paso Horqueta
2149	179	San Alfredo
2150	179	San Carlos del Apa
2151	179	San Lázaro
2152	179	Sargento José Félix López
2153	179	Yby Yaú
2154	180	Altos
2155	180	Arroyos y Esteros
2156	180	Atyrá
2157	180	Caacupé
2158	180	Caraguatay
2159	180	Emboscada
2160	180	Eusebio Ayala
2161	180	Isla Pucú
2162	180	Itacurubí de la Cordillera
2163	180	Juan de Mena
2164	180	Loma Grande
2165	180	Mbocayaty del Yhaguy
2166	180	Nueva Colombia
2167	180	Piribebuy
2168	180	Primero de Marzo
2169	180	San Bernardino
2170	180	San José Obrero
2171	180	Santa Elena
2172	180	Tobatí
2173	180	Valenzuela
2174	181	Borja
2175	181	Capitán Mauricio José Troche
2176	181	Coronel Martínez
2177	181	Doctor Botrell
2178	181	Félix Pérez Cardozo
2179	181	General Eugenio Alejandrino Garay
2180	181	Independencia
2181	181	Itapé
2182	181	Iturbe
2183	181	José A. Fassardi
2184	181	Mbocayaty del Guairá
2185	181	Natalicio Talavera
2186	181	Ñumí
2187	181	Paso Yobái
2188	181	San Salvador
2189	181	Tebicuary
2190	181	Villarrica
2191	181	Yataity del Guairá
2192	182	Alto Verá
2193	182	Bella Vista
2194	182	Cambyretá
2195	182	Capitán Meza
2196	182	Capitán Miranda
2197	182	Carlos Antonio López
2198	182	Carmen del Paraná
2199	182	Coronel José Félix Bogado
2200	182	Edelira
2201	182	Encarnación
2202	182	Fram
2203	182	General Artigas
2204	182	General Delgado
2205	182	Hohenau
2206	182	Itapúa Poty
2207	182	Jesús de Tavarangüé
2208	182	José Leandro Oviedo
2209	182	La Paz
2210	182	Mayor Julio Dionisio Otaño
2211	182	Natalio
2212	182	Nueva Alborada
2213	182	Obligado
2214	182	Pirapó
2215	182	San Cosme y Damián
2216	182	San Juan del Paraná
2217	182	San Pedro del Paraná
2218	182	San Rafael del Paraná
2219	182	Tomás Romero Pereira
2220	182	Trinidad
2221	182	Yatytay
2222	183	Ayolas
2223	183	San Ignacio Guazú
2224	183	San Juan Bautista
2225	183	San Miguel
2226	183	San Patricio
2227	183	Santa María de Fe
2228	183	Santa Rosa de Lima
2229	183	Santiago
2230	183	Villa Florida
2231	183	Yabebyry
2232	184	Alberdi
2233	184	Cerrito
2234	184	Desmochados
2235	184	General José Eduvigis Díaz
2236	184	Guazú Cuá
2237	184	Humaitá
2238	184	Isla Umbú
2239	184	Laureles
2240	184	Mayor José Martínez
2241	184	Paso de Patria
2242	184	Pilar
2243	184	San Juan Bautista de Ñeembucú
2244	184	Tacuaras
2245	184	Villa Franca
2246	184	Villa Oliva
2247	184	Villalbín
2248	185	Acahay
2249	185	Caapucú
2250	185	Carapeguá
2251	185	Escobar
2252	185	General Bernardino Caballero
2253	185	La Colmena
2254	185	María Antonia
2255	185	Mbuyapey
2256	185	Paraguarí
2257	185	Pirayú
2258	185	Quiindy
2259	185	Quyquyhó
2260	185	San Roque González de Santa Cruz
2261	185	Sapucai
2262	185	Tebicuarymí
2263	185	Yaguarón
2264	185	Ybycuí
2265	185	Ybytymí
2266	186	Benjamín Aceval
2267	186	Campo Aceval
2268	186	General José María Bruguez
2269	186	José Falcón
2270	186	Nanawa
2271	186	Nueva Asunción5​
2272	186	Puerto Pinasco
2273	186	Teniente Esteban Martínez
2274	186	Teniente Primero Manuel Irala Fernández
2275	186	Villa Hayes
2276	187	Antequera
2277	187	Capiibary
2278	187	Choré
2279	187	General Elizardo Aquino
2280	187	General Isidoro Resquín
2281	187	Guayaibí
2282	187	Itacurubí del Rosario
2283	187	Liberación
2284	187	Lima
2285	187	Nueva Germania
2286	187	San José del Rosario
2287	187	San Estanislao
2288	187	San Pablo
2289	187	San Pedro de Ycuamandiyú
2290	187	San Vicente Pancholo
2291	187	Santa Rosa del Aguaray
2292	187	Tacuatí
2293	187	Unión
2294	187	Veinticinco de Diciembre
2295	187	Villa del Rosario
2296	187	Yataity del Norte
2297	188	Cercado
2298	188	Gral. J. Ballivian
2299	188	Itenez
2300	188	Mamore
2301	188	Marban
2302	188	Moxos
2303	188	Vaca Diez
2304	188	Yacuma
2305	189	Azurduy
2306	189	Belisario Boeto
2307	189	Hernando Siles
2308	189	Luis Calvo
2309	189	Nor Cinti
2310	189	Oropeza
2311	189	Sud Cinti
2312	189	Tomina
2313	189	Yamparaez
2314	189	Zudañez
2315	190	Arani
2316	190	Arque
2317	190	Ayopaya
2318	190	Bolivar
2319	190	Campero
2320	190	Capinota
2321	190	Carrasco
2322	190	Chapare
2323	190	Esteban Arce
2324	190	German Jordan
2325	190	Mizque
2326	190	Punata
2327	190	Quillacollo
2328	190	Tapacari
2329	190	Tiraque
2330	191	Abel Iturralde
2331	191	Aroma
2332	191	Bautista Saavedra
2333	191	Camacho
2334	191	Caranavi
2335	191	Franz Tamayo
2336	191	Gral. J. Manuel Pando
2337	191	Gualberto Villarroel
2338	191	Ingavi
2339	191	Inquisivi
2340	191	Larecaja
2341	191	Loayza
2342	191	Los Andes
2343	191	Manco Kapac
2344	191	Muñecas
2345	191	Murillo
2346	191	Nor Yungas
2347	191	Omasuyos
2348	191	Pacajes
2349	191	Sur Yungas
2350	192	Abaroa
2351	192	Carangas
2352	192	Ladislao Cabrera
2353	192	Litoral
2354	192	Mejillones
2355	192	Nor Carangas
2356	192	Pantaleon Dalence
2357	192	Poopo
2358	192	S. Pedro de Totora
2359	192	Sabaya
2360	192	Sajama
2361	192	Saucari
2362	192	Sebastian Pagador
2363	192	Sur Carangas
2364	192	Tomas Barron
2365	193	Abuna
2366	193	Gral. Federico Roman
2367	193	Madre de Dios
2368	193	Manuripi
2369	193	Nicolas Suarez
2370	194	Alonzo de Ibañez
2371	194	Antonio Quijarro
2372	194	Charcas
2373	194	Chayanta
2374	194	Cornelio Saavedra
2375	194	Daniel Campos
2376	194	Enrique Baldiviezo
2377	194	Gral. B. Bilbao
2378	194	Jose Maria Linares
2379	194	Modesto Omiste
2380	194	Nor Chichas
2381	194	Nor Lipez
2382	194	Rafael Bustillo
2383	194	Sur Chichas
2384	194	Sur Lipez
2385	194	Tomas Frias
2386	195	Andres Ibañez
2387	195	Angel Sandoval
2388	195	Caballero
2389	195	Chiquitos
2390	195	Cordillera
2391	195	Florida
2392	195	German Busch
2393	195	Guarayos
2394	195	Ichilo
2395	195	Ñuflo de Chavez
2396	195	Obispo Santiestevan
2397	195	Sara
2398	195	Vallegrande
2399	195	Velasco
2400	195	Warnes
2401	196	Arce
2402	196	Avilez
2403	196	Burnet O' Connor
2404	196	Gran Chaco
2405	196	Mendez
2406	197	Almirante
2407	197	Bocas del Toro
2408	197	Changuinola
2409	197	Chiriquí Grande
2410	198	Alanje
2411	198	Barú
2412	198	Boquerón
2413	198	Boquete
2414	198	Bugaba
2415	198	David
2416	198	Dolega
2417	198	Gualaca
2418	198	Remedios
2419	198	Renacimiento
2420	198	San Félix
2421	198	San Lorenzo
2422	198	Tierras Altas
2423	198	Tolé
2424	199	Aguadulce
2425	199	Antón
2426	199	La Pintada
2427	199	Natá
2428	199	Olá
2429	199	Penonomé
2430	200	Colón
2431	200	Chagres
2432	200	Donoso
2433	200	Portobelo
2434	200	Santa Isabel
2435	200	Omar Torrijos Herrera
2436	201	Chepigana
2437	201	Pinogana
2438	201	Santa Fe
2439	202	Chitré
2440	202	Las Minas
2441	202	Los Pozos
2442	202	Ocú
2443	202	Parita
2444	202	Pesé
2445	202	Santa María
2446	203	Guararé
2447	203	Las Tablas
2448	203	Los Santos
2449	203	Macaracas
2450	203	Pedasí
2451	203	Pocrí
2452	203	Tonosí
2453	204	Balboa
2454	204	Chepo
2455	204	Chimán
2456	204	Panamá
2457	204	San Miguelito
2458	204	Taboga
2459	205	Arraiján
2460	205	Capira
2461	205	Chame
2462	205	La Chorrera
2463	205	San Carlos
2464	206	Atalaya
2465	206	Calobre
2466	206	Cañazas
2467	206	La Mesa
2468	206	Las Palmas
2469	206	Mariato
2470	206	Montijo
2471	206	Río de Jesús
2472	206	San Francisco
2473	206	Santiago
2474	206	Soná
2475	207	Cémaco
2476	207	Sambú
2477	208	(Ninguno)
2478	209	Naso Tjër Di
2479	210	Besikó
2480	210	Kankintú
2481	210	Kusapín
2482	210	Mironó
2483	210	Müna
2484	210	Nole Düima
2485	210	Ñürüm
2486	210	Jirondai
2487	210	Santa Catalina o Calovébora
2488	211	Chahal
2489	211	Chisec
2490	211	Cobána​
2491	211	Fray Bartolomé de las Casas
2492	211	La Tinta
2493	211	Lanquín
2494	211	Panzós
2495	211	Raxruhá
2496	211	San Juan Chamelco
2497	211	San Pedro Carchá
2498	211	Santa Cruz Verapaz
2499	211	Santa María Cahabón
2500	211	Senahú
2501	211	Tamahú
2502	211	Tactic
2503	211	Tucurú
2504	212	Cubulco
2505	212	Granados
2506	212	Purulhá
2507	212	Rabinal
2508	212	Salamáa​
2509	212	San Jerónimo
2510	212	San Miguel Chicaj
2511	212	Santa Cruz el Chol
2512	213	Acatenango
2513	213	Chimaltenangoa​
2514	213	El Tejar
2515	213	Parramos
2516	213	Patzicía
2517	213	Patzún
2518	213	Pochuta
2519	213	San Andrés Itzapa
2520	213	San José Poaquíl
2521	213	San Juan Comalapa
2522	213	San Martín Jilotepeque
2523	213	Santa Apolonia
2524	213	Santa Cruz Balanyá
2525	213	Tecpán
2526	213	Yepocapa
2527	213	Zaragoza
2528	214	Camotán
2529	214	Chiquimulaa​
2530	214	Concepción Las Minas
2531	214	Esquipulas
2532	214	Ipala
2533	214	Olopa
2534	214	Quetzaltepeque
2535	214	San Jacinto
2536	214	San José la Arada
2537	214	San Juan Ermita
2538	215	El Jícaro
2539	215	Guastatoyaa​
2540	215	Morazán
2541	215	San Agustín Acasaguastlán
2542	215	San Antonio La Paz
2543	215	San Cristóbal Acasaguastlán
2544	215	Sanarate
2545	215	Sansare
2546	216	Escuintlaa​
2547	216	Guanagazapa
2548	216	Iztapa
2549	216	La Democracia
2550	216	La Gomera
2551	216	Masagua
2552	216	Nueva Concepción
2553	216	Palín
2554	216	San José
2555	216	San Vicente Pacaya
2556	216	Santa Lucía Cotzumalguapa
2557	216	Sipacate
2558	216	Siquinalá
2559	216	Tiquisate
2560	217	Amatitlán
2561	217	Chinautla
2562	217	Chuarrancho
2563	217	Ciudad de Guatemalaa​
2564	217	Fraijanes
2565	217	Mixco
2566	217	Palencia
2567	217	San José del Golfo
2568	217	San José Pinula
2569	217	San Juan Sacatepéquez
2570	217	San Miguel Petapa
2571	217	San Pedro Ayampuc
2572	217	San Pedro Sacatepéquez
2573	217	San Raymundo
2574	217	Santa Catarina Pinula
2575	217	Villa Canales
2576	217	Villa Nueva
2577	218	Aguacatán
2578	218	Chiantla
2579	218	Colotenango
2580	218	Concepción Huista
2581	218	Cuilco
2582	218	Huehuetenangoa​
2583	218	Jacaltenango
2584	218	La Libertad
2585	218	Malacatancito
2586	218	Nentón
2587	218	Petatán
2588	218	San Antonio Huista
2589	218	San Gaspar Ixchil
2590	218	San Ildefonso Ixtahuacán
2591	218	San Juan Atitán
2592	218	San Juan Ixcoy
2593	218	San Mateo Ixtatán
2594	218	San Miguel Acatán
2595	218	San Pedro Nécta
2596	218	San Pedro Soloma
2597	218	San Rafael La Independencia
2598	218	San Rafael Pétzal
2599	218	San Sebastián Coatán
2600	218	San Sebastián Huehuetenango
2601	218	Santa Ana Huista
2602	218	Santa Bárbara
2603	218	Santa Cruz Barillas
2604	218	Santa Eulalia
2605	218	Santiago Chimaltenango
2606	218	Tectitán
2607	218	Todos Santos Cuchumatán
2608	218	Unión Cantinil
2609	219	El Estor
2610	219	Livingston
2611	219	Los Amates
2612	219	Morales
2613	219	Puerto Barriosa​
2614	220	Jalapaa​
2615	220	Mataquescuintla
2616	220	Monjas
2617	220	San Carlos Alzatate
2618	220	San Luis Jilotepeque
2619	220	San Manuel Chaparrón
2620	220	San Pedro Pinula
2621	221	Agua Blanca
2622	221	Asunción Mita
2623	221	Atescatempa
2624	221	Comapa
2625	221	Conguaco
2626	221	El Adelanto
2627	221	El Progreso
2628	221	Jalpatagua
2629	221	Jerez
2630	221	Jutiapaa​
2631	221	Moyuta
2632	221	Pasaco
2633	221	Quesada
2634	221	San José Acatempa
2635	221	Santa Catarina Mita
2636	221	Yupiltepeque
2637	221	Zapotitlán
2638	222	Dolores
2639	222	El Chal
2640	222	Isla de Flores, Santa Elena de la Cruza​
2641	222	Las Cruces
2642	222	Melchor de Mencos
2643	222	Poptún
2644	222	San Andrésh​
2645	222	San Benito
2646	222	San Francisco
2647	222	San Luis
2648	222	Santa Ana
2649	222	Sayaxché
2650	223	Almolonga
2651	223	Cabricán
2652	223	Cajolá
2653	223	Cantel
2654	223	Coatepeque
2655	223	Colomba Costa Cuca
2656	223	Concepción Chiquirichapa
2657	223	El Palmar
2658	223	Flores Costa Cuca
2659	223	Génova
2660	223	Huitán
2661	223	La Esperanza
2662	223	Olintepeque
2663	223	Palestina de Los Altos
2664	223	Quetzaltenangoa​
2665	223	Salcajá
2666	223	San Carlos Sija
2667	223	San Francisco La Unión
2668	223	San Juan Ostuncalco
2669	223	San Martín Sacatepéquez
2670	223	San Mateo
2671	223	San Miguel Sigüilá
2672	223	Sibilia
2673	223	Zunil
2674	224	Canillá
2675	224	Chajul
2676	224	Chicamán
2677	224	Chiché
2678	224	Santo Tomás Chichicastenango
2679	224	Chinique
2680	224	Cunén
2681	224	Ixcán
2682	224	Joyabaj
2683	224	Nebaj
2684	224	Pachalum
2685	224	Patzité
2686	224	Sacapulas
2687	224	San Andrés Sajcabajá
2688	224	San Antonio Ilotenango
2689	224	San Bartolomé Jocotenango
2690	224	San Juan Cotzal
2691	224	San Pedro Jocopilas
2692	224	Santa Cruz del Quichéa​
2693	224	Uspantán
2694	224	Zacualpa
2695	225	Champerico
2696	225	El Asintal
2697	225	Nuevo San Carlos
2698	225	Retalhuleua​
2699	225	San Andrés Villa Seca
2700	225	San Felipe
2701	225	San Martín Zapotitlán
2702	225	San Sebastián
2703	225	Santa Cruz Muluá
2704	226	Alotenango
2705	226	Ciudad Vieja
2706	226	Jocotenango
2707	226	Antigua Guatemalaa​
2708	226	Magdalena Milpas Altas
2709	226	Pastores
2710	226	San Antonio Aguas Calientes
2711	226	San Bartolomé Milpas Altas
2712	226	San Lucas Sacatepéquez
2713	226	San Miguel Dueñas
2714	226	Santa Catarina Barahona
2715	226	Santa Lucía Milpas Altas
2716	226	Santa María de Jesús
2717	226	Santiago Sacatepéquez
2718	226	Santo Domingo Xenacoj
2719	226	Sumpango
2720	227	Ayutla
2721	227	Catarina
2722	227	Comitancillo
2723	227	Concepción Tutuapa
2724	227	El Quetzal
2725	227	El Tumbador
2726	227	Esquipulas Palo Gordo
2727	227	Ixchiguán
2728	227	La Blanca
2729	227	La Reforma
2730	227	Malacatán
2731	227	Nuevo Progreso
2732	227	Ocós
2733	227	Pajapita
2734	227	Río Blanco
2735	227	San Antonio Sacatepéquez
2736	227	San Cristóbal Cucho
2737	227	San José El Rodeo
2738	227	San José Ojetenam
2739	227	San Lorenzo
2740	227	San Marcosa​
2741	227	San Miguel Ixtahuacán
2742	227	San Pablo
2743	227	San Rafael Pie de la Cuesta
2744	227	Sibinal
2745	227	Sipacapa
2746	227	Tacaná
2747	227	Tajumulco
2748	227	Tejutla
2749	228	Barberena
2750	228	Casillas
2751	228	Chiquimulilla
2752	228	Cuilapaa​
2753	228	Guazacapán
2754	228	Nueva Santa Rosa
2755	228	Oratorio
2756	228	Pueblo Nuevo Viñas
2757	228	San Juan Tecuaco
2758	228	San Rafael las Flores
2759	228	Santa Cruz Naranjo
2760	228	Santa María Ixhuatán
2761	228	Santa Rosa de Lima
2762	228	Taxisco
2763	229	Concepción
2764	229	Nahualá
2765	229	Panajachel
2766	229	San Andrés Semetabaj
2767	229	San Antonio Palopó
2768	229	San José Chacayá
2769	229	San Juan La Laguna
2770	229	San Lucas Tolimán
2771	229	San Marcos La Laguna
2772	229	San Pablo La Laguna
2773	229	San Pedro La Laguna
2774	229	Santa Catarina Ixtahuacán
2775	229	Santa Catarina Palopó
2776	229	Santa Clara La Laguna
2777	229	Santa Cruz La Laguna
2778	229	Santa Lucía Utatlán
2779	229	Santa María Visitación
2780	229	Santiago Atitlán
2781	229	Sololáa​
2782	230	Chicacao
2783	230	Cuyotenango
2784	230	Mazatenangoa​
2785	230	Patulul
2786	230	Pueblo Nuevo
2787	230	Río Bravo
2788	230	Samayac
2789	230	San Antonio Suchitepéquez
2790	230	San Bernardino
2791	230	San Francisco Zapotitlán
2792	230	San Gabriel
2793	230	San José El Ídolo
2794	230	San José La Máquina
2795	230	San Juan Bautista
2796	230	San Miguel Panán
2797	230	San Pablo Jocopilas
2798	230	Santo Domingo Suchitepéquez
2799	230	Santo Tomás La Unión
2800	230	Zunilito
2801	231	Momostenango
2802	231	San Andrés Xecul
2803	231	San Bartolo
2804	231	San Cristóbal Totonicapán
2805	231	San Francisco El Alto
2806	231	Santa Lucía La Reforma
2807	231	Santa María Chiquimula
2808	231	Totonicapána​
2809	232	Cabañas
2810	232	Estanzuela
2811	232	Gualán
2812	232	Huité
2813	232	La Unión
2814	232	Río Hondo
2815	232	San Diego
2816	232	San Jorge
2817	232	Teculután
2818	232	Usumatlán
2819	233	La Ceiba
2820	233	Tela
2821	233	Jutiapa
2822	233	La Masica
2823	233	San Francisco
2824	233	Arizona
2825	233	Esparta
2826	233	El Porvenir
2827	234	Trujillo
2828	234	Balfate
2829	234	Iriona
2830	234	Limón
2831	234	Sabá
2832	234	Santa Fe
2833	234	Santa Rosa de Aguán
2834	234	Sonaguera
2835	234	Tocoa
2836	234	Bonito Oriental
2837	235	Comayagua
2838	235	Ajuterique
2839	235	El Rosario
2840	235	Esquías
2841	235	Humuya
2842	235	La libertad
2843	235	Lamaní
2844	235	La Trinidad
2845	235	Lejamani
2846	235	Meambar
2847	235	Minas de Oro
2848	235	Ojos de Agua
2849	235	San Jerónimo (Honduras)
2850	235	San José de Comayagua
2851	235	San José del Potrero
2852	235	San Luis
2853	235	San Sebastián
2854	235	Siguatepeque
2855	235	Villa de San Antonio
2856	235	Las Lajas
2857	235	Taulabé
2858	236	Santa Rosa de Copán
2859	236	Cabañas
2860	236	Concepción
2861	236	Copán Ruinas
2862	236	Corquín
2863	236	Cucuyagua
2864	236	Dolores
2865	236	Dulce Nombre
2866	236	El Paraíso
2867	236	Florida
2868	236	La Jigua
2869	236	La Unión
2870	236	Nueva Arcadia
2871	236	San Agustín
2872	236	San Antonio
2873	236	San Jerónimo
2874	236	San José
2875	236	San Juan de Opoa
2876	236	San Nicolás
2877	236	San Pedro
2878	236	Santa Rita
2879	236	Trinidad de Copán
2880	236	Veracruz
2881	237	San Pedro Sula
2882	237	Choloma
2883	237	Omoa
2884	237	Pimienta
2885	237	Potrerillos
2886	237	Puerto Cortés
2887	237	San Antonio de Cortés
2888	237	San Francisco de Yojoa
2889	237	San Manuel
2890	237	Santa Cruz de Yojoa
2891	237	Villanueva
2892	237	La Lima
2893	238	Choluteca
2894	238	Apacilagua
2895	238	Concepción de María
2896	238	Duyure
2897	238	El Corpus
2898	238	El Triunfo
2899	238	Marcovia
2900	238	Morolica
2901	238	Namasigue
2902	238	Orocuina
2903	238	Pespire
2904	238	San Antonio de Flores
2905	238	San Isidro
2906	238	San Marcos de Colón
2907	238	Santa Ana de Yusguare
2908	239	Yuscarán
2909	239	Alauca
2910	239	Danlí
2911	239	Güinope
2912	239	Jacaleapa
2913	239	Liure
2914	239	Morocelí
2915	239	Oropolí
2916	239	San Lucas
2917	239	San Matías
2918	239	Soledad
2919	239	Teupasenti
2920	239	Texiguat
2921	239	Vado Ancho
2922	239	Yauyupe
2923	239	Trojes
2924	240	Distrito Central
2925	240	Alubarén
2926	240	Cedros
2927	240	Curarén
2928	240	Guaimaca
2929	240	La Libertad
2930	240	La Venta
2931	240	Lepaterique
2932	240	Maraita
2933	240	Marale
2934	240	Nueva Armenia
2935	240	Ojojona
2936	240	Orica
2937	240	Reitoca
2938	240	Sabanagrande
2939	240	San Antonio de Oriente
2940	240	San Buenaventura
2941	240	San Ignacio
2942	240	San Juan de Flores
2943	240	San Miguelito
2944	240	Santa Ana
2945	240	Santa Lucía
2946	240	Talanga
2947	240	Tatumbla
2948	240	Valle de Ángeles
2949	240	Villa de San Francisco
2950	240	Vallecillo
2951	241	Puerto Lempira
2952	241	Brus Laguna
2953	241	Ahuas
2954	241	Juan Francisco Bulnes
2955	241	Ramón Villeda Morales
2956	241	Wampusirpe
2957	242	La Esperanza
2958	242	Camasca
2959	242	Colomoncagua
2960	242	Intibucá
2961	242	Jesús de Otoro
2962	242	Magdalena
2963	242	Masaguara
2964	242	San Juan
2965	242	San Marcos de la Sierra
2966	242	San Miguel Guancapla
2967	242	Yamaranguila
2968	242	San Francisco de Opalaca
2969	243	Roatán
2970	243	Guanaja
2971	243	José Santos Guardiola
2972	243	Utila
2973	244	La Paz
2974	244	Aguanqueterique
2975	244	Cane
2976	244	Chinacla
2977	244	Guajiquiro
2978	244	Lauterique
2979	244	Marcala
2980	244	Mercedes de Oriente
2981	244	Opatoro
2982	244	San Antonio del Norte
2983	244	San Pedro de Tutule
2984	244	Santa Elena
2985	244	Santa María
2986	244	Santiago de Puringla
2987	244	Yarula
2988	245	Gracias
2989	245	Belén
2990	245	Candelaria
2991	245	Cololaca
2992	245	Erandique
2993	245	Gualcince
2994	245	Guarita
2995	245	La Campa
2996	245	La Iguala
2997	245	Las Flores
2998	245	La Virtud
2999	245	Lepaera
3000	245	Mapulaca
3001	245	Piraera
3002	245	San Andrés
3003	245	San Juan Guarita
3004	245	San Manuel Colohete
3005	245	San Rafael
3006	245	Santa Cruz
3007	245	Talgua
3008	245	Tambla
3009	245	Tomalá
3010	245	Valladolid
3011	245	Virginia
3012	245	San Marcos de Caiquín
3013	246	Ocotepeque
3014	246	Belén Gualcho
3015	246	Dolores Merendón
3016	246	Fraternidad
3017	246	La Encarnación
3018	246	La Labor
3019	246	Lucerna
3020	246	Mercedes
3021	246	San Fernando
3022	246	San Francisco del Valle
3023	246	San Jorge
3024	246	San Marcos
3025	246	Sensenti
3026	246	Sinuapa
3027	247	Juticalpa
3028	247	Campamento
3029	247	Catacamas
3030	247	Concordia
3031	247	Dulce Nombre de Culmí
3032	247	Esquipulas del Norte
3033	247	Gualaco
3034	247	Guarizama
3035	247	Guata
3036	247	Guayape
3037	247	Jano
3038	247	Mangulile
3039	247	Manto
3040	247	Salamá
3041	247	San Esteban
3042	247	San Francisco de Becerra
3043	247	San Francisco de la Paz
3044	247	Santa María del Real
3045	247	Silca
3046	247	Yocón
3047	247	Patuca
3048	248	Santa Bárbara
3049	248	Arada
3050	248	Atima
3051	248	Azacualpa
3052	248	Ceguaca
3053	248	Concepción del Norte
3054	248	Concepción del Sur
3055	248	Chinda
3056	248	El Níspero
3057	248	Gualala
3058	248	Ilama
3059	248	Las Vegas
3060	248	Macuelizo
3061	248	Naranjito
3062	248	Nuevo Celilac
3063	248	Nueva Frontera
3064	248	Petoa
3065	248	Protección
3066	248	Quimistán
3067	248	San Francisco de Ojuera
3068	248	San José de las Colinas
3069	248	San Pedro Zacapa
3070	248	San Vicente Centenario
3071	248	Trinidad
3072	249	Nacaome
3073	249	Alianza
3074	249	Amapala
3075	249	Aramecina
3076	249	Caridad
3077	249	Goascorán
3078	249	Langue
3079	249	San Francisco de Coray
3080	249	San Lorenzo
3081	250	Yoro
3082	250	Arenal
3083	250	El Negrito
3084	250	El Progreso
3085	250	Jocón
3086	250	Morazán
3087	250	Olanchito
3088	250	Sulaco
3089	250	Victoria
3090	251	Boaco
3091	251	Camoapa
3092	251	San José de los Remates
3093	251	San Lorenzo
3094	251	Santa Lucía
3095	251	Teustepe
3096	252	Diriamba
3097	252	Dolores
3098	252	El Rosario
3099	252	Jinotepe
3100	252	La Conquista
3101	252	La Paz de Oriente
3102	252	San Marcos
3103	252	Santa Teresa
3104	253	Chichigalpa
3105	253	Chinandega
3106	253	Cinco Pinos
3107	253	Corinto
3108	253	El Realejo
3109	253	El Viejo
3110	253	Posoltega
3111	253	Puerto Morazán
3112	253	San Francisco del Norte
3113	253	San Pedro del Norte
3114	253	Santo Tomás del Norte
3115	253	Somotillo
3116	253	Villanueva
3117	254	Acoyapa
3118	254	Comalapa
3119	254	Cuapa
3120	254	El Coral
3121	254	Juigalpa
3122	254	La Libertad
3123	254	San Pedro de Lóvago
3124	254	Santo Domingo
3125	254	Santo Tomás
3126	254	Villa Sandino
3127	255	Bonanza
3128	255	Mulukukú
3129	255	Prinzapolka
3130	255	Puerto Cabezas
3131	255	Rosita
3132	255	Siuna
3133	255	Waslala
3134	255	Waspán
3135	256	Bluefields
3136	256	Desembocadura de Río Grande
3137	256	El Ayote
3138	256	El Rama
3139	256	El Tortuguero
3140	256	Islas del Maíz
3141	256	Kukra Hill
3142	256	La Cruz de Río Grande
3143	256	Laguna de Perlas
3144	256	Muelle de los Bueyes
3145	256	Nueva Guinea
3146	256	Paiwas
3147	257	Condega
3148	257	Estelí
3149	257	La Trinidad
3150	257	Pueblo Nuevo
3151	257	San Juan de Limay
3152	257	San Nicolás
3153	258	Diriá
3154	258	Diriomo
3155	258	Granada
3156	258	Nandaime
3157	259	El Cuá
3158	259	Jinotega
3159	259	La Concordia
3160	259	San José de Bocay
3161	259	San Rafael del Norte
3162	259	San Sebastián de Yalí
3163	259	Santa María de Pantasma
3164	259	Wiwilí de Jinotega
3165	260	Achuapa
3166	260	El Jicaral
3167	260	El Sauce
3168	260	La Paz Centro
3169	260	Larreynaga
3170	260	León
3171	260	Nagarote
3172	260	Quezalguaque
3173	260	Santa Rosa del Peñón
3174	260	Telica
3175	261	Las Sabanas
3176	261	Palacagüina
3177	261	San José de Cusmapa
3178	261	San Juan de Río Coco
3179	261	San Lucas
3180	261	Somoto
3181	261	Telpaneca
3182	261	Totogalpa
3183	261	Yalagüina
3184	262	Ciudad Sandino
3185	262	El Crucero
3186	262	Managua
3187	262	Mateare
3188	262	San Francisco Libre
3189	262	San Rafael del Sur
3190	262	Ticuantepe
3191	262	Tipitapa
3192	262	Villa El Carmen
3193	263	Catarina
3194	263	La Concepción
3195	263	Masatepe
3196	263	Masaya
3197	263	Nandasmo
3198	263	Nindirí
3199	263	Niquinohomo
3200	263	San Juan de Oriente
3201	263	Tisma
3202	264	Ciudad Darío
3203	264	El Tuma - La Dalia
3204	264	Esquipulas
3205	264	Matagalpa
3206	264	Matiguás
3207	264	Muy Muy
3208	264	Rancho Grande
3209	264	Río Blanco
3210	264	San Dionisio
3211	264	San Isidro
3212	264	San Ramón
3213	264	Sébaco
3214	264	Terrabona
3215	265	Ciudad Antigua
3216	265	Dipilto
3217	265	El Jícaro
3218	265	Jalapa
3219	265	Macuelizo
3220	265	Mozonte
3221	265	Murra
3222	265	Ocotal
3223	265	Quilalí
3224	265	San Fernando
3225	265	Santa María
3226	265	Wiwilí
3227	266	El Almendro
3228	266	El Castillo
3229	266	Morrito
3230	266	San Carlos
3231	266	San Juan del Norte
3232	266	San Miguelito
3233	267	Altagracia
3234	267	Belén
3235	267	Buenos Aires
3236	267	Cárdenas
3237	267	Moyogalpa
3238	267	Potosí
3239	267	Rivas
3240	267	San Jorge
3241	267	San Juan del Sur
3242	268	AGUASCALIENTES
3243	268	ASIENTOS
3244	268	CALVILLO
3245	268	COSÍO
3246	268	JESÚS MARÍA
3247	268	PABELLÓN DE ARTEAGA
3248	268	RINCÓN DE ROMOS
3249	268	SAN JOSÉ DE GRACIA
3250	268	TEPEZALÁ
3251	268	EL LLANO
3252	268	SAN FRANCISCO DE LOS ROMO
3253	269	ENSENADA
3254	269	MEXICALI
3255	269	TECATE
3256	269	TIJUANA
3257	269	PLAYAS DE ROSARITO
3258	270	COMONDÚ
3259	270	MULEGÉ
3260	270	LA PAZ
3261	270	LOS CABOS
3262	270	LORETO
3263	271	CALKINÍ
3264	271	CAMPECHE
3265	271	CARMEN
3266	271	CHAMPOTÓN
3267	271	HECELCHAKÁN
3268	271	HOPELCHÉN
3269	271	PALIZADA
3270	271	TENABO
3271	271	ESCÁRCEGA
3272	271	CALAKMUL
3273	271	CANDELARIA
3274	272	ACACOYAGUA
3275	272	ACALA
3276	272	ACAPETAHUA
3277	272	ALTAMIRANO
3278	272	AMATÁN
3279	272	AMATENANGO DE LA FRONTERA
3280	272	AMATENANGO DEL VALLE
3281	272	ANGEL ALBINO CORZO
3282	272	ARRIAGA
3283	272	BEJUCAL DE OCAMPO
3284	272	BELLA VISTA
3285	272	BERRIOZÁBAL
3286	272	BOCHIL
3287	272	EL BOSQUE
3288	272	CACAHOATÁN
3289	272	CATAZAJÁ
3290	272	CINTALAPA
3291	272	COAPILLA
3292	272	COMITÁN DE DOMÍNGUEZ
3293	272	LA CONCORDIA
3294	272	COPAINALÁ
3295	272	CHALCHIHUITÁN
3296	272	CHAMULA
3297	272	CHANAL
3298	272	CHAPULTENANGO
3299	272	CHENALHÓ
3300	272	CHIAPA DE CORZO
3301	272	CHIAPILLA
3302	272	CHICOASÉN
3303	272	CHICOMUSELO
3304	272	CHILÓN
3305	272	ESCUINTLA
3306	272	FRANCISCO LEÓN
3307	272	FRONTERA COMALAPA
3308	272	FRONTERA HIDALGO
3309	272	LA GRANDEZA
3310	272	HUEHUETÁN
3311	272	HUIXTÁN
3312	272	HUITIUPÁN
3313	272	HUIXTLA
3314	272	LA INDEPENDENCIA
3315	272	IXHUATÁN
3316	272	IXTACOMITÁN
3317	272	IXTAPA
3318	272	IXTAPANGAJOYA
3319	272	JIQUIPILAS
3320	272	JITOTOL
3321	272	JUÁREZ
3322	272	LARRÁINZAR
3323	272	LA LIBERTAD
3324	272	MAPASTEPEC
3325	272	LAS MARGARITAS
3326	272	MAZAPA DE MADERO
3327	272	MAZATÁN
3328	272	METAPA
3329	272	MITONTIC
3330	272	MOTOZINTLA
3331	272	NICOLÁS RUÍZ
3332	272	OCOSINGO
3333	272	OCOTEPEC
3334	272	OCOZOCOAUTLA DE ESPINOSA
3335	272	OSTUACÁN
3336	272	OSUMACINTA
3337	272	OXCHUC
3338	272	PALENQUE
3339	272	PANTELHÓ
3340	272	PANTEPEC
3341	272	PICHUCALCO
3342	272	PIJIJIAPAN
3343	272	EL PORVENIR
3344	272	VILLA COMALTITLÁN
3345	272	PUEBLO NUEVO SOLISTAHUACÁN
3346	272	RAYÓN
3347	272	REFORMA
3348	272	LAS ROSAS
3349	272	SABANILLA
3350	272	SALTO DE AGUA
3351	272	SAN CRISTÓBAL DE LAS CASAS
3352	272	SAN FERNANDO
3353	272	SILTEPEC
3354	272	SIMOJOVEL
3355	272	SITALÁ
3356	272	SOCOLTENANGO
3357	272	SOLOSUCHIAPA
3358	272	SOYALÓ
3359	272	SUCHIAPA
3360	272	SUCHIATE
3361	272	SUNUAPA
3362	272	TAPACHULA
3363	272	TAPALAPA
3364	272	TAPILULA
3365	272	TECPATÁN
3366	272	TENEJAPA
3367	272	TEOPISCA
3368	272	TILA
3369	272	TONALÁ
3370	272	TOTOLAPA
3371	272	LA TRINITARIA
3372	272	TUMBALÁ
3373	272	TUXTLA GUTIÉRREZ
3374	272	TUXTLA CHICO
3375	272	TUZANTÁN
3376	272	TZIMOL
3377	272	UNIÓN JUÁREZ
3378	272	VENUSTIANO CARRANZA
3379	272	VILLA CORZO
3380	272	VILLAFLORES
3381	272	YAJALÓN
3382	272	SAN LUCAS
3383	272	ZINACANTÁN
3384	272	SAN JUAN CANCUC
3385	272	ALDAMA
3386	272	BENEMÉRITO DE LAS AMÉRICAS
3387	272	MARAVILLA TENEJAPA
3388	272	MARQUÉS DE COMILLAS
3389	272	MONTECRISTO DE GUERRERO
3390	272	SAN ANDRÉS DURAZNAL
3391	272	SANTIAGO EL PINAR
3392	273	AHUMADA
3393	273	ALLENDE
3394	273	AQUILES SERDÁN
3395	273	ASCENSIÓN
3396	273	BACHÍNIVA
3397	273	BALLEZA
3398	273	BATOPILAS
3399	273	BOCOYNA
3400	273	BUENAVENTURA
3401	273	CAMARGO
3402	273	CARICHÍ
3403	273	CASAS GRANDES
3404	273	CORONADO
3405	273	COYAME DEL SOTOL
3406	273	LA CRUZ
3407	273	CUAUHTÉMOC
3408	273	CUSIHUIRIACHI
3409	273	CHIHUAHUA
3410	273	CHÍNIPAS
3411	273	DELICIAS
3412	273	DR. BELISARIO DOMÍNGUEZ
3413	273	GALEANA
3414	273	SANTA ISABEL
3415	273	GÓMEZ FARÍAS
3416	273	GRAN MORELOS
3417	273	GUACHOCHI
3418	273	GUADALUPE
3419	273	GUADALUPE Y CALVO
3420	273	GUAZAPARES
3421	273	GUERRERO
3422	273	HIDALGO DEL PARRAL
3423	273	HUEJOTITÁN
3424	273	IGNACIO ZARAGOZA
3425	273	JANOS
3426	273	JIMÉNEZ
3427	273	JULIMES
3428	273	LÓPEZ
3429	273	MADERA
3430	273	MAGUARICHI
3431	273	MANUEL BENAVIDES
3432	273	MATACHÍ
3433	273	MATAMOROS
3434	273	MEOQUI
3435	273	MORELOS
3436	273	MORIS
3437	273	NAMIQUIPA
3438	273	NONOAVA
3439	273	NUEVO CASAS GRANDES
3440	273	OCAMPO
3441	273	OJINAGA
3442	273	PRAXEDIS G. GUERRERO
3443	273	RIVA PALACIO
3444	273	ROSALES
3445	273	ROSARIO
3446	273	SAN FRANCISCO DE BORJA
3447	273	SAN FRANCISCO DE CONCHOS
3448	273	SAN FRANCISCO DEL ORO
3449	273	SANTA BÁRBARA
3450	273	SATEVÓ
3451	273	SAUCILLO
3452	273	TEMÓSACHIC
3453	273	EL TULE
3454	273	URIQUE
3455	273	URUACHI
3456	273	VALLE DE ZARAGOZA
3457	274	AZCAPOTZALCO
3458	274	COYOACÁN
3459	274	CUAJIMALPA DE MORELOS
3460	274	GUSTAVO A. MADERO
3461	274	IZTACALCO
3462	274	IZTAPALAPA
3463	274	LA MAGDALENA CONTRERAS
3464	274	MILPA ALTA
3465	274	ÁLVARO OBREGÓN
3466	274	TLÁHUAC
3467	274	TLALPAN
3468	274	XOCHIMILCO
3469	274	BENITO JUÁREZ
3470	274	MIGUEL HIDALGO
3471	275	ABASOLO
3472	275	ACUÑA
3473	275	ARTEAGA
3474	275	CANDELA
3475	275	CASTAÑOS
3476	275	CUATRO CIÉNEGAS
3477	275	ESCOBEDO
3478	275	FRANCISCO I. MADERO
3479	275	FRONTERA
3480	275	GENERAL CEPEDA
3481	275	HIDALGO
3482	275	LAMADRID
3483	275	MONCLOVA
3484	275	MÚZQUIZ
3485	275	NADADORES
3486	275	NAVA
3487	275	PARRAS
3488	275	PIEDRAS NEGRAS
3489	275	PROGRESO
3490	275	RAMOS ARIZPE
3491	275	SABINAS
3492	275	SACRAMENTO
3493	275	SALTILLO
3494	275	SAN BUENAVENTURA
3495	275	SAN JUAN DE SABINAS
3496	275	SAN PEDRO
3497	275	SIERRA MOJADA
3498	275	TORREÓN
3499	275	VIESCA
3500	275	VILLA UNIÓN
3501	275	ZARAGOZA
3502	276	ARMERÍA
3503	276	COLIMA
3504	276	COMALA
3505	276	COQUIMATLÁN
3506	276	IXTLAHUACÁN
3507	276	MANZANILLO
3508	276	MINATITLÁN
3509	276	TECOMÁN
3510	276	VILLA DE ÁLVAREZ
3511	277	DURANGO
3512	277	CANATLÁN
3513	277	CANELAS
3514	277	CONETO DE COMONFORT
3515	277	CUENCAMÉ
3516	277	GENERAL SIMÓN BOLÍVAR
3517	277	GÓMEZ PALACIO
3518	277	GUADALUPE VICTORIA
3519	277	GUANACEVÍ
3520	277	INDÉ
3521	277	LERDO
3522	277	MAPIMÍ
3523	277	MEZQUITAL
3524	277	NAZAS
3525	277	NOMBRE DE DIOS
3526	277	EL ORO
3527	277	OTÁEZ
3528	277	PÁNUCO DE CORONADO
3529	277	PEÑÓN BLANCO
3530	277	POANAS
3531	277	PUEBLO NUEVO
3532	277	RODEO
3533	277	SAN BERNARDO
3534	277	SAN DIMAS
3535	277	SAN JUAN DE GUADALUPE
3536	277	SAN JUAN DEL RÍO
3537	277	SAN LUIS DEL CORDERO
3538	277	SAN PEDRO DEL GALLO
3539	277	SANTA CLARA
3540	277	SANTIAGO PAPASQUIARO
3541	277	SÚCHIL
3542	277	TAMAZULA
3543	277	TEPEHUANES
3544	277	TLAHUALILO
3545	277	TOPIA
3546	277	VICENTE GUERRERO
3547	277	NUEVO IDEAL
3548	278	ACÁMBARO
3549	278	SAN MIGUEL DE ALLENDE
3550	278	APASEO EL ALTO
3551	278	APASEO EL GRANDE
3552	278	ATARJEA
3553	278	CELAYA
3554	278	MANUEL DOBLADO
3555	278	COMONFORT
3556	278	CORONEO
3557	278	CORTAZAR
3558	278	CUERÁMARO
3559	278	DOCTOR MORA
3560	278	DOLORES HIDALGO CUNA DE LA INDEPENDENCIA NACIONAL
3561	278	GUANAJUATO
3562	278	HUANÍMARO
3563	278	IRAPUATO
3564	278	JARAL DEL PROGRESO
3565	278	JERÉCUARO
3566	278	LEÓN
3567	278	MOROLEÓN
3568	278	PÉNJAMO
3569	278	PURÍSIMA DEL RINCÓN
3570	278	ROMITA
3571	278	SALAMANCA
3572	278	SALVATIERRA
3573	278	SAN DIEGO DE LA UNIÓN
3574	278	SAN FELIPE
3575	278	SAN FRANCISCO DEL RINCÓN
3576	278	SAN JOSÉ ITURBIDE
3577	278	SAN LUIS DE LA PAZ
3578	278	SANTA CATARINA
3579	278	SANTA CRUZ DE JUVENTINO ROSAS
3580	278	SANTIAGO MARAVATÍO
3581	278	SILAO DE LA VICTORIA
3582	278	TARANDACUAO
3583	278	TARIMORO
3584	278	TIERRA BLANCA
3585	278	URIANGATO
3586	278	VALLE DE SANTIAGO
3587	278	VICTORIA
3588	278	VILLAGRÁN
3589	278	XICHÚ
3590	278	YURIRIA
3591	279	ACAPULCO DE JUÁREZ
3592	279	AHUACUOTZINGO
3593	279	AJUCHITLÁN DEL PROGRESO
3594	279	ALCOZAUCA DE GUERRERO
3595	279	ALPOYECA
3596	279	APAXTLA
3597	279	ARCELIA
3598	279	ATENANGO DEL RÍO
3599	279	ATLAMAJALCINGO DEL MONTE
3600	279	ATLIXTAC
3601	279	ATOYAC DE ÁLVAREZ
3602	279	AYUTLA DE LOS LIBRES
3603	279	AZOYÚ
3604	279	BUENAVISTA DE CUÉLLAR
3605	279	COAHUAYUTLA DE JOSÉ MARÍA IZAZAGA
3606	279	COCULA
3607	279	COPALA
3608	279	COPALILLO
3609	279	COPANATOYAC
3610	279	COYUCA DE BENÍTEZ
3611	279	COYUCA DE CATALÁN
3612	279	CUAJINICUILAPA
3613	279	CUALÁC
3614	279	CUAUTEPEC
3615	279	CUETZALA DEL PROGRESO
3616	279	CUTZAMALA DE PINZÓN
3617	279	CHILAPA DE ÁLVAREZ
3618	279	CHILPANCINGO DE LOS BRAVO
3619	279	FLORENCIO VILLARREAL
3620	279	GENERAL CANUTO A. NERI
3621	279	GENERAL HELIODORO CASTILLO
3622	279	HUAMUXTITLÁN
3623	279	HUITZUCO DE LOS FIGUEROA
3624	279	IGUALA DE LA INDEPENDENCIA
3625	279	IGUALAPA
3626	279	IXCATEOPAN DE CUAUHTÉMOC
3627	279	ZIHUATANEJO DE AZUETA
3628	279	JUAN R. ESCUDERO
3629	279	LEONARDO BRAVO
3630	279	MALINALTEPEC
3631	279	MÁRTIR DE CUILAPAN
3632	279	METLATÓNOC
3633	279	MOCHITLÁN
3634	279	OLINALÁ
3635	279	OMETEPEC
3636	279	PEDRO ASCENCIO ALQUISIRAS
3637	279	PETATLÁN
3638	279	PILCAYA
3639	279	PUNGARABATO
3640	279	QUECHULTENANGO
3641	279	SAN LUIS ACATLÁN
3642	279	SAN MARCOS
3643	279	SAN MIGUEL TOTOLAPAN
3644	279	TAXCO DE ALARCÓN
3645	279	TECOANAPA
3646	279	TÉCPAN DE GALEANA
3647	279	TELOLOAPAN
3648	279	TEPECOACUILCO DE TRUJANO
3649	279	TETIPAC
3650	279	TIXTLA DE GUERRERO
3651	279	TLACOACHISTLAHUACA
3652	279	TLACOAPA
3653	279	TLALCHAPA
3654	279	TLALIXTAQUILLA DE MALDONADO
3655	279	TLAPA DE COMONFORT
3656	279	TLAPEHUALA
3657	279	LA UNIÓN DE ISIDORO MONTES DE OCA
3658	279	XALPATLÁHUAC
3659	279	XOCHIHUEHUETLÁN
3660	279	XOCHISTLAHUACA
3661	279	ZAPOTITLÁN TABLAS
3662	279	ZIRÁNDARO
3663	279	ZITLALA
3664	279	EDUARDO NERI
3665	279	ACATEPEC
3666	279	MARQUELIA
3667	279	COCHOAPA EL GRANDE
3668	279	JOSÉ JOAQUÍN DE HERRERA
3669	279	JUCHITÁN
3670	279	ILIATENCO
3671	280	ACATLÁN
3672	280	ACAXOCHITLÁN
3673	280	ACTOPAN
3674	280	AGUA BLANCA DE ITURBIDE
3675	280	AJACUBA
3676	280	ALFAJAYUCAN
3677	280	ALMOLOYA
3678	280	APAN
3679	280	EL ARENAL
3680	280	ATITALAQUIA
3681	280	ATLAPEXCO
3682	280	ATOTONILCO EL GRANDE
3683	280	ATOTONILCO DE TULA
3684	280	CALNALI
3685	280	CARDONAL
3686	280	CUAUTEPEC DE HINOJOSA
3687	280	CHAPANTONGO
3688	280	CHAPULHUACÁN
3689	280	CHILCUAUTLA
3690	280	ELOXOCHITLÁN
3691	280	EMILIANO ZAPATA
3692	280	EPAZOYUCAN
3693	280	HUASCA DE OCAMPO
3694	280	HUAUTLA
3695	280	HUAZALINGO
3696	280	HUEHUETLA
3697	280	HUEJUTLA DE REYES
3698	280	HUICHAPAN
3699	280	IXMIQUILPAN
3700	280	JACALA DE LEDEZMA
3701	280	JALTOCÁN
3702	280	JUÁREZ HIDALGO
3703	280	LOLOTLA
3704	280	METEPEC
3705	280	SAN AGUSTÍN METZQUITITLÁN
3706	280	METZTITLÁN
3707	280	MINERAL DEL CHICO
3708	280	MINERAL DEL MONTE
3709	280	LA MISIÓN
3710	280	MIXQUIAHUALA DE JUÁREZ
3711	280	MOLANGO DE ESCAMILLA
3712	280	NICOLÁS FLORES
3713	280	NOPALA DE VILLAGRÁN
3714	280	OMITLÁN DE JUÁREZ
3715	280	SAN FELIPE ORIZATLÁN
3716	280	PACULA
3717	280	PACHUCA DE SOTO
3718	280	PISAFLORES
3719	280	PROGRESO DE OBREGÓN
3720	280	MINERAL DE LA REFORMA
3721	280	SAN AGUSTÍN TLAXIACA
3722	280	SAN BARTOLO TUTOTEPEC
3723	280	SAN SALVADOR
3724	280	SANTIAGO DE ANAYA
3725	280	SANTIAGO TULANTEPEC DE LUGO GUERRERO
3726	280	SINGUILUCAN
3727	280	TASQUILLO
3728	280	TECOZAUTLA
3729	280	TENANGO DE DORIA
3730	280	TEPEAPULCO
3731	280	TEPEHUACÁN DE GUERRERO
3732	280	TEPEJI DEL RÍO DE OCAMPO
3733	280	TEPETITLÁN
3734	280	TETEPANGO
3735	280	VILLA DE TEZONTEPEC
3736	280	TEZONTEPEC DE ALDAMA
3737	280	TIANGUISTENGO
3738	280	TIZAYUCA
3739	280	TLAHUELILPAN
3740	280	TLAHUILTEPA
3741	280	TLANALAPA
3742	280	TLANCHINOL
3743	280	TLAXCOAPAN
3744	280	TOLCAYUCA
3745	280	TULA DE ALLENDE
3746	280	TULANCINGO DE BRAVO
3747	280	XOCHIATIPAN
3748	280	XOCHICOATLÁN
3749	280	YAHUALICA
3750	280	ZACUALTIPÁN DE ÁNGELES
3751	280	ZAPOTLÁN DE JUÁREZ
3752	280	ZEMPOALA
3753	280	ZIMAPÁN
3754	281	ACATIC
3755	281	ACATLÁN DE JUÁREZ
3756	281	AHUALULCO DE MERCADO
3757	281	AMACUECA
3758	281	AMATITÁN
3759	281	AMECA
3760	281	SAN JUANITO DE ESCOBEDO
3761	281	ARANDAS
3762	281	ATEMAJAC DE BRIZUELA
3763	281	ATENGO
3764	281	ATENGUILLO
3765	281	ATOTONILCO EL ALTO
3766	281	ATOYAC
3767	281	AUTLÁN DE NAVARRO
3768	281	AYOTLÁN
3769	281	AYUTLA
3770	281	LA BARCA
3771	281	BOLAÑOS
3772	281	CABO CORRIENTES
3773	281	CASIMIRO CASTILLO
3774	281	CIHUATLÁN
3775	281	ZAPOTLÁN EL GRANDE
3776	281	COLOTLÁN
3777	281	CONCEPCIÓN DE BUENOS AIRES
3778	281	CUAUTITLÁN DE GARCÍA BARRAGÁN
3779	281	CUAUTLA
3780	281	CUQUÍO
3781	281	CHAPALA
3782	281	CHIMALTITÁN
3783	281	CHIQUILISTLÁN
3784	281	DEGOLLADO
3785	281	EJUTLA
3786	281	ENCARNACIÓN DE DÍAZ
3787	281	ETZATLÁN
3788	281	EL GRULLO
3789	281	GUACHINANGO
3790	281	GUADALAJARA
3791	281	HOSTOTIPAQUILLO
3792	281	HUEJÚCAR
3793	281	HUEJUQUILLA EL ALTO
3794	281	LA HUERTA
3795	281	IXTLAHUACÁN DE LOS MEMBRILLOS
3796	281	IXTLAHUACÁN DEL RÍO
3797	281	JALOSTOTITLÁN
3798	281	JAMAY
3799	281	JILOTLÁN DE LOS DOLORES
3800	281	JOCOTEPEC
3801	281	JUANACATLÁN
3802	281	JUCHITLÁN
3803	281	LAGOS DE MORENO
3804	281	EL LIMÓN
3805	281	MAGDALENA
3806	281	SANTA MARÍA DEL ORO
3807	281	LA MANZANILLA DE LA PAZ
3808	281	MASCOTA
3809	281	MAZAMITLA
3810	281	MEXTICACÁN
3811	281	MEZQUITIC
3812	281	MIXTLÁN
3813	281	OCOTLÁN
3814	281	OJUELOS DE JALISCO
3815	281	PIHUAMO
3816	281	PONCITLÁN
3817	281	PUERTO VALLARTA
3818	281	VILLA PURIFICACIÓN
3819	281	QUITUPAN
3820	281	EL SALTO
3821	281	SAN CRISTÓBAL DE LA BARRANCA
3822	281	SAN DIEGO DE ALEJANDRÍA
3823	281	SAN JUAN DE LOS LAGOS
3824	281	SAN JULIÁN
3825	281	SAN MARTÍN DE BOLAÑOS
3826	281	SAN MARTÍN HIDALGO
3827	281	SAN MIGUEL EL ALTO
3828	281	SAN SEBASTIÁN DEL OESTE
3829	281	SANTA MARÍA DE LOS ÁNGELES
3830	281	SAYULA
3831	281	TALA
3832	281	TALPA DE ALLENDE
3833	281	TAMAZULA DE GORDIANO
3834	281	TAPALPA
3835	281	TECALITLÁN
3836	281	TECOLOTLÁN
3837	281	TECHALUTA DE MONTENEGRO
3838	281	TENAMAXTLÁN
3839	281	TEOCALTICHE
3840	281	TEOCUITATLÁN DE CORONA
3841	281	TEPATITLÁN DE MORELOS
3842	281	TEQUILA
3843	281	TEUCHITLÁN
3844	281	TIZAPÁN EL ALTO
3845	281	TLAJOMULCO DE ZÚÑIGA
3846	281	SAN PEDRO TLAQUEPAQUE
3847	281	TOLIMÁN
3848	281	TOMATLÁN
3849	281	TONAYA
3850	281	TONILA
3851	281	TOTATICHE
3852	281	TOTOTLÁN
3853	281	TUXCACUESCO
3854	281	TUXCUECA
3855	281	TUXPAN
3856	281	UNIÓN DE SAN ANTONIO
3857	281	UNIÓN DE TULA
3858	281	VALLE DE GUADALUPE
3859	281	VALLE DE JUÁREZ
3860	281	SAN GABRIEL
3861	281	VILLA CORONA
3862	281	VILLA GUERRERO
3863	281	VILLA HIDALGO
3864	281	CAÑADAS DE OBREGÓN
3865	281	YAHUALICA DE GONZÁLEZ GALLO
3866	281	ZACOALCO DE TORRES
3867	281	ZAPOPAN
3868	281	ZAPOTILTIC
3869	281	ZAPOTITLÁN DE VADILLO
3870	281	ZAPOTLÁN DEL REY
3871	281	ZAPOTLANEJO
3872	281	SAN IGNACIO CERRO GORDO
3873	282	ACAMBAY DE RUÍZ CASTAÑEDA
3874	282	ACOLMAN
3875	282	ACULCO
3876	282	ALMOLOYA DE ALQUISIRAS
3877	282	ALMOLOYA DE JUÁREZ
3878	282	ALMOLOYA DEL RÍO
3879	282	AMANALCO
3880	282	AMATEPEC
3881	282	AMECAMECA
3882	282	APAXCO
3883	282	ATENCO
3884	282	ATIZAPÁN
3885	282	ATIZAPÁN DE ZARAGOZA
3886	282	ATLACOMULCO
3887	282	ATLAUTLA
3888	282	AXAPUSCO
3889	282	AYAPANGO
3890	282	CALIMAYA
3891	282	CAPULHUAC
3892	282	COACALCO DE BERRIOZÁBAL
3893	282	COATEPEC HARINAS
3894	282	COCOTITLÁN
3895	282	COYOTEPEC
3896	282	CUAUTITLÁN
3897	282	CHALCO
3898	282	CHAPA DE MOTA
3899	282	CHAPULTEPEC
3900	282	CHIAUTLA
3901	282	CHICOLOAPAN
3902	282	CHICONCUAC
3903	282	CHIMALHUACÁN
3904	282	DONATO GUERRA
3905	282	ECATEPEC DE MORELOS
3906	282	ECATZINGO
3907	282	HUEHUETOCA
3908	282	HUEYPOXTLA
3909	282	HUIXQUILUCAN
3910	282	ISIDRO FABELA
3911	282	IXTAPALUCA
3912	282	IXTAPAN DE LA SAL
3913	282	IXTAPAN DEL ORO
3914	282	IXTLAHUACA
3915	282	XALATLACO
3916	282	JALTENCO
3917	282	JILOTEPEC
3918	282	JILOTZINGO
3919	282	JIQUIPILCO
3920	282	JOCOTITLÁN
3921	282	JOQUICINGO
3922	282	JUCHITEPEC
3923	282	LERMA
3924	282	MALINALCO
3925	282	MELCHOR OCAMPO
3926	282	MEXICALTZINGO
3927	282	NAUCALPAN DE JUÁREZ
3928	282	NEZAHUALCÓYOTL
3929	282	NEXTLALPAN
3930	282	NICOLÁS ROMERO
3931	282	NOPALTEPEC
3932	282	OCOYOACAC
3933	282	OCUILAN
3934	282	OTUMBA
3935	282	OTZOLOAPAN
3936	282	OTZOLOTEPEC
3937	282	OZUMBA
3938	282	PAPALOTLA
3939	282	POLOTITLÁN
3940	282	SAN ANTONIO LA ISLA
3941	282	SAN FELIPE DEL PROGRESO
3942	282	SAN MARTÍN DE LAS PIRÁMIDES
3943	282	SAN MATEO ATENCO
3944	282	SAN SIMÓN DE GUERRERO
3945	282	SANTO TOMÁS
3946	282	SOYANIQUILPAN DE JUÁREZ
3947	282	SULTEPEC
3948	282	TECÁMAC
3949	282	TEJUPILCO
3950	282	TEMAMATLA
3951	282	TEMASCALAPA
3952	282	TEMASCALCINGO
3953	282	TEMASCALTEPEC
3954	282	TEMOAYA
3955	282	TENANCINGO
3956	282	TENANGO DEL AIRE
3957	282	TENANGO DEL VALLE
3958	282	TEOLOYUCAN
3959	282	TEOTIHUACÁN
3960	282	TEPETLAOXTOC
3961	282	TEPETLIXPA
3962	282	TEPOTZOTLÁN
3963	282	TEQUIXQUIAC
3964	282	TEXCALTITLÁN
3965	282	TEXCALYACAC
3966	282	TEXCOCO
3967	282	TEZOYUCA
3968	282	TIANGUISTENCO
3969	282	TIMILPAN
3970	282	TLALMANALCO
3971	282	TLALNEPANTLA DE BAZ
3972	282	TLATLAYA
3973	282	TOLUCA
3974	282	TONATICO
3975	282	TULTEPEC
3976	282	TULTITLÁN
3977	282	VALLE DE BRAVO
3978	282	VILLA DE ALLENDE
3979	282	VILLA DEL CARBÓN
3980	282	VILLA VICTORIA
3981	282	XONACATLÁN
3982	282	ZACAZONAPAN
3983	282	ZACUALPAN
3984	282	ZINACANTEPEC
3985	282	ZUMPAHUACÁN
3986	282	ZUMPANGO
3987	282	CUAUTITLÁN IZCALLI
3988	282	VALLE DE CHALCO SOLIDARIDAD
3989	282	LUVIANOS
3990	282	SAN JOSÉ DEL RINCÓN
3991	282	TONANITLA
3992	283	ACUITZIO
3993	283	AGUILILLA
3994	283	ANGAMACUTIRO
3995	283	ANGANGUEO
3996	283	APATZINGÁN
3997	283	APORO
3998	283	AQUILA
3999	283	ARIO
4000	283	BRISEÑAS
4001	283	BUENAVISTA
4002	283	CARÁCUARO
4003	283	COAHUAYANA
4004	283	COALCOMÁN DE VÁZQUEZ PALLARES
4005	283	COENEO
4006	283	CONTEPEC
4007	283	COPÁNDARO
4008	283	COTIJA
4009	283	CUITZEO
4010	283	CHARAPAN
4011	283	CHARO
4012	283	CHAVINDA
4013	283	CHERÁN
4014	283	CHILCHOTA
4015	283	CHINICUILA
4016	283	CHUCÁNDIRO
4017	283	CHURINTZIO
4018	283	CHURUMUCO
4019	283	ECUANDUREO
4020	283	EPITACIO HUERTA
4021	283	ERONGARÍCUARO
4022	283	GABRIEL ZAMORA
4023	283	LA HUACANA
4024	283	HUANDACAREO
4025	283	HUANIQUEO
4026	283	HUETAMO
4027	283	HUIRAMBA
4028	283	INDAPARAPEO
4029	283	IRIMBO
4030	283	IXTLÁN
4031	283	JACONA
4032	283	JIQUILPAN
4033	283	JUNGAPEO
4034	283	LAGUNILLAS
4035	283	MADERO
4036	283	MARAVATÍO
4037	283	MARCOS CASTELLANOS
4038	283	LÁZARO CÁRDENAS
4039	283	MORELIA
4040	283	MÚGICA
4041	283	NAHUATZEN
4042	283	NOCUPÉTARO
4043	283	NUEVO PARANGARICUTIRO
4044	283	NUEVO URECHO
4045	283	NUMARÁN
4046	283	PAJACUARÁN
4047	283	PANINDÍCUARO
4048	283	PARÁCUARO
4049	283	PARACHO
4050	283	PÁTZCUARO
4051	283	PENJAMILLO
4052	283	PERIBÁN
4053	283	LA PIEDAD
4054	283	PURÉPERO
4055	283	PURUÁNDIRO
4056	283	QUERÉNDARO
4057	283	QUIROGA
4058	283	COJUMATLÁN DE RÉGULES
4059	283	LOS REYES
4060	283	SAHUAYO
4061	283	SANTA ANA MAYA
4062	283	SALVADOR ESCALANTE
4063	283	SENGUIO
4064	283	SUSUPUATO
4065	283	TACÁMBARO
4066	283	TANCÍTARO
4067	283	TANGAMANDAPIO
4068	283	TANGANCÍCUARO
4069	283	TANHUATO
4070	283	TARETAN
4071	283	TARÍMBARO
4072	283	TEPALCATEPEC
4073	283	TINGAMBATO
4074	283	TINGÜINDÍN
4075	283	TIQUICHEO DE NICOLÁS ROMERO
4076	283	TLALPUJAHUA
4077	283	TLAZAZALCA
4078	283	TOCUMBO
4079	283	TUMBISCATÍO
4080	283	TURICATO
4081	283	TUZANTLA
4082	283	TZINTZUNTZAN
4083	283	TZITZIO
4084	283	URUAPAN
4085	283	VILLAMAR
4086	283	VISTA HERMOSA
4087	283	YURÉCUARO
4088	283	ZACAPU
4089	283	ZAMORA
4090	283	ZINÁPARO
4091	283	ZINAPÉCUARO
4092	283	ZIRACUARETIRO
4093	283	ZITÁCUARO
4094	283	JOSÉ SIXTO VERDUZCO
4095	284	AMACUZAC
4096	284	ATLATLAHUCAN
4097	284	AXOCHIAPAN
4098	284	AYALA
4099	284	COATLÁN DEL RÍO
4100	284	CUERNAVACA
4101	284	HUITZILAC
4102	284	JANTETELCO
4103	284	JIUTEPEC
4104	284	JOJUTLA
4105	284	JONACATEPEC DE LEANDRO VALLE
4106	284	MAZATEPEC
4107	284	MIACATLÁN
4108	284	OCUITUCO
4109	284	PUENTE DE IXTLA
4110	284	TEMIXCO
4111	284	TEPALCINGO
4112	284	TEPOZTLÁN
4113	284	TETECALA
4114	284	TETELA DEL VOLCÁN
4115	284	TLALNEPANTLA
4116	284	TLALTIZAPÁN DE ZAPATA
4117	284	TLAQUILTENANGO
4118	284	TLAYACAPAN
4119	284	TOTOLAPAN
4120	284	XOCHITEPEC
4121	284	YAUTEPEC
4122	284	YECAPIXTLA
4123	284	ZACATEPEC
4124	284	ZACUALPAN DE AMILPAS
4125	284	TEMOAC
4126	285	ACAPONETA
4127	285	AHUACATLÁN
4128	285	AMATLÁN DE CAÑAS
4129	285	COMPOSTELA
4130	285	HUAJICORI
4131	285	IXTLÁN DEL RÍO
4132	285	JALA
4133	285	XALISCO
4134	285	DEL NAYAR
4135	285	ROSAMORADA
4136	285	RUÍZ
4137	285	SAN BLAS
4138	285	SAN PEDRO LAGUNILLAS
4139	285	SANTIAGO IXCUINTLA
4140	285	TECUALA
4141	285	TEPIC
4142	285	LA YESCA
4143	285	BAHÍA DE BANDERAS
4144	286	AGUALEGUAS
4145	286	LOS ALDAMAS
4146	286	ANÁHUAC
4147	286	APODACA
4148	286	ARAMBERRI
4149	286	BUSTAMANTE
4150	286	CADEREYTA JIMÉNEZ
4151	286	EL CARMEN
4152	286	CERRALVO
4153	286	CIÉNEGA DE FLORES
4154	286	CHINA
4155	286	DOCTOR ARROYO
4156	286	DOCTOR COSS
4157	286	DOCTOR GONZÁLEZ
4158	286	GARCÍA
4159	286	SAN PEDRO GARZA GARCÍA
4160	286	GENERAL BRAVO
4161	286	GENERAL ESCOBEDO
4162	286	GENERAL TERÁN
4163	286	GENERAL TREVIÑO
4164	286	GENERAL ZARAGOZA
4165	286	GENERAL ZUAZUA
4166	286	LOS HERRERAS
4167	286	HIGUERAS
4168	286	HUALAHUISES
4169	286	ITURBIDE
4170	286	LAMPAZOS DE NARANJO
4171	286	LINARES
4172	286	MARÍN
4173	286	MIER Y NORIEGA
4174	286	MINA
4175	286	MONTEMORELOS
4176	286	MONTERREY
4177	286	PARÁS
4178	286	PESQUERÍA
4179	286	LOS RAMONES
4180	286	RAYONES
4181	286	SABINAS HIDALGO
4182	286	SALINAS VICTORIA
4183	286	SAN NICOLÁS DE LOS GARZA
4184	286	SANTIAGO
4185	286	VALLECILLO
4186	286	VILLALDAMA
4187	287	ABEJONES
4188	287	ACATLÁN DE PÉREZ FIGUEROA
4189	287	ASUNCIÓN CACALOTEPEC
4190	287	ASUNCIÓN CUYOTEPEJI
4191	287	ASUNCIÓN IXTALTEPEC
4192	287	ASUNCIÓN NOCHIXTLÁN
4193	287	ASUNCIÓN OCOTLÁN
4194	287	ASUNCIÓN TLACOLULITA
4195	287	AYOTZINTEPEC
4196	287	EL BARRIO DE LA SOLEDAD
4197	287	CALIHUALÁ
4198	287	CANDELARIA LOXICHA
4199	287	CIÉNEGA DE ZIMATLÁN
4200	287	CIUDAD IXTEPEC
4201	287	COATECAS ALTAS
4202	287	COICOYÁN DE LAS FLORES
4203	287	LA COMPAÑÍA
4204	287	CONCEPCIÓN BUENAVISTA
4205	287	CONCEPCIÓN PÁPALO
4206	287	CONSTANCIA DEL ROSARIO
4207	287	COSOLAPA
4208	287	COSOLTEPEC
4209	287	CUILÁPAM DE GUERRERO
4210	287	CUYAMECALCO VILLA DE ZARAGOZA
4211	287	CHAHUITES
4212	287	CHALCATONGO DE HIDALGO
4213	287	CHIQUIHUITLÁN DE BENITO JUÁREZ
4214	287	HEROICA CIUDAD DE EJUTLA DE CRESPO
4215	287	ELOXOCHITLÁN DE FLORES MAGÓN
4216	287	EL ESPINAL
4217	287	TAMAZULÁPAM DEL ESPÍRITU SANTO
4218	287	FRESNILLO DE TRUJANO
4219	287	GUADALUPE ETLA
4220	287	GUADALUPE DE RAMÍREZ
4221	287	GUELATAO DE JUÁREZ
4222	287	GUEVEA DE HUMBOLDT
4223	287	MESONES HIDALGO
4224	287	HEROICA CIUDAD DE HUAJUAPAN DE LEÓN
4225	287	HUAUTEPEC
4226	287	HUAUTLA DE JIMÉNEZ
4227	287	IXTLÁN DE JUÁREZ
4228	287	HEROICA CIUDAD DE JUCHITÁN DE ZARAGOZA
4229	287	LOMA BONITA
4230	287	MAGDALENA APASCO
4231	287	MAGDALENA JALTEPEC
4232	287	SANTA MAGDALENA JICOTLÁN
4233	287	MAGDALENA MIXTEPEC
4234	287	MAGDALENA OCOTLÁN
4235	287	MAGDALENA PEÑASCO
4236	287	MAGDALENA TEITIPAC
4237	287	MAGDALENA TEQUISISTLÁN
4238	287	MAGDALENA TLACOTEPEC
4239	287	MAGDALENA ZAHUATLÁN
4240	287	MARISCALA DE JUÁREZ
4241	287	MÁRTIRES DE TACUBAYA
4242	287	MATÍAS ROMERO AVENDAÑO
4243	287	MAZATLÁN VILLA DE FLORES
4244	287	MIAHUATLÁN DE PORFIRIO DÍAZ
4245	287	MIXISTLÁN DE LA REFORMA
4246	287	MONJAS
4247	287	NATIVIDAD
4248	287	NAZARENO ETLA
4249	287	NEJAPA DE MADERO
4250	287	IXPANTEPEC NIEVES
4251	287	SANTIAGO NILTEPEC
4252	287	OAXACA DE JUÁREZ
4253	287	OCOTLÁN DE MORELOS
4254	287	LA PE
4255	287	PINOTEPA DE DON LUIS
4256	287	PLUMA HIDALGO
4257	287	SAN JOSÉ DEL PROGRESO
4258	287	PUTLA VILLA DE GUERRERO
4259	287	SANTA CATARINA QUIOQUITANI
4260	287	REFORMA DE PINEDA
4261	287	LA REFORMA
4262	287	REYES ETLA
4263	287	ROJAS DE CUAUHTÉMOC
4264	287	SALINA CRUZ
4265	287	SAN AGUSTÍN AMATENGO
4266	287	SAN AGUSTÍN ATENANGO
4267	287	SAN AGUSTÍN CHAYUCO
4268	287	SAN AGUSTÍN DE LAS JUNTAS
4269	287	SAN AGUSTÍN ETLA
4270	287	SAN AGUSTÍN LOXICHA
4271	287	SAN AGUSTÍN TLACOTEPEC
4272	287	SAN AGUSTÍN YATARENI
4273	287	SAN ANDRÉS CABECERA NUEVA
4274	287	SAN ANDRÉS DINICUITI
4275	287	SAN ANDRÉS HUAXPALTEPEC
4276	287	SAN ANDRÉS HUAYÁPAM
4277	287	SAN ANDRÉS IXTLAHUACA
4278	287	SAN ANDRÉS LAGUNAS
4279	287	SAN ANDRÉS NUXIÑO
4280	287	SAN ANDRÉS PAXTLÁN
4281	287	SAN ANDRÉS SINAXTLA
4282	287	SAN ANDRÉS SOLAGA
4283	287	SAN ANDRÉS TEOTILÁLPAM
4284	287	SAN ANDRÉS TEPETLAPA
4285	287	SAN ANDRÉS YAÁ
4286	287	SAN ANDRÉS ZABACHE
4287	287	SAN ANDRÉS ZAUTLA
4288	287	SAN ANTONINO CASTILLO VELASCO
4289	287	SAN ANTONINO EL ALTO
4290	287	SAN ANTONINO MONTE VERDE
4291	287	SAN ANTONIO ACUTLA
4292	287	SAN ANTONIO DE LA CAL
4293	287	SAN ANTONIO HUITEPEC
4294	287	SAN ANTONIO NANAHUATÍPAM
4295	287	SAN ANTONIO SINICAHUA
4296	287	SAN ANTONIO TEPETLAPA
4297	287	SAN BALTAZAR CHICHICÁPAM
4298	287	SAN BALTAZAR LOXICHA
4299	287	SAN BALTAZAR YATZACHI EL BAJO
4300	287	SAN BARTOLO COYOTEPEC
4301	287	SAN BARTOLOMÉ AYAUTLA
4302	287	SAN BARTOLOMÉ LOXICHA
4303	287	SAN BARTOLOMÉ QUIALANA
4304	287	SAN BARTOLOMÉ YUCUAÑE
4305	287	SAN BARTOLOMÉ ZOOGOCHO
4306	287	SAN BARTOLO SOYALTEPEC
4307	287	SAN BARTOLO YAUTEPEC
4308	287	SAN BERNARDO MIXTEPEC
4309	287	SAN BLAS ATEMPA
4310	287	SAN CARLOS YAUTEPEC
4311	287	SAN CRISTÓBAL AMATLÁN
4312	287	SAN CRISTÓBAL AMOLTEPEC
4313	287	SAN CRISTÓBAL LACHIRIOAG
4314	287	SAN CRISTÓBAL SUCHIXTLAHUACA
4315	287	SAN DIONISIO DEL MAR
4316	287	SAN DIONISIO OCOTEPEC
4317	287	SAN DIONISIO OCOTLÁN
4318	287	SAN ESTEBAN ATATLAHUCA
4319	287	SAN FELIPE JALAPA DE DÍAZ
4320	287	SAN FELIPE TEJALÁPAM
4321	287	SAN FELIPE USILA
4322	287	SAN FRANCISCO CAHUACUÁ
4323	287	SAN FRANCISCO CAJONOS
4324	287	SAN FRANCISCO CHAPULAPA
4325	287	SAN FRANCISCO CHINDÚA
4326	287	SAN FRANCISCO DEL MAR
4327	287	SAN FRANCISCO HUEHUETLÁN
4328	287	SAN FRANCISCO IXHUATÁN
4329	287	SAN FRANCISCO JALTEPETONGO
4330	287	SAN FRANCISCO LACHIGOLÓ
4331	287	SAN FRANCISCO LOGUECHE
4332	287	SAN FRANCISCO NUXAÑO
4333	287	SAN FRANCISCO OZOLOTEPEC
4334	287	SAN FRANCISCO SOLA
4335	287	SAN FRANCISCO TELIXTLAHUACA
4336	287	SAN FRANCISCO TEOPAN
4337	287	SAN FRANCISCO TLAPANCINGO
4338	287	SAN GABRIEL MIXTEPEC
4339	287	SAN ILDEFONSO AMATLÁN
4340	287	SAN ILDEFONSO SOLA
4341	287	SAN ILDEFONSO VILLA ALTA
4342	287	SAN JACINTO AMILPAS
4343	287	SAN JACINTO TLACOTEPEC
4344	287	SAN JERÓNIMO COATLÁN
4345	287	SAN JERÓNIMO SILACAYOAPILLA
4346	287	SAN JERÓNIMO SOSOLA
4347	287	SAN JERÓNIMO TAVICHE
4348	287	SAN JERÓNIMO TECÓATL
4349	287	SAN JORGE NUCHITA
4350	287	SAN JOSÉ AYUQUILA
4351	287	SAN JOSÉ CHILTEPEC
4352	287	SAN JOSÉ DEL PEÑASCO
4353	287	SAN JOSÉ ESTANCIA GRANDE
4354	287	SAN JOSÉ INDEPENDENCIA
4355	287	SAN JOSÉ LACHIGUIRI
4356	287	SAN JOSÉ TENANGO
4357	287	SAN JUAN ACHIUTLA
4358	287	SAN JUAN ATEPEC
4359	287	ÁNIMAS TRUJANO
4360	287	SAN JUAN BAUTISTA ATATLAHUCA
4361	287	SAN JUAN BAUTISTA COIXTLAHUACA
4362	287	SAN JUAN BAUTISTA CUICATLÁN
4363	287	SAN JUAN BAUTISTA GUELACHE
4364	287	SAN JUAN BAUTISTA JAYACATLÁN
4365	287	SAN JUAN BAUTISTA LO DE SOTO
4366	287	SAN JUAN BAUTISTA SUCHITEPEC
4367	287	SAN JUAN BAUTISTA TLACOATZINTEPEC
4368	287	SAN JUAN BAUTISTA TLACHICHILCO
4369	287	SAN JUAN BAUTISTA TUXTEPEC
4370	287	SAN JUAN CACAHUATEPEC
4371	287	SAN JUAN CIENEGUILLA
4372	287	SAN JUAN COATZÓSPAM
4373	287	SAN JUAN COLORADO
4374	287	SAN JUAN COMALTEPEC
4375	287	SAN JUAN COTZOCÓN
4376	287	SAN JUAN CHICOMEZÚCHIL
4377	287	SAN JUAN CHILATECA
4378	287	SAN JUAN DEL ESTADO
4379	287	SAN JUAN DIUXI
4380	287	SAN JUAN EVANGELISTA ANALCO
4381	287	SAN JUAN GUELAVÍA
4382	287	SAN JUAN GUICHICOVI
4383	287	SAN JUAN IHUALTEPEC
4384	287	SAN JUAN JUQUILA MIXES
4385	287	SAN JUAN JUQUILA VIJANOS
4386	287	SAN JUAN LACHAO
4387	287	SAN JUAN LACHIGALLA
4388	287	SAN JUAN LAJARCIA
4389	287	SAN JUAN LALANA
4390	287	SAN JUAN DE LOS CUÉS
4391	287	SAN JUAN MAZATLÁN
4392	287	SAN JUAN MIXTEPEC
4393	287	SAN JUAN ÑUMÍ
4394	287	SAN JUAN OZOLOTEPEC
4395	287	SAN JUAN PETLAPA
4396	287	SAN JUAN QUIAHIJE
4397	287	SAN JUAN QUIOTEPEC
4398	287	SAN JUAN SAYULTEPEC
4399	287	SAN JUAN TABAÁ
4400	287	SAN JUAN TAMAZOLA
4401	287	SAN JUAN TEITA
4402	287	SAN JUAN TEITIPAC
4403	287	SAN JUAN TEPEUXILA
4404	287	SAN JUAN TEPOSCOLULA
4405	287	SAN JUAN YAEÉ
4406	287	SAN JUAN YATZONA
4407	287	SAN JUAN YUCUITA
4408	287	SAN LORENZO
4409	287	SAN LORENZO ALBARRADAS
4410	287	SAN LORENZO CACAOTEPEC
4411	287	SAN LORENZO CUAUNECUILTITLA
4412	287	SAN LORENZO TEXMELÚCAN
4413	287	SAN LORENZO VICTORIA
4414	287	SAN LUCAS CAMOTLÁN
4415	287	SAN LUCAS OJITLÁN
4416	287	SAN LUCAS QUIAVINÍ
4417	287	SAN LUCAS ZOQUIÁPAM
4418	287	SAN LUIS AMATLÁN
4419	287	SAN MARCIAL OZOLOTEPEC
4420	287	SAN MARCOS ARTEAGA
4421	287	SAN MARTÍN DE LOS CANSECOS
4422	287	SAN MARTÍN HUAMELÚLPAM
4423	287	SAN MARTÍN ITUNYOSO
4424	287	SAN MARTÍN LACHILÁ
4425	287	SAN MARTÍN PERAS
4426	287	SAN MARTÍN TILCAJETE
4427	287	SAN MARTÍN TOXPALAN
4428	287	SAN MARTÍN ZACATEPEC
4429	287	SAN MATEO CAJONOS
4430	287	CAPULÁLPAM DE MÉNDEZ
4431	287	SAN MATEO DEL MAR
4432	287	SAN MATEO YOLOXOCHITLÁN
4433	287	SAN MATEO ETLATONGO
4434	287	SAN MATEO NEJÁPAM
4435	287	SAN MATEO PEÑASCO
4436	287	SAN MATEO PIÑAS
4437	287	SAN MATEO RÍO HONDO
4438	287	SAN MATEO SINDIHUI
4439	287	SAN MATEO TLAPILTEPEC
4440	287	SAN MELCHOR BETAZA
4441	287	SAN MIGUEL ACHIUTLA
4442	287	SAN MIGUEL AHUEHUETITLÁN
4443	287	SAN MIGUEL ALOÁPAM
4444	287	SAN MIGUEL AMATITLÁN
4445	287	SAN MIGUEL AMATLÁN
4446	287	SAN MIGUEL COATLÁN
4447	287	SAN MIGUEL CHICAHUA
4448	287	SAN MIGUEL CHIMALAPA
4449	287	SAN MIGUEL DEL PUERTO
4450	287	SAN MIGUEL DEL RÍO
4451	287	SAN MIGUEL EJUTLA
4452	287	SAN MIGUEL EL GRANDE
4453	287	SAN MIGUEL HUAUTLA
4454	287	SAN MIGUEL MIXTEPEC
4455	287	SAN MIGUEL PANIXTLAHUACA
4456	287	SAN MIGUEL PERAS
4457	287	SAN MIGUEL PIEDRAS
4458	287	SAN MIGUEL QUETZALTEPEC
4459	287	SAN MIGUEL SANTA FLOR
4460	287	VILLA SOLA DE VEGA
4461	287	SAN MIGUEL SOYALTEPEC
4462	287	SAN MIGUEL SUCHIXTEPEC
4463	287	VILLA TALEA DE CASTRO
4464	287	SAN MIGUEL TECOMATLÁN
4465	287	SAN MIGUEL TENANGO
4466	287	SAN MIGUEL TEQUIXTEPEC
4467	287	SAN MIGUEL TILQUIÁPAM
4468	287	SAN MIGUEL TLACAMAMA
4469	287	SAN MIGUEL TLACOTEPEC
4470	287	SAN MIGUEL TULANCINGO
4471	287	SAN MIGUEL YOTAO
4472	287	SAN NICOLÁS
4473	287	SAN NICOLÁS HIDALGO
4474	287	SAN PABLO COATLÁN
4475	287	SAN PABLO CUATRO VENADOS
4476	287	SAN PABLO ETLA
4477	287	SAN PABLO HUITZO
4478	287	SAN PABLO HUIXTEPEC
4479	287	SAN PABLO MACUILTIANGUIS
4480	287	SAN PABLO TIJALTEPEC
4481	287	SAN PABLO VILLA DE MITLA
4482	287	SAN PABLO YAGANIZA
4483	287	SAN PEDRO AMUZGOS
4484	287	SAN PEDRO APÓSTOL
4485	287	SAN PEDRO ATOYAC
4486	287	SAN PEDRO CAJONOS
4487	287	SAN PEDRO COXCALTEPEC CÁNTAROS
4488	287	SAN PEDRO COMITANCILLO
4489	287	SAN PEDRO EL ALTO
4490	287	SAN PEDRO HUAMELULA
4491	287	SAN PEDRO HUILOTEPEC
4492	287	SAN PEDRO IXCATLÁN
4493	287	SAN PEDRO IXTLAHUACA
4494	287	SAN PEDRO JALTEPETONGO
4495	287	SAN PEDRO JICAYÁN
4496	287	SAN PEDRO JOCOTIPAC
4497	287	SAN PEDRO JUCHATENGO
4498	287	SAN PEDRO MÁRTIR
4499	287	SAN PEDRO MÁRTIR QUIECHAPA
4500	287	SAN PEDRO MÁRTIR YUCUXACO
4501	287	SAN PEDRO MIXTEPEC
4502	287	SAN PEDRO MOLINOS
4503	287	SAN PEDRO NOPALA
4504	287	SAN PEDRO OCOPETATILLO
4505	287	SAN PEDRO OCOTEPEC
4506	287	SAN PEDRO POCHUTLA
4507	287	SAN PEDRO QUIATONI
4508	287	SAN PEDRO SOCHIÁPAM
4509	287	SAN PEDRO TAPANATEPEC
4510	287	SAN PEDRO TAVICHE
4511	287	SAN PEDRO TEOZACOALCO
4512	287	SAN PEDRO TEUTILA
4513	287	SAN PEDRO TIDAÁ
4514	287	SAN PEDRO TOPILTEPEC
4515	287	SAN PEDRO TOTOLÁPAM
4516	287	VILLA DE TUTUTEPEC
4517	287	SAN PEDRO YANERI
4518	287	SAN PEDRO YÓLOX
4519	287	SAN PEDRO Y SAN PABLO AYUTLA
4520	287	VILLA DE ETLA
4521	287	SAN PEDRO Y SAN PABLO TEPOSCOLULA
4522	287	SAN PEDRO Y SAN PABLO TEQUIXTEPEC
4523	287	SAN PEDRO YUCUNAMA
4524	287	SAN RAYMUNDO JALPAN
4525	287	SAN SEBASTIÁN ABASOLO
4526	287	SAN SEBASTIÁN COATLÁN
4527	287	SAN SEBASTIÁN IXCAPA
4528	287	SAN SEBASTIÁN NICANANDUTA
4529	287	SAN SEBASTIÁN RÍO HONDO
4530	287	SAN SEBASTIÁN TECOMAXTLAHUACA
4531	287	SAN SEBASTIÁN TEITIPAC
4532	287	SAN SEBASTIÁN TUTLA
4533	287	SAN SIMÓN ALMOLONGAS
4534	287	SAN SIMÓN ZAHUATLÁN
4535	287	SANTA ANA
4536	287	SANTA ANA ATEIXTLAHUACA
4537	287	SANTA ANA CUAUHTÉMOC
4538	287	SANTA ANA DEL VALLE
4539	287	SANTA ANA TAVELA
4540	287	SANTA ANA TLAPACOYAN
4541	287	SANTA ANA YARENI
4542	287	SANTA ANA ZEGACHE
4543	287	SANTA CATALINA QUIERÍ
4544	287	SANTA CATARINA CUIXTLA
4545	287	SANTA CATARINA IXTEPEJI
4546	287	SANTA CATARINA JUQUILA
4547	287	SANTA CATARINA LACHATAO
4548	287	SANTA CATARINA LOXICHA
4549	287	SANTA CATARINA MECHOACÁN
4550	287	SANTA CATARINA MINAS
4551	287	SANTA CATARINA QUIANÉ
4552	287	SANTA CATARINA TAYATA
4553	287	SANTA CATARINA TICUÁ
4554	287	SANTA CATARINA YOSONOTÚ
4555	287	SANTA CATARINA ZAPOQUILA
4556	287	SANTA CRUZ ACATEPEC
4557	287	SANTA CRUZ AMILPAS
4558	287	SANTA CRUZ DE BRAVO
4559	287	SANTA CRUZ ITUNDUJIA
4560	287	SANTA CRUZ MIXTEPEC
4561	287	SANTA CRUZ NUNDACO
4562	287	SANTA CRUZ PAPALUTLA
4563	287	SANTA CRUZ TACACHE DE MINA
4564	287	SANTA CRUZ TACAHUA
4565	287	SANTA CRUZ TAYATA
4566	287	SANTA CRUZ XITLA
4567	287	SANTA CRUZ XOXOCOTLÁN
4568	287	SANTA CRUZ ZENZONTEPEC
4569	287	SANTA GERTRUDIS
4570	287	SANTA INÉS DEL MONTE
4571	287	SANTA INÉS YATZECHE
4572	287	SANTA LUCÍA DEL CAMINO
4573	287	SANTA LUCÍA MIAHUATLÁN
4574	287	SANTA LUCÍA MONTEVERDE
4575	287	SANTA LUCÍA OCOTLÁN
4576	287	SANTA MARÍA ALOTEPEC
4577	287	SANTA MARÍA APAZCO
4578	287	SANTA MARÍA LA ASUNCIÓN
4579	287	HEROICA CIUDAD DE TLAXIACO
4580	287	AYOQUEZCO DE ALDAMA
4581	287	SANTA MARÍA ATZOMPA
4582	287	SANTA MARÍA CAMOTLÁN
4583	287	SANTA MARÍA COLOTEPEC
4584	287	SANTA MARÍA CORTIJO
4585	287	SANTA MARÍA COYOTEPEC
4586	287	SANTA MARÍA CHACHOÁPAM
4587	287	VILLA DE CHILAPA DE DÍAZ
4588	287	SANTA MARÍA CHILCHOTLA
4589	287	SANTA MARÍA CHIMALAPA
4590	287	SANTA MARÍA DEL ROSARIO
4591	287	SANTA MARÍA DEL TULE
4592	287	SANTA MARÍA ECATEPEC
4593	287	SANTA MARÍA GUELACÉ
4594	287	SANTA MARÍA GUIENAGATI
4595	287	SANTA MARÍA HUATULCO
4596	287	SANTA MARÍA HUAZOLOTITLÁN
4597	287	SANTA MARÍA IPALAPA
4598	287	SANTA MARÍA IXCATLÁN
4599	287	SANTA MARÍA JACATEPEC
4600	287	SANTA MARÍA JALAPA DEL MARQUÉS
4601	287	SANTA MARÍA JALTIANGUIS
4602	287	SANTA MARÍA LACHIXÍO
4603	287	SANTA MARÍA MIXTEQUILLA
4604	287	SANTA MARÍA NATIVITAS
4605	287	SANTA MARÍA NDUAYACO
4606	287	SANTA MARÍA OZOLOTEPEC
4607	287	SANTA MARÍA PÁPALO
4608	287	SANTA MARÍA PEÑOLES
4609	287	SANTA MARÍA PETAPA
4610	287	SANTA MARÍA QUIEGOLANI
4611	287	SANTA MARÍA SOLA
4612	287	SANTA MARÍA TATALTEPEC
4613	287	SANTA MARÍA TECOMAVACA
4614	287	SANTA MARÍA TEMAXCALAPA
4615	287	SANTA MARÍA TEMAXCALTEPEC
4616	287	SANTA MARÍA TEOPOXCO
4617	287	SANTA MARÍA TEPANTLALI
4618	287	SANTA MARÍA TEXCATITLÁN
4619	287	SANTA MARÍA TLAHUITOLTEPEC
4620	287	SANTA MARÍA TLALIXTAC
4621	287	SANTA MARÍA TONAMECA
4622	287	SANTA MARÍA TOTOLAPILLA
4623	287	SANTA MARÍA XADANI
4624	287	SANTA MARÍA YALINA
4625	287	SANTA MARÍA YAVESÍA
4626	287	SANTA MARÍA YOLOTEPEC
4627	287	SANTA MARÍA YOSOYÚA
4628	287	SANTA MARÍA YUCUHITI
4629	287	SANTA MARÍA ZACATEPEC
4630	287	SANTA MARÍA ZANIZA
4631	287	SANTA MARÍA ZOQUITLÁN
4632	287	SANTIAGO AMOLTEPEC
4633	287	SANTIAGO APOALA
4634	287	SANTIAGO APÓSTOL
4635	287	SANTIAGO ASTATA
4636	287	SANTIAGO ATITLÁN
4637	287	SANTIAGO AYUQUILILLA
4638	287	SANTIAGO CACALOXTEPEC
4639	287	SANTIAGO CAMOTLÁN
4640	287	SANTIAGO COMALTEPEC
4641	287	SANTIAGO CHAZUMBA
4642	287	SANTIAGO CHOÁPAM
4643	287	SANTIAGO DEL RÍO
4644	287	SANTIAGO HUAJOLOTITLÁN
4645	287	SANTIAGO HUAUCLILLA
4646	287	SANTIAGO IHUITLÁN PLUMAS
4647	287	SANTIAGO IXCUINTEPEC
4648	287	SANTIAGO IXTAYUTLA
4649	287	SANTIAGO JAMILTEPEC
4650	287	SANTIAGO JOCOTEPEC
4651	287	SANTIAGO JUXTLAHUACA
4652	287	SANTIAGO LACHIGUIRI
4653	287	SANTIAGO LALOPA
4654	287	SANTIAGO LAOLLAGA
4655	287	SANTIAGO LAXOPA
4656	287	SANTIAGO LLANO GRANDE
4657	287	SANTIAGO MATATLÁN
4658	287	SANTIAGO MILTEPEC
4659	287	SANTIAGO MINAS
4660	287	SANTIAGO NACALTEPEC
4661	287	SANTIAGO NEJAPILLA
4662	287	SANTIAGO NUNDICHE
4663	287	SANTIAGO NUYOÓ
4664	287	SANTIAGO PINOTEPA NACIONAL
4665	287	SANTIAGO SUCHILQUITONGO
4666	287	SANTIAGO TAMAZOLA
4667	287	SANTIAGO TAPEXTLA
4668	287	VILLA TEJÚPAM DE LA UNIÓN
4669	287	SANTIAGO TENANGO
4670	287	SANTIAGO TEPETLAPA
4671	287	SANTIAGO TETEPEC
4672	287	SANTIAGO TEXCALCINGO
4673	287	SANTIAGO TEXTITLÁN
4674	287	SANTIAGO TILANTONGO
4675	287	SANTIAGO TILLO
4676	287	SANTIAGO TLAZOYALTEPEC
4677	287	SANTIAGO XANICA
4678	287	SANTIAGO XIACUÍ
4679	287	SANTIAGO YAITEPEC
4680	287	SANTIAGO YAVEO
4681	287	SANTIAGO YOLOMÉCATL
4682	287	SANTIAGO YOSONDÚA
4683	287	SANTIAGO YUCUYACHI
4684	287	SANTIAGO ZACATEPEC
4685	287	SANTIAGO ZOOCHILA
4686	287	NUEVO ZOQUIÁPAM
4687	287	SANTO DOMINGO INGENIO
4688	287	SANTO DOMINGO ALBARRADAS
4689	287	SANTO DOMINGO ARMENTA
4690	287	SANTO DOMINGO CHIHUITÁN
4691	287	SANTO DOMINGO DE MORELOS
4692	287	SANTO DOMINGO IXCATLÁN
4693	287	SANTO DOMINGO NUXAÁ
4694	287	SANTO DOMINGO OZOLOTEPEC
4695	287	SANTO DOMINGO PETAPA
4696	287	SANTO DOMINGO ROAYAGA
4697	287	SANTO DOMINGO TEHUANTEPEC
4698	287	SANTO DOMINGO TEOJOMULCO
4699	287	SANTO DOMINGO TEPUXTEPEC
4700	287	SANTO DOMINGO TLATAYÁPAM
4701	287	SANTO DOMINGO TOMALTEPEC
4702	287	SANTO DOMINGO TONALÁ
4703	287	SANTO DOMINGO TONALTEPEC
4704	287	SANTO DOMINGO XAGACÍA
4705	287	SANTO DOMINGO YANHUITLÁN
4706	287	SANTO DOMINGO YODOHINO
4707	287	SANTO DOMINGO ZANATEPEC
4708	287	SANTOS REYES NOPALA
4709	287	SANTOS REYES PÁPALO
4710	287	SANTOS REYES TEPEJILLO
4711	287	SANTOS REYES YUCUNÁ
4712	287	SANTO TOMÁS JALIEZA
4713	287	SANTO TOMÁS MAZALTEPEC
4714	287	SANTO TOMÁS OCOTEPEC
4715	287	SANTO TOMÁS TAMAZULAPAN
4716	287	SAN VICENTE COATLÁN
4717	287	SAN VICENTE LACHIXÍO
4718	287	SAN VICENTE NUÑÚ
4719	287	SILACAYOÁPAM
4720	287	SITIO DE XITLAPEHUA
4721	287	SOLEDAD ETLA
4722	287	VILLA DE TAMAZULÁPAM DEL PROGRESO
4723	287	TANETZE DE ZARAGOZA
4724	287	TANICHE
4725	287	TATALTEPEC DE VALDÉS
4726	287	TEOCOCUILCO DE MARCOS PÉREZ
4727	287	TEOTITLÁN DE FLORES MAGÓN
4728	287	TEOTITLÁN DEL VALLE
4729	287	TEOTONGO
4730	287	TEPELMEME VILLA DE MORELOS
4731	287	VILLA TEZOATLÁN DE SEGURA Y LUNA
4732	287	SAN JERÓNIMO TLACOCHAHUAYA
4733	287	TLACOLULA DE MATAMOROS
4734	287	TLACOTEPEC PLUMAS
4735	287	TLALIXTAC DE CABRERA
4736	287	TOTONTEPEC VILLA DE MORELOS
4737	287	TRINIDAD ZAACHILA
4738	287	LA TRINIDAD VISTA HERMOSA
4739	287	UNIÓN HIDALGO
4740	287	VALERIO TRUJANO
4741	287	SAN JUAN BAUTISTA VALLE NACIONAL
4742	287	VILLA DÍAZ ORDAZ
4743	287	YAXE
4744	287	MAGDALENA YODOCONO DE PORFIRIO DÍAZ
4745	287	YOGANA
4746	287	YUTANDUCHI DE GUERRERO
4747	287	VILLA DE ZAACHILA
4748	287	SAN MATEO YUCUTINDOO
4749	287	ZAPOTITLÁN LAGUNAS
4750	287	ZAPOTITLÁN PALMAS
4751	287	SANTA INÉS DE ZARAGOZA
4752	287	ZIMATLÁN DE ÁLVAREZ
4753	288	ACAJETE
4754	288	ACATENO
4755	288	ACATZINGO
4756	288	ACTEOPAN
4757	288	AHUATLÁN
4758	288	AHUAZOTEPEC
4759	288	AHUEHUETITLA
4760	288	AJALPAN
4761	288	ALBINO ZERTUCHE
4762	288	ALJOJUCA
4763	288	ALTEPEXI
4764	288	AMIXTLÁN
4765	288	AMOZOC
4766	288	AQUIXTLA
4767	288	ATEMPAN
4768	288	ATEXCAL
4769	288	ATLIXCO
4770	288	ATOYATEMPAN
4771	288	ATZALA
4772	288	ATZITZIHUACÁN
4773	288	ATZITZINTLA
4774	288	AXUTLA
4775	288	AYOTOXCO DE GUERRERO
4776	288	CALPAN
4777	288	CALTEPEC
4778	288	CAMOCUAUTLA
4779	288	CAXHUACAN
4780	288	COATEPEC
4781	288	COATZINGO
4782	288	COHETZALA
4783	288	COHUECAN
4784	288	CORONANGO
4785	288	COXCATLÁN
4786	288	COYOMEAPAN
4787	288	CUAPIAXTLA DE MADERO
4788	288	CUAUTEMPAN
4789	288	CUAUTINCHÁN
4790	288	CUAUTLANCINGO
4791	288	CUAYUCA DE ANDRADE
4792	288	CUETZALAN DEL PROGRESO
4793	288	CUYOACO
4794	288	CHALCHICOMULA DE SESMA
4795	288	CHAPULCO
4796	288	CHIAUTZINGO
4797	288	CHICONCUAUTLA
4798	288	CHICHIQUILA
4799	288	CHIETLA
4800	288	CHIGMECATITLÁN
4801	288	CHIGNAHUAPAN
4802	288	CHIGNAUTLA
4803	288	CHILA
4804	288	CHILA DE LA SAL
4805	288	HONEY
4806	288	CHILCHOTLA
4807	288	CHINANTLA
4808	288	DOMINGO ARENAS
4809	288	EPATLÁN
4810	288	ESPERANZA
4811	288	FRANCISCO Z. MENA
4812	288	GENERAL FELIPE ÁNGELES
4813	288	HERMENEGILDO GALEANA
4814	288	HUAQUECHULA
4815	288	HUATLATLAUCA
4816	288	HUAUCHINANGO
4817	288	HUEHUETLÁN EL CHICO
4818	288	HUEJOTZINGO
4819	288	HUEYAPAN
4820	288	HUEYTAMALCO
4821	288	HUEYTLALPAN
4822	288	HUITZILAN DE SERDÁN
4823	288	HUITZILTEPEC
4824	288	ATLEQUIZAYAN
4825	288	IXCAMILPA DE GUERRERO
4826	288	IXCAQUIXTLA
4827	288	IXTACAMAXTITLÁN
4828	288	IXTEPEC
4829	288	IZÚCAR DE MATAMOROS
4830	288	JALPAN
4831	288	JOLALPAN
4832	288	JONOTLA
4833	288	JOPALA
4834	288	JUAN C. BONILLA
4835	288	JUAN GALINDO
4836	288	JUAN N. MÉNDEZ
4837	288	LAFRAGUA
4838	288	LIBRES
4839	288	LA MAGDALENA TLATLAUQUITEPEC
4840	288	MAZAPILTEPEC DE JUÁREZ
4841	288	MIXTLA
4842	288	MOLCAXAC
4843	288	CAÑADA MORELOS
4844	288	NAUPAN
4845	288	NAUZONTLA
4846	288	NEALTICAN
4847	288	NICOLÁS BRAVO
4848	288	NOPALUCAN
4849	288	OCOYUCAN
4850	288	OLINTLA
4851	288	ORIENTAL
4852	288	PAHUATLÁN
4853	288	PALMAR DE BRAVO
4854	288	PETLALCINGO
4855	288	PIAXTLA
4856	288	PUEBLA
4857	288	QUECHOLAC
4858	288	QUIMIXTLÁN
4859	288	RAFAEL LARA GRAJALES
4860	288	LOS REYES DE JUÁREZ
4861	288	SAN ANDRÉS CHOLULA
4862	288	SAN ANTONIO CAÑADA
4863	288	SAN DIEGO LA MESA TOCHIMILTZINGO
4864	288	SAN FELIPE TEOTLALCINGO
4865	288	SAN FELIPE TEPATLÁN
4866	288	SAN GABRIEL CHILAC
4867	288	SAN GREGORIO ATZOMPA
4868	288	SAN JERÓNIMO TECUANIPAN
4869	288	SAN JERÓNIMO XAYACATLÁN
4870	288	SAN JOSÉ CHIAPA
4871	288	SAN JOSÉ MIAHUATLÁN
4872	288	SAN JUAN ATENCO
4873	288	SAN JUAN ATZOMPA
4874	288	SAN MARTÍN TEXMELUCAN
4875	288	SAN MARTÍN TOTOLTEPEC
4876	288	SAN MATÍAS TLALANCALECA
4877	288	SAN MIGUEL IXITLÁN
4878	288	SAN MIGUEL XOXTLA
4879	288	SAN NICOLÁS BUENOS AIRES
4880	288	SAN NICOLÁS DE LOS RANCHOS
4881	288	SAN PABLO ANICANO
4882	288	SAN PEDRO CHOLULA
4883	288	SAN PEDRO YELOIXTLAHUACA
4884	288	SAN SALVADOR EL SECO
4885	288	SAN SALVADOR EL VERDE
4886	288	SAN SALVADOR HUIXCOLOTLA
4887	288	SAN SEBASTIÁN TLACOTEPEC
4888	288	SANTA CATARINA TLALTEMPAN
4889	288	SANTA INÉS AHUATEMPAN
4890	288	SANTA ISABEL CHOLULA
4891	288	SANTIAGO MIAHUATLÁN
4892	288	HUEHUETLÁN EL GRANDE
4893	288	SANTO TOMÁS HUEYOTLIPAN
4894	288	SOLTEPEC
4895	288	TECALI DE HERRERA
4896	288	TECAMACHALCO
4897	288	TECOMATLÁN
4898	288	TEHUACÁN
4899	288	TEHUITZINGO
4900	288	TENAMPULCO
4901	288	TEOPANTLÁN
4902	288	TEOTLALCO
4903	288	TEPANCO DE LÓPEZ
4904	288	TEPANGO DE RODRÍGUEZ
4905	288	TEPATLAXCO DE HIDALGO
4906	288	TEPEACA
4907	288	TEPEMAXALCO
4908	288	TEPEOJUMA
4909	288	TEPETZINTLA
4910	288	TEPEXCO
4911	288	TEPEXI DE RODRÍGUEZ
4912	288	TEPEYAHUALCO
4913	288	TEPEYAHUALCO DE CUAUHTÉMOC
4914	288	TETELA DE OCAMPO
4915	288	TETELES DE AVILA CASTILLO
4916	288	TEZIUTLÁN
4917	288	TIANGUISMANALCO
4918	288	TILAPA
4919	288	TLACOTEPEC DE BENITO JUÁREZ
4920	288	TLACUILOTEPEC
4921	288	TLACHICHUCA
4922	288	TLAHUAPAN
4923	288	TLALTENANGO
4924	288	TLANEPANTLA
4925	288	TLAOLA
4926	288	TLAPACOYA
4927	288	TLAPANALÁ
4928	288	TLATLAUQUITEPEC
4929	288	TLAXCO
4930	288	TOCHIMILCO
4931	288	TOCHTEPEC
4932	288	TOTOLTEPEC DE GUERRERO
4933	288	TULCINGO
4934	288	TUZAMAPAN DE GALEANA
4935	288	TZICATLACOYAN
4936	288	XAYACATLÁN DE BRAVO
4937	288	XICOTEPEC
4938	288	XICOTLÁN
4939	288	XIUTETELCO
4940	288	XOCHIAPULCO
4941	288	XOCHILTEPEC
4942	288	XOCHITLÁN DE VICENTE SUÁREZ
4943	288	XOCHITLÁN TODOS SANTOS
4944	288	YAONÁHUAC
4945	288	YEHUALTEPEC
4946	288	ZACAPALA
4947	288	ZACAPOAXTLA
4948	288	ZACATLÁN
4949	288	ZAPOTITLÁN
4950	288	ZAPOTITLÁN DE MÉNDEZ
4951	288	ZAUTLA
4952	288	ZIHUATEUTLA
4953	288	ZINACATEPEC
4954	288	ZONGOZOTLA
4955	288	ZOQUIAPAN
4956	288	ZOQUITLÁN
4957	289	AMEALCO DE BONFIL
4958	289	PINAL DE AMOLES
4959	289	ARROYO SECO
4960	289	CADEREYTA DE MONTES
4961	289	COLÓN
4962	289	CORREGIDORA
4963	289	EZEQUIEL MONTES
4964	289	HUIMILPAN
4965	289	JALPAN DE SERRA
4966	289	LANDA DE MATAMOROS
4967	289	EL MARQUÉS
4968	289	PEDRO ESCOBEDO
4969	289	PEÑAMILLER
4970	289	QUERÉTARO
4971	289	SAN JOAQUÍN
4972	289	TEQUISQUIAPAN
4973	290	COZUMEL
4974	290	FELIPE CARRILLO PUERTO
4975	290	ISLA MUJERES
4976	290	OTHÓN P. BLANCO
4977	290	JOSÉ MARÍA MORELOS
4978	290	SOLIDARIDAD
4979	290	TULUM
4980	290	BACALAR
4981	290	PUERTO MORELOS
4982	291	SAN LUIS POTOSÍ
4983	291	AHUALULCO
4984	291	ALAQUINES
4985	291	AQUISMÓN
4986	291	ARMADILLO DE LOS INFANTE
4987	291	CÁRDENAS
4988	291	CATORCE
4989	291	CEDRAL
4990	291	CERRITOS
4991	291	CERRO DE SAN PEDRO
4992	291	CIUDAD DEL MAÍZ
4993	291	CIUDAD FERNÁNDEZ
4994	291	TANCANHUITZ
4995	291	CIUDAD VALLES
4996	291	CHARCAS
4997	291	EBANO
4998	291	GUADALCÁZAR
4999	291	HUEHUETLÁN
5000	291	MATEHUALA
5001	291	MEXQUITIC DE CARMONA
5002	291	MOCTEZUMA
5003	291	RIOVERDE
5004	291	SALINAS
5005	291	SAN ANTONIO
5006	291	SAN CIRO DE ACOSTA
5007	291	SAN MARTÍN CHALCHICUAUTLA
5008	291	SAN NICOLÁS TOLENTINO
5009	291	SANTA MARÍA DEL RÍO
5010	291	SANTO DOMINGO
5011	291	SAN VICENTE TANCUAYALAB
5012	291	SOLEDAD DE GRACIANO SÁNCHEZ
5013	291	TAMASOPO
5014	291	TAMAZUNCHALE
5015	291	TAMPACÁN
5016	291	TAMPAMOLÓN CORONA
5017	291	TAMUÍN
5018	291	TANLAJÁS
5019	291	TANQUIÁN DE ESCOBEDO
5020	291	TIERRA NUEVA
5021	291	VANEGAS
5022	291	VENADO
5023	291	VILLA DE ARRIAGA
5024	291	VILLA DE GUADALUPE
5025	291	VILLA DE LA PAZ
5026	291	VILLA DE RAMOS
5027	291	VILLA DE REYES
5028	291	VILLA JUÁREZ
5029	291	AXTLA DE TERRAZAS
5030	291	XILITLA
5031	291	VILLA DE ARISTA
5032	291	MATLAPA
5033	291	EL NARANJO
5034	292	AHOME
5035	292	ANGOSTURA
5036	292	BADIRAGUATO
5037	292	CONCORDIA
5038	292	COSALÁ
5039	292	CULIACÁN
5040	292	CHOIX
5041	292	ELOTA
5042	292	ESCUINAPA
5043	292	EL FUERTE
5044	292	GUASAVE
5045	292	MAZATLÁN
5046	292	MOCORITO
5047	292	SALVADOR ALVARADO
5048	292	SAN IGNACIO
5049	292	SINALOA
5050	292	NAVOLATO
5051	293	ACONCHI
5052	293	AGUA PRIETA
5053	293	ALAMOS
5054	293	ALTAR
5055	293	ARIVECHI
5056	293	ARIZPE
5057	293	ATIL
5058	293	BACADÉHUACHI
5059	293	BACANORA
5060	293	BACERAC
5061	293	BACOACHI
5062	293	BÁCUM
5063	293	BANÁMICHI
5064	293	BAVIÁCORA
5065	293	BAVISPE
5066	293	BENJAMÍN HILL
5067	293	CABORCA
5068	293	CAJEME
5069	293	CANANEA
5070	293	CARBÓ
5071	293	LA COLORADA
5072	293	CUCURPE
5073	293	CUMPAS
5074	293	DIVISADEROS
5075	293	EMPALME
5076	293	ETCHOJOA
5077	293	FRONTERAS
5078	293	GRANADOS
5079	293	GUAYMAS
5080	293	HERMOSILLO
5081	293	HUACHINERA
5082	293	HUÁSABAS
5083	293	HUATABAMPO
5084	293	HUÉPAC
5085	293	IMURIS
5086	293	NACO
5087	293	NÁCORI CHICO
5088	293	NACOZARI DE GARCÍA
5089	293	NAVOJOA
5090	293	NOGALES
5091	293	ONAVAS
5092	293	OPODEPE
5093	293	OQUITOA
5094	293	PITIQUITO
5095	293	PUERTO PEÑASCO
5096	293	QUIRIEGO
5097	293	SAHUARIPA
5098	293	SAN FELIPE DE JESÚS
5099	293	SAN JAVIER
5100	293	SAN LUIS RÍO COLORADO
5101	293	SAN MIGUEL DE HORCASITAS
5102	293	SAN PEDRO DE LA CUEVA
5103	293	SANTA CRUZ
5104	293	SÁRIC
5105	293	SOYOPA
5106	293	SUAQUI GRANDE
5107	293	TEPACHE
5108	293	TRINCHERAS
5109	293	TUBUTAMA
5110	293	URES
5111	293	VILLA PESQUEIRA
5112	293	YÉCORA
5113	293	GENERAL PLUTARCO ELÍAS CALLES
5114	293	SAN IGNACIO RÍO MUERTO
5115	294	BALANCÁN
5116	294	CENTLA
5117	294	CENTRO
5118	294	COMALCALCO
5119	294	CUNDUACÁN
5120	294	HUIMANGUILLO
5121	294	JALAPA
5122	294	JALPA DE MÉNDEZ
5123	294	JONUTA
5124	294	MACUSPANA
5125	294	NACAJUCA
5126	294	PARAÍSO
5127	294	TACOTALPA
5128	294	TEAPA
5129	294	TENOSIQUE
5130	295	ALTAMIRA
5131	295	ANTIGUO MORELOS
5132	295	BURGOS
5133	295	CASAS
5134	295	CIUDAD MADERO
5135	295	CRUILLAS
5136	295	GONZÁLEZ
5137	295	GÜÉMEZ
5138	295	GUSTAVO DÍAZ ORDAZ
5139	295	JAUMAVE
5140	295	LLERA
5141	295	MAINERO
5142	295	EL MANTE
5143	295	MÉNDEZ
5144	295	MIER
5145	295	MIGUEL ALEMÁN
5146	295	MIQUIHUANA
5147	295	NUEVO LAREDO
5148	295	NUEVO MORELOS
5149	295	PADILLA
5150	295	PALMILLAS
5151	295	REYNOSA
5152	295	RÍO BRAVO
5153	295	SAN CARLOS
5154	295	SOTO LA MARINA
5155	295	TAMPICO
5156	295	TULA
5157	295	VALLE HERMOSO
5158	295	XICOTÉNCATL
5159	296	AMAXAC DE GUERRERO
5160	296	APETATITLÁN DE ANTONIO CARVAJAL
5161	296	ATLANGATEPEC
5162	296	ATLTZAYANCA
5163	296	APIZACO
5164	296	CALPULALPAN
5165	296	EL CARMEN TEQUEXQUITLA
5166	296	CUAPIAXTLA
5167	296	CUAXOMULCO
5168	296	CHIAUTEMPAN
5169	296	MUÑOZ DE DOMINGO ARENAS
5170	296	ESPAÑITA
5171	296	HUAMANTLA
5172	296	HUEYOTLIPAN
5173	296	IXTACUIXTLA DE MARIANO MATAMOROS
5174	296	IXTENCO
5175	296	MAZATECOCHCO DE JOSÉ MARÍA MORELOS
5176	296	CONTLA DE JUAN CUAMATZI
5177	296	TEPETITLA DE LARDIZÁBAL
5178	296	SANCTÓRUM DE LÁZARO CÁRDENAS
5179	296	NANACAMILPA DE MARIANO ARISTA
5180	296	ACUAMANALA DE MIGUEL HIDALGO
5181	296	NATÍVITAS
5182	296	PANOTLA
5183	296	SAN PABLO DEL MONTE
5184	296	SANTA CRUZ TLAXCALA
5185	296	TEOLOCHOLCO
5186	296	TEPEYANCO
5187	296	TERRENATE
5188	296	TETLA DE LA SOLIDARIDAD
5189	296	TETLATLAHUCA
5190	296	TLAXCALA
5191	296	TOCATLÁN
5192	296	TOTOLAC
5193	296	ZILTLALTÉPEC DE TRINIDAD SÁNCHEZ SANTOS
5194	296	TZOMPANTEPEC
5195	296	XALOZTOC
5196	296	XALTOCAN
5197	296	PAPALOTLA DE XICOHTÉNCATL
5198	296	XICOHTZINCO
5199	296	YAUHQUEMEHCAN
5200	296	ZACATELCO
5201	296	LA MAGDALENA TLALTELULCO
5202	296	SAN DAMIÁN TEXÓLOC
5203	296	SAN FRANCISCO TETLANOHCAN
5204	296	SAN JERÓNIMO ZACUALPAN
5205	296	SAN JOSÉ TEACALCO
5206	296	SAN JUAN HUACTZINCO
5207	296	SAN LORENZO AXOCOMANITLA
5208	296	SAN LUCAS TECOPILCO
5209	296	SANTA ANA NOPALUCAN
5210	296	SANTA APOLONIA TEACALCO
5211	296	SANTA CATARINA AYOMETLA
5212	296	SANTA CRUZ QUILEHTLA
5213	296	SANTA ISABEL XILOXOXTLA
5214	297	ACAYUCAN
5215	297	ACULA
5216	297	ACULTZINGO
5217	297	CAMARÓN DE TEJEDA
5218	297	ALPATLÁHUAC
5219	297	ALTO LUCERO DE GUTIÉRREZ BARRIOS
5220	297	ALTOTONGA
5221	297	ALVARADO
5222	297	AMATITLÁN
5223	297	NARANJOS AMATLÁN
5224	297	AMATLÁN DE LOS REYES
5225	297	ANGEL R. CABADA
5226	297	LA ANTIGUA
5227	297	APAZAPAN
5228	297	ASTACINGA
5229	297	ATLAHUILCO
5230	297	ATZACAN
5231	297	ATZALAN
5232	297	TLALTETELA
5233	297	AYAHUALULCO
5234	297	BANDERILLA
5235	297	BOCA DEL RÍO
5236	297	CALCAHUALCO
5237	297	CAMERINO Z. MENDOZA
5238	297	CARRILLO PUERTO
5239	297	CATEMACO
5240	297	CAZONES DE HERRERA
5241	297	CERRO AZUL
5242	297	CITLALTÉPETL
5243	297	COACOATZINTLA
5244	297	COAHUITLÁN
5245	297	COATZACOALCOS
5246	297	COATZINTLA
5247	297	COETZALA
5248	297	COLIPA
5249	297	COMAPA
5250	297	CÓRDOBA
5251	297	COSAMALOAPAN DE CARPIO
5252	297	COSAUTLÁN DE CARVAJAL
5253	297	COSCOMATEPEC
5254	297	COSOLEACAQUE
5255	297	COTAXTLA
5256	297	COXQUIHUI
5257	297	COYUTLA
5258	297	CUICHAPA
5259	297	CUITLÁHUAC
5260	297	CHACALTIANGUIS
5261	297	CHALMA
5262	297	CHICONAMEL
5263	297	CHICONQUIACO
5264	297	CHICONTEPEC
5265	297	CHINAMECA
5266	297	CHINAMPA DE GOROSTIZA
5267	297	LAS CHOAPAS
5268	297	CHOCAMÁN
5269	297	CHONTLA
5270	297	CHUMATLÁN
5271	297	ESPINAL
5272	297	FILOMENO MATA
5273	297	FORTÍN
5274	297	GUTIÉRREZ ZAMORA
5275	297	HIDALGOTITLÁN
5276	297	HUATUSCO
5277	297	HUAYACOCOTLA
5278	297	HUEYAPAN DE OCAMPO
5279	297	HUILOAPAN DE CUAUHTÉMOC
5280	297	IGNACIO DE LA LLAVE
5281	297	ILAMATLÁN
5282	297	ISLA
5283	297	IXCATEPEC
5284	297	IXHUACÁN DE LOS REYES
5285	297	IXHUATLÁN DEL CAFÉ
5286	297	IXHUATLANCILLO
5287	297	IXHUATLÁN DEL SURESTE
5288	297	IXHUATLÁN DE MADERO
5289	297	IXMATLAHUACAN
5290	297	IXTACZOQUITLÁN
5291	297	JALACINGO
5292	297	XALAPA
5293	297	JALCOMULCO
5294	297	JÁLTIPAN
5295	297	JAMAPA
5296	297	JESÚS CARRANZA
5297	297	XICO
5298	297	JUAN RODRÍGUEZ CLARA
5299	297	JUCHIQUE DE FERRER
5300	297	LANDERO Y COSS
5301	297	LERDO DE TEJADA
5302	297	MALTRATA
5303	297	MANLIO FABIO ALTAMIRANO
5304	297	MARIANO ESCOBEDO
5305	297	MARTÍNEZ DE LA TORRE
5306	297	MECATLÁN
5307	297	MECAYAPAN
5308	297	MEDELLÍN DE BRAVO
5309	297	MIAHUATLÁN
5310	297	LAS MINAS
5311	297	MISANTLA
5312	297	MIXTLA DE ALTAMIRANO
5313	297	MOLOACÁN
5314	297	NAOLINCO
5315	297	NARANJAL
5316	297	NAUTLA
5317	297	OLUTA
5318	297	OMEALCA
5319	297	ORIZABA
5320	297	OTATITLÁN
5321	297	OTEAPAN
5322	297	OZULUAMA DE MASCAREÑAS
5323	297	PAJAPAN
5324	297	PÁNUCO
5325	297	PAPANTLA
5326	297	PASO DEL MACHO
5327	297	PASO DE OVEJAS
5328	297	LA PERLA
5329	297	PEROTE
5330	297	PLATÓN SÁNCHEZ
5331	297	PLAYA VICENTE
5332	297	POZA RICA DE HIDALGO
5333	297	LAS VIGAS DE RAMÍREZ
5334	297	PUEBLO VIEJO
5335	297	PUENTE NACIONAL
5336	297	RAFAEL DELGADO
5337	297	RAFAEL LUCIO
5338	297	RÍO BLANCO
5339	297	SALTABARRANCA
5340	297	SAN ANDRÉS TENEJAPAN
5341	297	SAN ANDRÉS TUXTLA
5342	297	SAN JUAN EVANGELISTA
5343	297	SANTIAGO TUXTLA
5344	297	SAYULA DE ALEMÁN
5345	297	SOCONUSCO
5346	297	SOCHIAPA
5347	297	SOLEDAD ATZOMPA
5348	297	SOLEDAD DE DOBLADO
5349	297	SOTEAPAN
5350	297	TAMALÍN
5351	297	TAMIAHUA
5352	297	TAMPICO ALTO
5353	297	TANCOCO
5354	297	TANTIMA
5355	297	TANTOYUCA
5356	297	TATATILA
5357	297	CASTILLO DE TEAYO
5358	297	TECOLUTLA
5359	297	TEHUIPANGO
5360	297	ÁLAMO TEMAPACHE
5361	297	TEMPOAL
5362	297	TENAMPA
5363	297	TENOCHTITLÁN
5364	297	TEOCELO
5365	297	TEPATLAXCO
5366	297	TEPETLÁN
5367	297	JOSÉ AZUETA
5368	297	TEXCATEPEC
5369	297	TEXHUACÁN
5370	297	TEXISTEPEC
5371	297	TEZONAPA
5372	297	TIHUATLÁN
5373	297	TLACOJALPAN
5374	297	TLACOLULAN
5375	297	TLACOTALPAN
5376	297	TLACOTEPEC DE MEJÍA
5377	297	TLACHICHILCO
5378	297	TLALIXCOYAN
5379	297	TLALNELHUAYOCAN
5380	297	TLAPACOYAN
5381	297	TLAQUILPA
5382	297	TLILAPAN
5383	297	TONAYÁN
5384	297	TOTUTLA
5385	297	TUXTILLA
5386	297	URSULO GALVÁN
5387	297	VEGA DE ALATORRE
5388	297	VERACRUZ
5389	297	VILLA ALDAMA
5390	297	XOXOCOTLA
5391	297	YANGA
5392	297	YECUATLA
5393	297	ZENTLA
5394	297	ZONGOLICA
5395	297	ZONTECOMATLÁN DE LÓPEZ Y FUENTES
5396	297	ZOZOCOLCO DE HIDALGO
5397	297	AGUA DULCE
5398	297	EL HIGO
5399	297	NANCHITAL DE LÁZARO CÁRDENAS DEL RÍO
5400	297	TRES VALLES
5401	297	CARLOS A. CARRILLO
5402	297	TATAHUICAPAN DE JUÁREZ
5403	297	UXPANAPA
5404	297	SAN RAFAEL
5405	297	SANTIAGO SOCHIAPAN
5406	298	ABALÁ
5407	298	ACANCEH
5408	298	AKIL
5409	298	BACA
5410	298	BOKOBÁ
5411	298	BUCTZOTZ
5412	298	CACALCHÉN
5413	298	CALOTMUL
5414	298	CANSAHCAB
5415	298	CANTAMAYEC
5416	298	CELESTÚN
5417	298	CENOTILLO
5418	298	CONKAL
5419	298	CUNCUNUL
5420	298	CUZAMÁ
5421	298	CHACSINKÍN
5422	298	CHANKOM
5423	298	CHAPAB
5424	298	CHEMAX
5425	298	CHICXULUB PUEBLO
5426	298	CHICHIMILÁ
5427	298	CHIKINDZONOT
5428	298	CHOCHOLÁ
5429	298	CHUMAYEL
5430	298	DZÁN
5431	298	DZEMUL
5432	298	DZIDZANTÚN
5433	298	DZILAM DE BRAVO
5434	298	DZILAM GONZÁLEZ
5435	298	DZITÁS
5436	298	DZONCAUICH
5437	298	ESPITA
5438	298	HALACHÓ
5439	298	HOCABÁ
5440	298	HOCTÚN
5441	298	HOMÚN
5442	298	HUHÍ
5443	298	HUNUCMÁ
5444	298	IXIL
5445	298	IZAMAL
5446	298	KANASÍN
5447	298	KANTUNIL
5448	298	KAUA
5449	298	KINCHIL
5450	298	KOPOMÁ
5451	298	MAMA
5452	298	MANÍ
5453	298	MAXCANÚ
5454	298	MAYAPÁN
5455	298	MÉRIDA
5456	298	MOCOCHÁ
5457	298	MOTUL
5458	298	MUNA
5459	298	MUXUPIP
5460	298	OPICHÉN
5461	298	OXKUTZCAB
5462	298	PANABÁ
5463	298	PETO
5464	298	QUINTANA ROO
5465	298	RÍO LAGARTOS
5466	298	SACALUM
5467	298	SAMAHIL
5468	298	SANAHCAT
5469	298	SANTA ELENA
5470	298	SEYÉ
5471	298	SINANCHÉ
5472	298	SOTUTA
5473	298	SUCILÁ
5474	298	SUDZAL
5475	298	SUMA
5476	298	TAHDZIÚ
5477	298	TAHMEK
5478	298	TEABO
5479	298	TECOH
5480	298	TEKAL DE VENEGAS
5481	298	TEKANTÓ
5482	298	TEKAX
5483	298	TEKIT
5484	298	TEKOM
5485	298	TELCHAC PUEBLO
5486	298	TELCHAC PUERTO
5487	298	TEMAX
5488	298	TEMOZÓN
5489	298	TEPAKÁN
5490	298	TETIZ
5491	298	TEYA
5492	298	TICUL
5493	298	TIMUCUY
5494	298	TINUM
5495	298	TIXCACALCUPUL
5496	298	TIXKOKOB
5497	298	TIXMEHUAC
5498	298	TIXPÉHUAL
5499	298	TIZIMÍN
5500	298	TUNKÁS
5501	298	TZUCACAB
5502	298	UAYMA
5503	298	UCÚ
5504	298	UMÁN
5505	298	VALLADOLID
5506	298	XOCCHEL
5507	298	YAXCABÁ
5508	298	YAXKUKUL
5509	298	YOBAÍN
5510	299	APOZOL
5511	299	APULCO
5512	299	ATOLINGA
5513	299	CALERA
5514	299	CAÑITAS DE FELIPE PESCADOR
5515	299	CONCEPCIÓN DEL ORO
5516	299	CHALCHIHUITES
5517	299	FRESNILLO
5518	299	TRINIDAD GARCÍA DE LA CADENA
5519	299	GENARO CODINA
5520	299	GENERAL ENRIQUE ESTRADA
5521	299	GENERAL FRANCISCO R. MURGUÍA
5522	299	EL PLATEADO DE JOAQUÍN AMARO
5523	299	GENERAL PÁNFILO NATERA
5524	299	HUANUSCO
5525	299	JALPA
5526	299	JEREZ
5527	299	JIMÉNEZ DEL TEUL
5528	299	JUAN ALDAMA
5529	299	JUCHIPILA
5530	299	LUIS MOYA
5531	299	MAZAPIL
5532	299	MEZQUITAL DEL ORO
5533	299	MIGUEL AUZA
5534	299	MOMAX
5535	299	MONTE ESCOBEDO
5536	299	MOYAHUA DE ESTRADA
5537	299	NOCHISTLÁN DE MEJÍA
5538	299	NORIA DE ÁNGELES
5539	299	OJOCALIENTE
5540	299	PINOS
5541	299	RÍO GRANDE
5542	299	SAIN ALTO
5543	299	EL SALVADOR
5544	299	SOMBRERETE
5545	299	SUSTICACÁN
5546	299	TABASCO
5547	299	TEPECHITLÁN
5548	299	TEPETONGO
5549	299	TEÚL DE GONZÁLEZ ORTEGA
5550	299	TLALTENANGO DE SÁNCHEZ ROMÁN
5551	299	VALPARAÍSO
5552	299	VETAGRANDE
5553	299	VILLA DE COS
5554	299	VILLA GARCÍA
5555	299	VILLA GONZÁLEZ ORTEGA
5556	299	VILLANUEVA
5557	299	ZACATECAS
5558	299	TRANCOSO
5559	300	Adolfo Alsina
5560	300	Adolfo Gonzales Chaves
5561	300	Alberti
5562	300	Almirante Brown
5563	300	Arrecifes
5564	300	Avellaneda
5565	300	Ayacucho
5566	300	Azul
5567	300	Bahía Blanca
5568	300	Balcarce
5569	300	Baradero
5570	300	Benito Juárez
5571	300	Berazategui
5572	300	Berisso
5573	300	Bolívar
5574	300	Bragado
5575	300	Brandsen
5576	300	Buenos Aires
5577	300	Campana
5578	300	Cañuelas
5579	300	Capitán Sarmiento Carlos
5580	300	Carlos Casares
5581	300	Carlos Tejedor
5582	300	Carmen de Areco
5583	300	Castelli
5584	300	Chacabuco
5585	300	Chascomús
5586	300	Chivilcoy
5587	300	Colón
5588	300	Coronel de Marina Leonardo Rosales
5589	300	Coronel Dorrego
5590	300	Coronel Pringles
5591	300	Coronel Suárez
5592	300	Daireaux
5593	300	Dolores
5594	300	Ensenada
5595	300	Escobar
5596	300	Esteban Echeverría
5597	300	Exaltación de la Cruz
5598	300	Ezeiza
5599	300	Florencio Varela
5600	300	Florentino Ameghino
5601	300	General Alvarado
5602	300	General Alvear
5603	300	General Arenales
5604	300	General Belgrano
5605	300	General Guido
5606	300	General Juan Madariaga
5607	300	General La Madrid
5608	300	General Las Heras
5609	300	General Lavalle
5610	300	General Paz
5611	300	General Pinto
5612	300	General Pueyrredón
5613	300	General Rodríguez
5614	300	General San Martín
5615	300	General Viamonte
5616	300	General Villegas
5617	300	Guaminí
5618	300	Hipólito Yrigoyen
5619	300	Hurlingham
5620	300	Ituzaingó
5621	300	José C. Paz
5622	300	Junín
5623	300	La Costa
5624	300	La Matanza
5625	300	La Plata
5626	300	Lanús
5627	300	Laprida
5628	300	Las Flores
5629	300	Leandro N. Alem
5630	300	Lincoln
5631	300	Lobería
5632	300	Lobos
5633	300	Lomas de Zamora
5634	300	Luján
5635	300	Magdalena
5636	300	Maipú
5637	300	Malvinas Argentinas
5638	300	Mar Chiquita
5639	300	Marcos Paz
5640	300	Mercedes
5641	300	Merlo
5642	300	Monte
5643	300	Monte Hermoso
5644	300	Moreno
5645	300	Morón
5646	300	Navarro
5647	300	Necochea
5648	300	Nueve de Julio
5649	300	Olavarría
5650	300	Patagones
5651	300	Pehuajó
5652	300	Pellegrini
5653	300	Pergamino
5654	300	Pila
5655	300	Pilar
5656	300	Pinamar
5657	300	Presidente Perón
5658	300	Puan
5659	300	Punta Indio
5660	300	Quilmes
5661	300	Ramallo
5662	300	Rauch
5663	300	Rivadavia
5664	300	Rojas
5665	300	Roque Pérez
5666	300	Saavedra
5667	300	Saladillo
5668	300	Salliqueló
5669	300	Salto
5670	300	San Andrés de Giles
5671	300	San Antonio de Areco
5672	300	San Cayetano
5673	300	San Fernando
5674	300	San Isidro
5675	300	San Miguel
5676	300	San Nicolás
5677	300	San Pedro
5678	300	San Vicente
5679	300	Suipacha
5680	300	Tandil
5681	300	Tapalqué
5682	300	Tigre
5683	300	Tordillo
5684	300	Tornquist
5685	300	Trenque Lauquen
5686	300	Tres Arroyos
5687	300	Tres de Febrero
5688	300	Tres Lomas
5689	300	Veinticinco de Mayo
5690	300	Vicente López
5691	300	Villa Gesell
5692	300	Villarino
5693	300	Zárate
5694	301	Ambato
5695	301	Ancasti
5696	301	Andalgalá
5697	301	Antofagasta de la Sierra
5698	301	Belén
5699	301	Capayán
5700	301	Capital
5701	301	El Alto
5702	301	Fray Mamerto Esquiú
5703	301	La Paz
5704	301	Paclín
5705	301	Pomán
5706	301	Santa María
5707	301	Santa Rosa
5708	301	Tinogasta
5709	301	Valle Viejo
5710	302	Bermejo
5711	302	Comandante Fernández
5712	302	Doce de Octubre
5713	302	Dos de Abril
5714	302	Fray Justo Santa María de Oro
5715	302	General Donovan
5716	302	General Güemes
5717	302	Independencia
5718	302	Libertad
5719	302	Libertador General San Martín
5720	302	Mayor Luis Jorge Fontana
5721	302	O'Higgins
5722	302	Presidencia de la Plaza
5723	302	Primero de Mayo
5724	302	Quitilipi
5725	302	San Lorenzo
5726	302	Sargento Cabral
5727	302	Tapenagá
5728	303	Biedma
5729	303	Cushamen
5730	303	Escalante
5731	303	Futaleufú
5732	303	Gaiman
5733	303	Gastre
5734	303	Languiñeo
5735	303	Mártires
5736	303	Paso de Indios
5737	303	Rawson
5738	303	Río Senguer
5739	303	Sarmiento
5740	303	Tehuelches
5741	303	Telsen
5742	304	Calamuchita
5743	304	Cruz del Eje
5744	304	General Roca
5745	304	Ischilín
5746	304	Juárez Celman
5747	304	Marcos Juárez
5748	304	Minas
5749	304	Pocho
5750	304	Presidente Roque Sáenz Peña
5751	304	Punilla
5752	304	Río Cuarto
5753	304	Río Primero
5754	304	Río Seco
5755	304	Río Segundo
5756	304	San Alberto
5757	304	San Javier
5758	304	San Justo
5759	304	Sobremonte
5760	304	Tercero Arriba
5761	304	Totoral
5762	304	Tulumba
5763	304	Unión
5764	305	Bella Vista
5765	305	Berón de Astrada
5766	305	Concepción
5767	305	Curuzú Cuatiá
5768	305	Empedrado
5769	305	Esquina
5770	305	Goya
5771	305	Itatí
5772	305	Lavalle
5773	305	Mburucuyá
5774	305	Monte Caseros
5775	305	Paso de los Libres
5776	305	Saladas
5777	305	San Cosme
5778	305	San Luis del Palmar
5779	305	San Martín
5780	305	San Roque
5781	305	Santo Tomé
5782	305	Sauce
5783	306	Concordia
5784	306	Diamante
5785	306	Federación
5786	306	Federal
5787	306	Feliciano
5788	306	Gualeguay
5789	306	Gualeguaychú
5790	306	Islas del Ibicuy
5791	306	Nogoyá
5792	306	Paraná
5793	306	San Salvador
5794	306	Tala
5795	306	Uruguay
5796	306	Victoria
5797	306	Villaguay
5798	307	Formosa
5799	307	Laishi
5800	307	Matacos
5801	307	Patiño
5802	307	Pilagás
5803	307	Pilcomayo
5804	307	Pirané
5805	307	Ramón Lista
5806	308	Cochinoca
5807	308	Doctor Manuel Belgrano
5808	308	El Carmen
5809	308	Humahuaca
5810	308	Ledesma
5811	308	Palpalá
5812	308	Rinconada
5813	308	San Antonio
5814	308	Santa Bárbara
5815	308	Santa Catalina
5816	308	Susques
5817	308	Tilcara
5818	308	Tumbaya
5819	308	Valle Grande
5820	308	Yavi
5821	309	Atreucó
5822	309	Caleu Caleu
5823	309	Catriló
5824	309	Chalileo
5825	309	Chapaleufú
5826	309	Chical Co
5827	309	Conhelo
5828	309	Curacó
5829	309	Guatraché
5830	309	Hucal
5831	309	Lihuel Calel
5832	309	Limay Mahuida
5833	309	Loventué
5834	309	Maracó
5835	309	Puelén
5836	309	Quemú Quemú
5837	309	Rancul
5838	309	Realicó
5839	309	Toay
5840	309	Trenel
5841	309	Utracán
5842	310	Arauco
5843	310	Castro Barros
5844	310	Chamical
5845	310	Chilecito
5846	310	Coronel Felipe Varela
5847	310	Famatina
5848	310	General Ángel V. Peñaloza
5849	310	General Juan Facundo Quiroga
5850	310	General Lamadrid
5851	310	General Ocampo
5852	310	Rosario Vera Peñaloza
5853	310	San Blas de los Sauces
5854	310	Sanagasta
5855	310	Vinchina
5856	311	Godoy Cruz
5857	311	Guaymallén
5858	311	Las Heras
5859	311	Luján de Cuyo
5860	311	Malargüe
5861	311	San Carlos
5862	311	San Rafael
5863	311	Tunuyán
5864	311	Tupungato
5865	312	Apóstoles
5866	312	Cainguás
5867	312	Candelaria
5868	312	Eldorado
5869	312	General Manuel Belgrano
5870	312	Guaraní
5871	312	Iguazú
5872	312	Montecarlo
5873	312	Oberá
5874	312	San Ignacio
5875	313	Aluminé
5876	313	Añelo
5877	313	Catán Lil
5878	313	Chos Malal
5879	313	Collón Curá
5880	313	Confluencia
5881	313	Huiliches
5882	313	Lácar
5883	313	Loncopué
5884	313	Los Lagos
5885	313	Ñorquín
5886	313	Pehuenches
5887	313	Picún Leufú
5888	313	Picunches
5889	313	Zapala
5890	314	Bariloche
5891	314	Conesa
5892	314	El Cuy
5893	314	Ñorquincó
5894	314	Pichi Mahuida
5895	314	Pilcaniyeu
5896	314	Valcheta
5897	315	Anta
5898	315	Cachi
5899	315	Cafayate
5900	315	Cerrillos
5901	315	Chicoana
5902	315	General José de San Martín
5903	315	Guachipas
5904	315	Iruya
5905	315	La Caldera
5906	315	La Candelaria
5907	315	La Poma
5908	315	La Viña
5909	315	Los Andes
5910	315	Metán
5911	315	Molinos
5912	315	Orán
5913	315	Rosario de la Frontera
5914	315	Rosario de Lerma
5915	315	Santa Victoria
5916	316	Albardón
5917	316	Angaco
5918	316	Calingasta
5919	316	Caucete
5920	316	Chimbas
5921	316	Iglesia
5922	316	Jáchal
5923	316	Pocito
5924	316	Santa Lucía
5925	316	Ullum
5926	316	Valle Fértil
5927	316	Zonda
5928	317	Belgrano
5929	317	General Pedernera
5930	317	Gobernador Dupuy
5931	317	La Capital
5932	318	Corpen Aike
5933	318	Deseado
5934	318	Güer Aike
5935	318	Lago Argentino
5936	318	Lago Buenos Aires
5937	318	Magallanes
5938	318	Río Chico
5939	319	Caseros
5940	319	Castellanos
5941	319	Constitución
5942	319	Garay
5943	319	General López
5944	319	General Obligado
5945	319	Iriondo
5946	319	Las Colonias
5947	319	Rosario
5948	319	San Cristóbal
5949	319	San Jerónimo
5950	319	Vera
5951	320	Aguirre
5952	320	Alberdi
5953	320	Atamisqui
5954	320	Banda
5955	320	Choya
5956	320	Copo
5957	320	Figueroa
5958	320	General Taboada
5959	320	Guasayán
5960	320	Jiménez
5961	320	Juan F. Ibarra
5962	320	Loreto
5963	320	Mitre
5964	320	Ojo de Agua
5965	320	Quebrachos
5966	320	Río Hondo
5967	320	Robles
5968	320	Salavina
5969	320	Silípica
5970	321	Río Grande
5971	321	Ushuaia
5972	322	Burruyacú
5973	322	Chicligasta
5974	322	Cruz Alta
5975	322	Famaillá
5976	322	Graneros
5977	322	Juan Bautista Alberdi
5978	322	La Cocha
5979	322	Leales
5980	322	Lules
5981	322	Monteros
5982	322	Simoca
5983	322	Tafí del Valle
5984	322	Tafí Viejo
5985	322	Trancas
5986	322	Yerba Buena
5987	323	Assis Brasil
5988	323	Brasiléia
5989	323	Epitaciolândia
5990	323	Xapuri
5991	323	Acrelândia
5992	323	Bujari
5993	323	Capixaba
5994	323	Plácido de Castro
5995	323	Porto Acre
5996	323	Rio Branco (Capital)
5997	323	Senador Guiomard
5998	323	Manoel Urbano
5999	323	Santa Rosa do Purus
6000	323	Sena Madureira
6001	323	Cruzeiro do Sul
6002	323	Mâncio Lima
6003	323	Marechal Thaumaturgo
6004	323	Porto Walter
6005	323	Rodrigues Alves
6006	323	Feijó
6007	323	Jordão
6008	323	Tarauacá
6009	324	Arapiraca
6010	324	Campo Grande
6011	324	Coité do Nóia
6012	324	Craíbas
6013	324	Feira Grande
6014	324	Girau do Ponciano
6015	324	Lagoa da Canoa
6016	324	Limoeiro de Anadia
6017	324	São Sebastião
6018	324	Taquarana
6019	324	Belém
6020	324	Cacimbinhas
6021	324	Estrela de Alagoas
6022	324	Igaci
6023	324	Mar Vermelho
6024	324	Maribondo
6025	324	Minador do Negrão
6026	324	Palmeira dos Índios
6027	324	Paulo Jacinto
6028	324	Quebrangulo
6029	324	Tanque d'Arca
6030	324	Olho d'Água Grande
6031	324	São Brás
6032	324	Traipu
6033	324	Japaratinga
6034	324	Maragogi
6035	324	Passo de Camaragibe
6036	324	Porto de Pedras
6037	324	São Miguel dos Milagres
6038	324	Barra de Santo Antônio
6039	324	Barra de São Miguel
6040	324	Coqueiro Seco
6041	324	Maceió (capital estatal)
6042	324	Marechal Deodoro
6043	324	Paripueira
6044	324	Pilar
6045	324	Rio Largo
6046	324	Santa Luzia do Norte
6047	324	Satuba
6048	324	Atalaia
6049	324	Branquinha
6050	324	Cajueiro
6051	324	Campestre
6052	324	Capela
6053	324	Colônia Leopoldina
6054	324	Flexeiras
6055	324	Jacuípe
6056	324	Joaquim Gomes
6057	324	Jundiá
6058	324	Matriz de Camaragibe
6059	324	Messias
6060	324	Murici
6061	324	Novo Lino
6062	324	Porto Calvo
6063	324	São Luís do Quitunde
6064	324	Feliz Deserto
6065	324	Igreja Nova
6066	324	Penedo
6067	324	Piaçabuçu
6068	324	Porto Real do Colégio
6069	324	Anadia
6070	324	Boca da Mata
6071	324	Campo Alegre
6072	324	Coruripe
6073	324	Jequiá da Praia
6074	324	Junqueiro
6075	324	Roteiro
6076	324	São Miguel dos Campos
6077	324	Teotônio Vilela
6078	324	Chã Preta
6079	324	Ibateguara
6080	324	Pindoba
6081	324	Santana do Mundaú
6082	324	São José da Laje
6083	324	União dos Palmares
6084	324	Viçosa
6085	324	Delmiro Gouveia
6086	324	Olho d'Água do Casado
6087	324	Piranhas
6088	324	Batalha
6089	324	Belo Monte
6090	324	Jacaré dos Homens
6091	324	Jaramataia
6092	324	Major Isidoro
6093	324	Monteirópolis
6094	324	Olho d'Água das Flores
6095	324	Olivença
6096	324	Carneiros
6097	324	Dois Riachos
6098	324	Maravilha
6099	324	Ouro Branco
6100	324	Palestina
6101	324	Pão de Açúcar
6102	324	Poço das Trincheiras
6103	324	Santana do Ipanema
6104	324	São José da Tapera
6105	324	Senador Rui Palmeira
6106	324	Água Branca
6107	324	Canapi
6108	324	Inhapi
6109	324	Mata Grande
6110	324	Pariconha
6111	325	Amapá
6112	325	Calçoene
6113	325	Cutias
6114	325	Ferreira Gomes
6115	325	Itaubal
6116	325	Laranjal do Jari
6117	325	Macapá
6118	325	Mazagão
6119	325	Oiapoque
6120	325	Pedra Branca do Amapari
6121	325	Porto Grande
6122	325	Pracuúba
6123	325	Santana
6124	325	Serra do Navio
6125	325	Tartarugalzinho
6126	325	Vitória do Jari
6127	326	Alvarães
6128	326	Amaturá
6129	326	Anamã
6130	326	Anori
6131	326	Apuí
6132	326	Atalaia do Norte
6133	326	Autazes
6134	326	Barcelos
6135	326	Barreirinha
6136	326	Benjamin Constant
6137	326	Beruri
6138	326	Boa Vista do Ramos
6139	326	Boca do Acre
6140	326	Borba
6141	326	Caapiranga
6142	326	Canutama
6143	326	Carauari
6144	326	Careiro
6145	326	Careiro da Várzea
6146	326	Coari
6147	326	Codajás
6148	326	Eirunepé
6149	326	Envira
6150	326	Fonte Boa
6151	326	Guajará
6152	326	Humaitá
6153	326	Ipixuna
6154	326	Iranduba
6155	326	Itacoatiara
6156	326	Itamarati
6157	326	Itapiranga
6158	326	Japurá
6159	326	Juruá
6160	326	Jutaí
6161	326	Lábrea
6162	326	Manacapuru
6163	326	Manaquiri
6164	326	Manaus
6165	326	Manicoré
6166	326	Maraã
6167	326	Maués
6168	326	Nhamundá
6169	326	Nova Olinda do Norte
6170	326	Novo Airão
6171	326	Novo Aripuanã
6172	326	Parintins
6173	326	Pauini
6174	326	Presidente Figueiredo
6175	326	Rio Preto da Eva
6176	326	Santa Isabel do Rio Negro
6177	326	Santo Antônio do Içá
6178	326	São Gabriel da Cachoeira
6179	326	São Paulo de Olivença
6180	326	São Sebastião do Uatumã
6181	326	Silves
6182	326	Tabatinga
6183	326	Tapauá
6184	326	Tefé
6185	326	Tonantins
6186	326	Uarini
6187	326	Urucará
6188	326	Urucurituba
6189	327	Água Fria
6190	327	Amélia Rodrigues
6191	327	Anguera
6192	327	Antônio Cardoso
6193	327	Conceição da Feira
6194	327	Coração de Maria
6195	327	Elísio Medrado
6196	327	Feira de Santana
6197	327	Ipecaetá
6198	327	Ipirá
6199	327	Irará
6200	327	Itatim
6201	327	Ouriçangas
6202	327	Pedrão
6203	327	Pintadas
6204	327	Rafael Jambeiro
6205	327	Santa Bárbara
6206	327	Santa Teresinha
6207	327	Santanópolis
6208	327	Santo Estêvão
6209	327	São Gonçalo dos Campos
6210	327	Serra Preta
6211	327	Tanquinho
6212	327	Teodoro Sampaio
6213	327	América Dourada
6214	327	Barra do Mendes
6215	327	Barro Alto
6216	327	Cafarnaum
6217	327	Canarana
6218	327	Central
6219	327	Gentio do Ouro
6220	327	Ibipeba
6221	327	Ibititá
6222	327	Iraquara
6223	327	Irecê
6224	327	João Dourado
6225	327	Jussara
6226	327	Lapão
6227	327	Mulungu do Morro
6228	327	Presidente Dutra
6229	327	São Gabriel
6230	327	Souto Soares
6231	327	Uibaí
6232	327	Baixa Grande
6233	327	Boa Vista do Tupim
6234	327	Iaçu
6235	327	Ibiquera
6236	327	Itaberaba
6237	327	Lajedinho
6238	327	Macajuba
6239	327	Mairi
6240	327	Mundo Novo
6241	327	Ruy Barbosa
6242	327	Tapiramutá
6243	327	Várzea da Roça
6244	327	Caém
6245	327	Caldeirão Grande
6246	327	Capim Grosso
6247	327	Jacobina
6248	327	Miguel Calmon
6249	327	Mirangaba
6250	327	Morro do Chapéu
6251	327	Ourolândia
6252	327	Piritiba
6253	327	Ponto Novo
6254	327	Quixabeira
6255	327	São José do Jacuípe
6256	327	Saúde
6257	327	Serrolândia
6258	327	Várzea do Poço
6259	327	Várzea Nova
6260	327	Andorinha
6261	327	Antônio Gonçalves
6262	327	Campo Formoso
6263	327	Filadélfia
6264	327	Itiúba
6265	327	Jaguarari
6266	327	Pindobaçu
6267	327	Senhor do Bonfim
6268	327	Umburanas
6269	327	Boquira
6270	327	Botuporã
6271	327	Brotas de Macaúbas
6272	327	Caturama
6273	327	Ibipitanga
6274	327	Ibitiara
6275	327	Ipupiara
6276	327	Macaúbas
6277	327	Novo Horizonte
6278	327	Oliveira dos Brejinhos
6279	327	Tanque Novo
6280	327	Aracatu
6281	327	Brumado
6282	327	Caraíbas
6283	327	Condeúba
6284	327	Cordeiros
6285	327	Guajeru
6286	327	Ituaçu
6287	327	Maetinga
6288	327	Malhada de Pedras
6289	327	Piripá
6290	327	Presidente Jânio Quadros
6291	327	Rio do Antônio
6292	327	Tanhaçu
6293	327	Tremedal
6294	327	Caculé
6295	327	Caetité
6296	327	Candiba
6297	327	Guanambi
6298	327	Ibiassucê
6299	327	Igaporã
6300	327	Iuiú
6301	327	Jacaraci
6302	327	Lagoa Real
6303	327	Licínio de Almeida
6304	327	Malhada
6305	327	Matina
6306	327	Mortugaba
6307	327	Palmas de Monte Alto
6308	327	Pindaí
6309	327	Riacho de Santana
6310	327	Sebastião Laranjeiras
6311	327	Urandi
6312	327	Encruzilhada
6313	327	Itambé
6314	327	Itapetinga
6315	327	Itarantim
6316	327	Itororó
6317	327	Macarani
6318	327	Maiquinique
6319	327	Potiraguá
6320	327	Ribeirão do Largo
6321	327	Aiquara
6322	327	Amargosa
6323	327	Apuarema
6324	327	Brejões
6325	327	Cravolândia
6326	327	Irajuba
6327	327	Iramaia
6328	327	Itagi
6329	327	Itaquara
6330	327	Itiruçu
6331	327	Jaguaquara
6332	327	Jequié
6333	327	Jiquiriçá
6334	327	Jitaúna
6335	327	Lafaiete Coutinho
6336	327	Laje
6337	327	Lajedo do Tabocal
6338	327	Maracás
6339	327	Marcionílio Souza
6340	327	Milagres
6341	327	Mutuípe
6342	327	Nova Itarana
6343	327	Planaltino
6344	327	Santa Inês
6345	327	São Miguel das Matas
6346	327	Ubaíra
6347	327	Dom Basílio
6348	327	Érico Cardoso
6349	327	Livramento de Nossa Senhora
6350	327	Paramirim
6351	327	Rio do Pires
6352	327	Abaíra
6353	327	Andaraí
6354	327	Barra da Estiva
6355	327	Boninal
6356	327	Bonito
6357	327	Contendas do Sincorá
6358	327	Ibicoara
6359	327	Itaeté
6360	327	Jussiape
6361	327	Lençóis
6362	327	Mucugê
6363	327	Nova Redenção
6364	327	Palmeiras
6365	327	Piatã
6366	327	Rio de Contas
6367	327	Seabra
6368	327	Utinga
6369	327	Wagner
6370	327	Anagé
6371	327	Barra do Choça
6372	327	Belo Campo
6373	327	Boa Nova
6374	327	Bom Jesus da Serra
6375	327	Caatiba
6376	327	Caetanos
6377	327	Cândido Sales
6378	327	Dário Meira
6379	327	Ibicuí
6380	327	Iguaí
6381	327	Manoel Vitorino
6382	327	Mirante
6383	327	Nova Canaã
6384	327	Planalto
6385	327	Poções
6386	327	Vitória da Conquista
6387	327	Baianópolis
6388	327	Barreiras
6389	327	Catolândia
6390	327	Formosa do Rio Preto
6391	327	Luís Eduardo Magalhães
6392	327	Riachão das Neves
6393	327	São Desidério
6394	327	Angical
6395	327	Brejolândia
6396	327	Cotegipe
6397	327	Cristópolis
6398	327	Mansidão
6399	327	Santa Rita de Cássia
6400	327	Tabocas do Brejo Velho
6401	327	Wanderley
6402	327	Canápolis
6403	327	Cocos
6404	327	Coribe
6405	327	Correntina
6406	327	Jaborandi
6407	327	Santa Maria da Vitória
6408	327	São Félix do Coribe
6409	327	Serra Dourada
6410	327	Catu
6411	327	Conceição do Jacuípe
6412	327	Itanagra
6413	327	Mata de São João
6414	327	Pojuca
6415	327	São Sebastião do Passé
6416	327	Terra Nova
6417	327	Camaçari
6418	327	Candeias
6419	327	Dias d'Ávila
6420	327	Itaparica
6421	327	Lauro de Freitas
6422	327	Madre de Deus
6423	327	Salvador (capital estatal)
6424	327	São Francisco do Conde
6425	327	Simões Filho
6426	327	Vera Cruz
6427	327	Aratuípe
6428	327	Cabaceiras do Paraguaçu
6429	327	Cachoeira
6430	327	Castro Alves
6431	327	Conceição do Almeida
6432	327	Cruz das Almas
6433	327	Dom Macedo Costa
6434	327	Governador Mangabeira
6435	327	Jaguaripe
6436	327	Maragogipe
6437	327	Muniz Ferreira
6438	327	Muritiba
6439	327	Nazaré
6440	327	Salinas da Margarida
6441	327	Santo Amaro
6442	327	Santo Antônio de Jesus
6443	327	São Felipe
6444	327	São Félix
6445	327	Sapeaçu
6446	327	Saubara
6447	327	Varzedo
6448	327	Acajutiba
6449	327	Alagoinhas
6450	327	Aporá
6451	327	Araças
6452	327	Aramari
6453	327	Barrocas
6454	327	Crisópolis
6455	327	Inhambupe
6456	327	Rio Real
6457	327	Sátiro Dias
6458	327	Cardeal da Silva
6459	327	Conde
6460	327	Entre Rios
6461	327	Esplanada
6462	327	Jandaíra
6463	327	Cansanção
6464	327	Canudos
6465	327	Euclides da Cunha
6466	327	Monte Santo
6467	327	Nordestina
6468	327	Queimadas
6469	327	Quijingue
6470	327	Tucano
6471	327	Uauá
6472	327	Coronel João Sá
6473	327	Jeremoabo
6474	327	Pedro Alexandre
6475	327	Santa Brígida
6476	327	Sítio do Quinto
6477	327	Adustina
6478	327	Antas
6479	327	Banzaê
6480	327	Cícero Dantas
6481	327	Cipó
6482	327	Fátima
6483	327	Heliópolis
6484	327	Itapicuru
6485	327	Nova Soure
6486	327	Novo Triunfo
6487	327	Olindina
6488	327	Paripiranga
6489	327	Ribeira do Amparo
6490	327	Ribeira do Pombal
6491	327	Araci
6492	327	Biritinga
6493	327	Candeal
6494	327	Capela do Alto Alegre
6495	327	Conceição do Coité
6496	327	Gavião
6497	327	Ichu
6498	327	Lamarão
6499	327	Nova Fátima
6500	327	Pé de Serra
6501	327	Retirolândia
6502	327	Riachão do Jacuípe
6503	327	Santaluz
6504	327	São Domingos
6505	327	Serrinha
6506	327	Teofilândia
6507	327	Valente
6508	327	Almadina
6509	327	Arataca
6510	327	Aurelino Leal
6511	327	Barra do Rocha
6512	327	Belmonte
6513	327	Buerarema
6514	327	Camacan
6515	327	Canavieiras
6516	327	Coaraci
6517	327	Firmino Alves
6518	327	Floresta Azul
6519	327	Gandu
6520	327	Gongogi
6521	327	Governador Lomanto Júnior
6522	327	Ibicaraí
6523	327	Ibirapitanga
6524	327	Ibirataia
6525	327	Ilhéus
6526	327	Ipiaú
6527	327	Itabuna
6528	327	Itacaré
6529	327	Itagibá
6530	327	Itaju do Colônia
6531	327	Itajuípe
6532	327	Itamari
6533	327	Itapé
6534	327	Itapebi
6535	327	Itapitanga
6536	327	Jussari
6537	327	Mascote
6538	327	Nova Ibiá
6539	327	Pau Brasil
6540	327	Santa Cruz da Vitória
6541	327	Santa Luzia
6542	327	São José da Vitória
6543	327	Teolândia
6544	327	Ubaitaba
6545	327	Ubatã
6546	327	Una
6547	327	Uruçuca
6548	327	Wenceslau Guimarães
6549	327	Alcobaça
6550	327	Caravelas
6551	327	Eunápolis
6552	327	Guaratinga
6553	327	Ibirapuã
6554	327	Itabela
6555	327	Itagimirim
6556	327	Itamaraju
6557	327	Itanhém
6558	327	Jucuruçu
6559	327	Lajedão
6560	327	Medeiros Neto
6561	327	Mucuri
6562	327	Nova Viçosa
6563	327	Porto Seguro
6564	327	Prado
6565	327	Santa Cruz Cabrália
6566	327	Teixeira de Freitas
6567	327	Vereda
6568	327	Cairu
6569	327	Camamu
6570	327	Igrapiúna
6571	327	Ituberá
6572	327	Maraú
6573	327	Nilo Peçanha
6574	327	Piraí do Norte
6575	327	Presidente Tancredo Neves
6576	327	Taperoá
6577	327	Valença
6578	327	Barra
6579	327	Buritirama
6580	327	Ibotirama
6581	327	Itaguaçu da Bahia
6582	327	Morpará
6583	327	Muquém de São Francisco
6584	327	Xique-Xique
6585	327	Bom Jesus da Lapa
6586	327	Carinhanha
6587	327	Feira da Mata
6588	327	Paratinga
6589	327	Serra do Ramalho
6590	327	Sítio do Mato
6591	327	Campo Alegre de Lourdes
6592	327	Casa Nova
6593	327	Curaçá
6594	327	Juazeiro
6595	327	Pilão Arcado
6596	327	Remanso
6597	327	Sento Sé
6598	327	Sobradinho
6599	327	Abaré
6600	327	Chorrochó
6601	327	Glória
6602	327	Macururé
6603	327	Paulo Afonso
6604	327	Rodelas
6605	328	Cedro
6606	328	Icó
6607	328	Iguatu
6608	328	Orós
6609	328	Quixelô
6610	328	Baixio
6611	328	Ipaumirim
6612	328	Lavras da Mangabeira
6613	328	Umari
6614	328	Antonina do Norte
6615	328	Cariús
6616	328	Jucás
6617	328	Tarrafas
6618	328	Várzea Alegre
6619	328	Alto Santo
6620	328	Ibicuitinga
6621	328	Jaguaruana
6622	328	Limoeiro do Norte
6623	328	Morada Nova
6624	328	Palhano
6625	328	Quixeré
6626	328	Russas
6627	328	São João do Jaguaribe
6628	328	Tabuleiro do Norte
6629	328	Aracati
6630	328	Fortim
6631	328	Icapuí
6632	328	Itaiçaba
6633	328	Jaguaretama
6634	328	Jaguaribara
6635	328	Jaguaribe
6636	328	Ererê
6637	328	Iracema
6638	328	Pereiro
6639	328	Potiretama
6640	328	Aquiraz
6641	328	Caucaia
6642	328	Eusébio
6643	328	Fortaleza
6644	328	(capital estatal)
6645	328	Guaiúba
6646	328	Itaitinga
6647	328	Maracanaú
6648	328	Maranguape
6649	328	Pacatuba
6650	328	Horizonte
6651	328	Pacajús
6652	328	Coreaú
6653	328	Frecheirinha
6654	328	Moraújo
6655	328	Uruoca
6656	328	Carnaubal
6657	328	Croatá
6658	328	Guaraciaba do Norte
6659	328	Ibiapina
6660	328	São Benedito
6661	328	Tianguá
6662	328	Ubajara
6663	328	Viçosa do Ceará
6664	328	Ipú
6665	328	Ipueiras
6666	328	Pires Ferreira
6667	328	Poranga
6668	328	Reriutaba
6669	328	Varjota
6670	328	Acaraú
6671	328	Barroquinha
6672	328	Bela Cruz
6673	328	Camocim
6674	328	Chaval
6675	328	Cruz
6676	328	Granja
6677	328	Itarema
6678	328	Jijoca de Jericoacoara
6679	328	Marco
6680	328	Martinópole
6681	328	Morrinhos
6682	328	Alcântaras
6683	328	Meruoca
6684	328	Catunda
6685	328	Hidrolândia
6686	328	Santa Quitéria
6687	328	Cariré
6688	328	Forquilha
6689	328	Graça
6690	328	Groaíras
6691	328	Irauçuba
6692	328	Massapê
6693	328	Miraíma
6694	328	Mucambo
6695	328	Pacujá
6696	328	Santana do Acaraú
6697	328	Senador Sá
6698	328	Sobral
6699	328	Paracuru
6700	328	Paraipaba
6701	328	São Gonçalo do Amarante
6702	328	Acarapé
6703	328	Araçoiaba
6704	328	Aratuba
6705	328	Baturité
6706	328	Capistrano
6707	328	Guaramiranga
6708	328	Itapiúna
6709	328	Mulungu
6710	328	Pacoti
6711	328	Palmácia
6712	328	Redenção
6713	328	Canindé
6714	328	Caridade
6715	328	Itatira
6716	328	Paramoti
6717	328	Beberibe
6718	328	Cascavel
6719	328	Pindoretama
6720	328	Barreira
6721	328	Chorozinho
6722	328	Ocara
6723	328	Amontada
6724	328	Itapipoca
6725	328	Trairi
6726	328	Apuiarés
6727	328	General Sampaio
6728	328	Pentecoste
6729	328	São Luís do Curu
6730	328	Tejuçuoca
6731	328	Itapagé
6732	328	Tururu
6733	328	Umirim
6734	328	Uruburetama
6735	328	Ararendá
6736	328	Crateús
6737	328	Independência
6738	328	Ipaporanga
6739	328	Monsenhor Tabosa
6740	328	Nova Russas
6741	328	Novo Oriente
6742	328	Quiterianópolis
6743	328	Tamboril
6744	328	Aiuaba
6745	328	Arneiroz
6746	328	Catarina
6747	328	Parambu
6748	328	Saboeiro
6749	328	Tauá
6750	328	Banabuiú
6751	328	Boa Viagem
6752	328	Choró
6753	328	Ibaretama
6754	328	Madalena
6755	328	Quixadá
6756	328	Quixeramobim
6757	328	Acopiara
6758	328	Deputado Irapuan Pinheiro
6759	328	Milhã
6760	328	Mombaça
6761	328	Pedra Branca
6762	328	Piquet Carneiro
6763	328	Senador Pompeu
6764	328	Solonópole
6765	328	Aurora
6766	328	Barro
6767	328	Mauriti
6768	328	Abaiara
6769	328	Brejo Santo
6770	328	Jati
6771	328	Penaforte
6772	328	Barbalha
6773	328	Crato
6774	328	Jardim
6775	328	Juazeiro do Norte
6776	328	Missão Velha
6777	328	Nova Olinda
6778	328	Porteiras
6779	328	Santana do Cariri
6780	328	Altaneira
6781	328	Caririaçú
6782	328	Farias Brito
6783	328	Granjeiro
6784	328	Araripe
6785	328	Assaré
6786	328	Campos Sales
6787	328	Potengi
6788	328	Salitre
6789	329	Brasília
6790	329	Gama
6791	329	Taguatinga
6792	329	Brazlândia
6793	329	Planaltina
6794	329	Paranoá
6795	329	Núcleo Bandeirante
6796	329	Ceilândia
6797	329	Guará
6798	329	Cruzeiro
6799	329	Samambaia
6800	329	Santa Maria
6801	329	Recanto das Emas
6802	329	Lago Sul
6803	329	Riacho Fundo
6804	329	Lago Norte
6805	329	Candangolândia
6806	329	Águas Claras
6807	329	Riacho Fundo II
6808	329	Sudoeste/Octogonal
6809	329	Varjão
6810	329	Park Way
6811	329	SCIA
6812	329	Sobradinho II
6813	329	Jardim Botânico
6814	329	Itapoã
6815	329	SIA
6816	329	Vicente Pires
6817	329	Fercal
6818	330	Afonso Cláudio
6819	330	Brejetuba
6820	330	Conceição do Castelo
6821	330	Domingos Martins
6822	330	Laranja da Terra
6823	330	Marechal Floriano
6824	330	Venda Nova do Imigrante
6825	330	Alfredo Chaves
6826	330	Anchieta
6827	330	Guarapari
6828	330	Iconha
6829	330	Piúma
6830	330	Rio Novo do Sul
6831	330	Itaguaçu
6832	330	Itarana
6833	330	Santa Leopoldina
6834	330	Santa Maria do Jetibá
6835	330	Santa Teresa
6836	330	São Roque do Canaã
6837	330	Cariacica
6838	330	Serra
6839	330	Viana
6840	330	Vila Velha
6841	330	Vitória (State Capital)
6842	330	Aracruz
6843	330	Fundão
6844	330	Ibiraçu
6845	330	João Neiva
6846	330	Linhares
6847	330	Rio Bananal
6848	330	Sooretama
6849	330	Montanha
6850	330	Mucurici
6851	330	Pinheiros
6852	330	Ponto Belo
6853	330	Conceição da Barra
6854	330	Jaguaré
6855	330	Pedro Canário
6856	330	São Mateus
6857	330	Água Doce do Norte
6858	330	Barra de São Francisco
6859	330	Ecoporanga
6860	330	Mantenópolis
6861	330	Alto Rio Novo
6862	330	Baixo Guandu
6863	330	Colatina
6864	330	Governador Lindenberg
6865	330	Marilândia
6866	330	Pancas
6867	330	São Domingos do Norte
6868	330	Águia Branca
6869	330	Boa Esperança
6870	330	Nova Venécia
6871	330	São Gabriel da Palha
6872	330	Vila Pavão
6873	330	Vila Valério
6874	330	Alegre
6875	330	Divino de São Lourenço
6876	330	Dores do Rio Preto
6877	330	Guaçuí
6878	330	Ibatiba
6879	330	Ibitirama
6880	330	Irupi
6881	330	Iúna
6882	330	Muniz Freire
6883	330	Apiacá
6884	330	Atilio Vivacqua
6885	330	Bom Jesus do Norte
6886	330	Cachoeiro de Itapemirim
6887	330	Castelo
6888	330	Jerônimo Monteiro
6889	330	Mimoso do Sul
6890	330	Muqui
6891	330	São José do Calçado
6892	330	Vargem Alta
6893	330	Itapemirim
6894	330	Marataízes
6895	330	Presidente Kennedy
6896	331	Anápolis
6897	331	Araçu
6898	331	Brazabrantes
6899	331	Campo Limpo de Goiás
6900	331	Caturaí
6901	331	Damolândia
6902	331	Heitoraí
6903	331	Inhumas
6904	331	Itaberaí
6905	331	Itaguari
6906	331	Itaguaru
6907	331	Itauçu
6908	331	Jaraguá
6909	331	Jesúpolis
6910	331	Nova Veneza
6911	331	Ouro Verde de Goiás
6912	331	Petrolina de Goiás
6913	331	Santa Rosa de Goiás
6914	331	São Francisco de Goiás
6915	331	Taquaral de Goiás
6916	331	Adelândia
6917	331	Americano do Brasil
6918	331	Anicuns
6919	331	Aurilândia
6920	331	Avelinópolis
6921	331	Buriti de Goiás
6922	331	Firminópolis
6923	331	Mossâmedes
6924	331	Nazário
6925	331	Sanclerlândia
6926	331	Santa Bárbara de Goiás
6927	331	São Luís de Montes Belos
6928	331	Turvânia
6929	331	Carmo do Rio Verde
6930	331	Ceres
6931	331	Goianésia
6932	331	Guaraíta
6933	331	Guarinos
6934	331	Hidrolina
6935	331	Ipiranga de Goiás
6936	331	Itapaci
6937	331	Itapuranga
6938	331	Morro Agudo de Goiás
6939	331	Nova América
6940	331	Nova Glória
6941	331	Pilar de Goiás
6942	331	Rialma
6943	331	Rianápolis
6944	331	Rubiataba
6945	331	Santa Isabel
6946	331	Santa Rita do Novo Destino
6947	331	São Luíz do Norte
6948	331	São Patrício
6949	331	Uruana
6950	331	Abadia de Goiás
6951	331	Aparecida de Goiânia
6952	331	Aragoiânia
6953	331	Bela Vista de Goiás
6954	331	Bonfinópolis
6955	331	Caldazinha
6956	331	Goianápolis
6957	331	Goiânia
6958	331	Goianira
6959	331	Guapó
6960	331	Leopoldo de Bulhões
6961	331	Nerópolis
6962	331	Santo Antônio de Goiás
6963	331	Senador Canedo
6964	331	Terezópolis de Goiás
6965	331	Trindade
6966	331	Amorinópolis
6967	331	Cachoeira de Goiás
6968	331	Córrego do Ouro
6969	331	Fazenda Nova
6970	331	Iporá
6971	331	Israelândia
6972	331	Ivolândia
6973	331	Jaupaci
6974	331	Moiporá
6975	331	Novo Brasil
6976	331	Abadiânia
6977	331	Água Fria de Goiás
6978	331	Águas Lindas de Goiás
6979	331	Alexânia
6980	331	Cabeceiras
6981	331	Cidade Ocidental
6982	331	Cocalzinho de Goiás
6983	331	Corumbá de Goiás
6984	331	Cristalina
6985	331	Formosa
6986	331	Luziânia
6987	331	Mimoso de Goiás
6988	331	Novo Gama
6989	331	Padre Bernardo
6990	331	Pirenópolis
6991	331	Santo Antônio do Descoberto
6992	331	Valparaíso de Goiás
6993	331	Vila Boa
6994	331	Vila Propício
6995	331	Alvorada do Norte
6996	331	Buritinópolis
6997	331	Damianópolis
6998	331	Divinópolis de Goiás
6999	331	Flores de Goiás
7000	331	Guarani de Goiás
7001	331	Iaciara
7002	331	Mambaí
7003	331	Posse
7004	331	Simolândia
7005	331	Sítio d'Abadia
7006	331	Aragarças
7007	331	Arenópolis
7008	331	Baliza
7009	331	Bom Jardim de Goiás
7010	331	Diorama
7011	331	Montes Claros de Goiás
7012	331	Araguapaz
7013	331	Aruanã
7014	331	Britânia
7015	331	Faina
7016	331	Goiás
7017	331	Itapirapuã
7018	331	Matrinchã
7019	331	Santa Fé de Goiás
7020	331	Crixás
7021	331	Mozarlândia
7022	331	Nova Crixás
7023	331	Novo Planalto
7024	331	São Miguel do Araguaia
7025	331	Uirapuru
7026	331	Alto Paraíso de Goiás
7027	331	Campos Belos
7028	331	Cavalcante
7029	331	Colinas do Sul
7030	331	Monte Alegre de Goiás
7031	331	Nova Roma
7032	331	São João d'Aliança
7033	331	Teresina de Goiás
7034	331	Alto Horizonte
7035	331	Amaralina
7036	331	Bonópolis
7037	331	Campinaçu
7038	331	Campinorte
7039	331	Campos Verdes
7040	331	Estrela do Norte
7041	331	Formoso
7042	331	Mara Rosa
7043	331	Minaçu
7044	331	Montividiu do Norte
7045	331	Mutunópolis
7046	331	Niquelândia
7047	331	Nova Iguaçu de Goiás
7048	331	Porangatu
7049	331	Santa Tereza de Goiás
7050	331	Santa Terezinha de Goiás
7051	331	Trombas
7052	331	Uruaçu
7053	331	Anhanguera
7054	331	Campo Alegre de Goiás
7055	331	Catalão
7056	331	Corumbaíba
7057	331	Cumari
7058	331	Davinópolis
7059	331	Goiandira
7060	331	Ipameri
7061	331	Nova Aurora
7062	331	Ouvidor
7063	331	Três Ranchos
7064	331	Água Limpa
7065	331	Aloândia
7066	331	Bom Jesus de Goiás
7067	331	Buriti Alegre
7068	331	Cachoeira Dourada
7069	331	Caldas Novas
7070	331	Cromínia
7071	331	Goiatuba
7072	331	Inaciolândia
7073	331	Itumbiara
7074	331	Joviânia
7075	331	Mairipotaba
7076	331	Marzagão
7077	331	Panamá
7078	331	Piracanjuba
7079	331	Pontalina
7080	331	Porteirão
7081	331	Professor Jamil
7082	331	Rio Quente
7083	331	Vicentinópolis
7084	331	Cristianópolis
7085	331	Gameleira de Goiás
7086	331	Orizona
7087	331	Palmelo
7088	331	Pires do Rio
7089	331	Santa Cruz de Goiás
7090	331	São Miguel do Passa Quatro
7091	331	Silvânia
7092	331	Urutaí
7093	331	Vianópolis
7094	331	Cachoeira Alta
7095	331	Caçu
7096	331	Gouvelândia
7097	331	Itajá
7098	331	Itarumã
7099	331	Lagoa Santa
7100	331	Paranaiguara
7101	331	Quirinópolis
7102	331	São Simão
7103	331	Aparecida do Rio Doce
7104	331	Aporé
7105	331	Caiapônia
7106	331	Castelândia
7107	331	Chapadão do Céu
7108	331	Doverlândia
7109	331	Jataí
7110	331	Maurilândia
7111	331	Mineiros
7112	331	Montividiu
7113	331	Palestina de Goiás
7114	331	Perolândia
7115	331	Portelândia
7116	331	Rio Verde
7117	331	Santa Helena de Goiás
7118	331	Santa Rita do Araguaia
7119	331	Santo Antônio da Barra
7120	331	Serranópolis
7121	331	Acreúna
7122	331	Campestre de Goiás
7123	331	Cezarina
7124	331	Edealina
7125	331	Edéia
7126	331	Indiara
7127	331	Jandaia
7128	331	Palmeiras de Goiás
7129	331	Palminópolis
7130	331	Paraúna
7131	331	São João da Paraúna
7132	331	Turvelândia
7133	332	Arame
7134	332	Barra do Corda
7135	332	Fernando Falcão
7136	332	Formosa da Serra Negra
7137	332	Grajaú
7138	332	Itaipava do Grajaú
7139	332	Jenipapo dos Vieiras
7140	332	Joselândia
7141	332	Santa Filomena do Maranhão
7142	332	Sítio Novo
7143	332	Tuntum
7144	332	Bacabal
7145	332	Bernardo do Mearim
7146	332	Bom Lugar
7147	332	Esperantinópolis
7148	332	Igarapé Grande
7149	332	Lago do Junco
7150	332	Lago dos Rodrigues
7151	332	Lago Verde
7152	332	Lima Campos
7153	332	Olho d'Água das Cunhãs
7154	332	Pedreiras
7155	332	Pio XII
7156	332	Poção de Pedras
7157	332	Santo Antônio dos Lopes
7158	332	São Luís Gonzaga do Maranhão
7159	332	São Mateus do Maranhão
7160	332	São Raimundo do Doca Bezerra
7161	332	São Roberto
7162	332	Satubinha
7163	332	Trizidela do Vale
7164	332	Dom Pedro
7165	332	Fortuna
7166	332	Gonçalves Dias
7167	332	Governador Archer
7168	332	Governador Eugênio Barros
7169	332	Governador Luiz Rocha
7170	332	Graça Aranha
7171	332	Senador Alexandre Costa
7172	332	São Domingos do Maranhão
7173	332	São José dos Basílios
7174	332	Água Doce do Maranhão
7175	332	Araioses
7176	332	Magalhães de Almeida
7177	332	Santa Quitéria do Maranhão
7178	332	Santana do Maranhão
7179	332	São Bernardo
7180	332	Buriti Bravo
7181	332	Caxias
7182	332	Matões
7183	332	Parnarama
7184	332	São João do Soter
7185	332	Timon
7186	332	Barão de Grajaú
7187	332	Colinas
7188	332	Jatobá
7189	332	Lagoa do Mato
7190	332	Mirador
7191	332	Nova Iorque
7192	332	Paraibano
7193	332	Passagem Franca
7194	332	Pastos Bons
7195	332	São Francisco do Maranhão
7196	332	São João dos Patos
7197	332	Sucupira do Norte
7198	332	Sucupira do Riachão
7199	332	Anapurus
7200	332	Belágua
7201	332	Brejo
7202	332	Buriti
7203	332	Chapadinha
7204	332	Mata Roma
7205	332	Milagres do Maranhão
7206	332	São Benedito do Rio Preto
7207	332	Urbano Santos
7208	332	Alto Alegre do Maranhão
7209	332	Capinzal do Norte
7210	332	Codó
7211	332	Coroatá
7212	332	Peritoró
7213	332	Timbiras
7214	332	Afonso Cunha
7215	332	Aldeias Altas
7216	332	Coelho Neto
7217	332	Duque Bacelar
7218	332	Paço do Lumiar
7219	332	Raposa (Maranhão)
7220	332	São José de Ribamar
7221	332	São Luís
7222	332	Anajatuba
7223	332	Arari
7224	332	Bela Vista do Maranhão
7225	332	Cajari
7226	332	Conceição do Lago-Açu
7227	332	Igarapé do Meio
7228	332	Matinha
7229	332	Monção
7230	332	Olinda Nova do Maranhão
7231	332	Palmeirândia
7232	332	Pedro do Rosário
7233	332	Penalva
7234	332	Peri Mirim
7235	332	Pinheiro
7236	332	Presidente Sarney
7237	332	Santa Helena
7238	332	São Bento
7239	332	São João Batista
7240	332	São Vicente Ferrer
7241	332	Vitória do Mearim
7242	332	Cantanhede
7243	332	Itapecuru Mirim
7244	332	Matões do Norte
7245	332	Miranda do Norte
7246	332	Nina Rodrigues
7247	332	Pirapemas
7248	332	Presidente Vargas
7249	332	Vargem Grande
7250	332	Barreirinhas
7251	332	Humberto de Campos
7252	332	Paulino Neves
7253	332	Primeira Cruz
7254	332	Santo Amaro do Maranhão
7255	332	Tutóia
7256	332	Alcântara
7257	332	Apicum-Açu
7258	332	Bacuri
7259	332	Bacurituba
7260	332	Bequimão
7261	332	Cajapió
7262	332	Cedral
7263	332	Central do Maranhão
7264	332	Cururupu
7265	332	Guimarães
7266	332	Mirinzal
7267	332	Porto Rico do Maranhão
7268	332	Serrano do Maranhão
7269	332	Axixá
7270	332	Bacabeira
7271	332	Cachoeira Grande
7272	332	Icatu
7273	332	Morros
7274	332	Presidente Juscelino
7275	332	Rosário
7276	332	Santa Rita
7277	332	Amapá do Maranhão
7278	332	Boa Vista do Gurupi
7279	332	Cândido Mendes
7280	332	Carutapera
7281	332	Centro do Guilherme
7282	332	Centro Novo do Maranhão
7283	332	Godofredo Viana
7284	332	Governador Nunes Freire
7285	332	Junco do Maranhão
7286	332	Luís Domingues
7287	332	Maracaçumé
7288	332	Maranhãozinho
7289	332	Turiaçu
7290	332	Turilândia
7291	332	Açailândia
7292	332	Amarante do Maranhão
7293	332	Buritirana
7294	332	Cidelândia
7295	332	Governador Edison Lobão
7296	332	Imperatriz
7297	332	Itinga do Maranhão
7298	332	João Lisboa
7299	332	Lajeado Novo
7300	332	Montes Altos
7301	332	Ribamar Fiquene
7302	332	São Francisco do Brejão
7303	332	São Pedro da Água Branca
7304	332	Senador La Rocque
7305	332	Vila Nova dos Martírios
7306	332	Altamira do Maranhão
7307	332	Alto Alegre do Pindaré
7308	332	Araguanã
7309	332	Bom Jardim
7310	332	Bom Jesus das Selvas
7311	332	Brejo de Areia
7312	332	Buriticupu
7313	332	Governador Newton Bello
7314	332	Lagoa Grande do Maranhão
7315	332	Lago da Pedra
7316	332	Marajá do Sena
7317	332	Nova Olinda do Maranhão
7318	332	Paulo Ramos
7319	332	Pindaré-Mirim
7320	332	Presidente Médici
7321	332	Santa Luzia do Paruá
7322	332	São João do Carú
7323	332	Tufilândia
7324	332	Vitorino Freire
7325	332	Zé Doca
7326	332	Benedito Leite
7327	332	Fortaleza dos Nogueiras
7328	332	Loreto
7329	332	Nova Colinas
7330	332	Sambaíba
7331	332	São Domingos do Azeitão
7332	332	São Félix de Balsas
7333	332	São Raimundo das Mangabeiras
7334	332	Alto Parnaíba
7335	332	Balsas
7336	332	Feira Nova do Maranhão
7337	332	Riachão
7338	332	Tasso Fragoso
7339	332	Campestre do Maranhão
7340	332	Carolina
7341	332	Estreito
7342	332	Porto Franco
7343	332	São João do Paraíso
7344	332	São Pedro dos Crentes
7345	333	Acorizal
7346	333	Água Boa
7347	333	Alta Floresta
7348	333	Alto Araguaia
7349	333	Alto da Boa Vista
7350	333	Alto Garças
7351	333	Alto Paraguai
7352	333	Alto Taquari
7353	333	Apiacás
7354	333	Araguaiana
7355	333	Araguainha
7356	333	Araputanga
7357	333	Arenápolis
7358	333	Aripuanã
7359	333	Barão de Melgaço
7360	333	Barra do Bugres
7361	333	Barra do Garças
7362	333	Bom Jesus do Araguaia
7363	333	Brasnorte
7364	333	Cáceres
7365	333	Campinápolis
7366	333	Campo Novo do Parecis
7367	333	Campo Verde
7368	333	Campos de Júlio
7369	333	Canabrava do Norte
7370	333	Carlinda
7371	333	Castanheira
7372	333	Chapada dos Guimarães
7373	333	Cláudia
7374	333	Cocalinho
7375	333	Colíder
7376	333	Colniza
7377	333	Comodoro
7378	333	Confresa
7379	333	Conquista d'Oeste
7380	333	Cotriguaçu
7381	333	Cuiabá
7382	333	Curvelândia
7383	333	Denise
7384	333	Diamantino
7385	333	Dom Aquino
7386	333	Feliz Natal
7387	333	Figueirópolis d'Oeste
7388	333	Gaúcha do Norte
7389	333	General Carneiro
7390	333	Glória d'Oeste
7391	333	Guarantã do Norte
7392	333	Guiratinga
7393	333	Indiavaí
7394	333	Ipiranga do Norte
7395	333	Itanhangá
7396	333	Itaúba
7397	333	Itiquira
7398	333	Jaciara
7399	333	Jangada
7400	333	Jauru
7401	333	Juara
7402	333	Juína
7403	333	Juruena
7404	333	Juscimeira
7405	333	Lambari d'Oeste
7406	333	Lucas do Rio Verde
7407	333	Luciara
7408	333	Marcelândia
7409	333	Matupá
7410	333	Mirassol d'Oeste
7411	333	Nobres
7412	333	Nortelândia
7413	333	Nossa Senhora do Livramento
7414	333	Nova Bandeirantes
7415	333	Nova Brasilândia
7416	333	Nova Canaã do Norte
7417	333	Nova Fronteira
7418	333	Nova Guarita
7419	333	Nova Lacerda
7420	333	Nova Marilândia
7421	333	Nova Maringá
7422	333	Nova Monte Verde
7423	333	Nova Mutum
7424	333	Nova Nazaré
7425	333	Nova Olímpia
7426	333	Nova Santa Helena
7427	333	Nova Ubiratã
7428	333	Nova Xavantina
7429	333	Novo Horizonte do Norte
7430	333	Novo Mundo
7431	333	Novo Santo Antônio
7432	333	Novo São Joaquim
7433	333	Paranaíta
7434	333	Paranatinga
7435	333	Pedra Preta
7436	333	Peixoto de Azevedo
7437	333	Planalto da Serra
7438	333	Poconé
7439	333	Pontal do Araguaia
7440	333	Ponte Branca
7441	333	Pontes e Lacerda
7442	333	Porto Alegre do Norte
7443	333	Porto dos Gaúchos
7444	333	Porto Esperidião
7445	333	Porto Estrela
7446	333	Poxoréu
7447	333	Primavera do Leste
7448	333	Querência
7449	333	Reserva do Cabaçal
7450	333	Ribeirão Cascalheira
7451	333	Ribeirãozinho
7452	333	Rio Branco
7453	333	Rondolândia
7454	333	Rondonópolis
7455	333	Rosário Oeste
7456	333	Salto do Céu
7457	333	Santa Carmem
7458	333	Santa Cruz do Xingu
7459	333	Santa Rita do Trivelato
7460	333	Santa Terezinha
7461	333	Santo Afonso
7462	333	Santo Antônio do Leste
7463	333	Santo Antônio do Leverger
7464	333	São Félix do Araguaia
7465	333	São José do Povo
7466	333	São José do Rio Claro
7467	333	São José do Xingu
7468	333	São José dos Quatro Marcos
7469	333	São Pedro da Cipa
7470	333	Sapezal
7471	333	Serra Nova Dourada
7472	333	Sinop
7473	333	Sorriso
7474	333	Tabaporã
7475	333	Tangará da Serra
7476	333	Tapurah
7477	333	Terra Nova do Norte
7478	333	Tesouro
7479	333	Torixoréu
7480	333	União do Sul
7481	333	Vale de São Domingos
7482	333	Várzea Grande
7483	333	Vera
7484	333	Vila Bela da Santíssima Trindade
7485	333	Vila Rica
7486	334	Água Clara
7487	334	Alcinópolis
7488	334	Amambai
7489	334	Anastácio
7490	334	Anaurilândia
7491	334	Angélica
7492	334	Antônio João
7493	334	Aparecida do Taboado
7494	334	Aquidauana
7495	334	Aral Moreira
7496	334	Bandeirantes
7497	334	Bataguassu
7498	334	Batayporã
7499	334	Bela Vista
7500	334	Bodoquena
7501	334	Brasilândia
7502	334	Caarapó
7503	334	Camapuã
7504	334	Caracol
7505	334	Cassilândia
7506	334	Chapadão do Sul
7507	334	Corguinho
7508	334	Coronel Sapucaia
7509	334	Corumbá
7510	334	Costa Rica
7511	334	Coxim
7512	334	Deodápolis
7513	334	Dois Irmãos do Buriti
7514	334	Douradina
7515	334	Dourados
7516	334	Eldorado
7517	334	Fátima do Sul
7518	334	Figueirão
7519	334	Glória de Dourados
7520	334	Guia Lopes da Laguna
7521	334	Iguatemi
7522	334	Inocência
7523	334	Itaporã
7524	334	Itaquiraí
7525	334	Ivinhema
7526	334	Japorã
7527	334	Jaraguari
7528	334	Jateí
7529	334	Juti
7530	334	Ladário
7531	334	Laguna Carapã
7532	334	Maracaju
7533	334	Miranda
7534	334	Naviraí
7535	334	Nioaque
7536	334	Nova Alvorada do Sul
7537	334	Nova Andradina
7538	334	Novo Horizonte do Sul
7539	334	Paraíso das Águas
7540	334	Paranaíba
7541	334	Paranhos
7542	334	Pedro Gomes
7543	334	Ponta Porã
7544	334	Porto Murtinho
7545	334	Ribas do Rio Pardo
7546	334	Rio Brilhante
7547	334	Rio Negro
7548	334	Rio Verde de Mato Grosso
7549	334	Rochedo
7550	334	Santa Rita do Pardo
7551	334	São Gabriel do Oeste
7552	334	Selvíria
7553	334	Sete Quedas
7554	334	Sidrolândia
7555	334	Sonora
7556	334	Tacuru
7557	334	Taquarussu
7558	334	Terrenos
7559	334	Três Lagoas
7560	334	Vicentina
7561	335	Alfredo Vasconcelos
7562	335	Antônio Carlos
7563	335	Barbacena
7564	335	Barroso
7565	335	Capela Nova
7566	335	Caranaíba
7567	335	Carandaí
7568	335	Desterro do Melo
7569	335	Ibertioga
7570	335	Ressaquinha
7571	335	Santa Bárbara do Tugúrio
7572	335	Senhora dos Remédios
7573	335	Carrancas
7574	335	Ijaci
7575	335	Ingaí
7576	335	Itumirim
7577	335	Itutinga
7578	335	Lavras
7579	335	Luminárias
7580	335	Nepomuceno
7581	335	Ribeirão Vermelho
7582	335	Conceição da Barra de Minas
7583	335	Coronel Xavier Chaves
7584	335	Dores de Campos
7585	335	Lagoa Dourada
7586	335	Madre de Deus de Minas
7587	335	Nazareno
7588	335	Piedade do Rio Grande
7589	335	Prados
7590	335	Resende Costa
7591	335	Ritápolis
7592	335	Santa Cruz de Minas
7593	335	Santana do Garambéu
7594	335	São João del Rei
7595	335	São Tiago
7596	335	Tiradentes
7597	335	Araújos
7598	335	Bom Despacho
7599	335	Dores do Indaiá
7600	335	Estrela do Indaiá
7601	335	Japaraíba
7602	335	Lagoa da Prata
7603	335	Leandro Ferreira
7604	335	Luz
7605	335	Martinho Campos
7606	335	Moema
7607	335	Quartel Geral
7608	335	Serra da Saudade
7609	335	Augusto de Lima
7610	335	Buenópolis
7611	335	Corinto
7612	335	Curvelo
7613	335	Felixlândia
7614	335	Inimutaba
7615	335	Joaquim Felício
7616	335	Monjolos
7617	335	Morro da Garça
7618	335	Santo Hipólito
7619	335	Abaeté
7620	335	Biquinhas
7621	335	Cedro do Abaeté
7622	335	Morada Nova de Minas
7623	335	Paineiras
7624	335	Pompéu
7625	335	Três Marias
7626	335	Almenara
7627	335	Bandeira
7628	335	Divisópolis
7629	335	Felisburgo
7630	335	Jacinto
7631	335	Jequitinhonha
7632	335	Joaíma
7633	335	Jordânia
7634	335	Mata Verde
7635	335	Monte Formoso
7636	335	Palmópolis
7637	335	Rio do Prado
7638	335	Rubim
7639	335	Salto da Divisa
7640	335	Santa Maria do Salto
7641	335	Santo Antônio do Jacinto
7642	335	Araçuaí
7643	335	Caraí
7644	335	Coronel Murta
7645	335	Itinga
7646	335	Novo Cruzeiro
7647	335	Padre Paraíso
7648	335	Ponto dos Volantes
7649	335	Virgem da Lapa
7650	335	Angelândia
7651	335	Aricanduva
7652	335	Berilo
7653	335	Capelinha
7654	335	Carbonita
7655	335	Chapada do Norte
7656	335	Francisco Badaró
7657	335	Itamarandiba
7658	335	Jenipapo de Minas
7659	335	José Gonçalves de Minas
7660	335	Leme do Prado
7661	335	Minas Novas
7662	335	Turmalina
7663	335	Veredinha
7664	335	Couto de Magalhaes de Minas
7665	335	Datas
7666	335	Diamantina
7667	335	Felício dos Santos
7668	335	Gouveia
7669	335	Presidente Kubitschek
7670	335	São Gonçalo do Rio Preto
7671	335	Senador Modestino Gonçalves
7672	335	Cachoeira de Pajeú
7673	335	Comercinho
7674	335	Itaobim
7675	335	Medina
7676	335	Pedra Azul
7677	335	Belo Horizonte
7678	335	(State Capital)
7679	335	Betim
7680	335	Brumadinho
7681	335	Caeté
7682	335	Confins
7683	335	Contagem
7684	335	Esmeraldas
7685	335	Ibirité
7686	335	Igarapé
7687	335	Juatuba
7688	335	Mário Campos
7689	335	Mateus Leme
7690	335	Nova Lima
7691	335	Pedro Leopoldo
7692	335	Raposos
7693	335	Ribeirão das Neves
7694	335	Rio Ácima
7695	335	Sabará
7696	335	São Joaquim de Bicas
7697	335	São José da Lapa
7698	335	Sarzedo
7699	335	Vespasiano
7700	335	Alvorada de Minas
7701	335	Conceição do Mato Dentro
7702	335	Congonhas do Norte
7703	335	Dom Joaquim
7704	335	Itambé do Mato Dentro
7705	335	Morro do Pilar
7706	335	Passabém
7707	335	Rio Vermelho
7708	335	Santo Antônio do Itambé
7709	335	Santo Antônio do Rio Abaixo
7710	335	São Sebastião do Rio Preto
7711	335	Serra Azul de Minas
7712	335	Serro
7713	335	Casa Grande
7714	335	Catas Altas da Noruega
7715	335	Congonhas
7716	335	Conselheiro Lafaiete
7717	335	Cristiano Otoni
7718	335	Desterro de Entre Rios
7719	335	Entre Rios de Minas
7720	335	Itaverava
7721	335	Queluzito
7722	335	Santana dos Montes
7723	335	São Brás do Suaçuí
7724	335	Alvinópolis
7725	335	Barão de Cocais
7726	335	Bela Vista de Minas
7727	335	Bom Jesus do Amparo
7728	335	Catas Altas
7729	335	Dionísio
7730	335	Ferros
7731	335	Itabira
7732	335	João Monlevade
7733	335	Nova Era
7734	335	Nova União
7735	335	Rio Piracicaba
7736	335	Santa Maria de Itabira
7737	335	São Domingos do Prata
7738	335	São Gonçalo do Rio Abaixo
7739	335	São José do Goiabal
7740	335	Taquaraçu de Minas
7741	335	Belo Vale
7742	335	Bonfim
7743	335	Crucilândia
7744	335	Itaguara
7745	335	Itatiaiuçu
7746	335	Jeceaba
7747	335	Moeda
7748	335	Piedade dos Gerais
7749	335	Rio Manso
7750	335	Diogo de Vasconcelos
7751	335	Itabirito
7752	335	Mariana
7753	335	Ouro Preto
7754	335	Florestal
7755	335	Onça de Pitangui
7756	335	Pará de Minas
7757	335	Pitangui
7758	335	São José da Varginha
7759	335	Araçaí
7760	335	Baldim
7761	335	Cachoeira da Prata
7762	335	Caetanópolis
7763	335	Capim Branco
7764	335	Cordisburgo
7765	335	Fortuna de Minas
7766	335	Funilândia
7767	335	Inhaúma
7768	335	Jaboticatubas
7769	335	Jequitibá
7770	335	Maravilhas
7771	335	Matozinhos
7772	335	Papagaios
7773	335	Paraopeba
7774	335	Pequi
7775	335	Prudente de Morais
7776	335	Santana de Pirapama
7777	335	Santana do Riacho
7778	335	Sete Lagoas
7779	335	Brasilândia de Minas
7780	335	Guarda-Mor
7781	335	João Pinheiro
7782	335	Lagamar
7783	335	Lagoa Grande
7784	335	Paracatu
7785	335	Presidente Olegário
7786	335	São Gonçalo do Abaeté
7787	335	Varjão de Minas
7788	335	Vazante
7789	335	Arinos
7790	335	Bonfinópolis de Minas
7791	335	Buritis
7792	335	Cabeceira Grande
7793	335	Dom Bosco
7794	335	Natalândia
7795	335	Unaí
7796	335	Uruana de Minas
7797	335	Bocaiúva
7798	335	Engenheiro Navarro
7799	335	Francisco Dumont
7800	335	Guaraciama
7801	335	Olhos-d'Água
7802	335	Botumirim
7803	335	Cristália
7804	335	Grão Mogol
7805	335	Itacambira
7806	335	Josenópolis
7807	335	Padre Carvalho
7808	335	Catuti
7809	335	Espinosa
7810	335	Gameleiras
7811	335	Jaíba
7812	335	Janaúba
7813	335	Mamonas
7814	335	Mato Verde
7815	335	Monte Azul
7816	335	Nova Porteirinha
7817	335	Pai Pedro
7818	335	Porteirinha
7819	335	Riacho dos Machados
7820	335	Serranópolis de Minas
7821	335	Bonito de Minas
7822	335	Chapada Gaúcha
7823	335	Cônego Marinho
7824	335	Icaraí de Minas
7825	335	Itacarambi
7826	335	Januária
7827	335	Juvenília
7828	335	Manga
7829	335	Matias Cardoso
7830	335	Miravânia
7831	335	Montalvânia
7832	335	Pedras de Maria da Cruz
7833	335	Pintópolis
7834	335	São Francisco
7835	335	São João das Missões
7836	335	Urucuia
7837	335	Brasília de Minas
7838	335	Campo Azul
7839	335	Capitão Enéas
7840	335	Claro dos Poções
7841	335	Coração de Jesus
7842	335	Francisco Sá
7843	335	Glaucilândia
7844	335	Ibiracatu
7845	335	Japonvar
7846	335	Juramento
7847	335	Lontra
7848	335	Luislândia
7849	335	Mirabela
7850	335	Montes Claros
7851	335	Patis
7852	335	Ponto Chique
7853	335	São João da Lagoa
7854	335	São João da Ponte
7855	335	São João do Pacuí
7856	335	Ubaí
7857	335	Varzelândia
7858	335	Verdelândia
7859	335	Buritizeiro
7860	335	Ibiaí
7861	335	Jequitaí
7862	335	Lagoa dos Patos
7863	335	Lassance
7864	335	Pirapora
7865	335	Riachinho
7866	335	Santa Fé de Minas
7867	335	São Romão
7868	335	Várzea da Palma
7869	335	Águas Vermelhas
7870	335	Berizal
7871	335	Curral de Dentro
7872	335	Divisa Alegre
7873	335	Fruta de Leite
7874	335	Indaiabira
7875	335	Montezuma
7876	335	Ninheira
7877	335	Novorizonte
7878	335	Rio Pardo de Minas
7879	335	Rubelita
7880	335	Salinas
7881	335	Santa Cruz de Salinas
7882	335	Santo Antônio do Retiro
7883	335	Taiobeiras
7884	335	Vargem Grande do Rio Pardo
7885	335	Aguanil
7886	335	Campo Belo
7887	335	Cana Verde
7888	335	Cristais
7889	335	Perdões
7890	335	Santana do Jacaré
7891	335	Carmo do Cajuru
7892	335	Cláudio
7893	335	Conceição do Pará
7894	335	Divinópolis
7895	335	Igaratinga
7896	335	Itaúna
7897	335	Nova Serrana
7898	335	Perdigão
7899	335	Santo Antônio do Monte
7900	335	São Gonçalo do Pará
7901	335	São Sebastião do Oeste
7902	335	Arcos
7903	335	Camacho
7904	335	Córrego Fundo
7905	335	Formiga
7906	335	Itapecerica
7907	335	Pains
7908	335	Pedra do Indaiá
7909	335	Pimenta
7910	335	Bom Sucesso
7911	335	Carmo da Mata
7912	335	Carmópolis de Minas
7913	335	Ibituruna
7914	335	Oliveira
7915	335	Passa Tempo
7916	335	Piracema
7917	335	Santo Antônio do Amparo
7918	335	São Francisco de Paula
7919	335	Bambuí
7920	335	Córrego Danta
7921	335	Doresópolis
7922	335	Iguatama
7923	335	Medeiros
7924	335	Piumhi
7925	335	São Roque de Minas
7926	335	Tapiraí
7927	335	Vargem Bonita
7928	335	Alfenas
7929	335	Alterosa
7930	335	Areado
7931	335	Carmo do Rio Claro
7932	335	Carvalhópolis
7933	335	Conceição da Aparecida
7934	335	Divisa Nova
7935	335	Fama
7936	335	Machado
7937	335	Paraguaçu
7938	335	Poço Fundo
7939	335	Serrania
7940	335	Aiuruoca
7941	335	Andrelândia
7942	335	Arantina
7943	335	Bocaina de Minas
7944	335	Bom Jardim de Minas
7945	335	Carvalhos
7946	335	Cruzília
7947	335	Liberdade
7948	335	Minduri
7949	335	Passa-Vinte
7950	335	São Vicente de Minas
7951	335	Seritinga
7952	335	Serranos
7953	335	Brasópolis
7954	335	Consolação
7955	335	Cristina
7956	335	Delfim Moreira
7957	335	Dom Viçoso
7958	335	Itajubá
7959	335	Maria da Fé
7960	335	Marmelópolis
7961	335	Paraisópolis
7962	335	Piranguçu
7963	335	Piranguinho
7964	335	Virgínia
7965	335	Wenceslau Braz
7966	335	Alpinópolis
7967	335	Bom Jesus da Penha
7968	335	Capetinga
7969	335	Capitólio
7970	335	Cássia
7971	335	Claraval
7972	335	Delfinópolis
7973	335	Fortaleza de Minas
7974	335	Ibiraci
7975	335	Itaú de Minas
7976	335	Passos
7977	335	Pratápolis
7978	335	São João Batista do Glória
7979	335	São José da Barra
7980	335	Albertina
7981	335	Andradas
7982	335	Bandeira do Sul
7983	335	Botelhos
7984	335	Caldas
7985	335	Ibitiúra de Minas
7986	335	Inconfidentes
7987	335	Jacutinga
7988	335	Monte Sião
7989	335	Ouro Fino
7990	335	Poços de Caldas
7991	335	Santa Rita de Caldas
7992	335	Bom Repouso
7993	335	Borda da Mata
7994	335	Bueno Brandão
7995	335	Camanducaia
7996	335	Cambuí
7997	335	Congonhal
7998	335	Córrego do Bom Jesus
7999	335	Espírito Santo do Dourado
8000	335	Estiva
8001	335	Extrema
8002	335	Gonçalves
8003	335	Ipuiúna
8004	335	Itapeva
8005	335	Munhoz
8006	335	Pouso Alegre
8007	335	Sapucaí-Mirim
8008	335	Senador Amaral
8009	335	Senador José Bento
8010	335	Tocos do Moji
8011	335	Toledo
8012	335	Cachoeira de Minas
8013	335	Careaçu
8014	335	Conceição das Pedras
8015	335	Conceição dos Ouros
8016	335	Cordislândia
8017	335	Heliodora
8018	335	Natércia
8019	335	Pedralva
8020	335	Santa Rita do Sapucaí
8021	335	São Gonçalo do Sapucaí
8022	335	São João da Mata
8023	335	São José do Alegre
8024	335	São Sebastião da Bela Vista
8025	335	Silvianópolis
8026	335	Turvolândia
8027	335	Alagoa
8028	335	Baependi
8029	335	Cambuquira
8030	335	Carmo de Minas
8031	335	Caxambu
8032	335	Conceição do Rio Verde
8033	335	Itamonte
8034	335	Itanhandu
8035	335	Jesuânia
8036	335	Lambari
8037	335	Olímpio Noronha
8038	335	Passa Quatro
8039	335	Pouso Alto
8040	335	São Lourenço
8041	335	São Sebastião do Rio Verde
8042	335	Soledade de Minas
8043	335	Arceburgo
8044	335	Cabo Verde
8045	335	Guaranesia
8046	335	Guaxupé
8047	335	Itamogi
8048	335	Jacuí
8049	335	Juruaia
8050	335	Monte Belo
8051	335	Monte Santo de Minas
8052	335	Muzambinho
8053	335	Nova Resende
8054	335	São Pedro da União
8055	335	São Sebastião do Paraíso
8056	335	São Tomás de Aquino
8057	335	Campanha
8058	335	Campo do Meio
8059	335	Campos Gerais
8060	335	Carmo da Cachoeira
8061	335	Coqueiral
8062	335	Elói Mendes
8063	335	Guapé
8064	335	Ilicínea
8065	335	Monsenhor Paulo
8066	335	Santana da Vargem
8067	335	São Bento Abade
8068	335	São Thomé das Letras
8069	335	Três Corações
8070	335	Três Pontas
8071	335	Varginha
8072	335	Araxá
8073	335	Campos Altos
8074	335	Ibiá
8075	335	Nova Ponte
8076	335	Pedrinópolis
8077	335	Perdizes
8078	335	Pratinha
8079	335	Sacramento
8080	335	Santa Juliana
8081	335	Tapira
8082	335	Campina Verde
8083	335	Carneirinho
8084	335	Comendador Gomes
8085	335	Fronteira
8086	335	Frutal
8087	335	Itapagipe
8088	335	Iturama
8089	335	Limeira do Oeste
8090	335	Pirajuba
8091	335	Planura
8092	335	São Francisco de Sales
8093	335	União de Minas
8094	335	Capinópolis
8095	335	Gurinhatã
8096	335	Ipiaçu
8097	335	Ituiutaba
8098	335	Santa Vitória
8099	335	Arapuá
8100	335	Carmo do Paranaíba
8101	335	Guimarânia
8102	335	Lagoa Formosa
8103	335	Matutina
8104	335	Patos de Minas
8105	335	Rio Paranaíba
8106	335	Santa Rosa da Serra
8107	335	Major Porto
8108	335	São Gotardo
8109	335	Tiros
8110	335	Abadia dos Dourados
8111	335	Coromandel
8112	335	Cruzeiro da Fortaleza
8113	335	Douradoquara
8114	335	Estrela do Sul
8115	335	Grupiara
8116	335	Iraí de Minas
8117	335	Monte Carmelo
8118	335	Patrocínio
8119	335	Romaria
8120	335	Serra do Salitre
8121	335	Água Comprida
8122	335	Campo Florido
8123	335	Conceição das Alagoas
8124	335	Conquista
8125	335	Delta
8126	335	Uberaba
8127	335	Veríssimo
8128	335	Araguari
8129	335	Araporã
8130	335	Cascalho Rico
8131	335	Centralina
8132	335	Indianópolis
8133	335	Monte Alegre de Minas
8134	335	Prata
8135	335	Tupaciguara
8136	335	Uberlândia
8137	335	Águas Formosas
8138	335	Bertópolis
8139	335	Carlos Chagas
8140	335	Crisólita
8141	335	Fronteira dos Vales
8142	335	Machacalis
8143	335	Nanuque
8144	335	Santa Helena de Minas
8145	335	Serra dos Aimorés
8146	335	Umburatiba
8147	335	Ataléia
8148	335	Catuji
8149	335	Franciscópolis
8150	335	Frei Gaspar
8151	335	Itaipé
8152	335	Ladainha
8153	335	Malacacheta
8154	335	Novo Oriente de Minas
8155	335	Ouro Verde de Minas
8156	335	Pavão
8157	335	Poté
8158	335	Setubinha
8159	335	Teófilo Otoni
8160	335	Aimorés
8161	335	Alvarenga
8162	335	Conceição de Ipanema
8163	335	Conselheiro Pena
8164	335	Cuparaque
8165	335	Goiabeira
8166	335	Ipanema
8167	335	Itueta
8168	335	Mutum
8169	335	Pocrane
8170	335	Resplendor
8171	335	Santa Rita do Itueto
8172	335	Taparuba
8173	335	Bom Jesus do Galho
8174	335	Bugre
8175	335	Caratinga
8176	335	Córrego Novo
8177	335	Dom Cavati
8178	335	Entre Folhas
8179	335	Iapu
8180	335	Imbé de Minas
8181	335	Inhapim
8182	335	Ipaba
8183	335	Piedade de Caratinga
8184	335	Pingo-d'Água
8185	335	Santa Bárbara do Leste
8186	335	Santa Rita de Minas
8187	335	São Domingos das Dores
8188	335	São João do Oriente
8189	335	São Sebastião do Anta
8190	335	Tarumirim
8191	335	Ubaporanga
8192	335	Vargem Alegre
8193	335	Alpercata
8194	335	Campanário
8195	335	Capitão Andrade
8196	335	Coroaci
8197	335	Divino das Laranjeiras
8198	335	Engenheiro Caldas
8199	335	Fernandes Tourinho
8200	335	Frei Inocêncio
8201	335	Galiléia
8202	335	Governador Valadares
8203	335	Itambacuri
8204	335	Itanhomi
8205	335	Jampruca
8206	335	Marilac
8207	335	Mathias Lobato
8208	335	Nacip Raydan
8209	335	Nova Módica
8210	335	Pescador
8211	335	São Geraldo da Piedade
8212	335	São Geraldo do Baixio
8213	335	São José da Safira
8214	335	São José do Divino
8215	335	Sobrália
8216	335	Tumiritinga
8217	335	Virgolândia
8218	335	Braúnas
8219	335	Carmésia
8220	335	Coluna
8221	335	Divinolândia de Minas
8222	335	Dores de Guanhães
8223	335	Gonzaga
8224	335	Guanhães
8225	335	Materlândia
8226	335	Paulistas
8227	335	Sabinópolis
8228	335	Santa Efigênia de Minas
8229	335	São João Evangelista
8230	335	Sardoá
8231	335	Senhora do Porto
8232	335	Virginópolis
8233	335	Açucena
8234	335	Antônio Dias
8235	335	Belo Oriente
8236	335	Coronel Fabriciano
8237	335	Ipatinga
8238	335	Jaguaraçu
8239	335	Joanésia
8240	335	Marliéria
8241	335	Mesquita
8242	335	Naque
8243	335	Periquito
8244	335	Santana do Paraíso
8245	335	Timóteo
8246	335	Central de Minas
8247	335	Itabirinha de Mantena
8248	335	Mantena
8249	335	Mendes Pimentel
8250	335	Nova Belém
8251	335	São Félix de Minas
8252	335	São João do Manteninha
8253	335	Cantagalo
8254	335	Frei Lagonegro
8255	335	José Raydan
8256	335	Peçanha
8257	335	Santa Maria do Suaçuí
8258	335	São José do Jacuri
8259	335	São Pedro do Suaçuí
8260	335	São Sebastião do Maranhão
8261	335	Além Paraíba
8262	335	Argirita
8263	335	Cataguases
8264	335	Dona Eusébia
8265	335	Estrela Dalva
8266	335	Itamarati de Minas
8267	335	Laranjal
8268	335	Leopoldina
8269	335	Palma
8270	335	Pirapetinga
8271	335	Recreio
8272	335	Santana de Cataguases
8273	335	Santo Antônio do Aventureiro
8274	335	Volta Grande
8275	335	Aracitaba
8276	335	Belmiro Braga
8277	335	Bias Fortes
8278	335	Bicas
8279	335	Chácara
8280	335	Chiador
8281	335	Coronel Pacheco
8282	335	Descoberto
8283	335	Ewbank da Câmara
8284	335	Goianá
8285	335	Guarará
8286	335	Juiz de Fora
8287	335	Lima Duarte
8288	335	Mar de Espanha
8289	335	Maripá de Minas
8290	335	Matias Barbosa
8291	335	Olaria
8292	335	Oliveira Fortes
8293	335	Paiva
8294	335	Pedro Teixeira
8295	335	Pequeri
8296	335	Piau
8297	335	Rio Novo
8298	335	Rio Preto
8299	335	Rochedo de Minas
8300	335	Santa Bárbara do Monte Verde
8301	335	Santa Rita de Ibitipoca
8302	335	Santa Rita de Jacutinga
8303	335	Santana do Deserto
8304	335	Santos Dumont
8305	335	São João Nepomuceno
8306	335	Senador Cortes
8307	335	Simão Pereira
8308	335	Abre Campo
8309	335	Alto Caparaó
8310	335	Alto Jequitibá
8311	335	Caparaó
8312	335	Caputira
8313	335	Chalé
8314	335	Durandé
8315	335	Lajinha
8316	335	Luisburgo
8317	335	Manhuaçu
8318	335	Manhumirim
8319	335	Martins Soares
8320	335	Matipó
8321	335	Pedra Bonita
8322	335	Reduto
8323	335	Santa Margarida
8324	335	Santana do Manhuaçu
8325	335	São João do Manhuaçu
8326	335	São José do Mantimento
8327	335	Simonésia
8328	335	Antônio Prado de Minas
8329	335	Barão de Monte Alto
8330	335	Caiana
8331	335	Carangola
8332	335	Divino
8333	335	Espera Feliz
8334	335	Eugenópolis
8335	335	Faria Lemos
8336	335	Fervedouro
8337	335	Miradouro
8338	335	Miraí
8339	335	Muriaé
8340	335	Orizânia
8341	335	Patrocínio do Muriaé
8342	335	Pedra Dourada
8343	335	Rosário da Limeira
8344	335	São Francisco do Glória
8345	335	São Sebastião da Vargem Alegre
8346	335	Tombos
8347	335	Vieiras
8348	335	Acaiaca
8349	335	Barra Longa
8350	335	Dom Silvério
8351	335	Guaraciaba
8352	335	Jequeri
8353	335	Oratórios
8354	335	Piedade de Ponte Nova
8355	335	Ponte Nova
8356	335	Raul Soares
8357	335	Rio Casca
8358	335	Rio Doce
8359	335	Santa Cruz do Escalvado
8360	335	Santo Antônio do Grama
8361	335	São Pedro dos Ferros
8362	335	Sem-Peixe
8363	335	Sericita
8364	335	Urucânia
8365	335	Vermelho Novo
8366	335	Astolfo Dutra
8367	335	Divinésia
8368	335	Dores do Turvo
8369	335	Guarani
8370	335	Guidoval
8371	335	Guiricema
8372	335	Mercês
8373	335	Piraúba
8374	335	Rio Pomba
8375	335	Rodeiro
8376	335	São Geraldo
8377	335	Senador Firmino
8378	335	Silveirânia
8379	335	Tabuleiro
8380	335	Tocantins
8381	335	Ubá
8382	335	Visconde do Rio Branco
8383	335	Alto Rio Doce
8384	335	Amparo do Serra
8385	335	Araponga
8386	335	Brás Pires
8387	335	Cajuri
8388	335	Canaã
8389	335	Cipotânea
8390	335	Coímbra
8391	335	Ervália
8392	335	Lamim
8393	335	Paula Cândido
8394	335	Pedra do Anta
8395	335	Piranga
8396	335	Porto Firme
8397	335	Presidente Bernardes
8398	335	Rio Espera
8399	335	São Miguel do Anta
8400	335	Senhora de Oliveira
8401	335	Teixeiras
8402	336	Almeirim
8403	336	Porto de Moz
8404	336	Faro
8405	336	Juruti
8406	336	Óbidos
8407	336	Oriximiná
8408	336	Terra Santa
8409	336	Alenquer
8410	336	Belterra
8411	336	Curuá
8412	336	Mojuí dos Campos
8413	336	Monte Alegre
8414	336	Placas
8415	336	Prainha
8416	336	Santarém
8417	336	Cachoeira do Arari
8418	336	Chaves
8419	336	Muaná
8420	336	Ponta de Pedras
8421	336	Salvaterra
8422	336	Santa Cruz do Arari
8423	336	Soure
8424	336	Afuá
8425	336	Anajás
8426	336	Breves
8427	336	Curralinho
8428	336	São Sebastião da Boa Vista
8429	336	Bagre
8430	336	Gurupá
8431	336	Melgaço
8432	336	Portel
8433	336	Ananindeua
8434	336	Barcarena
8435	336	Belém (capital estatal)
8436	336	Benevides
8437	336	Marituba
8438	336	Santa Bárbara do Pará
8439	336	Bujaru
8440	336	Castanhal
8441	336	Inhangapi
8442	336	Santa Isabel do Pará
8443	336	Santo Antônio do Tauá
8444	336	Augusto Corrêa
8445	336	Bragança
8446	336	Capanema
8447	336	Igarapé-Açu
8448	336	Nova Timboteua
8449	336	Peixe-Boi
8450	336	Primavera
8451	336	Quatipuru
8452	336	Santa Maria do Pará
8453	336	Santarém Novo
8454	336	São Francisco do Pará
8455	336	Tracuateua
8456	336	Abaetetuba
8457	336	Baião
8458	336	Cametá
8459	336	Igarapé-Miri
8460	336	Limoeiro do Ajuru
8461	336	Mocajuba
8462	336	Oeiras do Pará
8463	336	Aurora do Pará
8464	336	Cachoeira do Piriá
8465	336	Capitão Poço
8466	336	Garrafão do Norte
8467	336	Ipixuna do Pará
8468	336	Irituia
8469	336	Mãe do Rio
8470	336	Nova Esperança do Piriá
8471	336	Ourém
8472	336	Santa Luzia do Pará
8473	336	São Domingos do Capim
8474	336	São Miguel do Guamá
8475	336	Viseu
8476	336	Colares
8477	336	Curuçá
8478	336	Magalhães Barata
8479	336	Maracanã
8480	336	Marapanim
8481	336	Salinópolis
8482	336	São Caetano de Odivelas
8483	336	São João da Ponta
8484	336	São João de Pirabas
8485	336	Terra Alta
8486	336	Vigia
8487	336	Acará
8488	336	Concórdia do Pará
8489	336	Moju
8490	336	Tailândia
8491	336	Tomé-Açu
8492	336	Conceição do Araguaia
8493	336	Floresta do Araguaia
8494	336	Santa Maria das Barreiras
8495	336	Santana do Araguaia
8496	336	Brejo Grande do Araguaia
8497	336	Marabá
8498	336	Palestina do Pará
8499	336	São Domingos do Araguaia
8500	336	São João do Araguaia
8501	336	Abel Figueiredo
8502	336	Bom Jesus do Tocantins
8503	336	Dom Eliseu
8504	336	Goianésia do Pará
8505	336	Paragominas
8506	336	Rondon do Pará
8507	336	Ulianópolis
8508	336	Água Azul do Norte
8509	336	Canaã dos Carajás
8510	336	Curionópolis
8511	336	Eldorado dos Carajás
8512	336	Parauapebas
8513	336	Pau-d'Arco
8514	336	Piçarra
8515	336	Rio Maria
8516	336	São Geraldo do Araguaia
8517	336	Sapucaia
8518	336	Xinguara
8519	336	Bannach
8520	336	Cumaru do Norte
8521	336	Ourilândia do Norte
8522	336	São Félix do Xingu
8523	336	Tucumã
8524	336	Breu Branco
8525	336	Itupiranga
8526	336	Jacundá
8527	336	Nova Ipixuna
8528	336	Novo Repartimento
8529	336	Tucuruí
8530	336	Altamira
8531	336	Anapu
8532	336	Brasil Novo
8533	336	Medicilândia
8534	336	Pacajá
8535	336	Senador José Porfírio
8536	336	Uruará
8537	336	Vitória do Xingu
8538	336	Aveiro
8539	336	Itaituba
8540	336	Jacareacanga
8541	336	Novo Progresso
8542	336	Rurópolis
8543	336	Trairão
8544	337	Alagoa Grande
8545	337	Alagoa Nova
8546	337	Areia
8547	337	Bananeiras
8548	337	Borborema
8549	337	Matinhas
8550	337	Pilões
8551	337	Serraria
8552	337	Boa Vista
8553	337	Campina Grande
8554	337	Fagundes
8555	337	Lagoa Seca
8556	337	Massaranduba
8557	337	Puxinanã
8558	337	Serra Redonda
8559	337	Algodão de Jandaíra
8560	337	Arara
8561	337	Barra de Santa Rosa
8562	337	Cuité
8563	337	Damião
8564	337	Nova Floresta
8565	337	Olivedos
8566	337	Pocinhos
8567	337	Remígio
8568	337	Soledade
8569	337	Sossêgo
8570	337	Araruna
8571	337	Cacimba de Dentro
8572	337	Campo de Santana
8573	337	Casserengue
8574	337	Dona Inês
8575	337	Solânea
8576	337	Areial
8577	337	Esperança
8578	337	Montadas
8579	337	São Sebastião de Lagoa de Roça
8580	337	Alagoinha
8581	337	Araçagi
8582	337	Caiçara
8583	337	Cuitegi
8584	337	Duas Estradas
8585	337	Guarabira
8586	337	Lagoa de Dentro
8587	337	Logradouro
8588	337	Pilõezinhos
8589	337	Pirpirituba
8590	337	Serra da Raiz
8591	337	Sertãozinho
8592	337	Caldas Brandão
8593	337	Gurinhém
8594	337	Ingá
8595	337	Itabaiana
8596	337	Itatuba
8597	337	Juarez Távora
8598	337	Mogeiro
8599	337	Riachão do Bacamarte
8600	337	Salgado de São Félix
8601	337	Aroeiras
8602	337	Gado Bravo
8603	337	Natuba
8604	337	Santa Cecília
8605	337	Umbuzeiro
8606	337	Amparo
8607	337	Assunção
8608	337	Camalaú
8609	337	Congo
8610	337	Coxixola
8611	337	Livramento
8612	337	Monteiro
8613	337	Ouro Velho
8614	337	Parari
8615	337	São João do Tigre
8616	337	São José dos Cordeiros
8617	337	São Sebastião do Umbuzeiro
8618	337	Serra Branca
8619	337	Sumé
8620	337	Zabelê
8621	337	Alcantil
8622	337	Barra de Santana
8623	337	Boqueirão
8624	337	Cabaceiras
8625	337	Caraúbas
8626	337	Caturité
8627	337	Gurjão
8628	337	Riacho de Santo Antônio
8629	337	Santo André
8630	337	São Domingos do Cariri
8631	337	São João do Cariri
8632	337	Junco do Seridó
8633	337	Salgadinho
8634	337	São José do Sabugi
8635	337	São Mamede
8636	337	Várzea
8637	337	Baraúna
8638	337	Cubati
8639	337	Frei Martinho
8640	337	Juazeirinho
8641	337	Nova Palmeira
8642	337	Pedra Lavrada
8643	337	Picuí
8644	337	Seridó
8645	337	Tenório
8646	337	Bayeux
8647	337	Cabedelo
8648	337	João Pessoa (capital estatal)
8649	337	Lucena
8650	337	Baía da Traição
8651	337	Capim
8652	337	Cuité de Mamanguape
8653	337	Curral de Cima
8654	337	Itapororoca
8655	337	Jacaraú
8656	337	Mamanguape
8657	337	Marcação
8658	337	Mataraca
8659	337	Pedro Régis
8660	337	Rio Tinto
8661	337	Alahandra
8662	337	Caaporã
8663	337	Pedras de Fogo
8664	337	Pitimbu
8665	337	Cruz do Espírito Santo
8666	337	Juripiranga
8667	337	Mari
8668	337	Riachão do Poço
8669	337	São José dos Ramos
8670	337	São Miguel de Taipu
8671	337	Sapé
8672	337	Sobrado
8673	337	Bernardino Batista
8674	337	Bom Jesus
8675	337	Bonito de Santa Fé
8676	337	Cachoeira dos Índios
8677	337	Cajazeiras
8678	337	Carrapateira
8679	337	Monte Horebe
8680	337	Poço Dantas
8681	337	Poço de José de Moura
8682	337	São João do Rio do Peixe
8683	337	São José de Piranhas
8684	337	Triunfo
8685	337	Uiraúna
8686	337	Belém do Brejo do Cruz
8687	337	Brejo do Cruz
8688	337	Brejo dos Santos
8689	337	Catolé do Rocha
8690	337	Jericó
8691	337	Lagoa
8692	337	Mato Grosso
8693	337	Riacho dos Cavalos
8694	337	São José do Brejo do Cruz
8695	337	Boa Ventura
8696	337	Conceição
8697	337	Curral Velho
8698	337	Diamante
8699	337	Ibiara
8700	337	Itaporanga
8701	337	Santana de Mangueira
8702	337	São José de Caiana
8703	337	Serra Grande
8704	337	Areia de Baraúnas
8705	337	Cacimba de Areia
8706	337	Mãe d'Água
8707	337	Passagem
8708	337	Patos
8709	337	Quixabá
8710	337	São José de Espinharas
8711	337	São José do Bonfim
8712	337	Aguiar
8713	337	Catingueira
8714	337	Coremas
8715	337	Emas
8716	337	Igaracy
8717	337	Olho d'Água
8718	337	Piancó
8719	337	Santana dos Garrotes
8720	337	Cacimbas
8721	337	Desterro
8722	337	Imaculada
8723	337	Juru
8724	337	Manaíra
8725	337	Maturéia
8726	337	Princesa Isabel
8727	337	São José de Princesa
8728	337	Tavares
8729	337	Teixeira
8730	337	Aparecida
8731	337	Cajazeirinhas
8732	337	Condado
8733	337	Lastro
8734	337	Malta
8735	337	Marizópolis
8736	337	Nazarezinho
8737	337	Paulista
8738	337	Pombal
8739	337	Santa Cruz
8740	337	São Bentinho
8741	337	São Domingos de Pombal
8742	337	São José da Lagoa Tapada
8743	337	Sousa
8744	337	Vieirópolis
8745	337	Vista Serrana
8746	338	Barbosa Ferraz
8747	338	Campo Mourão
8748	338	Corumbataí do Sul
8749	338	Engenheiro Beltrão
8750	338	Farol
8751	338	Fênix
8752	338	Iretama
8753	338	Luiziana
8754	338	Mamborê
8755	338	Peabiru
8756	338	Quinta do Sol
8757	338	Roncador
8758	338	Terra Boa
8759	338	Altamira do Paraná
8760	338	Campina da Lagoa
8761	338	Goioerê
8762	338	Janiópolis
8763	338	Juranda
8764	338	Moreira Sales
8765	338	Nova Cantu
8766	338	Quarto Centenário
8767	338	Rancho Alegre d'Oeste
8768	338	Ubiratã
8769	338	Arapoti
8770	338	Jaguariaíva
8771	338	Piraí do Sul
8772	338	Sengés
8773	338	Carambeí
8774	338	Castro
8775	338	Palmeira
8776	338	Ponta Grossa
8777	338	Imbaú
8778	338	Ortigueira
8779	338	Reserva
8780	338	Telêmaco Borba
8781	338	Tibagi
8782	338	Ventania
8783	338	Campina do Simão
8784	338	Candói
8785	338	Espigão Alto do Iguaçu
8786	338	Foz do Jordão
8787	338	Goioxim
8788	338	Guarapuava
8789	338	Inácio Martins
8790	338	Laranjeiras do Sul
8791	338	Marquinho
8792	338	Nova Laranjeiras
8793	338	Pinhão
8794	338	Porto Barreiro
8795	338	Quedas do Iguaçu
8796	338	Reserva do Iguaçu
8797	338	Rio Bonito do Iguaçu
8798	338	Turvo
8799	338	Virmond
8800	338	Clevelândia
8801	338	Coronel Domingos Soares
8802	338	Honório Serpa
8803	338	Mangueirinha
8804	338	Palmas
8805	338	Boa Ventura de São Roque
8806	338	Mato Rico
8807	338	Palmital
8808	338	Pitanga
8809	338	Santa Maria do Oeste
8810	338	Adrianópolis
8811	338	Cerro Azul
8812	338	Doutor Ulysses
8813	338	Almirante Tamandaré
8814	338	Araucária
8815	338	Balsa Nova
8816	338	Bocaiúva do Sul
8817	338	Campina Grande do Sul
8818	338	Campo Largo
8819	338	Campo Magro
8820	338	Colombo
8821	338	Contenda
8822	338	Curitiba (capital estatal)
8823	338	Fazenda Rio Grande
8824	338	Itaperuçu
8825	338	Mandirituba
8826	338	Pinhais
8827	338	Piraquara
8828	338	Quatro Barras
8829	338	Rio Branco do Sul
8830	338	São José dos Pinhais
8831	338	Tunas do Paraná
8832	338	Lapa
8833	338	Porto Amazonas
8834	338	Antonina
8835	338	Guaraqueçaba
8836	338	Guaratuba
8837	338	Matinhos
8838	338	Morretes
8839	338	Paranaguá
8840	338	Pontal do Paraná
8841	338	Agudos do Sul
8842	338	Campo do Tenente
8843	338	Piên
8844	338	Quitandinha
8845	338	Tijucas do Sul
8846	338	Cianorte
8847	338	Cidade Gaúcha
8848	338	Guaporema
8849	338	Rondon
8850	338	São Manoel do Paraná
8851	338	São Tomé
8852	338	Tapejara
8853	338	Tuneiras do Oeste
8854	338	Alto Paraná
8855	338	Amaporã
8856	338	Diamante do Norte
8857	338	Guairaçá
8858	338	Inajá
8859	338	Itaúna do Sul
8860	338	Jardim Olinda
8861	338	Loanda
8862	338	Marilena
8863	338	Nova Aliança do Ivaí
8864	338	Nova Londrina
8865	338	Paraíso do Norte
8866	338	Paranacity
8867	338	Paranapoema
8868	338	Paranavaí
8869	338	Planaltina do Paraná
8870	338	Porto Rico
8871	338	Querência do Norte
8872	338	Santa Cruz do Monte Castelo
8873	338	Santa Isabel do Ivaí
8874	338	Santa Mônica
8875	338	Santo Antônio do Caiuá
8876	338	São Carlos do Ivaí
8877	338	São João do Caiuá
8878	338	São Pedro do Paraná
8879	338	Tamboara
8880	338	Terra Rica
8881	338	Alto Paraíso
8882	338	Alto Piquiri
8883	338	Altônia
8884	338	Brasilândia do Sul
8885	338	Cafezal do Sul
8886	338	Cruzeiro do Oeste
8887	338	Esperança Nova
8888	338	Francisco Alves
8889	338	Icaraíma
8890	338	Iporã
8891	338	Ivaté
8892	338	Maria Helena
8893	338	Mariluz
8894	338	Perobal
8895	338	Pérola
8896	338	São Jorge do Patrocínio
8897	338	Umuarama
8898	338	Xambrê
8899	338	Apucarana
8900	338	Arapongas
8901	338	Califórnia
8902	338	Cambira
8903	338	Jandaia do Sul
8904	338	Marilândia do Sul
8905	338	Mauá da Serra
8906	338	Novo Itacolomi
8907	338	Sabáudia
8908	338	Ângulo
8909	338	Astorga
8910	338	Cafeara
8911	338	Centenário do Sul
8912	338	Colorado
8913	338	Flórida
8914	338	Guaraci
8915	338	Iguaraçu
8916	338	Itaguajé
8917	338	Jaguapitã
8918	338	Lobato
8919	338	Lupionópolis
8920	338	Mandaguaçu
8921	338	Munhoz de Melo
8922	338	Nossa Senhora das Graças
8923	338	Nova Esperança
8924	338	Presidente Castelo Branco
8925	338	Santa Fé
8926	338	Santo Inácio
8927	338	Uniflor
8928	338	Borrazópolis
8929	338	Cruzmaltina
8930	338	Faxinal
8931	338	Kaloré
8932	338	Marumbi
8933	338	Rio Bom
8934	338	Doutor Camargo
8935	338	Floraí
8936	338	Floresta
8937	338	Ivatuba
8938	338	Ourizona
8939	338	São Jorge do Ivaí
8940	338	Arapuã
8941	338	Ariranha do Ivaí
8942	338	Cândido de Abreu
8943	338	Godoy Moreira
8944	338	Grandes Rios
8945	338	Ivaiporã
8946	338	Jardim Alegre
8947	338	Lidianópolis
8948	338	Lunardelli
8949	338	Manoel Ribas
8950	338	Nova Tebas
8951	338	Rio Branco do Ivaí
8952	338	Rosário do Ivaí
8953	338	São João do Ivaí
8954	338	São Pedro do Ivaí
8955	338	Cambé
8956	338	Ibiporã
8957	338	Londrina
8958	338	Pitangueiras
8959	338	Rolândia
8960	338	Tamarana
8961	338	Mandaguari
8962	338	Marialva
8963	338	Maringá
8964	338	Paiçandu
8965	338	Sarandi
8966	338	Alvorada do Sul
8967	338	Bela Vista do Paraíso
8968	338	Florestópolis
8969	338	Miraselva
8970	338	Porecatu
8971	338	Prado Ferreira
8972	338	Primeiro de Maio
8973	338	Sertanópolis
8974	338	Assaí
8975	338	Jataizinho
8976	338	Nova Santa Bárbara
8977	338	Rancho Alegre
8978	338	Santa Cecília do Pavão
8979	338	São Jerônimo da Serra
8980	338	São Sebastião da Amoreira
8981	338	Uraí
8982	338	Abatiá
8983	338	Andirá
8984	338	Congonhinhas
8985	338	Cornélio Procópio
8986	338	Itambaracá
8987	338	Leópolis
8988	338	Nova América da Colina
8989	338	Ribeirão do Pinhal
8990	338	Santa Amélia
8991	338	Santa Mariana
8992	338	Santo Antônio do Paraíso
8993	338	Sertaneja
8994	338	Conselheiro Mairinck
8995	338	Curiúva
8996	338	Figueira
8997	338	Ibaiti
8998	338	Jaboti
8999	338	Japira
9000	338	Pinhalão
9001	338	Sapopema
9002	338	Barra do Jacaré
9003	338	Cambará
9004	338	Jacarezinho
9005	338	Jundiaí do Sul
9006	338	Ribeirão Claro
9007	338	Santo Antônio da Platina
9008	338	Carlópolis
9009	338	Guapirama
9010	338	Joaquim Távora
9011	338	Quatiguá
9012	338	Salto do Itararé
9013	338	Santana do Itararé
9014	338	São José da Boa Vista
9015	338	Siqueira Campos
9016	338	Tomazina
9017	338	Anahy
9018	338	Boa Vista da Aparecida
9019	338	Braganey
9020	338	Cafelândia
9021	338	Campo Bonito
9022	338	Capitão Leônidas Marques
9023	338	Catanduvas
9024	338	Corbélia
9025	338	Diamante do Sul
9026	338	Guaraniaçu
9027	338	Ibema
9028	338	Lindoeste
9029	338	Santa Lúcia
9030	338	Santa Tereza do Oeste
9031	338	Três Barras do Paraná
9032	338	Céu Azul
9033	338	Foz do Iguaçu
9034	338	Itaipulândia
9035	338	Matelândia
9036	338	Medianeira
9037	338	Missal
9038	338	Ramilândia
9039	338	Santa Terezinha de Itaipu
9040	338	São Miguel do Iguaçu
9041	338	Serranópolis do Iguaçu
9042	338	Vera Cruz do Oeste
9043	338	Assis Chateaubriand
9044	338	Diamante d'Oeste
9045	338	Entre Rios do Oeste
9046	338	Formosa do Oeste
9047	338	Guaíra
9048	338	Iracema do Oeste
9049	338	Jesuítas
9050	338	Marechal Cândido Rondon
9051	338	Maripá
9052	338	Mercedes
9053	338	Nova Santa Rosa
9054	338	Ouro Verde do Oeste
9055	338	Palotina
9056	338	Pato Bragado
9057	338	Quatro Pontes
9058	338	São José das Palmeiras
9059	338	São Pedro do Iguaçu
9060	338	Terra Roxa
9061	338	Tupãssi
9062	338	Irati
9063	338	Mallet
9064	338	Rebouças
9065	338	Rio Azul
9066	338	Fernandes Pinheiro
9067	338	Guamiranga
9068	338	Imbituva
9069	338	Ipiranga
9070	338	Ivaí
9071	338	Prudentópolis
9072	338	Teixeira Soares
9073	338	Antônio Olinto
9074	338	São João do Triunfo
9075	338	São Mateus do Sul
9076	338	Bituruna
9077	338	Cruz Machado
9078	338	Paula Freitas
9079	338	Paulo Frontin
9080	338	Porto Vitória
9081	338	União da Vitória
9082	338	Ampére
9083	338	Bela Vista da Caroba
9084	338	Pérola d'Oeste
9085	338	Pranchita
9086	338	Realeza
9087	338	Santa Izabel do Oeste
9088	338	Barracão
9089	338	Boa Esperança do Iguaçu
9090	338	Bom Jesus do Sul
9091	338	Cruzeiro do Iguaçu
9092	338	Dois Vizinhos
9093	338	Enéas Marques
9094	338	Flor da Serra do Sul
9095	338	Francisco Beltrão
9096	338	Manfrinópolis
9097	338	Marmeleiro
9098	338	Nova Esperança do Sudoeste
9099	338	Nova Prata do Iguaçu
9100	338	Pinhal de São Bento
9101	338	Renascença
9102	338	Salgado Filho
9103	338	Salto do Lontra
9104	338	Santo Antônio do Sudoeste
9105	338	São Jorge d'Oeste
9106	338	Verê
9107	338	Bom Sucesso do Sul
9108	338	Chopinzinho
9109	338	Coronel Vivida
9110	338	Itapejara d'Oeste
9111	338	Mariópolis
9112	338	Pato Branco
9113	338	São João
9114	338	Saudade do Iguaçu
9115	338	Sulina
9116	338	Vitorino
9117	339	Abreu e Lima
9118	339	Afogados da Ingazeira
9119	339	Afrânio
9120	339	Agrestina
9121	339	Água Preta
9122	339	Águas Belas
9123	339	Aliança
9124	339	Altinho
9125	339	Amaraji
9126	339	Angelim
9127	339	Araripina
9128	339	Arcoverde
9129	339	Barra de Guabiraba
9130	339	Barreiros
9131	339	Belém de Maria
9132	339	Belém de São Francisco
9133	339	Belo Jardim
9134	339	Betânia
9135	339	Bezerros
9136	339	Bodocó
9137	339	Bom Conselho
9138	339	Brejão
9139	339	Brejinho
9140	339	Brejo da Madre de Deus
9141	339	Buenos Aires
9142	339	Buíque
9143	339	Cabo de Santo Agostinho
9144	339	Cabrobó
9145	339	Cachoeirinha
9146	339	Caetés
9147	339	Calçado
9148	339	Calumbi
9149	339	Camaragibe
9150	339	Camocim de São Félix
9151	339	Camutanga
9152	339	Canhotinho
9153	339	Capoeiras
9154	339	Carnaíba
9155	339	Carnaubeira da Penha
9156	339	Carpina
9157	339	Caruaru
9158	339	Casinhas
9159	339	Catende
9160	339	Chã de Alegria
9161	339	Chã Grande
9162	339	Correntes
9163	339	Cortês
9164	339	Cumaru
9165	339	Cupira
9166	339	Custódia
9167	339	Dormentes
9168	339	Escada
9169	339	Exu
9170	339	Feira Nova
9171	339	Fernando de Noronha
9172	339	Ferreiros
9173	339	Flores
9174	339	Frei Miguelinho
9175	339	Gameleira
9176	339	Garanhuns
9177	339	Glória do Goitá
9178	339	Goiana
9179	339	Granito
9180	339	Gravatá
9181	339	Iati
9182	339	Ibimirim
9183	339	Ibirajuba
9184	339	Igarassu
9185	339	Iguaraci
9186	339	Ingazeira
9187	339	Ipojuca
9188	339	Ipubi
9189	339	Itacuruba
9190	339	Itaíba
9191	339	Ilha de Itamaracá
9192	339	Itapetim
9193	339	Itapissuma
9194	339	Itaquitinga
9195	339	Jaboatão dos Guararapes
9196	339	Jaqueira
9197	339	Jataúba
9198	339	João Alfredo
9199	339	Joaquim Nabuco
9200	339	Jucati
9201	339	Jupi
9202	339	Jurema
9203	339	Lagoa do Carro
9204	339	Lagoa de Itaenga
9205	339	Lagoa do Ouro
9206	339	Lagoa dos Gatos
9207	339	Lajedo
9208	339	Limoeiro
9209	339	Macaparana
9210	339	Machados
9211	339	Manari
9212	339	Maraial
9213	339	Mirandiba
9214	339	Moreilândia
9215	339	Moreno
9216	339	Nazaré da Mata
9217	339	Olinda
9218	339	Orobó
9219	339	Orocó
9220	339	Ouricuri
9221	339	Palmares
9222	339	Palmeirina
9223	339	Panelas
9224	339	Paranatama
9225	339	Parnamirim
9226	339	Passira
9227	339	Paudalho
9228	339	Pedra
9229	339	Pesqueira
9230	339	Petrolândia
9231	339	Petrolina
9232	339	Poção
9233	339	Pombos
9234	339	Quipapá
9235	339	Quixaba
9236	339	Recife
9237	339	Riacho das Almas
9238	339	Ribeirão
9239	339	Rio Formoso
9240	339	Sairé
9241	339	Salgueiro
9242	339	Saloá
9243	339	Sanharó
9244	339	Santa Cruz da Baixa Verde
9245	339	Santa Cruz do Capibaribe
9246	339	Santa Filomena
9247	339	Santa Maria da Boa Vista
9248	339	Santa Maria do Cambucá
9249	339	São Benedito do Sul
9250	339	São Bento do Una
9251	339	São Caetano
9252	339	São Joaquim do Monte
9253	339	São José da Coroa Grande
9254	339	São José do Belmonte
9255	339	São José do Egito
9256	339	São Lourenço da Mata
9257	339	São Vicente Férrer
9258	339	Serra Talhada
9259	339	Serrita
9260	339	Sertânia
9261	339	Sirinhaém
9262	339	Solidão
9263	339	Surubim
9264	339	Tabira
9265	339	Tacaimbó
9266	339	Tacaratu
9267	339	Tamandaré
9268	339	Taquaritinga do Norte
9269	339	Terezinha
9270	339	Timbaúba
9271	339	Toritama
9272	339	Tracunhaém
9273	339	Tupanatinga
9274	339	Tuparetama
9275	339	Venturosa
9276	339	Verdejante
9277	339	Vertente do Lério
9278	339	Vertentes
9279	339	Vicência
9280	339	Vitória de Santo Antão
9281	339	Xexéu
9282	340	Alto Longá
9283	340	Assunção do Piauí
9284	340	Boqueirão do Piauí
9285	340	Buriti dos Montes
9286	340	Campo Maior
9287	340	Capitão de Campos
9288	340	Castelo do Piauí
9289	340	Cocal de Telha
9290	340	Domingos Mourão
9291	340	Jatobá do Piauí
9292	340	Juazeiro do Piauí
9293	340	Lagoa de São Francisco
9294	340	Milton Brandão
9295	340	Nossa Senhora de Nazaré
9296	340	Pau d'Arco do Piauí
9297	340	Pedro II
9298	340	São João da Serra
9299	340	São Miguel do Tapuio
9300	340	Sigefredo Pacheco
9301	340	Agricolândia
9302	340	Amarante
9303	340	Angical do Piauí
9304	340	Arraial
9305	340	Barro Duro
9306	340	Francisco Ayres
9307	340	Hugo Napoleão
9308	340	Jardim do Mulato
9309	340	Lagoinha do Piauí
9310	340	Olho d'Água do Piauí
9311	340	Palmeirais
9312	340	Passagem Franca do Piauí
9313	340	Regeneração
9314	340	Santo Antônio dos Milagres
9315	340	São Gonçalo do Piauí
9316	340	São Pedro do Piauí
9317	340	Altos
9318	340	Beneditinos
9319	340	Coivaras
9320	340	Curralinhos
9321	340	Demerval Lobão
9322	340	José de Freitas
9323	340	Lagoa Alegre
9324	340	Lagoa do Piauí
9325	340	Miguel Leão
9326	340	Monsenhor Gil
9327	340	Teresina (capital del estado)
9328	340	União
9329	340	Aroazes
9330	340	Barra d'Alcântara
9331	340	Elesbão Veloso
9332	340	Francinópolis
9333	340	Inhuma
9334	340	Lagoa do Sítio
9335	340	Novo Oriente do Piauí
9336	340	Pimenteiras
9337	340	Prata do Piauí
9338	340	Santa Cruz dos Milagres
9339	340	São Félix do Piauí
9340	340	São Miguel da Baixa Grande
9341	340	Valença do Piauí
9342	340	Barras
9343	340	Boa Hora
9344	340	Brasileira
9345	340	Cabeceiras do Piauí
9346	340	Campo Largo do Piauí
9347	340	Esperantina
9348	340	Joaquim Pires
9349	340	Joca Marques
9350	340	Luzilândia
9351	340	Madeiro
9352	340	Matias Olímpio
9353	340	Miguel Alves
9354	340	Morro do Chapéu do Piauí
9355	340	Nossa Senhora dos Remédios
9356	340	Piripiri
9357	340	Porto
9358	340	São João do Arraial
9359	340	Bom Princípio do Piauí
9360	340	Buriti dos Lopes
9361	340	Cajueiro da Praia
9362	340	Caraúbas do Piauí
9363	340	Caxingó
9364	340	Cocal
9365	340	Cocal dos Alves
9366	340	Ilha Grande
9367	340	Luís Correia
9368	340	Murici dos Portelas
9369	340	Parnaíba
9370	340	Piracuruca
9371	340	São João da Fronteira
9372	340	Acauã
9373	340	Bela Vista do Piauí
9374	340	Belém do Piauí
9375	340	Betânia do Piauí
9376	340	Caldeirão Grande do Piauí
9377	340	Campinas do Piauí
9378	340	Campo Alegre do Fidalgo
9379	340	Campo Grande do Piauí
9380	340	Capitão Gervásio Oliveira
9381	340	Caridade do Piauí
9382	340	Conceição do Canindé
9383	340	Curral Novo do Piauí
9384	340	Floresta do Piauí
9385	340	Francisco Macêdo
9386	340	Fronteiras
9387	340	Isaías Coelho
9388	340	Itainópolis
9389	340	Jacobina do Piauí
9390	340	Jaicós
9391	340	João Costa
9392	340	Lagoa do Barro do Piauí
9393	340	Marcolândia
9394	340	Massapê do Piauí
9395	340	Nova Santa Rita
9396	340	Padre Marcos
9397	340	Paes Landim
9398	340	Patos do Piauí
9399	340	Paulistana
9400	340	Pedro Laurentino
9401	340	Queimada Nova
9402	340	Ribeira do Piauí
9403	340	Santo Inácio do Piauí
9404	340	São Francisco de Assis do Piauí
9405	340	São João do Piauí
9406	340	Simões
9407	340	Simplício Mendes
9408	340	Socorro do Piauí
9409	340	Vera Mendes
9410	340	Vila Nova do Piauí
9411	340	Aroeiras do Itaim
9412	340	Bocaina
9413	340	Cajazeiras do Piauí
9414	340	Colônia do Piauí
9415	340	Dom Expedito Lopes
9416	340	Geminiano
9417	340	Ipiranga do Piauí
9418	340	Oeiras
9419	340	Paquetá
9420	340	Picos
9421	340	Santa Cruz do Piauí
9422	340	Santa Rosa do Piauí
9423	340	Santana do Piauí
9424	340	São João da Canabrava
9425	340	São João da Varjota
9426	340	São José do Piauí
9427	340	São Luís do Piauí
9428	340	Sussuapara
9429	340	Tanque do Piauí
9430	340	Wall Ferraz
9431	340	Alagoinha do Piauí
9432	340	Alegrete do Piauí
9433	340	Francisco Santos
9434	340	Monsenhor Hipólito
9435	340	Pio IX
9436	340	Santo Antônio de Lisboa
9437	340	São Julião
9438	340	Alvorada do Gurguéia
9439	340	Barreiras do Piauí
9440	340	Cristino Castro
9441	340	Currais
9442	340	Gilbués
9443	340	Monte Alegre do Piauí
9444	340	Palmeira do Piauí
9445	340	Redenção do Gurguéia
9446	340	Santa Luz
9447	340	São Gonçalo do Gurguéia
9448	340	Baixa Grande do Ribeiro
9449	340	Ribeiro Gonçalves
9450	340	Uruçuí
9451	340	Antônio Almeida
9452	340	Bertolínia
9453	340	Colônia do Gurguéia
9454	340	Eliseu Martins
9455	340	Landri Sales
9456	340	Manoel Emídio
9457	340	Marcos Parente
9458	340	Porto Alegre do Piauí
9459	340	Sebastião Leal
9460	340	Avelino Lopes
9461	340	Corrente
9462	340	Cristalândia do Piauí
9463	340	Curimatá
9464	340	Júlio Borges
9465	340	Morro Cabeça no Tempo
9466	340	Parnaguá
9467	340	Riacho Frio
9468	340	Sebastião Barros
9469	340	Canavieira
9470	340	Flores do Piauí
9471	340	Floriano
9472	340	Guadalupe
9473	340	Itaueira
9474	340	Jerumenha
9475	340	Nazaré do Piauí
9476	340	Pavussu
9477	340	Rio Grande do Piauí
9478	340	São Francisco do Piauí
9479	340	São José do Peixe
9480	340	São Miguel do Fidalgo
9481	340	Anísio de Abreu
9482	340	Bonfim do Piauí
9483	340	Brejo do Piauí
9484	340	Canto do Buriti
9485	340	Coronel José Dias
9486	340	Dirceu Arcoverde
9487	340	Dom Inocêncio
9488	340	Fartura do Piauí
9489	340	Guaribas
9490	340	Pajeú do Piauí
9491	340	São Braz do Piauí
9492	340	São Lourenço do Piauí
9493	340	São Raimundo Nonato
9494	340	Tamboril do Piauí
9495	340	Várzea Branca
9496	341	Casimiro de Abreu
9497	341	Rio das Ostras
9498	341	Silva Jardim
9499	341	Araruama
9500	341	Armação dos Búzios
9501	341	Arraial do Cabo
9502	341	Cabo Frío
9503	341	Iguaba Grande
9504	341	São Pedro da Aldeia
9505	341	Saquarema
9506	341	Carmo
9507	341	Cordeiro
9508	341	Macuco
9509	341	Duas Barras
9510	341	Nova Friburgo
9511	341	Sumidouro
9512	341	Santa Maria Madalena
9513	341	São Sebastião do Alto
9514	341	Trajano de Morais
9515	341	Areal
9516	341	Comendador Levy Gasparian
9517	341	Paraíba do Sul
9518	341	Três Rios
9519	341	Itaguaí
9520	341	Mangaratiba
9521	341	Seropédica
9522	341	Cachoeiras de Macacu
9523	341	Rio Bonito
9524	341	Belford Roxo
9525	341	Duque de Caxias
9526	341	Guapimirim
9527	341	Itaboraí
9528	341	Japeri
9529	341	Magé
9530	341	Maricá
9531	341	Nilópolis
9532	341	Niterói
9533	341	Nova Iguaçu
9534	341	Queimados
9535	341	Río de Janeiro (capital estatal)
9536	341	São Gonçalo
9537	341	São João de Meriti
9538	341	Tanguá
9539	341	Petrópolis
9540	341	São José do Vale do Rio Preto
9541	341	Teresópolis
9542	341	Engenheiro Paulo de Frontin
9543	341	Mendes
9544	341	Miguel Pereira
9545	341	Paracambi
9546	341	Paty do Alferes
9547	341	Vassouras
9548	341	Bom Jesus do Itabapoana
9549	341	Italva
9550	341	Itaperuna
9551	341	Laje do Muriaé
9552	341	Natividade
9553	341	Porciúncula
9554	341	Varre-Sai
9555	341	Aperibé
9556	341	Cambuci
9557	341	Itaocara
9558	341	Miracema
9559	341	Santo Antônio de Pádua
9560	341	São José de Ubá
9561	341	Campos dos Goytacazes
9562	341	Cardoso Moreira
9563	341	São Fidélis
9564	341	São Francisco de Itabapoana
9565	341	São João da Barra
9566	341	Carapebus
9567	341	Conceição de Macabu
9568	341	Macaé
9569	341	Quissamã
9570	341	Angra dos Reis
9571	341	Parati
9572	341	Barra do Piraí
9573	341	Rio das Flores
9574	341	Barra Mansa
9575	341	Itatiaia
9576	341	Pinheiral
9577	341	Piraí
9578	341	Porto Real
9579	341	Quatis
9580	341	Resende
9581	341	Río Claro
9582	341	Volta Redonda
9583	342	Acari
9584	342	Afonso Bezerra
9585	342	Água Nova
9586	342	Alexandria
9587	342	Almino Afonso
9588	342	Alto do Rodrigues
9589	342	Angicos
9590	342	Antônio Martins
9591	342	Apodi
9592	342	Areia Branca
9593	342	Arês
9594	342	Assu
9595	342	Baía Formosa
9596	342	Barcelona
9597	342	Bento Fernandes
9598	342	Boa Saúde
9599	342	Bodó
9600	342	Caiçara do Norte
9601	342	Caiçara do Rio do Vento
9602	342	Caicó
9603	342	Campo Redondo
9604	342	Canguaretama
9605	342	Carnaúba dos Dantas
9606	342	Carnaubais
9607	342	Ceará-Mirim
9608	342	Cerro Corá
9609	342	Coronel Ezequiel
9610	342	Coronel João Pessoa
9611	342	Cruzeta
9612	342	Currais Novos
9613	342	Doutor Severiano
9614	342	Encanto
9615	342	Equador
9616	342	Espírito Santo
9617	342	Extremoz
9618	342	Felipe Guerra
9619	342	Fernando Pedroza
9620	342	Florânia
9621	342	Francisco Dantas
9622	342	Frutuoso Gomes
9623	342	Galinhos
9624	342	Goianinha
9625	342	Governador Dix-Sept Rosado
9626	342	Grossos
9627	342	Guamaré
9628	342	Ielmo Marinho
9629	342	Ipanguaçu
9630	342	Ipueira
9631	342	Itaú
9632	342	Jaçanã
9633	342	Janduís
9634	342	Japi
9635	342	Jardim de Angicos
9636	342	Jardim de Piranhas
9637	342	Jardim do Seridó
9638	342	João Câmara
9639	342	João Dias
9640	342	José da Penha
9641	342	Jucurutu
9642	342	Lagoa d'Anta
9643	342	Lagoa de Pedras
9644	342	Lagoa de Velhos
9645	342	Lagoa Nova
9646	342	Lagoa Salgada
9647	342	Lajes
9648	342	Lajes Pintadas
9649	342	Lucrécia
9650	342	Luís Gomes
9651	342	Macaíba
9652	342	Macau
9653	342	Major Sales
9654	342	Marcelino Vieira
9655	342	Martins
9656	342	Maxaranguape
9657	342	Messias Targino
9658	342	Montanhas
9659	342	Monte das Gameleiras
9660	342	Mossoró
9661	342	Natal
9662	342	Nísia Floresta
9663	342	Nova Cruz
9664	342	Olho-d'Água do Borges
9665	342	Paraná
9666	342	Paraú
9667	342	Parazinho
9668	342	Parelhas
9669	342	Passa e Fica
9670	342	Patu
9671	342	Pau dos Ferros
9672	342	Pedra Grande
9673	342	Pedro Avelino
9674	342	Pedro Velho
9675	342	Pendências
9676	342	Poço Branco
9677	342	Portalegre
9678	342	Porto do Mangue
9679	342	Pureza
9680	342	Rafael Fernandes
9681	342	Rafael Godeiro
9682	342	Riacho da Cruz
9683	342	Riachuelo
9684	342	Rio do Fogo
9685	342	Rodolfo Fernandes
9686	342	Santana do Matos
9687	342	Santana do Seridó
9688	342	Santo Antônio
9689	342	São Bento do Norte
9690	342	São Bento do Trairi
9691	342	São Fernando
9692	342	São Francisco do Oeste
9693	342	São João do Sabugi
9694	342	São José de Mipibu
9695	342	São José do Campestre
9696	342	São José do Seridó
9697	342	São Miguel
9698	342	São Miguel do Gostoso
9699	342	São Paulo do Potengi
9700	342	São Pedro
9701	342	São Rafael
9702	342	São Vicente
9703	342	Senador Elói de Souza
9704	342	Senador Georgino Avelino
9705	342	Serra Caiada
9706	342	Serra de São Bento
9707	342	Serra do Mel
9708	342	Serra Negra do Norte
9709	342	Serrinha dos Pintos
9710	342	Severiano Melo
9711	342	Taboleiro Grande
9712	342	Taipu
9713	342	Tangará
9714	342	Tenente Ananias
9715	342	Tenente Laurentino Cruz
9716	342	Tibau
9717	342	Tibau do Sul
9718	342	Timbaúba dos Batistas
9719	342	Touros
9720	342	Triunfo Potiguar
9721	342	Umarizal
9722	342	Upanema
9723	342	Venha-Ver
9724	342	Vila Flor
9725	343	Agudo
9726	343	Dona Francisca
9727	343	Faxinal do Soturno
9728	343	Formigueiro
9729	343	Ivorá
9730	343	Nova Palma
9731	343	Restinga Seca
9732	343	São João do Polêsine
9733	343	Silveira Martins
9734	343	Cacequi
9735	343	Dilermando de Aguiar
9736	343	Itaara
9737	343	Jaguari
9738	343	Mata
9739	343	Nova Esperança do Sul
9740	343	São Martinho da Serra
9741	343	São Pedro do Sul
9742	343	São Sepé
9743	343	São Vicente do Sul
9744	343	Toropi
9745	343	Vila Nova do Sul
9746	343	Capão do Cipó
9747	343	Itacurubi
9748	343	Jari
9749	343	Júlio de Castilhos
9750	343	Pinhal Grande
9751	343	Quevedos
9752	343	Santiago
9753	343	Tupanciretã
9754	343	Unistalda
9755	343	Cachoeira do Sul
9756	343	Cerro Branco
9757	343	Novo Cabrais
9758	343	Pantano Grande
9759	343	Paraíso do Sul
9760	343	Passo do Sobrado
9761	343	Rio Pardo
9762	343	Arroio do Meio
9763	343	Bom Retiro do Sul
9764	343	Boqueirão do Leão
9765	343	Canudos do Vale
9766	343	Capitão
9767	343	Coqueiro Baixo
9768	343	Doutor Ricardo
9769	343	Encantado
9770	343	Estrela
9771	343	Fazenda Vilanova
9772	343	Forquetinha
9773	343	Imigrante
9774	343	Lajeado
9775	343	Marques de Souza
9776	343	Muçum
9777	343	Nova Bréscia
9778	343	Paverama
9779	343	Pouso Novo
9780	343	Progresso
9781	343	Relvado
9782	343	Roca Sales
9783	343	Santa Clara do Sul
9784	343	Sério
9785	343	Tabaí
9786	343	Taquari
9787	343	Teutônia
9788	343	Travesseiro
9789	343	Vespasiano Correa
9790	343	Westfália
9791	343	Arroio do Tigre
9792	343	Candelária
9793	343	Estrela Velha
9794	343	Gramado Xavier
9795	343	Herveiras
9796	343	Ibarama
9797	343	Lagoa Bonita do Sul
9798	343	Mato Leitão
9799	343	Passa Sete
9800	343	Santa Cruz do Sul
9801	343	Segredo
9802	343	Sinimbu
9803	343	Vale do Sol
9804	343	Venâncio Aires
9805	343	Arambaré
9806	343	Barra do Ribeiro
9807	343	Camaquã
9808	343	Cerro Grande do Sul
9809	343	Chuvisca
9810	343	Dom Feliciano
9811	343	Sentinela do Sul
9812	343	Tapes
9813	343	Canela
9814	343	Dois Irmãos
9815	343	Gramado
9816	343	Igrejinha
9817	343	Ivoti
9818	343	Lindolfo Collor
9819	343	Morro Reuter
9820	343	Nova Petrópolis
9821	343	Picada Café
9822	343	Presidente Lucena
9823	343	Riozinho
9824	343	Rolante
9825	343	Santa Maria do Herval
9826	343	Taquara
9827	343	Três Coroas
9828	343	Alto Feliz
9829	343	Barão
9830	343	Bom Princípio
9831	343	Brochier
9832	343	Capela de Santana
9833	343	Feliz
9834	343	Harmonia
9835	343	Linha Nova
9836	343	Maratá
9837	343	Montenegro
9838	343	Pareci Novo
9839	343	Poço das Antas
9840	343	Portão
9841	343	Salvador do Sul
9842	343	São José do Hortêncio
9843	343	São José do Sul
9844	343	São Pedro da Serra
9845	343	São Sebastião do Caí
9846	343	São Vendelino
9847	343	Tupandi
9848	343	Vale Real
9849	343	Arroio do Sal
9850	343	Balneário Pinhal
9851	343	Capão da Canoa
9852	343	Capivari do Sul
9853	343	Caraá
9854	343	Cidreira
9855	343	Dom Pedro de Alcântara
9856	343	Imbé
9857	343	Itati
9858	343	Mampituba
9859	343	Maquiné
9860	343	Morrinhos do Sul
9861	343	Mostardas
9862	343	Osório
9863	343	Palmares do Sul
9864	343	Santo Antônio da Patrulha
9865	343	Terra de Areia
9866	343	Torres
9867	343	Tramandaí
9868	343	Três Cachoeiras
9869	343	Três Forquilhas
9870	343	Xangri-lá
9871	343	Alvorada
9872	343	Araricá
9873	343	Campo Bom
9874	343	Canoas
9875	343	Eldorado do Sul
9876	343	Estância Velha
9877	343	Esteio
9878	343	Glorinha
9879	343	Gravataí
9880	343	Guaíba
9881	343	Mariana Pimentel
9882	343	Nova Hartz
9883	343	Novo Hamburgo
9884	343	Parobé
9885	343	Porto Alegre (capital estatal)
9886	343	São Leopoldo
9887	343	Sapiranga
9888	343	Sapucaia do Sul
9889	343	Sertão Santana
9890	343	Viamão
9891	343	Arroio dos Ratos
9892	343	Barão do Triunfo
9893	343	Butiá
9894	343	Charqueadas
9895	343	General Câmara
9896	343	Minas do Leão
9897	343	São Jerônimo
9898	343	Vale Verde
9899	343	Antônio Prado
9900	343	Bento Gonçalves
9901	343	Boa Vista do Sul
9902	343	Carlos Barbosa
9903	343	Caxias do Sul
9904	343	Coronel Pilar
9905	343	Cotiporã
9906	343	Fagundes Varela
9907	343	Farroupilha
9908	343	Flores da Cunha
9909	343	Garibaldi
9910	343	Monte Belo do Sul
9911	343	Nova Pádua
9912	343	Nova Roma do Sul
9913	343	Santa Tereza
9914	343	São Marcos
9915	343	Veranópolis
9916	343	Vila Flores
9917	343	André da Rocha
9918	343	Anta Gorda
9919	343	Arvorezinha
9920	343	Dois Lajeados
9921	343	Guabiju
9922	343	Guaporé
9923	343	Ilópolis
9924	343	Itapuca
9925	343	Montauri
9926	343	Nova Alvorada
9927	343	Nova Araçá
9928	343	Nova Bassano
9929	343	Nova Prata
9930	343	Paraí
9931	343	Protásio Alves
9932	343	Putinga
9933	343	São Jorge
9934	343	São Valentim do Sul
9935	343	Serafina Corrêa
9936	343	União da Serra
9937	343	Vista Alegre do Prata
9938	343	Cambará do Sul
9939	343	Campestre da Serra
9940	343	Capão Bonito do Sul
9941	343	Esmeralda
9942	343	Ipê
9943	343	Jaquirana
9944	343	Lagoa Vermelha
9945	343	Monte Alegre dos Campos
9946	343	Muitos Capões
9947	343	Pinhal da Serra
9948	343	São José dos Ausentes
9949	343	Vacaria
9950	343	Almirante Tamandaré do Sul
9951	343	Barra Funda
9952	343	Boa Vista das Missões
9953	343	Carazinho
9954	343	Cerro Grande
9955	343	Chapada
9956	343	Coqueiros do Sul
9957	343	Jaboticaba
9958	343	Lajeado do Bugre
9959	343	Nova Boa Vista
9960	343	Novo Barreiro
9961	343	Palmeira das Missões
9962	343	Pinhal
9963	343	Sagrada Família
9964	343	Santo Antônio do Planalto
9965	343	São José das Missões
9966	343	São Pedro das Missões
9967	343	Caibaté
9968	343	Campina das Missões
9969	343	Cerro Largo
9970	343	Guarani das Missões
9971	343	Mato Queimado
9972	343	Porto Xavier
9973	343	Roque Gonzales
9974	343	Salvador das Missões
9975	343	São Paulo das Missões
9976	343	São Pedro do Butiá
9977	343	Sete de Setembro
9978	343	Alto Alegre
9979	343	Boa Vista do Cadeado
9980	343	Boa Vista do Incra
9981	343	Campos Borges
9982	343	Cruz Alta
9983	343	Espumoso
9984	343	Fortaleza dos Valos
9985	343	Ibirubá
9986	343	Jacuizinho
9987	343	Jóia
9988	343	Quinze de Novembro
9989	343	Saldanha Marinho
9990	343	Salto do Jacuí
9991	343	Santa Bárbara do Sul
9992	343	Aratiba
9993	343	Áurea
9994	343	Barão de Cotegipe
9995	343	Barra do Rio Azul
9996	343	Benjamin Constant do Sul
9997	343	Campinas do Sul
9998	343	Carlos Gomes
9999	343	Centenário
10000	343	Cruzaltense
10001	343	Entre Rios do Sul
10002	343	Erebango
10003	343	Erechim
10004	343	Erval Grande
10005	343	Estação
10006	343	Faxinalzinho
10007	343	Floriano Peixoto
10008	343	Gaurama
10009	343	Getúlio Vargas
10010	343	Ipiranga do Sul
10011	343	Itatiba do Sul
10012	343	Marcelino Ramos
10013	343	Mariano Moro
10014	343	Paulo Bento
10015	343	Ponte Preta
10016	343	Quatro Irmãos
10017	343	São Valentim
10018	343	Severiano de Almeida
10019	343	Três Arroios
10020	343	Viadutos
10021	343	Alpestre
10022	343	Ametista do Sul
10023	343	Constantina
10024	343	Cristal do Sul
10025	343	Dois Irmãos das Missões
10026	343	Engenho Velho
10027	343	Erval Seco
10028	343	Frederico Westphalen
10029	343	Gramado dos Loureiros
10030	343	Iraí
10031	343	Liberato Salzano
10032	343	Nonoai
10033	343	Novo Tiradentes
10034	343	Novo Xingu
10035	343	Palmitinho
10036	343	Pinheirinho do Vale
10037	343	Rio dos Índios
10038	343	Rodeio Bonito
10039	343	Rondinha
10040	343	Seberi
10041	343	Taquaruçu do Sul
10042	343	Três Palmeiras
10043	343	Trindade do Sul
10044	343	Vicente Dutra
10045	343	Vista Alegre
10046	343	Ajuricaba
10047	343	Alegría
10048	343	Augusto Pestana
10049	343	Bozano
10050	343	Chiapetta
10051	343	Condor
10052	343	Coronel Barros
10053	343	Coronel Bicaco
10054	343	Ijuí
10055	343	Inhacorá
10056	343	Nova Ramada
10057	343	Panambi
10058	343	Pejuçara
10059	343	Santo Augusto
10060	343	São Valério do Sul
10061	343	Lagoa dos Três Cantos
10062	343	Não-Me-Toque
10063	343	Selbach
10064	343	Tapera
10065	343	Tio Hugo
10066	343	Victor Graeff
10067	343	Água Santa
10068	343	Camargo
10069	343	Casca
10070	343	Caseiros
10071	343	Charrúa
10072	343	Ciríaco
10073	343	Coxilha
10074	343	David Canabarro
10075	343	Ernestina
10076	343	Gentil
10077	343	Ibiraiaras
10078	343	Marau
10079	343	Mato Castelhano
10080	343	Muliterno
10081	343	Nicolau Vergueiro
10082	343	Passo Fundo
10083	343	Pontão
10084	343	Ronda Alta
10085	343	Santa Cecília do Sul
10086	343	Santo Antônio do Palma
10087	343	São Domingos do Sul
10088	343	Sertão
10089	343	Vanini
10090	343	Vila Lângaro
10091	343	Vila Maria
10092	343	Cacique Doble
10093	343	Ibiaçá
10094	343	Machadinho
10095	343	Maximiliano de Almeida
10096	343	Paim Filho
10097	343	Sananduva
10098	343	Santo Expedito do Sul
10099	343	São João da Urtiga
10100	343	São José do Ouro
10101	343	Tupanci do Sul
10102	343	Alecrim
10103	343	Cândido Godói
10104	343	Novo Machado
10105	343	Porto Lucena
10106	343	Porto Mauá
10107	343	Porto Vera Cruz
10108	343	Santa Rosa
10109	343	Santo Cristo
10110	343	São José do Inhacorá
10111	343	Três de Maio
10112	343	Tucunduva
10113	343	Tuparendi
10114	343	Bossoroca
10115	343	Catuípe
10116	343	Dezesseis de Novembro
10117	343	Entre-Ijuís
10118	343	Eugênio de Castro
10119	343	Giruá
10120	343	Pirapó
10121	343	Rolador
10122	343	Santo Ângelo
10123	343	Santo Antônio das Missões
10124	343	São Luiz Gonzaga
10125	343	São Miguel das Missões
10126	343	São Nicolau
10127	343	Senador Salgado Filho
10128	343	Ubiretama
10129	343	Vitória das Missões
10130	343	Barros Cassal
10131	343	Fontoura Xavier
10132	343	Ibirapuitã
10133	343	Lagoão
10134	343	Mormaço
10135	343	São José do Herval
10136	343	Tunas
10137	343	Barra do Guarita
10138	343	Boa Vista do Buricá
10139	343	Bom Progresso
10140	343	Braga
10141	343	Campo Novo
10142	343	Crissiumal
10143	343	Derrubadas
10144	343	Doutor Maurício Cardoso
10145	343	Esperança do Sul
10146	343	Horizontina
10147	343	Miraguaí
10148	343	Nova Candelária
10149	343	Redentora
10150	343	São Martinho
10151	343	Sede Nova
10152	343	Tenente Portela
10153	343	Tiradentes do Sul
10154	343	Três Passos
10155	343	Vista Gaúcha
10156	343	Arroio Grande
10157	343	Herval
10158	343	Jaguarão
10159	343	Chuí
10160	343	Rio Grande
10161	343	Santa Vitória do Palmar
10162	343	São José do Norte
10163	343	Arroio do Padre
10164	343	Canguçu
10165	343	Capão do Leão
10166	343	Cerrito
10167	343	Cristal
10168	343	Morro Redondo
10169	343	Pedro Osório
10170	343	Pelotas
10171	343	São Lourenço do Sul
10172	343	Turuçu
10173	343	Amaral Ferrador
10174	343	Caçapava do Sul
10175	343	Candiota
10176	343	Encruzilhada do Sul
10177	343	Pedras Altas
10178	343	Pinheiro Machado
10179	343	Piratini
10180	343	Santana da Boa Vista
10181	343	Rosário do Sul
10182	343	Santa Margarida do Sul
10183	343	Santana do Livramento
10184	343	Aceguá
10185	343	Bagé
10186	343	Dom Pedrito
10187	343	Hulha Negra
10188	343	Lavras do Sul
10189	343	Alegrete
10190	343	Barra do Quaraí
10191	343	Garruchos
10192	343	Itaqui
10193	343	Maçambara
10194	343	Manoel Viana
10195	343	São Borja
10196	343	São Francisco de Assis
10197	343	Uruguaiana
10198	343	Quaraí
10199	344	Alta Floresta d'Oeste
10200	344	Alto Alegre de los Parecis
10201	344	Alvorada d'Oeste
10202	344	Ariquemes
10203	344	Cabixi
10204	344	Cacaulândia
10205	344	Cacoal
10206	344	Campo Nuevo de Rondonia
10207	344	Candeias del Jamari
10208	344	Castanheiras
10209	344	Cerejeiras
10210	344	Chupinguaia
10211	344	Colorado del Oeste
10212	344	Corumbiara
10213	344	Costa Marques
10214	344	Cujubim
10215	344	Espigão d'Oeste
10216	344	Extrema de Rondonia
10217	344	Gobernador Jorge Teixeira
10218	344	Guajará-Mirim
10219	344	Itapuã del Oeste
10220	344	Jaru
10221	344	Ji-Paraná
10222	344	Machadinho d'Oeste
10223	344	Ministro Andreazza
10224	344	Mirante de la Sierra
10225	344	Monte Negro
10226	344	Nueva Brasilândia d'Oeste
10227	344	Nueva Mamoré
10228	344	Nueva Unión
10229	344	Novo Horizonte del Oeste
10230	344	Oro Negro del Oeste
10231	344	Parecis
10232	344	Pimenta Bueno
10233	344	Pimenteiras del Oeste
10234	344	Puerto Velho
10235	344	Primavera de Rondonia
10236	344	Río Crespo
10237	344	Rolim de Moura
10238	344	Santa Luzia d'Oeste
10239	344	Son Felipe d'Oeste
10240	344	São Francisco del Guaporé
10241	344	São Miguel del Guaporé
10242	344	Seringueiras
10243	344	Teixeirópolis
10244	344	Theobroma
10245	344	Urupá
10246	344	Valle del Anari
10247	344	Valle del Paraíso
10248	344	Vilhena
10249	345	Amajari
10250	345	Boa Vista (capital estatal)
10251	345	Pacaraima
10252	345	Cantá
10253	345	Normandia
10254	345	Uiramutã
10255	345	Caracaraí
10256	345	Mucajaí
10257	345	Caroebe
10258	345	Rorainópolis
10259	345	São João da Baliza
10260	346	Biguaçu
10261	346	Florianópolis (capital estatal)
10262	346	Governador Celso Ramos
10263	346	Palhoça
10264	346	Paulo Lopes
10265	346	Santo Amaro da Imperatriz
10266	346	São José
10267	346	São Pedro de Alcântara
10268	346	Águas Mornas
10269	346	Alfredo Wagner
10270	346	Anitápolis
10271	346	Rancho Queimado
10272	346	São Bonifácio
10273	346	Angelina
10274	346	Canelinha
10275	346	Leoberto Leal
10276	346	Major Gercino
10277	346	Nova Trento
10278	346	Tijucas
10279	346	Bela Vista do Toldo
10280	346	Canoinhas
10281	346	Irineópolis
10282	346	Itaiópolis
10283	346	Mafra
10284	346	Major Vieira
10285	346	Monte Castelo
10286	346	Papanduva
10287	346	Porto União
10288	346	Timbó Grande
10289	346	Três Barras
10290	346	Araquari (antes, Paraty)
10291	346	Balneário Barra do Sul
10292	346	Corupá
10293	346	Garuva
10294	346	Guaramirim
10295	346	Itapoá
10296	346	Jaraguá do Sul
10297	346	Joinville
10298	346	São Francisco do Sul
10299	346	Schroeder
10300	346	Rio Negrinho
10301	346	São Bento do Sul
10302	346	Águas de Chapecó
10303	346	Águas Frias
10304	346	Bom Jesus do Oeste
10305	346	Caibi
10306	346	Campo Erê
10307	346	Caxambu do Sul
10308	346	Chapecó
10309	346	Cordilheira Alta
10310	346	Coronel Freitas
10311	346	Cunha Porã
10312	346	Cunhataí
10313	346	Flor do Sertão
10314	346	Formosa do Sul
10315	346	Guatambú
10316	346	Iraceminha
10317	346	Jardinópolis
10318	346	Modelo
10319	346	Nova Erechim
10320	346	Nova Itaberaba
10321	346	Palmitos
10322	346	Pinhalzinho
10323	346	Planalto Alegre
10324	346	Quilombo
10325	346	Saltinho
10326	346	Santa Terezinha do Progresso
10327	346	Santiago do Sul
10328	346	São Bernardino
10329	346	São Carlos
10330	346	São Lourenço do Oeste
10331	346	São Miguel da Boa Vista
10332	346	Saudades
10333	346	Serra Alta
10334	346	Sul Brasil
10335	346	Tigrinhos
10336	346	União do Oeste
10337	346	Alto Bela Vista
10338	346	Arabutã
10339	346	Arvoredo
10340	346	Concórdia
10341	346	Ipira
10342	346	Ipumirim
10343	346	Irani
10344	346	Itá
10345	346	Lindóia do Sul
10346	346	Paial
10347	346	Peritiba
10348	346	Piratuba
10349	346	Presidente Castelo Branco (antes, Dois Irmãos)
10350	346	Seara
10351	346	Xavantina
10352	346	Água Doce
10353	346	Arroio Trinta
10354	346	Caçador
10355	346	Calmon
10356	346	Capinzal
10357	346	Erval Velho
10358	346	Fraiburgo
10359	346	Herval d’Oeste
10360	346	Ibiam
10361	346	Ibicaré
10362	346	Iomerê
10363	346	Jaborá
10364	346	Joaçaba (antes, Cruzeiro)
10365	346	Lacerdópolis
10366	346	Lebon Régis
10367	346	Luzerna
10368	346	Macieira
10369	346	Matos Costa
10370	346	Ouro
10371	346	Pinheiro Preto
10372	346	Rio das Antas
10373	346	Salto Veloso
10374	346	Treze Tílias
10375	346	Videira
10376	346	Bandeirante
10377	346	Barra Bonita
10378	346	Descanso
10379	346	Dionísio Cerqueira
10380	346	Guarujá do Sul
10381	346	Iporã do Oeste
10382	346	Mondaí
10383	346	Palma Sola
10384	346	Paraíso
10385	346	Princesa
10386	346	Riqueza
10387	346	Romelândia
10388	346	São João do Oeste
10389	346	São José do Cedro
10390	346	São Miguel do Oeste
10391	346	Tunápolis
10392	346	Abelardo Luz
10393	346	Coronel Martins
10394	346	Faxinal dos Guedes
10395	346	Galvão
10396	346	Ipuaçu
10397	346	Jupiá
10398	346	Lajeado Grande
10399	346	Marema
10400	346	Ouro Verde
10401	346	Passos Maia
10402	346	Ponte Serrada
10403	346	Vargeão
10404	346	Xanxerê
10405	346	Xaxim
10406	346	Anita Garibaldi
10407	346	Bocaina do Sul
10408	346	Bom Jardim da Serra
10409	346	Bom Retiro
10410	346	Campo Belo do Sul
10411	346	Capão Alto
10412	346	Celso Ramos
10413	346	Cerro Negro
10414	346	Correia Pinto
10415	346	Lages
10416	346	Otacílio Costa
10417	346	Painel
10418	346	Rio Rufino
10419	346	São Joaquim
10420	346	São José do Cerrito
10421	346	Urubici
10422	346	Urupema
10423	346	Abdon Batista
10424	346	Brunópolis
10425	346	Campos Novos
10426	346	Curitibanos
10427	346	Frei Rogério
10428	346	Monte Carlo
10429	346	Ponte Alta
10430	346	Ponte Alta do Norte
10431	346	São Cristóvão do Sul
10432	346	Vargem
10433	346	Zortéa
10434	346	Araranguá
10435	346	Balneário Arroio do Silva
10436	346	Balneário Gaivota
10437	346	Ermo
10438	346	Jacinto Machado
10439	346	Maracajá
10440	346	Meleiro
10441	346	Morro Grande
10442	346	Passo de Torres
10443	346	Praia Grande
10444	346	Santa Rosa do Sul
10445	346	São João do Sul
10446	346	Sombrio
10447	346	Timbé do Sul
10448	346	Balneário Rincão (será mplantado en enero de 2013)
10449	346	Cocal do Sul
10450	346	Criciúma
10451	346	Forquilhinha
10452	346	Içara
10453	346	Lauro Müller
10454	346	Morro da Fumaça
10455	346	Siderópolis
10456	346	Treviso
10457	346	Urussanga
10458	346	Armazém
10459	346	Braço do Norte
10460	346	Capivari de Baixo
10461	346	Garopaba
10462	346	Grão Pará
10463	346	Gravatal
10464	346	Imaruí
10465	346	Imbituba (antes, Henrique Lage)
10466	346	Jaguaruna
10467	346	Laguna
10468	346	Orleans
10469	346	Pedras Grandes
10470	346	Pescaria Brava será mplantado en enero de 2013)
10471	346	Rio Fortuna
10472	346	Sangão
10473	346	Santa Rosa de Lima
10474	346	São Ludgero (antes, São Ludigéro)
10475	346	Treze de Maio
10476	346	Tubarão
10477	346	Apiúna
10478	346	Ascurra
10479	346	Benedito Novo
10480	346	Blumenau
10481	346	Botuverá
10482	346	Brusque
10483	346	Doutor Pedrinho
10484	346	Gaspar
10485	346	Guabiruba
10486	346	Indaial
10487	346	Luiz Alves
10488	346	Pomerode
10489	346	Rio dos Cedros
10490	346	Rodeio
10491	346	Timbó
10492	346	Balneário Camboriú
10493	346	Barra Velha
10494	346	Bombinhas
10495	346	Camboriú
10496	346	Ilhota
10497	346	Itajaí
10498	346	Itapema
10499	346	Navegantes
10500	346	Penha
10501	346	Balneário Piçarras
10502	346	Porto Belo
10503	346	São João do Itaperiú
10504	346	Agrolândia
10505	346	Atalanta
10506	346	Chapadão do Lageado
10507	346	Imbuia
10508	346	Ituporanga
10509	346	Vidal Ramos
10510	346	Agronômica
10511	346	Braço do Trombudo
10512	346	Dona Emma
10513	346	Ibirama
10514	346	José Boiteux
10515	346	Laurentino
10516	346	Lontras
10517	346	Mirim Doce
10518	346	Pouso Redondo
10519	346	Presidente Getúlio
10520	346	Presidente Nereu
10521	346	Rio do Campo
10522	346	Rio do Oeste
10523	346	Rio do Sul
10524	346	Salete
10525	346	Taió
10526	346	Trombudo Central
10527	346	Vitor Meireles
10528	346	Witmarsum
10529	347	Amparo de São Francisco
10530	347	Aquidabã
10531	347	Aracaju
10532	347	Arauá
10533	347	Barra dos Coqueiros
10534	347	Boquim
10535	347	Brejo Grande
10536	347	Campo do Brito
10537	347	Canhoba
10538	347	Canindé de São Francisco
10539	347	Carira
10540	347	Carmópolis
10541	347	Cedro de São João
10542	347	Cristinápolis
10543	347	Cumbe
10544	347	Divina Pastora
10545	347	Estância
10546	347	Frei Paulo
10547	347	Gararu
10548	347	General Maynard
10549	347	Graccho Cardoso
10550	347	Ilha das Flores
10551	347	Indiaroba
10552	347	Itabaianinha
10553	347	Itabi
10554	347	Itaporanga d'Ajuda
10555	347	Japaratuba
10556	347	Japoatã
10557	347	Lagarto
10558	347	Laranjeiras
10559	347	Macambira
10560	347	Malhada dos Bois
10561	347	Malhador
10562	347	Maruim
10563	347	Moita Bonita
10564	347	Monte Alegre de Sergipe
10565	347	Muribeca
10566	347	Neópolis
10567	347	Nossa Senhora Aparecida
10568	347	Nossa Senhora da Glória
10569	347	Nossa Senhora das Dores
10570	347	Nossa Senhora de Lourdes
10571	347	Nossa Senhora do Socorro
10572	347	Pedra Mole
10573	347	Pedrinhas
10574	347	Pirambu
10575	347	Poço Redondo
10576	347	Poço Verde
10577	347	Porto da Folha
10578	347	Propriá
10579	347	Riachão do Dantas
10580	347	Ribeirópolis
10581	347	Rosário do Catete
10582	347	Salgado
10583	347	Santa Luzia do Itanhy
10584	347	Santana do São Francisco
10585	347	Santo Amaro das Brotas
10586	347	São Cristóvão
10587	347	São Miguel do Aleixo
10588	347	Simão Dias
10589	347	Siriri
10590	347	Telha
10591	347	Tobias Barreto
10592	347	Tomar do Geru
10593	347	Umbaúba
10594	348	Abreulândia
10595	348	Aguiarnópolis
10596	348	Aliança do Tocantins
10597	348	Almas
10598	348	Ananás
10599	348	Angico
10600	348	Aparecida do Rio Negro
10601	348	Aragominas
10602	348	Araguacema
10603	348	Araguaçu
10604	348	Araguaína
10605	348	Araguatins
10606	348	Arapoema
10607	348	Arraias
10608	348	Augustinópolis
10609	348	Aurora do Tocantins
10610	348	Axixá do Tocantins
10611	348	Babaçulândia
10612	348	Bandeirantes do Tocantins
10613	348	Barra do Ouro
10614	348	Barrolândia
10615	348	Bernardo Sayão
10616	348	Brasilândia do Tocantins
10617	348	Brejinho de Nazaré
10618	348	Buriti do Tocantins
10619	348	Campos Lindos
10620	348	Cariri do Tocantins
10621	348	Carmolândia
10622	348	Carrasco Bonito
10623	348	Caseara
10624	348	Chapada da Natividade
10625	348	Chapada de Areia
10626	348	Colinas do Tocantins
10627	348	Colméia
10628	348	Combinado
10629	348	Conceição do Tocantins
10630	348	Couto de Magalhães
10631	348	Cristalândia
10632	348	Crixás do Tocantins
10633	348	Darcinópolis
10634	348	Dianópolis
10635	348	Divinópolis do Tocantins
10636	348	Dois Irmãos do Tocantins
10637	348	Dueré
10638	348	Figueirópolis
10639	348	Formoso do Araguaia
10640	348	Fortaleza do Tabocão
10641	348	Goianorte
10642	348	Goiatins
10643	348	Guaraí
10644	348	Gurupi
10645	348	Itacajá
10646	348	Itaguatins
10647	348	Itapiratins
10648	348	Itaporã do Tocantins
10649	348	Jaú do Tocantins
10650	348	Juarina
10651	348	Lagoa da Confusão
10652	348	Lagoa do Tocantins
10653	348	Lajeado (Tocantins)
10654	348	Lavandeira
10655	348	Lizarda
10656	348	Luzinópolis
10657	348	Marianópolis do Tocantins
10658	348	Mateiros
10659	348	Maurilândia do Tocantins
10660	348	Miracema do Tocantins
10661	348	Miranorte
10662	348	Monte do Carmo
10663	348	Monte Santo do Tocantins
10664	348	Muricilândia
10665	348	Nova Rosalândia
10666	348	Novo Acordo
10667	348	Novo Alegre
10668	348	Novo Jardim
10669	348	Oliveira de Fátima
10670	348	Palmeirante
10671	348	Palmeiras do Tocantins
10672	348	Palmeirópolis
10673	348	Paraíso do Tocantins
10674	348	Paranã
10675	348	Pedro Afonso
10676	348	Peixe
10677	348	Pequizeiro
10678	348	Pindorama do Tocantins
10679	348	Piraquê
10680	348	Pium
10681	348	Ponte Alta do Bom Jesus
10682	348	Ponte Alta do Tocantins
10683	348	Porto Alegre do Tocantins
10684	348	Porto Nacional
10685	348	Praia Norte
10686	348	Pugmil
10687	348	Recursolândia
10688	348	Rio da Conceição
10689	348	Rio dos Bois
10690	348	Rio Sono
10691	348	Sampaio
10692	348	Sandolândia
10693	348	Santa Fé do Araguaia
10694	348	Santa Maria do Tocantins
10695	348	Santa Rita do Tocantins
10696	348	Santa Rosa do Tocantins
10697	348	Santa Tereza do Tocantins
10698	348	Santa Terezinha do Tocantins
10699	348	São Bento do Tocantins
10700	348	São Félix do Tocantins
10701	348	São Miguel do Tocantins
10702	348	São Salvador do Tocantins
10703	348	São Sebastião do Tocantins
10704	348	São Valério da Natividade
10705	348	Silvanópolis
10706	348	Sítio Novo do Tocantins
10707	348	Sucupira
10708	348	Taquaruçu do Porto
10709	348	Taipas do Tocantins
10710	348	Talismã
10711	348	Tocantínia
10712	348	Tocantinópolis
10713	348	Tupirama
10714	348	Tupiratins
10715	348	Wanderlândia
10716	348	Xambioá
10717	349	Adamantina
10718	349	Adolfo
10719	349	Aguaí
10720	349	Águas da Prata
10721	349	Águas de Lindóia
10722	349	Águas de Santa Bárbara
10723	349	Águas de São Pedro
10724	349	Agudos
10725	349	Alambari
10726	349	Alfredo Marcondes
10727	349	Altair
10728	349	Altinópolis
10729	349	Alumínio
10730	349	Álvares Florence
10731	349	Álvares Machado
10732	349	Álvaro de Carvalho
10733	349	Alvinlândia
10734	349	Americana
10735	349	Américo Brasiliense
10736	349	Américo de Campos
10737	349	Analândia
10738	349	Andradina
10739	349	Angatuba
10740	349	Anhembi
10741	349	Anhumas
10742	349	Aparecida D´oeste
10743	349	Apiaí
10744	349	Araçariguama
10745	349	Araçatuba
10746	349	Araçoiaba da Serra
10747	349	Aramina
10748	349	Arandu
10749	349	Arapeí
10750	349	Araraquara
10751	349	Araras
10752	349	Arco-íris
10753	349	Arealva
10754	349	Areias
10755	349	Areiópolis
10756	349	Ariranha
10757	349	Artur Nogueira
10758	349	Arujá
10759	349	Aspásia
10760	349	Assis
10761	349	Atibaia
10762	349	Auriflama
10763	349	Avaí
10764	349	Avanhandava
10765	349	Avaré
10766	349	Bady Bassitt
10767	349	Balbinos
10768	349	Bálsamo
10769	349	Bananal
10770	349	Barão de Antonina
10771	349	Barbosa
10772	349	Bariri
10773	349	Barra do Chapéu
10774	349	Barra do Turvo
10775	349	Barretos
10776	349	Barrinha
10777	349	Barueri
10778	349	Bastos
10779	349	Batatais
10780	349	Bauru
10781	349	Bebedouro
10782	349	Bento de Abreu
10783	349	Bernardino de Campos
10784	349	Bertioga
10785	349	Bilac
10786	349	Birigui
10787	349	Biritiba-mirim
10788	349	Boa Esperança do Sul
10789	349	Bofete
10790	349	Boituva
10791	349	Bom Jesus Dos Perdões
10792	349	Bom Sucesso de Itararé
10793	349	Borá
10794	349	Boracéia
10795	349	Borebi
10796	349	Botucatu
10797	349	Bragança Paulista
10798	349	Braúna
10799	349	Brejo Alegre
10800	349	Brodowski
10801	349	Brotas
10802	349	Buri
10803	349	Buritama
10804	349	Buritizal
10805	349	Cabrália Paulista
10806	349	Cabreúva
10807	349	Caçapava
10808	349	Cachoeira Paulista
10809	349	Caconde
10810	349	Caiabu
10811	349	Caieiras
10812	349	Caiuá
10813	349	Cajamar
10814	349	Cajati
10815	349	Cajobi
10816	349	Cajuru
10817	349	Campina do Monte Alegre
10818	349	Campinas
10819	349	Campo Limpo Paulista
10820	349	Campos do Jordão
10821	349	Campos Novos Paulista
10822	349	Cananéia
10823	349	Canas
10824	349	Cândido Mota
10825	349	Cândido Rodrigues
10826	349	Canitar
10827	349	Capão Bonito
10828	349	Capela do Alto
10829	349	Capivari
10830	349	Caraguatatuba
10831	349	Carapicuíba
10832	349	Cardoso
10833	349	Casa Branca
10834	349	Cássia Dos Coqueiros
10835	349	Castilho
10836	349	Catanduva
10837	349	Catiguá
10838	349	Cerqueira César
10839	349	Cerquilho
10840	349	Cesário Lange
10841	349	Charqueada
10842	349	Clementina
10843	349	Colina
10844	349	Colômbia
10845	349	Conchal
10846	349	Conchas
10847	349	Cordeirópolis
10848	349	Coroados
10849	349	Coronel Macedo
10850	349	Corumbataí
10851	349	Cosmópolis
10852	349	Cosmorama
10853	349	Cotia
10854	349	Cravinhos
10855	349	Cristais Paulista
10856	349	Cruzália
10857	349	Cubatão
10858	349	Cunha
10859	349	Descalvado
10860	349	Diadema
10861	349	Dirce Reis
10862	349	Divinolândia
10863	349	Dobrada
10864	349	Dois Córregos
10865	349	Dolcinópolis
10866	349	Dourado
10867	349	Dracena
10868	349	Duartina
10869	349	Dumont
10870	349	Echaporã
10871	349	Elias Fausto
10872	349	Elisiário
10873	349	Embaúba
10874	349	Embu
10875	349	Embu-guaçu
10876	349	Emilianópolis
10877	349	Engenheiro Coelho
10878	349	Espírito Santo do Pinhal
10879	349	Espírito Santo do Turvo
10880	349	Estrela D´oeste
10881	349	Euclides da Cunha Paulista
10882	349	Fartura
10883	349	Fernandópolis
10884	349	Fernando Prestes
10885	349	Fernão
10886	349	Ferraz de Vasconcelos
10887	349	Flora Rica
10888	349	Floreal
10889	349	Flórida Paulista
10890	349	Florínia
10891	349	Franca
10892	349	Francisco Morato
10893	349	Franco da Rocha
10894	349	Gabriel Monteiro
10895	349	Gália
10896	349	Garça
10897	349	Gastão Vidigal
10898	349	Gavião Peixoto
10899	349	General Salgado
10900	349	Getulina
10901	349	Glicério
10902	349	Guaiçara
10903	349	Guaimbê
10904	349	Guapiaçu
10905	349	Guapiara
10906	349	Guaraçaí
10907	349	Guarani D´oeste
10908	349	Guarantã
10909	349	Guararapes
10910	349	Guararema
10911	349	Guaratinguetá
10912	349	Guareí
10913	349	Guariba
10914	349	Guarujá
10915	349	Guarulhos
10916	349	Guatapará
10917	349	Guzolândia
10918	349	Herculândia
10919	349	Holambra
10920	349	Hortolândia
10921	349	Iacanga
10922	349	Iacri
10923	349	Iaras
10924	349	Ibaté
10925	349	Ibirá
10926	349	Ibirarema
10927	349	Ibitinga
10928	349	Ibiúna
10929	349	Icém
10930	349	Iepê
10931	349	Igaraçu do Tietê
10932	349	Igarapava
10933	349	Igaratá
10934	349	Iguape
10935	349	Ilhabela
10936	349	Ilha Comprida
10937	349	Ilha Solteira
10938	349	Indaiatuba
10939	349	Indiana
10940	349	Indiaporã
10941	349	Inúbia Paulista
10942	349	Ipaussu
10943	349	Iperó
10944	349	Ipeúna
10945	349	Ipiguá
10946	349	Iporanga
10947	349	Ipuã
10948	349	Iracemápolis
10949	349	Irapuã
10950	349	Irapuru
10951	349	Itaberá
10952	349	Itaí
10953	349	Itajobi
10954	349	Itaju
10955	349	Itanhaém
10956	349	Itaóca
10957	349	Itapecerica da Serra
10958	349	Itapetininga
10959	349	Itapevi
10960	349	Itapira
10961	349	Itapirapuã Paulista
10962	349	Itápolis
10963	349	Itapuí
10964	349	Itapura
10965	349	Itaquaquecetuba
10966	349	Itararé
10967	349	Itariri
10968	349	Itatiba
10969	349	Itatinga
10970	349	Itirapina
10971	349	Itirapuã
10972	349	Itobi
10973	349	Itu
10974	349	Itupeva
10975	349	Ituverava
10976	349	Jaboticabal
10977	349	Jacareí
10978	349	Jaci
10979	349	Jacupiranga
10980	349	Jaguariúna
10981	349	Jales
10982	349	Jambeiro
10983	349	Jandira
10984	349	Jarinu
10985	349	Jaú
10986	349	Jeriquara
10987	349	Joanópolis
10988	349	João Ramalho
10989	349	José Bonifácio
10990	349	Júlio Mesquita
10991	349	Jumirim
10992	349	Jundiaí
10993	349	Junqueirópolis
10994	349	Juquiá
10995	349	Juquitiba
10996	349	Lagoinha
10997	349	Laranjal Paulista
10998	349	Lavínia
10999	349	Lavrinhas
11000	349	Leme
11001	349	Lençóis Paulista
11002	349	Limeira
11003	349	Lindóia
11004	349	Lins
11005	349	Lorena
11006	349	Lourdes
11007	349	Louveira
11008	349	Lucélia
11009	349	Lucianópolis
11010	349	Luís Antônio
11011	349	Luiziânia
11012	349	Lupércio
11013	349	Lutécia
11014	349	Macatuba
11015	349	Macaubal
11016	349	Macedônia
11017	349	Magda
11018	349	Mairinque
11019	349	Mairiporã
11020	349	Manduri
11021	349	Marabá Paulista
11022	349	Maracaí
11023	349	Marapoama
11024	349	Mariápolis
11025	349	Marília
11026	349	Marinópolis
11027	349	Martinópolis
11028	349	Matão
11029	349	Mauá
11030	349	Mendonça
11031	349	Meridiano
11032	349	Mesópolis
11033	349	Miguelópolis
11034	349	Mineiros do Tietê
11035	349	Miracatu
11036	349	Mira Estrela
11037	349	Mirandópolis
11038	349	Mirante do Paranapanema
11039	349	Mirassol
11040	349	Mirassolândia
11041	349	Mococa
11042	349	Moji Das Cruzes
11043	349	Mogi Guaçu
11044	349	Moji-mirim
11045	349	Mombuca
11046	349	Monções
11047	349	Mongaguá
11048	349	Monte Alegre do Sul
11049	349	Monte Alto
11050	349	Monte Aprazível
11051	349	Monte Azul Paulista
11052	349	Monteiro Lobato
11053	349	Monte Mor
11054	349	Morro Agudo
11055	349	Morungaba
11056	349	Motuca
11057	349	Murutinga do Sul
11058	349	Nantes
11059	349	Narandiba
11060	349	Natividade da Serra
11061	349	Nazaré Paulista
11062	349	Neves Paulista
11063	349	Nhandeara
11064	349	Nipoã
11065	349	Nova Aliança
11066	349	Nova Campina
11067	349	Nova Canaã Paulista
11068	349	Nova Castilho
11069	349	Nova Europa
11070	349	Nova Granada
11071	349	Nova Guataporanga
11072	349	Nova Independência
11073	349	Novais
11074	349	Nova Luzitânia
11075	349	Nova Odessa
11076	349	Nuporanga
11077	349	Ocauçu
11078	349	Óleo
11079	349	Olímpia
11080	349	Onda Verde
11081	349	Oriente
11082	349	Orindiúva
11083	349	Orlândia
11084	349	Osasco
11085	349	Oscar Bressane
11086	349	Osvaldo Cruz
11087	349	Ourinhos
11088	349	Ouroeste
11089	349	Pacaembu
11090	349	Palmares Paulista
11091	349	Palmeira D´oeste
11092	349	Panorama
11093	349	Paraguaçu Paulista
11094	349	Paraibuna
11095	349	Paranapanema
11096	349	Paranapuã
11097	349	Parapuã
11098	349	Pardinho
11099	349	Pariquera-açu
11100	349	Parisi
11101	349	Patrocínio Paulista
11102	349	Paulicéia
11103	349	Paulínia
11104	349	Paulistânia
11105	349	Paulo de Faria
11106	349	Pederneiras
11107	349	Pedra Bela
11108	349	Pedranópolis
11109	349	Pedregulho
11110	349	Pedreira
11111	349	Pedrinhas Paulista
11112	349	Pedro de Toledo
11113	349	Penápolis
11114	349	Pereira Barreto
11115	349	Pereiras
11116	349	Peruíbe
11117	349	Piacatu
11118	349	Piedade
11119	349	Pilar do Sul
11120	349	Pindamonhangaba
11121	349	Pindorama
11122	349	Piquerobi
11123	349	Piquete
11124	349	Piracaia
11125	349	Piracicaba
11126	349	Piraju
11127	349	Pirajuí
11128	349	Pirangi
11129	349	Pirapora do Bom Jesus
11130	349	Pirapozinho
11131	349	Pirassununga
11132	349	Piratininga
11133	349	Platina
11134	349	Poá
11135	349	Poloni
11136	349	Pompéia
11137	349	Pongaí
11138	349	Pontal
11139	349	Pontalinda
11140	349	Pontes Gestal
11141	349	Populina
11142	349	Porangaba
11143	349	Porto Feliz
11144	349	Porto Ferreira
11145	349	Potim
11146	349	Potirendaba
11147	349	Pracinha
11148	349	Pradópolis
11149	349	Pratânia
11150	349	Presidente Alves
11151	349	Presidente Epitácio
11152	349	Presidente Prudente
11153	349	Presidente Venceslau
11154	349	Promissão
11155	349	Quadra
11156	349	Quatá
11157	349	Queiroz
11158	349	Queluz
11159	349	Quintana
11160	349	Rafard
11161	349	Rancharia
11162	349	Redenção da Serra
11163	349	Regente Feijó
11164	349	Reginópolis
11165	349	Registro
11166	349	Restinga
11167	349	Ribeira
11168	349	Ribeirão Bonito
11169	349	Ribeirão Branco
11170	349	Ribeirão Corrente
11171	349	Ribeirão do Sul
11172	349	Ribeirão Dos Índios
11173	349	Ribeirão Grande
11174	349	Ribeirão Pires
11175	349	Ribeirão Preto
11176	349	Riversul
11177	349	Rifaina
11178	349	Rincão
11179	349	Rinópolis
11180	349	Rio Claro
11181	349	Rio Das Pedras
11182	349	Rio Grande da Serra
11183	349	Riolândia
11184	349	Rosana
11185	349	Roseira
11186	349	Rubiácea
11187	349	Rubinéia
11188	349	Sabino
11189	349	Sagres
11190	349	Sales
11191	349	Sales Oliveira
11192	349	Salesópolis
11193	349	Salmourão
11194	349	Salto
11195	349	Salto de Pirapora
11196	349	Salto Grande
11197	349	Sandovalina
11198	349	Santa Adélia
11199	349	Santa Albertina
11200	349	Santa Bárbara D´oeste
11201	349	Santa Branca
11202	349	Santa Clara D´oeste
11203	349	Santa Cruz da Conceição
11204	349	Santa Cruz da Esperança
11205	349	Santa Cruz Das Palmeiras
11206	349	Santa Cruz do Rio Pardo
11207	349	Santa Ernestina
11208	349	Santa fé do Sul
11209	349	Santa Gertrudes
11210	349	Santa Maria da Serra
11211	349	Santa Mercedes
11212	349	Santana da Ponte Pensa
11213	349	Santana de Parnaíba
11214	349	Santa Rita D´oeste
11215	349	Santa Rita do Passa Quatro
11216	349	Santa Rosa de Viterbo
11217	349	Santa Salete
11218	349	Santo Anastácio
11219	349	Santo Antônio da Alegria
11220	349	Santo Antônio de Posse
11221	349	Santo Antônio do Aracanguá
11222	349	Santo Antônio do Jardim
11223	349	Santo Antônio do Pinhal
11224	349	Santo Expedito
11225	349	Santópolis do Aguapeí
11226	349	Santos
11227	349	São Bento do Sapucaí
11228	349	São Bernardo do Campo
11229	349	São Caetano do Sul
11230	349	São João da Boa Vista
11231	349	São João Das Duas Pontes
11232	349	São João de Iracema
11233	349	São João do Pau D´alho
11234	349	São Joaquim da Barra
11235	349	São José da Bela Vista
11236	349	São José do Barreiro
11237	349	São José do Rio Pardo
11238	349	São José do Rio Preto
11239	349	São José Dos Campos
11240	349	São Lourenço da Serra
11241	349	São Luís do Paraitinga
11242	349	São Manuel
11243	349	São Miguel Arcanjo
11244	349	São Paulo
11245	349	São Pedro do Turvo
11246	349	São Roque
11247	349	São Sebastião da Grama
11248	349	Sarapuí
11249	349	Sarutaiá
11250	349	Sebastianópolis do Sul
11251	349	Serra Azul
11252	349	Serrana
11253	349	Serra Negra
11254	349	Sete Barras
11255	349	Severínia
11256	349	Silveiras
11257	349	Socorro
11258	349	Sorocaba
11259	349	Sud Mennucci
11260	349	Sumaré
11261	349	Suzano
11262	349	Suzanápolis
11263	349	Tabapuã
11264	349	Taboão da Serra
11265	349	Taciba
11266	349	Taguaí
11267	349	Taiaçu
11268	349	Taiúva
11269	349	Tambaú
11270	349	Tanabi
11271	349	Tapiratiba
11272	349	Taquaral
11273	349	Taquaritinga
11274	349	Taquarituba
11275	349	Taquarivaí
11276	349	Tarabai
11277	349	Tarumã
11278	349	Tatuí
11279	349	Taubaté
11280	349	Tejupá
11281	349	Tietê
11282	349	Timburi
11283	349	Torre de Pedra
11284	349	Torrinha
11285	349	Trabiju
11286	349	Tremembé
11287	349	Três Fronteiras
11288	349	Tuiuti
11289	349	Tupã
11290	349	Tupi Paulista
11291	349	Turiúba
11292	349	Ubarana
11293	349	Ubatuba
11294	349	Ubirajara
11295	349	Uchoa
11296	349	União Paulista
11297	349	Urânia
11298	349	Uru
11299	349	Urupês
11300	349	Valentim Gentil
11301	349	Valinhos
11302	349	Valparaíso
11303	349	Vargem Grande do Sul
11304	349	Vargem Grande Paulista
11305	349	Várzea Paulista
11306	349	Vinhedo
11307	349	Viradouro
11308	349	Vista Alegre do Alto
11309	349	Vitória Brasil
11310	349	Votorantim
11311	349	Votuporanga
11312	349	Zacarias
11313	349	Chavantes
0	0	No Determinado
\.


--
-- TOC entry 2627 (class 0 OID 33571)
-- Dependencies: 260
-- Data for Name: tipocargo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipocargo (idtipocargo, descripcion, posee_nivel) FROM stdin;
2	OFICIAL	S
1	MINISTERIAL	N
\.


--
-- TOC entry 2629 (class 0 OID 33578)
-- Dependencies: 262
-- Data for Name: tipoconstruccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipoconstruccion (idtipoconstruccion, descripcion) FROM stdin;
1	Adobe
2	Ladrillos
3	Madera
\.


--
-- TOC entry 2600 (class 0 OID 33463)
-- Dependencies: 230
-- Data for Name: tipodoc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipodoc (idtipodoc, descripcion) FROM stdin;
4	Pasaporte
6	Otros
2	Certificado de Nacimiento
3	Carnet Extranjeria
5	Tarjeta de Servicio Militar
0	No Determinado
1	Documento de Identidad (DNI, Cédula de Identidad)
\.


--
-- TOC entry 2632 (class 0 OID 33586)
-- Dependencies: 265
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
-- TOC entry 2634 (class 0 OID 33592)
-- Dependencies: 267
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
-- TOC entry 2636 (class 0 OID 33598)
-- Dependencies: 269
-- Data for Name: trimestre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trimestre (idtrimestre, descripcion, fechainicial, fechafinal, nrosemanas) FROM stdin;
1	Primer Trimestre	01/01	31/03	13
2	Segundo Trimestre	01/04	30/06	13
3	Tercer Trimestre	01/07	30/09	13
4	Cuarto Trimestre	01/10	31/12	13
\.


--
-- TOC entry 2638 (class 0 OID 33610)
-- Dependencies: 272
-- Data for Name: log_sistema; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.log_sistema (idlog, mensaje, fecha, usuario, nombres, idperfil, idreferencia, ip, operacion, tabla) FROM stdin;
1	\N	2021-09-16 17:25:46	admin	DE LA GARZA ZAVALETA, TONY MARTIN	1	20	::1	insertar	public.idiomas
2	\N	2021-09-16 17:28:25	admin	DE LA GARZA ZAVALETA, TONY MARTIN	1	20	::1	modificar	public.idiomas
3	\N	2021-09-16 17:28:33	admin	DE LA GARZA ZAVALETA, TONY MARTIN	1	20	::1	modificar	public.idiomas
4	\N	2021-09-16 17:29:00	admin	DE LA GARZA ZAVALETA, TONY MARTIN	1	20	::1	modificar	public.idiomas
5	\N	2021-09-16 17:29:09	admin	DE LA GARZA ZAVALETA, TONY MARTIN	1	20	::1	modificar	public.idiomas
6	\N	2021-09-16 17:31:07	admin	DE LA GARZA ZAVALETA, TONY MARTIN	1	20	::1	modificar	public.idiomas
7	\N	2021-09-16 17:31:31	admin	DE LA GARZA ZAVALETA, TONY MARTIN	1	20	::1	eliminar	public.idiomas
8	\N	2021-09-16 17:32:59	admin	DE LA GARZA ZAVALETA, TONY MARTIN	1	21	::1	insertar	public.idiomas
9	\N	2021-09-16 17:35:04	admin	DE LA GARZA ZAVALETA, TONY MARTIN	1	22	::1	insertar	public.idiomas
10	\N	2021-09-16 17:35:27	admin	DE LA GARZA ZAVALETA, TONY MARTIN	1	3	::1	insertar	public.idiomas
\.


--
-- TOC entry 2640 (class 0 OID 33621)
-- Dependencies: 274
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
36	\N	#	reportes/general_asociados	35	2	C20210716214013	A
37	\N	#	reportes/grafico_feligresia	35	3	C20210718212452	A
38	\N	#	reportes/miembros_iglesia	35	4	C20210718212747	A
39	\N	#	instituciones/index	8	15	C20210726012743	A
40	\N	#	otras_propiedades/index	8	16	C20210726012810	A
41	\N	#	reportes/oficiales_iglesia	35	5	C20210728151814	A
42	\N	#	reportes/oficiales_union_asociacion	35	6	C20210728161558	A
43	\N	#	reportes/informe_semestral	35	7	C20210728162033	A
44	\N	#	eleccion/index	13	6	C20210729230642	A
45	\N	#	importar/datos	13	7	C20210820001538	A
\.


--
-- TOC entry 2641 (class 0 OID 33625)
-- Dependencies: 275
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
36	1	Reporte General de Asociados
37	1	Reporte de Feligresia
38	1	Miembros de Iglesia
39	1	Instituciones
40	1	Otras Propiedades
41	1	Oficiales de Iglesia
42	1	Oficiales Unión/Asociación
43	1	Informe Semestral
44	1	Elección de Oficiales
45	1	Importar Datos
\.


--
-- TOC entry 2643 (class 0 OID 33630)
-- Dependencies: 277
-- Data for Name: perfiles; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.perfiles (perfil_id, perfil_descripcion, estado) FROM stdin;
1	ADMINISTRADOR	A
2	SUBADMINISTRADOR	A
22	\N	A
\.


--
-- TOC entry 2644 (class 0 OID 33634)
-- Dependencies: 278
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
-- TOC entry 2646 (class 0 OID 33639)
-- Dependencies: 280
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
2	31
2	32
2	33
2	39
2	40
2	16
2	26
2	2
2	7
2	4
2	5
2	34
22	10
22	17
22	9
22	18
22	19
22	20
22	21
22	22
22	23
22	24
22	25
22	31
22	32
22	33
22	39
22	40
22	16
22	29
22	26
22	28
22	30
22	44
22	2
22	7
22	4
22	5
22	34
22	36
22	37
22	38
22	41
22	42
22	43
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
1	39
1	40
1	16
1	29
1	26
1	28
1	30
1	44
1	45
1	2
1	7
1	4
1	5
1	34
1	36
1	37
1	38
1	41
1	42
1	43
\.


--
-- TOC entry 2647 (class 0 OID 33642)
-- Dependencies: 281
-- Data for Name: tipoacceso; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.tipoacceso (idtipoacceso, descripcion) FROM stdin;
1	su DISTRITO MISIONERO
4	su PAIS
5	su DIVISION
3	su UNION
2	su ASOCIACIÓN
\.


--
-- TOC entry 2649 (class 0 OID 33648)
-- Dependencies: 283
-- Data for Name: usuarios; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.usuarios (usuario_id, usuario_user, usuario_pass, usuario_nombres, usuario_referencia, perfil_id, estado, idmiembro, idtipoacceso) FROM stdin;
10	admin	$2y$10$p93p/0o.usTlXCq//upIce5Chvo/KagAsZ7qX1y6Aw299eoVW8TWC	\N	\N	1	A	19	5
\.


--
-- TOC entry 2715 (class 0 OID 0)
-- Dependencies: 172
-- Name: actividadmisionera_idactividadmisionera_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.actividadmisionera_idactividadmisionera_seq', 40, true);


--
-- TOC entry 2716 (class 0 OID 0)
-- Dependencies: 174
-- Name: capacitacion_miembro_idcapacitacion_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.capacitacion_miembro_idcapacitacion_seq', 1, false);


--
-- TOC entry 2717 (class 0 OID 0)
-- Dependencies: 176
-- Name: cargo_miembro_idcargomiembro_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.cargo_miembro_idcargomiembro_seq', 1, false);


--
-- TOC entry 2718 (class 0 OID 0)
-- Dependencies: 178
-- Name: categoriaiglesia_idcategoriaiglesia_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.categoriaiglesia_idcategoriaiglesia_seq', 1, false);


--
-- TOC entry 2719 (class 0 OID 0)
-- Dependencies: 180
-- Name: condicioneclesiastica_idcondicioneclesiastica_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.condicioneclesiastica_idcondicioneclesiastica_seq', 1, false);


--
-- TOC entry 2720 (class 0 OID 0)
-- Dependencies: 182
-- Name: condicioninmueble_idcondicioninmueble_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.condicioninmueble_idcondicioninmueble_seq', 1, false);


--
-- TOC entry 2721 (class 0 OID 0)
-- Dependencies: 184
-- Name: control_traslados_idcontrol_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.control_traslados_idcontrol_seq', 1, false);


--
-- TOC entry 2722 (class 0 OID 0)
-- Dependencies: 186
-- Name: controlactmisionera_idcontrolactmisionera_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.controlactmisionera_idcontrolactmisionera_seq', 1, false);


--
-- TOC entry 2723 (class 0 OID 0)
-- Dependencies: 188
-- Name: distritomisionero_iddistritomisionero_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.distritomisionero_iddistritomisionero_seq', 55, true);


--
-- TOC entry 2724 (class 0 OID 0)
-- Dependencies: 190
-- Name: division_iddivision_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.division_iddivision_seq', 6, true);


--
-- TOC entry 2725 (class 0 OID 0)
-- Dependencies: 193
-- Name: educacion_miembro_ideducacionmiembro_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.educacion_miembro_ideducacionmiembro_seq', 1, false);


--
-- TOC entry 2726 (class 0 OID 0)
-- Dependencies: 195
-- Name: eleccion_ideleccion_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.eleccion_ideleccion_seq', 1, false);


--
-- TOC entry 2727 (class 0 OID 0)
-- Dependencies: 197
-- Name: historial_altasybajas_idhistorial_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.historial_altasybajas_idhistorial_seq', 1, false);


--
-- TOC entry 2728 (class 0 OID 0)
-- Dependencies: 199
-- Name: historial_traslados_idtraslado_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.historial_traslados_idtraslado_seq', 1, false);


--
-- TOC entry 2729 (class 0 OID 0)
-- Dependencies: 201
-- Name: iglesia_idiglesia_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.iglesia_idiglesia_seq', 1785, true);


--
-- TOC entry 2730 (class 0 OID 0)
-- Dependencies: 203
-- Name: institucion_idinstitucion_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.institucion_idinstitucion_seq', 1, false);


--
-- TOC entry 2731 (class 0 OID 0)
-- Dependencies: 205
-- Name: laboral_miembro_idlaboralmiembro_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.laboral_miembro_idlaboralmiembro_seq', 1, false);


--
-- TOC entry 2732 (class 0 OID 0)
-- Dependencies: 207
-- Name: miembro_idmiembro_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.miembro_idmiembro_seq', 1, false);


--
-- TOC entry 2733 (class 0 OID 0)
-- Dependencies: 209
-- Name: mision_idmision_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.mision_idmision_seq', 21, true);


--
-- TOC entry 2734 (class 0 OID 0)
-- Dependencies: 211
-- Name: motivobaja_idmotivobaja_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.motivobaja_idmotivobaja_seq', 1, false);


--
-- TOC entry 2735 (class 0 OID 0)
-- Dependencies: 213
-- Name: otras_propiedades_ idotrapropiedad_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias."otras_propiedades_ idotrapropiedad_seq"', 1, false);


--
-- TOC entry 2736 (class 0 OID 0)
-- Dependencies: 215
-- Name: otrospastores_idotrospastores_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.otrospastores_idotrospastores_seq', 1, false);


--
-- TOC entry 2737 (class 0 OID 0)
-- Dependencies: 219
-- Name: paises_jerarquia_pj_id_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.paises_jerarquia_pj_id_seq', 61, true);


--
-- TOC entry 2738 (class 0 OID 0)
-- Dependencies: 220
-- Name: paises_pais_id_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.paises_pais_id_seq', 23, true);


--
-- TOC entry 2739 (class 0 OID 0)
-- Dependencies: 222
-- Name: parentesco_miembro_idparentescomiembro_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.parentesco_miembro_idparentescomiembro_seq', 1, false);


--
-- TOC entry 2740 (class 0 OID 0)
-- Dependencies: 224
-- Name: religion_idreligion_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.religion_idreligion_seq', 1, false);


--
-- TOC entry 2741 (class 0 OID 0)
-- Dependencies: 226
-- Name: temp_traslados_idtemptraslados_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.temp_traslados_idtemptraslados_seq', 461, true);


--
-- TOC entry 2742 (class 0 OID 0)
-- Dependencies: 228
-- Name: union_idunion_seq; Type: SEQUENCE SET; Schema: iglesias; Owner: postgres
--

SELECT pg_catalog.setval('iglesias.union_idunion_seq', 14, true);


--
-- TOC entry 2743 (class 0 OID 0)
-- Dependencies: 235
-- Name: cargo_idcargo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cargo_idcargo_seq', 157, true);


--
-- TOC entry 2744 (class 0 OID 0)
-- Dependencies: 237
-- Name: condicioninmueble_idcondicioninmueble_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.condicioninmueble_idcondicioninmueble_seq', 1, false);


--
-- TOC entry 2745 (class 0 OID 0)
-- Dependencies: 239
-- Name: departamento_iddepartamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departamento_iddepartamento_seq', 349, true);


--
-- TOC entry 2746 (class 0 OID 0)
-- Dependencies: 241
-- Name: distrito_iddistrito_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.distrito_iddistrito_seq', 9143, true);


--
-- TOC entry 2747 (class 0 OID 0)
-- Dependencies: 243
-- Name: estadocivil_idestadocivil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estadocivil_idestadocivil_seq', 1, false);


--
-- TOC entry 2748 (class 0 OID 0)
-- Dependencies: 245
-- Name: gradoinstruccion_idgradoinstruccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gradoinstruccion_idgradoinstruccion_seq', 1, false);


--
-- TOC entry 2749 (class 0 OID 0)
-- Dependencies: 247
-- Name: idiomas_idioma_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.idiomas_idioma_id_seq', 2, true);


--
-- TOC entry 2750 (class 0 OID 0)
-- Dependencies: 249
-- Name: nivel_idnivel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nivel_idnivel_seq', 21, true);


--
-- TOC entry 2751 (class 0 OID 0)
-- Dependencies: 251
-- Name: ocupacion_idocupacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ocupacion_idocupacion_seq', 1, false);


--
-- TOC entry 2752 (class 0 OID 0)
-- Dependencies: 253
-- Name: pais_idpais_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pais_idpais_seq', 1, false);


--
-- TOC entry 2753 (class 0 OID 0)
-- Dependencies: 255
-- Name: parentesco_idparentesco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parentesco_idparentesco_seq', 1, false);


--
-- TOC entry 2754 (class 0 OID 0)
-- Dependencies: 257
-- Name: procesos_proceso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.procesos_proceso_id_seq', 1, false);


--
-- TOC entry 2755 (class 0 OID 0)
-- Dependencies: 259
-- Name: provincia_idprovincia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.provincia_idprovincia_seq', 11313, true);


--
-- TOC entry 2756 (class 0 OID 0)
-- Dependencies: 261
-- Name: tipocargo_idtipocargo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipocargo_idtipocargo_seq', 22, true);


--
-- TOC entry 2757 (class 0 OID 0)
-- Dependencies: 263
-- Name: tipoconstruccion_idtipoconstruccion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipoconstruccion_idtipoconstruccion_seq', 1, false);


--
-- TOC entry 2758 (class 0 OID 0)
-- Dependencies: 264
-- Name: tipodoc_idtipodoc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipodoc_idtipodoc_seq', 1, false);


--
-- TOC entry 2759 (class 0 OID 0)
-- Dependencies: 266
-- Name: tipodocumentacion_idtipodocumentacion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipodocumentacion_idtipodocumentacion_seq', 1, false);


--
-- TOC entry 2760 (class 0 OID 0)
-- Dependencies: 268
-- Name: tipoinmueble_idtipoinmueble_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipoinmueble_idtipoinmueble_seq', 1, false);


--
-- TOC entry 2761 (class 0 OID 0)
-- Dependencies: 270
-- Name: trimestre_idtrimestre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trimestre_idtrimestre_seq', 1, false);


--
-- TOC entry 2762 (class 0 OID 0)
-- Dependencies: 273
-- Name: log_sistema_idlog_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.log_sistema_idlog_seq', 10, true);


--
-- TOC entry 2763 (class 0 OID 0)
-- Dependencies: 276
-- Name: modulos_modulo_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.modulos_modulo_id_seq', 45, true);


--
-- TOC entry 2764 (class 0 OID 0)
-- Dependencies: 279
-- Name: perfiles_perfil_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.perfiles_perfil_id_seq', 22, true);


--
-- TOC entry 2765 (class 0 OID 0)
-- Dependencies: 282
-- Name: tipoacceso_idtipoacceso_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.tipoacceso_idtipoacceso_seq', 1, false);


--
-- TOC entry 2766 (class 0 OID 0)
-- Dependencies: 284
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.usuarios_usuario_id_seq', 12, true);


--
-- TOC entry 2329 (class 2606 OID 33710)
-- Name: actividadmisionera actividadmisionera_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.actividadmisionera
    ADD CONSTRAINT actividadmisionera_pkey PRIMARY KEY (idactividadmisionera);


--
-- TOC entry 2331 (class 2606 OID 33712)
-- Name: capacitacion_miembro capacitacion_miembro_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.capacitacion_miembro
    ADD CONSTRAINT capacitacion_miembro_pkey PRIMARY KEY (idcapacitacion);


--
-- TOC entry 2333 (class 2606 OID 33714)
-- Name: cargo_miembro cargo_miembro_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.cargo_miembro
    ADD CONSTRAINT cargo_miembro_pkey PRIMARY KEY (idcargomiembro, idmiembro, idcargo);


--
-- TOC entry 2335 (class 2606 OID 33716)
-- Name: categoriaiglesia categoriaiglesia_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.categoriaiglesia
    ADD CONSTRAINT categoriaiglesia_pkey PRIMARY KEY (idcategoriaiglesia);


--
-- TOC entry 2337 (class 2606 OID 33718)
-- Name: condicioneclesiastica condicioneclesiastica_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.condicioneclesiastica
    ADD CONSTRAINT condicioneclesiastica_pkey PRIMARY KEY (idcondicioneclesiastica);


--
-- TOC entry 2339 (class 2606 OID 33720)
-- Name: condicioninmueble condicioninmueble_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.condicioninmueble
    ADD CONSTRAINT condicioninmueble_pkey PRIMARY KEY (idcondicioninmueble);


--
-- TOC entry 2341 (class 2606 OID 33722)
-- Name: control_traslados control_traslados_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.control_traslados
    ADD CONSTRAINT control_traslados_pkey PRIMARY KEY (idcontrol);


--
-- TOC entry 2343 (class 2606 OID 33724)
-- Name: controlactmisionera controlactmisionera_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.controlactmisionera
    ADD CONSTRAINT controlactmisionera_pkey PRIMARY KEY (idcontrolactmisionera);


--
-- TOC entry 2345 (class 2606 OID 33726)
-- Name: distritomisionero distritomisionero_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.distritomisionero
    ADD CONSTRAINT distritomisionero_pkey PRIMARY KEY (iddistritomisionero);


--
-- TOC entry 2347 (class 2606 OID 33728)
-- Name: division division_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.division
    ADD CONSTRAINT division_pkey PRIMARY KEY (iddivision);


--
-- TOC entry 2349 (class 2606 OID 33730)
-- Name: educacion_miembro educacion_miembro_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.educacion_miembro
    ADD CONSTRAINT educacion_miembro_pkey PRIMARY KEY (ideducacionmiembro);


--
-- TOC entry 2351 (class 2606 OID 33732)
-- Name: eleccion eleccion_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.eleccion
    ADD CONSTRAINT eleccion_pkey PRIMARY KEY (ideleccion);


--
-- TOC entry 2353 (class 2606 OID 33734)
-- Name: historial_altasybajas historial_altasybajas_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.historial_altasybajas
    ADD CONSTRAINT historial_altasybajas_pkey PRIMARY KEY (idhistorial);


--
-- TOC entry 2355 (class 2606 OID 33736)
-- Name: historial_traslados historial_traslados_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.historial_traslados
    ADD CONSTRAINT historial_traslados_pkey PRIMARY KEY (idtraslado);


--
-- TOC entry 2357 (class 2606 OID 33738)
-- Name: iglesia iglesia_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.iglesia
    ADD CONSTRAINT iglesia_pkey PRIMARY KEY (idiglesia);


--
-- TOC entry 2359 (class 2606 OID 33740)
-- Name: institucion institucion_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.institucion
    ADD CONSTRAINT institucion_pkey PRIMARY KEY (idinstitucion);


--
-- TOC entry 2361 (class 2606 OID 33742)
-- Name: laboral_miembro laboral_miembro_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.laboral_miembro
    ADD CONSTRAINT laboral_miembro_pkey PRIMARY KEY (idlaboralmiembro);


--
-- TOC entry 2363 (class 2606 OID 33744)
-- Name: miembro miembro_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.miembro
    ADD CONSTRAINT miembro_pkey PRIMARY KEY (idmiembro);


--
-- TOC entry 2365 (class 2606 OID 33746)
-- Name: mision mision_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.mision
    ADD CONSTRAINT mision_pkey PRIMARY KEY (idmision);


--
-- TOC entry 2367 (class 2606 OID 33748)
-- Name: motivobaja motivobaja_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.motivobaja
    ADD CONSTRAINT motivobaja_pkey PRIMARY KEY (idmotivobaja);


--
-- TOC entry 2369 (class 2606 OID 33750)
-- Name: otras_propiedades otras_propiedades_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.otras_propiedades
    ADD CONSTRAINT otras_propiedades_pkey PRIMARY KEY (idotrapropiedad);


--
-- TOC entry 2371 (class 2606 OID 33752)
-- Name: otrospastores otrospastores_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.otrospastores
    ADD CONSTRAINT otrospastores_pkey PRIMARY KEY (idotrospastores);


--
-- TOC entry 2373 (class 2606 OID 33754)
-- Name: paises paises_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.paises
    ADD CONSTRAINT paises_pkey PRIMARY KEY (pais_id);


--
-- TOC entry 2375 (class 2606 OID 33756)
-- Name: parentesco_miembro parentesco_miembro_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.parentesco_miembro
    ADD CONSTRAINT parentesco_miembro_pkey PRIMARY KEY (idparentescomiembro);


--
-- TOC entry 2377 (class 2606 OID 33758)
-- Name: religion religion_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.religion
    ADD CONSTRAINT religion_pkey PRIMARY KEY (idreligion);


--
-- TOC entry 2379 (class 2606 OID 33760)
-- Name: temp_traslados temp_traslados_pkey; Type: CONSTRAINT; Schema: iglesias; Owner: postgres
--

ALTER TABLE ONLY iglesias.temp_traslados
    ADD CONSTRAINT temp_traslados_pkey PRIMARY KEY (idmiembro, idtipodoc, iddivision, pais_id, idunion, idmision, iddistritomisionero, idiglesia, nrodoc, tipo_traslado);


--
-- TOC entry 2383 (class 2606 OID 33762)
-- Name: cargo cargo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargo
    ADD CONSTRAINT cargo_pkey PRIMARY KEY (idcargo);


--
-- TOC entry 2385 (class 2606 OID 33764)
-- Name: condicioninmueble condicioninmueble_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.condicioninmueble
    ADD CONSTRAINT condicioninmueble_pkey PRIMARY KEY (idcondicioninmueble);


--
-- TOC entry 2387 (class 2606 OID 33766)
-- Name: departamento departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_pkey PRIMARY KEY (iddepartamento);


--
-- TOC entry 2389 (class 2606 OID 33768)
-- Name: distrito distrito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distrito
    ADD CONSTRAINT distrito_pkey PRIMARY KEY (iddistrito);


--
-- TOC entry 2391 (class 2606 OID 33770)
-- Name: estadocivil estadocivil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estadocivil
    ADD CONSTRAINT estadocivil_pkey PRIMARY KEY (idestadocivil);


--
-- TOC entry 2393 (class 2606 OID 33772)
-- Name: gradoinstruccion gradoinstruccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gradoinstruccion
    ADD CONSTRAINT gradoinstruccion_pkey PRIMARY KEY (idgradoinstruccion);


--
-- TOC entry 2395 (class 2606 OID 33774)
-- Name: idiomas idiomas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idiomas
    ADD CONSTRAINT idiomas_pkey PRIMARY KEY (idioma_id);


--
-- TOC entry 2397 (class 2606 OID 33776)
-- Name: nivel nivel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel
    ADD CONSTRAINT nivel_pkey PRIMARY KEY (idnivel);


--
-- TOC entry 2399 (class 2606 OID 33778)
-- Name: ocupacion ocupacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ocupacion
    ADD CONSTRAINT ocupacion_pkey PRIMARY KEY (idocupacion);


--
-- TOC entry 2401 (class 2606 OID 33780)
-- Name: pais pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (idpais);


--
-- TOC entry 2403 (class 2606 OID 33782)
-- Name: parentesco parentesco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parentesco
    ADD CONSTRAINT parentesco_pkey PRIMARY KEY (idparentesco);


--
-- TOC entry 2405 (class 2606 OID 33784)
-- Name: procesos procesos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procesos
    ADD CONSTRAINT procesos_pkey PRIMARY KEY (proceso_id);


--
-- TOC entry 2407 (class 2606 OID 33786)
-- Name: provincia provincia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincia
    ADD CONSTRAINT provincia_pkey PRIMARY KEY (idprovincia);


--
-- TOC entry 2409 (class 2606 OID 33788)
-- Name: tipocargo tipocargo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipocargo
    ADD CONSTRAINT tipocargo_pkey PRIMARY KEY (idtipocargo);


--
-- TOC entry 2411 (class 2606 OID 33790)
-- Name: tipoconstruccion tipoconstruccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipoconstruccion
    ADD CONSTRAINT tipoconstruccion_pkey PRIMARY KEY (idtipoconstruccion);


--
-- TOC entry 2381 (class 2606 OID 33792)
-- Name: tipodoc tipodoc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipodoc
    ADD CONSTRAINT tipodoc_pkey PRIMARY KEY (idtipodoc);


--
-- TOC entry 2413 (class 2606 OID 33794)
-- Name: tipodocumentacion tipodocumentacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipodocumentacion
    ADD CONSTRAINT tipodocumentacion_pkey PRIMARY KEY (idtipodocumentacion);


--
-- TOC entry 2415 (class 2606 OID 33796)
-- Name: tipoinmueble tipoinmueble_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipoinmueble
    ADD CONSTRAINT tipoinmueble_pkey PRIMARY KEY (idtipoinmueble);


--
-- TOC entry 2417 (class 2606 OID 33798)
-- Name: trimestre trimestre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trimestre
    ADD CONSTRAINT trimestre_pkey PRIMARY KEY (idtrimestre);


--
-- TOC entry 2419 (class 2606 OID 33800)
-- Name: log_sistema log_sistema_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.log_sistema
    ADD CONSTRAINT log_sistema_pkey PRIMARY KEY (idlog);


--
-- TOC entry 2421 (class 2606 OID 33802)
-- Name: modulos modulos_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.modulos
    ADD CONSTRAINT modulos_pkey PRIMARY KEY (modulo_id);


--
-- TOC entry 2423 (class 2606 OID 33804)
-- Name: perfiles perfiles_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.perfiles
    ADD CONSTRAINT perfiles_pkey PRIMARY KEY (perfil_id);


--
-- TOC entry 2425 (class 2606 OID 33806)
-- Name: permisos permisos_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.permisos
    ADD CONSTRAINT permisos_pkey PRIMARY KEY (perfil_id, modulo_id);


--
-- TOC entry 2427 (class 2606 OID 33808)
-- Name: tipoacceso tipoacceso_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tipoacceso
    ADD CONSTRAINT tipoacceso_pkey PRIMARY KEY (idtipoacceso);


--
-- TOC entry 2429 (class 2606 OID 33810)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id);


--
-- TOC entry 2430 (class 2606 OID 33811)
-- Name: modulos fk_padres_modulos; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.modulos
    ADD CONSTRAINT fk_padres_modulos FOREIGN KEY (modulo_padre) REFERENCES seguridad.modulos(modulo_id);


--
-- TOC entry 2656 (class 0 OID 0)
-- Dependencies: 9
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2021-09-16 17:39:13

--
-- PostgreSQL database dump complete
--

