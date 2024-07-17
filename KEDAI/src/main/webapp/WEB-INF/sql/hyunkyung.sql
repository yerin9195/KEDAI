

-- 설문 테이블
create table tbl_survey
(survey_no     number               not null  -- 설문번호
,fk_empid      varchar2(30)         not null  -- 사원아이디
,subject       varchar2(200)        not null  -- 설문제목
,desc          nvarchar2(1000)                -- 상세설명
,attachment    varchar2(200)                  -- 첨부파일
,startday      date default sysdate not null  -- 설문시작일
,duedate       date                 not null  -- 설문마감일
,name          varchar2(50)         not null  -- 설문자 이름
,job_name      varchar2(50)                   -- 설문자 직급명
                                               
,constraint PK_tbl_survey_survey_no primary key(survey_no)
,constraint FK_tbl_survey_empid foreign key(fk_empid) references tbl_employees(empid)
,constraint FK_tbl_comment_parentSeq foreign key(parentSeq) references tbl_board(seq) on delete cascade
,constraint CK_tbl_comment_status check( status in(1,0) ) 
);
-- 설문 테이블의 설문번호 시퀀스
create sequence survey_no
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 설문테이블 코멘트
COMMENT ON COLUMN tbl_survey.survey_no IS '설문에 대한 번호(primary key)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey.fk_empid IS '설문을 작성한 사원 아이디 references tbl_employees(empid)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey.subject IS '설문제목'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey.desc IS '설문에 대한 상세 설명'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey.attachment IS '첨부파일'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey.startday IS '설문시작일(default sysdate)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey.duedate IS '설문마감일'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey.name IS '설문을 작성한 사원 이름'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey.job_name IS '설문을 작성한 사원의 직급명'; --Comment이(가) 생성되었습니다.


--설문대상
create table tbl_survey_target
(target_code    number      not null  -- 설문대상코드 
,fk_survey_no   number      not null  -- 설문번호 
,fk_dept_code   number(4)   not null  -- 부서코드 

,constraint PK_tbl_survey_target_target_code primary key(q_code)
,constraint FK_tbl_survey_target_fk_survey_no foreign key(fk_survey_no) references tbl_survey(survey_no)
,constraint FK_tbl_survey_target_fk_dept_code foreign key(fk_dept_code) references tbl_dept(dept_code)
);

-- 설문대상 코멘트
COMMENT ON COLUMN tbl_survey_target.target_code IS '설문 대상에 대한 시퀀스(primary key)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_target.fk_survey_no IS '설문 번호 references tbl_survey(survey_no)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_target.fk_dept_code IS '설문 대상으로 선택한 부서의 코드 references tbl_dept(dept_code)'; --Comment이(가) 생성되었습니다.


--설문문항타입
create table tbl_q_type
(q_type_code    number          not null  -- 문항타입코드 
,q_type         VARCHAR(50)     not null  -- 문항타입 

,constraint PK_tbl_q_type_q_type_code primary key(q_type_code)
);


-- 설문문항타입 코멘트
COMMENT ON COLUMN tbl_q_type.q_type_code IS '설문 문항 질문 타입에 따른 코드(primary key)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_q_type.q_type IS '설문 문항 타입에 대한 설명 '; --Comment이(가) 생성되었습니다.



--설문문항
create table tbl_survey_q
(q_code           VARCHAR(200)      not null    -- 설문문항코드
,fk_survey_no     NUMBER            not null    -- 설문번호
,q_number         NUMBER            not null    -- 설문문항번호 
,q_content        VARCHAR2(200)     not null    -- 문항별 질문
,q_num_option     VARCHAR2(200)                 -- 문항질문별선택옵션
,q_type_code      NUMBER            not null    -- 문항타입코드

,constraint PK_tbl_survey_q_q_code primary key(q_code)
,constraint FK_tbl_survey_q_fk_survey_no foreign key(fk_survey_no) references tbl_survey(survey_no)
);

-- 설문문항 코멘트
COMMENT ON COLUMN tbl_survey_q.q_code IS '설문 문항 코드(primary key)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_q.fk_survey_no IS '설문번호  references tbl_survey(survey_no) '; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_q.q_number IS '설문 문항 번호'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_q.q_code IS '설문 문항 코드'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_q.q_content IS '문항별 질문 내용'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_q.q_num_option IS '문항 질문에 선택지가 있는 경우 '; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_q.q_type_code IS '설문 문항타입코드 references tbl_survey(survey_no)'; --Comment이(가) 생성되었습니다.


