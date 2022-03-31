/*
자바에서 메서드(method) = 오라클에서는 함수(Function)

- 단일 행 함수 : 각 행마다 반복적으로 적용돼서 입력받은 행의 개수만큼 결과를 반환
ex) length() -> 데이터의 길이값 반환

- 그룹 함수 : 특정한 행들의 집합으로 그룹이 형성되어 => 그룹당 1개의 결과를 반환 
ex) sum()
*/
-- 문자형 함수
-- length() : 데이터의 길이값 반환 (말그래도 길이 값 3글자면 길이값도 3)
-- lengthb() : 주어진 컬럼/문자열에 대한 길이(byte)로 반환해주는 함수 (메모리 영역에 저장되는 길이값)
select emp_name, length(emp_name), lengthb(emp_name) from employee;

-- instr(컬럼/문자열, 찾고자 하는 문자(열), 시작 인덱스, 검색된 문자(열)의 순번) : 특정 문자열에서 찾고자 한는 문자열(문자열의 위치)을 찾아주는 함수
-- 시작 인덱스에 음수값을 제시하면 뒤에서부터 탐색
-- dual 테이블 : 오라클에서 제공해주는 연산,함수 실행 용도로 사용하는 특수한 테이블
select instr('Hello World Hi High', 'H', 1, 1) from dual;
select instr('Hello World Hi High', 'H', 1, 2) from dual;
select instr('Hello World Hi High', 'H', 2, 2) from dual;
select instr('Hello World Hi High', 'H', -1, 1) from dual;

--employee 테이블에서 email, email컬럼의 @ 위치를 조회
select email, instr(email, '@', 1, 1) from employee;

-- lpad(대상이되는 컬럼/문자열, 반환할 길이, 덧붙일 문자(열)) / rpad() 
-- : 주어진 컬럼/ 문자열을 대상으로 해서 임의의 문자열을 왼쪽/오른쪽에 덧붙여서 길이N의 문자열을 반환하는 함수
select rpad(email, 20, '#') from employee;

-- ltrim(대상이되는 컬럼/문자열, 제거하고 싶은 문자(열)) / rtrim()
-- : 주어진 컬럼/문자열을 대상으로 제거하고 싶은 문자를 제거한 뒤 나머지를 반환하는 함수
-- ltrim 제거하고 싶은 문자열이 왼쪽(문자열의 시작)에 위치해 있을때 / rtrim 문자열의 오른쪽(문자열의 끝)에 제거하고 싶은 문자열이 위치
select rtrim(email, 'kh.or.kr') from employee;
select ltrim(email, 's') from employee;

-- 문제 1
-- Hello KH Java 문자열을 Hello KH 가 출력되게 하여라.
select rtrim('Hello KH Java', 'Java') from dual;

-- 문제 2
-- Hello KH Java 문자열을 KH Java 가 출력되게 하여라.
select ltrim('Hello KH Java', 'Hello') from dual;

-- 문제 3
-- DEPARTMENT 테이블에서 DEPT_TITLE을 출력하여라
-- 이때, 마지막 부 글자를 빼고 출력되도록 하여라 / ex)회계관리부 -> 회계관리
select rtrim(dept_title, '부') from department;

-- 문제 4
-- 다음문자열에서 앞뒤 모든 숫자를 제거하세요.
-- '982341678934509hello89798739273402'
select rtrim(ltrim('982341678934509hello89798739273402', '0123456789'),'0123456789') from dual;

-- substr(대상이 되는 컬럼/문자열, 문자열을 잘라낼 위치, 반환할 문자의 개수)
-- : 대상이 되는 컬럼/문자열에서 시작위치로부터 제시한 문자의 개수만큼 문자(열)을 잘라서 반환해주는 함수
select substr('HappyHappyDay', 1, 5) from dual;
select substr('HappyHappyDay', 6, 8) from dual;
select substr('HappyHappyDay', 7, 3) from dual;
select substr('HappyHappyDay', -7, 3) from dual;

-- employee 테이블에서 사원명 조회 -> 성만 중복없이 사전순으로 조회 
select distinct substr(emp_name, 1, 1) from employee order by 1;
-- employee 테이블에서 남자 사원의 사원번호, 사원명, 주민번호, 연봉을 조회
-- 주민번호의 뒷자리 6자리는 모두 *로 표시하시오.
select * from employee;
select emp_id "사원", emp_name "사원명", 
 substr(emp_no,1,8)||'******' "주민번호", salary*12 "연봉" from employee
  where emp_no like '%-1%';
  
