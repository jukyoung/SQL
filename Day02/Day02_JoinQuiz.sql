SELECT * FROM USER_TABLES;
select* from employee;
select * from location;
select * from department;
select * from job;
select * from sal_grade;
select * from national;
--1. 주민번호가 1970년대 생이면서 성별이 여자이고, 성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.

select emp_name "사원명", emp_no "주민번호", dept_title "부서명", job_name "직급명"
 from employee join department on(dept_code = dept_id)
  join job using(job_code) where substr(emp_no,1,2) between 70 and 79
   and substr(emp_no,8,1) = '2';

--2. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
select emp_id "사번", emp_name "사원명", dept_title "부서명"
 from employee join department on(dept_code = dept_id)
  where emp_name like '%형%';
  
--3. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
select emp_name "사원명", job_name "직급명", dept_code "부서코드", dept_title "부서명"
 from employee join job using(job_code) join department on(dept_code = dept_id)
  where dept_title like '%해외영업%';
  
--4. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
select emp_name "사원명", bonus "보너스포인트", dept_title "부서명", local_name "근무지역명"
 from employee join department on(dept_code = dept_id)
  join location on (location_id = local_code)
   where bonus is not null;

--5. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
select emp_name "사원명", job_name "직급명", dept_title "부서명", local_name "근무지역명"
  from employee join job using(job_code)
   join department on(dept_code = dept_id)
    join location on (location_id = local_code)
     where dept_code = 'D2';

--6. 급여등급테이블의 최대급여(MIN_SAL)의 -20만원보다 많이 받는 직원들의 사원명, 직급명, 급여, 최대급여를 조회하시오.
-- (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 조인할 것)
select emp_name "사원명", job_name "직급명", salary "급여", min_sal "최대급여"
 from employee join job using(job_code)
  join sal_grade using(sal_level)
   where salary > (min_sal - 200000); -- 맞는지 모르겟음..

--7. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
select emp_name "사원명", dept_title "부서명", local_name "지역명", national_name "국가명"
 from employee join department on(dept_code = dept_id)
  join location on(location_id = local_code)
   join national using(national_code)
    where national_code in('KO','JP');

--8. 같은 부서에 근무하는 직원들의 사원명, 부서명, 동료이름을 조회하시오. (self join 사용)
select e1.emp_name "사원명", dept_title "부서명", e2.emp_name "동료이름"
 from employee e1 join department on(dept_code = dept_id)
  join employee e2 on(e1.dept_code = e2.dept_code)
  where e1.emp_name != e2.emp_name;

--9. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오. 단, join과 IN 사용할 것
select emp_name "사원명", job_name "직급명", salary "급여"
 from employee join job using(job_code)
  where bonus is null and job_name in ('차장', '사원');

--10. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
select decode(ent_yn, 'Y', '퇴사', 'N','재직') "재직여부", count(*) "인원수"
 from employee group by ent_yn;

--11. 각 사원들의 이름,나이(한국나이),부서명,직책명을 출력하여라.
-- 부서가 없으면 '부서없음' 출력 / 나이 내림차순 정렬 
select emp_name "이름", 
  extract(year from sysdate) - extract(year from to_date(substr(emp_no,1,2), 'RR')) +1 "나이", 
   nvl(dept_title, '부서없음') "부서명", job_name "직책명"
   from employee left outer join department on(dept_code = dept_id)
    join job using(job_code)
     order by 2 desc;