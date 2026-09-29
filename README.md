# Entregable Final - Tecnología de Base de Datos I

# Migración de Base de Datos Employees desde MariaDB hacia PostgreSQL
# Repositorio GitHub

Este repositorio contiene todos los archivos necesarios para reproducir y verificar la migración de la base de datos employees desde MariaDB hacia PostgreSQL.

Incluye:

- Documentación del proceso.
- Scripts de migración.
- Scripts de verificación.
- Modelo físico.
- Backup PostgreSQL.

Repositorio:

https://github.com/Dorian1251/EntregableFinal_TBDI

------------------------------------------------------------------------

# 1. Descripción del proyecto

El presente proyecto documenta el proceso completo de migración de la
base de datos `employees` desde MariaDB hacia PostgreSQL.

La migración fue realizada utilizando la herramienta **pgloader**,
permitiendo transferir la estructura y la información almacenada en
MariaDB hacia una nueva base PostgreSQL.

Durante el proceso se conservaron:

-   Tablas.
-   Registros.
-   Claves primarias.
-   Claves foráneas.
-   Índices.
-   Relaciones entre entidades.

También se realizaron adaptaciones de tipos de datos debido a las
diferencias existentes entre ambos gestores.

------------------------------------------------------------------------

# 2. Objetivo del proyecto

## Objetivo general

Realizar la migración completa de la base de datos `employees` desde
MariaDB hacia PostgreSQL, verificando la integridad de la información y
documentando cada etapa del proceso.

## Objetivos específicos

-   Configurar el entorno mediante Docker.
-   Preparar la base origen MariaDB.
-   Crear la base destino PostgreSQL.
-   Ejecutar la migración con pgloader.
-   Verificar registros migrados.
-   Validar integridad referencial.
-   Crear vistas en PostgreSQL.
-   Generar el modelo físico con PgModeler.

------------------------------------------------------------------------

# 3. Tecnologías utilizadas

## MariaDB 11.8.9

Base de datos origen donde se encontraba la información original.

## PostgreSQL 18.6

Base de datos destino donde se almacenó la información migrada.

## Docker

Utilizado para administrar los contenedores de MariaDB, PostgreSQL,
Adminer y pgAdmin.

## Pgloader

Herramienta utilizada para automatizar la migración entre gestores.

## PgModeler

Herramienta utilizada para generar la representación gráfica del modelo
físico.

------------------------------------------------------------------------

# 4. Arquitectura utilizada

    MariaDB
       |
       |
     pgloader
       |
       |
    PostgreSQL
       |
       |
     PgModeler

MariaDB contiene la base original, pgloader realiza la transferencia y
PostgreSQL almacena el modelo migrado.

------------------------------------------------------------------------

# 5. Estructura del proyecto

    EntregableFinal_TBDI/

    ├── README.md
    ├── Informe_Final.md

    ├── backup/
    │   └── backup_pdb_employees.dump

    ├── modelo/
    │   └── pdb_employees_modelo.sql

    └── scripts/
        ├── migracion.load
        ├── verificaciones.sql
        └── vistas.sql

------------------------------------------------------------------------

# 6. Proceso de migración

## Preparación del entorno

Los servicios fueron levantados mediante Docker:

``` bash
docker compose up -d
```

Servicios utilizados:

-   MariaDB como base origen.
-   PostgreSQL como base destino.
-   Adminer para administración.
-   pgAdmin para PostgreSQL.

------------------------------------------------------------------------

## Análisis de la base origen

Antes de la migración se verificaron:

-   Tablas existentes.
-   Vistas.
-   Tipos de datos.
-   Claves primarias.
-   Claves foráneas.

Base utilizada:

    employees

------------------------------------------------------------------------

## Configuración de pgloader

Archivo:

    scripts/migracion.load

Este archivo define:

-   Conexión origen MariaDB.
-   Conexión destino PostgreSQL.
-   Creación de tablas.
-   Creación de índices.
-   Conversión de tipos.

------------------------------------------------------------------------

## Ejecución de migración

Comando:

``` bash
pgloader migracion.load
```

Resultado:

    3919015 registros migrados correctamente

------------------------------------------------------------------------

# 7. Adaptaciones realizadas

## Conversión ENUM

MariaDB:

``` sql
gender ENUM('M','F')
```

PostgreSQL:

``` sql
gender TEXT
```

Se realizó esta conversión para asegurar compatibilidad durante la
migración.

------------------------------------------------------------------------

## Conversión de tipos numéricos

MariaDB:

    INT(11)

PostgreSQL:

    BIGINT

Permitió conservar correctamente los valores numéricos.

------------------------------------------------------------------------

## Vistas

Las vistas:

    current_dept_emp
    dept_emp_latest_date

fueron recreadas manualmente en PostgreSQL debido a que no fueron
migradas automáticamente.

------------------------------------------------------------------------

# 8. Verificación de la migración

Se realizaron pruebas de validación:

## Tablas migradas

    departments
    dept_emp
    dept_manager
    employees
    salaries
    titles

## Conteo de registros

  Tabla            Registros
  -------------- -----------
  employees           300024
  departments              9
  dept_emp            331603
  dept_manager            24
  salaries           2844047
  titles              443308

------------------------------------------------------------------------

## Integridad referencial

Resultados:

    empleados_sin_departamento = 0

    departamentos_sin_empleados = 0

------------------------------------------------------------------------

## Comparación MariaDB/PostgreSQL

Los registros del origen y destino coincidieron, confirmando que la
migración fue realizada sin pérdida de información.

------------------------------------------------------------------------

# 9. Backup de PostgreSQL

Backup generado:

    backup_pdb_employees.dump

Comando utilizado:

``` bash
pg_dump -F c -d pdb_employees -f backup_pdb_employees.dump
```

------------------------------------------------------------------------

# 10. Modelo físico

El modelo fue generado mediante PgModeler.

Incluye:

-   Entidades.
-   Atributos.
-   Relaciones.
-   Claves primarias.
-   Claves foráneas.

Archivo:

    modelo/pdb_employees_modelo.sql

------------------------------------------------------------------------

# 11. Conclusión

La migración de la base de datos `employees` desde MariaDB hacia
PostgreSQL fue realizada correctamente.

Se logró conservar la información, estructura y relaciones principales
del modelo, además de validar los resultados mediante conteos,
integridad referencial y pruebas de funcionamiento.

El proyecto final contiene los scripts, respaldo y documentación
necesarios para reproducir el proceso de migración.

------------------------------------------------------------------------

# Autor

Dorian

# Asignatura

Tecnología de Base de Datos I