select emp_id "사원", emp_name "사원명", 
 substr(emp_no,1,8)||'******' "주민번호", salary*12 "연봉" from employee
  where substr(emp_no, 8, 1) in ('1', '3');

-- concat(대상문자열1, 대상문자열2) : => 두개의 문자열을 하나로 합친 후 반환해주는 함수
select concat(concat('ABCD', '가나다라'),'hi') from dual;
select 'ABCD'|| '가나다라'||'hi' from dual;

-- lower(대상 문자열/ 컬럼) / upper(대상 문자열/ 컬럼) / inicap(대상 문자열/ 컬럼)
-- : lower -> 대상 문자열을 모두 소문자로 변환해주는 함수
-- : upper -> 대상 문자열을 모두 대문자로 변환해주는 함수
-- : initcap -> 단어의 첫 글자만 대문자로 변환해주는 함수
select lower('Welcom To My World') from dual;
select upper('Welcom To My World') from dual;
select initcap('welcom to my world') from dual;

-- replace(대상이 되는 문자열/컬럼, 변경대상이 되는 문자(열), 변경할 문자(열))
-- 대상이 되는 문자열/컬럼을 기준으로 변경대상이 되는 문자(열)를 찾아서 변경할 문자(열)로 바꿔주는 함수
select replace('Hello Hi High', 'Hi', 'Ho') from dual;
select replace('Hello Hi High', 'Hi', '') from dual;

--------------------------------------------------------------------------------------
-- 숫자형 함수
-- abs(숫자) : 인자로 전달받은 숫자의 절대값을 반환해주는 함수
select abs(-10) from dual;

-- mod(숫자/숫자에 해당하는 컬럼, 나눌 값) : 인자로 전달받은 숫자를 나눌 값으로 나눠서 나머지를 반환해주는 함수
select mod(10, 3) from dual;
select mod(10, 2) from dual;
select mod(10, 4) from dual;

-- round(숫자) : 인자로 받은 숫자를 반올림하여 반환해주는 함수
-- round(숫자, 소숫점 인덱스 위치): 인자로 받은 숫자를 지정한 위치 다음 자리수에서 반올림하여 반환해주는 함수
select round(123.678) from dual;
select round(123.456, 1) from dual;
select round(123.456, 2) from dual;
select round(123.456, 0) from dual;
select round(123.456, -2) from dual;

-- floor(숫자) : 인자로 받은 숫자의 소수점 자리를 모두 버리고 반환해주는 함수
select floor(123.456) from dual;
select floor(123.678) from dual;

-- trunc(숫자, 소숫점 위치) : 인자로 받은 숫자를 지정한 위치까지 잘라서 반환해주는 함수
select trunc(123.456, 1) from dual;
select trunc(123.456, 1), round(123.456, 1) from dual;

-- ceil(숫자) : 인자로 받은 숫자의 소수점 자리를 버리고 반환해주는 함수
select ceil(123.456), floor(123.456) from dual;

-- employee 테이블에서 직원명, 입사일, 오늘까지의 근무일수 조회
-- 주말도 포함, 소수점 아래는 버림
select emp_name "직원명", hire_date "입사일", floor(sysdate-hire_date) "근무일수" from employee;

---------------------------------------------------------------------------------------------
-- 날짜 함수
-- sysdate : 시스템에 저장되어 있는 현재 날짜(시간포함) 반환
select sysdate from dual;
-- current_date : session(접속) timezone 에 따라 현재 날짜(시간) 반환
select current_date from dual;

-- months_between(날짜형, 날짜형) : 두 날짜 사이의 개월 수 차이를 반환해주는 함수
select months_between(sysdate, hire_date) from employee;
select floor(months_between(sysdate, hire_date)/12) from employee;
select months_between(sysdate, sysdate-31) from employee;

-- add_months(기준 날짜, 더할 개월 수) : 첫 번째 인자값인 날짜를 기준으로 해서 두 번째 인자값을 더해서 반환해주는 함수
select add_months(sysdate, 1) from dual;
select add_months(sysdate, -1) from dual;

-- employee 테이블에서 사원명, 입사일, 입사 후 6개월이 된 날짜 조회
select emp_name "사원명", hire_date "입사일", add_months(hire_date, 6) "입사일+6개월" from employee;

