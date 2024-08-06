/*
Question: Which are the top-paying skills depending on the role?
*/

-- CTE to filter jobs
WITH filtered_jobs AS (
    SELECT *
    FROM 
        job_postings_fact
    WHERE
        job_title_short IN ('Business Analyst', 'Data Analyst', 'Data Scientist') AND
        NOT job_location = 'Anywhere' AND
        job_schedule_type = 'Full-time' AND
        salary_year_avg IS NOT NULL
)

-- Compute average salary per skill and role
SELECT
    job_title_short AS role,
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_yearly_salary
FROM
    filtered_jobs
INNER JOIN skills_job_dim ON filtered_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    skills, role