--설문답변
create table tbl_survey_a
(a_code             NUMBER            not null    -- 설문답변코드
,fk_survey_no       NUMBER            not null    -- 설문번호
,fk_q_code   VARCHAR(200)      not null    -- 설문문항코드
,survey_a_content   VARCHAR2(200)     not null    -- 답변
,fk_q_type_code     NUMBER            not null    -- 문항타입코드
,fk_empid           VARCHAR2(30)      not null    -- 답변자 사원아이디

,constraint PK_tbl_survey_a_a_code primary key(a_code)
,constraint FK_tbl_survey_a_fk_survey_no foreign key(fk_survey_no) references tbl_survey(survey_no)
,constraint FK_tbl_survey_a_fk_q_code foreign key(fk_q_code) references tbl_survey_q(q_code)
,constraint FK_tbl_survey_a_fk_q_type_code foreign key(fk_q_type_code) references tbl_survey(tbl_q_type)
,constraint FK_tbl_survey_a_fk_empid foreign key(fk_empid) references tbl_employees(empid)
);

-- 설문문항 코멘트
COMMENT ON COLUMN tbl_survey_a.a_code IS '설문 답변 코드(primary key)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_a.fk_survey_no IS '설문번호 references tbl_survey(survey_no)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_a.fk_survey_q_code IS '설문문항코드 tbl_survey_q(q_code)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_a.survey_a_content IS '설문에 대한 답변'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_a.fk_q_type_code IS '설문 문항에 대한 타입 코드 tbl_survey(tbl_q_type)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_survey_a.fk_empid IS '설문 답변자의 사원 아이디 tbl_employees(empid)'; --Comment이(가) 생성되었습니다.




--- *** 테이블명에 달려진 주석문 조회하기 *** --
select *
from user_tab_comments; 

 ---- !!!! 테이블을 생성한 이후에 웬만하면 컬럼명에 대한 주석문을 달아주도록 합시다.!!!! ----
    --     COMMENT ON COLUMN 테이블명.컬럼명 IS '주석문'
COMMENT ON COLUMN tbl_jikwon.sano IS '사원번호 primary key'; --Comment이(가) 생성되었습니다.


show user;


---------------------------결재 관련 테이블------------------------------
-- 기안종류(24.07.03 생성완료)
create table tbl_doctype
(doctype_code       NUMBER            not null    -- 기안종류코드
,doctype_name       VARCHAR2(30)      not null    -- 기안종류명

,constraint PK_tbl_doctype_doctype_code primary key(doctype_code)
);
-- 기안종류 코멘트
COMMENT ON COLUMN tbl_doctype.doctype_code IS '기안 종류 코드(primary key) 100:연차신청서 101:회의록 102:추가근무비용신청'; --Comment이(가) 생성되었습니다.

insert into tbl_doctype(doctype_code, doctype_name) values(100, '연차신청서');
insert into tbl_doctype(doctype_code, doctype_name) values(101, '회의록');
insert into tbl_doctype(doctype_code, doctype_name) values(102, '추가근무비용신청');
      
commit;

--기안문서(24.07.03 생성완료)
create table tbl_doc
(doc_no             VARCHAR2(30)         not null    -- 기안문서번호(EX. KD-100-2407)
,fk_doctype_code    NUMBER               not null    -- 기안종류코드 100:연차신청서 101:회의록 102:야간근무신청
,fk_empid           VARCHAR2(30)         not null    -- 기안자사원아이디
,doc_subject        NVARCHAR2(50)        not null    -- 기안문서제목
,doc_content        NVARCHAR2(2000)      not null    -- 기안문서내용
,created_date       date default sysdate not null    -- 서류작성일자
,doc_comment            NVARCHAR2(100)                   -- 기안의견
-- ,doc_status         NUMBER  default 0    not null    -- 기안상태  0:기안 1:반려                
,constraint PK_tbl_doc_doc_no primary key(doc_no)
,constraint FK_tbl_doc_fk_doctype_code foreign key(fk_doctype_code) references tbl_doctype(doctype_code)
,constraint FK_tbl_doc_fk_empid foreign key(fk_empid) references tbl_employees(EMPID)
-- ,constraint ck_tbl_doc_doc_status CHECK (doc_status IN(0, 1))
);

ALTER TABLE tbl_doc
DROP COLUMN doc_status;


ALTER TABLE tbl_doc RENAME COLUMN content TO doc_content;

ALTER TABLE tbl_doc DROP COLUMN doc_org_filename;
ALTER TABLE tbl_doc DROP COLUMN doc_filename; -- 첨부 파일명
ALTER TABLE tbl_doc DROP COLUMN doc_filesize;--파일크기
commit;

create sequence doc_noSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

