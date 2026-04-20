--
-- PostgreSQL database dump
--

\restrict 8Z1yXgHiYvAxiScYpI4bemORElKOYbJowGrx9n4lSTpwJcapHiJGXBmiEeSBcIM

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-04-12 23:19:07

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 16720)
-- Name: aseguradora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aseguradora (
    id_aseguradora integer NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo_cobertura character varying(100) NOT NULL,
    origen character varying(50) NOT NULL,
    CONSTRAINT aseguradora_origen_check CHECK (((origen)::text = ANY ((ARRAY['Nacional'::character varying, 'Internacional'::character varying])::text[])))
);


ALTER TABLE public.aseguradora OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16719)
-- Name: aseguradora_id_aseguradora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aseguradora_id_aseguradora_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aseguradora_id_aseguradora_seq OWNER TO postgres;

--
-- TOC entry 5249 (class 0 OID 0)
-- Dependencies: 229
-- Name: aseguradora_id_aseguradora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aseguradora_id_aseguradora_seq OWNED BY public.aseguradora.id_aseguradora;


--
-- TOC entry 242 (class 1259 OID 16811)
-- Name: cita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cita (
    id_cita integer NOT NULL,
    fecha date NOT NULL,
    hora_programada time without time zone,
    id_paciente integer NOT NULL,
    id_medico integer NOT NULL,
    id_sede integer NOT NULL,
    id_servicio integer NOT NULL,
    id_estado integer NOT NULL,
    id_franja integer NOT NULL,
    id_cita_origen integer,
    observaciones character varying(255),
    CONSTRAINT cita_check CHECK (((id_cita_origen IS NULL) OR (id_cita_origen <> id_cita)))
);


ALTER TABLE public.cita OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16810)
-- Name: cita_id_cita_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cita_id_cita_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cita_id_cita_seq OWNER TO postgres;

--
-- TOC entry 5250 (class 0 OID 0)
-- Dependencies: 241
-- Name: cita_id_cita_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cita_id_cita_seq OWNED BY public.cita.id_cita;


--
-- TOC entry 248 (class 1259 OID 16945)
-- Name: detalle_factura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_factura (
    id_detalle_factura integer NOT NULL,
    id_factura integer NOT NULL,
    id_procedimiento integer,
    id_cita integer,
    id_servicio integer NOT NULL,
    cantidad integer DEFAULT 1 NOT NULL,
    precio_unitario numeric(12,2) NOT NULL,
    subtotal_linea numeric(12,2) NOT NULL,
    CONSTRAINT detalle_factura_cantidad_check CHECK ((cantidad > 0)),
    CONSTRAINT detalle_factura_check CHECK ((((id_procedimiento IS NOT NULL) AND (id_cita IS NULL)) OR ((id_procedimiento IS NULL) AND (id_cita IS NOT NULL)))),
    CONSTRAINT detalle_factura_check1 CHECK ((subtotal_linea = ((cantidad)::numeric * precio_unitario))),
    CONSTRAINT detalle_factura_precio_unitario_check CHECK ((precio_unitario >= (0)::numeric)),
    CONSTRAINT detalle_factura_subtotal_linea_check CHECK ((subtotal_linea >= (0)::numeric))
);


ALTER TABLE public.detalle_factura OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16944)
-- Name: detalle_factura_id_detalle_factura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalle_factura_id_detalle_factura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_factura_id_detalle_factura_seq OWNER TO postgres;

--
-- TOC entry 5251 (class 0 OID 0)
-- Dependencies: 247
-- Name: detalle_factura_id_detalle_factura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalle_factura_id_detalle_factura_seq OWNED BY public.detalle_factura.id_detalle_factura;


--
-- TOC entry 222 (class 1259 OID 16654)
-- Name: especialidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.especialidad (
    id_especialidad integer NOT NULL,
    nombre character varying(100) NOT NULL,
    area_clinica character varying(100) NOT NULL
);


ALTER TABLE public.especialidad OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16653)
-- Name: especialidad_id_especialidad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.especialidad_id_especialidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.especialidad_id_especialidad_seq OWNER TO postgres;

--
-- TOC entry 5252 (class 0 OID 0)
-- Dependencies: 221
-- Name: especialidad_id_especialidad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.especialidad_id_especialidad_seq OWNED BY public.especialidad.id_especialidad;


--
-- TOC entry 238 (class 1259 OID 16784)
-- Name: estado_cita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado_cita (
    id_estado integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.estado_cita OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16783)
-- Name: estado_cita_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_cita_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estado_cita_id_estado_seq OWNER TO postgres;

--
-- TOC entry 5253 (class 0 OID 0)
-- Dependencies: 237
-- Name: estado_cita_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estado_cita_id_estado_seq OWNED BY public.estado_cita.id_estado;


--
-- TOC entry 246 (class 1259 OID 16908)
-- Name: factura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factura (
    id_factura integer NOT NULL,
    numero_factura character varying(30) NOT NULL,
    fecha date NOT NULL,
    id_paciente integer NOT NULL,
    id_aseguradora integer,
    id_forma_pago integer NOT NULL,
    subtotal numeric(12,2) NOT NULL,
    impuesto numeric(12,2) DEFAULT 0 NOT NULL,
    total numeric(12,2) NOT NULL,
    CONSTRAINT factura_check CHECK ((total = (subtotal + impuesto))),
    CONSTRAINT factura_impuesto_check CHECK ((impuesto >= (0)::numeric)),
    CONSTRAINT factura_subtotal_check CHECK ((subtotal >= (0)::numeric)),
    CONSTRAINT factura_total_check CHECK ((total >= (0)::numeric))
);


ALTER TABLE public.factura OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16907)
-- Name: factura_id_factura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.factura_id_factura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.factura_id_factura_seq OWNER TO postgres;

--
-- TOC entry 5254 (class 0 OID 0)
-- Dependencies: 245
-- Name: factura_id_factura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.factura_id_factura_seq OWNED BY public.factura.id_factura;


--
-- TOC entry 232 (class 1259 OID 16734)
-- Name: forma_pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forma_pago (
    id_forma_pago integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.forma_pago OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16733)
