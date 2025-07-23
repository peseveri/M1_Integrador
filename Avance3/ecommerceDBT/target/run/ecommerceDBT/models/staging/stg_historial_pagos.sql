
  create view `ecommercedb`.`stg_historial_pagos__dbt_tmp`
    
    
  as (
    SELECT
    PagoID AS id_pago,
    OrdenID AS order_id,
    MetodoPagoID AS id_metodo_pago,
    Monto AS monto_pagado,
    FechaPago AS fecha_pago,
    EstadoPago AS estado_pago
FROM ecommercedb.historialpagos
  );