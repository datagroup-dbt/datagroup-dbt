WITH source AS (
    SELECT
        job_id,
        f.value as industry,
        posting_date
    FROM {{ ref('stg_job_postings') }},
    LATERAL FLATTEN(input => industries) f
)
SELECT * FROM source