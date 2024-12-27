use Company_SD 
--1.	Display (Using Union Function)a.	
---The name and the gender of the dependence that's gender is Female and depending on Female Employee.b.
---	 And the male dependence that depends on Male Employee.
select Dependent.Dependent_name , Dependent.Sex 
from Dependent inner join Employee 
on Employee.SSN = Dependent.ESSN and Employee.Sex='F' and Dependent.Sex='F'
union all
select Dependent.Dependent_name , Dependent.Sex 
from Dependent inner join Employee 
on Employee.SSN = Dependent.ESSN and Employee.Sex='M' and Dependent.Sex='M' 
--2.	For each project, list the project name and the total hours per week (for all employees) spent on that project.
select  p.Pname, sum(w.Hours)
from Project p inner join Works_for w
on p.Pnumber = w.Pno
group by p.Pname
--3.	Display the data of the department which has the smallest employee ID over all employees' ID.
select *
from Departments
where Dnum = (select Dno from Employee where SSN = (select  min(SSN)from Employee))
--4.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees
select Dname, min(e.Salary), max(e.Salary), avg(e.Salary)
from Employee e inner join Departments d
on e.Dno = d.Dnum
group by d.Dname
--5.	List the full name of all managers who have no dependents
select Fname +' '+Lname as name , SSN 
FROM Employee a inner join Departments b
on a.SSN = b.MGRSSN and not exists  (select * from Dependent where b.MGRSSN = Dependent.ESSN)
--66.	For each department
-- if its average salary is less than the average salary of all employees
-- display its number, name and number of its employees
select avg(Salary) as Average , d.Dname, d.Dnum ,count(SSN) as[Number of employees]
from Employee e inner join Departments d
 on d.Dnum = e.Dno 
 group by d.Dnum , d.Dname
 having avg(Salary) <(select avg(Salary)from Employee)
 --7.	Retrieve a list of employee’s names and 
 --the projects names they are working on ordered by department number and within each department, ordered alphabetically by last name, first name.
 select e.*, p.*
from Departments d inner join Project p
on d.Dnum = p.Dnum
inner join Employee e 
on e.Dno = d.Dnum
order by d.Dname  ,e.Lname ,e.Fname;
--88.	Try to get the max 2 salaries using sub query
select Salary
from Employee 
where salary >=(select max(Salary)from Employee 
where Salary <(select max(Salary)from Employee ))
--9.	Get the full name of employees that is similar to any dependent name
select  e.Fname + ' ' + e.Lname
from Employee e , Dependent d
where e.Fname + ' ' + e.Lname = d.Dependent_name;
--10.	Display the employee number and name if at least one of them have dependents (use exists keyword) 
select Fname +' '+Lname as name , SSN , SSN FROM Employee a 
where  exists (select * from Dependent where a.SSN = Dependent.ESSN)
--11.	In the department table insert new department called "DEPT IT”, with id 100,
-- employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006
insert into Departments values('DEPT IT',100,112233,'1-11-2006')
--12.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)
-- moved to be the manager of the new department (id = 100), and they give you(your SSN =102672) her position (Dept. 20 manager) 

--a.	First try to update her record in the department table
---b.	Update your record to be department 20 manager.
--c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)

update Departments
set MGRSSN = 968574
where Dnum = 100;

update Departments
set MGRSSN = 102672
where Dnum = 20;

update Employee
set Dno =
(select Dnum from Departments where MGRSSN = 102672),
Superssn =102672
where SSN = 102660

--13.	Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344)
--- so try to delete his data from your database in case you know that you will be temporarily in his position.
---Hint: (Check if Mr. Kamel has dependents, works as a department manager, 
----supervises any employees or works in any projects and handle these cases).
delete from Dependent where ESSN=223344
update Departments
set MGRSSN = 102672
where MGRSSN =223344
update Employee
set Superssn = 102672
where Superssn =223344
update Works_for
set ESSn = 102672
where ESSn =223344
delete from Employee where SSN=223344
--14.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%
update Employee 
set Salary += Salary*.3
from Employee e inner join Works_for w on e.SSN= w.ESSn inner join Project p on p.Pnumber = w.Pno and p.Pname='Al Rabwah'