SELECT column_name, comments
FROM user_col_comments
WHERE table_name = 'TBL_DOC' ;

commit;

-- 기안종류 코멘트
COMMENT ON COLUMN tbl_doc.doc_no IS '기안 문서 번호(primary key)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_doc.fk_doctype_code IS '기안 종류 코드 references tbl_doctype(doctype_code) 100:연차신청서 101:회의록 102:야간근무신청';
COMMENT ON COLUMN tbl_doc.fk_empid IS '기안을 올린 사원 아이디 references tbl_employees(empid)';
COMMENT ON COLUMN tbl_doc.subject IS '기안 문서 제목';
COMMENT ON COLUMN tbl_doc.content IS '기안 문서 내용';
COMMENT ON COLUMN tbl_doc.created_date IS '서류 작성 일자 default sysdate';
COMMENT ON COLUMN tbl_doc.doc_comment IS '기안 의견';
COMMENT ON COLUMN tbl_doc.doc_status IS '기안상태  0:기안 1:반려';
COMMENT ON COLUMN tbl_doc.doc_org_filename IS '기안자가 올린 첨부 파일명';
COMMENT ON COLUMN tbl_doc.doc_filename IS 'WAS에 저장하는 첨부 파일명';
COMMENT ON COLUMN tbl_doc.doc_filesize IS '파일 사이즈';

--연차 신청서
create table tbl_dayoff
(dayoff_no        NUMBER         not null    -- 신청서시퀀스
,fk_doc_no        VARCHAR2(30)   not null    -- 기안문서번호
,dayoff_type      NUMBER         not null    -- 연차종류 
,startdate        DATE           not null    -- 휴가시작일
,findate          DATE           not null    -- 휴가종료일
,reason           VARCHAR2(50)   not null    -- 연차사유

,constraint PK_tbl_dayoff_dayoff_no primary key(doc_no)
,constraint FK_tbl_dayoff_fk_doc_no foreign key(fk_doc_no) references tbl_doc(doc_no)
);

-- 연차 신청서 코멘트
COMMENT ON COLUMN tbl_dayoff.dayoff_no IS '연차 신청서 시퀀스(primary key)'; --Comment이(가) 생성되었습니다.
COMMENT ON COLUMN tbl_doc.fk_doc_no IS '기안 문서 번호  references tbl_doc(doc_no)';
COMMENT ON COLUMN tbl_doc.dayoff_type IS '연차종류 '; -- 번호는 아직 미정..
COMMENT ON COLUMN tbl_doc.startdate IS '휴가시작일 '; 
COMMENT ON COLUMN tbl_doc.findate IS '휴가종료일 '; 
COMMENT ON COLUMN tbl_doc.reason IS '연차사유 '; 

--회의록(24.07.03 생성완료)
create table tbl_minutes
(minutes_no    NUMBER             not null    -- 회의록시퀀스
,fk_doc_no       VARCHAR2(30)       not null    -- 기안문서번호
,meeting_date    DATE               not null    -- 회의일자 
,attendees       NVARCHAR2(50)      not null    -- 회의 참석자
,host_dept       NVARCHAR2(50)      not null    -- 회의 주관부서
,constraint PK_tbl_minutes_minutes_code primary key(minutes_code)
,constraint FK_tbl_minutes_fk_doc_no foreign key(fk_doc_no) references tbl_doc(doc_no)
);             
ALTER TABLE tbl_minutes RENAME COLUMN minutes_code TO minutes_no;
ALTER TABLE tbl_minutes ADD host_dept NVARCHAR2(50) not null;
ALTER TABLE tbl_minutes DROP COLUMN content; -- content테이블 삭제

select *
from tbl_minutes;
create sequence minutes_noSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
--Sequence MINUTES_NOSEQ이(가) 생성되었습니다.

commit;

select *
from  tbl_minutes;

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_MINUTES';

--회의록 코멘트(24.07.03 생성완료)
COMMENT ON COLUMN tbl_mom.mom_code IS '회의록 시퀀스(primary key) '; 
COMMENT ON COLUMN tbl_mom.fk_doc_no IS ' 기안 문서 번호 references tbl_doc(doc_no) '; 
COMMENT ON COLUMN tbl_mom.meeting_date IS '회의 일자 '; 
COMMENT ON COLUMN tbl_mom.content IS '회의록 내용 '; 
COMMENT ON COLUMN tbl_mom.attendees IS '회의 참석자 '; 

commit;

