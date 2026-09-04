USE facultyreview;
INSERT IGNORE INTO schools (school_name) VALUES ('School of Computing'),('School of Electronics'),('School of Mechanical Engineering');
INSERT IGNORE INTO departments (school_id, department_name)
SELECT school_id, 'Computer Science and Engineering' FROM schools WHERE school_name='School of Computing';
INSERT IGNORE INTO departments (school_id, department_name)
SELECT school_id, 'Electronics and Communication Engineering' FROM schools WHERE school_name='School of Electronics';
INSERT IGNORE INTO departments (school_id, department_name)
SELECT school_id, 'Mechanical Engineering' FROM schools WHERE school_name='School of Mechanical Engineering';
INSERT IGNORE INTO subjects (subject_code, subject_name) VALUES ('BCSE201L','Database Management Systems'),('BCSE202L','Operating Systems'),('BCSE203L','Computer Networks'),('BCSE204L','Data Structures'),('BCSE205L','Java Programming');
INSERT IGNORE INTO faculties (faculty_name, department_id)
SELECT 'Dr. Arun Kumar',department_id FROM departments WHERE department_name='Computer Science and Engineering';
INSERT IGNORE INTO faculties (faculty_name, department_id)
SELECT 'Dr. Priya',department_id FROM departments WHERE department_name='Computer Science and Engineering';
INSERT IGNORE INTO faculties (faculty_name, department_id)
SELECT 'Dr. Ravi',department_id FROM departments WHERE department_name='Computer Science and Engineering';
INSERT IGNORE INTO faculty_subjects(faculty_id,subject_id)
SELECT f.faculty_id,s.subject_id FROM faculties f CROSS JOIN subjects s WHERE f.faculty_name='Dr. Arun Kumar' AND s.subject_name IN ('Database Management Systems','Operating Systems','Computer Networks');
INSERT IGNORE INTO faculty_subjects(faculty_id,subject_id)
SELECT f.faculty_id,s.subject_id FROM faculties f CROSS JOIN subjects s WHERE f.faculty_name='Dr. Priya' AND s.subject_name IN ('Data Structures','Java Programming');
INSERT IGNORE INTO faculty_subjects(faculty_id,subject_id)
SELECT f.faculty_id,s.subject_id FROM faculties f CROSS JOIN subjects s WHERE f.faculty_name='Dr. Ravi' AND s.subject_name IN ('Operating Systems','Computer Networks');
