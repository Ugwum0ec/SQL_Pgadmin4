CREATE TABLE job_applied(
    job_id INT,
    application_sent_date date,
    custome_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

select * from job_applied;

INSERT INTO job_applied
        (
            job_id,
            application_sent_date,
            custome_resume,
            resume_file_name,
            cover_letter_sent,
            cover_letter_file_name,
            status
        )
values
        (
            1,
            '2024-06-01',
            true,
            'resume_john_doe.pdf',
            true,
            'cover_letter_john_doe.pdf',
            'Submitted'),
            (2,
            '2024-06-02',
            false,
            NULL,
            false,
            NULL,
            'rejected'),
            (3,
            '2024-06-03',
            true,
            'resume_jane_smith.pdf',
            true,
            'cover_letter_jane_smith.pdf',
            'interview scheduled'),
            (4,
            '2024-06-04',
            true,
            'resume_john_doe.pdf',
            true,
            'cover_letter_john_doe.pdf',
            'Submitted'),
            (5,
            '2024-06-05',
            false,  
            NULL,
            false,
            NULL,
            'ghosted'
        );

 
ALTER TABLE job_applied
ADD contact VARCHAR(50);

UPDATE job_applied
SET contact = 'John Doe'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Jane Smith'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Bob Johnson'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Alice Brown'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Charlie Davis'
WHERE job_id = 5;

ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

ALTER TABLE job_applied
DROP COLUMN contact_name;

DROP TABLE job_applied;


