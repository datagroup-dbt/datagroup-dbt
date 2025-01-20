WITH job_postings AS (
    SELECT * FROM {{ ref('stg_job_postings') }}
),
final AS (
    SELECT 
        posting_date,
        company_id,
        COUNT(*) as total_postings,
        SUM(CASE WHEN is_valid THEN 1 ELSE 0 END) as valid_postings,
        SUM(CASE WHEN is_invalid THEN 1 ELSE 0 END) as invalid_postings,
        AVG(ARRAY_SIZE(skills)) as avg_skills_per_posting,
        AVG(LENGTH(description)) as avg_description_length
    FROM job_postings
    GROUP BY posting_date, company_id
)
SELECT * FROM final