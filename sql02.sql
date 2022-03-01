use demo;
show tables;

select * from emp;
select * from dept;
select * from salgrade;

desc emp;

-- 사원수
select count(empno) from emp;
select count(comm) from emp; -- null(값이 생성된 적 없음)값 제외한 수 나옴
select count(mgr) from emp;
select max(sal), min(sal), avg(sal), sum(sal) from emp;

-- 부서별 사원수, 급여합계, 급여평균을 구하라
select deptno, count(ename), sum(sal), avg(sal) from emp group by deptno order by deptno;

-- 업무별 통계
select job, count(empno), sum(sal), max(sal), avg(sal), min(sal) from emp group by job;

-- distinct: 중복데이터 제거
select distinct job from emp;

-- 업무별 급여의 합계, 평균을 구하여 평균이 3000불 이상인 업무를 출력하라
select job, sum(sal), avg(sal) from emp 
group by job 
having avg(sal)>=3000;

-- 업무별 급여 평균과 보너스의 평균을 구하라
select job, sum(sal) '급여합계', avg(sal) '급여평균', avg(comm) '보너스평균' from emp group by job;

-- 합계가 있는건 null 데이터를 제외하고 구해야 함
select ename, sal, comm, ifnull(comm,0)+1000 from emp;
select * from emp where comm is null;
select sum(sal), avg(sal), sum(comm), avg(ifnull(comm,0)) from emp;

-- 보너스를 받는 사원의 사원수, 보너스 합, 보너스 평균을 구하라
select count(empno), sum(comm), avg(comm) from emp where comm>0;

-- 전체 원급이 5000을 초과하는 각 업무에 대하여 업무와 원급여 합계를 출력하여라
-- 단 판매원은 제외하고 월 급여 합계로 내림차순 정렬하여라
select job, sum(sal) from emp
where job != 'salesman'
group by job
having sum(sal)>=5000
order by sum(sal) desc;

show tables;
