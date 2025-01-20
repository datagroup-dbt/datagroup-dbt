WITH source AS (
    SELECT DISTINCT
        job_id,
        company,
        posting_date
    FROM {{ ref('stg_job_postings') }}
)
SELECT * FROM source