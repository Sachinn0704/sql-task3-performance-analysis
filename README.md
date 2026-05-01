# 📊 SQL Advanced Student Performance Analysis (Task 3)

## 📌 Project Overview

This project is a continuation of the SQL Data Analysis Internship. After building the database with **students, courses, and enrollments**, this task focuses on performing **advanced SQL analysis**.

The goal is to extract deeper insights using:

* JOINs
* GROUP BY
* HAVING
* Subqueries

---

## 🎯 Objectives

* Analyze student performance using advanced SQL queries
* Identify top-performing students per course
* Calculate pass rates across courses
* Determine the overall topper
* Find students enrolled in multiple courses

---

## 🗂️ Repository Structure

```
sql-advanced-analysis-task3/
│
├── task3.sql
└── README.md
```

---

## 🗄️ Database Overview

This project uses the following tables:

* **students** → Stores student details
* **courses** → Stores course information
* **enrollments** → Links students with courses and stores grades

---

## 🔗 Relationships

* One student → Multiple courses
* One course → Multiple students
* Many-to-many relationship handled using `enrollments`

---

## 📊 SQL Queries & Analysis

### 1️⃣ Top Student per Course

Finds the highest-scoring student in each course.

```sql
SELECT c.name AS course, s.name AS student, MAX(e.grade) AS top_grade
FROM enrollments e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id
GROUP BY c.name;
```

---

### 2️⃣ Pass Rate per Course

Calculates percentage of students scoring **≥ 40**.

```sql
SELECT c.name,
SUM(CASE WHEN e.grade >= 40 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS pass_rate
FROM enrollments e
JOIN courses c ON e.course_id = c.id
GROUP BY c.name;
```

---

### 3️⃣ Overall Topper

Finds the best student across all courses.

```sql
SELECT s.name, AVG(e.grade) AS avg_grade
FROM enrollments e
JOIN students s ON e.student_id = s.id
GROUP BY s.name
ORDER BY avg_grade DESC
LIMIT 1;
```

---

### 4️⃣ Students Enrolled in Multiple Courses

Identifies students taking more than one course.

```sql
SELECT student_id, COUNT(course_id) AS total_courses
FROM enrollments
GROUP BY student_id
HAVING COUNT(course_id) > 1;
```

---

## 🚀 How to Run

### Requirements

* MySQL / PostgreSQL / SQLite
* SQL Editor (VS Code / DB Fiddle / SQLite Online)

### Steps

1. Open your SQL environment
2. Ensure database with required tables exists
3. Run `task3.sql`
4. Execute queries
5. Analyze results

---

## 📈 Key Insights

* Identifies top-performing students per course
* Calculates pass percentage for performance evaluation
* Helps detect multi-course enrollment patterns
* Useful for academic performance tracking

---

## 🎓 Learning Outcomes

* Writing advanced SQL queries
* Using JOIN + GROUP BY + HAVING
* Applying conditional aggregation
* Performing real-world data analysis

---

## 🧠 Skills Demonstrated

* SQL (Advanced)
* Data Analysis
* Query Optimization
* Problem Solving



