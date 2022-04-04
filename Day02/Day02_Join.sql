/*
 조인문(JOIN)
 : 두 개 이상의 테이블을 결합 하는 것 ->
     조합하려고 하는 테이블에서 각 테이블의 공통된 컬럼을 데이터로 합쳐서 표현하는 것
    조건을 제시하지 않으면 이중 for 문과 비슷한 형태로 동작 -> 모든 경우의 수를 조회
    
    ANSI 표준 Join
    Oracle Join
*/
select * from employee; -- 23개
select * from department; -- 9개
select * from employee, department; --207개 모든 경우의 수를 다 조합해서 나온것

/*
 조인문을 사용할때 각 테이블이 가지고 있는 컬럼명이 같은 때 / 컬럼명이 다를 때
*/
-- 부서코드가 같은 employee, department 테이블의 사번, 사원명, 부서코드, 부서명 조회
-- 기준이 되는 컬럼명이 다를 때 (dept_code /dept_id)
-- oracle 문법
select emp_id, emp_name, dept_code, dept_title from employee, department
 where dept_code = dept_id;

-- ANSI
select emp_id, emp_name, dept_code, dept_title 
  from employee join department
   on (dept_code = dept_id);

-- 두 개의 테이블에서 컬럼명이 같을 때
-- employee, job;
select * from employee, job order by 1;
-- 사번, 사원명, 직급코드, 직급명
-- 각 테이블에 별칭을 부여 -> 테이블명 별칭
-- 이름이 같은 컬럼명 앞에 테이블의 별칭.컬럼명 형식으로 어떤 테이블의 컬럼을 얘기하는건지 명시
-- select 구문에서도 구분해줘야함
-- oracle
select emp_id, emp_name, e.job_code, job_name
  from employee e, job j where e.job_code = j.job_code;
-- ANSI : 두 테이블의 같은 컬럼명 -> using(컬럼명)
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
 5. 다중 Join
 ** Non-Equi Join
*/

/*
 Cross Join (상호 조인) : 조인되는 테이블에 조건을 걸어주지 않아서 모든 데이터(모든 경우의 수가) 조합되어 나오는 경우
   : 한 테이블의 총 행수 * 다른 테이블의 총 행수
*/
 select * from employee, department; -- oracle
 select * from employee cross join department; --ANSI

/*
  Inner Join (내부 조인 /교집합) : 가장 많이 사용하는 join 형태
   : 테이블 A와 테이블 B 에서 조건이 맞는 데이터만 반환
   select 컬럼... from 테이블A, 테이블B where 조건; -- oracle
   select 컬럼... from 테이블A inner join 테이블B on 조건; -- ANSI
   select 컬럼... from 테이블 A join 테이블B on 조건; -- ANSI (ANSI 문법에서 join만 써있으면 inner join)
*/
select * from employee, department where dept_code = dept_id; -- oracle
select * from employee inner join department on (dept_code = dept_id); -- ANSI

-- 총무부, 회계관리부인 사원들의 사원명, 이메일, 부서명, 부서코드만 조회
-- oracle
select emp_name "사원명", email "이메일", dept_title "부서명", dept_code "부서코드"
  from employee, department where dept_code = dept_id 
   and dept_title in ('총무부', '회계관리부');
-- ANSI
select emp_name "사원명", email "이메일", dept_title "부서명", dept_code "부서코드"
 from employee inner join department on(dept_code = dept_id)
  where dept_title in ('총무부', '회계관리부');

-- 해외 영업부(해외영업1,2,3부)의 모든 직원들의 사번, 사원명, 부서명, 부서코드, 연봉 출력 -- inner join
-- ANSI
select emp_id "사번", emp_name "사원명", dept_title "부서명",
    dept_code "부서코드", salary*12 "연봉"
    from employee inner join department on (dept_code = dept_id)
    where dept_title like '%해외영업%';
-- oracle
select emp_id "사번", emp_name "사원명", dept_title "부서명",
    dept_code "부서코드", salary*12 "연봉"
    from employee, department where dept_code = dept_id
    and dept_title like '%해외영업%';
    
-- 대리급 사원(직책 = 대리)들의 급여 목록 확인
-- 대리급 사원들의 사원명, 직급코드, 직급명, 부서코드(null - 인턴), 월급 조회
-- 월급 -> 통화표시와 단위표시
-- 이름 오름차순, 월급 내림차순
select * from employee, job;
-- oracle
select emp_name "사원명",  e.job_code "직급코드", job_name "직급명",
 nvl(dept_code, '인턴') "부서코드", to_char(salary, 'L999,999,999') "월급"
  from employee e, job j where e.job_code = j.job_code
  and job_name = '대리' order by 1, 5 desc;
-- ANSI
select emp_name "사원명",  job_code "직급코드", job_name "직급명",
 nvl(dept_code, '인턴') "부서코드", to_char(salary, 'L999,999,999') "월급"
 from employee inner join job using(job_code)
  where job_name = '대리' order by 1, 5 desc;

---------------------------------------------------------------------------
/* Left Outer Join (외부 조인/합집합 -> 왼쪽 외부 조인)
   : 조인하는 테이블 A의 데이터를 모두 반환, 테이블 B는 조건 구문에 일치하는 데이터만 반환
   -> inner join 조건을 걸게 되면 조건에만 맞는 데이터가 반환
   -> left outer join 조건이 일치하지 않아도 왼쪽 테이블의 데이터는 모두 반환
   oracle : select 컬럼.. from 테이블A, 테이블B where 컬럼 = 컬럼(+);
   ANSI : select 컬럼.. from 테이블A left outer join 테이블B on()/using();
*/
-- 모든 직원들의 부서명 출력
select * from employee;
select * from department;
select emp_name, dept_title from employee, department where dept_code = dept_id;
 -- inner join을 사용할 경우 조건이 일치하지 않는 데이터가 full로 조회되지 않은 경우 발생
