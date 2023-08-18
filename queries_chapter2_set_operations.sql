-- 2.1 cities having ACC or TATA compaines
select city from company where cname = 'ACC'
union 
select city from company where cname = 'TATA';

-- 2.2 cities having both ACC and TATA comapnies
select c1.city from company as c1 where c1.cname = 'ACC' and c1.city in (select c2.city from company as c2 where c2.cname = 'TATA');

-- 2.3 cities having ACC but not TATA companies
select c1.city from company as c1 where c1.cname = 'ACC' and c1.city not in (select c2.city from company as c2 where c2.cname = 'TATA');

-- 2.4 displaying names of employees of acc company in nagpur
select e1.ename from employee as e1 where e1.ename in (select ec1.ename from emp_company as ec1 where ec1.cname = 'ACC') and e1.city = 'NAGPUR';

-- 2.5 names of employees who work in nagpur but not for ACC company
select e1.ename from employee as e1 where e1.ename in (select ec1.ename from emp_company as ec1 where ec1.cname  != 'ACC') and e1.city = 'NAGPUR';

-- 2.6 names of employees living in nagpur working in acc and having shift A
select e1.ename from employee as e1 where e1.ename in (select ec1.ename from emp_company as ec1 where ec1.cname = 'ACC' ) and e1.ename in (select es1.ename from emp_shift as es1 where es1.shift = 'A');

-- 2.7 names of employees living in nagpur working in acc and not working in shift A
select e1.ename from employee as e1 where e1.ename in (select ec1.ename from emp_company as ec1 where ec1.cname = 'ACC' ) and e1.ename in (select es1.ename from emp_shift as es1 where es1.shift != 'A');

-- 2.8 names of employees living in nagpur or mumbai
select e1.ename from employee as e1 where e1.city = 'NAGPUR'
union 
select e2.ename from employee as e2 where e2.city = 'MUMBAI';

select ename from employee where city = 'NAGPUR' or city = 'MUMBAI';

-- 2.9 & 2.10 union all & union 
-- union all includes duplicate rows
-- union removes duplicate rows
/*
First 2 sub-queries are joined by union results in 8 rows but using union all includes duplicate from the next sub-query
*/
select ename from employee 
union
select ename from employee
union all 
select ename from employee;

/*
First 2 sub-queries are joined by union all results in 16 rows but using union removes duplicate from the next sub-query
*/
select ename from employee 
union all
select ename from employee
union
select ename from employee;


-- 2.11 names of employees working in acc and city they live in using in clause
select e1.ename, e1.city from employee as e1 where e1.ename in (select ec1.ename from emp_company as ec1 where ec1.cname = 'ACC');

-- 2.12 employees living in mumbai and having their company located in delhi
select e1.ename from employee as e1 where e1.ename in (select ec1.ename from emp_company as ec1 where ec1.cname in ( select c1.cname from company as c1 where c1.city = 'DELHI')) and e1.city = 'MUMBAI';
select ec1.ename from emp_company as ec1 where ec1.ename in (select e1.ename from employee as e1 where e1.city = 'MUMBAI') and ec1.cname in (select c1.cname from company as c1 where c1.city = 'DELHI');
describe employee;
-- 2.13 employees who live in same city as where sunil is living
select e1.ename from employee as e1 where e1.city in (select e2.city from employee as e2 where e2.ename = 'SUNIL');

-- 2.14 employees who live in same city as where Ajay is living
select e1.ename from employee as e1 where e1.city in (select e2.city from employee as e2 where e2.ename = 'AJAY');

-- 2.15 employee names and living cities having shift-A and company ACC
select e1.ename, e1.city from employee as e1 where e1.ename in(select ec1.ename from emp_company as ec1 where ec1.cname = 'ACC') and e1.ename in (select es1.ename from emp_shift as es1 where es1.shift = 'A');

-- 2.16 employee names and living city having company city as mumbai
select e1.ename, e1.city from employee as e1 where e1.ename in (select ec1.ename from emp_company as ec1 where ec1.cname in (select c1.cname from company as c1 where c1.city = 'MUMBAI'));

