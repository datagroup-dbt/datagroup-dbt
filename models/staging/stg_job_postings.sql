WITH source AS (
    SELECT * FROM {{ source('raw', 'raw_jobs_data') }}
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
        is_invalid,
        posting_date
    FROM source
)
SELECT * FROM renamed