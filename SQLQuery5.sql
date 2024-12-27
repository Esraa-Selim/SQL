use ITI 
--1.	Retrieve number of students who have a value in their age.
select count(St_Id) as StudentCount from Student where st_age is not null 
--2.	Get all instructors Names without repetition
select distinct Ins_Name from Instructor
--3.	Display student with the following Format (use isNull function)
select St_Id as [Student ID], isnull(St_Fname + ' ' + St_Lname, '') as [Student Full Name],
		Dept_Name as [Department name]
from Student s inner join Department d
on d.Dept_Id = s.Dept_Id 
--4.	Display instructor Name and Department Name 
--Note: display all the instructors if they are attached to a department or not 
select Ins_Name, Dept_Name
from Instructor i left join Department d
on d.Dept_Id = i.Dept_Id 
--5.	Display student full name and the name of the course he is taking
--For only courses which have a grade 
select St_Fname + ' ' + St_Lname as [full name], Crs_Name
from Student s inner join Stud_Course sc
on s.St_Id = sc.St_Id
inner join Course c
on c.Crs_Id = sc.Crs_Id
where grade is not null 
--6.	Display number of courses for each topic name 
select t.Top_Id, count(Crs_Id)
from Topic t inner join Course c
on t.Top_Id = c.Top_Id
group by t.Top_Id 
--7.	Display max and min salary for instructors 
select max(salary) as maxS, min(salary) as minS
from Instructor 
--8.	Display instructors who have salaries less than the average salary of all instructors 
select *  from Instructor where Salary < (select avg(Salary) from Instructor) 
-- 9.	Display the Department name that contains the instructor who receives the minimum salary
 select Dept_Name
from Instructor i inner join Department d
on i.Dept_Id = d.Dept_Id and Salary = (select min(salary)from Instructor) 
-- 10 Select max two salaries in instructor table 
select top(2) salary from Instructor order by Salary desc 
--11.	 Select instructor name and his salary but if there is no salary display instructor bonus keyword. “use coalesce Function” 
select Ins_Name as InstuctorName, coalesce(convert(nvarchar(20),salary),'instructor bonus') as Salary from Instructor
--12.	Select Average Salary for instructors 
 select AVG(salary)
from Instructor 
--13.	Select Student first name and the data of his supervisor 
select s.St_Fname ,super.*
from Student s inner join student super
on s.St_super = super.St_Id 
--14.	Create a view that displays student full name, course name if the student has a grade more than 50. 
Create view Student_Details	
as
select concat(s.St_Fname,' ',s.St_Lname) as FullName ,c.Crs_Name As CourseName , Grade from Student as S 
		inner join Stud_Course as SC on s.St_Id=sc.St_Id and Grade > 50
		inner join Course as C on c.Crs_Id=sc.Crs_Id 
--- 15 Create an Encrypted view that displays manager names and the topics they teach.  
alter view View_MangerDetails
with encryption
as
select Ins.Ins_Name as ManagerName , Top_Name as Topic from Department as Dept 
		inner join  Instructor as Ins on Dept.Dept_Manager = ins.Ins_Id 
		inner join Ins_Course on ins.Ins_Id=Ins_Course.Ins_Id
		inner join Course on Ins_Course.Crs_Id = Course.Crs_Id
		inner join Topic on Topic.Top_Id = Course.Top_Id
WITH CHECK OPTION;

select * from View_MangerDetails 
---16.	Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department  
Create view View_InsDeptDetails
as
select Ins_Name as InstuctorName , Dept_Name as DepartmentName from Instructor 
		inner join Department on Department.Dept_Id=Instructor.Dept_Id and Dept_Name in ('SD','Java')

select * from View_InsDeptDetail