-- Name: forma_pago_id_forma_pago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forma_pago_id_forma_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.forma_pago_id_forma_pago_seq OWNER TO postgres;

--
-- TOC entry 5255 (class 0 OID 0)
-- Dependencies: 231
-- Name: forma_pago_id_forma_pago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forma_pago_id_forma_pago_seq OWNED BY public.forma_pago.id_forma_pago;


--
-- TOC entry 240 (class 1259 OID 16795)
-- Name: franja_horaria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.franja_horaria (
    id_franja integer NOT NULL,
    descripcion character varying(50) NOT NULL,
    dia_semana character varying(20) NOT NULL,
    hora_inicio time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    CONSTRAINT franja_horaria_check CHECK ((hora_inicio < hora_fin)),
    CONSTRAINT franja_horaria_dia_semana_check CHECK (((dia_semana)::text = ANY ((ARRAY['Lunes'::character varying, 'Martes'::character varying, 'Miércoles'::character varying, 'Jueves'::character varying, 'Viernes'::character varying, 'Sábado'::character varying, 'Domingo'::character varying])::text[])))
);


ALTER TABLE public.franja_horaria OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16794)
-- Name: franja_horaria_id_franja_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.franja_horaria_id_franja_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.franja_horaria_id_franja_seq OWNER TO postgres;

--
-- TOC entry 5256 (class 0 OID 0)
-- Dependencies: 239
-- Name: franja_horaria_id_franja_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.franja_horaria_id_franja_seq OWNED BY public.franja_horaria.id_franja;


--
-- TOC entry 224 (class 1259 OID 16666)
-- Name: medico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medico (
    id_medico integer NOT NULL,
    nombre character varying(100) NOT NULL,
    id_especialidad integer NOT NULL,
    id_sede integer NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.medico OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16665)
-- Name: medico_id_medico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medico_id_medico_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medico_id_medico_seq OWNER TO postgres;

--
-- TOC entry 5257 (class 0 OID 0)
-- Dependencies: 223
-- Name: medico_id_medico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medico_id_medico_seq OWNED BY public.medico.id_medico;


--
-- TOC entry 228 (class 1259 OID 16702)
-- Name: paciente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paciente (
    id_paciente integer NOT NULL,
    edad integer NOT NULL,
    sexo character varying(20) NOT NULL,
    id_tipo_cliente integer NOT NULL,
    CONSTRAINT paciente_edad_check CHECK (((edad >= 0) AND (edad <= 120))),
    CONSTRAINT paciente_sexo_check CHECK (((sexo)::text = ANY ((ARRAY['Masculino'::character varying, 'Femenino'::character varying, 'Otro'::character varying])::text[])))
);


ALTER TABLE public.paciente OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16701)
-- Name: paciente_id_paciente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paciente_id_paciente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paciente_id_paciente_seq OWNER TO postgres;

--
-- TOC entry 5258 (class 0 OID 0)
-- Dependencies: 227
-- Name: paciente_id_paciente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paciente_id_paciente_seq OWNED BY public.paciente.id_paciente;


--
-- TOC entry 244 (class 1259 OID 16862)
-- Name: procedimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.procedimiento (
    id_procedimiento integer NOT NULL,
    fecha date NOT NULL,
    id_cita integer,
    id_paciente integer NOT NULL,
    id_medico integer NOT NULL,
    id_sede integer NOT NULL,
    id_servicio integer NOT NULL,
    id_aseguradora integer,
    cantidad integer DEFAULT 1 NOT NULL,
    observaciones character varying(255),
    CONSTRAINT procedimiento_cantidad_check CHECK ((cantidad > 0))
);


ALTER TABLE public.procedimiento OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16861)
-- Name: procedimiento_id_procedimiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.procedimiento_id_procedimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.procedimiento_id_procedimiento_seq OWNER TO postgres;

--
-- TOC entry 5259 (class 0 OID 0)
-- Dependencies: 243
-- Name: procedimiento_id_procedimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.procedimiento_id_procedimiento_seq OWNED BY public.procedimiento.id_procedimiento;


--
-- TOC entry 220 (class 1259 OID 16640)
-- Name: sede; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sede (
    id_sede integer NOT NULL,
    nombre character varying(100) NOT NULL,
    provincia character varying(50) NOT NULL,
    region character varying(50) NOT NULL,
    tipo_sede character varying(50) NOT NULL
);


ALTER TABLE public.sede OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16639)
-- Name: sede_id_sede_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sede_id_sede_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sede_id_sede_seq OWNER TO postgres;

--
-- TOC entry 5260 (class 0 OID 0)
-- Dependencies: 219
-- Name: sede_id_sede_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sede_id_sede_seq OWNED BY public.sede.id_sede;


--
-- TOC entry 236 (class 1259 OID 16756)
-- Name: servicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servicio (
    id_servicio integer NOT NULL,
    nombre character varying(100) NOT NULL,
    id_tipo_servicio integer NOT NULL,
    id_especialidad integer NOT NULL,
    tarifa_referencia numeric(12,2) NOT NULL,
    costo_referencia numeric(12,2),
    activo boolean DEFAULT true NOT NULL,
    CONSTRAINT servicio_costo_referencia_check CHECK ((costo_referencia >= (0)::numeric)),
    CONSTRAINT servicio_tarifa_referencia_check CHECK ((tarifa_referencia >= (0)::numeric))
);


ALTER TABLE public.servicio OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16755)
-- Name: servicio_id_servicio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servicio_id_servicio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.servicio_id_servicio_seq OWNER TO postgres;

--
-- TOC entry 5261 (class 0 OID 0)
-- Dependencies: 235
-- Name: servicio_id_servicio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servicio_id_servicio_seq OWNED BY public.servicio.id_servicio;


--
-- TOC entry 226 (class 1259 OID 16691)
-- Name: tipo_cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_cliente (
    id_tipo_cliente integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.tipo_cliente OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16690)
-- Name: tipo_cliente_id_tipo_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_cliente_id_tipo_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipo_cliente_id_tipo_cliente_seq OWNER TO postgres;

