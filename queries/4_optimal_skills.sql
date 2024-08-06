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
),

-- Define CTE for skill demand
skill_demand AS (
    SELECT
        job_title_short AS role,
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        filtered_jobs
    INNER JOIN skills_job_dim ON filtered_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY
        role, skills_dim.skill_id
),

-- Define CTE for skill salary
skill_salary AS (
    SELECT
        job_title_short AS role,
        skills_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_yearly_salary
    FROM
        filtered_jobs
    INNER JOIN skills_job_dim ON filtered_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY
        role, skills_dim.skill_id
)

-- Combine CTEs
SELECT
    skill_demand.role,
    skill_demand.skill_id,
    skill_demand.skills,
    demand_count,
    avg_yearly_salary
FROM
    skill_demand
INNER JOIN skill_salary ON skill_demand.skill_id = skill_salary.skill_id
AND skill_demand.role = skill_salary.role



