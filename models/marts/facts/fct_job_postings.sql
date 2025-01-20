WITH job_postings AS (
    SELECT * FROM {{ ref('stg_job_postings') }}
),
companies AS (
    SELECT * FROM {{ ref('dim_companies') }}
),
locations AS (
    SELECT * FROM {{ ref('dim_locations') }}
)
SELECT 
    jp.job_id,
    c.company_id,
    l.location_id,
    jp.posting_date,
    jp.employment_type,
    jp.seniority_level,
    jp.workplace_type,
    jp.is_valid,
    jp.is_invalid,
    ARRAY_SIZE(jp.skills) as skills_count,
    ARRAY_SIZE(jp.job_functions) as functions_count,
    ARRAY_SIZE(jp.industries) as industries_count,
    LENGTH(jp.description) as description_length
FROM job_postings jp
LEFT JOIN companies c ON jp.company = c.company_name
LEFT JOIN locations l ON jp.location = l.location_name