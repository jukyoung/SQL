/*
 ���ι�(JOIN)
 : �� �� �̻��� ���̺��� ���� �ϴ� �� ->
     �����Ϸ��� �ϴ� ���̺��� �� ���̺��� ����� �÷��� �����ͷ� ���ļ� ǥ���ϴ� ��
    ������ �������� ������ ���� for ���� ����� ���·� ���� -> ��� ����� ���� ��ȸ
    
    ANSI ǥ�� Join
    Oracle Join
*/
select * from employee; -- 23��
select * from department; -- 9��
select * from employee, department; --207�� ��� ����� ���� �� �����ؼ� ���°�

/*
 ���ι��� ����Ҷ� �� ���̺��� ������ �ִ� �÷����� ���� �� / �÷����� �ٸ� ��
*/
-- �μ��ڵ尡 ���� employee, department ���̺��� ���, �����, �μ��ڵ�, �μ��� ��ȸ
-- ������ �Ǵ� �÷����� �ٸ� �� (dept_code /dept_id)
-- oracle ����
select emp_id, emp_name, dept_code, dept_title from employee, department
 where dept_code = dept_id;

-- ANSI
select emp_id, emp_name, dept_code, dept_title 
  from employee join department
   on (dept_code = dept_id);

-- �� ���� ���̺��� �÷����� ���� ��
-- employee, job;
select * from employee, job order by 1;
-- ���, �����, �����ڵ�, ���޸�
-- �� ���̺� ��Ī�� �ο� -> ���̺�� ��Ī
-- �̸��� ���� �÷��� �տ� ���̺��� ��Ī.�÷��� �������� � ���̺��� �÷��� ����ϴ°��� ���
-- select ���������� �����������
-- oracle
select emp_id, emp_name, e.job_code, job_name
  from employee e, job j where e.job_code = j.job_code;
-- ANSI : �� ���̺��� ���� �÷��� -> using(�÷���)
select emp_id, emp_name, job_code, job_name
 from employee join job using(job_code);
  
/*
 1. Cross Join
 2. Inner Join
 3. Outer Join
   3-1. Left Outer Join
   3-2. Right Outer Join
   3-3. Full Outer Join
 4. Self Join
 5. ���� Join
 ** Non-Equi Join
*/

/*
 Cross Join (��ȣ ����) : ���εǴ� ���̺� ������ �ɾ����� �ʾƼ� ��� ������(��� ����� ����) ���յǾ� ������ ���
   : �� ���̺��� �� ��� * �ٸ� ���̺��� �� ���
*/
 select * from employee, department; -- oracle
 select * from employee cross join department; --ANSI

/*
  Inner Join (���� ���� /������) : ���� ���� ����ϴ� join ����
   : ���̺� A�� ���̺� B ���� ������ �´� �����͸� ��ȯ
   select �÷�... from ���̺�A, ���̺�B where ����; -- oracle
   select �÷�... from ���̺�A inner join ���̺�B on ����; -- ANSI
   select �÷�... from ���̺� A join ���̺�B on ����; -- ANSI (ANSI �������� join�� �������� inner join)
*/
select * from employee, department where dept_code = dept_id; -- oracle
select * from employee inner join department on (dept_code = dept_id); -- ANSI

-- �ѹ���, ȸ��������� ������� �����, �̸���, �μ���, �μ��ڵ常 ��ȸ
-- oracle
select emp_name "�����", email "�̸���", dept_title "�μ���", dept_code "�μ��ڵ�"
  from employee, department where dept_code = dept_id 
   and dept_title in ('�ѹ���', 'ȸ�������');
-- ANSI
select emp_name "�����", email "�̸���", dept_title "�μ���", dept_code "�μ��ڵ�"
 from employee inner join department on(dept_code = dept_id)
  where dept_title in ('�ѹ���', 'ȸ�������');

