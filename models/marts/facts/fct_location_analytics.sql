WITH job_locations AS (
    SELECT * FROM {{ ref('stg_job_postings') }}
),
final AS (
    SELECT 
        l.location_id,
        l.city,
        l.state,
        l.country,
        COUNT(DISTINCT j.job_id) as total_jobs,
        COUNT(DISTINCT j.company) as unique_companies,
        AVG(j.is_valid::INTEGER) as validity_rate
    FROM job_locations j
    JOIN {{ ref('dim_locations') }} l ON j.location = l.location_name
    GROUP BY l.location_id, l.city, l.state, l.country
)
SELECT * FROM final