-- 오라클 계정 생성을 위해서는 SYS 또는 SYSTEM 으로 연결하여 작업을 해야 합니다. [SYS 시작] --
show user;
-- USER이(가) "SYS"입니다.

-- 오라클 계정 생성시 계정명 앞에 c## 붙이지 않고 생성하도록 하겠습니다.
alter session set "_ORACLE_SCRIPT"=true;
-- Session이(가) 변경되었습니다.

-- 오라클 계정명은 MYMVC_USER 이고 암호는 gclass 인 사용자 계정을 생성합니다.
create user final_orauser5 identified by gclass default tablespace users; 
-- User MYMVC_USER이(가) 생성되었습니다.

-- 위에서 생성되어진 MYMVC_USER 이라는 오라클 일반사용자 계정에게 오라클 서버에 접속이 되어지고,
-- 테이블 생성 등등을 할 수 있도록 여러가지 권한을 부여해주겠습니다.
grant connect, resource, create view, unlimited tablespace to final_orauser5;
-- Grant을(를) 성공했습니다.

-----------------------------------------------------------------------
-- 접속 - 새접속 - Name: remote_final_orauser5 사용자이름: final_orauser5 비밀번호: gclass 비밀번호 저장 - 테스트 - 저장 - 취소

create table tbl_bus
(bus_no                     VARCHAR2(30)  not null               
,pf_station_id              VARCHAR2(30)  not null          --정류장아이디
,first_time                 VARCHAR2(200)  not null                  --첫차시간
,last_time                  VARCHAR2(200)  not null                  --막차시간
,time_gap                   NUMBER  not null          --배차간격
,constraint PK_tbl_bus primary key(bus_no,pf_station_id)
,constraint FK_tbl_station_pf_station_id foreign key(pf_station_id) references tbl_station(Pk_station_id)
);

create sequence total_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache; 
-- 101
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('101번','03122','07:00:00','24:00:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('101번','04021','07:03:00','23:57:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('101번','04397','07:07:00','23:53:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('101번','04396','07:11:00','23:49:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('101번','04019','07:12:00','23:48:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('101번','03123','07:14:00','23:46:00','10');
--102
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102번','03015','07:00:00','24:00:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102번','03039','07:03:00','23:57:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102번','03137','07:07:00','23:53:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102번','03107','07:11:00','23:49:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102번','03124','07:12:00','23:48:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102번','03122','07:14:00','23:46:00','10');

insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102번','03123','07:17:00','23:44:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102번','03125','07:19:00','23:42:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102번','03110','07:20:00','23:39:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102번','03142','07:23:00','23:37:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102번','03038','07:25:00','23:35:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102번','03017','07:28:00','23:32:00','10');
commit;
--103
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103번','03090','07:00:00','24:00:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103번','03170','07:03:00','23:57:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103번','03103','07:07:00','23:53:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103번','03172','07:11:00','23:49:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103번','03122','07:12:00','23:48:00','10');

insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103번','03123','07:17:00','23:44:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103번','03173','07:19:00','23:42:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103번','03104','07:20:00','23:39:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103번','03169','07:23:00','23:37:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103번','03091','07:25:00','23:35:00','10');
commit;

select *
from tbl_bus

		select bus_no, v.pf_station_id, h.pk_station_id, first_time, last_time, h.station_name, time_gap, lat, lng, way, zindex
		from 
		(
		select bus_no, pf_station_id, first_time, last_time, time_gap
		from tbl_bus
		where bus_no = '101번'
		order by first_time asc
		)v cross join
		(
		select pk_station_id, station_name, lat, lng, way, zindex
		from tbl_station
		)h
		where h.pk_station_id = v.pf_station_id
		order by v.first_time asc
        
create table tbl_station
(Pk_station_id                  VARCHAR2(30)                      --정류장아이디                   
,station_name                   VARCHAR2(100)  not null           --정류장명
,lat                            NUMBER  not null                  --위도
,lng                            NUMBER  not null                  --경도
,constraint PK_tbl_station_station_id primary key(Pk_station_id)
);



  alter table tbl_station
  add way varchar2(200) not null;

commit;

--101번
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03122','수원월드컵경기장.아름학교','37.28674706537582','127.0402587819467','경기도경제과학진흥원 방면',1);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('04021','경기도경제과학진흥원','37.29079534179728','127.04547963591234','광교중앙.경기도청.아주대역환승센터 방면',2);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('04397','광교중앙.경기도청.아주대역환승센터','37.288454732776685','127.05138185376052','종점',3);


insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('04396','광교중앙.경기도청.아주대역환승센터','37.288537908037156','127.05177379426947','경기도경제과학진흥원 방면',4);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('04019','경기도경제과학진흥원','37.291135603390984','127.04516688665875','수원월드컵경기장.아름학교 방면',5);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03123','수원월드컵경기장.아름학교','37.28707375972554','127.0400587889236','종점',6);

--102번
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03015','수원역.노보텔수원','37.268212757868156','126.99956876164312','세무서.신용회복위원회 방면',7);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03039','세무서.신용회복위원회','37.26734320504059','127.00338785976807','녹산문고앞 방면',8);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03137','녹산문고앞',' 37.27510882921343','127.0181954083477','인계선경아파트 방면',9);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03107','인계선경아파트','37.27682782145644','127.03656077602773','창현고교.아주대학교.유신고교 방면',10);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03124','창현고교.아주대학교.유신고교','37.280878404042944','127.04211057329069','수원월드컵경기장.아름학교 방면',11);

insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03125','창현고교.아주대학교.유신고교','37.280574302250706','127.04211322287942','우만신성아파트 방면',12);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03110','우만신성아파트','37.27707546906844','127.03700627909338','영동시장 방면',13);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03142','영동시장','37.275313764757875','127.01852525914751','세무서.신용회복위원회 방면',14);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03038','세무서.신용회복위원회','37.26894689758696','127.00704926536443','수원역.AK플라자 방면',15);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03017','수원역.AK플라자','37.26745362831417','127.00081455316372','종점',16);

