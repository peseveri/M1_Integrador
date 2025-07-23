# Proyecto de Análisis y Preparación de Datos para E-commerce
## Avance 1
## 🚀 Visión General del Proyecto

Este proyecto es el primer avance en la mejora del sistema de reportes de una empresa de e-commerce. Como parte del equipo de datos, mi rol fue analizar y comprender las fuentes de datos disponibles (archivos CSV) para establecer las bases de un modelado de datos robusto. El enfoque principal estuvo en la **carga de datos en una base de datos relacional**, la **evaluación de su calidad** y la **detección de inconsistencias**, sentando las bases para futuras transformaciones y análisis.

---

## 🎯 Objetivos

* **Configurar el Entorno de Base de Datos**: Establecer una base de datos relacional (MySQL).
* **Crear y Cargar Tablas**: Generar la estructura de tablas y poblar la base de datos con datos de archivos CSV.
* **Preparar y Transformar Datos**: Identificar y transformar columnas con datos semi-estructurados a un formato estructurado.
* **Explorar Datos**: Realizar un análisis exploratorio de datos (EDA) utilizando SQL y Python (ORM).
* **Identificar Estructura y Relaciones**: Determinar atributos clave, llaves primarias y foráneas, y otras relaciones importantes para preguntas de negocio.
* **Evaluar la Calidad de los Datos**: Detectar y documentar problemas de calidad de datos, proponiendo posibles soluciones.

---

## 🛠️ Tecnologías Utilizadas

* **Base de Datos**: MySQL
* **Lenguajes**: SQL, Python
* **Librerías Python**:
    * `pandas`
    * `SQLAlchemy`
    * `python-dotenv`
    * `pymysql`
    * `matplotlib`
    * `seaborn`
* **Entorno Virtual**: `venv`

---

## 📦 Estructura del Proyecto
├── Avance1/
│   ├── csv/
│   ├── sql/
│   │   ├── create_tables.sql
│   │   ├── load_data.sql
│   │   └── check_data.sql
│   ├── estructura_relaciones.md
│   ├── detectar_semiestructurados.py
│   └── eda_orm.ipynb
├── Avance2/
│   ├── ER.png
│   └── modelo_dimensional.md
├── Avance3/
│   └── ecommerceDBT/                    # Carpeta principal del proyecto DBT
│       ├── dbt_project.yml              # Archivo de configuración del proyecto DBT
│       ├── packages.yml                 # Define los paquetes DBT de terceros a instalar
│       ├── packages-lock.yml            # Generado automáticamente, registra las versiones exactas de los paquetes instalados
│       └── models/                      # Contiene todos tus modelos SQL de DBT
│           ├── staging/                 # Capa Bronze: Limpieza y selección básica
│           │   ├── stg_usuarios.sql
│           │   ├── stg_categorias.sql
│           │   ├── stg_productos.sql
│           │   ├── stg_ordenes.sql
│           │   ├── stg_detalle_ordenes.sql
│           │   ├── stg_metodos_pago.sql
│           │   ├── stg_historial_pagos.sql
│           │   ├── stg_reseñas.sql
│           │   └── stg_direcciones_envio.sql
│           │
│           ├── intermediate/            # Capa Silver: Transformaciones intermedias y SCDs
│           │   ├── int_productos_scd.sql
│           │   ├── int_usuarios_scd.sql
│           │   ├── int_base_ventas.sql
│           │   ├── int_base_pagos.sql
│           │   └── int_base_reseñas.sql
│           │
│           └── gold/                    # Capa Gold: Modelos dimensionales finales (hechos y dimensiones)
│               ├── dim_tiempo.sql
│               ├── dim_usuario.sql
│               ├── dim_producto.sql
│               ├── dim_categoria.sql
│               ├── dim_metodo_pago.sql
│               ├── fact_ventas.sql
│               ├── fact_pagos.sql
│               ├── fct_reseñas.sql
│               │
│               └── schema.yml             # Un único archivo schema.yml para todos los modelos Gold
|─── .env
|─── .gitignore
|─── requirements.txt


