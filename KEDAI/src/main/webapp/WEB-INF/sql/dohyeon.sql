-- ����Ŭ ���� ������ ���ؼ��� SYS �Ǵ� SYSTEM ���� �����Ͽ� �۾��� �ؾ� �մϴ�. [SYS ����] --
show user;
-- USER��(��) "SYS"�Դϴ�.

-- ����Ŭ ���� ������ ������ �տ� c## ������ �ʰ� �����ϵ��� �ϰڽ��ϴ�.
alter session set "_ORACLE_SCRIPT"=true;
-- Session��(��) ����Ǿ����ϴ�.

-- ����Ŭ �������� MYMVC_USER �̰� ��ȣ�� gclass �� ����� ������ �����մϴ�.
create user final_orauser5 identified by gclass default tablespace users; 
-- User MYMVC_USER��(��) �����Ǿ����ϴ�.

-- ������ �����Ǿ��� MYMVC_USER �̶�� ����Ŭ �Ϲݻ���� �������� ����Ŭ ������ ������ �Ǿ�����,
-- ���̺� ���� ����� �� �� �ֵ��� �������� ������ �ο����ְڽ��ϴ�.
grant connect, resource, create view, unlimited tablespace to final_orauser5;
-- Grant��(��) �����߽��ϴ�.

-----------------------------------------------------------------------
-- ���� - ������ - Name: remote_final_orauser5 ������̸�: final_orauser5 ��й�ȣ: gclass ��й�ȣ ���� - �׽�Ʈ - ���� - ���

create table tbl_bus
(bus_no                     VARCHAR2(30)  not null               
,pf_station_id              VARCHAR2(30)  not null          --��������̵�
,first_time                 VARCHAR2(200)  not null                  --ù���ð�
,last_time                  VARCHAR2(200)  not null                  --�����ð�
,time_gap                   NUMBER  not null          --��������
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
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('101��','03122','07:00:00','24:00:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('101��','04021','07:03:00','23:57:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('101��','04397','07:07:00','23:53:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('101��','04396','07:11:00','23:49:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('101��','04019','07:12:00','23:48:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('101��','03123','07:14:00','23:46:00','10');
--102
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102��','03015','07:00:00','24:00:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102��','03039','07:03:00','23:57:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102��','03137','07:07:00','23:53:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102��','03107','07:11:00','23:49:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102��','03124','07:12:00','23:48:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102��','03122','07:14:00','23:46:00','10');

insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102��','03123','07:17:00','23:44:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102��','03125','07:19:00','23:42:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102��','03110','07:20:00','23:39:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102��','03142','07:23:00','23:37:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102��','03038','07:25:00','23:35:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('102��','03017','07:28:00','23:32:00','10');
commit;
--103
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103��','03090','07:00:00','24:00:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103��','03170','07:03:00','23:57:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103��','03103','07:07:00','23:53:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103��','03172','07:11:00','23:49:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103��','03122','07:12:00','23:48:00','10');

insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103��','03123','07:17:00','23:44:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103��','03173','07:19:00','23:42:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103��','03104','07:20:00','23:39:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103��','03169','07:23:00','23:37:00','10');
insert into tbl_bus(bus_no, pf_station_id, first_time, last_time, time_gap) values('103��','03091','07:25:00','23:35:00','10');
commit;

select *
from tbl_bus

		select bus_no, v.pf_station_id, h.pk_station_id, first_time, last_time, h.station_name, time_gap, lat, lng, way, zindex
		from 
		(
		select bus_no, pf_station_id, first_time, last_time, time_gap
		from tbl_bus
		where bus_no = '101��'
		order by first_time asc
		)v cross join
		(
		select pk_station_id, station_name, lat, lng, way, zindex
		from tbl_station
		)h
		where h.pk_station_id = v.pf_station_id
		order by v.first_time asc
        
create table tbl_station
(Pk_station_id                  VARCHAR2(30)                      --��������̵�                   
,station_name                   VARCHAR2(100)  not null           --�������
,lat                            NUMBER  not null                  --����
,lng                            NUMBER  not null                  --�浵
,constraint PK_tbl_station_station_id primary key(Pk_station_id)
);



  alter table tbl_station
  add way varchar2(200) not null;

commit;

--101��
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03122','���������Ű����.�Ƹ��б�','37.28674706537582','127.0402587819467','��⵵������������� ���',1);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('04021','��⵵�������������','37.29079534179728','127.04547963591234','�����߾�.��⵵û.���ִ뿪ȯ�¼��� ���',2);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('04397','�����߾�.��⵵û.���ִ뿪ȯ�¼���','37.288454732776685','127.05138185376052','����',3);


insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('04396','�����߾�.��⵵û.���ִ뿪ȯ�¼���','37.288537908037156','127.05177379426947','��⵵������������� ���',4);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('04019','��⵵�������������','37.291135603390984','127.04516688665875','���������Ű����.�Ƹ��б� ���',5);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03123','���������Ű����.�Ƹ��б�','37.28707375972554','127.0400587889236','����',6);

--102��
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03015','������.�뺸�ڼ���','37.268212757868156','126.99956876164312','������.�ſ�ȸ������ȸ ���',7);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03039','������.�ſ�ȸ������ȸ','37.26734320504059','127.00338785976807','��깮��� ���',8);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03137','��깮���',' 37.27510882921343','127.0181954083477','�ΰ輱�����Ʈ ���',9);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03107','�ΰ輱�����Ʈ','37.27682782145644','127.03656077602773','â����.���ִ��б�.���Ű� ���',10);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03124','â����.���ִ��б�.���Ű�','37.280878404042944','127.04211057329069','���������Ű����.�Ƹ��б� ���',11);

insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03125','â����.���ִ��б�.���Ű�','37.280574302250706','127.04211322287942','�츸�ż�����Ʈ ���',12);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03110','�츸�ż�����Ʈ','37.27707546906844','127.03700627909338','�������� ���',13);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03142','��������','37.275313764757875','127.01852525914751','������.�ſ�ȸ������ȸ ���',14);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03038','������.�ſ�ȸ������ȸ','37.26894689758696','127.00704926536443','������.AK�ö��� ���',15);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03017','������.AK�ö���','37.26745362831417','127.00081455316372','����',16);