--
-- TOC entry 5262 (class 0 OID 0)
-- Dependencies: 225
-- Name: tipo_cliente_id_tipo_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_cliente_id_tipo_cliente_seq OWNED BY public.tipo_cliente.id_tipo_cliente;


--
-- TOC entry 234 (class 1259 OID 16745)
-- Name: tipo_servicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_servicio (
    id_tipo_servicio integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE public.tipo_servicio OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16744)
-- Name: tipo_servicio_id_tipo_servicio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_servicio_id_tipo_servicio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipo_servicio_id_tipo_servicio_seq OWNER TO postgres;

--
-- TOC entry 5263 (class 0 OID 0)
-- Dependencies: 233
-- Name: tipo_servicio_id_tipo_servicio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_servicio_id_tipo_servicio_seq OWNED BY public.tipo_servicio.id_tipo_servicio;


--
-- TOC entry 4932 (class 2604 OID 16723)
-- Name: aseguradora id_aseguradora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aseguradora ALTER COLUMN id_aseguradora SET DEFAULT nextval('public.aseguradora_id_aseguradora_seq'::regclass);


--
-- TOC entry 4939 (class 2604 OID 16814)
-- Name: cita id_cita; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita ALTER COLUMN id_cita SET DEFAULT nextval('public.cita_id_cita_seq'::regclass);


--
-- TOC entry 4944 (class 2604 OID 16948)
-- Name: detalle_factura id_detalle_factura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura ALTER COLUMN id_detalle_factura SET DEFAULT nextval('public.detalle_factura_id_detalle_factura_seq'::regclass);


--
-- TOC entry 4927 (class 2604 OID 16657)
-- Name: especialidad id_especialidad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidad ALTER COLUMN id_especialidad SET DEFAULT nextval('public.especialidad_id_especialidad_seq'::regclass);


--
-- TOC entry 4937 (class 2604 OID 16787)
-- Name: estado_cita id_estado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_cita ALTER COLUMN id_estado SET DEFAULT nextval('public.estado_cita_id_estado_seq'::regclass);


--
-- TOC entry 4942 (class 2604 OID 16911)
-- Name: factura id_factura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura ALTER COLUMN id_factura SET DEFAULT nextval('public.factura_id_factura_seq'::regclass);


--
-- TOC entry 4933 (class 2604 OID 16737)
-- Name: forma_pago id_forma_pago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pago ALTER COLUMN id_forma_pago SET DEFAULT nextval('public.forma_pago_id_forma_pago_seq'::regclass);


--
-- TOC entry 4938 (class 2604 OID 16798)
-- Name: franja_horaria id_franja; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.franja_horaria ALTER COLUMN id_franja SET DEFAULT nextval('public.franja_horaria_id_franja_seq'::regclass);


--
-- TOC entry 4928 (class 2604 OID 16669)
-- Name: medico id_medico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medico ALTER COLUMN id_medico SET DEFAULT nextval('public.medico_id_medico_seq'::regclass);


--
-- TOC entry 4931 (class 2604 OID 16705)
-- Name: paciente id_paciente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paciente ALTER COLUMN id_paciente SET DEFAULT nextval('public.paciente_id_paciente_seq'::regclass);


--
-- TOC entry 4940 (class 2604 OID 16865)
-- Name: procedimiento id_procedimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedimiento ALTER COLUMN id_procedimiento SET DEFAULT nextval('public.procedimiento_id_procedimiento_seq'::regclass);


--
-- TOC entry 4926 (class 2604 OID 16643)
-- Name: sede id_sede; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sede ALTER COLUMN id_sede SET DEFAULT nextval('public.sede_id_sede_seq'::regclass);


--
-- TOC entry 4935 (class 2604 OID 16759)
-- Name: servicio id_servicio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicio ALTER COLUMN id_servicio SET DEFAULT nextval('public.servicio_id_servicio_seq'::regclass);


--
-- TOC entry 4930 (class 2604 OID 16694)
-- Name: tipo_cliente id_tipo_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_cliente ALTER COLUMN id_tipo_cliente SET DEFAULT nextval('public.tipo_cliente_id_tipo_cliente_seq'::regclass);


--
-- TOC entry 4934 (class 2604 OID 16748)
-- Name: tipo_servicio id_tipo_servicio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_servicio ALTER COLUMN id_tipo_servicio SET DEFAULT nextval('public.tipo_servicio_id_tipo_servicio_seq'::regclass);


--
-- TOC entry 5225 (class 0 OID 16720)
-- Dependencies: 230
-- Data for Name: aseguradora; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.aseguradora VALUES (1, 'INS Salud', 'Cobertura parcial', 'Nacional');
INSERT INTO public.aseguradora VALUES (2, 'BlueCross CR', 'Cobertura total', 'Internacional');
INSERT INTO public.aseguradora VALUES (3, 'MediPlus', 'Cobertura parcial', 'Nacional');
INSERT INTO public.aseguradora VALUES (4, 'Salud Premium', 'Cobertura total', 'Internacional');


--
-- TOC entry 5237 (class 0 OID 16811)
-- Dependencies: 242
-- Data for Name: cita; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cita VALUES (1, '2024-01-08', '08:00:00', 1, 1, 1, 1, 1, 1, NULL, 'Consulta atendida');
INSERT INTO public.cita VALUES (2, '2024-01-08', '10:30:00', 2, 1, 1, 2, 1, 1, NULL, 'ECG realizado');
INSERT INTO public.cita VALUES (3, '2024-01-09', '09:00:00', 3, 2, 2, 3, 2, 4, NULL, 'Paciente canceló');
INSERT INTO public.cita VALUES (4, '2024-01-10', '14:00:00', 4, 3, 1, 4, 1, 9, NULL, 'Control atendido');
INSERT INTO public.cita VALUES (5, '2024-01-10', '15:00:00', 5, 2, 2, 3, 4, 9, NULL, 'No-show');
INSERT INTO public.cita VALUES (6, '2024-01-11', '11:00:00', 6, 5, 4, 7, 3, 10, NULL, 'Reprogramada');
INSERT INTO public.cita VALUES (7, '2024-01-15', '11:00:00', 6, 5, 4, 7, 1, 13, 6, 'Cita reprogramada y atendida');
INSERT INTO public.cita VALUES (8, '2024-01-16', '13:00:00', 7, 6, 1, 8, 1, 14, NULL, 'Valoración ortopédica');
INSERT INTO public.cita VALUES (9, '2024-01-17', '08:30:00', 8, 4, 3, 6, 1, 7, NULL, 'Consulta dermatológica');
INSERT INTO public.cita VALUES (10, '2024-01-18', '12:30:00', 1, 3, 1, 5, 1, 11, NULL, 'Ultrasonido atendido');


