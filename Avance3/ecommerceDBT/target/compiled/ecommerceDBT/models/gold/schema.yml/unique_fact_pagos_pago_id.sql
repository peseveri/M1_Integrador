
    
    

select
    pago_id as unique_field,
    count(*) as n_records

from `ecommercedb`.`fact_pagos`
where pago_id is not null
group by pago_id
having count(*) > 1


