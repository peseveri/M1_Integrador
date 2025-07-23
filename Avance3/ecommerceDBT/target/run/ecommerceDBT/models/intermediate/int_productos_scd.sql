
      insert into `ecommercedb`.`int_productos_scd` (`producto_sk`, `product_id`, `nombre`, `descripcion`, `id_categoria`, `precio_actual`, `stock`, `fecha_inicio_validez_scd`, `fecha_fin_validez_scd`, `es_actual`)
    (
       select `producto_sk`, `product_id`, `nombre`, `descripcion`, `id_categoria`, `precio_actual`, `stock`, `fecha_inicio_validez_scd`, `fecha_fin_validez_scd`, `es_actual`
       from `ecommercedb`.`int_productos_scd__dbt_tmp`
    )
  