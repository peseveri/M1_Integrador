{{ config(materialized='table') }}
SELECT  bv.orden_id, prod.producto_sk, us.usuario_sk, dt.tiempo_id, bv.precio_unitario, bv.cantidad, (bv.precio_unitario * bv.cantidad) AS total_linea FROM {{ ref('int_base_ventas') }} bv JOIN {{ ref('dim_producto') }} prod ON bv.product_id = prod.product_id AND bv.fecha_venta BETWEEN prod.fecha_inicio_validez_scd AND prod.fecha_fin_validez_scd JOIN {{ ref('dim_usuario') }} us ON bv.user_id = us.user_id AND bv.fecha_venta JOIN {{ ref('dim_tiempo') }} dt ON bv.fecha_venta = dt.fecha

