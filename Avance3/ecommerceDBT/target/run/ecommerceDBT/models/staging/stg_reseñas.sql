
  create view `ecommercedb`.`stg_reseñas__dbt_tmp`
    
    
  as (
    SELECT
    ReseñaID AS id_reseña,
    UsuarioID AS user_id, 
    ProductoID AS product_id,
    Calificacion AS rating,
    Comentario AS comentario,
    Fecha AS fecha_reseña
FROM ecommercedb.reseñasproductos
  );