
    
    

select
    tiempo_id as unique_field,
    count(*) as n_records

from `ecommercedb`.`dim_tiempo`
where tiempo_id is not null
group by tiempo_id
having count(*) > 1