---

## ⚙️ Instalación y Configuración

1. **Clonar el repositorio y crear entorno virtual**:

    Clonar el repositorio: git clone <URL_DEL_REPOSITORIO> cd Avance1
   ```bash
   python -m venv venv
   source venv/bin/activate  # Windows: venv\Scripts\activate

2. **Instalar dependencias**:
    ```bash
    pip install -r requirements.txt
    ```


3. **Configurar archivo .env**:
    ```env
    DB_USER=tu_usuario
    DB_PASSWORD=tu_contraseña
    DB_HOST=localhost
    DB_PORT=3306
    DB_NAME=ecommercedb
    ```

4. ## Configurar la base de datos:
    Asegúrate de tener MySQL 8.0 o superior instalado y en ejecución. Copia los archivos CSV a la ruta especificada en secure_file_priv de MySQL (por ejemplo, C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/). Para verificar esta ruta, ejecuta: SHOW VARIABLES LIKE 'secure_file_priv';

    Ejecuta el script SQL sql/create_tables.sql para crear la base de datos con las tablas y despues ejecutar sql/load_data para insertar la data desde el workbench y correr las queries.

5. ## Ejecutar el eda que realizara las validaciones de datos y el analisis exploratorio

    ```bash
    python eda_orm.ipynb
    ```

6. ## Estructura y Relaciones y exploracion de datos:
    Se encuentra detallado en el archivo estructura_relaciones.md
    Las queries para examinar los datos y detectar posibles inconsistencias estan en sql/check_data.sql

---
# Avance 2

Toda la información del avance 2 está dentro de Avance2/ en donde se encuentra un documento explicando todo el modelo dimensional.

Aclaración:  
Si desde la vista previa no se puede ver el entidad-relación, lo dejo adjuntado en el archivo ER.png

# Avance 3

## 🚀 ecommerceDBT - Un Data Warehouse para Análisis de E-commerce
Este proyecto implementa un Data Warehouse robusto y escalable para un sistema de e-commerce, utilizando dbt (data build tool) para todas las transformaciones de datos. El objetivo principal es consolidar datos de diversas fuentes transaccionales, limpiarlos, transformarlos y presentarlos en un formato optimizado para el análisis y la toma de decisiones estratégicas.

🎯 Objetivo del Proyecto
El principal objetivo de ecommerceDBT es construir un modelo de datos físico en SQL que sirva como una fuente única de verdad para el análisis de ventas, productos, usuarios y pagos. dbt facilita este proceso al permitirnos definir nuestras transformaciones como código SQL versionado, probado y documentado.

✨ Características Principales
💾 Implementación del Modelo de Datos Físico en SQL (Gestionado por dbt)
En este proyecto, dbt es el encargado de la creación y materialización del modelo de datos físico de la base de datos MySQL. No se requiere que crees manualmente las tablas del Data Warehouse (DimTiempo, FactVentas, etc.) con sentencias CREATE TABLE separadas. dbt, al ejecutar los modelos SQL, traduce automáticamente la lógica de transformación en las sentencias DDL (Data Definition Language) necesarias para construir tus tablas y vistas en el esquema de destino configurado.

🔄 Transformación de Datos con dbt
Todos los procesos de transformación de datos se gestionan a través de scripts SQL orquestados por dbt, siguiendo una arquitectura de capas (Medallion Architecture: Bronze, Silver, Gold):

Limpieza y Normalización de Datos (Capa Staging/Bronze):
Los modelos en la carpeta staging/ son la primera parada para los datos brutos. Aquí se realizan operaciones de limpieza mínimas, como renombrar columnas para mayor claridad y consistencia, y se ajustan tipos de datos básicos.

Creación de Tablas de Hechos y Dimensiones (Capas Intermediate/Silver y Gold):

Capa intermediate/ (Silver): Aquí se aplican transformaciones más complejas, se unen datos de diferentes fuentes y se preparan las estructuras para las dimensiones y hechos finales. Es también donde se implementa la lógica de Slowly Changing Dimensions.

Capa gold/ (Gold): Contiene los modelos finales de hechos y dimensiones, optimizados para el consumo analítico. Estos modelos desnormalizan intencionalmente ciertos atributos para mejorar el rendimiento de las consultas y la facilidad de uso para los analistas.

Implementación de Slowly Changing Dimensions (SCD) con dbt:
Para capturar los cambios históricos en atributos de dimensiones que evolucionan con el tiempo (como la dirección de un usuario o el precio y stock de un producto), hemos implementado SCD Tipo 2 en modelos clave como dim_usuario y dim_producto. Esto se logra mediante la lógica incremental de dbt y la gestión explícita de claves subrogadas (_sk), fechas de validez (fecha_inicio_validez_scd, fecha_fin_validez_scd) y el indicador es_actual.

🔗 Manejo de Relaciones y Garantía de Integridad
dbt, aunque no impone restricciones de clave foránea (FK) a nivel de base de datos directamente (una práctica común en Data Warehouses para optimizar el rendimiento de carga), nos permite manejar y validar la integridad referencial y la calidad de los datos de manera robusta a través de:

Referencias (ref() y source()): Al usar {{ ref('nombre_modelo') }} para referenciar otros modelos dentro del proyecto, y {{ source('nombre_sistema_origen', 'nombre_tabla_origen') }} para las tablas fuente, dbt construye automáticamente un Grafo Dirigido Acíclico (DAG). Esto asegura que los modelos se construyan en el orden correcto de sus dependencias, garantizando que los datos necesarios estén disponibles antes de que un modelo dependiente se ejecute.

Tests de Integridad (schema.yml): Se definen tests explícitamente en los archivos .yml (como models/gold/schema.yml) para verificar:

Unicidad y No Nulos: Para las claves primarias (unique, not_null).

Relaciones Referenciales: Para las claves foráneas (relationships), asegurando que todos los valores en una FK existan como PK en la tabla referenciada.

Tests Personalizados: Para lógicas de negocio más complejas o validaciones específicas de SCD (ej., que solo haya una versión es_actual por clave de negocio).

📊 Presentación de Insights (Storytelling)
La capa gold/ de este proyecto está diseñada para ser la fuente principal para herramientas de Business Intelligence (BI) y análisis. Los datos transformados están listos para ser consultados y presentados en un formato que facilita la creación de narrativas y la extracción de valor de negocio:

El Lunes es el Nuevo Viernes: Descubriendo los picos de ventas semanales para optimizar operaciones.

El Éxito Silencioso de la Categoría 'Accesorios': Revelando el alto volumen de transacciones en categorías inesperadas.

Desafíos en el Pipeline de Pagos: Identificando fugas de ingresos y oportunidades para mejorar la experiencia del cliente en el proceso de pago.

Clientes Fieles: El Motor Oculto de Nuestro Crecimiento: Cuantificando el valor de los clientes recurrentes y de alto gasto para enfocar estrategias de fidelización.

## Cómo Ejecutar el Proyecto

### Configurar profiles.yml:
Asegúrate de que el archivo ~/.dbt/profiles.yml (esto es adentro el disco C, adentro de tu usuario) esté configurado con los detalles de tu conexión a MySQL. El schema debe apuntar a tu base de datos de origen (EcommerceDB) para que dbt pueda leer las tablas raw_data.

Verificar dbt_project.yml
Asegúrate de que tu dbt_project.yml (en la raíz de ecommerceDBT/) apunte al perfil correcto:

```yaml
name: 'ecommerceDBT'
version: '1.0.0'
profile: 'ecommerceDBT'

```
## Crear y Poblar Tablas de Origen:
Esto ya se realiza en el Avance 1

## Navegar al directorio del proyecto:
```bash
cd \M1_Integrador\Avance3\ecommerceDBT
```

## Instalar paquetes DBT, probar la conexion a la base, correr el DBT para realizar las transformaciones y ejecutar tests:
```bash
dbt deps
dbt debug
dbt run
dbt test
```


