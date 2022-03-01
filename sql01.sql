-- 데이터베이스 목록
show databases;
-- 데이터베이스 선택
use employees;
-- 테이블 목록
show tables;
-- 레코드 선택
select * from employees;

-- 숫자함수
select abs(-100);
select emp_no-400000 '절대치' from employees;
select ceil(10.1), ceil(-10.1), floor(10.9),floor(-10.9);
select round(192.123,1), round(192.123,-1);
select mod(emp_no, 4),
		emp_no %4,
        emp_no mod 4 from employees;
-- 난수: 0~1사이의 값 중에 1개를 무작위 생성해줌
select rand() , ceil(rand()*100), ceil(rand()*11)+50; -- 0~99사이의 값을 1개가 생성

-- 문자 내장 함수
select ascii('A'), char(65);

-- 문자수 => select char_length('가나다'), byte크기 => length('가나다');

-- 문자열 연결 'concat'
select concat('이','정','은'),concat_ws('☆','이','정','은');
select concat(first_name, last_name), concat_ws(' ',first_name, last_name) from employees;

-- 위치와 관련된 함수
select elt(2,'a','b','c'), field('b','a','b','c'), find_in_set('b','a,b,c'), instr('abcd','b'), locate('b','abcd');

-- insert (전체, 2번째부터, 3개를, 여기 쓴걸로 대체)
select insert('가나다라마',2,3,'###');

select reverse('가나다라마');

select left(first_name, 2), right(first_name,2), first_name from employees;

select lcase(first_name), ucase(first_name), first_name from employees;

select lpad(first_name,10,'*'), rpad(first_name,10,'@'), first_name from employees;

-- substr(전체, 4번째부터, 2개)
select substr('이정은최고',4,2);
select substring(first_name,2,3), first_name from employees;
select substring_index('csl6901.naver.com','.',2),
		substring_index('csl6901.naver.com','.',-2);

-- 문제: 이름의 길자길이의 50%만큼 출력하고 나머지는 '*'로 표시하라
select first_name, char_length(first_name),
rpad(substring(first_name,1,char_length(first_name)/2),char_length(first_name),'*') '정답'from employees;

select first_name, replace(first_name, 'A', '에이') from employees;
select first_name, replace(first_name, 'a', '에이') from employees;

-- 문제: 이메일을 이용하여 아이디와 도메인을 분리하여라
select substring_index('csl6901@naver.com','@',1);

-- 날짜 내장함수
select curdate(), curtime(), now(), sysdate();
select date(now()), time(sysdate());
select year(now()), year(sysdate()), year(curdate());

select adddate(now(), interval(31)day); -- 31일 후
select subdate(now(), interval 31 day); -- 31일 전

select abs(datediff('2022-01-05','2022-01-15'));
select dayofweek(now()), dayofyear(now());
select last_day(now()), time_to_sec(now());

select cast('2022~05~20' as date);
select cast('2022,05,20' as date);
select cast('2022-05.20' as date);
select cast(now() as date);

select date_format(now(),'%Y-%m-%d %H:%i:%S %p %W %a');
show tables;
select * from salaries;