DROP USER hospital cascade;

drop tablespace hostp_tbs
    including contents and datafiles;
    
create tablespace hostp_tbs datafile 'C:\oraclexe\app\oracle\oradata\XE\hospitaldb.dbf' size 20m;

create user hospital
identified by hospital
default tablespace hostp_tbs
temporary tablespace temp
profile default;

grant connect, resource to hospital;
grant create view, create synonym to hospital;

alter user hospital account unlock;

drop table Doctors;

create table Doctors (
    순서 number(4),
    doc_id number(10) not null,
    major_treat varchar2(25) not null,
    doc_name varchar2(20) not null,
    doc_gen char(1) not null,
    doc_phone varchar2(15) null,
    doc_email varchar2(50) unique,
    doc_position varchar2(20) not null
);

alter table Doctors
    add constraint doc_id_pk primary key (doc_id);

create sequence doc_seq
    start with 1
    increment by 1;

insert into doctors 
    values(doc_seq.nextval, 980312, '소아과', '이태정', 'M', '010-333-1340', 'ltj@hanbh.com', '과장');
insert into doctors 
    values(doc_seq.nextval, 000601, '내과', '안성기', 'M', '011-222-0987', 'ask@hanbh.com', '과장');
insert into doctors 
    values(doc_seq.nextval, 001208, '외과', '김민종', 'M', '010-333-8743', 'kmj@han.com', '과장');
insert into doctors 
    values(doc_seq.nextval, 020403, '피부과', '이태서', 'M', '019-777-3764', 'lts@hanbh.com', '과장');
insert into doctors 
    values(doc_seq.nextval, 050900, '소아과', '김연아', 'F', '010-555-3746', 'kya@hanbh.com', '전문의');
insert into doctors 
    values(doc_seq.nextval, 050101, '내과', '차태현', 'M', '011-222-7643', 'cth@hanbh.com', '전문의');
insert into doctors 
    values(doc_seq.nextval, 062019, '소아과', '전지현', 'F', '010-999-1265', 'jjh@hanbh.com', '전문의');
insert into doctors 
    values(doc_seq.nextval, 070576, '피부과', '홍길동', 'M', '016-333-7263', 'hgd@hanbh.com', '전문의');
insert into doctors 
    values(doc_seq.nextval, 080543, '방사선과', '유재석', 'M', '010-222-1263', 'yjs@hanbh.com', '과장');
insert into doctors 
    values(doc_seq.nextval, 091001, '외과', '김병만', 'M', '010-555-3542', 'kbm@hanbh.com', '전문의');

select * from doctors;


drop table nurses;

create table Nurses (
    순서 number(4),
    nur_id number(10) not null,
    major_job varchar2(25) not null,
    nur_name varchar2(20) not null,
    nur_gen char(1) not null,
    nur_phone varchar2(15) null,
    nur_email varchar2(50) unique,
    nur_position varchar2(20) not null
);

alter table Nurses
    add constraint nur_id_pk primary key (nur_id);

create sequence nur_seq 
    start with 1
    increment by 1;

insert into nurses 
    values(nur_seq.nextval, 050302, '소아과', '김은영', 'F', '010-555-8751', 'key@hanbh.com', '수간호사');
insert into nurses 
    values(nur_seq.nextval, 050021, '내과', '윤성애', 'F', '016-333-8745', 'ysa@hanbh.com', '수간호사');
insert into nurses 
    values(nur_seq.nextval, 040089, '피부과', '신지원', 'M', '010-666-7646', 'sjw@hanbh.com', '주임');
insert into nurses 
    values(nur_seq.nextval, 070605, '방사선과', '유정화', 'F', '010-333-4588', 'yjh@hanbh.com', '주임');
insert into nurses 
    values(nur_seq.nextval, 070804, '내과', '라하나', 'F', '010-222-1340', 'nhn@hanbh.com', '주임');
insert into nurses 
    values(nur_seq.nextval, 071018, '소아과', '김화경', 'F', '019-888-4116', 'khk@hanbh.com', '주임');