--결재 테이블(24.07.03 생성완료)
create table tbl_approval
(approval_no        NUMBER           not null    -- 결재번호
,fk_doc_no          VARCHAR2(30)     not null    -- 기안문서번호
,fk_empid           VARCHAR2(30)     not null    -- 결재자사원아이디 
,status             NUMBER           not null    -- 결재상태
,approval_comment   NVARCHAR2(100)               -- 결재의견
,approval_date      DATE                         -- 결재일자
,level_no           NUMBER           not null    -- 결재단계
,constraint PK_tbl_approval_approval_no primary key(approval_no)
,constraint FK_tbl_approval_fk_doc_no foreign key(fk_doc_no) references tbl_doc(doc_no)
,constraint FK_tbl_approval_fk_empid foreign key(fk_empid) references tbl_employees(empid)
);

ALTER TABLE tbl_approval DROP CONSTRAINT PK_tbl_approval_new;

ALTER TABLE tbl_approval 
ADD CONSTRAINT PK_tbl_approval_no_empid PRIMARY KEY (approval_no, fk_empid);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_APPROVAL';

ALTER TABLE tbl_approval
MODIFY level_no DEFAULT NULL;

create sequence approval_noSeq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

SELECT sequence_name
FROM user_sequences
WHERE sequence_name = 'APPROVAL_NOSEQ';

commit;

-- 결재 코멘트(24.07.03 생성완료)

COMMENT ON COLUMN tbl_approval.approval_no IS '결재번호(primary key) '; 
COMMENT ON COLUMN tbl_approval.fk_doc_no IS '기안 문서 번호 '; 
COMMENT ON COLUMN tbl_approval.fk_empid IS ' 결재자 사원 아이디 '; 
COMMENT ON COLUMN tbl_approval.status IS '결재상태 0:미결재 1:결재 3:반려'; 
COMMENT ON COLUMN tbl_approval.approval_comment IS '결재의견 '; 
COMMENT ON COLUMN tbl_approval.approval_date IS '결재일자 '; 


-- 첨부파일 테이블



--- 문서번호 추가하기

desc tbl_job

select *
from tbl_job

SELECT *
FROM tbl_employees

select E.empid, E.name, J.job_code, J.job_name, CASE WHEN D.dept_code IS NULL THEN ' ' ELSE TO_CHAR(D.dept_code) END AS dept_code,
       nvl(D.dept_name, ' ') as dept_name
from tbl_employees E
JOIN tbl_job J
ON E.fk_job_code = J.job_code
LEFT JOIN tbl_dept D
ON E.fk_dept_code = D.dept_code
order by dept_name asc, job_code desc


    
SELECT D.dept_name, COUNT(E.empid) AS employee_count
FROM tbl_employees E
LEFT JOIN tbl_dept D
ON E.fk_dept_code = D.dept_code
GROUP BY E.fk_dept_code, D.dept_name
ORDER BY D.dept_name DESC;


SELECT E.empid, E.name, E.fk_dept_code, J.job_code, J.job_name, D.dept_name
FROM  tbl_employees E
JOIN tbl_job J
ON  E.fk_job_code = J.job_code
LEFT JOIN tbl_dept D
ON E.fk_dept_code = D.dept_code
where empid !='2018100-007' and fk_dept_code = '100'
ORDER BY D.dept_code DESC, J.job_code ASC;   

SELECT E.empid, E.name, E.fk_dept_code, J.job_code, J.job_name, D.dept_name
FROM  tbl_employees E
JOIN tbl_job J
ON  E.fk_job_code = J.job_code
LEFT JOIN tbl_dept D
ON E.fk_dept_code = D.dept_code
ORDER BY D.dept_code DESC, J.job_code ASC;

where fk_dept_code = (null)

select *
from tbl_dept;


SELECT NVL(to_char(D.dept_code, ' ')) AS dept_code, D.dept_name
FROM tbl_dept D
RIGHT JOIN tbl_employees E ON E.fk_dept_code = D.dept_code
GROUP BY D.dept_code, D.dept_name
ORDER BY D.dept_code ASC;

--ORA-00909: invalid number of arguments

SELECT CASE WHEN D.dept_code IS NULL THEN '0' ELSE TO_CHAR(D.dept_code) END AS dept_code,
       nvl(D.dept_name, ' ')
FROM tbl_dept D
RIGHT JOIN tbl_employees E ON E.fk_dept_code = D.dept_code
GROUP BY D.dept_code, D.dept_name
ORDER BY D.dept_code desc;

select *
from tbl_employees


select minutes_no.nextval
from dual;


insert insert into tbl_doc(doc_no, fk_doctype_code, fk_empid, doc_subject, doc_content, created_date)
values(103, '변우석', default);

select *
from tbl_minutes;

desc tbl_doc;

