
  create view `ecommercedb`.`stg_metodos_pago__dbt_tmp`
    
    
  as (
    SELECT
    MetodoPagoID AS id_metodo_pago,
    Nombre AS nombre_metodo,
    Descripcion AS descripcion
FROM ecommercedb.metodospago
  );