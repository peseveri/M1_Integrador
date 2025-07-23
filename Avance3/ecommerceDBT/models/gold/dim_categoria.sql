
{{ config(materialized='table') }}

SELECT
    category_id AS categoria_id, 
    nombre,
    descripcion
FROM {{ ref('stg_categorias') }}