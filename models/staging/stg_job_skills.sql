WITH source AS (
    SELECT
        job_id,
        f.value as skill,
        posting_date
    FROM {{ ref('stg_job_postings') }},
    LATERAL FLATTEN(input => skills) f
)
SELECT * FROM source