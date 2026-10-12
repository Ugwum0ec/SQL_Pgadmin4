-- January jobs
/*CREATE TABLE January_Jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February jobs
CREATE TABLE February_Jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March jobs
CREATE TABLE March_Jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT
    job_posted_date
FROM
    March_Jobs;


SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;*/


SELECT
    job_id,
    job_location,
    salary_year_avg,
    CASE
        WHEN salary_year_avg < 50000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 50000 AND 99999 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;

WITH skill_count AS (
    SELECT
        skill_id,
        COUNT(*) AS Count
    FROM
        skills_job_dim
    GROUP BY
        skill_id
)
SELECT
    skills_dim.skills,
    skill_count.Count
FROM
    skills_dim
LEFT JOIN skill_count ON skills_dim.skill_id = skill_count.skill_id
ORDER BY
    skill_count.Count DESC;


WITH Postings_Num AS (
    SELECT
        company_dim.name AS COMPANY_NAME,
        COUNT(job_postings_fact.job_id) AS NUMBER_OF_JOBS
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    GROUP BY
        company_dim.name
    ORDER BY
        NUMBER_OF_JOBS DESC
)

SELECT
    COMPANY_NAME,
    NUMBER_OF_JOBS,
    CASE
    WHEN NUMBER_OF_JOBS < 500 THEN 'LOW'
    WHEN NUMBER_OF_JOBS BETWEEN 500 AND 1500 THEN 'MEDIUM'
    ELSE 'HIGH'
END AS JOB_POSTINGS_CATEGORY
FROM
    Postings_Num


WITH remote_job_skills AS(
SELECT
    skill_id,
    COUNT(skill_id) AS skill_count
FROM
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON skills_to_job.job_id = job_postings.job_id
WHERE
    job_postings.job_work_from_home = TRUE AND
    job_postings.job_title_short = 'Data Analyst'
GROUP BY
    skill_id
)

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    skill_count
FROM
    remote_job_skills
INNER JOIN skills_dim ON remote_job_skills.skill_id = skills_dim.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;


SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs





SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date,
    quarter1_job_postings.salary_year_avg
FROM(
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
WHERE
    quarter1_job_postings.salary_year_avg > 70000 AND
    quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    quarter1_job_postings.salary_year_avg DESC;