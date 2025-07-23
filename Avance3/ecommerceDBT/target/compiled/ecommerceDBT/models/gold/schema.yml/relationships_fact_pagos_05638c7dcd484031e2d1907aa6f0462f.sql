
    
    

with child as (
    select metodo_pago_id as from_field
    from `ecommercedb`.`fact_pagos`
    where metodo_pago_id is not null
),

parent as (
    select metodo_pago_id as to_field
    from `ecommercedb`.`dim_metodo_pago`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