COMMIT;
--103��
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03090','������û��9���ⱸ.���ο��ݰ���','37.26296873108508','127.03252946353398','�ΰ跡�̾ȳ��Ŭ���� ���',17);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03170','�ΰ跡�̾ȳ��Ŭ����','37.26879104986174','127.0348629277089','������������Ʈ.�ΰ�Ｚ����Ʈ ���',18);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03103','������������Ʈ.�ΰ�Ｚ����Ʈ','37.270935284162796','127.03568132562151','����޸���� ���',19);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03172','����޸����','37.278291523233456','127.03810907484589','���������Ű����.�Ƹ��б� ���',20);

insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03173','����޸����','37.280127734188476','127.03703032535326','�ΰ�Ｚ����Ʈ.������������Ʈ ���',21);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03104','�ΰ�Ｚ����Ʈ.������������Ʈ','37.27110432574714','127.03536007826766','�ΰ跡�̾ȳ��Ŭ���� ���',22);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03169','�ΰ跡�̾ȳ��Ŭ����','37.26878891362191','127.03446550797491','������û��8���ⱸ.������ũ.�������� ���',23);
insert into tbl_station(Pk_station_id, station_name, lat, lng, way, zindex) values('03091','������û��8���ⱸ.������ũ.��������','37.263757169233','127.03243397754491','����',24);

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

--����������� ���̺�
create table tbl_car
(car_seq                  NUMBER                     --��������̵�                   
,fk_empid                 VARCHAR2(30)  not null           --�������
,car_num                  VARCHAR2(100)  not null                  --����
,car_kind                 VARCHAR2(100)  not null                  --�浵
,max_num                  NUMBER  not null                  --�浵
,constraint PK_tbl_car_car_seq primary key(car_seq)
,constraint FK_tbl_car_fk_empid foreign key(fk_empid) references tbl_employees(empid)
);


-- �Ϻ������������� ���̺�
create table tbl_day_share
(res_num                  NUMBER                      --��������̵�                   
,fk_car_seq               NUMBER  not null           --�������
,start_date               DATE  not null                  --����
,last_date                DATE  not null                  --�浵
,dp_add                   VARCHAR2(200)  not null                  --�浵
,dp_lat                   NUMBER  not null                  --�浵
,dp_lng                   NUMBER  not null                  --�浵
,ds_add                   VARCHAR2(200)  not null                  --�浵
,ds_lat                   NUMBER  not null                  --�浵
,ds_lng                   NUMBER  not null                  --�浵
,want_max                 NUMBER  not null                  --�浵
,st_fee                   NUMBER  not null                  --�浵
,end_status               NUMBER  not null                  --�浵
,cancel_status            NUMBER  not null                  --�浵
,constraint PK_tbl_day_share_res_num primary key(res_num)
,constraint FK_tbl_day_share_fk_car_seq foreign key(fk_car_seq) references tbl_car(car_seq)
);


