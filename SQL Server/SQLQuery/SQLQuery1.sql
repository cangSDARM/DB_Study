/*
（1）查询计算机系学生的修课情况，要求列出学生的名字、所修课的课程号和成绩。
（2）查询“信息管理系”修了“计算机文化学” 的学生姓名和成绩。
（3）查询所有选修了Java课程的学生情况，列出学生姓名和所在系。
（4）统计每个系的学生的考试平均成绩。
（5）查询与“刘晨”在同一个系学习的学生。
（6）查询考试成绩大于90分的学生的学号和姓名。
（7）查询计算机系选了“C002”课程的学生，列出姓名和性别。
（8）查询选修了“Java”课程的学生的学号和姓名。
（9）统计选了Java课程的这些学生的选课门数和平均成绩。
（10）查询选了“JAVA”课程的学生学号、姓名和JAVA成绩。
（11）查询选了“C004”号课程且成绩高于此课程的平均成绩的学生的学号和成绩。
（12）查询考试平均成绩高于全体学生的总平均成绩的学生的学号和平均成绩。
（13）查询没选“C001”号课程的学生姓名和所在系。
（14）查询计算机系没选JAVA课程的学生姓名和性别。
(15) 查询其他学期开设的课程中比第1学期开设课程的学分少的课程名、开课学期和学分。
（16）查询至少有一次成绩大于等于90的学生的姓名，所修的课程号和成绩。
（17）查询比第1学期开设的所有课程的学分都小的其他学期开设的课程名、开课学期和学分。
（18）查询每个学期学分最低的课程的课程名、开课学期和学分。
（19）查询每门课程考试成绩最高的两个学生的学号以及相应的课程号和成绩。不包括没考试的课程。
（20）查询每门课程中，考试成绩低于该门课程的平均成绩的学生的学号和成绩。
（21）查询有最高学分超过本学期平均学分1.5倍的学期。
（22）查询学生姓名、所在系和该学生选的课程门数。
（23）查询课程名、开课学期及选该门课的学生人数、平均成绩。不包括没人选的课程。
(24) 使用exists查询选了“C002”课程的学生姓名。
（25）使用exists查询选了JAVA课程的学生姓名和所在系。
（26）使用exists查询没有选修“C001”课程的学生姓名和所在系。
(27) 使用exists查询计算机系没选JAVA的学生姓名和性别。
(28) 使用exists查询至少选了全部课程的学生的学号、姓名和所在系。
(29) 使用exists查询至少选了“0811102”学生所选的全部课程的学生的学号和所选的课程号。
 */
use xkgl
--1
select student.Sname, SC.Cno, SC.Grade from student right join SC on SC.Sno = student.Sno where student.Sdept = '计算机系';
--2
select student.Sname, SC.Grade from student right join SC on SC.Sno = student.Sno right join Course on Course.Cno = SC.Cno where Course.Cname = '计算机文化学' and student.Sdept = '信息管理系'
--3
select student.Sname, student.Sdept from student right join SC on SC.Sno = student.Sno right join Course on Course.Cno = SC.Cno where Course.Cname = 'Java'
--4
select avg(SC.Grade) as 'avgGrade' from SC right join student on student.Sno = SC.Sno group by student.Sdept
--5
select SC.Cno, count(SC.Sno), avg(SC.Grade), max(SC.Grade), min(SC.Grade) from SC left join student on student.Sno = SC.Sno where student.Sdept='计算机系' group by SC.Cno
--6
select A.Sname, A.Sdept from student as A left join student as B on B.Sdept = A.Sdept where B.Sname = '刘晨'
--7
select A.Cname, A.Semester from Course as A left join Course as B on B.Semester = A.Semester where B.Cname = '数据结构'
--8
select SC.Cno from SC group by SC.Cno having count(SC.Sno) > 1
--9
select student.Sname, SC.Cno from student inner join SC on SC.Sno = student.Sno
--10
select Cno from Course where not exists(select*from SC where Cno=Course.Cno)
--11
select Sname, Ssex from student left join SC on student.Sno = SC.Sno where student.Sdept = '计算机系' and SC.Cno is null
--12
select count(SC.Cno) from student left join SC on SC.Sno = student.Sno where student.Sdept = '计算机系' group by student.Sno
--13
select student.Sno, count(SC.Cno) from student left join SC on SC.Sno = student.Sno where student.Sdept = '信息管理系' group by student.Sno order by count(SC.Cno)
--14
select Student.Sname, Student.Ssex from Student where Sdept='计算机系' and Sno not in(select Sno from Course,SC where Cname='Java' and Course.Cno=SC.Cno)
--15
select Cname, Semester, Credit from Course where Semester != '1' and Credit < any(select Credit from Course where Semester='1')
--16
select Sname, Cno, Grade from Student,SC where Student.Sno in(select distinct Sno from SC where Grade>=90) and Student.Sno=SC.Sno
--17
select Cname, Semester, Credit from Course where Semester != '1' and Credit < all(select Credit from Course where Semester='1')
--18
select Cname, Semester, Credit from Course as A where Credit in(select min(Credit) from Course as B where A.Semester=B.Semester)
--19
select Student.Sno, Cno, Grade from Student,SC as A where Grade in (select top 2 Grade from SC as B where A.Cno=B.Cno) and Student.Sno=A.Sno order by Cno
--20
select Sno, A.Cno, Grade from SC as A where Grade < (select avg(Grade) from SC as B where A.Cno=B.Cno) order by A.Cno
--21
select Semester from Course as A group by Semester having max(Credit)>(select 1.5*avg(Credit) from Course as B where A.Semester=B.Semester)
--22
select Sname, Sdept, count(1) from Student,SC where Student.Sno=SC.Sno group by Sname, Sdept
--23
select Cname, Semester, count(Sno),avg(Grade) from Course,SC where Course.Cno=SC.Cno group by Cname,Semester
--24
select Sname from Student where exists(select * from SC where Sno=Student.Sno and SC.Cno='C002')
--25
select Sname, Sdept from Student where exists(select * from Course,SC where Cname='Java' and Course.Cno=SC.Cno and Sno=Student.Sno)
--26
select Sname, Sdept from Student where not exists(select Cno, Sno from SC where Cno='C001' and SC.Sno=Student.Sno)
--27
select Sname, Ssex from Student where not exists(select Cno, Grade from Course,SC where Cname='Java' and Course.Cno=SC.Cno and SC.Sno=Student.Sno)
--28
select Sno, Sname, Sdept from Student where not exists(select Cno from Course where not exists(select Sno, Cno from SC where SC.Sno=Student.Sno and SC.Cno=Course.Cno))
--29
select distinct Sno, Cno from SC as A where not exists(select Cno, Sno from SC as B where B.Sno='0811102' and not exists(select Cno, Sno from SC as C where C.Sno=A.Sno and C.Cno=B.Cno))
