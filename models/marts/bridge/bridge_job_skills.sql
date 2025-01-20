WITH stg_job_skills AS (
    SELECT * FROM {{ ref('stg_job_skills') }}
),
dim_skills AS (
    SELECT * FROM {{ ref('dim_skills') }}
)
SELECT
    job_id,
    s.skill_id,
    s.skill_name,
    posting_date
FROM stg_job_skills js
JOIN dim_skills s ON js.skill = s.skill_name