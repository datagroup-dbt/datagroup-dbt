WITH stg_functions AS (
    SELECT DISTINCT job_function FROM {{ ref('stg_job_functions') }}
),
final AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['job_function']) }} as job_function_id,
        job_function as job_function_name
    FROM stg_functions
)
SELECT * FROM final