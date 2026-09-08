# Advanced SQL Student Performance Analysis

**Task 3 — Updated September 8, 2026**

An advanced SQL practice project built around a student-course-enrollment database. The project demonstrates practical SQL filtering, aggregation, joins, conditional logic, subqueries, CTEs, and window functions for portfolio-style performance analysis.

## Project Summary

The project progresses from foundational grouped analysis to analytical SQL patterns used in real reporting workflows.

It demonstrates how to:

- Filter rows with `WHERE`
- Filter grouped results with `HAVING`
- Combine `WHERE`, `GROUP BY`, and `HAVING`
- Join students, courses, and enrollments
- Calculate averages, counts, minimums, and maximums
- Calculate course pass rates
- Identify top students per course
- Find the overall topper
- Perform conditional aggregation with `CASE`
- Use CTEs to build reusable analytical steps
- Rank students and courses with window functions
- Compare each grade with its course average
- Calculate running averages
- Segment students into performance quartiles with `NTILE`

## Database Model

- `students` — student information
- `courses` — course information
- `enrollments` — student-course relationships and grades

The `enrollments` table represents the many-to-many relationship between students and courses.

## Core SQL Concepts

### WHERE vs HAVING

`WHERE` filters individual rows before grouping. `HAVING` filters groups after aggregation.

```sql
SELECT student_id, AVG(grade) AS average_grade
FROM enrollments
WHERE grade >= 40
GROUP BY student_id
HAVING AVG(grade) >= 80;
```

### CTEs and Window Functions

The new `advanced_analytics.sql` file extends the project with analytical SQL patterns:

- `WITH` common table expressions for readable multi-step analysis
- `RANK()` for overall student rankings
- `DENSE_RANK()` for department-level rankings
- `PARTITION BY` for rankings within groups
- `AVG() OVER()` for course averages and running averages
- `NTILE(4)` for performance quartiles
- Comparison of individual grades against course benchmarks

These techniques are useful for dashboards, performance reports, cohort analysis, and business intelligence workflows.

## Main Analysis

1. Top Student Per Course
2. Pass Rate Per Course
3. Overall Topper
4. Multiple-Course Enrollment
5. Student Performance Summary
6. Department-Level Performance
7. Conditional Aggregation
8. Overall and Department Student Ranking
9. Course Ranking Within Department
10. Grade vs Course Average Benchmarking
11. Running Student Average
12. Student Performance Quartiles

## SQL Concepts Practiced

- `SELECT`, `FROM`, `WHERE`
- `JOIN`, `GROUP BY`, `HAVING`
- `ORDER BY`, `LIMIT`
- `AVG`, `COUNT`, `SUM`, `MIN`, `MAX`
- `CASE` and conditional aggregation
- Subqueries
- Common table expressions (`WITH`)
- Window functions
- `RANK`, `DENSE_RANK`, `NTILE`
- `PARTITION BY`
- Foreign keys and many-to-many relationships

## Files

```text
.
├── README.md
├── task3.sql
├── advanced_analytics.sql
└── sql_task3_project.zip
```

### `task3.sql`

Contains the complete runnable Task 3 dataset, filtering examples, grouped analysis, pass-rate calculations, topper analysis, and conditional aggregation.

### `advanced_analytics.sql`

Adds a second analytical layer using CTEs and window functions. Run it after `task3.sql` has created and populated the tables.

## How to Run

1. Open MySQL, PostgreSQL, SQLite, or another compatible SQL environment.
2. Run `task3.sql` first to create the tables and sample data.
3. Run `advanced_analytics.sql` to execute the advanced analytical queries.
4. Review each result and compare the window-function output with the grouped results from Task 3.

> SQL syntax can vary between database systems. The core concepts are portable, while functions such as `LIMIT` may require an equivalent such as `TOP` or `FETCH FIRST` in some systems.

## Skills Demonstrated

- SQL data filtering and aggregation
- Relational joins and subqueries
- CTE-based query design
- Window-function analytics
- Ranking and segmentation
- Benchmark comparison
- Student performance analysis
- Portfolio-oriented analytical problem solving

## Update Log

### September 8, 2026

- Added `advanced_analytics.sql`.
- Added student ranking with `RANK()` and `DENSE_RANK()`.
- Added course ranking within departments.
- Added grade-versus-course-average benchmarking.
- Added running student averages.
- Added performance quartiles using `NTILE(4)`.
- Updated README to document the advanced analytics layer.

### September 2, 2026

- Added the complete `task3.sql` practice script.
- Added practical `WHERE` and `HAVING` examples.
- Added combined row-level and group-level filtering examples.
- Expanded performance-analysis queries.