insert into nurses 
    values(nur_seq.nextval, 100356, '소아과', '이선용', 'M', '010-777-1234', 'lsy@hanbh.com', '간호사');
insert into nurses 
    values(nur_seq.nextval, 104145, '외과', '김현', 'M', '010-999-8520', 'kh@hanbh.com', '간호사');
insert into nurses 
    values(nur_seq.nextval, 120309, '피부과', '박성완', 'M', '010-777-4996', 'psw@hanbh.com', '간호사');
insert into nurses 
    values(nur_seq.nextval, 130211, '외과', '이서연', 'F', '010-222-3214', 'lsy2@hanbh.com', '간호사');

    
drop table patients;
    
create table Patients (
    순서 number(4),
    pat_id number(10) not null,
    nur_id number(10) not null,
    doc_id number(10) not null,
    pat_name varchar2(20) not null,
    pat_gen char(1) not null,
    pat_jumin varchar2(14) not null,
    pat_addr varchar2(100) not null,
    pat_phone varchar2(15) null,
    pat_email varchar2(50) unique,
    pat_job varchar2(20) not null
);

alter table Patients
    add constraint pat_id_pk primary key (pat_id);

alter table Patients
    add (constraint R_2 foreign key (doc_id) references Doctors (doc_id));
    
alter table Patients
    add (constraint R_3 foreign key (nur_id) references Nurses (nur_id));

create sequence pat_seq 
    start with 1
    increment by 1;

insert into patients 
    values(pat_seq.nextval, 2345, 050302, 980312, '안상건', 'M', 232345, '서울', '010-555-7845', 'ask@ab.com', '회사원');
insert into patients 
    values(pat_seq.nextval, 3545, 040089, 020403, '김성룡', 'M', 543545, '서울', '010-333-7812', 'ksr@bb.com', '자영업');
insert into patients 
    values(pat_seq.nextval, 3424, 070605, 080543, '이종진', 'M', 433424, '부산', '019-888-4859', 'ljj@ab.com', '회사원');
insert into patients 
    values(pat_seq.nextval, 7675, 100356, 050900, '최광석', 'M', 677675, '당진', '010-222-4847', 'cks@cc.com', '회사원');
insert into patients 
    values(pat_seq.nextval, 4533, 070804, 000601, '정한경', 'M', 744533, '강릉', '010-777-9630', 'jhk@ab.com', '교수');
insert into patients 
    values(pat_seq.nextval, 5546, 120309, 070576, '유원현', 'M', 765546, '대구', '016-777-0214', 'ywh@cc.com', '자영업');
insert into patients 
    values(pat_seq.nextval, 4543, 070804, 050101, '최재정', 'M', 454543, '부산', '010-555-4187', 'cjj@bb.com', '회사원');
insert into patients 
    values(pat_seq.nextval, 9768, 130211, 091001, '이진희', 'F', 119768, '서울', '010-888-3675', 'ljh@ab.com', '교수');
insert into patients 
    values(pat_seq.nextval, 4234, 130211, 091001, '오나미', 'F', 234234, '속초', '010-999-6541', 'onm@cc.com', '학생');
insert into patients 
    values(pat_seq.nextval, 7643, 071018, 062019, '송성묵', 'M', 987643, '서울', '010-222-5874', 'ssm@bb.com', '학생');

    
drop table treatments;
    
create table Treatments (
    순서 number(4),
    treat_id number(15) not null,
    pat_id number(10) not null,
    doc_id number(10) not null,
    treat_contents varchar2(1000) not null,
    treat_date date not null
);

alter table Treatments
    add constraint treat_pat_doc_id_pk primary key (treat_id, pat_id, doc_id);

alter table Treatments
    add (constraint R_5 foreign key (pat_id) references Patients (pat_id));
    
alter table Treatments
    add (constraint R_6 foreign key (doc_id) references Doctors (doc_id));

create sequence tre_seq
    start with 1
    increment by 1;

