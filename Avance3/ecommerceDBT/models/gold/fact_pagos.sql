-- Archivo: Avane3/models/gold/fact_pagos.sql (VERIFICAR)
{{ config(materialized='table') }}

SELECT
    bp.id_pago AS pago_id,
    bp.order_id,
    mp.metodo_pago_id, -- Esta columna ahora debería existir en 'mp' (dim_metodo_pago)
    t.tiempo_id,
    bp.monto_pagado,
    bp.estado_pago
FROM {{ ref('int_base_pagos') }} bp
LEFT JOIN {{ ref('dim_metodo_pago') }} mp ON bp.id_metodo_pago = mp.metodo_pago_id
LEFT JOIN {{ ref('dim_tiempo') }} t ON DATE_FORMAT(bp.fecha_pago, '%Y%m%d') = t.tiempo_id