
  create view `ecommercedb`.`stg_detalle_ordenes__dbt_tmp`
    
    
  as (
    SELECT
    DetalleID AS id_linea_venta,
    OrdenID AS orden_id,
    ProductoID AS product_id,
    Cantidad AS cantidad,
    PrecioUnitario AS precio_unitario
FROM ecommercedb.detalleordenes
  );