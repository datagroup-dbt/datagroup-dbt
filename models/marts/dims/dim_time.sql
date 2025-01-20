WITH stg_time AS (
    SELECT * FROM {{ ref('stg_time') }}
)
SELECT
    date as date_id,
    date,
    year,
    month,
    year_month,
    quarter,
    day_of_week
FROM stg_time