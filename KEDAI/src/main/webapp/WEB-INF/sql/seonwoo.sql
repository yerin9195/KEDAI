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


