-- Archivo: Avane3/models/gold/dim_producto.sql (ACTUALIZADO)
{{ config(materialized='table') }}

SELECT
    p.producto_sk,
    p.product_id,
    p.nombre,
    p.descripcion,
    c.category_id AS categoria_id, -- Usar category_id de stg_categorias
    c.nombre AS nombre_categoria,
    c.descripcion AS descripcion_categoria,
    -- c.categorizacion, -- Removido, ya que no está en la tabla de origen Categorias
    p.precio_actual,
    p.stock, -- Añadido
    p.fecha_inicio_validez_scd,
    p.fecha_fin_validez_scd,
    p.es_actual
FROM {{ ref('int_productos_scd') }} p
JOIN {{ ref('stg_categorias') }} c ON p.id_categoria = c.category_id