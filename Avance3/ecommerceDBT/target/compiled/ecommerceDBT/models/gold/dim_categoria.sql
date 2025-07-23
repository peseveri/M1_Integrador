-- Archivo: Avane3/models/gold/dim_categoria.sql (ACTUALIZADO)


SELECT
    category_id AS categoria_id, -- Usar category_id de stg_categorias
    nombre,
    descripcion
    -- categorizacion -- Removido
FROM `ecommercedb`.`stg_categorias`