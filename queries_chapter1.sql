select ename, city from employee;


select * from emp_company;

-- listing 1.22
select c1.cname as companyname
from company as c1
where city = 'MUMBAI';

-- listing 1.23
select e1.ename as employee_name
from employee as e1
where city = 'NAGPUR';

-- 1.24
select e1.ename as employee_name 
from emp_company as e1
where e1.cname = 'ACC' and e1.salary > 1000.00;

-- 1.25
select e1.ename as employee_name
from emp_company as e1
where e1.cname != 'ACC';

-- 1.26
select e1.ename as employee_name 
from emp_company as e1
where e1.cname = 'ACC' or e1.cname = 'TATA';


