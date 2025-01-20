{% set source_relation = source('raw', 'raw_jobs_data') %}

WITH source AS (
    SELECT *
    FROM {{ source_relation }}
),
renamed AS (
    SELECT
        job_id,
        title,
        company,
        location,
        employment_type,
        seniority_level,
        workplace_type,
        industries,
        job_functions,
        skills,
        description,
        posted_time,
        expire_time,
        is_valid,
        posting_date
    FROM source
)
SELECT * FROM renamed