--
-- TOC entry 5243 (class 0 OID 16945)
-- Dependencies: 248
-- Data for Name: detalle_factura; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.detalle_factura VALUES (1, 1, 1, NULL, 2, 1, 35000.00, 35000.00);
INSERT INTO public.detalle_factura VALUES (2, 2, 2, NULL, 4, 1, 45000.00, 45000.00);
INSERT INTO public.detalle_factura VALUES (3, 3, 3, NULL, 7, 1, 30000.00, 30000.00);
INSERT INTO public.detalle_factura VALUES (4, 4, 4, NULL, 8, 1, 50000.00, 50000.00);
INSERT INTO public.detalle_factura VALUES (5, 5, 6, NULL, 6, 1, 42000.00, 42000.00);
INSERT INTO public.detalle_factura VALUES (6, 6, 5, NULL, 5, 1, 60000.00, 60000.00);
INSERT INTO public.detalle_factura VALUES (7, 7, 7, NULL, 9, 1, 75000.00, 75000.00);


--
-- TOC entry 5217 (class 0 OID 16654)
-- Dependencies: 222
-- Data for Name: especialidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.especialidad VALUES (1, 'Cardiología', 'Medicina interna');
INSERT INTO public.especialidad VALUES (2, 'Pediatría', 'Medicina general');
INSERT INTO public.especialidad VALUES (3, 'Ginecología', 'Salud femenina');
INSERT INTO public.especialidad VALUES (4, 'Dermatología', 'Consulta externa');
INSERT INTO public.especialidad VALUES (5, 'Radiología', 'Diagnóstico');
INSERT INTO public.especialidad VALUES (6, 'Ortopedia', 'Especialidades quirúrgicas');


--
-- TOC entry 5233 (class 0 OID 16784)
-- Dependencies: 238
-- Data for Name: estado_cita; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.estado_cita VALUES (1, 'Atendida');
INSERT INTO public.estado_cita VALUES (2, 'Cancelada');
INSERT INTO public.estado_cita VALUES (3, 'Reprogramada');
INSERT INTO public.estado_cita VALUES (4, 'No-show');


--
-- TOC entry 5241 (class 0 OID 16908)
-- Dependencies: 246
-- Data for Name: factura; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.factura VALUES (1, 'FAC-2024-0001', '2024-01-08', 2, 1, 1, 35000.00, 0.00, 35000.00);
INSERT INTO public.factura VALUES (2, 'FAC-2024-0002', '2024-01-10', 4, 2, 1, 45000.00, 0.00, 45000.00);
INSERT INTO public.factura VALUES (3, 'FAC-2024-0003', '2024-01-15', 6, 3, 1, 30000.00, 0.00, 30000.00);
INSERT INTO public.factura VALUES (4, 'FAC-2024-0004', '2024-01-16', 7, NULL, 2, 50000.00, 6500.00, 56500.00);
INSERT INTO public.factura VALUES (5, 'FAC-2024-0005', '2024-01-17', 8, NULL, 3, 42000.00, 5460.00, 47460.00);
INSERT INTO public.factura VALUES (6, 'FAC-2024-0006', '2024-01-18', 1, 4, 1, 60000.00, 0.00, 60000.00);
INSERT INTO public.factura VALUES (7, 'FAC-2024-0007', '2024-01-20', 7, 1, 1, 75000.00, 0.00, 75000.00);


--
-- TOC entry 5227 (class 0 OID 16734)
-- Dependencies: 232
-- Data for Name: forma_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.forma_pago VALUES (1, 'Aseguradora');
INSERT INTO public.forma_pago VALUES (2, 'Tarjeta de crédito');
INSERT INTO public.forma_pago VALUES (3, 'Tarjeta de débito');
INSERT INTO public.forma_pago VALUES (4, 'Efectivo');


--
-- TOC entry 5235 (class 0 OID 16795)
-- Dependencies: 240
-- Data for Name: franja_horaria; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.franja_horaria VALUES (1, 'Mañana', 'Lunes', '07:00:00', '11:59:00');
INSERT INTO public.franja_horaria VALUES (2, 'Medio día', 'Lunes', '12:00:00', '13:59:00');
INSERT INTO public.franja_horaria VALUES (3, 'Tarde', 'Lunes', '14:00:00', '18:00:00');
INSERT INTO public.franja_horaria VALUES (4, 'Mañana', 'Martes', '07:00:00', '11:59:00');
INSERT INTO public.franja_horaria VALUES (5, 'Medio día', 'Martes', '12:00:00', '13:59:00');
INSERT INTO public.franja_horaria VALUES (6, 'Tarde', 'Martes', '14:00:00', '18:00:00');
INSERT INTO public.franja_horaria VALUES (7, 'Mañana', 'Miércoles', '07:00:00', '11:59:00');
INSERT INTO public.franja_horaria VALUES (8, 'Medio día', 'Miércoles', '12:00:00', '13:59:00');
INSERT INTO public.franja_horaria VALUES (9, 'Tarde', 'Miércoles', '14:00:00', '18:00:00');
INSERT INTO public.franja_horaria VALUES (10, 'Mañana', 'Jueves', '07:00:00', '11:59:00');
INSERT INTO public.franja_horaria VALUES (11, 'Medio día', 'Jueves', '12:00:00', '13:59:00');
INSERT INTO public.franja_horaria VALUES (12, 'Tarde', 'Jueves', '14:00:00', '18:00:00');
INSERT INTO public.franja_horaria VALUES (13, 'Mañana', 'Viernes', '07:00:00', '11:59:00');
INSERT INTO public.franja_horaria VALUES (14, 'Medio día', 'Viernes', '12:00:00', '13:59:00');
INSERT INTO public.franja_horaria VALUES (15, 'Tarde', 'Viernes', '14:00:00', '18:00:00');


