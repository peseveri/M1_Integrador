
  
    

  create  table
    `ecommercedb`.`fact_reseñas__dbt_tmp`
    
    
      as
    
    (
      
SELECT br.id_reseña, prod.producto_sk, dt.tiempo_id, br.rating FROM `ecommercedb`.`int_base_reseñas` br JOIN `ecommercedb`.`dim_producto` prod ON br.product_id = prod.product_id AND br.fecha_reseña BETWEEN prod.fecha_inicio_validez_scd AND prod.fecha_fin_validez_scd JOIN `ecommercedb`.`dim_tiempo` dt ON br.fecha_reseña = dt.fecha
    )

  