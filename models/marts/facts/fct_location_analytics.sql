SELECT 
    l.location_id,
    l.city,
    l.state,
    l.country,
    l.region,
    t.year_month,
    COUNT(DISTINCT j.job_id) as total_jobs,
    COUNT(DISTINCT j.company_id) as unique_companies,
    SUM(CASE WHEN j.is_valid THEN 1 ELSE 0 END)::FLOAT / NULLIF(COUNT(*), 0) as validity_rate,
    AVG(j.skills_count) as avg_skills_per_posting,
    AVG(j.description_length) as avg_description_length
FROM {{ ref('fct_job_postings') }} j
JOIN {{ ref('dim_locations') }} l ON j.location_id = l.location_id
JOIN {{ ref('dim_time') }} t ON DATE_TRUNC('MONTH', j.posting_date) = t.year_month
GROUP BY l.location_id, l.city, l.state, l.country, l.region, t.year_month