--
-- TOC entry 5219 (class 0 OID 16666)
-- Dependencies: 224
-- Data for Name: medico; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.medico VALUES (1, 'Dr. Andrés Mora', 1, 1, true);
INSERT INTO public.medico VALUES (2, 'Dra. Valeria Quesada', 2, 2, true);
INSERT INTO public.medico VALUES (3, 'Dra. Sofía Brenes', 3, 1, true);
INSERT INTO public.medico VALUES (4, 'Dr. Luis Chaves', 4, 3, true);
INSERT INTO public.medico VALUES (5, 'Dr. Pablo Araya', 5, 4, true);
INSERT INTO public.medico VALUES (6, 'Dr. Diego Solano', 6, 1, true);


--
-- TOC entry 5223 (class 0 OID 16702)
-- Dependencies: 228
-- Data for Name: paciente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.paciente VALUES (1, 34, 'Femenino', 2);
INSERT INTO public.paciente VALUES (2, 45, 'Masculino', 2);
INSERT INTO public.paciente VALUES (3, 29, 'Femenino', 1);
INSERT INTO public.paciente VALUES (4, 52, 'Masculino', 2);
INSERT INTO public.paciente VALUES (5, 8, 'Otro', 1);
INSERT INTO public.paciente VALUES (6, 61, 'Femenino', 3);
INSERT INTO public.paciente VALUES (7, 39, 'Masculino', 2);
INSERT INTO public.paciente VALUES (8, 26, 'Femenino', 1);


--
-- TOC entry 5239 (class 0 OID 16862)
-- Dependencies: 244
-- Data for Name: procedimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.procedimiento VALUES (1, '2024-01-08', 2, 2, 1, 1, 2, 1, 1, 'ECG completado');
INSERT INTO public.procedimiento VALUES (2, '2024-01-10', 4, 4, 3, 1, 4, 2, 1, 'Control ginecológico');
INSERT INTO public.procedimiento VALUES (3, '2024-01-15', 7, 6, 5, 4, 7, 3, 1, 'Radiografía realizada');
INSERT INTO public.procedimiento VALUES (4, '2024-01-16', 8, 7, 6, 1, 8, NULL, 1, 'Valoración privada');
INSERT INTO public.procedimiento VALUES (5, '2024-01-18', 10, 1, 3, 1, 5, 4, 1, 'Ultrasonido ginecológico');
INSERT INTO public.procedimiento VALUES (6, '2024-01-17', 9, 8, 4, 3, 6, NULL, 1, 'Consulta dermatológica');
INSERT INTO public.procedimiento VALUES (7, '2024-01-20', NULL, 7, 6, 1, 9, 1, 1, 'Procedimiento sin cita asociada');


--
-- TOC entry 5215 (class 0 OID 16640)
-- Dependencies: 220
-- Data for Name: sede; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sede VALUES (1, 'MediCare San José', 'San José', 'Central', 'Principal');
INSERT INTO public.sede VALUES (2, 'MediCare Heredia', 'Heredia', 'Central', 'Sucursal');
INSERT INTO public.sede VALUES (3, 'MediCare Alajuela', 'Alajuela', 'Central', 'Sucursal');
INSERT INTO public.sede VALUES (4, 'MediCare Cartago', 'Cartago', 'Central', 'Sucursal');


--
-- TOC entry 5231 (class 0 OID 16756)
-- Dependencies: 236
-- Data for Name: servicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.servicio VALUES (1, 'Consulta cardiológica', 1, 1, 55000.00, 25000.00, true);
INSERT INTO public.servicio VALUES (2, 'Electrocardiograma', 4, 1, 35000.00, 15000.00, true);
INSERT INTO public.servicio VALUES (3, 'Consulta pediátrica', 1, 2, 40000.00, 18000.00, true);
INSERT INTO public.servicio VALUES (4, 'Control ginecológico', 1, 3, 45000.00, 20000.00, true);
INSERT INTO public.servicio VALUES (5, 'Ultrasonido ginecológico', 4, 3, 60000.00, 28000.00, true);
INSERT INTO public.servicio VALUES (6, 'Consulta dermatológica', 1, 4, 42000.00, 19000.00, true);
INSERT INTO public.servicio VALUES (7, 'Radiografía simple', 4, 5, 30000.00, 12000.00, true);
INSERT INTO public.servicio VALUES (8, 'Valoración ortopédica', 1, 6, 50000.00, 22000.00, true);
INSERT INTO public.servicio VALUES (9, 'Infiltración articular', 2, 6, 75000.00, 35000.00, true);


--
-- TOC entry 5221 (class 0 OID 16691)
-- Dependencies: 226
-- Data for Name: tipo_cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo_cliente VALUES (1, 'Nuevo');
INSERT INTO public.tipo_cliente VALUES (2, 'Recurrente');
INSERT INTO public.tipo_cliente VALUES (3, 'Corporativo');


--
-- TOC entry 5229 (class 0 OID 16745)
-- Dependencies: 234
-- Data for Name: tipo_servicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo_servicio VALUES (1, 'Consulta');
INSERT INTO public.tipo_servicio VALUES (2, 'Procedimiento');
INSERT INTO public.tipo_servicio VALUES (3, 'Cirugía ambulatoria');
INSERT INTO public.tipo_servicio VALUES (4, 'Diagnóstico');


--
-- TOC entry 5264 (class 0 OID 0)
-- Dependencies: 229
-- Name: aseguradora_id_aseguradora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aseguradora_id_aseguradora_seq', 4, true);


--
-- TOC entry 5265 (class 0 OID 0)
-- Dependencies: 241
-- Name: cita_id_cita_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cita_id_cita_seq', 10, true);


--
-- TOC entry 5266 (class 0 OID 0)
-- Dependencies: 247
-- Name: detalle_factura_id_detalle_factura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_factura_id_detalle_factura_seq', 7, true);


--
-- TOC entry 5267 (class 0 OID 0)
-- Dependencies: 221
-- Name: especialidad_id_especialidad_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.especialidad_id_especialidad_seq', 6, true);


