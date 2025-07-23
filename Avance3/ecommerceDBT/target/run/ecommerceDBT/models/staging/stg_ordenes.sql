
  create view `ecommercedb`.`stg_ordenes__dbt_tmp`
    
    
  as (
    SELECT
    OrdenID AS orden_id,
    UsuarioID AS user_id,
    FechaOrden AS fecha_orden
FROM ecommercedb.ordenes
  );