--문제 1. 부서별로 지불할 특별보너스를 출력하려 한다. 부서코드, 사원명, 보너스율, 특별보너스액을 아래 조건을 참고하여 출력.
   --D5 부서는 급여의 10% 
   --D2 부서는 급여의 20%
   --D9 부서는 급여의 30% 를 특별보너스로 지불할 예정
   --나머지 부서는 보너스 없음
   --아래의 결과값이 나오도록 Decode를 활용하여 쿼리문을 작성
select nvl(dept_code, '인턴') "부서코드", emp_name "사원명",
 decode(dept_code, 'D5', '10%', 'D2', '20%', 'D9','30%', '없음')"보너스율",
  decode(dept_code, 'D5', salary*0.1, 'D2', salary*0.2, 'D9', salary*0.3, 0)"특별보너스액"
 from employee order by 1;
 
-- 문제 2. employee 테이블에서 60년대생 중에서 초반생과, 후반생을 나누어 출력. .
  -- 64년생까지는 60대 초반, 65~69년생까지는 60대 후반 
  -- Case 를 활용 (아래는 실제 출력될 결과값)
select emp_name "사원명", 
 case
  when to_number(substr(emp_no, 1, 2)) between 60 and 64 then '60대 초반'
  when to_number(substr(emp_no, 1, 2)) between 65 and 69 then '60대 후반'
  end
  from employee where to_number(substr(emp_no, 1, 2)) between 60 and 69;
  
-- 문제3. employee 테이블에서 10년 미만 근무자는 Junior 로, 
-- 10년부터 19년차 근무자는 Intermediate, 20년 이상은 Senior 로 출력.
   -- 년차는 소수점을 버리고 계산, 년차를 기준으로 오름차순 정렬 
   -- Case 활용 (아래는 실제 출력될 결과값)
select emp_name "직원명", floor((sysdate-hire_date)/365)"년차",
 case
  when floor((sysdate-hire_date)/365) < 10 then 'Junior'
  when floor((sysdate-hire_date)/365) between 10 and 19 then 'Intermediate'
  when floor((sysdate-hire_date)/365) >= 20 then 'Senior'
  end
  from employee order by 2;
  
 