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
    credits INT NOT NULL
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade DECIMAL(5,2) NOT NULL,
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

-- High-performing enrollment records
SELECT *
FROM enrollments
WHERE grade >= 80
ORDER BY grade DESC;

-- ============================================================
-- 3. HAVING CLAUSE
-- HAVING filters groups after GROUP BY and aggregation.
-- Aggregate conditions such as AVG(), COUNT(), and MAX()
-- belong in HAVING rather than WHERE.
-- ============================================================

-- Students whose average grade is at least 80
SELECT
    s.student_id,
    s.student_name,
    AVG(e.grade) AS average_grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name
HAVING AVG(e.grade) >= 80
ORDER BY average_grade DESC;

-- Students enrolled in more than one course
SELECT
    s.student_id,
    s.student_name,
    COUNT(e.course_id) AS course_count
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name
HAVING COUNT(e.course_id) > 1
ORDER BY course_count DESC;

-- Courses with at least 3 enrollment records
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS enrollment_count
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.student_id) >= 3
ORDER BY enrollment_count DESC;

-- ============================================================
-- 4. WHERE + GROUP BY + HAVING TOGETHER
-- WHERE first removes rows; GROUP BY creates groups;
-- HAVING then filters those groups.
-- ============================================================

-- Find students whose passing grades average at least 75.
SELECT
    s.student_id,
    s.student_name,
    AVG(e.grade) AS passing_grade_average,
    COUNT(e.enrollment_id) AS passing_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.grade >= 40
GROUP BY s.student_id, s.student_name
HAVING AVG(e.grade) >= 75
ORDER BY passing_grade_average DESC;

-- ============================================================
-- 5. TOP STUDENT PER COURSE
-- ============================================================

SELECT
    c.course_name,
    s.student_name,
    e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.grade = (
    SELECT MAX(e2.grade)
    FROM enrollments e2
    WHERE e2.course_id = e.course_id
)
ORDER BY c.course_name;

-- ============================================================
-- 6. PASS RATE PER COURSE
-- Passing grade = 40 or above.
-- ============================================================

SELECT
    c.course_id,
    c.course_name,
    COUNT(e.enrollment_id) AS total_enrollments,
    SUM(CASE WHEN e.grade >= 40 THEN 1 ELSE 0 END) AS passed,
    ROUND(
        100.0 * SUM(CASE WHEN e.grade >= 40 THEN 1 ELSE 0 END)
        / COUNT(e.enrollment_id),
        2
    ) AS pass_rate_percentage
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY pass_rate_percentage DESC;

-- ============================================================
-- 7. OVERALL TOPPER
-- ============================================================

SELECT
    s.student_id,
    s.student_name,
    ROUND(AVG(e.grade), 2) AS average_grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name
ORDER BY average_grade DESC
LIMIT 1;

-- ============================================================
-- 8. STUDENT PERFORMANCE SUMMARY
-- ============================================================

SELECT
    s.student_id,
    s.student_name,
    s.department,
    COUNT(e.enrollment_id) AS courses_taken,
    ROUND(AVG(e.grade), 2) AS average_grade,
    MAX(e.grade) AS highest_grade,
    MIN(e.grade) AS lowest_grade,
    SUM(CASE WHEN e.grade >= 40 THEN 1 ELSE 0 END) AS passed_courses,
    SUM(CASE WHEN e.grade < 40 THEN 1 ELSE 0 END) AS failed_courses
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name, s.department
ORDER BY average_grade DESC;

-- ============================================================
-- 9. DEPARTMENT-LEVEL PERFORMANCE
-- ============================================================

SELECT
    s.department,
    COUNT(DISTINCT s.student_id) AS student_count,
    COUNT(e.enrollment_id) AS enrollment_count,
    ROUND(AVG(e.grade), 2) AS department_average
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.department
HAVING AVG(e.grade) >= 60
ORDER BY department_average DESC;

-- ============================================================
-- 10. CONDITIONAL AGGREGATION
-- ============================================================

SELECT
    c.course_name,
    COUNT(*) AS total_students,
    SUM(CASE WHEN e.grade >= 80 THEN 1 ELSE 0 END) AS distinction_count,
    SUM(CASE WHEN e.grade >= 60 AND e.grade < 80 THEN 1 ELSE 0 END) AS first_class_count,
    SUM(CASE WHEN e.grade >= 40 AND e.grade < 60 THEN 1 ELSE 0 END) AS pass_count,
    SUM(CASE WHEN e.grade < 40 THEN 1 ELSE 0 END) AS fail_count
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY c.course_name;

-- ============================================================
-- 11. ORDER BY AND LIMIT
-- ============================================================

SELECT
    s.student_name,
    e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
ORDER BY e.grade DESC
LIMIT 5;

-- ============================================================
-- 12. KEY CONCEPT COMPARISON
-- ============================================================

-- WHERE: filters rows before GROUP BY.
-- HAVING: filters groups after GROUP BY.
-- WHERE should not normally contain aggregate functions such as AVG().
-- HAVING is designed for aggregate/group-level conditions.

-- Example:
-- WHERE e.grade >= 40       -> row-level filtering
-- HAVING AVG(e.grade) >= 80 -> group-level filtering
