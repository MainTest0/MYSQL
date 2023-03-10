

SHOW TABLES;

-- LIMIT 가지고올 때 제한 5개 들고와라
SELECT * FROM salaries
LIMIT 5;

-- 10번째부터 5개 들고와라
SELECT * FROM salaries
LIMIT 10, 5;

-- 몇개있는지 확인하고싶을 때
-- 집계함수 중에 COUNT
SELECT COUNT(emp_no) FROM salaries;

-- 몇개 있던지 간에 그룹화 시켜줌
SELECT *
FROM salaries
GROUP BY emp_no;

-- GROUP BY에 조건절을 사용할 때는 having 절 사용
SELECT *
FROM salaries
GROUP BY emp_no
HAVING emp_no = 10001;

-- 2단계
SELECT *, COUNT(salary)
FROM salaries
GROUP BY emp_no;

-- 사원의 월급중 최고 연봉이 궁금하다.
-- 사원의 월급중 최저 연봉이 궁금하다.
-- 사원의 월급 받은 횟수가 궁금하다.
SELECT *, COUNT(salary) AS COUNT
		, MAX(salary) AS max
        , MIN(salary) AS min
FROM salaries
GROUP BY emp_no;

-- 받은 급액의 합계가 궁금하다.
-- 평균 급여가 궁금하다.
-- 평균 급여 소수점 2번째까지 반올림하고 싶다.(ROUND)
SELECT *, COUNT(salary) AS COUNT
		, MAX(salary) AS max
        , MIN(salary) AS min
        , SUM(salary) AS sum
        -- , AVG(salary) AS avg
        , ROUND(AVG(salary), 2) AS avg
FROM salaries
GROUP BY emp_no;

-- 2문제 생성 직접 쿼리 출력
SHOW TABLES;
-- titles : 직급
-- dept_emp : 사원번호의 소속 부서 번호
-- dept_manager : 부서번호의 매니저 사원 번호
SELECT * FROM dept_manager;
SELECT * FROM salaries;

-- 문제=============================================
-- d003부서 소속 매니저 중 가장 높은 연봉을 출력하고
-- 월급의 평균값 출력
SELECT *, MAX(salary) AS max
		, FLOOR(AVG(salary)) AS avg
FROM dept_manager AS m
INNER JOIN salaries AS s
ON m.emp_no = s.emp_no
GROUP BY m.dept_no
HAVING dept_no = 'd003';

-- 1. emp_no로 그룹을 나누고 title table에서 
-- title과 salaries table에서 salary를 출력하라. 
-- (join 사용)
SELECT *
FROM titles;

SELECT *
FROM titles AS t
JOIN salaries AS s
ON t.emp_no = s.emp_no
GROUP BY t.emp_no;
-- 2. 위에서 출력한값에서 연봉이 65000원 이상인 
-- 사람만 출력하라. (몇명인지도 출력)
SELECT *, COUNT(t.emp_no) AS '인원'
FROM titles AS t
JOIN salaries AS s
ON t.emp_no = s.emp_no
GROUP BY t.emp_no
HAVING salary >= 65000;
-- 3. Engineer(시니어, 어시스턴트, 일반 모두 포함)이라는 
-- 직책을 가진 사원들의 최고 연봉을 출력해라
select * from titles;

SELECT t.emp_no, title, salary, MAX(salary) AS max
FROM titles AS t
JOIN salaries AS s
ON t.emp_no = s.emp_no
GROUP BY t.emp_no
HAVING title LIKE '%Engineer';
-- 4. 각 부서에는 몇 명이 있는지 출력해보자
SELECT * FROM dept_emp;
SELECT dept_no, COUNT(dept_no)
FROM dept_emp
GROUP BY dept_no;
-- 5. 각 직급 별로 몇 명이 있는지 출력해보자
SELECT * FROM titles;
SELECT title, COUNT(title)
FROM titles
GROUP BY title;
-- 6. employees 테이블과 salaries 테이블을 활용해서 
-- 남자 직원의 최고 연봉을 구하시오.
SELECT * FROM employees;
SELECT * FROM salaries;

SELECT e.emp_no, gender, salary, MAX(salary)
FROM employees AS e
JOIN salaries AS s
ON e.emp_no = s.emp_no
GROUP BY e.emp_no
HAVING gender = 'M';


-- 문제=============================================

-- 1단계
-- 남자 성비로 그룹화 시키고싶다.
SELECT *
FROM employees
GROUP BY gender;

-- 2단계
SELECT *, COUNT(gender)
FROM employees
GROUP BY gender;

-- 같은날 입사하면 동기
-- 동기 몇명인지 출력하고싶다.
SELECT *, COUNT(hire_date)
FROM employees
GROUP BY hire_date;

-- GROUP BY에 조건 2개 걸기
-- 83명 중에 남자 따로 여자 따로 그룹화하고 싶다.
SELECT *, COUNT(hire_date)
FROM employees
GROUP BY hire_date, gender;


SELECT * FROM employees;
-- employees와 dept_emp의 관계는
-- employees (1) : dept_emp(N)
SELECT * FROM departments;	-- 중복이 없는걸보니까 PK다.
-- 부서번호가 1개만 존재
-- dept_no와 departments의 관계는
-- dept_emp (N) : department (1)

SELECT * FROM dept_emp;
-- employees : departments -> N : M 관계차수를 가진다.
-- ->중간테이블 dept_emp를 만들어서 N : M를 표현하고 있다.

-- 10001번의 사람이 어떤 부서인지 확인하고싶다.
-- 1단계 JOIN 해보기
SELECT e.emp_no, e.first_name, d.dept_no
FROM employees AS e
LEFT JOIN dept_emp AS d
ON e.emp_no = d.emp_no;


-- 3단계
SELECT e.emp_no, e.first_name, d.dept_no, dp.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS d
ON e.emp_no = d.emp_no
LEFT JOIN departments AS dp
ON d.dept_no = dp.dept_no;

-- 4단계 그룹화 시키기
-- d001만 출력하고싶다.
SELECT e.emp_no, e.first_name, d.dept_no, dp.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS d
ON e.emp_no = d.emp_no
LEFT JOIN departments AS dp
ON d.dept_no = dp.dept_no
GROUP BY dept_no
HAVING e.emp_no = '10001';
























