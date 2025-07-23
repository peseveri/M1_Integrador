-- Archivo: Avane3/models/gold/dim_metodo_pago.sql (VERIFICAR/ACTUALIZAR)


SELECT
    id_metodo_pago AS metodo_pago_id, -- ¡Asegúrate de que id_metodo_pago se aliasa a metodo_pago_id!
    nombre_metodo,
    descripcion
FROM `ecommercedb`.`stg_metodos_pago`