-- next_day(기준 날짜, 요일/숫자) : 기준 날짜를 기준으로 해서 오른쪽에 해당하는 가장 가까운 날짜를 반환해주는 함수
-- 요일의 형식 : '월' 혹은 '월요일'
-- 숫자의 의미 : 1-일요일 2-월요일 3-화요일 4-수요일 5-목요일 6-금요일 7-토요일
select next_day(sysdate, '월') from dual;
select next_day(sysdate, 2) from dual;

-- last_day(기준 날짜) : 기준 날짜를 바탕으로 해서 해당 날짜가 속한 달의 마지막 날을 반환해주는 함수
select last_day(sysdate) from dual;
select last_day(add_months(sysdate, -1)) from dual;

-- employee -> 사원명, 입사일, 입사월의 마지막날 조회
select emp_name "사원명", hire_date "입사일", last_day(hire_date) "입사월의 마지막날" from employee;
-- 다음달의 마지막날
select last_day(add_months(sysdate, 1)) from dual;

-- extract(year/month/day from date(기준날짜)) : 기준날짜로부터 년/월/일을 추출해서 반환해주는 함수
select extract(year from sysdate) from dual;
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual;

-- employee 테이블에서 사원명 입사년도 입사월 입사일을 조회
select emp_name "사원명", extract(year from hire_date) "입사년도",
 extract(month from hire_date) "입사월", extract(day from hire_date) "입사일" from employee;

-- employee 테이블에서 사원명, 입사일, 년차를 출력
-- 입사일 -> yyyy년MM월DD일 형식으로 출력
-- 년차 출력시에는 소수점은 올림으로 처리 -> 28.144 -> 29년차
-- 출력 시에 정렬은 입사년차 기준으로 오름차순
select emp_name "사원명", concat(extract(year from hire_date), '년') 
 ||concat(extract(month from hire_date), '월') 
 ||concat(extract(day from hire_date), '일') "입사일",
 ceil((sysdate-hire_date)/365) "년차" from employee order by 3;
 
 -- 문자열을 기준으로 order by -> 문자로써 더 작은 숫자를 작다고 인식(10과 3이 있다면 10이 더 작은수)
 
 -- 특별 보너스를 지급 -> 자료가 필요
 -- employee -> 입사일을 기준으로 다음달 1일 부터 6개월을 계산해서 조회
 -- 사원명, 입사일, 기준일, 기준일+ 6개월
 -- 22/01/05 입사 -> 22/02/01 기준일 -> 22/08/01 기준일 + 6개월
 -- 출력시 입사일 기준으로 출력
 select emp_name "사원명", hire_date "입사일", last_day(hire_date)+1 "기준일",
  add_months(last_day(hire_date)+1, 6) "기준일+6개월" from employee order by 2;
  
--------------------------------------------------------------------------------
-- 형변환
-- to_char(date/number, format) : 날짜 혹은 숫자를 특정한 형식의 문자형으로 변환해주는 함수
/*
  Date형 -> 문자형
  년 : YY/ YYYY 
  월 : MM
  일 : DD
*/
select sysdate from dual;
select to_char(sysdate, 'YYYY-MM-DD') from dual;
select to_char(sysdate, 'YYYY/MM/DD') from dual;
-- employee -> 입사년월일 1999년 03월05일 -> 사원명, 입사년월일
-- 한글을 형식에 추가하고 싶다면 한글의 양쪽을 “  “ 로 묶어주기
select emp_name "사원명", to_char(hire_date, 'YYYY"년" MM"월" DD"일"')"입사년월일" from employee;

-- DAY : x요일
select to_char(sysdate, 'YY/MM/DD/DAY')from dual;
-- DY : x(요일)
select to_char(sysdate,'YY/MM/DD/DY') from dual;
-- MONTH : x월
select to_char(sysdate, 'YY/MONTH/DD')from dual;
-- HH MI SS 시분초
select to_char(sysdate, 'HH:MI:SS')from dual;
-- PM/AM : 오후/오전
select to_char(sysdate, 'PMHH:MI:SS')from dual;
-- HH24 : 24시간을 기준으로 표기
select to_char(sysdate, 'HH24:MI:SS')from dual;

