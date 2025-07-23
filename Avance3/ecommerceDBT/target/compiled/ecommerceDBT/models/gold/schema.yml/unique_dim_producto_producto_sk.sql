
    
    

select
    producto_sk as unique_field,
    count(*) as n_records

from `ecommercedb`.`dim_producto`
where producto_sk is not null
group by producto_sk
having count(*) > 1


