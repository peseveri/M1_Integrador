
  
    

  create  table
    `ecommercedb`.`dim_usuario__dbt_tmp`
    
    
      as
    
    (
      

SELECT
    usuario_sk,
    user_id,
    nombre,
    apellido,
    direccion,
    fecha_registro,
    fecha_fin_validez_scd,
    es_actual_scd
FROM `ecommercedb`.`int_usuarios_scd`
    )

  