use company_SD
---	Display the Department id, name and id and the name of its manager.
select Dnum, Dname, MGRSSN, Fname
from Departments d , employee e
where d.MGRSSN = e.SSN
---	Display the name of the departments and the name of the projects under its control.
select  Dname, Pname
from Departments d , Project p
where d.Dnum = p.Dnum
---	Display the full data about all the dependence associated with the name of the employee they depend on him/her.
select d.*  , e.Fname
from Dependent d inner join Employee e
on d.ESSN = e.SSN;

---	Display the Id, name and location of the projects in Cairo or Alex city
select Pnumber, Pname, Plocation
from Project
where City in ('Alex', 'Cairo');
---5.	Display the Projects full data of the projects with a name starts with "a" letter.
select * from Project
where Pname like 'a%';
---6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
select * from Employee
where Dno = 30 and Salary between 1000 and 2000;
---7.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.
select e.*
from Employee e
inner join Works_for w on e.SSN = w.ESSn
inner join Project p on p.Pnumber = w.Pno
where w.Hours >= 10 and p.Dnum = 10 and p.Pname = 'AL Rabwah'; 
---8.	Find the names of the employees who directly supervised with Kamel Mohamed 
select X.Fname as employee
from Employee X , Employee Y
where Y.Fname = 'Kamel' and Y.Lname = 'Mohamed' and X.Superssn = Y.SSN;
---9.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name
select Fname +' '+Lname as name , Pname from Employee inner join Works_for on Employee.SSN = Works_for.ESSn inner join Project on
Project.Pnumber = Works_for.Pno order by Pname

--10.	For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.
select p.Pnumber , d.Dname, e.Lname, e.Address, e.Bdate
from Project p 
inner join Departments d 
on p.Dnum = d.Dnum
inner join Employee e on e.SSN = d.MGRSSN
where p.City = 'Cairo'; 
--11.	Display All Data of the managers
select e.* 
from Employee e, Departments d
where d.MGRSSN = e.SSN;
---12.	Display All Employees data and the data of their dependents even if they have no dependents
select e.*
from Employee e left join Dependent d
on e.SSN = d.ESSN;
---13.	Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
insert into Employee
values('esraa', 'selim', 102672, '2002/05/7', 'menofia', 'F', 3000,112233, 30);
---14.	Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or supervisor number to him.insert into Employee
insert into Employee
values('aya', 'ali', 102660, '2002/12/12', 'menofia', 'F', NULL,NULL, 30);
---15.	Upgrade your salary by 20 % of its last value.
update Employee
set Salary += (Salary*20)/100
where SSN = 1022672;