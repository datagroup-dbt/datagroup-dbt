WITH source AS (
    SELECT DISTINCT
        location as location_raw
    FROM {{ ref('stg_job_postings') }}
),
parsed AS (
    SELECT
        location_raw,
        SPLIT_PART(location_raw, ', ', -1) as country,
        CASE 
            WHEN ARRAY_SIZE(SPLIT(location_raw, ', ')) > 2 
            THEN SPLIT_PART(location_raw, ', ', -2) 
        END as state,
        SPLIT_PART(location_raw, ', ', 1) as city
    FROM source
)
SELECT * FROM parsed