-- �ؿ� ������(�ؿܿ���1,2,3��)�� ��� �������� ���, �����, �μ���, �μ��ڵ�, ���� ��� -- inner join
-- ANSI
select emp_id "���", emp_name "�����", dept_title "�μ���",
    dept_code "�μ��ڵ�", salary*12 "����"
    from employee inner join department on (dept_code = dept_id)
    where dept_title like '%�ؿܿ���%';
-- oracle
select emp_id "���", emp_name "�����", dept_title "�μ���",
    dept_code "�μ��ڵ�", salary*12 "����"
    from employee, department where dept_code = dept_id
    and dept_title like '%�ؿܿ���%';
    
-- �븮�� ���(��å = �븮)���� �޿� ��� Ȯ��
-- �븮�� ������� �����, �����ڵ�, ���޸�, �μ��ڵ�(null - ����), ���� ��ȸ
-- ���� -> ��ȭǥ�ÿ� ����ǥ��
-- �̸� ��������, ���� ��������
select * from employee, job;
-- oracle
select emp_name "�����",  e.job_code "�����ڵ�", job_name "���޸�",
 nvl(dept_code, '����') "�μ��ڵ�", to_char(salary, 'L999,999,999') "����"
  from employee e, job j where e.job_code = j.job_code
  and job_name = '�븮' order by 1, 5 desc;
-- ANSI
select emp_name "�����",  job_code "�����ڵ�", job_name "���޸�",
 nvl(dept_code, '����') "�μ��ڵ�", to_char(salary, 'L999,999,999') "����"
 from employee inner join job using(job_code)
  where job_name = '�븮' order by 1, 5 desc;

---------------------------------------------------------------------------
/* Left Outer Join (�ܺ� ����/������ -> ���� �ܺ� ����)
   : �����ϴ� ���̺� A�� �����͸� ��� ��ȯ, ���̺� B�� ���� ������ ��ġ�ϴ� �����͸� ��ȯ
   -> inner join ������ �ɰ� �Ǹ� ���ǿ��� �´� �����Ͱ� ��ȯ
   -> left outer join ������ ��ġ���� �ʾƵ� ���� ���̺��� �����ʹ� ��� ��ȯ
   oracle : select �÷�.. from ���̺�A, ���̺�B where �÷� = �÷�(+);
   ANSI : select �÷�.. from ���̺�A left outer join ���̺�B on()/using();
*/
-- ��� �������� �μ��� ���
select * from employee;
select * from department;
select emp_name, dept_title from employee, department where dept_code = dept_id;
 -- inner join�� ����� ��� ������ ��ġ���� �ʴ� �����Ͱ� full�� ��ȸ���� ���� ��� �߻�
-- oracle
select emp_name, dept_title from employee, department
 where dept_code = dept_id(+);
--ANSI
select emp_name, dept_title from employee left outer join department 
 on(dept_code = dept_id);

-- ��������θ� �����ϰ� ��� �μ� ������ ���, �����, �μ���, ���� ��ȸ
-- �μ����� ���� ���� -> '����' ������ �μ���, ���, ���� ������������
-- oracle
select emp_id "���", emp_name "�����", nvl(dept_title, '����') "�μ���", salary*12 "����"
 from employee, department where dept_code = dept_id(+)
  and dept_title != '���������' order by 3,1,4;
-- ANSI
select emp_id "���", emp_name "�����", nvl(dept_title, '����') "�μ���", salary*12 "����"
 from employee left outer join department on(dept_code = dept_id)
  where dept_title != '���������' or dept_code is null order by 3,1,4;
-- != / = / like/ not like ���� equal �����ڸ� �̿��ϰ� �Ǹ� null ���� ����� �� �񱳰� ���� �ʾ� ��� ���ܵ� ���� 
-- null ���� ����ϰ� �ʹٸ� ��ȸ������ �߰����� ���� �ٿ���.

