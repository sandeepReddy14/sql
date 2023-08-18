-- ONLY USING IN AND EXISTS

-- 1.List name of employees having living city same as AJAY.

-- 2.List name of employees with their living city having shift B and company ACC

-- 3.List name of eployees with their living city having company city as MUMBAI

-- 4.List name of employees having living city same as company city

-- 5.List name of employee having same company city as company city of AJAY


-- CARTESIAN PRODUCT

-- 1.List of employees whose company city is NAGPUR
select ec1.ename 
from emp_company as ec1,company as c1
where ec1.cname = c1.cname and c1.city = 'NAGPUR';

-- 2. list name of employees having company located in Nagpur and shift is B
select ec1.ename 
from emp_company as ec1,company as c1,emp_shift as es1
where ec1.cname = c1.cname and ec1.ename = es1.ename and c1.city = 'NAGPUR' and es1.shift = 'B';

-- 3. List name of employees company location nagpue shift is B living in MUMBAI
select e1.ename
from emp_company as ec1,company as c1,emp_shift as es1,employee as e1
where e1.ename = ec1.ename and ec1.cname = c1.cname and ec1.ename = es1.ename and c1.city = 'NAGPUR' and es1.shift = 'B' and e1.city = 'MUMBAI'  ;

-- 4. List name of employees whose company city is same as living city and shift is B
select e1.ename
from employee as e1, emp_company as ec1,company as c1,emp_shift as es1
where e1.ename = ec1.ename and ec1.ename = es1.ename and ec1.cname = c1.cname and e1.city = c1.city and es1.shift = 'B';

-- 5. List employees whose salary is more than 2000 and living city is nagpur.
select e1.ename
from employee as e1,emp_company as ec1
where e1.ename = ec1.ename and e1.city = 'NAGPUR' and ec1.salary > 2000;

-- SELF JOIN

-- 1.List name of employees having same company as company of vijay.
select ec2.ename 
from emp_company as ec1,emp_company as ec2
where ec1.ename = 'VIJAY' and ec1.cname = ec2.cname;

-- 2.List name of employees having same company as company of vijay and salary more than 1000.
select ec2.ename 
from emp_company as ec1,emp_company as ec2
where ec1.ename = 'VIJAY' and ec1.cname = ec2.cname and ec2.salary > 1000;

-- 3.List name of employees having same company as company of vijay and shift B
select ec2.ename 
from emp_company as ec1,emp_company as ec2,emp_shift as es1
where ec1.ename = 'VIJAY' and ec1.cname = ec2.cname and ec2.ename = es1.ename and es1.shift = 'B';

-- 4.List name of employees having same company as company of vijay and same living city as AJAY.
select ec2.ename
from emp_company as ec1,emp_company as ec2,employee as e1, employee as e2
where ec1.ename = 'VIJAY' and ec1.cname = ec2.cname and ec2.ename = e1.ename and e1.city = e2.city and e2.ename = ec2.ename and e1.ename = 'VIJAY';

-- 5.List name of employees having same company city as company city of vijay,
-- Give name of employee living in the same city where their manager also is living.
-- Give salary of manager of employee living in city 'MUMBAI'.
