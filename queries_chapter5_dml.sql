/*
DML-Data Manipulation Language.
To change or update data of table.
UPDATE & DELETE statements are used to do changes to rows of a table.
*/

/*
-- UPDATE:
1.UPDATE statement is used to update existing rows in a table.
2.Only one table can be updated at a time.
3.Joins or cartesian products cannot be used for specifying conditions.
4.To make references from other tables use WHERE statement with IN or EXISTS clause. 
5.Syntax -> update <table_name> set col1=val1,col2=val2,.... where <condition>
*/

/*
-- DELETE:
1.DELETE statement only deletes rows, not table.
2.Joins or cartesian products cannot be used for specifying conditions.
3.To make references from other tables use WHERE statement with IN or EXISTS clause.
4. syntax -> delete from <table_name> <condition>
*/

/*
-- Dropping a table:
1.Deletes entire table not just rows.
2.syntax -> drop table <table_name> 
*/

/*
-- Renaming table:
1.Syntax -> rename table <table_old_name> to <table_new_name>
*/

/*
-- Inserting Data using Query DML
1.If data has to be transferred to one table to another, the insert statement is used along with select.
2. Order of select should be compatible table column
*/

-- 5.1 Inrease salary of employee by 20%
update emp_company 
set salary = salary*1.2;

-- 5.2 Increase salary of ACC employee by 20%
update emp_company
set salary = salary*1.2
where cname = 'ACC';

-- 5.3 Increase salary of sunil by 100 if anil & sunil work for ACC(?)
with 
anilbool as (select ename from emp_company where ename = 'ANIL' and cname = 'ACC')
update emp_company
set salary = salary+100
where ename = 'SUNIL' and cname = 'ACC' and exists(select * from anilbool);

-- 5.4 decrease salary of vijay  by 100 if both vijay and sunil are living in CHENNAI
update emp_company 
set salary = salary - 100
where ename = 'VIJAY' and exists(select * from employee where ename = 'VIJAY' and city = 'CHENNAI')
and exists(select * from employee where ename = 'SUNIL' and city = 'CHENNAI');

-- 5.5 increase salary of employees by 15% living in chennai.
update emp_company 
set salary = salary*1.15
where ename in (select ename from employee where city = 'CHENNAI');

-- 5.6 change cname from acc to tata for employees whose salary is greater than 8000 lives in mumbai.
update emp_company
set cname = 'TATA'
where salary > 8000 and cname = 'ACC' and ename in (select ename from employee where city = 'MUMBAI');

-- 5.7 change cname from acc to tata and increase salary by 20% for employees whose salary is greater than 8000 lives in mumbai.
update emp_company
set cname = 'TATA', salary = salary*1.2
where salary > 8000 and cname = 'ACC' and ename in (select ename from employee where city = 'MUMBAI');

-- 5.8 increase salary of sunil by 100 and decrease vijay's salary by 100
update emp_company 
set salary = salary + 100
where ename = 'SUNIL';

update emp_company 
set salary = salary - 100
where ename = 'VIJAY';

-- 5.9 redacted

-- 5.10 Assign salary of VIJAY to SUNIL where salary of SUNIL is unknown
with 
sunilsal as (select salary from emp_company where ename = 'SUNIL')
update emp_company
set salary = (select salary from sunilsal)
where ename = 'VIJAY';

-- 5.11 Assign salary of VIJAY to SUNIL+VIJAY's salary where salary of SUNIL is unknown
with 
sunilsal as (select salary from emp_company where ename = 'SUNIL')
update emp_company
set salary = salary + (select salary from sunilsal)
where ename = 'VIJAY';

-- 5.15 delete all rows from employee table having city chennai.
delete from employee where city = 'CHENNAI';

-- 5.16 delete employees from emp_company table who live in mumbai.
delete from emp_company where ename in (select ename from employee where city = 'MUMBAI');

-- 5.17 delete rows of the emp_company table having salary greater than 8000
delete from emp_company where salary > 8000;

-- 5.18 delete rows of the emp_company table with salary greater than 8000, lives in chennai, company is in mumbai.
delete from emp_company where salary > 8000 and 
ename in (select ename from employee where city = 'CHENNAI')
and cname in (select cname from company where city = 'MUMBAI');

-- 5.19 delete employee table
drop table employee;

-- 5.20 rename employee table to emp
rename table employee to emp;

-- 5.21 employee names from employee to emp_shift
insert into emp_shift (ename) select ename from employee;

-- 5.22 employee names from employee to emp_shift with shift as 'Z'
insert into emp_shift (ename,shift) select ename,'Z' from employee;

-- 5.23 insert row into emp_company with ename as anil salary equal to avg salary of ACC
insert into emp_company (ename,salary) 
select 'ANIL',avg(salary) from emp_company where cname = 'ACC';

-- 5.24 insert rows in employee with employee of company as acc having same ciy as ACC
insert into employee (ename,city)
select ec1.ename,c1.city
from emp_company as ec1,company as c1
where ec1.cname = 'ACC' and ec1.cname = c1.cname;
