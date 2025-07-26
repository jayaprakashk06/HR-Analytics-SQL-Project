# HR-Analytics-SQL-Project


## Project Overview
This project involves comprehensive HR data analysis using SQL, focusing on employee metrics, department analytics, and workforce insights. The analysis covers various aspects of human resources including salary distributions, attrition rates, department-wise analytics, and employee performance metrics.

## Table Structure
The project uses a main table `hr_analytics` with the following key columns:
- Employee Demographics (Age, Gender, Education)
- Job-related Information (Department, Job Role, Salary)
- Performance Metrics (Performance Rating, Job Satisfaction)
- Career Progress (Years at Company, Promotions)
- Work Conditions (Business Travel, Work Life Balance)

## Key Analysis Areas

### 1. Data Quality Checks
- Duplicate employee record verification
- Null value identification in critical fields
- Data consistency validation

### 2. Departmental Analysis
- Average monthly income by department
- Employee distribution across departments
- Department-wise attrition rates

### 3. Employee Demographics
- Age group distribution
- Gender distribution by department
- Educational background analysis
- Marital status statistics

### 4. Compensation Analysis
- Salary quartile analysis
- Top three salaries in each department
- Salary variations based on business travel

### 5. Performance Metrics
- Performance ratings by job role
- Work experience analysis
- Employee tenure analysis

### 6. Travel and Work Patterns
- Business travel patterns by department
- Travel impact on compensation
- Work-life balance metrics

## SQL Features Used
- Aggregate Functions
- Window Functions (ROW_NUMBER, DENSE_RANK, NTILE)
- CASE Statements
- CTEs and Subqueries
- GROUP BY and ORDER BY operations
- Data Filtering and Sorting

## How to Use
1. Create a database named 'hr'
2. Execute the table creation script
3. Import your HR data
4. Run the analysis queries as needed

```sql
-- Example: Create Database and Table
create database hr;
use hr;
create table hr_analytics(
    -- [table structure as in your code]
);
```

## Analysis Examples

### Department-wise Salary Analysis
```sql
select Department, round(avg(MonthlyIncome)) as highest_salary_by_category
from hr_analytics
group by Department
order by highest_salary_by_category desc;
```

### Attrition Analysis
```sql
select Attrition, Department,
count(*) as number_of_employees
from hr_analytics
group by Attrition, Department
order by number_of_employees;
```

## Contributing
Feel free to contribute to this project by:
1. Forking the repository
2. Creating your feature branch
3. Committing your changes
4. Pushing to the branch
5. Creating a new Pull Request
   
## Author
- [@jayaprakashk06](https://github.com/jayaprakashk06)
