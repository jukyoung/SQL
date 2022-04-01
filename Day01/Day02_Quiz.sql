--���� 1. �μ����� ������ Ư�����ʽ��� ����Ϸ� �Ѵ�. �μ��ڵ�, �����, ���ʽ���, Ư�����ʽ����� �Ʒ� ������ �����Ͽ� ���.
   --D5 �μ��� �޿��� 10% 
   --D2 �μ��� �޿��� 20%
   --D9 �μ��� �޿��� 30% �� Ư�����ʽ��� ������ ����
   --������ �μ��� ���ʽ� ����
   --�Ʒ��� ������� �������� Decode�� Ȱ���Ͽ� �������� �ۼ�
select nvl(dept_code, '����') "�μ��ڵ�", emp_name "�����",
 decode(dept_code, 'D5', '10%', 'D2', '20%', 'D9','30%', '����')"���ʽ���",
  decode(dept_code, 'D5', salary*0.1, 'D2', salary*0.2, 'D9', salary*0.3, 0)"Ư�����ʽ���"
 from employee order by 1;
 
-- ���� 2. employee ���̺��� 60���� �߿��� �ʹݻ���, �Ĺݻ��� ������ ���. .
  -- 64��������� 60�� �ʹ�, 65~69��������� 60�� �Ĺ� 
  -- Case �� Ȱ�� (�Ʒ��� ���� ��µ� �����)
select emp_name "�����", 
 case
  when to_number(substr(emp_no, 1, 2)) between 60 and 64 then '60�� �ʹ�'
  when to_number(substr(emp_no, 1, 2)) between 65 and 69 then '60�� �Ĺ�'
  end
  from employee where to_number(substr(emp_no, 1, 2)) between 60 and 69;
  
-- ����3. employee ���̺��� 10�� �̸� �ٹ��ڴ� Junior ��, 
-- 10����� 19���� �ٹ��ڴ� Intermediate, 20�� �̻��� Senior �� ���.
   -- ������ �Ҽ����� ������ ���, ������ �������� �������� ���� 
   -- Case Ȱ�� (�Ʒ��� ���� ��µ� �����)
select emp_name "������", floor((sysdate-hire_date)/365)"����",
 case
  when floor((sysdate-hire_date)/365) < 10 then 'Junior'
  when floor((sysdate-hire_date)/365) between 10 and 19 then 'Intermediate'
  when floor((sysdate-hire_date)/365) >= 20 then 'Senior'
  end
  from employee order by 2;
  
 