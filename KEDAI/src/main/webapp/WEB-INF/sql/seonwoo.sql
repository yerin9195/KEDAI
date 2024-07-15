select * 
from tbl_business_part;

insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday) 
values('youinna', '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', '유인나', 'jnfHk9MlyFJUs2pN34jOUKnMAbGd8kHbm7wgNqMDWIc=', '0W8j3vcLbVOrOBwdXHFJFQ==', 
       '15864', '경기 군포시 오금로 15-17', '101동 102호', ' (금정동)', '2', '2001-10-11');
       
insert into tbl_business_part(partner_no, partner_type, partner_name, partner_url, partner_address, imgfilename, lat, lng, zindex, part_emp_name, part_emp_tel, part_emp_email, part_emp_dept)
values('123-345-567','유통업','한국유통','daum.naver','서울시 마포구 월드컵대로','daum.png',37.56511284953554,126.98187860455485,1,'홍길동','010-2222-3333','honggildong@naver.com','유통관리부');
       
insert into tbl_business_part(partner_no, partner_type, partner_name, partner_url, partner_address, imgfilename, lat, lng, zindex, part_emp_name, part_emp_tel, part_emp_email, part_emp_dept)
values('123-345-568','판매업','대한섬유','daehan.naver','서울시 마포구 월드컵대로','daehan.png',37.56511284953556,126.98187860455489,2,'박명수','010-2233-4433','parkms@naver.com','섬유제작부');      
   
insert into tbl_business_part(partner_no, partner_type, partner_name, partner_url, partner_address, imgfilename, lat, lng, zindex, part_emp_name, part_emp_tel, part_emp_email, part_emp_dept)
values('123-345-590','세무회계업','나라회계','nara.daum.net','서울시 용산구 한남대로','nara.png',37.56511284953522,126.98187860455487,3,'장나라','010-3344-4455','nara@naver.com','회계관리부');         
   
insert into tbl_business_part(partner_no, partner_type, partner_name, partner_url, partner_address, imgfilename, lat, lng, zindex, part_emp_name, part_emp_tel, part_emp_email, part_emp_dept)
values('123-345-600','디자인업','미래디자인','miraedesign.net','서울시 성동구 성수1대로','miraeDesign.png',37.56511284953999,126.98187860458883,4,'윤미래','010-5555-7777','miraedesign@naver.com','디자인제작부');

insert into tbl_business_part(partner_no, partner_type, partner_name, partner_url, partner_address, imgfilename, lat, lng, zindex, part_emp_name, part_emp_tel, part_emp_email, part_emp_dept)
values('123-345-444','유통관리부','고고유통','gogoyutong.net','서울시 성동구 성수2대로','gogoyutong.png',37.56511284953123,126.98187860458123,5,'고나리','010-9999-8877','gogoyutong@naver.com','유통관리부');

commit;

Drop table tbl_business_part;

select *
from tbl_business_part;

rollback;

commit;

-----------------------------------------------------------------------------------------------------------------------------------------------------
-- 거래처 테이블 재생성 시작 -- (주소 컬럼 세부적으로 추가한다)
create table tbl_business_part
(partner_no             varchar2(100) not null 
,partner_type           varchar2(100) not null
,partner_name           varchar2(100) not null
,partner_url            varchar2(200) not null
,partner_postcode       varchar2(200) not null
,partner_address        varchar2(200) not null
,partner_detailaddress  varchar2(200) null
,partner_extraaddress   varchar2(200) null
,imgfilename            varchar2(200) not null
,lat                    Number        not null
,lng                    Number        not null
,zindex                 Number        not null
,part_emp_name          varchar2(30)  not null        
,part_emp_tel           varchar2(30)  null
,part_emp_email         varchar2(100) not null
,part_emp_dept          varchar2(30)  null
,constraint tbl_business_part primary key(partner_no)
);

commit;

select *
from tbl_business_part;
-- 거래처 테이블 재생성 끝 -- (주소 컬럼 세부적으로 추가한다)

--- 주석문 넣기 시작 -- 
-- 테이블 주석문 --
comment on table tbl_business_part
is '거래처정보가 들어있는 테이블';
-- Comment이(가) 생성되었습니다.

select *
from user_tab_comments
where table_name = 'TBL_BUSINESS_PART'; 

-- 컬럼 주석문 -- 
comment on column tbl_business_part.partner_no is '사업자등록번호';
-- 여기까지 생성

