/*
�ڹٿ��� �޼���(method) = ����Ŭ������ �Լ�(Function)

- ���� �� �Լ� : �� �ึ�� �ݺ������� ����ż� �Է¹��� ���� ������ŭ ����� ��ȯ
ex) length() -> �������� ���̰� ��ȯ

- �׷� �Լ� : Ư���� ����� �������� �׷��� �����Ǿ� => �׷�� 1���� ����� ��ȯ 
ex) sum()
*/
-- ������ �Լ�
-- length() : �������� ���̰� ��ȯ (���׷��� ���� �� 3���ڸ� ���̰��� 3)
-- lengthb() : �־��� �÷�/���ڿ��� ���� ����(byte)�� ��ȯ���ִ� �Լ� (�޸� ������ ����Ǵ� ���̰�)
select emp_name, length(emp_name), lengthb(emp_name) from employee;

-- instr(�÷�/���ڿ�, ã���� �ϴ� ����(��), ���� �ε���, �˻��� ����(��)�� ����) : Ư�� ���ڿ����� ã���� �Ѵ� ���ڿ�(���ڿ��� ��ġ)�� ã���ִ� �Լ�
-- ���� �ε����� �������� �����ϸ� �ڿ������� Ž��
-- dual ���̺� : ����Ŭ���� �������ִ� ����,�Լ� ���� �뵵�� ����ϴ� Ư���� ���̺�
select instr('Hello World Hi High', 'H', 1, 1) from dual;
select instr('Hello World Hi High', 'H', 1, 2) from dual;
select instr('Hello World Hi High', 'H', 2, 2) from dual;
select instr('Hello World Hi High', 'H', -1, 1) from dual;

--employee ���̺��� email, email�÷��� @ ��ġ�� ��ȸ
select email, instr(email, '@', 1, 1) from employee;

-- lpad(����̵Ǵ� �÷�/���ڿ�, ��ȯ�� ����, ������ ����(��)) / rpad() 
-- : �־��� �÷�/ ���ڿ��� ������� �ؼ� ������ ���ڿ��� ����/�����ʿ� ���ٿ��� ����N�� ���ڿ��� ��ȯ�ϴ� �Լ�
select rpad(email, 20, '#') from employee;

-- ltrim(����̵Ǵ� �÷�/���ڿ�, �����ϰ� ���� ����(��)) / rtrim()
-- : �־��� �÷�/���ڿ��� ������� �����ϰ� ���� ���ڸ� ������ �� �������� ��ȯ�ϴ� �Լ�
-- ltrim �����ϰ� ���� ���ڿ��� ����(���ڿ��� ����)�� ��ġ�� ������ / rtrim ���ڿ��� ������(���ڿ��� ��)�� �����ϰ� ���� ���ڿ��� ��ġ
select rtrim(email, 'kh.or.kr') from employee;
select ltrim(email, 's') from employee;

-- ���� 1
-- Hello KH Java ���ڿ��� Hello KH �� ��µǰ� �Ͽ���.
select rtrim('Hello KH Java', 'Java') from dual;

-- ���� 2
-- Hello KH Java ���ڿ��� KH Java �� ��µǰ� �Ͽ���.
select ltrim('Hello KH Java', 'Hello') from dual;

-- ���� 3
-- DEPARTMENT ���̺��� DEPT_TITLE�� ����Ͽ���
-- �̶�, ������ �� ���ڸ� ���� ��µǵ��� �Ͽ��� / ex)ȸ������� -> ȸ�����
select rtrim(dept_title, '��') from department;

-- ���� 4
-- �������ڿ����� �յ� ��� ���ڸ� �����ϼ���.
-- '982341678934509hello89798739273402'
select rtrim(ltrim('982341678934509hello89798739273402', '0123456789'),'0123456789') from dual;

