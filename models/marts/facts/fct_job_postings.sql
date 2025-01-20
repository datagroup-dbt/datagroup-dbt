WITH job_postings AS (
    SELECT * FROM {{ ref('stg_job_postings') }}
),
companies AS (
    SELECT * FROM {{ ref('dim_companies') }}
),
locations AS (
    SELECT * FROM {{ ref('dim_locations') }}
),
final AS (
    SELECT 
        jp.job_id,
        c.company_id,
        l.location_id,
        jp.posting_date,
        jp.is_valid,
        jp.employment_type,
        jp.seniority_level,
        jp.workplace_type
    FROM job_postings jp
    LEFT JOIN companies c ON jp.company = c.company_name
    LEFT JOIN locations l ON jp.location = l.location_name
)
SELECT * FROM final