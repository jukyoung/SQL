/*
   TCL (Transaction Control Language)
   : 트랜잭션 제어 언어
   - commit, rollback
   
   트랜잭션 : 한번에 수행되야하는 작업의 단위
   
   예) ATM
   1. 카드 삽입
   2. 메뉴 선택(인출)
   3. 금액 확인 / 비밀번호 인증
   4. 사용자가 입력한 금액이 해당 계좌에서 뽑을 수 있는 금액인지 확인
   5. 실제 현금 인출
   6. 카드 뽑고 끝
   
   == 현금을 인출한다 하는 하나의 작업
   -> 6번까지 작업이 정상적으로 완료가 됐을 때 -> commit (최종 저장)
   -> 6번까지의 작업 중에서 하나라도 비정상 흐름이 발생하면 그때는 모든 작업을 rollback(취소)
  
  commit : 트랜잭션 작업이 정상적으로 완료되면 변경 내용을 영구적으로 저장
  savepoint <savepoint명> : 현재 트랜잭션 작업 시점에다가 이름 부여 (하나의 트랜잭션 안에서 구역을 나누는 것)
  rollback : 트랜잭션 작업을 모두 취소하고 최근에 commit 했던 지점으로 돌아가는 것
  rollback to savepoint명 : 해당 savepoint로 되돌아 간다
*/

create table tbl_user(
  no number unique
  , id varchar2(100) primary key
  , pw varchar2(100) not null
);

insert into tbl_user values(1, 'user1', 'pw1');
insert into tbl_user values(2, 'user2', 'pw2');
insert into tbl_user values(3, 'user3', 'pw3');

select * from tbl_user;

commit;

insert into tbl_user values(4, 'user4', 'pw4');

rollback;

insert into tbl_user values(4, 'user4', 'pw4');
savepoint sp1;

insert into tbl_user values(5, 'user5', 'pw5');

rollback to sp1;
rollback;

-- rollback 명령어를 수행하는 순간 기존에 존재하던 savepoint 들은 모두 사라짐