insert into treatments 
    values(tre_seq.nextval, 130516023, 2345, 980312, '감기, 몸살', to_date('2013-05-16', 'YYYY-MM-DD'));
insert into treatments 
    values(tre_seq.nextval, 130628100, 3545, 020403, '피부 트러블 치료', to_date('2013-06-28', 'YYYY-MM-DD'));
insert into treatments 
    values(tre_seq.nextval, 131205056, 3424, 080543, '목 디스크로 MRI 촬영', to_date('2013-12-05', 'YYYY-MM-DD'));
insert into treatments 
    values(tre_seq.nextval, 131218024, 7675, 050900, '중이염', to_date('2013-12-18', 'YYYY-MM-DD'));
insert into treatments 
    values(tre_seq.nextval, 131224012, 4533, 000601, '장염', to_date('2013-12-24', 'YYYY-MM-DD'));
insert into treatments 
    values(tre_seq.nextval, 140103001, 5546, 070576, '여드름 치료', to_date('2014-01-03', 'YYYY-MM-DD'));
insert into treatments 
    values(tre_seq.nextval, 140109026, 4543, 050101, '위염', to_date('2014-01-09', 'YYYY-MM-DD'));
insert into treatments 
    values(tre_seq.nextval, 140226102, 9768, 091001, '화상치료', to_date('2014-02-26', 'YYYY-MM-DD'));
insert into treatments 
    values(tre_seq.nextval, 140303003, 4234, 091001, '교통사고 외상치료', to_date('2014-03-03', 'YYYY-MM-DD'));
insert into treatments 
    values(tre_seq.nextval, 140308087, 7643, 062019, '장염', to_date('2014-03-08', 'YYYY-MM-DD'));


drop table charts;

create table Charts (
    순서 number(4),
    chart_id varchar2(20) not null,
    treat_id number(15) not null,
    doc_id number(10) not null,
    pat_id number(10) not null,
    nur_id number(10) not null,
    chart_contents varchar2(1000) not null
);

alter table Charts
    add constraint chart_treat_doc_pat_id_pk primary key (chart_id, treat_id, doc_id, pat_id);
    
alter table Charts
    add (constraint R_4 foreign key (nur_id) references Nurses (nur_id));
    
alter table Charts
    add (constraint R_7 foreign key (treat_id, pat_id, doc_id) references Treatments (treat_id, pat_id, doc_id));
 
create sequence cha_seq
    start with 1
    increment by 1;

insert into charts 
    values(cha_seq.nextval, 'p_130516023', 130516023, 980312, 2345, 050302, '감기 주사 및 약 처방');
insert into charts 
    values(cha_seq.nextval, 'd_130628100', 130628100, 020403, 3454, 040089, '피부 감염 방지 주사');
insert into charts 
    values(cha_seq.nextval, 'r_131205056', 131205056, 080543, 3424, 070605, '주사처방');
insert into charts 
    values(cha_seq.nextval, 'p_131218024', 131218024, 050900, 7675, 100356, '귓속청소 및 약 처방');
insert into charts 
    values(cha_seq.nextval, 'i_131224012', 131224012, 000601, 4533, 070804, '장염 입원치료');
insert into charts 
    values(cha_seq.nextval, 'd_140103001', 140103001, 070576, 5546, 120309, '여드름 치료약 처방');
insert into charts 
    values(cha_seq.nextval, 'i_140109026', 140109026, 050101, 4543, 070804, '위내시경');
insert into charts 
    values(cha_seq.nextval, 's_140226102', 140226102, 091001, 9768, 130211, '화상 크림약 처방');
insert into charts 
    values(cha_seq.nextval, 's_140303003', 140303003, 091001, 4234, 130211, '입원치료');
insert into charts 
    values(cha_seq.nextval, 'p_140308087', 140308087, 062019, 7643, 071018, '장염 입원치료');

select * from charts;
select * from doctors;
select * from nurses;
select * from treatments;
select * from patients;

commit;


