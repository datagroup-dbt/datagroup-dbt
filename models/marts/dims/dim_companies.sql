WITH stg_companies AS (
    SELECT * FROM {{ ref('stg_companies') }}
),
final AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['company']) }} as company_id,
        company as company_name,
        COUNT(DISTINCT job_id) as total_job_postings,
        MIN(posting_date) as first_posting_date,
        MAX(posting_date) as last_posting_date
    FROM stg_companies
    GROUP BY company
)
SELECT * FROM final