
{{ config(materialized='incremental', unique_key='producto_sk', merge_update_columns=['fecha_fin_validez_scd', 'es_actual']) }}

WITH
    productos_fuente AS (
        SELECT
            product_id,
            nombre,
            descripcion,
            category_id AS id_categoria,
            precio_actual,
            stock,
            CURRENT_DATE() AS fecha_inicio_validez_scd_raw
        FROM {{ ref('stg_productos') }}
    ),
    productos_cambios AS (
        SELECT
            product_id,
            nombre,
            descripcion,
            id_categoria,
            precio_actual,
            stock,
            fecha_inicio_validez_scd_raw,

            MD5(
                CONCAT_WS(
                    '__', 
                    COALESCE(CAST(product_id AS CHAR), '_NULL_'),
                    COALESCE(CAST(id_categoria AS CHAR), '_NULL_'),
                    COALESCE(CAST(precio_actual AS CHAR), '_NULL_'),
                    COALESCE(CAST(stock AS CHAR), '_NULL_'),
                    COALESCE(CAST(fecha_inicio_validez_scd_raw AS CHAR), '_NULL_')
                )
            ) AS producto_sk
           
        FROM productos_fuente
    )
SELECT
    pc.producto_sk,
    pc.product_id,
    pc.nombre,
    pc.descripcion,
    pc.id_categoria,
    pc.precio_actual,
    pc.stock,
    pc.fecha_inicio_validez_scd_raw AS fecha_inicio_validez_scd,
    CAST('9999-12-31' AS DATE) AS fecha_fin_validez_scd,
    TRUE AS es_actual
FROM productos_cambios pc

{% if is_incremental() %}
WHERE NOT EXISTS (
    SELECT 1
    FROM {{ this }} AS old_data
    WHERE old_data.product_id = pc.product_id
      AND old_data.es_actual = TRUE
      AND old_data.id_categoria = pc.id_categoria
      AND old_data.precio_actual = pc.precio_actual
      AND old_data.stock = pc.stock
)
{% endif %}