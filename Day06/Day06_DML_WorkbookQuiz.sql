-- 1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
insert into tb_class_type values(01, '�����ʼ�');
insert into tb_class_type values(02, '��������');
insert into tb_class_type values(03, '�����ʼ�');
insert into tb_class_type values(04, '���缱��');
insert into tb_class_type values(05, '������');

-- 2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� ����. 
-- �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)
create table tb_�л��Ϲ����� as select student_no "�й�", student_name "�л��̸�",
 student_address "�л� �ּ�" from tb_student;

-- 3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� �Ѵ�.
-- �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (��Ʈ : ����� �پ���, �ҽŲ� �ۼ��Ͻÿ�)
create table tb_������а� as select student_no "�й�",
 student_name "�л��̸�",
 to_char(to_date(substr(student_ssn, 1, 2), 'RR'), 'YYYY')"����⵵"
 , professor_name "�����̸�" 
 from tb_student join tb_department using(department_no) 
 left outer join tb_professor on(coach_professor_no = professor_no)
  where department_name = '������а�';


-- 4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�. (��,
--�ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� �Ѵ�)
update tb_department set capacity = round(capacity+(capacity*0.1));

-- 5. �й� A413042 �� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����Ǿ��ٰ� �Ѵ�.
-- �ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�.

select * from tb_student where student_no = 'A413042';
update tb_student set student_address = '����� ���α� ���ε� 181-21'
  where student_no = 'A413042';

-- 6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ�� �����Ͽ���.
-- �� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�.
update tb_student set student_ssn = substr(student_ssn, 1, 6);

-- 7. ���а� ����� �л��� 2005 �� 1 �б⿡ �ڽ��� ������ '�Ǻλ�����' ������ �߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���. 
-- ��� ������ Ȯ�� ���� ��� �ش� ������ ������ 3.5 �� ����Ű�� �����Ǿ���. ������ SQL ���� �ۼ��Ͻÿ�.

select point, term_no, class_name, department_name, student_name 
 from tb_student join tb_department using(department_no)
  join tb_grade using(student_no) 
  join tb_class using(department_no) where student_name = '�����' 
  and class_name = '�Ǻλ�����' and term_no = 200501;
  
select department_name from tb_department 
  where student_no =  (select student_no from tb_student where student_name = '�����'
   and department_name =( select department_name from tb_department 
   where department_name= '���а�'
   ))and term_no = 200501;
   
-- 8. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� �����Ͻÿ�. 
delete from tb_grade 
 where student_no in (select student_no from tb_student where absence_yn = 'Y'); 