--
-- TOC entry 5268 (class 0 OID 0)
-- Dependencies: 237
-- Name: estado_cita_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estado_cita_id_estado_seq', 4, true);


--
-- TOC entry 5269 (class 0 OID 0)
-- Dependencies: 245
-- Name: factura_id_factura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.factura_id_factura_seq', 7, true);


--
-- TOC entry 5270 (class 0 OID 0)
-- Dependencies: 231
-- Name: forma_pago_id_forma_pago_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forma_pago_id_forma_pago_seq', 4, true);


--
-- TOC entry 5271 (class 0 OID 0)
-- Dependencies: 239
-- Name: franja_horaria_id_franja_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.franja_horaria_id_franja_seq', 15, true);


--
-- TOC entry 5272 (class 0 OID 0)
-- Dependencies: 223
-- Name: medico_id_medico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medico_id_medico_seq', 6, true);


--
-- TOC entry 5273 (class 0 OID 0)
-- Dependencies: 227
-- Name: paciente_id_paciente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paciente_id_paciente_seq', 8, true);


--
-- TOC entry 5274 (class 0 OID 0)
-- Dependencies: 243
-- Name: procedimiento_id_procedimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.procedimiento_id_procedimiento_seq', 7, true);


--
-- TOC entry 5275 (class 0 OID 0)
-- Dependencies: 219
-- Name: sede_id_sede_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sede_id_sede_seq', 4, true);


--
-- TOC entry 5276 (class 0 OID 0)
-- Dependencies: 235
-- Name: servicio_id_servicio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servicio_id_servicio_seq', 9, true);


--
-- TOC entry 5277 (class 0 OID 0)
-- Dependencies: 225
-- Name: tipo_cliente_id_tipo_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_cliente_id_tipo_cliente_seq', 3, true);


--
-- TOC entry 5278 (class 0 OID 0)
-- Dependencies: 233
-- Name: tipo_servicio_id_tipo_servicio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_servicio_id_tipo_servicio_seq', 4, true);


--
-- TOC entry 4985 (class 2606 OID 16732)
-- Name: aseguradora aseguradora_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aseguradora
    ADD CONSTRAINT aseguradora_nombre_key UNIQUE (nombre);


--
-- TOC entry 4987 (class 2606 OID 16730)
-- Name: aseguradora aseguradora_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aseguradora
    ADD CONSTRAINT aseguradora_pkey PRIMARY KEY (id_aseguradora);


--
-- TOC entry 5011 (class 2606 OID 16825)
-- Name: cita cita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_pkey PRIMARY KEY (id_cita);


--
-- TOC entry 5037 (class 2606 OID 16962)
-- Name: detalle_factura detalle_factura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura
    ADD CONSTRAINT detalle_factura_pkey PRIMARY KEY (id_detalle_factura);


--
-- TOC entry 4969 (class 2606 OID 16664)
-- Name: especialidad especialidad_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidad
    ADD CONSTRAINT especialidad_nombre_key UNIQUE (nombre);


--
-- TOC entry 4971 (class 2606 OID 16662)
-- Name: especialidad especialidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especialidad
    ADD CONSTRAINT especialidad_pkey PRIMARY KEY (id_especialidad);


--
-- TOC entry 5003 (class 2606 OID 16793)
-- Name: estado_cita estado_cita_descripcion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_cita
    ADD CONSTRAINT estado_cita_descripcion_key UNIQUE (descripcion);


--
-- TOC entry 5005 (class 2606 OID 16791)
-- Name: estado_cita estado_cita_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado_cita
    ADD CONSTRAINT estado_cita_pkey PRIMARY KEY (id_estado);


--
-- TOC entry 5029 (class 2606 OID 16928)
-- Name: factura factura_numero_factura_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_numero_factura_key UNIQUE (numero_factura);


--
-- TOC entry 5031 (class 2606 OID 16926)
-- Name: factura factura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_pkey PRIMARY KEY (id_factura);


--
-- TOC entry 4989 (class 2606 OID 16743)
-- Name: forma_pago forma_pago_descripcion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pago
    ADD CONSTRAINT forma_pago_descripcion_key UNIQUE (descripcion);


--
-- TOC entry 4991 (class 2606 OID 16741)
-- Name: forma_pago forma_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pago
    ADD CONSTRAINT forma_pago_pkey PRIMARY KEY (id_forma_pago);


--
-- TOC entry 5007 (class 2606 OID 16809)
-- Name: franja_horaria franja_horaria_descripcion_dia_semana_hora_inicio_hora_fin_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.franja_horaria
    ADD CONSTRAINT franja_horaria_descripcion_dia_semana_hora_inicio_hora_fin_key UNIQUE (descripcion, dia_semana, hora_inicio, hora_fin);


--
-- TOC entry 5009 (class 2606 OID 16807)
-- Name: franja_horaria franja_horaria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.franja_horaria
    ADD CONSTRAINT franja_horaria_pkey PRIMARY KEY (id_franja);


--
-- TOC entry 4975 (class 2606 OID 16679)
-- Name: medico medico_nombre_id_especialidad_id_sede_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medico
    ADD CONSTRAINT medico_nombre_id_especialidad_id_sede_key UNIQUE (nombre, id_especialidad, id_sede);


--
-- TOC entry 4977 (class 2606 OID 16677)
-- Name: medico medico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medico
    ADD CONSTRAINT medico_pkey PRIMARY KEY (id_medico);


--
-- TOC entry 4983 (class 2606 OID 16713)
-- Name: paciente paciente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (id_paciente);


--
-- TOC entry 5027 (class 2606 OID 16876)
-- Name: procedimiento procedimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedimiento
    ADD CONSTRAINT procedimiento_pkey PRIMARY KEY (id_procedimiento);


--
-- TOC entry 4965 (class 2606 OID 16652)
-- Name: sede sede_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sede
    ADD CONSTRAINT sede_nombre_key UNIQUE (nombre);


--
-- TOC entry 4967 (class 2606 OID 16650)
-- Name: sede sede_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sede
    ADD CONSTRAINT sede_pkey PRIMARY KEY (id_sede);


