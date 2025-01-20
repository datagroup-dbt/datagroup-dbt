WITH job_skills AS (
    SELECT * FROM {{ ref('bridge_job_skills') }}
),
time_dim AS (
    SELECT * FROM {{ ref('dim_time') }}
),
final AS (
    SELECT 
        t.year_month,
        s.skill_id,
        s.skill_name,
        COUNT(DISTINCT js.job_id) as job_count,
        COUNT(DISTINCT js.job_id) / LAG(COUNT(DISTINCT js.job_id)) 
            OVER (PARTITION BY s.skill_id ORDER BY t.year_month) - 1 as growth_rate
    FROM job_skills js
    JOIN {{ ref('dim_skills') }} s ON js.skill_id = s.skill_id
    JOIN time_dim t ON js.posting_date = t.date
    GROUP BY t.year_month, s.skill_id, s.skill_name
)
SELECT * FROM final