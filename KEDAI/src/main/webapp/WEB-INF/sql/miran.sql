show user;
-- USER이(가) "FINAL_ORAUSER5"입니다

-- 급여 테이블 
create table tbl_sal
(salary_seq NUMBER not null --  급여번호
, fk_empid VARCHAR2(30) not null -- 사원아이디
, payment_date DATE not null    --  지급일자
, work_day NUMBER not null  --  근무일수
, work_day_plus NUMBER  --  초과근무일수
, base_salary NUMBER not null   --  기본급
, meal_pay NUMBER   --  식대
, annual_pay NUMBER     --  연차수당
, overtime_pay NUMBER   --  초과근무수당
, income_tax NUMBER     --  소득세
, local_income_tax NUMBER   --  지방소득세
, national_pen NUMBER   --  국민연금
, health_ins NUMBER     --  건강보험
, employment_ins NUMBER     --  고용보험
, constraint PK_tbl_sal primary key(salary_seq) 
, constraint FK_tbl_sal_fk_empid FOREIGN key(fk_empid) references tbl_employees(empid)
);
--  Table TBL_SAL이(가) 생성되었습니다.

comment on table tbl_sal 
is '급여 테이블';
--  Comment이(가) 생성되었습니다.

create sequence salary_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--  Sequence SALARY_SEQ이(가) 생성되었습니다.

comment on column tbl_sal.salary_seq is '급여번호'; 
comment on column tbl_sal.FK_EMPID is '사원아이디'; 
comment on column tbl_sal.PAYMENT_DATE is '지급일자'; 
comment on column tbl_sal.WORK_DAY is '근무일수'; 
comment on column tbl_sal.WORK_DAY_PLUS is '초과근무일수'; 
comment on column tbl_sal.BASE_SALARY is '기본급'; 
comment on column tbl_sal.MEAL_PAY is '식대'; 
comment on column tbl_sal.ANNUAL_PAY is '연차수당'; 
comment on column tbl_sal.OVERTIME_PAY is '초과근무수당'; 
comment on column tbl_sal.INCOME_TAX is '소득세'; 
comment on column tbl_sal.LOCAL_INCOME_TAX is '지방소득세'; 
comment on column tbl_sal.NATIONAL_PEN is '국민연금'; 
comment on column tbl_sal.HEALTH_INS is '건강보험'; 
comment on column tbl_sal.EMPLOYMENT_INS is '고용보험'; 
-- Comment이(가) 생성되었습니다.

select *
from user_col_comments
where table_name = 'TBL_SAL';