# Advanced SQL Student Performance Analysis

**Task 3 — Updated September 2, 2026**

An advanced SQL practice project built around a student-course-enrollment database. The project demonstrates practical SQL filtering, aggregation, joins, conditional logic, ranking, and performance analysis.

## Project Summary

This task covers both row-level and group-level filtering and applies them to student performance analysis.

The project demonstrates how to:

- Filter rows with `WHERE`
- Filter grouped/aggregated results with `HAVING`
- Combine `WHERE`, `GROUP BY`, and `HAVING`
- Join students, courses, and enrollments
- Calculate averages, counts, minimums, and maximums
- Calculate course pass rates
- Identify the top student in each course
- Find the overall topper
- Detect students enrolled in multiple courses
- Perform conditional aggregation with `CASE`
- Sort and limit analytical results

## Database Model

- `students` — student information
- `courses` — course information
- `enrollments` — student-course relationships and grades

The `enrollments` table represents the many-to-many relationship between students and courses.

## Today's Core Concept: WHERE vs HAVING

### WHERE

`WHERE` filters **individual rows before grouping and aggregation**.

Example:

```sql
SELECT *
FROM enrollments
WHERE grade >= 40;
```

This filters individual enrollment records based on the grade.

### HAVING

`HAVING` filters **groups after `GROUP BY` and aggregation**.

Example:

```sql
SELECT student_id, AVG(grade) AS average_grade
FROM enrollments
GROUP BY student_id
HAVING AVG(grade) >= 80;
```

This filters student groups based on their calculated average.

### Quick Rule

| Clause | Filters | Typical use |
|---|---|---|
| `WHERE` | Rows | Before grouping/aggregation |
| `HAVING` | Groups | After grouping/aggregation |

A useful pattern is:

```text
FROM / JOIN
    ↓
WHERE        → filter rows
    ↓
GROUP BY     → create groups
    ↓
HAVING       → filter groups
    ↓
SELECT
    ↓
ORDER BY
    ↓
LIMIT
```

## Main Analysis

### 1. Top Student Per Course

Identifies the student or students with the highest recorded grade in each course.

### 2. Pass Rate Per Course

Calculates the percentage of enrollment records with a grade of at least 40.

### 3. Overall Topper

Ranks students using their average grade across enrolled courses.

### 4. Multiple-Course Enrollment

Finds students enrolled in more than one course using `GROUP BY` and `HAVING COUNT(...)`.

### 5. Student Performance Summary

Provides course count, average grade, highest grade, lowest grade, passed courses, and failed courses for each student.

### 6. Department-Level Performance

Summarizes student counts, enrollments, and average grades by department.

### 7. Conditional Aggregation

Uses `CASE` expressions with aggregate functions to classify performance levels and count passes/fails.

## SQL Concepts Practiced

- `SELECT`
- `FROM`
- `WHERE`
- `JOIN`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIMIT`
- Aggregate functions: `AVG`, `COUNT`, `SUM`, `MIN`, `MAX`
- `CASE`
- Conditional aggregation
- Subqueries
- Foreign keys
- Many-to-many relationships

## Required SQL File

`task3.sql` contains the complete runnable Task 3 practice script, including:

1. Database table creation
2. Sample student/course/enrollment data
3. `WHERE` examples
4. `HAVING` examples
5. Combined `WHERE + GROUP BY + HAVING` analysis
6. Top student per course
7. Course pass-rate analysis
8. Overall topper
9. Student performance summary
10. Department performance analysis
11. Conditional aggregation
12. `ORDER BY` and `LIMIT` examples

## How to Run

1. Open a SQL environment such as MySQL, PostgreSQL, or another compatible database system.
2. Run `task3.sql`.
3. Execute the queries section by section.
4. Review the output and verify the filtering and aggregation logic.

> Note: SQL syntax can vary slightly between database systems. The script uses common SQL concepts; `LIMIT` is supported by MySQL, PostgreSQL, and SQLite but may require an equivalent such as `TOP` or `FETCH FIRST` in other systems.

## Repository Structure

```text
.
├── README.md
├── task3.sql
└── sql_task3_project.zip
```

## Skills Demonstrated

- SQL data filtering
- Understanding `WHERE` vs `HAVING`
- Relational data analysis
- Aggregation and grouping
- Joins and subqueries
- Conditional aggregation
- Student performance analysis
- Analytical problem solving

## Update Log

### September 2, 2026

- Added the complete `task3.sql` practice script.
- Added practical `WHERE` examples.
- Added practical `HAVING` examples.
- Added combined row-level and group-level filtering examples.
- Expanded performance-analysis queries.
- Updated this README to document today's SQL concepts and code.
