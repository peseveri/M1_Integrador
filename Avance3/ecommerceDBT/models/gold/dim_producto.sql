
{{ config(materialized='table') }}

SELECT
    p.producto_sk,
    p.product_id,
    p.nombre,
    p.descripcion,
    c.category_id AS categoria_id, 
    c.nombre AS nombre_categoria,
    c.descripcion AS descripcion_categoria,
    p.precio_actual,
    p.stock, 
    p.fecha_inicio_validez_scd,
    p.fecha_fin_validez_scd,
    p.es_actual
FROM {{ ref('int_productos_scd') }} p
JOIN {{ ref('stg_categorias') }} c ON p.id_categoria = c.category_id