-- substr(����� �Ǵ� �÷�/���ڿ�, ���ڿ��� �߶� ��ġ, ��ȯ�� ������ ����)
-- : ����� �Ǵ� �÷�/���ڿ����� ������ġ�κ��� ������ ������ ������ŭ ����(��)�� �߶� ��ȯ���ִ� �Լ�
select substr('HappyHappyDay', 1, 5) from dual;
select substr('HappyHappyDay', 6, 8) from dual;
select substr('HappyHappyDay', 7, 3) from dual;
select substr('HappyHappyDay', -7, 3) from dual;

-- employee ���̺��� ����� ��ȸ -> ���� �ߺ����� ���������� ��ȸ 
select distinct substr(emp_name, 1, 1) from employee order by 1;
-- employee ���̺��� ���� ����� �����ȣ, �����, �ֹι�ȣ, ������ ��ȸ
-- �ֹι�ȣ�� ���ڸ� 6�ڸ��� ��� *�� ǥ���Ͻÿ�.
select * from employee;
select emp_id "���", emp_name "�����", 
 substr(emp_no,1,8)||'******' "�ֹι�ȣ", salary*12 "����" from employee
  where emp_no like '%-1%';
  
select emp_id "���", emp_name "�����", 
 substr(emp_no,1,8)||'******' "�ֹι�ȣ", salary*12 "����" from employee
  where substr(emp_no, 8, 1) in ('1', '3');

-- concat(����ڿ�1, ����ڿ�2) : => �ΰ��� ���ڿ��� �ϳ��� ��ģ �� ��ȯ���ִ� �Լ�
select concat(concat('ABCD', '�����ٶ�'),'hi') from dual;
select 'ABCD'|| '�����ٶ�'||'hi' from dual;

-- lower(��� ���ڿ�/ �÷�) / upper(��� ���ڿ�/ �÷�) / inicap(��� ���ڿ�/ �÷�)
-- : lower -> ��� ���ڿ��� ��� �ҹ��ڷ� ��ȯ���ִ� �Լ�
-- : upper -> ��� ���ڿ��� ��� �빮�ڷ� ��ȯ���ִ� �Լ�
-- : initcap -> �ܾ��� ù ���ڸ� �빮�ڷ� ��ȯ���ִ� �Լ�
select lower('Welcom To My World') from dual;
select upper('Welcom To My World') from dual;
select initcap('welcom to my world') from dual;

-- replace(����� �Ǵ� ���ڿ�/�÷�, �������� �Ǵ� ����(��), ������ ����(��))
-- ����� �Ǵ� ���ڿ�/�÷��� �������� �������� �Ǵ� ����(��)�� ã�Ƽ� ������ ����(��)�� �ٲ��ִ� �Լ�
select replace('Hello Hi High', 'Hi', 'Ho') from dual;
select replace('Hello Hi High', 'Hi', '') from dual;

--------------------------------------------------------------------------------------
-- ������ �Լ�
-- abs(����) : ���ڷ� ���޹��� ������ ���밪�� ��ȯ���ִ� �Լ�
select abs(-10) from dual;

-- mod(����/���ڿ� �ش��ϴ� �÷�, ���� ��) : ���ڷ� ���޹��� ���ڸ� ���� ������ ������ �������� ��ȯ���ִ� �Լ�
select mod(10, 3) from dual;
select mod(10, 2) from dual;
select mod(10, 4) from dual;

-- round(����) : ���ڷ� ���� ���ڸ� �ݿø��Ͽ� ��ȯ���ִ� �Լ�
-- round(����, �Ҽ��� �ε��� ��ġ): ���ڷ� ���� ���ڸ� ������ ��ġ ���� �ڸ������� �ݿø��Ͽ� ��ȯ���ִ� �Լ�
select round(123.678) from dual;
select round(123.456, 1) from dual;
select round(123.456, 2) from dual;
select round(123.456, 0) from dual;
select round(123.456, -2) from dual;

-- floor(����) : ���ڷ� ���� ������ �Ҽ��� �ڸ��� ��� ������ ��ȯ���ִ� �Լ�
select floor(123.456) from dual;
select floor(123.678) from dual;

