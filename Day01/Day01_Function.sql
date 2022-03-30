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

