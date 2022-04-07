-- 1. �迭 ������ ������ ī�װ� ���̺��� ������� ����. ������ ���� ���̺��� �ۼ��Ͻÿ�.
create table tb_category(
 name varchar2(10)
 , use_yn char(1) default 'Y'
);

-- 2. ���� ������ ������ ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.
create table tb_class_type(
 no varchar2(5) primary key
 , name varchar2(10)
);

-- 3. TB_CATEGORY ���̺��� NAME �÷��� PRIMARY KEY �� �����Ͻÿ�.
--(KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸� �����ϰ��� �Ѵٸ� �̸��� ������ �˾Ƽ� ������ �̸��� ����Ѵ�.)
alter table tb_category add constraint name_pk primary key(name);

desc tb_category;
select constraint_name, constraint_type from user_constraints where table_name = 'TB_CATEGORY';

-- 4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.
alter table tb_class_type modify name constraint name_nn not null; 
select constraint_name, constraint_type from user_constraints where table_name = 'TB_CLASS_TYPE';

-- 5. �� ���̺��� �÷� ���� NO �� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����, �÷�����
-- NAME �� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.
alter table tb_class_type modify no varchar(10) modify name varchar2(20);
desc tb_class_type;
alter table tb_category modify name varchar2(20);
desc tb_category;

-- 6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� �տ����� ���·� �����Ѵ�. (ex. CATEGORY_NAME)
alter table tb_category rename column name to category_name;
alter table tb_category rename column use_yn to category_use_yn;
alter table tb_class_type rename column no to class_type_no;
alter table tb_class_type rename column name to class_type_name;

--7. TB_CATEGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ���� �����Ͻÿ�.
-- Primary Key �� �̸��� "PK_ + �÷��̸�"���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME )
select constraint_name from user_constraints where table_name = 'TB_CATEGORY';
alter table tb_category rename constraint name_pk to pk_category_name;

select constraint_name from user_constraints where table_name = 'TB_CLASS_TYPE';
alter table tb_class_type rename constraint SYS_C007132 to pk_class_type_no;

-- 8. ������ ���� INSERT ���� ��������.
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT;
select * from tb_category;

-- 9.TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ����� �����ϵ���
-- FOREIGN KEY �� �����Ͻÿ�. �� �� KEY �̸��� FK_���̺��̸�_�÷��̸����� �����Ѵ�. (ex. FK_DEPARTMENT_CATEGORY )

select * from tb_department;
desc tb_department;
alter table tb_department add constraint 
  fk_department_category foreign key(category) references tb_category(category_name); 

-- 10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW �� ������� �Ѵ�. 
-- �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.
/*
�� �̸�
 VW_�л��Ϲ�����
�÷�
 �й�
 �л��̸�
 �ּ�
*/

create view vw_�л��Ϲ����� 
 as select student_no "�й�", student_name "�л��̸�", student_address "�ּ�" 
  from tb_student;

-- 11. �� ������б��� 1 �⿡ �� ���� �а����� �л��� ���������� ���� ����� �����Ѵ�.
--�̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
--�̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ� (��, �� VIEW �� �ܼ� SELECT
--���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
create view vw_������� 
  as select student_name "�л��̸�", department_name "�а��̸�",
   nvl(professor_name, '����') "��米�� �̸�" 
   from tb_student join tb_department using(department_no)
   left outer join tb_professor on(coach_professor_no = professor_no) order by 2;
  
   select * from vw_�������;

-- 12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����.
create view vw_�а����л���
 as select department_name , count(*) "student_count" 
   from tb_student join tb_department using(department_no) 
    group by department_name order by 1;
    
    select * from VW_�а����л���;

--13. ������ ������ �л��Ϲ����� View �� ���ؼ� �й��� A213046 �� �л��� �̸��� ����
-- �̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
select * from vw_�л��Ϲ�����;
 update vw_�л��Ϲ����� set �л��̸� = '�趯��' where �й� = 'A213046';

-- 14. 13�������� ���� VIEW �� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW �� ��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�
drop view vw_�л��Ϲ�����;
create view vw_�л��Ϲ����� 
 as select student_no "�й�", student_name "�л��̸�", student_address "�ּ�" 
  from tb_student with read only;

--15. �� ������б��� �ų� ������û �Ⱓ�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ���������� �ǰ� �ִ�.
-- �ֱ� 3 ���� �������� �����ο��� ���� ���Ҵ� 3 ������ ã�� ������ �ۼ��غ��ÿ�.
select * from (select row_number() over(order by count(*) desc) "����",
class_no "�����ȣ", class_name "�����̸�", count(*) "�����ο�"
  from tb_student join tb_grade using(student_no)
   join tb_class using(class_no) group by class_no, class_name)
    where "����" <= 3 order by 4 desc;
  