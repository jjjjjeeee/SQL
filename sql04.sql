use demo;
select * from emp;
show databases;

create database mydb;
use mydb;

-- 테이블 생성하기
create table member(
-- 필드명  데이터타입  제약조건  기본값...
num int auto_increment primary key,
username varchar(30) not null,
tel varchar(15) not null,
email varchar(50),
birth date,
gender char(1) default 'M',
writedate datetime default now()
);
show tables; 
desc member;

-- 테이블 지우기: drop table member;

-- 1. 회원테이블 만들기
create table usertbl(
-- 필드명  데이터타입  제약조건  기본값...
userid varchar(20) primary key,
username varchar(30) not null,
birth year not null,
local varchar(50) not null,
mobile varchar(4),
mobile2 varchar(10),
height int(3),
writedate datetime
);

-- 2. 제품테이블 만들기
create table prodtbl(
-- 필드명  데이터타입  제약조건  기본값...
productname varchar(100) primary key,
price int default 0,
opendate datetime,
company varchar(50),
stock int default 0
);

-- 3. 구매테이블 만들기
create table buytbl(
-- 필드명  데이터타입  제약조건  기본값...
buyno integer auto_increment,
userid varchar(30) not null,
productname varchar(50) not null,
groupname varchar(40) not null,
price int default 0,
amount int default 0,
buydate datetime default now(),
primary key(buyno)
);

desc buytbl;
desc prodtbl;
desc usertbl;