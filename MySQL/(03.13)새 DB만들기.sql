
-- blog
-- 서버 프로그램 구현 - MYSQL <-- 서버와 연동
-- 로그인, 회원가입 정리

-- blog라는 서비스를 만들기 위해서 DB만들기
CREATE DATABASE myblog;
USE myblog;

-- 사용자 생성하기
-- (사용자를 만들어서 특정 권한을 줄 수 있음)
-- 8버전부터 비밀번호가 너무 짧으면 접근이 안됨
CREATE USER 'bloguser'@'%' IDENTIFIED BY '1q2w3e4r5t';

-- 사용자 기본 권한 조회
-- DB를 선택해야함
USE mysql;	-- 기본적으로 만들어주는 DB
SELECT USER, HOST FROM USER;
-- host가 localhost로 되어있으면 우리만 접근 가능
-- %는 어디에서든 접근 가능한 권한 (IP주소 개념)

-- bloguser만 디테일하게 살펴보기
SELECT * FROM user WHERE user = 'bloguser';
-- 계정 생성, 접근할 수 있는 것만 생성해놓은 상태

-- 권한 주는 명령어 GRANT
-- 권한을 매칭하는 것
-- * : 모든 권한에 접근가능
GRANT ALL PRIVILEGES ON *.* TO 'bloguser'@'%';
-- 방금 권한 변경을 즉시 적용하려면 1가지 명령어를 더 해줘야함
FLUSH PRIVILEGES;	-- 지금 설정한 권한을 바로 적용

SELECT CONCAT('문자열', '3개', '합침');

-- 이 사용자에 어떤 권한을 쥐어줄지 설정 가능
-- 접근 권한에 대해서도 CRUD를 줄 수 있음(부분적 권한부여 가능)

SELECT * FROM dept_emp;
SELECT * FROM salaries;

-- 평균 급여가 50,000 이상인 직원만 출력
-- 평균 급여는 소수점 1번째 자리까지 구하기
SELECT *, ROUND(AVG(salary), 1) AS avg
FROM dept_emp AS d
INNER JOIN salaries AS s
ON d.emp_no = s.emp_no
GROUP BY dept_no
HAVING avg >= 50000;

-- 3. Engineer(시니어, 어시스턴트, 일반 모두 포함)이라는 
-- 직책을 가진 사원들의 최고 연봉을 출력해라
select * from titles;
select * from salaries;

SELECT *, MAX(s.salary)
FROM titles AS t
INNER JOIN salaries AS s
ON t.emp_no = s.emp_no
GROUP BY t.emp_no
HAVING title LIKE '%Engineer'






















