
SELECT
    od.orden_id,
    od.product_id,
    od.cantidad,
    od.precio_unitario,
    o.fecha_orden AS fecha_venta,
    o.user_id      
FROM {{ ref('stg_detalle_ordenes') }} od 
LEFT JOIN {{ ref('stg_ordenes') }} o ON od.orden_id = o.orden_id 