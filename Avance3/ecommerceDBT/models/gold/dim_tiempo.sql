
{{ config(materialized='table') }}

WITH nums AS (
    SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
hundreds AS (
    SELECT (t1.n + t2.n * 10 + t3.n * 100 + t4.n * 1000) AS num
    FROM nums AS t1
    CROSS JOIN nums AS t2
    CROSS JOIN nums AS t3
    CROSS JOIN nums AS t4 
),
date_series AS (
    SELECT DATE_ADD('2020-01-01', INTERVAL num DAY) AS fecha_generada_raw
    FROM hundreds
    WHERE DATE_ADD('2020-01-01', INTERVAL num DAY) <= '2026-12-31'
)
SELECT
    CAST(DATE_FORMAT(fecha_generada_raw, '%Y%m%d') AS UNSIGNED) AS tiempo_id,
    fecha_generada_raw AS fecha,
    YEAR(fecha_generada_raw) AS anio,
    MONTH(fecha_generada_raw) AS mes,
    MONTHNAME(fecha_generada_raw) AS nombre_mes,
    CASE DAYOFWEEK(fecha_generada_raw)
        WHEN 1 THEN 7 -- Domingo
        WHEN 2 THEN 1 -- Lunes
        WHEN 3 THEN 2 -- Martes
        WHEN 4 THEN 3 -- Miércoles
        WHEN 5 THEN 4 -- Jueves
        WHEN 6 THEN 5 -- Viernes
        WHEN 7 THEN 6 -- Sábado
    END AS dia_semana_num,
    DAYNAME(fecha_generada_raw) AS nombre_dia_semana
FROM date_series
ORDER BY fecha_generada_raw