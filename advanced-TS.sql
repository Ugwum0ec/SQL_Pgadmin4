/*SELECT 
    job_title_short AS Title,
    job_location AS Location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS Date,
    EXTRACT(MONTH FROM job_posted_date) AS Column_Month,
    EXTRACT(YEAR FROM job_posted_date) AS Column_Year
FROM
    job_postings_fact
LIMIT 5;*/


/*SELECT
    Count(job_id) AS Job_Count,
    EXTRACT(MONTH FROM job_posted_date) AS Column_Month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    Column_Month
ORDER BY
    Job_Count DESC;*/


/*SELECT
    job_schedule_type AS Schedule_Type,
    AVG(salary_year_avg) AS Average_Salary_Yearly,
    AVG(salary_hour_avg) AS Average_Salary_Hourly
FROM
    job_postings_fact
WHERE
    EXTRACT(MONTH FROM job_posted_date) >= 6
GROUP BY
    Schedule_Type;*/


/*SELECT
    COUNT(job_id) AS Job_Count,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS Month
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York')
ORDER BY
    Month DESC;*/


SELECT
    company_dim.company_id AS Company_ID,
    company_dim.name AS Company_Name,
    job_postings.job_health_insurance AS Health_Insurance,
    EXTRACT(MONTH FROM job_postings.job_posted_date) AS Job_Posted_Month
FROM
    company_dim
LEFT JOIN
    job_postings_fact AS job_postings ON company_dim.company_id = job_postings.company_id
WHERE
    job_postings.job_health_insurance = 't' AND EXTRACT(MONTH FROM job_postings.job_posted_date) BETWEEN 4 AND 6; 