
    
    

with child as (
    select categoria_id as from_field
    from `ecommercedb`.`dim_producto`
    where categoria_id is not null
),

parent as (
    select categoria_id as to_field
    from `ecommercedb`.`dim_categoria`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


