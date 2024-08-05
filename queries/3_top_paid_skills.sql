SELECT
    job_title_short AS role,
    skills,
    AVG(salary_year_avg) AS avg_yearly_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short IN ('Business Analyst', 'Data Analyst', 'Data Scientist') AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills, role