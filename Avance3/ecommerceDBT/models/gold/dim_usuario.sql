{{ config(materialized='table') }}

SELECT
    usuario_sk,
    user_id,
    nombre,
    apellido,
    direccion,
    fecha_registro,
    fecha_fin_validez_scd,
    es_actual_scd
FROM {{ ref('int_usuarios_scd') }}