-- trunc(����, �Ҽ��� ��ġ) : ���ڷ� ���� ���ڸ� ������ ��ġ���� �߶� ��ȯ���ִ� �Լ�
select trunc(123.456, 1) from dual;
select trunc(123.456, 1), round(123.456, 1) from dual;

-- ceil(����) : ���ڷ� ���� ������ �Ҽ��� �ڸ��� ������ ��ȯ���ִ� �Լ�
select ceil(123.456), floor(123.456) from dual;

-- employee ���̺��� ������, �Ի���, ���ñ����� �ٹ��ϼ� ��ȸ
-- �ָ��� ����, �Ҽ��� �Ʒ��� ����
select emp_name "������", hire_date "�Ի���", floor(sysdate-hire_date) "�ٹ��ϼ�" from employee;

---------------------------------------------------------------------------------------------
-- ��¥ �Լ�
-- sysdate : �ý��ۿ� ����Ǿ� �ִ� ���� ��¥(�ð�����) ��ȯ
select sysdate from dual;
-- current_date : session(����) timezone �� ���� ���� ��¥(�ð�) ��ȯ
select current_date from dual;

-- months_between(��¥��, ��¥��) : �� ��¥ ������ ���� �� ���̸� ��ȯ���ִ� �Լ�
select months_between(sysdate, hire_date) from employee;
select floor(months_between(sysdate, hire_date)/12) from employee;
select months_between(sysdate, sysdate-31) from employee;

-- add_months(���� ��¥, ���� ���� ��) : ù ��° ���ڰ��� ��¥�� �������� �ؼ� �� ��° ���ڰ��� ���ؼ� ��ȯ���ִ� �Լ�
select add_months(sysdate, 1) from dual;
select add_months(sysdate, -1) from dual;

-- employee ���̺��� �����, �Ի���, �Ի� �� 6������ �� ��¥ ��ȸ
select emp_name "�����", hire_date "�Ի���", add_months(hire_date, 6) "�Ի���+6����" from employee;

-- next_day(���� ��¥, ����/����) : ���� ��¥�� �������� �ؼ� �����ʿ� �ش��ϴ� ���� ����� ��¥�� ��ȯ���ִ� �Լ�
-- ������ ���� : '��' Ȥ�� '������'
-- ������ �ǹ� : 1-�Ͽ��� 2-������ 3-ȭ���� 4-������ 5-����� 6-�ݿ��� 7-�����
select next_day(sysdate, '��') from dual;
select next_day(sysdate, 2) from dual;

-- last_day(���� ��¥) : ���� ��¥�� �������� �ؼ� �ش� ��¥�� ���� ���� ������ ���� ��ȯ���ִ� �Լ�
select last_day(sysdate) from dual;
select last_day(add_months(sysdate, -1)) from dual;

-- employee -> �����, �Ի���, �Ի���� �������� ��ȸ
select emp_name "�����", hire_date "�Ի���", last_day(hire_date) "�Ի���� ��������" from employee;
-- �������� ��������
select last_day(add_months(sysdate, 1)) from dual;

-- extract(year/month/day from date(���س�¥)) : ���س�¥�κ��� ��/��/���� �����ؼ� ��ȯ���ִ� �Լ�
select extract(year from sysdate) from dual;
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual;

-- employee ���̺��� ����� �Ի�⵵ �Ի�� �Ի����� ��ȸ
select emp_name "�����", extract(year from hire_date) "�Ի�⵵",
 extract(month from hire_date) "�Ի��", extract(day from hire_date) "�Ի���" from employee;

