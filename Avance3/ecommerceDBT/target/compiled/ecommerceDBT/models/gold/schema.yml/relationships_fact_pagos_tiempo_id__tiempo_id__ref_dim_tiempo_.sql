
    
    

with child as (
    select tiempo_id as from_field
    from `ecommercedb`.`fact_pagos`
    where tiempo_id is not null
),

parent as (
    select tiempo_id as to_field
    from `ecommercedb`.`dim_tiempo`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


