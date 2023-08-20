-- 1.Increase salary of employees by 30%
update emp_company 
set salary = salary*1.3;

-- 2.Decrease salary of sunil by 200
update emp_company
set salary = salary-200;

-- 3.Create table using query
-- 4.Insert data using dml statements

-- 5.Delete the emp_company where salary is less than 4000.
delete from emp_company where salary < 4000;