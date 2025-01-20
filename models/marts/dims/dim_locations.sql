WITH stg_locations AS (
    SELECT * FROM {{ ref('stg_locations') }}
),
final AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['location_raw']) }} as location_id,
        location_raw as location_name,
        city,
        state,
        country,
        country as region
    FROM stg_locations
)
SELECT * FROM final