-- employee ���̺��� �����, �Ի���, ������ ���
-- �Ի��� -> yyyy��MM��DD�� �������� ���
-- ���� ��½ÿ��� �Ҽ����� �ø����� ó�� -> 28.144 -> 29����
-- ��� �ÿ� ������ �Ի���� �������� ��������
select emp_name "�����", concat(extract(year from hire_date), '��') 
 ||concat(extract(month from hire_date), '��') 
 ||concat(extract(day from hire_date), '��') "�Ի���",
 ceil((sysdate-hire_date)/365) "����" from employee order by 3;
 
 -- ���ڿ��� �������� order by -> ���ڷν� �� ���� ���ڸ� �۴ٰ� �ν�(10�� 3�� �ִٸ� 10�� �� ������)
 
 -- Ư�� ���ʽ��� ���� -> �ڷᰡ �ʿ�
 -- employee -> �Ի����� �������� ������ 1�� ���� 6������ ����ؼ� ��ȸ
 -- �����, �Ի���, ������, ������+ 6����
 -- 22/01/05 �Ի� -> 22/02/01 ������ -> 22/08/01 ������ + 6����
 -- ��½� �Ի��� �������� ���
 select emp_name "�����", hire_date "�Ի���", last_day(hire_date)+1 "������",
  add_months(last_day(hire_date)+1, 6) "������+6����" from employee order by 2;
  
--------------------------------------------------------------------------------
-- ����ȯ
-- to_char(date/number, format) : ��¥ Ȥ�� ���ڸ� Ư���� ������ ���������� ��ȯ���ִ� �Լ�
/*
  Date�� -> ������
  �� : YY/ YYYY 
  �� : MM
  �� : DD
*/
select sysdate from dual;
select to_char(sysdate, 'YYYY-MM-DD') from dual;
select to_char(sysdate, 'YYYY/MM/DD') from dual;
-- employee -> �Ի����� 1999�� 03��05�� -> �����, �Ի�����
-- �ѱ��� ���Ŀ� �߰��ϰ� �ʹٸ� �ѱ��� ������ ��  �� �� �����ֱ�
select emp_name "�����", to_char(hire_date, 'YYYY"��" MM"��" DD"��"')"�Ի�����" from employee;

-- DAY : x����
select to_char(sysdate, 'YY/MM/DD/DAY')from dual;
-- DY : x(����)
select to_char(sysdate,'YY/MM/DD/DY') from dual;
-- MONTH : x��
select to_char(sysdate, 'YY/MONTH/DD')from dual;
-- HH MI SS �ú���
select to_char(sysdate, 'HH:MI:SS')from dual;
-- PM/AM : ����/����
select to_char(sysdate, 'PMHH:MI:SS')from dual;
-- HH24 : 24�ð��� �������� ǥ��
select to_char(sysdate, 'HH24:MI:SS')from dual;

-- employee ���̺� �����, �Ի���-> 1990/02/05(ȭ) ���� ���
select emp_name "�����", to_char(hire_date, 'YYYY/MM/DD(DY)') "�Ի���" from employee;

-- ���� -> ������
-- to_char(��� ����, )
-- 123456789 -> 0�̳� 9�� �̿��� ���������� ��ȯ
select to_char(123456789, '999,999,999') from dual;
select to_char(123456789, '000,000,000') from dual;
-- 9 : �������� ���ĺ��� ª�� ���ڰ� ���´ٸ� ����� �Ǵ� ���� ���̿� ���缭 ������� ��ȯ
-- 0 : �������� ���ĺ��� ª�� ���ڰ� ���´ٸ� ���Ŀ� ���缭 ���̸� �����ϰ� ���� �ڸ����� 0���� ä�� ��
select to_char(12345, '999,999,999') "9", to_char(12345, '000,000,000') "0" from dual;

-- ��ȭ ǥ�� -> L (local)
select to_char(12345, 'L999,999') from dual;

-- employee -> ������, �����ڵ�, ����(��) ��ȸ
-- ��, ������ ��ȭǥ��
-- ���� ���ʽ��� ����� �ݾ����� ��ȸ(����+(����*���ʽ�)*12)
-- nvl(����/�÷�, ġȯ��): ���� �ش� ����/�÷� ���� null ���̶�� ġȯ������ ��ȯ���ִ� �Լ� 
select emp_name "������", job_code "�����ڵ�",
 to_char((salary+(salary*nvl(bonus,0)))*12, 'L999,999,999') "����(��)" 
  from employee;
 
 -----------------------------------------------------------------------------------
