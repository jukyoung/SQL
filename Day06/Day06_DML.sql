/*
    DML (Data Manipulation Language)
    : ������ ���۾�
    -> Data�� ����, ����, ����, ��ȸ�ϴ� ���
    -> insert, update, delete, select 
*/

/*
   insert : ���̺� ���ο� ���� �߰��Ҷ� ����ϴ� ����
   -> insert into ���̺�� values(�Է��� ������, �Է��� ������...); 
   -> ��� �࿡ ���� �����͸� �߰��ϰ��� �Ҷ� ����ϴ� ����
   -> insert into ���̺��(�÷���1, �÷���2...) values(�Է��� ������, �Է��� ������...);
   -> Ư���� �÷����� �����͸� �ְ� ���� ��� ����ϴ� ����
*/
create table member(
 id varchar2(100) primary key
 , pw varchar2(100) not null
 , nickname varchar2(100) unique
 , email varchar2(100)
);
select*from member;
insert into member values('abc123', 'abc', 'ABC���ݸ�', 'abc@naver.com');
insert into member(id, pw) values('eee555', 'eEE');
insert into member(id, pw, nickname, email) values('aaa','fdds','���̿���', 'aa@gmail.com');

-- ���������� �̿��ؼ� insert ���� ���
-- employee
insert into member (select emp_id, job_code, emp_name, email from employee where emp_id = '200');

-- ������ ����ȯ -> ����Ŭ�� �ڵ����� �ڷ����� �����Ͽ� ��ȯ���ִ°�
insert into member values(123, sysdate, 'ffd', 'abc@naver.com');

-------------------------------------------------------------------------------------------------
/*
    update : �÷��� ����� �����͸� �����ϴ� ���� -> ���̺��� ��ü �� ������ ��ȭ�� ���� ����
    -> update ���̺�� set ������ �÷��� = ������ ��...where ����;
*/
select * from member;
update member set email = 'eee@gmail.com'; -- email�� ��� �����͸� �� ����
update member set email = 'abc@naver.com' where id = 'abc123';
-- pw, nickname
update member set pw = '1234' , nickname = '��Ƽ' where id = 'eee555';

/*
   delete : ���̺��� ���� �����ϴ� ���� -> ���� ������ ��ȭ�� ����
   -> ���ǹ��� �ɾ����� ������ ���̺��� ��� �����Ͱ� ������
   -> delete from ���̺�� where ����..;
*/
delete from member where id = '200';
delete from member;

/*
   truncate : ���̺��� ��ü ���� �����Ҷ� ����ϴ� ����
   -> �ǵ��� �� ���� -> �� ���������� ����
*/
delete from member;
rollback;
select * from member;

truncate table member;



