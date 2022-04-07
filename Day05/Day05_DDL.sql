/*
  DDL(Data Definition Language)
  : 데이터 정의어
  : 데이터베이스 객체 생성(create), 수정(alter), 삭제(drop) 하는 구문
  
  오라클 객체 종류
  : 사용자(user), 테이블(table), 뷰(view), 시퀀스(sequence)..
  
  테이블을 기준으로.
  생성(create)
  -> creat table 테이블명(컬럼명 자료형(크기), 컬럼명 자료형(크기)........);
*/
create table temp(id varchar2(300), 
   pw varchar2(500), 
   age number(100), 
   join_date date
   );
/*
  제약 조건(constraints)
  : 테이블을 생성할 때 구성하는 컬럼에 들어갈 데이터에 대해 제약조건을 설정하는것
  -> 데이터의 일관성과 정확성을 유지하기 위해서(데이터 무결성)
  
  - not null : 해당 컬럼에 null 값이 들어갈 수 없음 -> null 값 허용 X
  - unique : 중복된 값을 허용 X
  - primary key (기본키) : null 값 허용 X 중복값 허용 X -> 컬럼의 고유 식별자로 사용
  - foreign key (외래키) : 두 테이블 간의 관계를 설정하고 
    -> A테이블(id,pw,...) B테이블(member_id, count...) 
       B테이블의 member_id 컬럼에 있는 값이 A테이블의 id에 있는 데이터여야 하는 경우
  - check : 해당 컬럼에 저장 가능한 값의 범위 조건을 지정해서 설정한 값만 허용
*/
select constraint_name, constraint_type from user_constraints
 where table_name = 'EMPLOYEE';
-- P : primary key / C : check / not null
-- 제약조건을 걸때 따로 이름을 지정하지 않으면 자동으로 붙여줌

/*
   not null : null 값을 허용 X -> 해당 컬럼에 반드시 값이 기록되어야 하는 경우 사용
*/
create table user_nocons(
 no number
 , pw varchar2(100)
 , name varchar2(100)
 , gender varchar2(10)
);
select * from user_nocons;
insert into user_nocons values(1, 'abc123', 'tom', '남');
insert into user_nocons values(2, null, null, '여');

create table user_cons(
  no number not null -- 컬럼명 자료형(길이) 제약조건
  ,pw varchar2(100) not null
  , name varchar2(100) not null
  , gender varchar2(10)
);
select * from user_cons;
insert into user_cons values(1, 'aaa555', 'paul', '남');
insert into user_cons values(2, null, null, '여');
-- 데이터를 삽입할 때부터 제약조건에 부합하지 않는다면 데이터가 들어가지 않음

/*
   unique : 해당 컬럼에 중복값을 제한하는 제약조건
   - null 값도 들어감 → 값을 안넣어도 됨.
*/
select * from user_nocons;
insert into user_nocons values(1, 'eee555', 'will', '남');

drop table user_cons; -- 테이블 삭제 구문

/*
  제약조건을 거는 방식
  - 컬럼 레벨 : 컬럼명 자료형(길이)옆에 제약조건명을 명시하는 경우
  - 테이블 레벨 : 컬럼을 모두 정의한 후 마지막에 제약조건명(컬럼명) 형식으로 제약조건을 걸어주는 방식
  ** not null -> 컬럼 레벨에서만 제약조건 걸어줄 수 있다
*/

create table user_cons( -- 컬럼 레벨에서 제약조건 걸기
  no number unique not null
  ,pw varchar2(100) not null  
  , name varchar2(100) not null
  , gender varchar2(10)
);

create table user_cons( -- 테이블 레벨에서 제약조건 걸기 
  no number 
  ,pw varchar2(100) not null  
  , name varchar2(100) not null
  , gender varchar2(10)
  , unique(no) -- 테이블 레벨에서 unique 제약조건걸기
);

select * from user_cons;
insert into user_cons values(1, '11234', 'tom', '남');
insert into user_cons values(null, '12345', 'sam', '남');

