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

-- 컬럼 추가하기
alter table tbl_employees
add orgimgfilename VARCHAR2(100);
-- Table TBL_EMPLOYEES이(가) 변경되었습니다.

comment on column tbl_employees.imgfilename is 'WAS(톰캣)에저장될이미지파일명'; 
comment on column tbl_employees.orgimgfilename is '실제이미지파일명'; 
-- Comment이(가) 생성되었습니다.

-----------------------------------------------------------------------

-- 로그인 기록 테이블
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

SELECT empid, name, nickname, jubun, gender, age, email, mobile
     , postcode, address, detailaddress, extraaddress
     , imgfilename, orgimgfilename, hire_date, salary, commission_pct, point
     , fk_dept_code, dept_code, dept_name, fk_job_code, job_code, job_name, dept_tel, sign_img, annual_leave, pwdchangegap
     , NVL(lastlogingap, trunc(months_between(sysdate, hire_date))) AS lastlogingap
FROM 
(
    select empid, name, nickname, jubun
         , func_gender(jubun) AS gender
         , func_age(jubun) AS age
         , email, mobile, postcode, address, detailaddress, extraaddress
         , imgfilename, orgimgfilename, to_char(hire_date, 'yyyy-mm-dd') AS hire_date, salary, commission_pct, point
         , fk_dept_code, dept_code, nvl(D.dept_name, ' ') AS dept_name
         , fk_job_code, job_code, nvl(J.job_name, ' ') AS job_name
         , dept_tel, sign_img, annual_leave
         , trunc(months_between(sysdate, lastpwdchangedate)) AS pwdchangegap
    from tbl_employees E1 
    LEFT JOIN tbl_dept D ON E1.fk_dept_code = D.dept_code
    LEFT JOIN tbl_job J ON E1.fk_job_code = J.job_code
    where status = 1 and empid = '2010001-001' and pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
) E2 
CROSS JOIN 
( 
    select trunc(months_between(sysdate, max(logindate))) AS lastlogingap 
    from tbl_loginhistory 
    where fk_empid = '2010001-001'
) H

insert into tbl_loginhistory(history_seq, fk_empid, logindate, clientip)
values(loginhistory_seq.nextval, #{empid}, default, #{clientip})

select empid 
from tbl_employees
where status = 1 and name = '관리자' and email = 'KmwWd6gn2fheAtIEcHhtdq4ZISt5PKTmXRFHRew2vWc=';

-----------------------------------------------------------------------

-- 아이디 찾기
select empid
from tbl_employees
where status = 1 and name = ? and email = ?;

-- 아이디 중복확인하기
select empid
from tbl_employees
where empid = '2010001-001';

-- 비밀번호 찾기
select pwd
from tbl_employees
where status = 1 and empid = '2014100-004' and name = '이지은' and email = 'gpYWbUyoXF5e21I/zchLYZa5CieVh0uqW9c6k7/niIU=';

-- 비밀번호 변경하기
update tbl_employees set pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
where empid = '2010001-001';

commit;
-- 커밋 완료.

-----------------------------------------------------------------------

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
    1   대표이사
    2   전무
    3   상무
    4   부장
    5	과장
    6	차장
    7	대리
    8	사원
*/

update tbl_job set job_name = '대표이사'
where job_code = 1;

insert into tbl_job(job_code, job_name)
values(8, '사원');

commit;
-- 커밋 완료.

select *
from tbl_employees
where fk_dept_code = '200'
order by fk_job_code;

update tbl_employees set fk_job_code = 1
where empid = '2010001-001';

commit;
-- 커밋 완료.

-----------------------------------------------------------------------

-- 주민번호를 입력받아서 성별을 알려주는 함수 func_gender(주민번호)을 생성 
create or replace function func_gender 
(p_jubun  IN  varchar2) 
return varchar2         
is
    v_result varchar2(6); 
begin
    select case when substr(p_jubun, 7, 1) in('1', '3') then '남' else '여' end
           INTO
           v_result
    from dual;
    return v_result;
end func_gender;
-- Function FUNC_GENDER이(가) 컴파일되었습니다.

-- 주민번호를 입력받아서 나이를 알려주는 함수 func_age(주민번호)을 생성
create or replace function func_age
(p_jubun  IN  varchar2) 
return number         
is
    v_age number(3); 
begin
    select case when to_date(to_char(sysdate, 'yyyy')||substr(p_jubun, 3, 4), 'yyyymmdd') - to_date(to_char(sysdate, 'yyyymmdd'),'yyyymmdd') > 0 
                then extract(year from sysdate) - (to_number(substr(p_jubun, 1, 2)) + case when substr(p_jubun, 7, 1) in('1', '2') then 1900 else 2000 end ) - 1 
                else extract(year from sysdate) - (to_number(substr(p_jubun, 1, 2)) + case when substr(p_jubun, 7, 1) in('1', '2') then 1900 else 2000 end )
           end
           INTO
           v_age
    from dual;
    return v_age;
end func_age;
-- Function FUNC_AGE이(가) 컴파일되었습니다.

select jubun
     , func_gender(jubun) AS gender
     , func_age(jubun) AS age
from tbl_employees;

-----------------------------------------------------------------------







