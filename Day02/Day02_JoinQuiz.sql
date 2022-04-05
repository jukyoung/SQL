SELECT * FROM USER_TABLES;
select* from employee;
select * from location;
select * from department;
select * from job;
select * from sal_grade;
select * from national;
--1. �ֹι�ȣ�� 1970��� ���̸鼭 ������ �����̰�, ���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.

select emp_name "�����", emp_no "�ֹι�ȣ", dept_title "�μ���", job_name "���޸�"
 from employee join department on(dept_code = dept_id)
  join job using(job_code) where substr(emp_no,1,2) between 70 and 79
   and substr(emp_no,8,1) = '2';

--2. �̸��� '��'�ڰ� ���� �������� ���, �����, �μ����� ��ȸ�Ͻÿ�.
select emp_id "���", emp_name "�����", dept_title "�μ���"
 from employee join department on(dept_code = dept_id)
  where emp_name like '%��%';
  
--3. �ؿܿ����ο� �ٹ��ϴ� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
select emp_name "�����", job_name "���޸�", dept_code "�μ��ڵ�", dept_title "�μ���"
 from employee join job using(job_code) join department on(dept_code = dept_id)
  where dept_title like '%�ؿܿ���%';
  
--4. ���ʽ�����Ʈ�� �޴� �������� �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
select emp_name "�����", bonus "���ʽ�����Ʈ", dept_title "�μ���", local_name "�ٹ�������"
 from employee join department on(dept_code = dept_id)
  join location on (location_id = local_code)
   where bonus is not null;

--5. �μ��ڵ尡 D2�� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
select emp_name "�����", job_name "���޸�", dept_title "�μ���", local_name "�ٹ�������"
  from employee join job using(job_code)
   join department on(dept_code = dept_id)
    join location on (location_id = local_code)
     where dept_code = 'D2';

--6. �޿�������̺��� �ִ�޿�(MIN_SAL)�� -20�������� ���� �޴� �������� �����, ���޸�, �޿�, �ִ�޿��� ��ȸ�Ͻÿ�.
-- (������̺�� �޿�������̺��� SAL_LEVEL�÷��������� ������ ��)
select emp_name "�����", job_name "���޸�", salary "�޿�", min_sal "�ִ�޿�"
 from employee join job using(job_code)
  join sal_grade using(sal_level)
   where salary > (min_sal - 200000); -- �´��� �𸣰���..

--7. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� �����, �μ���, ������, �������� ��ȸ�Ͻÿ�.
select emp_name "�����", dept_title "�μ���", local_name "������", national_name "������"
 from employee join department on(dept_code = dept_id)
  join location on(location_id = local_code)
   join national using(national_code)
    where national_code in('KO','JP');

--8. ���� �μ��� �ٹ��ϴ� �������� �����, �μ���, �����̸��� ��ȸ�Ͻÿ�. (self join ���)
select e1.emp_name "�����", dept_title "�μ���", e2.emp_name "�����̸�"
 from employee e1 join department on(dept_code = dept_id)
  join employee e2 on(e1.dept_code = e2.dept_code)
  where e1.emp_name != e2.emp_name;

--9. ���ʽ�����Ʈ�� ���� ������ �߿��� ������ ����� ����� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�. ��, join�� IN ����� ��
select emp_name "�����", job_name "���޸�", salary "�޿�"
 from employee join job using(job_code)
  where bonus is null and job_name in ('����', '���');

--10. �������� ������ ����� ������ ���� ��ȸ�Ͻÿ�.
select decode(ent_yn, 'Y', '���', 'N','����') "��������", count(*) "�ο���"
 from employee group by ent_yn;

--11. �� ������� �̸�,����(�ѱ�����),�μ���,��å���� ����Ͽ���.
-- �μ��� ������ '�μ�����' ��� / ���� �������� ���� 
select emp_name "�̸�", 
  extract(year from sysdate) - extract(year from to_date(substr(emp_no,1,2), 'RR')) +1 "����", 
   nvl(dept_title, '�μ�����') "�μ���", job_name "��å��"
   from employee left outer join department on(dept_code = dept_id)
    join job using(job_code)
     order by 2 desc;