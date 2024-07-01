create table tbl_business_part
(partner_no           varchar2(100) not null -- 사업자 등록번호
,partner_type         varchar2(100) not null -- 거래처 업종
,partner_name         varchar2(100) not null -- 거래처명
,partner_url          varchar2(200) not null -- 거래처홈페이지 주소
,partner_address      varchar2(200) not null -- 거래처 주소
,imgfilename          varchar2(200) not null -- 이미지파일명
,lat                  Number        not null -- 위도
,lng                  Number        not null -- 경도
,zindex               NUMBER        not null -- 인덱스
,part_emp_name        varchar2(30)  not null -- 거래처담당자이름
,part_emp_tel         varchar2(30)  null     -- 거래처 담당자 연락처
,part_emp_email       varchar2(100) not null -- 거래처담당자 이메일
,part_emp_dept         varchar2(30) null     -- 거래처담당자 소속부서
,constraint tbl_business_part primary key(partner_no)
);

select *
from tbl_business_part;



-- 테이블 주석문 확인
Select *
From User_Tab_Comments
Where Table_Name = 'TBL_BUSINESS_PART'; 

-- 컬럼명 주석문
comment on column tbl_business_part.partner_no is '사업자등록번호'; 
comment on column tbl_business_part.partner_type is '거래처업종'; 
comment on column tbl_business_part.partner_name is '거래처명'; 
comment on column tbl_business_part.partner_url is '거래처홈페이지주소'; 
comment on column tbl_business_part.partner_address is '거래처주소'; 
comment on column tbl_business_part.imgfilename is '이미지파일명'; 
comment on column tbl_business_part.lat is '위도'; 
comment on column tbl_business_part.lng is '경도'; 
comment on column tbl_business_part.zindex is '인덱스'; 
comment on column tbl_business_part.part_emp_name is '거래처담당자이름'; 
comment on column tbl_business_part.part_emp_tel is '거래처담당자연락처'; 
comment on column tbl_business_part.part_emp_email is '거래처담당자이메일'; 
comment on column tbl_business_part.part_emp_dept is '거래처담당자소속부서'; 


-- 컬럼명 주석문 확인 -- tbl_business_part 대문자로 해야됨. 
select column_name, comments
from user_col_comments
where table_name = 'TBL_BUSINESS_PART';

--------------------------직원 테이블 생성확인(아직안되어있음)---------------------------------
select * 
from tbl_employees;
----------------------------------------------------------------------------
desc tab;


