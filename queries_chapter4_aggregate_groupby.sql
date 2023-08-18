/*
Aggregate functions and group by clause
*/

/*
-- AGGREGATE FUNCTIONS :
1.Aggregate functions are used for performing group operations.
2.Aggregate functions are used to calculate single values for group of rows.
3.First, data source is chosen on which operation is performed. In the absence of 
	the GROUP BY clause, a single group is formed from the rows on which aggregate function is evaluated.
    If there is a GROUP BY clause then multiple groups are formed and a row is returned for each group.
4.When using aggregate function in SELECT, other expressions in SELECT should also represent group property.
5.Commonly used aggregate functions are max(),min(),sum(),avg(),count(),variance(),stdev() standard-deviation.
6.max(),min(),sum(),avg() will return null if there are no matching rows.
	To get some default value use NVL function  nvl(max(salary),0) returns 0 if no matching records are found defined only in oracle.
*/

/*
-- GROUP BY CLAUSE:
1.The GROUP BY clause is used to compute aggregate functions of a group.
2.When GROUP BY is specified, then all the rows having same value of group by 
	expression are grouped together into one group.
*/

/*
-- HAVING CLAUSE:
1.The HAVING clause is used to provide condition on a group of rows. The where clause is used to 
	provide condition on the row value but the having clause is used to provide condition on the
    group value.
2.The query execution is as follows:
	-> the from clause determines data source.
    -> For each row in data source where condition is evaluated and rows are selected.
    -> On the selected rows, groups are formed according to GROUP BY clause.
    -> for each group having condition is applied and the row groups satisfying are given as output.
*/

/*
-- WITH CLAUSE:
1.Using with clause, you can reduce the overheads for computing same queries.
	Temporary tables are created based on the result and those can be used for the rest of the query evaluation.
*/

/*
-- ORDER BY CLAUSE:
1.The ORDER BY clause is used to sort data.
2.order by <col_name1/col_number1> <asc/desc>, <col_name2/col_number2> <asc/desc>, ....
*/

-- 4.1 list maximum salary of all employees.
select max(salary)
from emp_company;

-- 4.2 maximum salary of ACC employees.
select max(salary)
from emp_company 
where cname = 'ACC';

-- 4.3 Display name of employee having maximum salary.
select ec1.ename 
from emp_company as ec1
where ec1.salary in (select max(ec2.salary) from emp_company as ec2);

-- 4.4 Counting the number of employees working in ACC.
select count(ename)
from emp_company
where cname = 'ACC';

-- 4.5 return number of rows using count function in emp_company.
select count(*)
from emp_company;

-- 4.6 usage of NVL function.(nvl is defined in oracle)
-- select nvl(max(salary),0)
-- from emp_company 
-- where ename = 'sandeep';

-- 4.7 display number of employees living in mumbai
select count(ename)
from employee
where city = 'MUMBAI';

-- 4.8 display number of employees having shift A.
select count(ename)
from emp_shift
where shift = 'A';

-- 4.9 display names of employees with their city and maximum salary in TATA.
select e1.ename, e1.city 
from employee as e1
where e1.ename in (
select ec1.ename from emp_company as ec1 where ec1.salary in 
(select max(ec2.salary) from emp_company as ec2 where ec2.cname = 'TATA'));

-- 4.10 display names of employee having max salary in company where SUNIL is working
select ec1.ename 
from emp_company as ec1
where ec1.salary in 
(select max(ec2.salary) from emp_company as ec2 where ec2.cname in 
(select cname from emp_company where ename = 'SUNIL')
);

-- 4.11 display the name of employees having maximum salary in their company(with out group by clause).
select ec1.ename 
from emp_company as ec1 
where ec1.salary in (select max(ec2.salary) from emp_company as ec2 where ec1.cname = ec2.cname);

-- GROUP BY EXAMPLES:-

-- 4.12 display the names of companies ans max salary in that company.
select cname, max(salary)
from emp_company
group by cname;

-- 4.13 calculate the number of employees for each company. 
select cname, count(ename)
from emp_company 
group by cname;

-- HAVING CLAUSE EXAMPLES:-

-- 4.14 display companies having more than one employee.
select cname,count(ename)
from emp_company 
group by cname
having count(ename) > 1;

-- 4.15 find avg salary of each company
select cname,avg(salary)
from emp_company
group by cname;

-- 4.16 display avg salary of each company except ACC
select cname,avg(salary)
from emp_company
where cname != 'ACC'
group by cname;

-- 4.17 find companies with avg salary more than 1500
select cname, avg(salary)
from emp_company
group by cname
having avg(salary) > 1500;

-- 4.18 display average salary of a company only for the employees living in delhi.
select ec1.cname,avg(ec1.salary)
from emp_company as ec1
where ec1.ename in (select e1.ename from employee as e1 where e1.city = 'DELHI')
group by ec1.cname;

-- 4.19 name of company having highest average salary.
select ec1.cname,avg(ec1.salary)
from emp_company as ec1
group by ec1.cname
having avg(ec1.salary) >= all(select avg(ec2.salary) from emp_company as ec2 group by ec2.cname);

-- WITH CLAUSE EXAMPLES:-

-- Average salary of all companies and names of companies having the total salary more than the average salary.
with 
companysalary as (select cname,sum(salary) as totalsalary from emp_company group by cname),
companyavgsalary as (select avg(totalsalary) as avgsalary from companysalary)
select cname,totalsalary 
from companysalary
where totalsalary > (select avgsalary from companyavgsalary);

-- ratio of salaries of anil & sunil
with
anilsalary as (select salary from emp_company where ename = 'anil'),
sunilsalary as (select salary from emp_company where ename = 'sunil')
select t1.salary,t2.salary,t1.salary/t2.salary
from anilsalary as t1,sunilsalary as t2;

-- ORDER BY EXAMPLES:-

-- 4.20 sorting output on ename.
select ename,cname 
from emp_company 
order by ename asc;

-- 4.21 displaying output in descending order by ename.
select ename, cname
from emp_company
order by ename desc;

-- 4.22 sorting on cname in ascending order, if cname is same sorting on ename in descending order.
select ename,cname
from emp_company 
order by cname asc,ename desc;
