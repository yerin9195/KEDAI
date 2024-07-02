-- 오라클 계정 생성을 위해서는 SYS 또는 SYSTEM 으로 연결하여 작업을 해야 합니다. [SYS 시작] --
show user;
-- USER이(가) "SYS"입니다.

-- 오라클 계정 생성 시 계정명 앞에 c## 붙이지 않고 생성하도록 하겠습니다.
alter session set "_ORACLE_SCRIPT"=true;
-- Session이(가) 변경되었습니다.

-- 오라클 계정명은 final_orauser5 이고 암호는 gclass 인 사용자 계정을 생성합니다.
create user final_orauser5 identified by gclass default tablespace users; 
-- User FINAL_ORAUSER5이(가) 생성되었습니다.

-- 위에서 생성되어진 FINAL_ORAUSER5 이라는 오라클 일반사용자 계정에게 오라클 서버에 접속이 되어지고,
-- 테이블 생성 등등을 할 수 있도록 여러가지 권한을 부여해주겠습니다.
grant connect, resource, create view, unlimited tablespace to final_orauser5;
-- Grant을(를) 성공했습니다.

-- 접속 - 새접속 - Name: remote_final_orauser5 사용자이름: final_orauser5 비밀번호: gclass 비밀번호 저장 - 테스트 - 저장 - 취소

-----------------------------------------------------------------------

show user;
-- USER이(가) "FINAL_ORAUSER5"입니다.

-- 테이블 주석문
comment on table tbl_jikwon 
is '우리회사 사원들의 정보가 들어있는 테이블';

-- 테이블 주석문 확인
select *
from user_tab_comments
where table_name = 'tbl_jikwon'; 

-- 컬럼명 주석문
comment on column tbl_jikwon.saname is '사원명'; 
comment on column tbl_jikwon.salary is '기본급여 기본값은 100'; 
comment on column tbl_jikwon.comm is '수당 null 허락함'; 

-- 컬럼명 주석문 확인
select column_name, comments
from user_col_comments
where table_name = 'tbl_jikwon';

-----------------------------------------------------------------------

-- 부서 테이블
create table tbl_dept
(dept_code  NUMBER(4)     not null
,dept_name  VARCHAR2(30)  not null
,constraint PK_tbl_dept_dept_code primary key(dept_code)
);
-- Table TBL_DEPT이(가) 생성되었습니다.

comment on table tbl_dept 
is '부서 정보가 들어있는 테이블';
-- Comment이(가) 생성되었습니다.

comment on column tbl_dept.dept_code is '부서코드'; 
comment on column tbl_dept.dept_name is '부서명'; 
-- Comment이(가) 생성되었습니다.

select *
from user_tab_comments
where table_name = 'TBL_DEPT';

select column_name, comments
from user_col_comments
where table_name = 'TBL_DEPT';

-----------------------------------------------------------------------

-- 직급 테이블
create table tbl_job
(job_code  NUMBER(4)     not null
,job_name  VARCHAR2(30)  not null
,constraint PK_tbl_job_job_code primary key(job_code)
);
-- Table TBL_JOB이(가) 생성되었습니다.

comment on table tbl_job 
is '직급 정보가 들어있는 테이블';
-- Comment이(가) 생성되었습니다.

comment on column tbl_job.job_code is '직급코드'; 
comment on column tbl_job.job_name is '직급명'; 
-- Comment이(가) 생성되었습니다.

select *
from user_tab_comments
where table_name = 'TBL_JOB';

select column_name, comments
from user_col_comments
where table_name = 'TBL_JOB';

-----------------------------------------------------------------------

-- 사원 테이블
create table tbl_employees
(empid              VARCHAR2(30)   not null
,pwd                VARCHAR2(200)  not null
,name               VARCHAR2(30)   not null
,nickname           VARCHAR2(30)
,jubun              VARCHAR2(13)   not null
,email              VARCHAR2(200)  not null
,mobile             VARCHAR2(200)  not null
,postcode           VARCHAR2(5)    not null
,address            VARCHAR2(200)  not null
,detailaddress      VARCHAR2(200)
,extraaddress       VARCHAR2(200)
,imgfilename        VARCHAR2(100)
,hire_date          DATE           not null
,salary             NUMBER         not null
,commission_pct     NUMBER(2,2)
,point              NUMBER DEFAULT 0      not null
,fk_dept_code       NUMBER(4)
,fk_job_code        NUMBER(4)         
,dept_tel           VARCHAR2(30)
,lastpwdchangedate  DATE DEFAULT SYSDATE  not null
,status             NUMBER(1) DEFAULT 1   not null 
,sign_img           VARCHAR2(100)
,constraint PK_tbl_employees_empid        primary key(empid)
,constraint FK_tbl_employees_fk_dept_code foreign key(fk_dept_code) references tbl_dept(dept_code)
,constraint FK_tbl_employees_fk_job_code  foreign key(fk_job_code)  references tbl_job(job_code)
,constraint UQ_tbl_employees_email        unique(email)
,constraint CK_tbl_employees_status       check(status in(0,1))
);
-- Table TBL_EMPLOYEES이(가) 생성되었습니다.

