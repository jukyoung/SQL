/*
   view
   : 하나 이상의 테이블에서 원하는 데이터를 선택해서 새로운 가상 테이블을 만들어 주는 것
   -> 뷰를 통해 만들어진 테이블이 물리적으로 존재하는 것은 아니고, 다른 테이블의 데이터만 조합하여 보여주는 것
   -> 특정한 계정이 원본 테이블에 접근해서 모든 데이터(불필요한 데이터)에 접근하는 걸 방지할 수 있음
   -> 뷰를 생성하는 권한 -> 뷰의 내용을 수정하면 -> 실제 원본 테이블의 데이터도 수정됨
   -> 원본테이블의 내용이 수정되면 뷰의 내용도 수정된다 -> 데이터 실시간 공유(업데이트)
   create view 뷰 이름 as select구문
*/
-- system 계정에서 뷰 생성 권한 부여
grant create view to kh;

-- employee -> emp_no, emp_name, email, phone
create view emp_view as select emp_no, emp_name, email, phone from employee;
select * from emp_view;

-- test01 계정한테 위에서 만든 emp_view에 접근권한 주기
-- view에 대한 select 권한을 줄때 system이 아니라 실제 그 view를 생성한 kh에서 권한 부여
grant select on kh.emp_view to test01;
commit;
-- test01 계정에서 확인 -> 접근 가능
select * from kh.emp_view;

-- kh계정에서 선동일 -> 이름을 김동일 으로 수정
update employee set emp_name = '김동일' where emp_name = '선동일';
select * from employee;
commit;
-- test01 계정에서 확인 (수정되어있음)
select * from KH.emp_view;

-- 뷰 삭제
drop view emp_view;
commit;

select * from kh.emp_view;

------------------------------------------------------------------------------
/*
   sequence : 순차적으로 정수 값을 자동으로 생성하는 객체
             -> 자동번호 발생기
   create sequence 시퀀스명
   1. start with 숫자 -> 몇번부터 번호를 시작할건지
   2. increment by 숫자 -> 몇 단위로 숫자를 증가시킬건지
   3. maxvalue 숫자 / nomaxvalue -> 시퀀스의 최대값 지정 / 지정 X
   4. minvalue 숫자 / nominvalue -> 시퀀스의 최소값 지정 / 지정 X
   5. cycle / nocycle -> 만약 최대값에 도달하면 처음으로 돌아가 다시 순번을 매기기 시작할건지
   6. cache / nocache -> 메모리상에 미리 시퀀스를 뽑아 올려두고 사용하는 것 / 메모리상에 올려놓지 X
*/
create sequence seq_temp
  start with 1
  increment by 1
  nomaxvalue
  nocycle
  nocache;
drop sequence seq_temp;
select * from user_sequences where sequence_name = 'SEQ_TEMP';

/*
  nextval : 현재 시퀀스의 다음 값을 반환함과 동시에 시퀀스를 증가
  currval : 현재 값을 반환 -> 계정에 접속하고나서 nextval이 단한번도 쓰이지 않았다면 사용 x
*/
select seq_temp.nextval from dual;
select seq_temp.currval from dual;

select * from coffee;

insert into coffee values(seq_temp.nextval, 4000, 'Max');
insert into coffee values(seq_temp.nextval, 4000, 'Max');

drop sequence seq_temp;

