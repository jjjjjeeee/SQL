-- join
use demo;
show tables;

select * from emp;
select * from dept;
select * from salgrade;

-- 사원명(emp), 급여(emp), 부서코드(emp,dept), 부서명(dept)을 선택하라
select ename, sal, emp.deptno, dname
from emp, dept
where emp.deptno=dept.deptno;

select ename, sal, e.deptno, dname
from emp e, dept d
where e.deptno=d.deptno;

-- equi join(동등조인)
select ename, sal, emp.deptno, dname
from emp join dept
on emp.deptno=dept.deptno;-- 조인기준이 되는 필드명

select e.ename, e.sal, e.deptno, d.dname
from emp e join dept d
on e.deptno=d.deptno;

-- 사원번호, 담당업무, 급여, 부서명, 부서위치를 선택하라
-- 30번 부서인 사원은 제외하고 급여는 10%인상한 급여와 지급액(급여+보너스)를 출력하라
select e.empno, e.job, e.sal, e.sal*1.1 '인상급여', e.sal+ifnull(e.comm,0) '지급액',d.dname, d.loc
from emp e join dept d
on e.deptno=d.deptno
where e.deptno != 30 order by sal desc;

select a.empno, a.지급액 from 
(select e.empno, e.job, e.sal, e.sal*1.1 '인상급여', e.sal+ifnull(e.comm,0) '지급액',d.dname, d.loc
from emp e join dept d
on e.deptno=d.deptno
where e.deptno != 30) a;

-- Manager업무를 하는 사람의 평균급여보다 많이 받는 사원을 선택하는데
-- 사원번호, 사원명, 담당업무, 급여, 부서코드, 부서명을 오름차순으로 정렬하여 선택하라
select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname
from emp e join dept d
on e.deptno=d.deptno
and sal>(select avg(sal) from emp where job='manager')
order by ename asc;

-- salesman의 사원번화, 이름, 급여, 부서명, 근무지를 출력하여라
select e.empno, e.ename, e.sal, d.dname, d.loc
from emp e join dept d
on e.deptno=d.deptno
where job='salesman'; -- and job='salesman'을 써도 결과는 같음

-- non equi join (비동등조인)
select e.empno, e.ename, e.sal, s.grade, s.losal, s.hisal
from emp e, salgrade s
where e.sal between s.losal and s.hisal;

select e.empno, e.ename, e.sal, s.grade, s.losal, s.hisal
from emp e join salgrade s
on e.sal between s.losal and s.hisal;

-- emp테이블에서 사원명, 급여, 호봉을 선택하되 
-- 담당업무가 manager이거나 salesman인 사원 중 사원명에 'a'가 포함된 사원을 선택하라
select e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between losal and hisal
where e.job in('manager','salesman') and e.ename like '%a%';

select e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between losal and hisal
and e.job in('manager','salesman') and e.ename like '%a%';

-- 사원명, 급여, 부서코드, 부서명, 호봉을 선택하라 (테이블 3개 조인)
select e.ename, e.sal, e.deptno, d.dname, s.grade
from emp e join dept d
on e.deptno=d.deptno
join salgrade s
on e.sal between s.losal and s.hisal;

-- 사원번호, 사원명, 입사일, 급여, 부서명, 호봉, 호봉의 최고급여를 선택하라
-- 단, 급여가 2500불 이상인 사원을 급여순으로 내림차순하여 선택하라
select e.empno, e.ename, e.hiredate, e.sal, d.deptno, s.grade, s.losal, s.hisal
from emp e join dept d
on e.deptno=d.deptno
join salgrade s
on e.sal between losal and hisal
where e.sal>=2500 order by e.sal desc;

-- self 조인: 같은 테이블로 조인하기
-- 사원명, 담당업무, 급여, 매니저명, 매니저급여, 매니저업무
select e1.ename, e1.job, e1.sal, e2.ename, e2.sal, e2.job
from emp e1 join emp e2
on e1.mgr=e2.empno;

-- 사원명, 부서명, 급여, 매니저명, 매니저부서명, 매니저급여를 선택하라
select e1.ename '사원명', d1.dname '부서명', e1.sal '급여', e2.ename '매니저명', d2.dname '매니저부서명', e2.sal '매니저급여'   
from emp e1 join dept d1 on e1.deptno=d1.deptno
join emp e2 on e1.mgr=e2.empno
join dept d2 on e2.deptno=d2.deptno;

select concat('a','b','c','d','e');

-- emp테이블에서 '누구의 관리자는 누구이다'를 출력하시오
select concat(e1.ename, '\t의 관리자는\t', e2.ename, '이다') '결과'
from emp e1 join emp e2 on e1.mgr=e2.empno;

-- outer join
-- null 데이터가 발생하는 테이블 오른쪽 -> left outer join
-- null 데이터가 발생하는 테이블 왼쪽 -> right outer join 
select ename, e.deptno, d.dname, d.deptno
from emp e right outer join dept d on e.deptno=d.deptno;

select distinct e.deptno 'E', d.deptno 'D'
from dept d join emp e on d.deptno=e.deptno;

-- 문제 1. emp테이블에서 모든 사원에 대한 이름, 부서번호, 부서명을 출력하는 문장을 작성하세요. (부서번호순으로 오름차순 정렬하라.)
select e.ename, e.deptno, d.dname
from emp e join dept d on e.DEPTNO=d.DEPTNO 
order by d.dname;

-- 문제 2. emp테이블에서 NEW YORK에서 근무하고 있는 사원에 대하여 이름, 업무, 급여, 부서명을 출력하는 SELECT문을 작성하세요.
select e.ename, e.job, e.sal, d.dname, d.loc
from emp e join dept d on e.deptno=d.deptno
where d.loc='new york';

-- 문제 3. EMP테이블에서 보너스를 받는 사원에 대하여 이름, 부서명, 위치를 출력하는 SELECT문을 작성하세요.
select e.ename, d.dname, d.loc
from emp e join dept d on e.deptno=d.deptno
where comm is not null and comm!=0; -- and ifnull(e.comm,0)>0;

-- 문제 4. EMP테이블에서 이름 중 L자가 있는 사원에 대해 이름, 업무, 부서명, 위치를 출력하는 문장을 작성하세요.
select e.ename, e.job, d.dname, d.loc
from emp e join dept d on e.deptno=d.deptno
where ename like '%L%';

select a.ename, a.job, d.dname, d.loc
from (select ename, job, deptno from emp where ename like '%L%') a join dept d
on a.deptno=d.deptno;

-- 아래 결과를 출력하는 문장을 작성하세요
-- 관리자가 없는 king을 포함하여 모든 사원을 출력
-- --------------------------------------------
-- employee		emp#	manager		mgr#
-- king     	7839
-- blake    	7698	king		7839

select e.ename 'employee', e.empno 'emp#', e2.ename 'manager', e2.empno 'mgr#'
from emp e left outer join emp e2
on e.mgr=e2.empno;

-- natural join: 같은 필드명의 데이터를 알아서 조인해준다
select ename, sal, dname from emp natural join dept;
select ename, sal, dname ,e.deptno from emp e natural join dept d;

select ename, sal, dname, e.deptno from emp e join dept using(deptno);

show databases;
use mydb;
show tables;
desc member;
insert into member(username, tel, email, birth, gender) values('hong','010-1234-5678','hong@naver.com','2000-10-10','M');
select * from member;