/*
   primary key : 컬럼의 데이터가 중복값을 허용 x null 값 허용 x = 고유 식별자
   -> unique + not null = primary key
   -> 하나의 테이블에서 primary key는 딱 하나만 걸어줄 수 있음 -> 고유 식별자이기 때문
   -> unique + not null 제약조건은 하나의 테이블에서도 여러번 사용이 가능하기 때문에
      고유식별자는 아니지만 중복값과 null값을 허용하면 안되는 경우에 사용한다.
*/
drop table user_cons;
create table user_cons(
  no number primary key
  , id varchar2(100) primary key
  , nickname varchar2(200) unique not null
  , pw varchar2(100) not null
  , name varchar2(100) not null
  , gender varchar2(10)
);
select * from user_cons;
insert into user_cons values (null, '1234', 'tom','남');
insert into user_cons values (1, '1234', 'tom','남');

/*
   primary key 에 대한 하나의 컬럼이 아니라 여러개의 컬럼에 대한 복합키 형태로 적용을 시키고 싶으면
   컬럼레벨에서는 불가
   복합키 -> 컬럼 두개 이상을 묶어서 설정하는 키 
   각각의 컬럼에 대해서 unique ,not null 적용이 아니라 세트로서 적용이 됨
   -> 하나만 달라도 적용이 된다 라는 의미
   
*/
create table user_cons( -- no, id를 하나로 묶어서 primary key
  no number 
  , id varchar2(100) 
  , pw varchar2(100)
  , gender varchar2(10)
  , primary key (no, id)
);
select * from user_cons;
insert into user_cons values(1, 'abc', 'aaa555', '남');
insert into user_cons values(1, 'cba', 'aaa555', '남');

/*
  foreign key (외래키) : 참조된 다른 테이블이 제공하는 값만 사용할 수 있도록 제약하고 싶을 때.
  => 참조하는 컬럼과 참조되는 컬럼을 통해 두 테이블간에 관계가 생성이 됨.
  => 참조하는 컬럼이 참조되는 컬럼에 있는 값과 일치하거나, null 값만 가질 수 없음
  ** 참조하는 컬럼 : 참조 대상을 참조하는 테이블의 컬럼 (B_대여_테이블)
  ** 참조되는 컬럼 : 참조 대상이 되는 테이블 컬럼(A_학생_테이블)
*/
-- 학생 테이블 /대여 테이블
create table student(
  id varchar2(100) primary key
  , name varchar2(100) not null
  , age number not null
);
-- 3명의 학생 데이터
insert into student values('001', 'tom', 20);
insert into student values('002', 'salley', 30);
insert into student values('003', 'chloe', 25);
select * from student;

drop table borrow;
-- 도서 대여 테이블
create table borrow( -- 테이블 레벨
  book_id varchar2(100) primary key
  , std_id varchar2(100)
  , rent_date date
  , foreign key (std_id) references student (id) 
  -- foreign key (참조하는 컬럼) references 참조대상 테이블명 (참조대상 컬럼명)
);
create table borrow( -- 컬럼 레벨
  book_id varchar2(100) primary key
  , std_id varchar2(100) references student (id) -- 컬럼명 자료형(길이) references 참조대상 테이블명 (참조대상 컬럼명)
  , rent_date date
);
insert into borrow values('500', '002', sysdate);
select * from borrow;

-- 참조되고 있는 id -> 002 -> 삭제
-- 참조되고 있는 컬럼의 데이터를 가지고 있는 자식 컬럼이 있다면 원본 테이블의 데이터 삭제 x
select * from student;
delete from student where id = '002';

/*
   삭제 옵션
   -> 부모 테이블에서 데이터를 삭제 할때 자식 테이블에 있는 데이터를 어떤 방식으로 처리할지
   -> 제약조건을 걸때 삭제옵션도 함께 걸어 줌
   -> 기본 삭제 옵션은 on delete no action -> 자신을 참조하는 데이터가 있다면 삭제 할 수 없다
*/
-- on delete set null
-- 만약 참조하고 있던 부모 데이터가 삭제되면 자식 데이터를 null 값으로 설정
drop table borrow;
create table borrow( 
  book_id varchar2(100) primary key
  , std_id varchar2(100) references student (id) on delete set null
  , rent_date date
);
insert into borrow values('501', '003', sysdate);
select * from borrow;
select * from student;
delete from student where id = '002';

