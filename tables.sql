/*database usage*/
use sql_study;

/*employee table*/
create table employee
(
ename varchar(10),
city varchar(10)
);

/*emp_company*/
create table emp_company
(
ename varchar(10),
cname varchar(10),
salary decimal(10,2),
jdate date
);

/*company table*/
create table company
(
cname varchar(10),
city varchar(10)
);

/*manager table*/
create table manager
(
ename varchar(10),
mname varchar(10)
);

/*employee shift table*/
create table emp_shift
(
ename varchar(10),
shift varchar(1)
);

/*describe tables*/
describe employee;

/*Data insertion*/

/*company data*/
insert into company (cname, city)
values 
('ACC', 'MUMBAI'),
('TATA', 'DELHI');

/*employee table*/
insert into employee (ename, city)
values
('ANIL', 'NAGPUR'),
('SHANKAR', 'MUMBAI'),
('JAYA', 'CHENNAI'),
('SUNIL', 'MUMBAI'),
('VIJAY', 'DELHI'),
('PRAKASH', 'KOLKATA'),
('AJAY', 'CHENNAI');

/*emp_company*/
insert into emp_company (ename, cname, salary, jdate)
values
('ANIL', 'ACC', 1500.00,STR_TO_DATE('01/05/1989', '%d/%m/%Y')),
('SHANKAR', 'TATA', 2000.00, STR_TO_DATE('10/07/1990', '%d/%m/%Y')),
('JAYA', 'CMC', 1800.00, STR_TO_DATE('07/06/1991', '%d/%m/%Y')),
('SUNIL', 'CMC', 1700.00, STR_TO_DATE('01/01/1988', '%d/%m/%Y')),
('VIJAY', 'TATA', 5000.00, STR_TO_DATE('03/01/1988', '%d/%m/%Y')),
('PRAKASH', 'TATA', 3000.00, STR_TO_DATE('27/05/1989', '%d/%m/%Y')),
('AJAY', 'ACC', 8000.00, STR_TO_DATE('30/04/1995', '%d/%m/%Y')),
('AMOL', 'ACC', 1000.00, STR_TO_DATE('27/05/1995', '%d/%m/%Y'));

/*company*/
insert into company (cname, city)
values
('ACC', 'CHENNAI'),
('TATA', 'MUMBAI'),
('ACC', 'NAGPUR'),
('CMC', 'MUMBAI'),
('CMC', 'CHENNAI'),
('TATA', 'DELHI');

/*manager*/
insert into manager (ename, mname)
values
('ANIL', 'AJAY'),
('SHANKAR', 'VIJAY'),
('JAYA', null),
('SUNIL', 'JAYA'),
('VIJAY', null),
('PRAKASH', 'SHANKAR'),
('AJAY', null);

/*emp_shift*/
insert into emp_shift (ename, shift)
values
('ANIL', 'A'),
('SUNIL', 'B'),
('VIJAY', 'B'),
('PRAKASH', 'C');