comment on table tbl_employees 
is '사원 정보가 들어있는 테이블';
-- Comment이(가) 생성되었습니다.

comment on column tbl_employees.empid is '사원아이디'; 
comment on column tbl_employees.pwd is '비밀번호'; 
comment on column tbl_employees.name is '이름'; 
comment on column tbl_employees.nickname is '닉네임'; 
comment on column tbl_employees.jubun is '주민번호'; 
comment on column tbl_employees.email is '이메일'; 
comment on column tbl_employees.mobile is '연락처'; 
comment on column tbl_employees.postcode is '우편번호'; 
comment on column tbl_employees.address is '주소'; 
comment on column tbl_employees.detailaddress is '상세주소'; 
comment on column tbl_employees.extraaddress is '참고항목'; 
comment on column tbl_employees.imgfilename is '이미지파일명'; 
comment on column tbl_employees.hire_date is '입사일자'; 
comment on column tbl_employees.salary is '기본급여'; 
comment on column tbl_employees.commission_pct is '수당 퍼센티지'; 
comment on column tbl_employees.point is '포인트'; 
comment on column tbl_employees.fk_dept_code is '부서코드'; 
comment on column tbl_employees.fk_job_code is '직급코드'; 
comment on column tbl_employees.dept_tel is '내선번호'; 
comment on column tbl_employees.lastpwdchangedate is '마지막암호변경날짜시각'; 
comment on column tbl_employees.status is '퇴사유무'; 
comment on column tbl_employees.sign_img is '결재서명이미지'; 
-- Comment이(가) 생성되었습니다.

select *
from user_tab_comments
where table_name = 'TBL_EMPLOYEES';

select column_name, comments
from user_col_comments
where table_name = 'TBL_EMPLOYEES';

-----------------------------------------------------------------------

create table tbl_loginhistory
(history_seq  NUMBER                not null
,fk_empid     VARCHAR2(30)          not null
,logindate    DATE DEFAULT sysdate  not null
,clientip     VARCHAR2(20)          not null
,constraint PK_tbl_loginhistory primary key(history_seq)
,constraint FK_tbl_loginhistory_fk_empid foreign key(fk_empid) references tbl_employees(empid)
);
-- Table TBL_LOGINHISTORY이(가) 생성되었습니다.

create sequence loginhistory_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence LOGINHISTORY_SEQ이(가) 생성되었습니다.

comment on table tbl_loginhistory 
is '로그인기록 정보가 들어있는 테이블';
-- Comment이(가) 생성되었습니다.

comment on column tbl_loginhistory.history_seq is '기록번호'; 
comment on column tbl_loginhistory.fk_empid is '사원아이디'; 
comment on column tbl_loginhistory.logindate is '로그인날짜시각'; 
comment on column tbl_loginhistory.clientip is '접속IP주소'; 
-- Comment이(가) 생성되었습니다.

select *
from user_tab_comments
where table_name = 'TBL_LOGINHISTORY';

select column_name, comments
from user_col_comments
where table_name = 'TBL_LOGINHISTORY';

-----------------------------------------------------------------------

-- 로그인 처리하기
desc tbl_employees;
desc tbl_loginhistory;

SELECT empid, name, nickname, jubun, email, mobile, 
       postcode, address, detailaddress, extraaddress,
       imgfilename, hire_date, salary, commission_pct, point,
       fk_dept_code, fk_job_code, dept_tel, sign_img, annual_leave, pwdchangegap, 
       NVL(lastlogingap, trunc(months_between(sysdate, hire_date))) AS lastlogingap
FROM 
( 
    select empid, name, nickname, jubun, email, mobile, 
           postcode, address, detailaddress, extraaddress,
           imgfilename, hire_date, salary, commission_pct, point,
           fk_dept_code, fk_job_code, dept_tel, sign_img, annual_leave,
           trunc(months_between(sysdate, lastpwdchangedate)) AS pwdchangegap 
    from tbl_employees 
    where status = 1 and empid = '2010001-001' and pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
) E 
CROSS JOIN 
( 
    select trunc(months_between(sysdate, max(logindate))) AS lastlogingap 
    from tbl_loginhistory 
    where fk_empid = '2010001-001'
) H

insert into tbl_loginhistory(history_seq, fk_empid, logindate, clientip)
values(loginhistory_seq.nextval, #{empid}, default, #{clientip})

-----------------------------------------------------------------------

-- 아이디 찾기
select empid
from tbl_employees
where status = 1 and name = ? and email = ?

-- 아이디 중복확인하기
select empid
from tbl_employees
where empid = '2024100-001'
      
select *
from tbl_employees
where fk_dept_code = '200'
order by fk_job_code asc;   

delete from tbl_employees
where empid = '2010001-001'

commit;
-- 커밋 완료.

select dept_code, dept_name
from tbl_dept;
/*
    100	인사부
    200	영업지원부
    300	회계부
    400	상품개발부
    500	마케팅부
    600	해외사업부
    700	온라인사업부
*/

select job_code, job_name
from tbl_job;
/*
    1	부장
    2	과장
    3	차장
    4	대리
    5	주임
    6	사원
*/

update tbl_employees set fk_job_code = '3'
where empid = '2014100-003'


