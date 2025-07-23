
SELECT
    id_reseña,
    user_id,
    product_id,
    rating,
    comentario, 
    fecha_reseña 
FROM {{ ref('stg_reseñas') }}