/*
Question: How do the top required skills compare between Business Analysts (BA), Data Analysts (DA), and Data Scientists (DSc)?
*/

-- CTE to filter the jobs, i.e., only looking at onsite and full-time jobs for BA, DA and DSc
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

-- Join with skills tables and count number of job posts for a specific skill
SELECT
    job_title_short AS role,
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    filtered_jobs
INNER JOIN skills_job_dim ON filtered_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    role, skills