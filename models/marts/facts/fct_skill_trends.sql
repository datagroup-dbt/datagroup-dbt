WITH job_skills AS (
    SELECT * FROM {{ ref('bridge_job_skills') }}
),
dim_time AS (
    SELECT * FROM {{ ref('dim_time') }}
)
SELECT 
    t.year_month,
    s.skill_id,
    s.skill_name,
    COUNT(DISTINCT js.job_id) as job_count,
    COUNT(DISTINCT js.job_id) / NULLIF(LAG(COUNT(DISTINCT js.job_id)) 
        OVER (PARTITION BY s.skill_id ORDER BY t.year_month), 0) - 1 as growth_rate
FROM {{ ref('bridge_job_skills') }} js
JOIN {{ ref('dim_skills') }} s ON js.skill_id = s.skill_id
JOIN dim_time t ON DATE_TRUNC('MONTH', js.posting_date) = t.year_month
WHERE js.posting_date >= DATEADD('month', -12, CURRENT_DATE())
GROUP BY t.year_month, s.skill_id, s.skill_name