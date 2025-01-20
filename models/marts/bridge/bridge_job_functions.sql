WITH stg_job_functions AS (
    SELECT * FROM {{ ref('stg_job_functions') }}
),
dim_functions AS (
    SELECT * FROM {{ ref('dim_job_functions') }}
)
SELECT
    job_id,
    f.job_function_id,
    f.job_function_name,
    posting_date
FROM stg_job_functions jf
JOIN dim_functions f ON jf.job_function = f.job_function_name