-- 2.17 employee names having living city same as company city
select e1.ename from employee as e1 where e1.city in (select c1.city from company as c1 where c1.cname in(select ec1.cname from emp_company ec1 where ec1.ename = e1.ename));

-- 2.18 employee names having same company city as company city of ajay.
select ec2.ename from emp_company as ec2 where ec2.cname in (select c2.cname from company as c2 where c2.city in (select c1.city from company as c1 where c1.cname in(select ec1.cname from emp_company as ec1 where ec1.ename = 'AJAY')));

-- 2.19 displaying names of emplouyees using exists living in samme city as sunil
select e1.ename from employee as e1 where exists (select e2.city from employee as e2 where e2.ename = 'SUNIL' and e1.city = e2.city);

-- 2.20 display salaries of employees living in delhi
select ec1.salary from emp_company as ec1 where exists(select e1.ename from employee as e1 where e1.city = 'DELHI' and e1.ename = ec1.ename);

-- 2.21 display names of other employees other than amol using not exists
select ec1.ename from emp_company as ec1 where not exists( select e1.ename from employee as e1 where e1.ename = ec1.ename);
/*query outputs amol based on data not from query logic*/

-- 2.22 displaying names of employees having living city same as ajay
select e1.ename,e1.city from employee as e1 where exists(select 'x' from employee as e2 where e2.ename = 'AJAY' and e1.city = e2.city);

-- 2.23 displaying names of employees with living city having shift B and company CMC
select e1.ename, e1.city from employee as e1 where exists(select 'x' from emp_company as ec1 where ec1.cname ='CMC' and e1.ename = ec1.ename) and exists(select 'x' from emp_shift as es1 where e1.ename = es1.ename and es1.shift = 'B');

-- 2.24 displaying employee names with living city and company city as MUMBAI
select e1.ename, e1.city from employee as e1 where exists(select 'x' from emp_company as ec1 where ec1.ename = e1.ename and exists(select 'x' from company as c1 where c1.cname = ec1.cname and c1.city = 'MUMBAI'));

-- 2.25 displaying the names of employees having living city same as company city
select e1.ename from employee as e1 where exists(select 'x' from company as c1 where c1.city =  e1.city and exists(select 'x' from emp_company as ec1 where ec1.cname = c1.cname and e1.ename = ec1.ename));

-- 2.26 displaying names of employees having same company city as company city as ajay
select ec2.ename from emp_company as ec2 
where exists
(select 'x' from company as c1 
where ec2.cname = c1.cname and exists
(select 'x' from company as c2 
where c1.city = c2.city and exists
(select 'x' from emp_company as ec1 
where ec1.cname = c2.cname and ec1.ename = 'AJAY')));

/*multi column sub-queries
-- 2.27

-- 2.28
*/

-- 2.29 all info of TATA employees ename,salary,living city
select e1.ename,ec1.salary,e1.city 
from employee as e1, emp_company as ec1
where e1.ename = ec1.ename and ec1.cname = 'TATA';

-- 2.30 names of employees whose company is in delhi
select ec1.ename 
from emp_company as ec1, company as c1
where ec1.cname = c1.cname and c1.city = 'DELHI';

-- 2.31 same living city as company located city
select e1.ename 
from employee as e1, emp_company as ec1, company as c1
where e1.ename = ec1.ename and ec1.cname = c1.cname and e1.city = c1.city;

-- 2.32 employee names living in mumbai company city in delhi
select e1.ename 
from employee as e1, emp_company as ec1, company as c1
where e1.city = 'MUMBAI' and c1.city = 'DELHI' and e1.ename = ec1.ename and ec1.cname = c1.cname;

-- 2.33 names of managers and salary of employee SUNIL
select m1.mname, ec1.salary
from emp_company as ec1, manager as m1
where ec1.ename = 'SUNIL' and ec1.ename = m1.ename;

-- 2.34 names of employees having same city as sunil
select e2.ename
from employee as e1, employee as e2
where e1.city = e1.city and e2.ename = 'sunil';

-- 2.35