/*
 Right Outer Join (������/ ������ �ܺ� ����)
  : �����ϰ��� �ϴ� ���̺� A�� ���̺� B�� ���� ��, ���̺� A�� ���� ������ ��ġ�ϴ� �����͸� ��ȯ, ���̺� B�� ���ǿ� ������� ��� ������ ��ȯ
  oracle : select �÷�.. from ���̺�A, ���̺�B where �÷�(+) = �÷�;
  ansi : select �÷�.. from ���̺�A right outer join ���̺�B on()/using();
*/
select emp_name, dept_title from employee, department where dept_code(+) = dept_id;
select emp_name, dept_title from employee right outer join department on(dept_code = dept_id);

/*
  Full Outer Join(������)
   : ���̺� A�� ���̺� B�� �����Ҷ� ���ǿ� ���� �ʴ��� ��� ������ ���
  ansi : select �÷���.. from ���̺�A full outer join ���̺�B on()/using(); 
*/
-- ��� ������, ��� �μ��� ���
select emp_name, dept_title from employee full outer join department
  on(dept_code = dept_id);
  
/*
   Non-Equi Join (�� ����)
   -> ������ �÷��� ���� ��ġ�ϴ� ��찡 �ƴ϶�
   ���� ������ ���ԵǴ� ���� ����(between, <, >, <= ��)
*/
insert into kh.employee 
    values('999', '�žƶ�', '990101-1111111', 'gg@kh.or.kr', '01011111111', 'D8', 'J5', 'S1',
        8000, 0.3, null, to_date('90/02/06', 'YY/MM/DD'), null, 'N'); -- ���õ�����
select * from employee;
-- emp_id, emp_name, salary, sal_level -> sal_level -> min_sal �� max_sal ������ ��쿡��
select * from sal_grade;

select emp_id, emp_name, salary, s.sal_level
 from employee e inner join sal_grade s
  on(salary between min_sal and max_sal);

delete employee where emp_name = '�žƶ�'; -- ���� ������ ����

/*
  Self Join : �ٸ� ���̺��� �ƴ� ���� ���̺��� �����ϴ� ��
  -> �Ȱ��� ���̺��� join �ϱ� ������ �� ���̺� ��Ī�� �ݵ�� �����ϰ�
  -> ����Ϸ��� �÷��� � ��Ī�� �ش��ϴ� �÷����� ����Ϸ��°��� ��Ȯ�� �������. -> ��ȣ..
*/
-- ������ ����鿡 ���� manager_id Ȯ��
select emp_id, emp_name, manager_id
  from employee;
-- manager_id�� �ش��ϴ� �����(�Ŵ�����)�� �߰��ϰ� �ʹٸ�?
select e1.emp_id "�������", e1.emp_name "������", e1.manager_id "�Ŵ��� ���", e2.emp_name "�Ŵ�����"
  from employee e1 join employee e2
    on (e1.manager_id = e2.emp_id);

-- �Ŵ������ �ش� �Ŵ����� �����ϰ� �ִ� �����, �޿��� ��ȸ
select e1.emp_name "�Ŵ�����", e2.emp_name "�����", e2.salary "�޿�"
  from employee e1 join employee e2
   on(e1.emp_id = e2.manager_id);

/*
  ���� Join : ���� ���� ���ι��� ����ϴ� ���
*/
-- employee department ���� -> ���, �����, �μ��ڵ�, �μ���
select emp_id "���", emp_name "�����", dept_code "�μ��ڵ�", dept_title "�μ���"
 from employee join department
  on(dept_code = dept_id);
-- ���, �����, �μ��ڵ�, �μ��� + �μ�������
select * from location;

select dept_id, dept_title, local_name
 from department join location
  on(location_id = local_code);
  -- ansi
select emp_id "���", emp_name "�����", dept_code "�μ��ڵ�", 
 dept_title "�μ���", local_name "�μ�������"
  from employee join department on (dept_code = dept_id)
   join location on(location_id = local_code);
-- oracle
select emp_id "���", emp_name "�����", dept_code "�μ��ڵ�", 
 dept_title "�μ���", local_name "�μ�������"
 from employee, department, location
  where dept_code = dept_id and location_id = local_code;
