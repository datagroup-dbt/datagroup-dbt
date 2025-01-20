WITH source AS (
    SELECT
        job_id,
        f.value as job_function,
        posting_date
    FROM {{ ref('stg_job_postings') }},
    LATERAL FLATTEN(input => job_functions) f
)
SELECT * FROM source