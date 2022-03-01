-- 데이블관리
use demo;
show tables;
desc emp2;
select * from emp2;

-- 테이블에 필드를 추가
-- emp2 테이블에 연락처를 저장할 필드 추가
alter table emp2 add tel varchar(15);
desc emp2;

-- 필드의 크기를 수정
-- job을 varchar(20)으로 변경
alter table emp2 modify job varchar(20);
desc emp2;

-- 컬럼명 변경하기
-- tel => mobile로 컬럼명 변경
alter table emp2 change tel mobile varchar(20);

-- 필드 삭제하기
-- job 삭제 
alter table emp2 drop column job;

-- emp2테이블 지우기
drop table emp2;
show tables;

select * from emp;

delete from emp where empno in(1111,2222,3333);
commit;

-- 제약조건 확인하기
select * from information_schema.table_constraints where table_name in('emp','dept','salgrade');

-- unique: 유일한 값일 때
-- ename을 unique 제약조건 설정
alter table emp add constraint emp_up_ename unique(ename);
-- ename이 unique라서 smith가 insert되지 않음  // insert into emp(empno, ename) values(8888,'smith');
insert into emp(empno, ename) values(8888,'smith2');

-- 제약조건 삭제
alter table emp drop constraint emp_up_ename;
select * from information_schema.table_constraints where table_name in('emp','dept','salgrade'); -- 제약조건 지워졌나 확인

-- check: 특정 데이터만 등록되도록 제약 조건을 설정
alter table emp add constraint emp_ch_sal check(sal>500 and sal<8000);
-- sal칼럼에 제약조건을 설정해서 update되지 않음 // update emp set sal=8500 where ename='smith';
update emp set sal=7000 where ename='smith';

alter table emp add constraint emp_ck_comm check(comm in(100,200,300,400));
update emp set comm=100;
select * from emp;

update emp set comm=200 where sal>3000;
-- comm이 100,200,300,400외에는 허용하지 않음 // update emp set comm=500 where sal<2000;
update emp set comm=300 where sal<2000;

-- primary key 설정
-- dept테이블 deptno필드를 
alter table dept add constraint dept_pk_deptno primary key(deptno);

-- 이미 있는 번호라 입력불가 // insert into dept values(40,'총무부','서울');
insert into dept values(50,'총무부','서울');
select * from dept;

-- 외래키 설정
-- emp 테이블의 deptno는 dept테이블의 deptno를 참조 (참조하고 있는 테이블 기준으로 쿼리문작성)
alter table emp add constraint emp_fk_deptno foreign key(deptno) references dept(deptno);
select * from information_schema.table_constraints where table_name in('emp','dept','salgrade');
select * from dept;

-- emp에서 martin이 50번 부서로 이동
update emp set deptno=50 where ename='martin';
select * from emp;
-- deptno에 35번이 없기 때문에 에러발생 // update emp set deptno=35 where enmae='jones';

delete from dept where deptno=20;

alter table emp drop constraint emp_fk_deptno;

alter table emp add constraint emp_fk_deptno foreign key (deptno)
references dept(deptno) on delete cascade;

delete from dept where deptno=20;
select * from dept;
select * from emp;

-- 서브쿼리
select avg(sal) from emp;
select * from emp where sal>2016.66667;
-- 단일행 서브쿼리
select * from emp where sal>(select avg(sal) from emp);
