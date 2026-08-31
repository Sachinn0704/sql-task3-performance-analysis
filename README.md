# Advanced SQL Student Performance Analysis

An advanced SQL analysis project that builds on a student-course-enrollment database to answer deeper academic performance questions.

## Project Summary

The project uses joins, grouping, conditional aggregation, and filtering to identify top students, calculate course pass rates, find the overall topper, and detect students enrolled in multiple courses.

## Database Model

- `students` — student information
- `courses` — course information
- `enrollments` — student-course relationships and grades

The enrollment table represents the many-to-many relationship between students and courses.

## Main Analysis

### 1. Top student per course

Identifies the highest recorded grade in each course.

### 2. Pass rate per course

Calculates the percentage of enrollment records with a grade of at least 40.

### 3. Overall topper

Ranks students using their average grade across enrolled courses.

### 4. Multiple-course enrollment

Finds students enrolled in more than one course.

## SQL Techniques

- JOIN
- GROUP BY
- HAVING
- ORDER BY
- Aggregate functions
- CASE expressions
- Subqueries
- Conditional aggregation

## How to Run

1. Open MySQL, PostgreSQL, SQLite, or another compatible SQL environment.
2. Ensure the `students`, `courses`, and `enrollments` tables exist.
3. Run `task3.sql`.
4. Execute the analysis queries.
5. Review the results and compare course/student performance.

## Repository Structure

```text
.
├── task3.sql
└── README.md
```

## Skills Demonstrated

- Advanced SQL querying
- Relational data analysis
- Performance ranking
- Conditional aggregation
- Data interpretation
- Problem solving with SQL
