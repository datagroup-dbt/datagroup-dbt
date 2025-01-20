WITH stg_skills AS (
    SELECT DISTINCT skill FROM {{ ref('stg_job_skills') }}
),
final AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['skill']) }} as skill_id,
        skill as skill_name
    FROM stg_skills
)
SELECT * FROM final