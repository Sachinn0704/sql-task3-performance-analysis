-- Advanced SQL Analytics Extension
-- Adds CTEs and window functions to the Task 3 student-performance dataset.

-- ============================================================
-- 1. STUDENT RANKING WITH WINDOW FUNCTIONS
-- ============================================================

WITH student_scores AS (
    SELECT
        s.student_id,
        s.student_name,
        s.department,
        ROUND(AVG(e.grade), 2) AS average_grade
    FROM students s
    JOIN enrollments e ON s.student_id = e.student_id
    GROUP BY s.student_id, s.student_name, s.department
)
SELECT
    student_id,
    student_name,
    department,
    average_grade,
    RANK() OVER (ORDER BY average_grade DESC) AS overall_rank,
    DENSE_RANK() OVER (
        PARTITION BY department
        ORDER BY average_grade DESC
    ) AS department_rank
FROM student_scores
ORDER BY overall_rank, student_name;

-- ============================================================
-- 2. COURSE RANKING WITHIN EACH DEPARTMENT
-- ============================================================

WITH course_scores AS (
    SELECT
        s.department,
        c.course_name,
        ROUND(AVG(e.grade), 2) AS average_grade
    FROM students s
    JOIN enrollments e ON s.student_id = e.student_id
    JOIN courses c ON e.course_id = c.course_id
    GROUP BY s.department, c.course_id, c.course_name
)
SELECT
    department,
    course_name,
    average_grade,
    RANK() OVER (
        PARTITION BY department
        ORDER BY average_grade DESC
    ) AS course_rank
FROM course_scores
ORDER BY department, course_rank, course_name;

-- ============================================================
-- 3. EACH STUDENT'S GRADE COMPARED WITH COURSE AVERAGE
-- ============================================================

WITH graded_results AS (
    SELECT
        s.student_name,
        c.course_name,
        e.grade,
        ROUND(AVG(e.grade) OVER (PARTITION BY e.course_id), 2) AS course_average
    FROM enrollments e
    JOIN students s ON e.student_id = s.student_id
    JOIN courses c ON e.course_id = c.course_id
)
SELECT
    student_name,
    course_name,
    grade,
    course_average,
    ROUND(grade - course_average, 2) AS difference_from_course_average,
    CASE
        WHEN grade > course_average THEN 'Above average'
        WHEN grade < course_average THEN 'Below average'
        ELSE 'At average'
    END AS performance_vs_course
FROM graded_results
ORDER BY course_name, grade DESC;

-- ============================================================
-- 4. RUNNING STUDENT PERFORMANCE BY COURSE
-- ============================================================

SELECT
    s.student_name,
    c.course_name,
    e.grade,
    ROUND(
        AVG(e.grade) OVER (
            PARTITION BY e.student_id
            ORDER BY e.course_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS running_average
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.student_name, c.course_id;

-- ============================================================
-- 5. PERFORMANCE BAND USING NTILE
-- ============================================================

WITH student_scores AS (
    SELECT
        s.student_id,
        s.student_name,
        ROUND(AVG(e.grade), 2) AS average_grade
    FROM students s
    JOIN enrollments e ON s.student_id = e.student_id
    GROUP BY s.student_id, s.student_name
)
SELECT
    student_id,
    student_name,
    average_grade,
    NTILE(4) OVER (ORDER BY average_grade DESC) AS performance_quartile
FROM student_scores
ORDER BY performance_quartile, average_grade DESC;
