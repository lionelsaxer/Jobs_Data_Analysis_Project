/*
Question: How do the top skills required compared between Business Analysts (BA), Data Analysts (DA), and Data Scientists (DSc)?
*/

-- Filter the jobs, i.e., only looking at onsite and full-time jobs for BA, DA and DSc
WITH filtered_jobs AS (
    SELECT *
    FROM 
        job_postings_fact
    WHERE
        job_title_short IN ('Business Analyst', 'Data Analyst', 'Data Scientist') AND
        NOT job_location = 'Anywhere' AND
        job_schedule_type = 'Full-time'
)

SELECT
    job_title_short,
    skills,
    COUNT(*) AS post_count
FROM
    filtered_jobs
INNER JOIN skills_job_dim ON filtered_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    job_title_short, skills