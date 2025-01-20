WITH dates AS (
    SELECT DISTINCT
        posting_date as date
    FROM {{ ref('stg_job_postings') }}
)
SELECT
    date,
    YEAR(date) as year,
    MONTH(date) as month,
    DATE_TRUNC('MONTH', date) as year_month,
    QUARTER(date) as quarter,
    DAYOFWEEK(date) as day_of_week
FROM dates