comment on column tbl_business_part.partner_type is '거래처업종';
comment on column tbl_business_part.partner_name is '거래처명';
comment on column tbl_business_part.partner_url is '거래처홈페이지주소';
comment on column tbl_business_part.partner_postcode is '거래처우편번호';
comment on column tbl_business_part.partner_address is '거래처주소';
comment on column tbl_business_part.partner_detailaddress is '거래처상세주소';
comment on column tbl_business_part.partner_extraaddress is '거래처참고항목';
comment on column tbl_business_part.imgfilename is '이미지파일명';
comment on column tbl_business_part.lat is '위도';
comment on column tbl_business_part.lng is '경도';
comment on column tbl_business_part.zindex is '인덱스';
comment on column tbl_business_part.part_emp_name is '거래처담당자이름';
comment on column tbl_business_part.part_emp_tel is '거래처담당자연락처';
comment on column tbl_business_part.part_emp_email is '거래처담당자이메일';
comment on column tbl_business_part.part_emp_dept is '거래처담당자소속부서';

select column_name, comments
from user_col_comments
where table_name = 'TBL_BUSINESS_PART';

commit;
-- 거래처 테이블 재생성 및 주석추가 완료 -- 
--------------------------------------------------------------------------------------
insert into tbl_business_part(partner_no, partner_type, partner_name, partner_url, partner_postcode, partner_address, partner_detailaddress, partner_extraaddress, imgfilename, lat, lng, zindex, part_emp_name, part_emp_tel, part_emp_email, part_emp_dept)
values('123-45-67890','유통업','한국유통','hangukyutong.com','15856','경기 군포시 고산로250번길 13','202호','(당동)','daum.png',37.56511284953554,126.98187860455485,1,'홍길동','010-2222-3333','honggildong@naver.com','유통관리부');

insert into tbl_business_part(partner_no, partner_type, partner_name, partner_url,partner_postcode, partner_address,partner_detailaddress,partner_extraaddress, imgfilename, lat, lng, zindex, part_emp_name, part_emp_tel, part_emp_email, part_emp_dept)
values('223-56-56812','판매업','대한섬유','daehan.com','40159','경북 고령군 쌍림면 쌍림공단길 112','1호','협재동','daehan.png',37.56511284953556,126.98187860455489,2,'박명수','010-2233-4433','parkms@naver.com','섬유제작부');            
       
insert into tbl_business_part(partner_no, partner_type, partner_name, partner_url,partner_postcode, partner_address,partner_detailaddress,partner_extraaddress, imgfilename, lat, lng, zindex, part_emp_name, part_emp_tel, part_emp_email, part_emp_dept)
values('123-15-59011','세무회계업','나라회계','nara.daum.net','16305','경기 수원시 장안구 경수대로927번길 36-2','13층','1301호','nara.png',37.56511284953522,126.98187860455487,3,'장나라','010-3344-4455','nara@naver.com','회계관리부');         
         
insert into tbl_business_part(partner_no, partner_type, partner_name, partner_url,partner_postcode, partner_address,partner_detailaddress,partner_extraaddress, imgfilename, lat, lng, zindex, part_emp_name, part_emp_tel, part_emp_email, part_emp_dept)
values('123-32-60023','디자인업','미래디자인','miraedesign.net','04736','서울 성동구 독서당로 154','2층','204호','miraeDesign.png',37.56511284953999,126.98187860458883,4,'윤미래','010-5555-7777','miraedesign@naver.com','디자인제작부');
       
insert into tbl_business_part(partner_no, partner_type, partner_name, partner_url,partner_postcode, partner_address, imgfilename, lat, lng, zindex, part_emp_name, part_emp_tel, part_emp_email, part_emp_dept)
values('123-67-44412','유통관리부','고고유통','gogoyutong.net','17725','서울시 성동구 성수2대로','gogoyutong.png',37.56511284953123,126.98187860458123,5,'고나리','010-9999-8877','gogoyutong@naver.com','유통관리부');

select *
from tbl_business_part;

commit;
    
---------------------------------------------------------------------------------------------------------------      

select partner_no
from tbl_business_part
where partner_no = '123-15-59011'; 


select *
from tbl_business_part;

alter table tbl_business_part add part_emp_rank varchar(200);
alter table tbl_business_part add part_emp_rank varchar(200) not null;

update tbl_business_part
set part_emp_rank = ''
where part_emp_rank is not null;

alter table tbl_business_part
modify part_emp_rank varchar(200) not null;

truncate table tbl_business_part;

commit;


desc tbl_business_part;

select *
from tbl_business_part;
--------------------------------------------------------------------------------------------------------------------------------------------

select *
from tbl_business_part;

select *
from tbl_employees;




select partner_name
		from tbl_business_part
		where partner_name = '(주)에이티에스인코'

SELECT partner_name
FROM tbl_business_part;



select partner_no, partner_type, partner_name, partner_url, partner_postcode, partner_address, partner_detailaddress, partner_extraaddress,
		       originalfilename, part_emp_name, part_emp_tel, part_emp_email, part_emp_dept, part_emp_rank
		from tbl_business_part
        where partner_name = '(주)에이티에스인코';
        
        
delete from tbl_business_part
where partner_no = '111-22-22222'      
   
SELECT partner_name
FROM tbl_business_part;       



        
        
commit;        