-- �Ϻ�ž�½�û���� ���̺�
create table tbl_car_share
(pf_res_num             NUMBER                      --��������̵�                   
,pf_empid               VARCHAR2(30)  not null           --�������
,rshare_date            DATE  not null                  --����
,rdp_add                VARCHAR2(200)  not null                  --�浵
,rdp_lat                NUMBER  not null                  --�浵
,rdp_lng                NUMBER  not null                  --�浵
,rds_add                VARCHAR2(200)  not null                  --�浵
,rds_lat                NUMBER  not null                  --�浵
,rds_lng                NUMBER  not null                  --�浵
,share_fee              NUMBER  not null                  --�浵
,share_status           NUMBER  not null                  --�浵
,start_time             VARCHAR2(200)  not null                  --�浵
,end_time               VARCHAR2(200)                   --�浵
,cancel_status          DATE                   --�浵
,constraint PK_tbl_car primary key(pf_res_num,pf_empid)
,constraint FK_tbl_car_share_pf_res_num foreign key(pf_res_num) references tbl_day_share(res_num)
,constraint FK_tbl_car_share_pf_empid  foreign key(pf_empid) references tbl_employees(empid)
);

-- ��>
--------------- tbl_car
-- ���̺� �ּ���
comment on table tbl_car 
is '����� ���������� ����ִ� ���̺�';

comment on table tbl_day_share 
is '�Ϻ��������������� ����ִ� ���̺�';

comment on table tbl_car_share 
is '�Ϻ�ž�½�û������ ����ִ� ���̺�';

-- ���̺� �ּ��� Ȯ��
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
-- �÷��� �ּ���
comment on column tbl_car.car_seq is '����������ȣ'; 
comment on column tbl_car.fk_empid is '������̵�'; 
comment on column tbl_car.car_num is '����ȣ'; 
comment on column tbl_car.car_kind is '����'; 
comment on column tbl_car.max_num is '�ִ�ž���ο�'; 

--------------- tbl_car_share
-- �÷��� �ּ���
comment on column tbl_car_share.pf_res_num is '�����ȣ'; 
comment on column tbl_car_share.pf_empid is '������̵�'; 
comment on column tbl_car_share.rshare_date is 'ž������'; 
comment on column tbl_car_share.rdp_add is '������ּ�'; 
comment on column tbl_car_share.rdp_lat is '���������'; 
comment on column tbl_car_share.rdp_lng is '������浵'; 
comment on column tbl_car_share.rds_add is '�������ּ�'; 
comment on column tbl_car_share.rds_lat is '����������'; 
comment on column tbl_car_share.rds_lng is '�������浵'; 
comment on column tbl_car_share.share_fee is '���Һ��'; 
comment on column tbl_car_share.share_status is '���ο���'; 
comment on column tbl_car_share.start_time is '�����ð�'; 
comment on column tbl_car_share.end_time is '�����ð�'; 


--------------- tbl_day_share
-- �÷��� �ּ���
comment on column tbl_day_share.res_num is '�����ȣ'; 
comment on column tbl_day_share.fk_car_seq is '����������ȣ'; 
comment on column tbl_day_share.start_date is '������������'; 
comment on column tbl_day_share.last_date is '������������'; 
comment on column tbl_day_share.dp_add is '������ּ�'; 
comment on column tbl_day_share.dp_lat is '���������'; 
comment on column tbl_day_share.dp_lng is '������浵'; 
comment on column tbl_day_share.ds_add is '�������ּ�'; 
comment on column tbl_day_share.ds_lat is '����������'; 
comment on column tbl_day_share.ds_lng is '�������浵'; 
comment on column tbl_day_share.want_max is '����'; 
comment on column tbl_day_share.st_fee is '����'; 
comment on column tbl_day_share.end_status is '��������'; 
comment on column tbl_day_share.cancel_status is '��ҿ���'; 

-- �÷��� �ּ��� Ȯ��
select column_name, comments
from user_col_comments
where table_name = 'tbl_car';

-- �÷��� �ּ��� Ȯ��
select column_name, comments
from user_col_comments
where table_name = 'tbl_car_share';

-- �÷��� �ּ��� Ȯ��
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
where bus_no = '101��'
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
            bus_no = '101��'
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
where bus_no = '103��'
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