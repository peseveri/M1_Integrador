
  create view `ecommercedb`.`int_base_reseñas__dbt_tmp`
    
    
  as (
    -- Archivo: Avane3/models/intermediate/int_base_reseñas.sql (CORRECCIÓN)
SELECT
    id_reseña,
    user_id,
    product_id,
    rating,
    comentario, -- Si necesitas el comentario
    fecha_reseña -- Asegúrate de que este nombre coincida con el alias en stg_reseñas
FROM `ecommercedb`.`stg_reseñas`
  );