-- employee 테이블 사원명, 입사일-> 1990/02/05(화) 형태 출력
select emp_name "사원명", to_char(hire_date, 'YYYY/MM/DD(DY)') "입사일" from employee;

-- 숫자 -> 문자형
-- to_char(대상 숫자, )
-- 123456789 -> 0이나 9를 이용해 문자형으로 변환
select to_char(123456789, '999,999,999') from dual;
select to_char(123456789, '000,000,000') from dual;
-- 9 : 지정해준 형식보다 짧은 숫자가 들어온다면 대상이 되는 숫자 길이에 맞춰서 결과값을 반환
-- 0 : 지정해준 형식보다 짧은 숫자가 들어온다면 형식에 맞춰서 길이를 지정하고 남는 자리수는 0으로 채워 줌
select to_char(12345, '999,999,999') "9", to_char(12345, '000,000,000') "0" from dual;

-- 통화 표시 -> L (local)
select to_char(12345, 'L999,999') from dual;

-- employee -> 직원명, 직급코드, 연봉(원) 조회
-- 단, 연봉은 원화표시
-- 연봉 보너스가 적용된 금액으로 조회(월급+(월급*보너스)*12)
-- nvl(숫자/컬럼, 치환값): 만약 해당 숫자/컬럼 등이 null 값이라면 치환값으로 변환해주는 함수 
select emp_name "직원명", job_code "직급코드",
 to_char((salary+(salary*nvl(bonus,0)))*12, 'L999,999,999') "연봉(원)" 
  from employee;
 
 -----------------------------------------------------------------------------------
-- to_date(숫자/문자, 형식) : 숫자형 혹은 문자형 데이터를 데이트(날짜) 타입으로 바꿔주는 함수
-- 20120505
select to_date(20120505, 'YYYYMMDD')from dual;
select to_date(20120505, 'YYMMDD')from dual;
select to_date('20120505', 'YYYYMMDD') from dual;
-- 시간값을 변환할때 앞에 년/월/일 정보를 주지 않으면 현재 달의 1일로 날짜를 인식해버림
select to_char(to_date('110808', 'hh:mi:ss'), 'YYYY/MM/DD hh:mi:ss')from dual;
-- 년도값 변활할때 2000/1900년대에 대한 값을 명확히 제시하지 않으면 2000년대를 default 값으로 인식
select to_char(to_date('890909', 'YY/MM/DD'), 'YYYY/MM/DD') from dual;

-- employee 테이블에서 2000년도 이후에 입사한 사원명, 사번, 입사일 조회
select emp_name "사원명", emp_id "사번", hire_date "입사일" from employee
 where hire_date >= to_date('20000101', 'YYYYMMDD');
 
-----------------------------------------------------------------------
-- to_number(문자형, 형식) : 문자형을 숫자형으로 변환해주는 함수
--문자형이 이러한 형식으로 들어온다 이지 형식처럼 생기게 바뀌는건 아님
select to_number('123,456,789', '999,999,999') from dual;
select to_number('123,456,789', '999,999') from dual; -- 넘겨주는 문자형식에 맞춰 숫자형식도 동일하게.
select to_number('s123,123', '9999,999') from dual; -- 숫자로 변환불가한 문자열 넘겨줄 수 x

-- 묵시적 형변환
-- : 오라클에서는 어느 정도 자동적으로 자료형을 유추해서 형변환
-- 하지만 -> 묵시적 형변환에 의지 x -> 정확한 연산을 위해서는 정확한 자료형으로 변환한 후에 연산
select emp_name, salary from employee where salary = 8000000;
select emp_name, salary from employee where salary = '8000000';
select 25 + '25' from dual;

/*
 60년생의 직원명과 년생, 보너스 율을 출력하시오
 그때 보너스 값이 null인 경우에는 0% 이라고 출력 되게 만드시오
*/
select emp_name "직원명", substr(emp_no, 1, 2) "년생", nvl(bonus, 0)*100||'%' "보너스"
 from employee where to_number(substr(emp_no, 1, 2))between 60 and 69;

-------------------------------------------------------------------------------------
-- 그룹 함수
-- sum(숫자/컬럼) : 해당 컬럼/숫자 값의 총 합을 구해주는 함수
select sum(salary) from employee;
-- 부서코드가 D5인 사람들의 급여의 총합 조회
select sum(salary) from employee where dept_code = 'D5';
-- 직원명, 직원들의 급여 총합 출력
-- 그룹함수를 사용할때에는 단일한 결과값이 나온다는 점을 잊지 말기.
select emp_no, sum(salary) from employee;

