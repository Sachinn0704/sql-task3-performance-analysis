-- Advanced SQL Student Performance Analysis
-- Task 3 | Updated: 2026-09-02

-- ============================================================
-- 1. DATABASE SETUP
-- ============================================================

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade DECIMAL(5,2) NOT NULL CHECK (grade BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students (student_id, student_name, department) VALUES
(1, 'Aarav', 'Computer Science'),
(2, 'Diya', 'Computer Science'),
(3, 'Rohan', 'Information Technology'),
(4, 'Ananya', 'Information Technology'),
(5, 'Vikram', 'Data Science'),
(6, 'Meera', 'Data Science');

INSERT INTO courses (course_id, course_name, credits) VALUES
(101, 'SQL', 4),
(102, 'Python', 4),
(103, 'Power BI', 3),
(104, 'Statistics', 3);

INSERT INTO enrollments (enrollment_id, student_id, course_id, grade) VALUES
(1, 1, 101, 92),
(2, 1, 102, 88),
(3, 1, 103, 81),
(4, 2, 101, 76),
(5, 2, 102, 84),
(6, 3, 101, 68),
(7, 3, 103, 73),
(8, 3, 104, 79),
(9, 4, 101, 91),
(10, 4, 102, 95),
(11, 4, 103, 89),
(12, 4, 104, 93),
(13, 5, 102, 72),
(14, 5, 104, 65),
(15, 6, 101, 38),
(16, 6, 103, 44);

-- ============================================================
-- 2. WHERE CLAUSE
-- WHERE filters individual rows before grouping/aggregation.
-- It is normally used for non-aggregate conditions.
-- ============================================================

-- Students belonging to the Data Science department
SELECT *
FROM students
WHERE department = 'Data Science';

-- Enrollment records with passing grades
SELECT *
FROM enrollments
WHERE grade >= 40;
