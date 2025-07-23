
  create view `ecommercedb`.`stg_categorias__dbt_tmp`
    
    
  as (
    SELECT
    CategoriaID AS category_id,
    Nombre AS nombre,
    Descripcion AS descripcion
FROM ecommercedb.categorias
  );