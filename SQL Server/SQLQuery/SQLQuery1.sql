/*
��1����ѯ�����ϵѧ�����޿������Ҫ���г�ѧ�������֡����޿εĿγ̺źͳɼ���
��2����ѯ����Ϣ����ϵ�����ˡ�������Ļ�ѧ�� ��ѧ�������ͳɼ���
��3����ѯ����ѡ����Java�γ̵�ѧ��������г�ѧ������������ϵ��
��4��ͳ��ÿ��ϵ��ѧ���Ŀ���ƽ���ɼ���
��5����ѯ�롰��������ͬһ��ϵѧϰ��ѧ����
��6����ѯ���Գɼ�����90�ֵ�ѧ����ѧ�ź�������
��7����ѯ�����ϵѡ�ˡ�C002���γ̵�ѧ�����г��������Ա�
��8����ѯѡ���ˡ�Java���γ̵�ѧ����ѧ�ź�������
��9��ͳ��ѡ��Java�γ̵���Щѧ����ѡ��������ƽ���ɼ���
��10����ѯѡ�ˡ�JAVA���γ̵�ѧ��ѧ�š�������JAVA�ɼ���
��11����ѯѡ�ˡ�C004���ſγ��ҳɼ����ڴ˿γ̵�ƽ���ɼ���ѧ����ѧ�źͳɼ���
��12����ѯ����ƽ���ɼ�����ȫ��ѧ������ƽ���ɼ���ѧ����ѧ�ź�ƽ���ɼ���
��13����ѯûѡ��C001���ſγ̵�ѧ������������ϵ��
��14����ѯ�����ϵûѡJAVA�γ̵�ѧ���������Ա�
(15) ��ѯ����ѧ�ڿ���Ŀγ��бȵ�1ѧ�ڿ���γ̵�ѧ���ٵĿγ���������ѧ�ں�ѧ�֡�
��16����ѯ������һ�γɼ����ڵ���90��ѧ�������������޵Ŀγ̺źͳɼ���
��17����ѯ�ȵ�1ѧ�ڿ�������пγ̵�ѧ�ֶ�С������ѧ�ڿ���Ŀγ���������ѧ�ں�ѧ�֡�
��18����ѯÿ��ѧ��ѧ����͵Ŀγ̵Ŀγ���������ѧ�ں�ѧ�֡�
��19����ѯÿ�ſγ̿��Գɼ���ߵ�����ѧ����ѧ���Լ���Ӧ�Ŀγ̺źͳɼ���������û���ԵĿγ̡�
��20����ѯÿ�ſγ��У����Գɼ����ڸ��ſγ̵�ƽ���ɼ���ѧ����ѧ�źͳɼ���
��21����ѯ�����ѧ�ֳ�����ѧ��ƽ��ѧ��1.5����ѧ�ڡ�
��22����ѯѧ������������ϵ�͸�ѧ��ѡ�Ŀγ�������
��23����ѯ�γ���������ѧ�ڼ�ѡ���ſε�ѧ��������ƽ���ɼ���������û��ѡ�Ŀγ̡�
(24) ʹ��exists��ѯѡ�ˡ�C002���γ̵�ѧ��������
��25��ʹ��exists��ѯѡ��JAVA�γ̵�ѧ������������ϵ��
��26��ʹ��exists��ѯû��ѡ�ޡ�C001���γ̵�ѧ������������ϵ��
(27) ʹ��exists��ѯ�����ϵûѡJAVA��ѧ���������Ա�
(28) ʹ��exists��ѯ����ѡ��ȫ���γ̵�ѧ����ѧ�š�����������ϵ��
(29) ʹ��exists��ѯ����ѡ�ˡ�0811102��ѧ����ѡ��ȫ���γ̵�ѧ����ѧ�ź���ѡ�Ŀγ̺š�
 */
use xkgl
--1
select student.Sname, SC.Cno, SC.Grade from student right join SC on SC.Sno = student.Sno where student.Sdept = '�����ϵ';
--2
select student.Sname, SC.Grade from student right join SC on SC.Sno = student.Sno right join Course on Course.Cno = SC.Cno where Course.Cname = '������Ļ�ѧ' and student.Sdept = '��Ϣ����ϵ'
--3
select student.Sname, student.Sdept from student right join SC on SC.Sno = student.Sno right join Course on Course.Cno = SC.Cno where Course.Cname = 'Java'
--4
select avg(SC.Grade) as 'avgGrade' from SC right join student on student.Sno = SC.Sno group by student.Sdept
--5
select SC.Cno, count(SC.Sno), avg(SC.Grade), max(SC.Grade), min(SC.Grade) from SC left join student on student.Sno = SC.Sno where student.Sdept='�����ϵ' group by SC.Cno
--6
select A.Sname, A.Sdept from student as A left join student as B on B.Sdept = A.Sdept where B.Sname = '����'
--7
select A.Cname, A.Semester from Course as A left join Course as B on B.Semester = A.Semester where B.Cname = '���ݽṹ'
--8
select SC.Cno from SC group by SC.Cno having count(SC.Sno) > 1
--9
select student.Sname, SC.Cno from student inner join SC on SC.Sno = student.Sno
--10
select Cno from Course where not exists(select*from SC where Cno=Course.Cno)
--11
select Sname, Ssex from student left join SC on student.Sno = SC.Sno where student.Sdept = '�����ϵ' and SC.Cno is null
--12
select count(SC.Cno) from student left join SC on SC.Sno = student.Sno where student.Sdept = '�����ϵ' group by student.Sno
--13
select student.Sno, count(SC.Cno) from student left join SC on SC.Sno = student.Sno where student.Sdept = '��Ϣ����ϵ' group by student.Sno order by count(SC.Cno)
--14
select Student.Sname, Student.Ssex from Student where Sdept='�����ϵ' and Sno not in(select Sno from Course,SC where Cname='Java' and Course.Cno=SC.Cno)
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
