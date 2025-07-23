
    
    

select
    categoria_id as unique_field,
    count(*) as n_records

from `ecommercedb`.`dim_categoria`
where categoria_id is not null
group by categoria_id
having count(*) > 1