-- avg(컬럼) : 해당 컬럼 값들의 평균을 구해주는 함수
select round(avg(salary),0) from employee;
-- 송종기 사원과 선동일 사원의 평균급여를 구해보기
select avg(salary) from employee 
 where emp_name in('송종기', '선동일');
-- 전 직원의 보너스 평균 -> 소수점 셋째자리수에서 반올림해서 조회(둘째자리수까지 표기)
-- 그룹함수 : 그룹함수를 사용할 때 만약 null 값이 있다면 -> null 값은 아예 제외 대상이 됨
select round(avg(nvl(bonus,0)),2) from employee;

-- count(컬럼) : 해당 컬럼 -> 데이터 개수를 반환해주는 함수
select count(emp_name) from employee;
select count(*) from employee;
-- 보너스를 지급해야하는 사원의 수 카운트
select count(*) from employee where bonus is not null;
-- 부서코드가 D5인 사원의 수 카운트
select count(*) from employee where dept_code = 'D5';

-- 사원들이 속해 있는 부서의 수 카운트
select count(distinct dept_code) from employee;

-- max/min(컬럼) : 해당 그룹에서 최대값/최소값을 반환해주는 함수
select max(salary), min(salary) from employee;
-- employee 테이블에서 가장 오래 일한 사원의 입사일/ 가장 적게 일한 사원의 입사일 조회
select min(hire_date), max(hire_date) from employee;

-----------------------------------------------------------------------------
-- 조건식
/*
  decode(대상표현식, 조건1, 결과1, 조건2, 결과2, default) 
  조건과 결과의 세트를 이어붙여주는거 가능
  -> 만약 default 값을 명시적으로 지정해주지 않으면 default = null
  : 대상 표현식/값이 조건1과 같다면 결과 1이 반환, 조건2와 같다면 결과2가 반환,
    이 모든 조건이 충족되지 않는다면 default값이 반환
 -> equal 비교만 가능

*/
select emp_name "사원명", decode(substr(emp_no, 8, 1),1,'남', 2,'여') "성별" from employee;
select emp_name "사원명", decode(substr(emp_no, 8, 1),1,'남','여') "성별" from employee;
select*from employee;
-- 문제1. 사번, 직원명과 퇴사여부를출력하는데 ent_yn(퇴사여부)가 'Y'과 같다면 퇴사일을 출력해라
-- + 만약 퇴사하지 않은 직원들이라면 '재직중'을 출력, 정렬순서는 퇴사여부, 사번 컬럼 오름차순
select emp_id "사번", emp_name "직원명", 
  decode(ent_yn, 'N', '재직중', to_char(ent_date, 'YY"년" MM"월" DD"일 퇴사"')) "퇴사여부"
  from employee order by 3, 1;

/*
  case -> 조건문
  case
     when 조건1 then 결과1
     when 조건2 then 결과2
     ...
     else 모든 조건이 충족되지 않으면 반환되는 결과
    end
    -> else(기본값)을 설정해주지 않으면 조건이 모두 맞지 않을때 null 값 반환
    -> case를 이용해서 결과값을 적어줄 때 모든 조건에 대해 동일한 자료형을 사용
*/
select
  case
    when '가나다' = '하하하' then 10
    when 1 > 5 then 5
    else 0
    end
from dual;

select emp_id "사번", emp_name "직원명", 
 case
   when ent_yn = 'Y' then to_char(ent_date, 'YY"년" MM"월" DD"일 퇴사"')
   -- when ent_yn = 'N' then '재직중'
    else '재직중'
   end "퇴사여부"
    from employee order by 3,1;
    
/*
 부서별 1분기 실적 조회
 D2, D6 부서는 상/ D9 부서는 하/ 나머지 부서는 중 /인턴은 해당없음 으로 출력
 부서코드 없는 = 인턴
 부서코드 중복x 정렬순서는 부서코드 오름차순
*/
select distinct nvl(dept_code, '인턴') "부서코드",
 case
  when dept_code in ('D2', 'D6') then '상'
  when dept_code = 'D9' then '하'
  when dept_code is null  then '해당없음'
  else '중'
  end "1분기 실적"
  from employee order by 1;