-- to_date(����/����, ����) : ������ Ȥ�� ������ �����͸� ����Ʈ(��¥) Ÿ������ �ٲ��ִ� �Լ�
-- 20120505
select to_date(20120505, 'YYYYMMDD')from dual;
select to_date(20120505, 'YYMMDD')from dual;
select to_date('20120505', 'YYYYMMDD') from dual;
-- �ð����� ��ȯ�Ҷ� �տ� ��/��/�� ������ ���� ������ ���� ���� 1�Ϸ� ��¥�� �ν��ع���
select to_char(to_date('110808', 'hh:mi:ss'), 'YYYY/MM/DD hh:mi:ss')from dual;
-- �⵵�� ��Ȱ�Ҷ� 2000/1900��뿡 ���� ���� ��Ȯ�� �������� ������ 2000��븦 default ������ �ν�
select to_char(to_date('890909', 'YY/MM/DD'), 'YYYY/MM/DD') from dual;

-- employee ���̺��� 2000�⵵ ���Ŀ� �Ի��� �����, ���, �Ի��� ��ȸ
select emp_name "�����", emp_id "���", hire_date "�Ի���" from employee
 where hire_date >= to_date('20000101', 'YYYYMMDD');
 
-----------------------------------------------------------------------
-- to_number(������, ����) : �������� ���������� ��ȯ���ִ� �Լ�
--�������� �̷��� �������� ���´� ���� ����ó�� ����� �ٲ�°� �ƴ�
select to_number('123,456,789', '999,999,999') from dual;
select to_number('123,456,789', '999,999') from dual; -- �Ѱ��ִ� �������Ŀ� ���� �������ĵ� �����ϰ�.
select to_number('s123,123', '9999,999') from dual; -- ���ڷ� ��ȯ�Ұ��� ���ڿ� �Ѱ��� �� x

-- ������ ����ȯ
-- : ����Ŭ������ ��� ���� �ڵ������� �ڷ����� �����ؼ� ����ȯ
-- ������ -> ������ ����ȯ�� ���� x -> ��Ȯ�� ������ ���ؼ��� ��Ȯ�� �ڷ������� ��ȯ�� �Ŀ� ����
select emp_name, salary from employee where salary = 8000000;
select emp_name, salary from employee where salary = '8000000';
select 25 + '25' from dual;

/*
 60����� ������� ���, ���ʽ� ���� ����Ͻÿ�
 �׶� ���ʽ� ���� null�� ��쿡�� 0% �̶�� ��� �ǰ� ����ÿ�
*/
select emp_name "������", substr(emp_no, 1, 2) "���", nvl(bonus, 0)*100||'%' "���ʽ�"
 from employee where to_number(substr(emp_no, 1, 2))between 60 and 69;

-------------------------------------------------------------------------------------
-- �׷� �Լ�
-- sum(����/�÷�) : �ش� �÷�/���� ���� �� ���� �����ִ� �Լ�
select sum(salary) from employee;
-- �μ��ڵ尡 D5�� ������� �޿��� ���� ��ȸ
select sum(salary) from employee where dept_code = 'D5';
-- ������, �������� �޿� ���� ���
-- �׷��Լ��� ����Ҷ����� ������ ������� ���´ٴ� ���� ���� ����.
select emp_no, sum(salary) from employee;

-- avg(�÷�) : �ش� �÷� ������ ����� �����ִ� �Լ�
select round(avg(salary),0) from employee;
-- ������ ����� ������ ����� ��ձ޿��� ���غ���
select avg(salary) from employee 
 where emp_name in('������', '������');
