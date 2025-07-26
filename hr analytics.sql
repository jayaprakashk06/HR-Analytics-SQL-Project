create database hr;
use hr;
drop table hr_analysyis;
create table hr_analytics(
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);
select * from  hr_analytics;

-- cleaning data

SELECT 
  EmployeeNumber, 
  COUNT(*) AS duplicate_count
FROM hr_analytics
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;

SELECT 
  SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS null_age,
  SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS null_income,
  SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS null_department
FROM hr_analytics;

-- analysis

select  Department,round(avg(MonthlyIncome)) as highest_salary_by_category
from hr_analytics
group by Department
order by highest_salary_by_category desc;

select * from hr_analytics;
select JobRole,sum(TotalWorkingYears) as total_experience
from hr_analytics
group by JobRole
order by total_experience desc;

select JobRole,sum(EmployeeCount) as count_of_employees
from hr_analytics
group by JobRole
order by count_of_employees desc;

-- which department has most leaving employees
select Attrition,Department,
count(*) as number_of_employees
from hr_analytics
group by Attrition,Department
order by number_of_employees;

-- for incremental analysis
select Department,
case
when Age <30 then 'under 30'
when Age between 30 and 39 then '30s'
when Age between 40 and 49 then '40s'
else '50s'
end as age_group,
 case 
 when YearsAtCompany<3 then '0-2 years'
 when YearsAtCompany between 3 and 6 then '3-6 years'
 when YearsAtCompany between 7 and 10 then '7-10 years'
else '10 + experience'
end as experience,
count(case when Attrition ='No' then 1 end) as employeee_count
from hr_analytics
group by age_group,experience,Department
order by experience;

select * from hr_analytics limit 10;

-- Top three salaries in each department
select * from(
select Department,EmployeeNumber,MonthlyIncome,
row_number() over(partition by Department order by MonthlyIncome desc )as rn
from hr_analytics
) as ranked
where rn<=3;

-- travelling data
select Department,BusinessTravel,
count(*) as employee_count
from hr_analytics
group by BusinessTravel,Department
order by employee_count desc;

-- travel indication in salary
select Department,BusinessTravel,
round(avg(MonthlyIncome)) as avg_salary
from hr_analytics
group by Department,BusinessTravel
order by  Department,BusinessTravel;
-- education 
select Department,EducationField,
count(*) as Education_count
from hr_analytics
group by EducationField,Department
order by Department,Education_count desc;
-- gender distribution in departments
select Department,Gender,
count(*) as gender_count
from hr_analytics
group by Department,Gender
order by Department,gender_count desc;

-- marital status for insurance
select Department,MaritalStatus,
count(*) as marital_count
from hr_analytics
group by Department,MaritalStatus
order by Department,marital_count desc;

-- performance analysis
select JobRole,
EmployeeNumber,
PerformanceRating,
dense_rank() over	(partition by JobRole order by PerformanceRating desc) as rating
from hr_analytics;

-- salary range
select EmployeeNumber,MonthlyIncome,
ntile(4) over (order by MonthlyIncome) as income_quartile
from hr_analytics;

-- department slary range using qurtile
select MonthlyIncome,Department,
ntile(4) over (order by MonthlyIncome) as income_quartile
from hr_analytics
group by MonthlyIncome,Department
order by Department;




