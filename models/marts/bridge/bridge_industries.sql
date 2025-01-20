WITH stg_industries AS (
    SELECT * FROM {{ ref('stg_industries') }}
),
dim_industries AS (
    SELECT * FROM {{ ref('dim_industries') }}
)
SELECT
    job_id,
    i.industry_id,
    i.industry_name,
    posting_date
FROM stg_industries si
JOIN dim_industries i ON si.industry = i.industry_name