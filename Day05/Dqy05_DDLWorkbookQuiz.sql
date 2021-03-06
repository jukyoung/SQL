-- 1. 계열 정보를 저장할 카테고리 테이블을 맊들려고 핚다. 다음과 같은 테이블을 작성하시오.
create table tb_category(
 name varchar2(10)
 , use_yn char(1) default 'Y'
);

-- 2. 과목 구분을 저장할 테이블을 만들려고 한다. 다음과 같은 테이블을 작성하시오.
create table tb_class_type(
 no varchar2(5) primary key
 , name varchar2(10)
);

-- 3. TB_CATEGORY 테이블의 NAME 컬럼에 PRIMARY KEY 를 생성하시오.
--(KEY 이름을 생성하지 않아도 무방함. 만일 KEY 이를 지정하고자 한다면 이름은 본인이 알아서 적당한 이름을 사용한다.)
alter table tb_category add constraint name_pk primary key(name);

desc tb_category;
select constraint_name, constraint_type from user_constraints where table_name = 'TB_CATEGORY';

-- 4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오.
alter table tb_class_type modify name constraint name_nn not null; 
select constraint_name, constraint_type from user_constraints where table_name = 'TB_CLASS_TYPE';

-- 5. 두 테이블에서 컬럼 명이 NO 인 것은 기존 타입을 유지하면서 크기는 10 으로, 컬럼명이
-- NAME 인 것은 마찬가지로 기존 타입을 유지하면서 크기 20 으로 변경하시오.
alter table tb_class_type modify no varchar(10) modify name varchar2(20);
desc tb_class_type;
alter table tb_category modify name varchar2(20);
desc tb_category;

-- 6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을 각 각 TB_ 를 제외한 테이블 이름이 앞에붙은 형태로 변경한다. (ex. CATEGORY_NAME)
alter table tb_category rename column name to category_name;
alter table tb_category rename column use_yn to category_use_yn;
alter table tb_class_type rename column no to class_type_no;
alter table tb_class_type rename column name to class_type_name;

--7. TB_CATEGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이 변경하시오.
-- Primary Key 의 이름은 "PK_ + 컬럼이름"으로 지정하시오. (ex. PK_CATEGORY_NAME )
select constraint_name from user_constraints where table_name = 'TB_CATEGORY';
alter table tb_category rename constraint name_pk to pk_category_name;

select constraint_name from user_constraints where table_name = 'TB_CLASS_TYPE';
alter table tb_class_type rename constraint SYS_C007132 to pk_class_type_no;

-- 8. 다음과 같은 INSERT 문을 수행핚다.
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT;
select * from tb_category;

-- 9.TB_DEPARTMENT 의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 부모값으로 참조하도록
-- FOREIGN KEY 를 지정하시오. 이 때 KEY 이름은 FK_테이블이름_컬럼이름으로 지정한다. (ex. FK_DEPARTMENT_CATEGORY )

select * from tb_department;
desc tb_department;
alter table tb_department add constraint 
  fk_department_category foreign key(category) references tb_category(category_name); 

-- 10. 춘 기술대학교 학생들의 정보만이 포함되어 있는 학생일반정보 VIEW 를 만들고자 한다. 
-- 아래 내용을 참고하여 적절한 SQL 문을 작성하시오.
/*
뷰 이름
 VW_학생일반정보
컬럼
 학번
 학생이름
 주소
*/

create view vw_학생일반정보 
 as select student_no "학번", student_name "학생이름", student_address "주소" 
  from tb_student;

-- 11. 춘 기술대학교는 1 년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행한다.
--이를 위해 사용할 학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW 를 만드시오.
--이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오 (단, 이 VIEW 는 단순 SELECT
--만을 할 경우 학과별로 정렬되어 화면에 보여지게 만드시오.)
create view vw_지도면담 
  as select student_name "학생이름", department_name "학과이름",
   nvl(professor_name, '없음') "담당교수 이름" 
   from tb_student join tb_department using(department_no)
   left outer join tb_professor on(coach_professor_no = professor_no) order by 2;
  
   select * from vw_지도면담;

-- 12. 모든 학과의 학과별 학생 수를 확인할 수 있도록 적절한 VIEW 를 작성해 보자.
create view vw_학과별학생수
 as select department_name , count(*) "student_count" 
   from tb_student join tb_department using(department_no) 
    group by department_name order by 1;
    
    select * from VW_학과별학생수;

--13. 위에서 생성한 학생일반정보 View 를 통해서 학번이 A213046 인 학생의 이름을 본인
-- 이름으로 변경하는 SQL 문을 작성하시오.
select * from vw_학생일반정보;
 update vw_학생일반정보 set 학생이름 = '김땡땡' where 학번 = 'A213046';

-- 14. 13번에서와 같이 VIEW 를 통해서 데이터가 변경될 수 있는 상황을 막으려면 VIEW 를 어떻게 생성해야 하는지 작성하시오
drop view vw_학생일반정보;
create view vw_학생일반정보 
 as select student_no "학번", student_name "학생이름", student_address "주소" 
  from tb_student with read only;

--15. 춘 기술대학교는 매년 수강신청 기간만 되면 특정 인기 과목들에 수강 신청이 몰려문제가 되고 있다.
-- 최근 3 년을 기준으로 수강인원이 가장 많았던 3 과목을 찾는 구문을 작성해보시오.
select * from (select row_number() over(order by count(*) desc) "순위",
class_no "과목번호", class_name "과목이름", count(*) "수강인원"
  from tb_student join tb_grade using(student_no)
   join tb_class using(class_no) group by class_no, class_name)
    where "순위" <= 3 order by 4 desc;
  