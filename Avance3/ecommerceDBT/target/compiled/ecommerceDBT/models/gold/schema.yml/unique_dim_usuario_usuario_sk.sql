
    
    

select
    usuario_sk as unique_field,
    count(*) as n_records

from `ecommercedb`.`dim_usuario`
where usuario_sk is not null
group by usuario_sk
having count(*) > 1


