
{{ config(materialized='table') }}

SELECT
    id_metodo_pago AS metodo_pago_id,
    nombre_metodo,
    descripcion
FROM {{ ref('stg_metodos_pago') }}