-- oracle
select emp_name, dept_title from employee, department
 where dept_code = dept_id(+);
--ANSI
select emp_name, dept_title from employee left outer join department 
 on(dept_code = dept_id);

-- 기술지원부를 제외하고 모든 부서 직원의 사번, 사원명, 부서명, 연봉 조회
-- 부서명이 없는 직원 -> '미정' 정렬은 부서명, 사번, 연봉 오름차순으로
-- oracle
select emp_id "사번", emp_name "사원명", nvl(dept_title, '미정') "부서명", salary*12 "연봉"
 from employee, department where dept_code = dept_id(+)
  and dept_title != '기술지원부' order by 3,1,4;
-- ANSI
select emp_id "사번", emp_name "사원명", nvl(dept_title, '미정') "부서명", salary*12 "연봉"
 from employee left outer join department on(dept_code = dept_id)
  where dept_title != '기술지원부' or dept_code is null order by 3,1,4;
-- != / = / like/ not like 같은 equal 연산자를 이용하게 되면 null 값을 제대로 된 비교가 되지 않아 모두 제외돼 버림 
-- null 값을 출력하고 싶다면 우회적으로 추가적인 조건 붙여줌.

/*
 Right Outer Join (합집합/ 오른쪽 외부 조인)
  : 조인하고자 하는 테이블 A와 테이블 B가 있을 때, 테이블 A는 조건 구문에 일치하는 데이터만 반환, 테이블 B는 조건에 상관없이 모든 데이터 반환
  oracle : select 컬럼.. from 테이블A, 테이블B where 컬럼(+) = 컬럼;
  ansi : select 컬럼.. from 테이블A right outer join 테이블B on()/using();
*/
select emp_name, dept_title from employee, department where dept_code(+) = dept_id;
select emp_name, dept_title from employee right outer join department on(dept_code = dept_id);

/*
  Full Outer Join(합집합)
   : 테이블 A와 테이블 B를 조인할때 조건에 맞지 않더라도 모든 데이터 출력
  ansi : select 컬럼명.. from 테이블A full outer join 테이블B on()/using(); 
*/
-- 모든 직원명, 모든 부서명 출력
select emp_name, dept_title from employee full outer join department
  on(dept_code = dept_id);
  
/*
   Non-Equi Join (비등가 조인)
   -> 지정한 컬럼의 값이 일치하는 경우가 아니라
   값의 범위에 포함되는 행을 연결(between, <, >, <= 등)
*/
insert into kh.employee 
    values('999', '신아람', '990101-1111111', 'gg@kh.or.kr', '01011111111', 'D8', 'J5', 'S1',
        8000, 0.3, null, to_date('90/02/06', 'YY/MM/DD'), null, 'N'); -- 샘플데이터
select * from employee;
-- emp_id, emp_name, salary, sal_level -> sal_level -> min_sal 와 max_sal 사이인 경우에만
select * from sal_grade;

select emp_id, emp_name, salary, s.sal_level
 from employee e inner join sal_grade s
  on(salary between min_sal and max_sal);

delete employee where emp_name = '신아람'; -- 샘플 데이터 삭제

/*
  Self Join : 다른 테이블이 아닌 같은 테이블을 조인하는 것
  -> 똑같은 테이블을 join 하기 때문에 각 테이블에 별칭을 반드시 지정하고
  -> 사용하려는 컬럼명 어떤 별칭에 해당하는 컬럼명을 사용하려는건지 명확히 해줘야함. -> 모호..
*/
-- 각각의 사원들에 대한 manager_id 확인
select emp_id, emp_name, manager_id
  from employee;
-- manager_id에 해당하는 사원명(매니저명)도 추가하고 싶다면?
select e1.emp_id "직원사번", e1.emp_name "직원명", e1.manager_id "매니저 사번", e2.emp_name "매니저명"
  from employee e1 join employee e2
    on (e1.manager_id = e2.emp_id);

-- 매니저명과 해당 매니저가 관리하고 있는 사원명, 급여를 조회
select e1.emp_name "매니저명", e2.emp_name "사원명", e2.salary "급여"
  from employee e1 join employee e2
   on(e1.emp_id = e2.manager_id);

/*
  다중 Join : 여러 개의 조인문을 사용하는 경우
*/
-- employee department 조인 -> 사번, 사원명, 부서코드, 부서명
select emp_id "사번", emp_name "사원명", dept_code "부서코드", dept_title "부서명"
 from employee join department
  on(dept_code = dept_id);
-- 사번, 사원명, 부서코드, 부서명 + 부서지역명
select * from location;

select dept_id, dept_title, local_name
 from department join location
  on(location_id = local_code);
  -- ansi
select emp_id "사번", emp_name "사원명", dept_code "부서코드", 
 dept_title "부서명", local_name "부서지역명"
  from employee join department on (dept_code = dept_id)
   join location on(location_id = local_code);
-- oracle
select emp_id "사번", emp_name "사원명", dept_code "부서코드", 
 dept_title "부서명", local_name "부서지역명"
 from employee, department, location
  where dept_code = dept_id and location_id = local_code;
