-- 1. list number of employees living in mumbai.
select count(*)
from employee
where city = 'MUMBAI';

-- 2. list number of employees having shift A.
select count(*)
from emp_shift
where shift = 'A';

-- 3. list the names of employees with their living city having maximum salary in TATA.
select e1.ename,e1.city 
from employee as e1
where e1.ename in (
select ec1.ename from emp_company as ec1 where ec1.salary in (
select max(salary) from emp_company where cname = 'TATA')
);

-- 4. List the names of employees having max salary in a company where sunil is working.
select ec1.ename 
from emp_company as ec1
where ec1.salary in (
select max(ec2.salary) from emp_company as ec2 where ec2.cname in(select ec1.cname from emp_company as ec1 where ec1.ename = 'SUNIL')
);

-- 5. List the names of employees having max salary in their company.
select ec1.ename,ec1.cname from emp_company as ec1 where ec1.salary in
(select max(ec2.salary) from emp_company as ec2 where ec1.cname = ec2.cname );

-- 6. Find out the average salary given by each company.
select cname,avg(salary)
from emp_company
group by cname;

-- 7. Find out the average salary given by each company except ACC.
select cname,avg(salary)
from emp_company
where cname != 'ACC'
group by cname;

-- 8. Find out the names of companies HAVING average salary more than 1500.
select cname,avg(salary)
from emp_company
group by cname
having avg(salary) > 1500;

-- 9. Find out the average salary given by a company only for the employees living in DELHI.
select ec1.cname,avg(ec1.salary)
from emp_company as ec1
where ec1.ename in (select e1.ename from employee as e1 where e1.city = 'DELHI')
group by ec1.cname;

-- 10. find out the name of the company HAVING highest average salary.
select ec1.cname 
from emp_company as ec1
group by ec1.cname
having avg(ec1.salary) >= all(select avg(salary) from emp_company group by cname);