COMMIT;
--103번
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03090','수원시청역9번출구.국민연금공단','37.26296873108508','127.03252946353398','인계래미안노블클래스 방면',17);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03170','인계래미안노블클래스','37.26879104986174','127.0348629277089','현대힐스테이트.인계삼성아파트 방면',18);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03103','현대힐스테이트.인계삼성아파트','37.270935284162796','127.03568132562151','월드메르디앙 방면',19);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03172','월드메르디앙','37.278291523233456','127.03810907484589','수원월드컵경기장.아름학교 방면',20);

insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03173','월드메르디앙','37.280127734188476','127.03703032535326','인계삼성아파트.현대힐스테이트 방면',21);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03104','인계삼성아파트.현대힐스테이트','37.27110432574714','127.03536007826766','인계래미안노블클래스 방면',22);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03169','인계래미안노블클래스','37.26878891362191','127.03446550797491','수원시청역8번출구.씨네파크.헌혈의집 방면',23);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03091','수원시청역8번출구.씨네파크.헌혈의집','37.263757169233','127.03243397754491','종점',24);

delete from tbl_bus
delete from tbl_station

  alter table tbl_station
  add zindex number;
  commit;
    update tbl_station set Pk_station_id = '1'
    where station_name between '20240305-9401' and '20240305-9901'
    ;
ROLLBACK;

SELECT *
FROM tbl_station

--사원차량정보 테이블
create table tbl_car
(car_seq                  NUMBER                     --정류장아이디                   
,fk_empid                 VARCHAR2(30)  not null           --정류장명
,car_num                  VARCHAR2(100)  not null                  --위도
,car_kind                 VARCHAR2(100)  not null                  --경도
,max_num                  NUMBER  not null                  --경도
,constraint PK_tbl_car_car_seq primary key(car_seq)
,constraint FK_tbl_car_fk_empid foreign key(fk_empid) references tbl_employees(empid)
);


-- 일별차량공유정보 테이블
create table tbl_day_share
(res_num                  NUMBER                      --정류장아이디                   
,fk_car_seq               NUMBER  not null           --정류장명
,start_date               DATE  not null                  --위도
,last_date                DATE  not null                  --경도
,dp_add                   VARCHAR2(200)  not null                  --경도
,dp_lat                   NUMBER  not null                  --경도
,dp_lng                   NUMBER  not null                  --경도
,ds_add                   VARCHAR2(200)  not null                  --경도
,ds_lat                   NUMBER  not null                  --경도
,ds_lng                   NUMBER  not null                  --경도
,want_max                 NUMBER  not null                  --경도
,st_fee                   NUMBER  not null                  --경도
,end_status               NUMBER  not null                  --경도
,cancel_status            NUMBER  not null                  --경도
,constraint PK_tbl_day_share_res_num primary key(res_num)
,constraint FK_tbl_day_share_fk_car_seq foreign key(fk_car_seq) references tbl_car(car_seq)
);


-- 일별탑승신청정보 테이블
create table tbl_car_share
(pf_res_num             NUMBER                      --정류장아이디                   
,pf_empid               VARCHAR2(30)  not null           --정류장명
,rshare_date            DATE  not null                  --위도
,rdp_add                VARCHAR2(200)  not null                  --경도
,rdp_lat                NUMBER  not null                  --경도
,rdp_lng                NUMBER  not null                  --경도
,rds_add                VARCHAR2(200)  not null                  --경도
,rds_lat                NUMBER  not null                  --경도
,rds_lng                NUMBER  not null                  --경도
,share_fee              NUMBER  not null                  --경도
,share_status           NUMBER  not null                  --경도
,start_time             VARCHAR2(200)  not null                  --경도
,end_time               VARCHAR2(200)                   --경도
,cancel_status          DATE                   --경도
,constraint PK_tbl_car primary key(pf_res_num,pf_empid)
,constraint FK_tbl_car_share_pf_res_num foreign key(pf_res_num) references tbl_day_share(res_num)
,constraint FK_tbl_car_share_pf_empid  foreign key(pf_empid) references tbl_employees(empid)
);

