
      insert into `ecommercedb`.`int_usuarios_scd` (`usuario_sk`, `user_id`, `nombre`, `apellido`, `direccion`, `fecha_registro`, `fecha_fin_validez_scd`, `es_actual_scd`)
    (
       select `usuario_sk`, `user_id`, `nombre`, `apellido`, `direccion`, `fecha_registro`, `fecha_fin_validez_scd`, `es_actual_scd`
       from `ecommercedb`.`int_usuarios_scd__dbt_tmp`
    )
  