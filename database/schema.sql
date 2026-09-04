CREATE DATABASE IF NOT EXISTS facultyreview CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE facultyreview;

CREATE TABLE IF NOT EXISTS schools (
  school_id INT AUTO_INCREMENT PRIMARY KEY,
  school_name VARCHAR(150) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS departments (
  department_id INT AUTO_INCREMENT PRIMARY KEY,
  school_id INT NOT NULL,
  department_name VARCHAR(150) NOT NULL,
  UNIQUE KEY uq_dept (school_id, department_name),
  FOREIGN KEY (school_id) REFERENCES schools(school_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS faculties (
  faculty_id INT AUTO_INCREMENT PRIMARY KEY,
  faculty_name VARCHAR(150) NOT NULL,
  department_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_faculty (faculty_name, department_id),
  FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
CREATE TABLE IF NOT EXISTS subjects (
  subject_id INT AUTO_INCREMENT PRIMARY KEY,
  subject_code VARCHAR(50),
  subject_name VARCHAR(180) NOT NULL,
  UNIQUE KEY uq_subject (subject_code, subject_name)
);
CREATE TABLE IF NOT EXISTS faculty_subjects (
  faculty_id INT NOT NULL,
  subject_id INT NOT NULL,
  PRIMARY KEY (faculty_id, subject_id),
  FOREIGN KEY (faculty_id) REFERENCES faculties(faculty_id) ON DELETE CASCADE,
  FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  name VARCHAR(150) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('student','admin') NOT NULL DEFAULT 'student',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS reviews (
  review_id INT AUTO_INCREMENT PRIMARY KEY,
  faculty_id INT NOT NULL,
  subject_id INT NOT NULL,
  user_id INT NOT NULL,
  semester VARCHAR(50) NOT NULL,
  academic_year VARCHAR(20) NOT NULL,
  rating TINYINT NOT NULL,
  comment TEXT NOT NULL,
  status ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_review (faculty_id, subject_id, user_id, semester, academic_year),
  FOREIGN KEY (faculty_id) REFERENCES faculties(faculty_id) ON DELETE CASCADE,
  FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  CHECK (rating BETWEEN 1 AND 5)
);
CREATE TABLE IF NOT EXISTS reports (
  report_id INT AUTO_INCREMENT PRIMARY KEY,
  review_id INT NOT NULL,
  reason VARCHAR(500) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('open','resolved','dismissed') NOT NULL DEFAULT 'open',
  FOREIGN KEY (review_id) REFERENCES reviews(review_id) ON DELETE CASCADE
);