-- 예>
--------------- tbl_car
-- 테이블 주석문
comment on table tbl_car 
is '사원의 차량정보가 들어있는 테이블';

comment on table tbl_day_share 
is '일별차량공유정보가 들어있는 테이블';

comment on table tbl_car_share 
is '일별탑승신청정보가 들어있는 테이블';

-- 테이블 주석문 확인
select *
from user_tab_comments
where table_name = 'tbl_car';

select *
from user_tab_comments
where table_name = 'tbl_day_share';

select *
from user_tab_comments
where table_name = 'tbl_car_share';
--------------- tbl_car
-- 컬럼명 주석문
comment on column tbl_car.car_seq is '차량정보번호'; 
comment on column tbl_car.fk_empid is '사원아이디'; 
comment on column tbl_car.car_num is '차번호'; 
comment on column tbl_car.car_kind is '차종'; 
comment on column tbl_car.max_num is '최대탑승인원'; 

--------------- tbl_car_share
-- 컬럼명 주석문
comment on column tbl_car_share.pf_res_num is '예약번호'; 
comment on column tbl_car_share.pf_empid is '사원아이디'; 
comment on column tbl_car_share.rshare_date is '탑승일자'; 
comment on column tbl_car_share.rdp_add is '출발지주소'; 
comment on column tbl_car_share.rdp_lat is '출발지위도'; 
comment on column tbl_car_share.rdp_lng is '출발지경도'; 
comment on column tbl_car_share.rds_add is '도착지주소'; 
comment on column tbl_car_share.rds_lat is '도착지위도'; 
comment on column tbl_car_share.rds_lng is '도착지경도'; 
comment on column tbl_car_share.share_fee is '지불비용'; 
comment on column tbl_car_share.share_status is '승인여부'; 
comment on column tbl_car_share.start_time is '승차시간'; 
comment on column tbl_car_share.end_time is '하차시간'; 


--------------- tbl_day_share
-- 컬럼명 주석문
comment on column tbl_day_share.res_num is '예약번호'; 
comment on column tbl_day_share.fk_car_seq is '차량정보번호'; 
comment on column tbl_day_share.start_date is '모집시작일자'; 
comment on column tbl_day_share.last_date is '모집마감일자'; 
comment on column tbl_day_share.dp_add is '출발지주소'; 
comment on column tbl_day_share.dp_lat is '출발지위도'; 
comment on column tbl_day_share.dp_lng is '출발지경도'; 
comment on column tbl_day_share.ds_add is '도착지주소'; 
comment on column tbl_day_share.ds_lat is '도착지위도'; 
comment on column tbl_day_share.ds_lng is '도착지경도'; 
comment on column tbl_day_share.want_max is '정원'; 
comment on column tbl_day_share.st_fee is '가격'; 
comment on column tbl_day_share.end_status is '마감상태'; 
comment on column tbl_day_share.cancel_status is '취소여부'; 

-- 컬럼명 주석문 확인
select column_name, comments
from user_col_comments
where table_name = 'tbl_car';

-- 컬럼명 주석문 확인
select column_name, comments
from user_col_comments
where table_name = 'tbl_car_share';

-- 컬럼명 주석문 확인
select column_name, comments
from user_col_comments
where table_name = 'tbl_day_share';


select *
from tbl_station;

commit;

select bus_no, v.pf_station_id, h.pk_station_id, first_time, last_time, h.station_name, time_gap, lat, lng, way
from 
(
select bus_no, pf_station_id, first_time, last_time, time_gap
from tbl_bus
where bus_no = '101번'
order by first_time asc
)v cross join
(
select pk_station_id, station_name, lat, lng, way
from tbl_station
)h
where h.pk_station_id = v.pf_station_id
;

SELECT 
    v.bus_no, 
    v.pf_station_id, 
    h.pk_station_id, 
    v.first_time, 
    v.last_time, 
    h.station_name, 
    v.time_gap
FROM 
    (
        SELECT 
            bus_no, 
            pf_station_id, 
            first_time, 
            last_time, 
            time_gap
        FROM 
            tbl_bus
        WHERE 
            bus_no = '101번'
        ORDER BY 
            first_time ASC
    ) v
JOIN
    (
        SELECT 
            pk_station_id, 
            station_name
        FROM 
            tbl_station
    ) h
ON 
    h.pk_station_id = v.pf_station_id;
    
alter table tbl_station
drop column station_icon;
commit;

select bus_no, v.pf_station_id, h.pk_station_id, first_time, last_time, h.station_name, time_gap, lat, lng, way
from 
(
select bus_no, pf_station_id, first_time, last_time, time_gap
from tbl_bus
where bus_no = '103번'
order by first_time asc
)v cross join
(
select pk_station_id, station_name, lat, lng, way
from tbl_station
)h
where h.pk_station_id = v.pf_station_id
order by v.first_time asc

select *
from BIN$xO9DfSPvRe+DqMICxn5zhQ==$0;