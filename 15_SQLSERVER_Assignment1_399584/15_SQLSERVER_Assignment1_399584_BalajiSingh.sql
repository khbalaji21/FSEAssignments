Use FSE;

-- 1. Create the tables Customers and Orders with the following columns. (do not declare the corresponding primary and foreign keys)

Create table Customers(customerid char(5) not null,
CompanyName varchar(40) not null,
contactName char(30) null,
Address varchar(60) null,
City char(15) null,
Phone char(24) null,
Fax char(24) null)

Create table Orders(OrderId integer not null,
customerId char(5) not null,
Orderdate datetime null,
Shippeddate datetime null,
Freight money null,
Shipname varchar(40) null,
Shipaddres varchar(60) null,
Quantity integer null)

select * from Customers
select * from Orders


--2. Using the ALTER TABLE statement, add a new column named shipregion to the Orders table. The fields should be nullable and contain integers.

ALTER TABLE Orders ADD shipregion integer null

SELECT * from Orders


--3. Using the ALTER TABLE statement, change the data type of the column shipregion from INTEGER to CHARACTER with length 8. The fields may contain null values.

ALTER TABLE Orders ALTER COLUMN shipregion char(8) null

SELECT * from Orders


--4. Delete the formerly created column shipregion.

ALTER TABLE Orders DROP COLUMN shipregion

SELECT * from Orders


--5. sing the SQL Server Management Studio, try to insert a new row into the Orders table with the following values: (10, ‘ord01’, getdate(), getdate(), 100.0, ‘Windstar’, ‘Ocean’ ,1)

--Begin Tran
INSERT into Orders Values(10, 'ord01', GETDATE(), GETDATE(), 100.0, 'Windstar', 'Ocean', 1);
--rollback tran

select * from Orders


--6. Using the ALTER TABLE statement, add the current system date and time as the default value to the orderdate column of the Orders table

ALTER TABLE Orders ADD CONSTRAINT df_ordrdt DEFAULT GETDATE() FOR Orderdate

select * from Orders

--7. Rename the city column of the Customers table. The new name is Town

sp_rename 'Customers.city', 'Town', 'COLUMN';

SELECT * FROM Customers

--8. Create the following Tables and insert the shown data (This table will be used in the subsequent Lab sessions) 

CREATE TABLE Department(DeId varchar(5), Department varchar(20), Location varchar(20))
Insert into Department Values('d1', 'Res', 'Dallas');
Insert into Department Values('d2', 'Ac', 'Seattle');
Insert into Department Values('d3', 'Ma', 'Dallas');

SELECT * from Department

Create table Employee(emp varchar(6), emp_fna varchar(20), emp_lna varchar(20), dept varchar(5))
INSERT INTO Employee VALUES('25348', 'Matthew', 'Smith', 'd3')
INSERT INTO Employee VALUES('10102', 'Ann', 'Jones', 'd3')
INSERT INTO Employee VALUES('18316', 'John', 'Barrimor', 'd1')
INSERT INTO Employee VALUES('29346', 'James', 'James', 'd2')

SELECT * FROM Employee

CREATE TABLE Project(prjid varchar(5), project_na varchar(15), Budg integer)
INSERT INTO Project VALUES('p1', 'Apollo', 1200)
INSERT INTO Project VALUES('p2', 'Gemini', 9500)
INSERT INTO Project VALUES('p3', 'Mercury', 18560)

SELECT * FROM Project

CREATE TABLE Works_on(emp_no varchar(5), project_n varchar(5), Job varchar(15), enter_date datetime)
INSERT INTO Works_on VALUES('10102', 'p1', 'Analyst', '1997-10-1')
INSERT INTO Works_on VALUES('10102','p3', 'manager', '1999-1-1')
INSERT INTO Works_on VALUES('25348', 'p2', 'Clerk', '1998-2-15')
INSERT INTO Works_on VALUES('18316', 'p2', NULL, '1998-6-1')
INSERT INTO Works_on VALUES('29346', 'p2', NULL, '1997-12-15')
INSERT INTO Works_on VALUES('2581', 'p3', 'Analyst', '1998-10-15')
INSERT INTO Works_on VALUES('9031', 'p1', 'Manager', '1998-4-15')
INSERT INTO Works_on VALUES('28559', 'p1', NULL, '1998-8-1')
INSERT INTO Works_on VALUES('28559', 'p2', 'Clerk', '1992-2-1')
INSERT INTO Works_on VALUES('9031', 'p3', 'Clerk', '1997-11-15')
INSERT INTO Works_on VALUES('29346', 'p1', 'Clerk', '1998-1-4')

--1. Get all row of the works_on table.
SELECT * FROM Works_on

--2. Get the employee numbers for all clerks
SELECT emp_no FROM Works_on WHERE Job = 'Clerk'

--3. Get the employee numbers for employees working in project p2, and having employee numbers smaller than 10000. 
--   Solve this problem with two different but equivalent SELECT statements.
SELECT emp_no FROM Works_on WHERE project_n = 'p2' AND emp_no < 10000

--4. Get the employee numbers for all employees who didn’t enter their project in 1998.
SELECT emp_no FROM Works_on WHERE year(enter_date) <> '1998'

--5. Get the employee numbers for all employees who have a leading job (i.e., Analyst or Manager) in project p1
SELECT * FROM Works_on WHERE Job in ('Analyst', 'Manager') AND project_n = 'p1'

--6. Get the enter dates for all employees in project p2 whose jobs have not been determined yet
SELECT * FROM Works_on WHERE project_n = 'p2' AND Job is NULL 

--7. Get the employee numbers and last names of all employees whose first names contain two letter t’s 
SELECT emp, emp_lna FROM Employee WHERE emp_fna LIKE 't%' OR emp_fna LIKE '_t%'
SELECT emp, emp_lna FROM Employee WHERE emp_fna LIKE 'a%' OR emp_fna LIKE '_a%'

--8. Get the employee numbers and first names of all employees whose last names have a letter o 
--   or a as the second character and end with the letters es
SELECT emp, emp_fna FROM Employee WHERE emp_lna LIKE '%o%' OR emp_lna LIKE '_a%es'
SELECT * FROM Employee WHERE emp_lna LIKE '%o%' OR emp_lna LIKE '_a%es'

--9. Get the employee numbers of all employees whose departments are located in Seattle
SELECT * FROM Employee E INNER JOIN Department D ON E.dept = D.DeId WHERE D.location = 'Seattle'
SELECT E.emp FROM Employee E INNER JOIN Department D ON E.dept = D.DeId WHERE D.location = 'Seattle'

--10. Find the last and first names of all employess who entered their projects on 04.01.1998
SELECT * FROM Employee E INNER JOIN Works_on W ON E.emp = W.emp_no WHERE W.enter_date = '1998-01-04'
SELECT E.emp_fna, E.emp_lna FROM Employee E INNER JOIN Works_on W ON E.emp = W.emp_no WHERE W.enter_date = '1998-01-04'

--11. Group all departments using their locations
SELECT Location FROM Department GROUP BY Location

--12. Find the biggest employee number
SELECT MAX(emp) FROM Employee

--13. Get the jobs that are done by more than two employees
SELECT JOB FROM Works_on GROUP BY Job havinG COUNT(Job)>2

--14. Find the employee numbers of all employees who are clerks or work for department d3
SELECT W.emp_no FROM Works_on W INNER JOIN Employee E ON E.emp = W.emp_no WHERE E.dept = 'd3' OR W.Job = 'Clerk'

