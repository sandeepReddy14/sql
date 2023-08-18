
-- name of manager of employee anil
select m1.mname as manager
from manager as m1
where m1.ename = 'ANIL';

-- salary of employee of acc
select e1.ename,e1.salary as salary
from emp_company as e1
where e1.cname = 'ACC';

-- name of cities where tata is located
select c1.city as city 
from company as c1
where c1.cname = 'TATA';

-- name of employees having salary greater than 2000 and less than 6000
select c1.ename as employee_name 
from emp_company as c1
where c1.salary between 2001 and 5999;

-- name of employees having salary greater than 2000 and less than 6000 from company ACC 
select c1.ename as employee_name 
from emp_company as c1
where c1.salary between 2001 and 5999 and c1.cname = 'ACC';

-- name of employees whose manager is vijay
select m1.ename as employee_name
from manager as m1
where m1.mname = 'VIJAY';
