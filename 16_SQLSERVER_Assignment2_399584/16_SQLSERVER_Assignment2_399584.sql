--1. Create a non-clustered index for the enter_date column of the works_on table. Sixty percent of each index leaf page should be filled.

IF EXISTS (SELECT name FROM sys.indexes  
            WHERE name = N'IX_Work_Enterdate')   
    DROP INDEX IX_Work_Enterdate ON [dbo].[Works_on];   
GO 

CREATE NONCLUSTERED INDEX IX_Work_Enterdate   
    ON [dbo].[Works_on] (enter_date)
	WITH (FILLFACTOR = 60);  
Go

--2. Create a unique composite index for the l_name and f_name columns of the employee table.
CREATE UNIQUE NONCLUSTERED INDEX IX_Employee_Name
   ON [dbo].[Employee] ([emp_fna], [emp_lna]);

--3. Create a view that comprises the data of all employees that work for the department d1.
Go
CREATE VIEW vw_Department AS
SELECT [emp], [emp_fna], [emp_lna], [dept]
FROM [dbo].[Employee]
WHERE dept = 'd1';
Go
SELECT * FROM vw_Department

--4. For the project table, create a view that can be used by employees who are allowed to view all data of this table except the budget column
Go
CREATE VIEW vw_Project AS
SELECT [prjid], [project_na] 
FROM [dbo].[Project];
Go
SELECT * FROM vw_Project;

--5.Create a view that comprises the first and last names of all employees who entered their projects in the second half of the year 1988.
Go
CREATE VIEW vw_names_secondyear AS
SELECT E.emp_fna, E.emp_lna FROM Employee E INNER JOIN Works_on W ON E.emp = W.emp_no WHERE W.enter_date BETWEEN '1988-06-01' AND '1988-12-31';
Go
SELECT * FROM vw_names_secondyear

--6. Solve the previous exercise so that the original columns f_name and l_name have new names in the view:  first and last, respectively.
select emp_fna as first, emp_lna as last from vw_names_secondyear

--7. use the view in Exercise 3 to display full details of all employees whose last names begin with the letter M
SELECT * FROM vw_Department where emp_lna like 'M%'

--8. Create a view which comprises full details of all projects on which the employee named smith works
Go
CREATE VIEW vw_fulldtl_projects AS
SELECT * FROM Employee E INNER JOIN Works_on W ON E.emp = W.emp_no WHERE E.emp_lna = 'smith';
Go

SELECT * FROM vw_fulldtl_projects

--9. Using the ALTER VIEW statement, modify the condition in the view in Exercise-3. 
-- The modified view should comprise the data of all employees that work either for the department d1 or d2, or both
Go
ALTER VIEW vw_Department  
AS  
SELECT * FROM Works_on W INNER JOIN Employee E ON E.emp = W.emp_no WHERE E.dept in( 'd1','d2');
GO  
SELECT * FROM vw_Department

--10. Using the view from Exercise 4, insert details of a new project with project no ‘p2’ and name ‘moon’
GO  
INSERT INTO vw_Project (prjid, project_na)   
VALUES ('p2', 'moon');   
GO 

SELECT * FROM vw_Project
--11. Create a view (with the WITH CHECK OPTION clause) that comprises the first and last names of all employees whose employee number is less 
--than 10,000. After that, use the view to insert data for a new employee named Kohn with employee number 22123, who works for the department d3
Go
CREATE VIEW vw_WithCheck AS
SELECT emp_fna, emp_lna FROM Employee E WHERE emp < '10000'
WITH CHECK OPTION;
Go

SELECT * FROM vw_WithCheck
INSERT INTO vw_WithCheck (emp_fna, emp_lna) VALUES ('Balaji', 'Singh');

INSERT INTO Employee VALUES('22123', 'Kohn', '', 'd3')
INSERT INTO vw_WithCheck  VALUES('Check', 'Kohn')

--12. Create a view (with the WITH CHECK OPTION clause) with full details from the works_on table for all employees that entered their projects 
--during years 1998 and 1999. After that, modify entering date of employee with the employee number 19346. The new date is 06/01/1997
Go
CREATE VIEW vw_WorkChk AS
SELECT * FROM Works_on WHERE enter_date between '1998-01-01' and '1999-12-31'
WITH CHECK OPTION;
Go

INSERT INTO vw_WorkChk VALUES('19346', 'p3', 'Analyst', '1999-01-01')

UPDATE vw_WorkChk SET enter_date = '1997-06-01' WHERE emp_no = '19346';

SELECT * FROM vw_WorkChk
SELECT * FROM Works_on

