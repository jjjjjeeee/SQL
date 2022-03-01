use demo;
select * from emp;
desc emp;
show tables;

-- insert문: 레코드 추가
insert into emp values(7777,'hong','총무부',7369,now(),4000,100,40); -- 모든 필드의 정보가 있을 때
insert into emp(empno, ename) values(8888,'park'); -- 사원번호, 이름만 있을 때
insert into emp(ename, sal) values('choi',5000);  -- empno(null 허용안함)를 입력하지 않아서 에러발생
insert into emp(empno, ename, sal) values(9999,'choi',5000); 

-- 테이블 복사
create table emp2 as select empno, ename, job, sal from emp where job='MANAGER';
show tables;

select * from emp2;

-- emp2 테이블에 있는 레코드 중 급여가 3000불 이상인 사원을 emp2에 추가하라
insert into emp2(empno, ename, job, sal) select empno, ename, job, sal from emp where sal>=3000;

select * from emp2;
-- update문: 레코드 수정
update emp2 set job='인사부' where ename='choi';

-- ford사원의 job을 기획부, 급여를 1000불 인상하라
update emp2 set job='기획부' , sal=sal+1000 where ename='ford';

-- emp2 모든 사원의 급여를 10%인상한 급여로 수정하라
update emp2 set sal = sal+sal*0.1;

-- delete문: 레코드 삭제
-- 7777번 사원을 삭제
delete from emp2 where empno=7777;
select * from emp2;
delete from emp2 where job='인사부';

-- 현재 autocommit 상태확인
select @@autocommit; -- 1: 자동커밋 / 0: 자동커밋안됨
set autocommit = 0;
select * from emp order by ename;

-- 사원등록
insert into emp(empno, ename) values(1111,'lee');
select * from emp;
delete from emp where empno=8888;
delete from emp where ename='choi';

-- commit: update, insert, delete의 레코드가 변경된 경우 작업을 완료하는 기능
commit;

delete from emp where ename='lee';
rollback;

savepoint a;
insert into emp(empno,ename) values(2222,'aaaa');
insert into emp(empno,ename) values(3333,'bbbb');
savepoint b;
delete from emp where empno=1111;
delete from emp where job='salesman';
savepoint c;
update emp set comm=5000;
rollback to savepoint b; -- a 이후는 다 실행취소됨
select * from emp;
commit;