-- �� ������ ���ʽ� ��� -> �Ҽ��� ��°�ڸ������� �ݿø��ؼ� ��ȸ(��°�ڸ������� ǥ��)
-- �׷��Լ� : �׷��Լ��� ����� �� ���� null ���� �ִٸ� -> null ���� �ƿ� ���� ����� ��
select round(avg(nvl(bonus,0)),2) from employee;

-- count(�÷�) : �ش� �÷� -> ������ ������ ��ȯ���ִ� �Լ�
select count(emp_name) from employee;
select count(*) from employee;
-- ���ʽ��� �����ؾ��ϴ� ����� �� ī��Ʈ
select count(*) from employee where bonus is not null;
-- �μ��ڵ尡 D5�� ����� �� ī��Ʈ
select count(*) from employee where dept_code = 'D5';

-- ������� ���� �ִ� �μ��� �� ī��Ʈ
select count(distinct dept_code) from employee;

-- max/min(�÷�) : �ش� �׷쿡�� �ִ밪/�ּҰ��� ��ȯ���ִ� �Լ�
select max(salary), min(salary) from employee;
-- employee ���̺��� ���� ���� ���� ����� �Ի���/ ���� ���� ���� ����� �Ի��� ��ȸ
select min(hire_date), max(hire_date) from employee;

-----------------------------------------------------------------------------
-- ���ǽ�
/*
  decode(���ǥ����, ����1, ���1, ����2, ���2, default) 
  ���ǰ� ����� ��Ʈ�� �̾�ٿ��ִ°� ����
  -> ���� default ���� ��������� ���������� ������ default = null
  : ��� ǥ����/���� ����1�� ���ٸ� ��� 1�� ��ȯ, ����2�� ���ٸ� ���2�� ��ȯ,
    �� ��� ������ �������� �ʴ´ٸ� default���� ��ȯ
 -> equal �񱳸� ����

*/
select emp_name "�����", decode(substr(emp_no, 8, 1),1,'��', 2,'��') "����" from employee;
select emp_name "�����", decode(substr(emp_no, 8, 1),1,'��','��') "����" from employee;
select*from employee;
-- ����1. ���, ������� ��翩�θ�����ϴµ� ent_yn(��翩��)�� 'Y'�� ���ٸ� ������� ����ض�
-- + ���� ������� ���� �������̶�� '������'�� ���, ���ļ����� ��翩��, ��� �÷� ��������
select emp_id "���", emp_name "������", 
  decode(ent_yn, 'N', '������', to_char(ent_date, 'YY"��" MM"��" DD"�� ���"')) "��翩��"
  from employee order by 3, 1;

/*
  case -> ���ǹ�
  case
     when ����1 then ���1
     when ����2 then ���2
     ...
     else ��� ������ �������� ������ ��ȯ�Ǵ� ���
    end
    -> else(�⺻��)�� ���������� ������ ������ ��� ���� ������ null �� ��ȯ
    -> case�� �̿��ؼ� ������� ������ �� ��� ���ǿ� ���� ������ �ڷ����� ���
*/
select
  case
    when '������' = '������' then 10
    when 1 > 5 then 5
    else 0
    end
from dual;

select emp_id "���", emp_name "������", 
 case
   when ent_yn = 'Y' then to_char(ent_date, 'YY"��" MM"��" DD"�� ���"')
   -- when ent_yn = 'N' then '������'
    else '������'
   end "��翩��"
    from employee order by 3,1;
    
/*
 �μ��� 1�б� ���� ��ȸ
 D2, D6 �μ��� ��/ D9 �μ��� ��/ ������ �μ��� �� /������ �ش���� ���� ���
 �μ��ڵ� ���� = ����
 �μ��ڵ� �ߺ�x ���ļ����� �μ��ڵ� ��������
*/
select distinct nvl(dept_code, '����') "�μ��ڵ�",
 case
  when dept_code in ('D2', 'D6') then '��'
  when dept_code = 'D9' then '��'
  when dept_code is null  then '�ش����'
  else '��'
  end "1�б� ����"
  from employee order by 1;