-- on delete cascade
-- 부모 데이터가 삭제되면 해당 데이터를 참조하고 있는 자식 데이터 역시도 함께 삭제
-- 예시) 1번 게시글 작성 -> 1번 글번호를 참조하는 댓글 3개 달렸음
-- 1번 게시글 삭제 -> 댓글 3개도 모두 함께 삭제됨
create table borrow( 
  book_id varchar2(100) primary key
  , std_id varchar2(100) references student (id) on delete cascade
  , rent_date date
);
insert into borrow values('501', '003', sysdate);
select * from borrow;

delete from student where id = '003';

----------------------------------------------------------------------------
/*
  check
  : 해당 컬럼에 입력되거나, 수정되어 들어오는 값을 체크해 설정한 값만 들어올 수 있게끔 제한
*/
drop table user_cons;
create table user_cons(
  no number 
  , id varchar2(100) 
  , pw varchar2(100)
  , gender varchar2(10) check(gender in('남', '여'))
  , primary key (no, id)
);
insert into user_cons values(1, 'ab123', 'sdfsdf', '망고');
insert into user_cons values(1, 'ab123', 'sdfsdf', '남');
select * from user_cons;

-- default
create table temp(
 date_one date
 , date_two date default sysdate
);
insert into temp values(sysdate); -- 컬럼의 총 개수와 일치하지 않는 데이터를 넣고 있어 에러 발생
insert into temp values(sysdate, default); -- default라는 키워드를 이용해 값을 넣으면 테이블 생성 시 default로 잡아 준 값이 들어간다
select * from temp;

-----------------------------------------------------------------------------------------------------------------------------

/*
  drop : 객체를 삭제하기 위해 사용하는 구문
*/
drop table temp;

-----------------------------------------
/*
  alter : 테이블에 정의된 내용을 수정하고자 할때 사용하는 데이터 정의어
  -> 컬럼 추가/삭제, 제약조건 추가/삭제, 컬럼의 자료형 변경, default 값 변경
  -> 테이블명/컬럼명/제약조건의 이름 변경
*/
create table member(
  no number primary key
  , id varchar2(100)
  , pw varchar2(100)
);

select * from member;
-- 테이블의 정보를 보기 위해서는 desc
desc member;

-- 이미 존재하는 member 테이블에 새로운 컬럼 추가 (name)
alter table member add (name varchar2(100));

-- 새로운 컬럼 추가 (age) + default
alter table member add (age number default 0);

-- 제약 조건 추가 -> id 컬럼에 unique 제약조건 추가
alter table member add constraint id_unq unique(id); -- 지금 추가해줄 제약조건에 대한 이름
select constraint_name, constraint_type from user_constraints where table_name = 'MEMBER';

-- 제약 조건 추가 -> pw not null 제야 조건 추가 -> add 로 접근하지 x
-- not null은 modify 로 제약조건 추가가 가능함 -> 기존의 데이터가 비어있어야 함
alter table member add constraint pw_nn not null(pw); -- 오류
alter table member modify pw constraint pw_nn not null;

-- 컬럼명 수정 -> pw 컬럼을 password 라고 변경
alter table member rename column pw to password;
desc member;

-- 컬럼의 데이터 타입 수정 - name varchar2(100) -> char(100)
alter table member modify name char(100);

-- 컬럼 삭제 -> age 컬럼 삭제
alter table member drop column age;

-- 제약조건 삭제 -> password 컬럼의 제약조건 삭제
-- 제약조건의 이름을 먼저 알아야 함 -> 그 이름을 이용해 삭제
select constraint_name from user_constraints where table_name = 'MEMBER';
alter table member drop constraint pw_nn;

-- 제약조건명 수정
alter table member rename constraint SYS_C007129 to no_pk;

-- 테이블명 변경
alter table member rename to tbl_member;
select * from tbl_member;
