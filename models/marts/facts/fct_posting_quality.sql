SELECT 
    t.year_month,
    j.company_id,
    c.company_name,
    COUNT(*) as total_postings,
    SUM(CASE WHEN j.is_valid THEN 1 ELSE 0 END) as valid_postings,
    SUM(CASE WHEN j.is_invalid THEN 1 ELSE 0 END) as invalid_postings,
    AVG(j.skills_count) as avg_skills_per_posting,
    AVG(j.description_length) as avg_description_length,
    SUM(CASE WHEN j.description_length < 100 THEN 1 ELSE 0 END) as short_description_count,
    SUM(CASE WHEN j.skills_count < 3 THEN 1 ELSE 0 END) as low_skills_count
FROM {{ ref('fct_job_postings') }} j
JOIN {{ ref('dim_companies') }} c ON j.company_id = c.company_id
JOIN {{ ref('dim_time') }} t ON DATE_TRUNC('MONTH', j.posting_date) = t.year_month
GROUP BY t.year_month, j.company_id, c.company_name