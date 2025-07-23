
    
    

select
    metodo_pago_id as unique_field,
    count(*) as n_records

from `ecommercedb`.`dim_metodo_pago`
where metodo_pago_id is not null
group by metodo_pago_id
having count(*) > 1