--
-- TOC entry 4999 (class 2606 OID 16772)
-- Name: servicio servicio_nombre_id_especialidad_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicio
    ADD CONSTRAINT servicio_nombre_id_especialidad_key UNIQUE (nombre, id_especialidad);


--
-- TOC entry 5001 (class 2606 OID 16770)
-- Name: servicio servicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicio
    ADD CONSTRAINT servicio_pkey PRIMARY KEY (id_servicio);


--
-- TOC entry 4979 (class 2606 OID 16700)
-- Name: tipo_cliente tipo_cliente_descripcion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_cliente
    ADD CONSTRAINT tipo_cliente_descripcion_key UNIQUE (descripcion);


--
-- TOC entry 4981 (class 2606 OID 16698)
-- Name: tipo_cliente tipo_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_cliente
    ADD CONSTRAINT tipo_cliente_pkey PRIMARY KEY (id_tipo_cliente);


--
-- TOC entry 4993 (class 2606 OID 16754)
-- Name: tipo_servicio tipo_servicio_descripcion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_servicio
    ADD CONSTRAINT tipo_servicio_descripcion_key UNIQUE (descripcion);


--
-- TOC entry 4995 (class 2606 OID 16752)
-- Name: tipo_servicio tipo_servicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_servicio
    ADD CONSTRAINT tipo_servicio_pkey PRIMARY KEY (id_tipo_servicio);


--
-- TOC entry 5012 (class 1259 OID 16991)
-- Name: idx_cita_estado; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cita_estado ON public.cita USING btree (id_estado);


--
-- TOC entry 5013 (class 1259 OID 16987)
-- Name: idx_cita_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cita_fecha ON public.cita USING btree (fecha);


--
-- TOC entry 5014 (class 1259 OID 16992)
-- Name: idx_cita_franja; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cita_franja ON public.cita USING btree (id_franja);


--
-- TOC entry 5015 (class 1259 OID 16989)
-- Name: idx_cita_medico; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cita_medico ON public.cita USING btree (id_medico);


--
-- TOC entry 5016 (class 1259 OID 16988)
-- Name: idx_cita_paciente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cita_paciente ON public.cita USING btree (id_paciente);


--
-- TOC entry 5017 (class 1259 OID 16990)
-- Name: idx_cita_sede; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cita_sede ON public.cita USING btree (id_sede);


--
-- TOC entry 5018 (class 1259 OID 16993)
-- Name: idx_cita_servicio; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cita_servicio ON public.cita USING btree (id_servicio);


--
-- TOC entry 5038 (class 1259 OID 17007)
-- Name: idx_detalle_factura_cita; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_detalle_factura_cita ON public.detalle_factura USING btree (id_cita);


--
-- TOC entry 5039 (class 1259 OID 17005)
-- Name: idx_detalle_factura_factura; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_detalle_factura_factura ON public.detalle_factura USING btree (id_factura);


--
-- TOC entry 5040 (class 1259 OID 17006)
-- Name: idx_detalle_factura_procedimiento; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_detalle_factura_procedimiento ON public.detalle_factura USING btree (id_procedimiento);


--
-- TOC entry 5041 (class 1259 OID 17008)
-- Name: idx_detalle_factura_servicio; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_detalle_factura_servicio ON public.detalle_factura USING btree (id_servicio);


--
-- TOC entry 5032 (class 1259 OID 17003)
-- Name: idx_factura_aseguradora; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_factura_aseguradora ON public.factura USING btree (id_aseguradora);


--
-- TOC entry 5033 (class 1259 OID 17001)
-- Name: idx_factura_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_factura_fecha ON public.factura USING btree (fecha);


--
-- TOC entry 5034 (class 1259 OID 17004)
-- Name: idx_factura_forma_pago; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_factura_forma_pago ON public.factura USING btree (id_forma_pago);


--
-- TOC entry 5035 (class 1259 OID 17002)
-- Name: idx_factura_paciente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_factura_paciente ON public.factura USING btree (id_paciente);


--
-- TOC entry 4972 (class 1259 OID 16983)
-- Name: idx_medico_especialidad; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_medico_especialidad ON public.medico USING btree (id_especialidad);


--
-- TOC entry 4973 (class 1259 OID 16984)
-- Name: idx_medico_sede; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_medico_sede ON public.medico USING btree (id_sede);


--
-- TOC entry 5019 (class 1259 OID 17000)
-- Name: idx_procedimiento_aseguradora; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_procedimiento_aseguradora ON public.procedimiento USING btree (id_aseguradora);


--
-- TOC entry 5020 (class 1259 OID 16995)
-- Name: idx_procedimiento_cita; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_procedimiento_cita ON public.procedimiento USING btree (id_cita);


--
-- TOC entry 5021 (class 1259 OID 16994)
-- Name: idx_procedimiento_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_procedimiento_fecha ON public.procedimiento USING btree (fecha);


--
-- TOC entry 5022 (class 1259 OID 16997)
-- Name: idx_procedimiento_medico; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_procedimiento_medico ON public.procedimiento USING btree (id_medico);


--
-- TOC entry 5023 (class 1259 OID 16996)
-- Name: idx_procedimiento_paciente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_procedimiento_paciente ON public.procedimiento USING btree (id_paciente);


--
-- TOC entry 5024 (class 1259 OID 16998)
-- Name: idx_procedimiento_sede; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_procedimiento_sede ON public.procedimiento USING btree (id_sede);


--
-- TOC entry 5025 (class 1259 OID 16999)
-- Name: idx_procedimiento_servicio; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_procedimiento_servicio ON public.procedimiento USING btree (id_servicio);


--
-- TOC entry 4996 (class 1259 OID 16986)
-- Name: idx_servicio_especialidad; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_servicio_especialidad ON public.servicio USING btree (id_especialidad);


--
-- TOC entry 4997 (class 1259 OID 16985)
-- Name: idx_servicio_tipo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_servicio_tipo ON public.servicio USING btree (id_tipo_servicio);


--
-- TOC entry 5047 (class 2606 OID 16856)
-- Name: cita cita_id_cita_origen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_id_cita_origen_fkey FOREIGN KEY (id_cita_origen) REFERENCES public.cita(id_cita);


