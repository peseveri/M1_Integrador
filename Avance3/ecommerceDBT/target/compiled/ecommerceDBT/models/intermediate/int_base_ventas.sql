-- Archivo: Avane3/models/intermediate/int_base_ventas.sql (VERIFICAR/ACTUALIZAR)
SELECT
    od.orden_id, -- ¡Asegúrate de que esta columna esté aquí!
    od.product_id,
    od.cantidad,
    od.precio_unitario,
    o.fecha_orden AS fecha_venta, -- Asumiendo que unes con stg_ordenes para la fecha
    o.user_id      -- Asumiendo que unes con stg_ordenes para el user_id
FROM `ecommercedb`.`stg_detalle_ordenes` od -- O tu modelo de staging de detalles de órdenes
LEFT JOIN `ecommercedb`.`stg_ordenes` o ON od.orden_id = o.orden_id -- Si tienes una tabla de encabezado de órdenes