Proyecto BI – MediCare S.A.

Integrantes del grupo
Isaac Elizondo Espinoza
Nicole Víquez Arguedas
Matthew Meneses Pérez
Axel Gabriel Brenes Mena
Joseph Molina Chavarría

Descripción del problema:
MediCare S.A. es una clínica privada costarricense con presencia en varias provincias del Gran Área Metropolitana: San José, Heredia, Alajuela y Cartago. Cada sede opera con su propio sistema transaccional, lo que genera fragmentación en los datos operativos y financieros.

Esta situación dificulta:
La consolidación de información en tiempo real
La comparación de desempeño entre sedes
El análisis de rentabilidad por servicios
La identificación de patrones de cancelación y no-show
El análisis del comportamiento de aseguradoras y pacientes

Como resultado, la gerencia no cuenta con una visión integrada del negocio que permita tomar decisiones estratégicas basadas en datos.
El objetivo de este proyecto es desarrollar una solución de Inteligencia de Negocios (BI) que centralice la información, permita el análisis de indicadores clave y facilite la toma de decisiones.

Arquitectura de la solución

La solución implementa una arquitectura de BI compuesta por tres capas principales:

Capa de integración de datos (ETL)
Se utiliza EasyMorph para extraer, transformar y cargar los datos provenientes de las distintas fuentes. En esta etapa se realiza la limpieza, normalización y enriquecimiento de la información.
Capa de almacenamiento
Se utiliza PostgreSQL como sistema gestor de base de datos para implementar un Data Warehouse basado en un modelo dimensional (tablas de hechos y dimensiones).
Capa de visualización
Se utiliza Microsoft Power BI para construir dashboards interactivos que permiten analizar los indicadores clave del negocio.

Herramientas utilizadas
EasyMorph
PostgreSQL
Microsoft Power BI
Git y GitHub para control de versiones

Instrucciones de ejecución:
Clonar el repositorio, git clone https://github.com/ByAx3l/ProyectoBI.git
cd ProyectoBI

Configurar la base de datos
Instalar PostgreSQL
Crear una base de datos nueva
Ejecutar los scripts SQL incluidos en el repositorio para crear las tablas del modelo dimensional

Ejecutar procesos ETL
Abrir los flujos en EasyMorph
Configurar la conexión a la base de datos
Ejecutar los procesos de carga de datos hacia el Data Warehouse

Estructura del repositorio:
ProyectoBI/
│
├── README.md/ Archivo readme para la comprension del proyecto.
├── Base/ Scripts SQL para la creación del Data Warehouse
├── Visualizaciones/ Visualizaciones hechas en Power BI
├── Raw/ Datos fuente originales sin procesar
├── Profiled/ Datos analizados para identificar calidad, estructura y anomalías
├── Validated/ Datos limpios y validados listos para integración
├── Integracion_Analitica/ Datos integrados y transformados para el modelo analítico
├── Dimensiones/ Construccion de tablas dimensionales con datos finales
├── FactAtencionClinica/ Datos correspondientes a la tabla de hechos principal del modelo
└── README.md Documento principal

(Cada carpeta concerniente al ETL tiene tanto sus .morph con el proceso como sus respectivos .dset como resultados de dicha ejecucion.