--
-- TOC entry 5048 (class 2606 OID 16846)
-- Name: cita cita_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_id_estado_fkey FOREIGN KEY (id_estado) REFERENCES public.estado_cita(id_estado);


--
-- TOC entry 5049 (class 2606 OID 16851)
-- Name: cita cita_id_franja_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_id_franja_fkey FOREIGN KEY (id_franja) REFERENCES public.franja_horaria(id_franja);


--
-- TOC entry 5050 (class 2606 OID 16831)
-- Name: cita cita_id_medico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_id_medico_fkey FOREIGN KEY (id_medico) REFERENCES public.medico(id_medico);


--
-- TOC entry 5051 (class 2606 OID 16826)
-- Name: cita cita_id_paciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_id_paciente_fkey FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente);


--
-- TOC entry 5052 (class 2606 OID 16836)
-- Name: cita cita_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sede(id_sede);


--
-- TOC entry 5053 (class 2606 OID 16841)
-- Name: cita cita_id_servicio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_id_servicio_fkey FOREIGN KEY (id_servicio) REFERENCES public.servicio(id_servicio);


--
-- TOC entry 5063 (class 2606 OID 16973)
-- Name: detalle_factura detalle_factura_id_cita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura
    ADD CONSTRAINT detalle_factura_id_cita_fkey FOREIGN KEY (id_cita) REFERENCES public.cita(id_cita);


--
-- TOC entry 5064 (class 2606 OID 16963)
-- Name: detalle_factura detalle_factura_id_factura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura
    ADD CONSTRAINT detalle_factura_id_factura_fkey FOREIGN KEY (id_factura) REFERENCES public.factura(id_factura) ON DELETE CASCADE;


--
-- TOC entry 5065 (class 2606 OID 16968)
-- Name: detalle_factura detalle_factura_id_procedimiento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura
    ADD CONSTRAINT detalle_factura_id_procedimiento_fkey FOREIGN KEY (id_procedimiento) REFERENCES public.procedimiento(id_procedimiento);


--
-- TOC entry 5066 (class 2606 OID 16978)
-- Name: detalle_factura detalle_factura_id_servicio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_factura
    ADD CONSTRAINT detalle_factura_id_servicio_fkey FOREIGN KEY (id_servicio) REFERENCES public.servicio(id_servicio);


--
-- TOC entry 5060 (class 2606 OID 16934)
-- Name: factura factura_id_aseguradora_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_id_aseguradora_fkey FOREIGN KEY (id_aseguradora) REFERENCES public.aseguradora(id_aseguradora);


--
-- TOC entry 5061 (class 2606 OID 16939)
-- Name: factura factura_id_forma_pago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_id_forma_pago_fkey FOREIGN KEY (id_forma_pago) REFERENCES public.forma_pago(id_forma_pago);


--
-- TOC entry 5062 (class 2606 OID 16929)
-- Name: factura factura_id_paciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_id_paciente_fkey FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente);


--
-- TOC entry 5042 (class 2606 OID 16680)
-- Name: medico medico_id_especialidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medico
    ADD CONSTRAINT medico_id_especialidad_fkey FOREIGN KEY (id_especialidad) REFERENCES public.especialidad(id_especialidad);


--
-- TOC entry 5043 (class 2606 OID 16685)
-- Name: medico medico_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medico
    ADD CONSTRAINT medico_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sede(id_sede);


--
-- TOC entry 5044 (class 2606 OID 16714)
-- Name: paciente paciente_id_tipo_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_id_tipo_cliente_fkey FOREIGN KEY (id_tipo_cliente) REFERENCES public.tipo_cliente(id_tipo_cliente);


--
-- TOC entry 5054 (class 2606 OID 16902)
-- Name: procedimiento procedimiento_id_aseguradora_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedimiento
    ADD CONSTRAINT procedimiento_id_aseguradora_fkey FOREIGN KEY (id_aseguradora) REFERENCES public.aseguradora(id_aseguradora);


--
-- TOC entry 5055 (class 2606 OID 16877)
-- Name: procedimiento procedimiento_id_cita_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedimiento
    ADD CONSTRAINT procedimiento_id_cita_fkey FOREIGN KEY (id_cita) REFERENCES public.cita(id_cita);


--
-- TOC entry 5056 (class 2606 OID 16887)
-- Name: procedimiento procedimiento_id_medico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedimiento
    ADD CONSTRAINT procedimiento_id_medico_fkey FOREIGN KEY (id_medico) REFERENCES public.medico(id_medico);


--
-- TOC entry 5057 (class 2606 OID 16882)
-- Name: procedimiento procedimiento_id_paciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedimiento
    ADD CONSTRAINT procedimiento_id_paciente_fkey FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente);


--
-- TOC entry 5058 (class 2606 OID 16892)
-- Name: procedimiento procedimiento_id_sede_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedimiento
    ADD CONSTRAINT procedimiento_id_sede_fkey FOREIGN KEY (id_sede) REFERENCES public.sede(id_sede);


--
-- TOC entry 5059 (class 2606 OID 16897)
-- Name: procedimiento procedimiento_id_servicio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedimiento
    ADD CONSTRAINT procedimiento_id_servicio_fkey FOREIGN KEY (id_servicio) REFERENCES public.servicio(id_servicio);


--
-- TOC entry 5045 (class 2606 OID 16778)
-- Name: servicio servicio_id_especialidad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicio
    ADD CONSTRAINT servicio_id_especialidad_fkey FOREIGN KEY (id_especialidad) REFERENCES public.especialidad(id_especialidad);


--
-- TOC entry 5046 (class 2606 OID 16773)
-- Name: servicio servicio_id_tipo_servicio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicio
    ADD CONSTRAINT servicio_id_tipo_servicio_fkey FOREIGN KEY (id_tipo_servicio) REFERENCES public.tipo_servicio(id_tipo_servicio);


-- Completed on 2026-04-12 23:19:07

--
-- PostgreSQL database dump complete
--

\unrestrict 8Z1yXgHiYvAxiScYpI4bemORElKOYbJowGrx9n4lSTpwJcapHiJGXBmiEeSBcIM

