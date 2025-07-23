-- Archivo: Avane3/models/intermediate/int_usuarios_scd.sql (VERSIÓN FINAL DE CORRECCIÓN)
{{ config(materialized='incremental', unique_key='usuario_sk', merge_update_columns=['fecha_fin_validez_scd', 'es_actual_scd']) }}

WITH
    usuarios_fuente AS (
        SELECT
            user_id,
            nombre,
            apellido,
            fecha_registro
        FROM {{ ref('stg_usuarios') }}
    ),
    direcciones_con_rn AS (
        SELECT
            direccion_id,
            user_id,
            CONCAT_WS(', ', calle, ciudad, departamento, provincia, distrito, estado, codigo_postal, pais) AS direccion_completa,
            ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY direccion_id DESC) AS rn
        FROM {{ ref('stg_direcciones_envio') }}
    ),
    direcciones_usuario AS (
        SELECT
            user_id,
            direccion_completa
        FROM direcciones_con_rn
        WHERE rn = 1
    ),
    usuarios_con_direccion AS (
        SELECT
            u.user_id,
            u.nombre,
            u.apellido,
            COALESCE(du.direccion_completa, 'Direccion Desconocida') AS direccion,
            u.fecha_registro
        FROM usuarios_fuente u
        LEFT JOIN direcciones_usuario du ON u.user_id = du.user_id
    ),
    usuarios_cambios AS (
        SELECT
            user_id,
            nombre,
            apellido,
            direccion,
            fecha_registro,
            fecha_registro AS fecha_inicio_validez_scd, -- Renombrado aquí, se usa en la SELECT final
            CAST('9999-12-31' AS DATE) AS fecha_fin_validez_scd, -- Definida aquí, se usa en la SELECT final
            TRUE AS es_actual_scd, -- Definida aquí, se usa en la SELECT final
            MD5(
                CONCAT_WS(
                    '__',
                    COALESCE(CAST(user_id AS CHAR), '_NULL_'),
                    COALESCE(CAST(direccion AS CHAR), '_NULL_'),
                    COALESCE(CAST(fecha_registro AS CHAR), '_NULL_')
                )
            ) AS usuario_sk
        FROM usuarios_con_direccion
    )
SELECT
    -- Seleccionar explícitamente cada columna con su nombre final aquí
    -- para asegurarse de que dbt las "vea" correctamente.
    usuario_sk,
    user_id,
    nombre,
    apellido,
    direccion,
    fecha_registro,
    fecha_inicio_validez_scd,
    fecha_fin_validez_scd,
    es_actual_scd
FROM usuarios_cambios -- ¡Usar el alias de la CTE final!

{% if is_incremental() %}
WHERE NOT EXISTS (
    SELECT 1
    FROM {{ this }} AS old_data
    WHERE old_data.user_id = usuarios_cambios.user_id -- Asegúrate de referenciar el alias de la CTE
      AND old_data.es_actual_scd = 1
      AND old_data.direccion = usuarios_cambios.direccion
)
{% endif %}