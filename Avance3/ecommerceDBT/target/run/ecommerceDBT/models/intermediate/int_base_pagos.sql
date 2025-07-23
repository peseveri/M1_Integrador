
  create view `ecommercedb`.`int_base_pagos__dbt_tmp`
    
    
  as (
    SELECT id_pago, order_id, id_metodo_pago, fecha_pago, monto_pagado, estado_pago FROM `ecommercedb`.`stg_historial_pagos`
  );