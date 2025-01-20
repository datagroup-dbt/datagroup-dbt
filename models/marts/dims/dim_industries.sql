WITH stg_industries AS (
    SELECT DISTINCT industry FROM {{ ref('stg_industries') }}
),
final AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['industry']) }} as industry_id,
        industry as industry_name
    FROM stg_industries
)
SELECT * FROM final