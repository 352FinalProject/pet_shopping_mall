--==============================
-- 관리자 계정 - pet 계정 생성
--==============================
create user pet
identified by pet
default tablespace users;

grant connect, resource to pet;

grant create session,
grant create table to pet;

alter user pet quota unlimited on users;

alter session set "_oracle_script" = true;
create user pet
identified by pet
default tablespace users;


grant connect, resource to pet;

grant create session to pet;
grant create table to pet;

alter user pet quota unlimited on users;

-- 멤버 테이블
create table member (
    id number,
    member_id varchar2(20),
    password varchar2(300) not null,
    name varchar2(50) not null,
    phone varchar2(11) not null,
    email varchar2(200),
    enroll_date timestamp default sysdate,
    address varchar2(500),
    birthday timestamp,
    member_role varchar(20) default 'ROLE_USER' not null,
    point number default 0,
    field char(1),
    constraints pk_member_id primary key(id),
    constraints uq_member_member_id unique (member_id)
);

-- qna 질문 테이블
create table question (
    question_id number,
    question_member_id varchar2(20),
    question_category varchar2(50),
    question_email varchar2(200),
    question_title varchar2(500),
    question_content varchar2(4000),
    question_created_at timestamp default sysdate,
    constraints pk_question_id primary key(question_id),
    constraints fk_question_member_id foreign key(question_member_id) references member(member_id) on delete cascade
);

-- qna 답변 테이블
create table answer(
   answer_id number,
   answer_admin_name varchar2(20) default '관리자',
   answer_question_id number,
   answer_content varchar2(4000),
   answer_created_at timestamp default sysdate,
   constraints pk_answer_id primary key(answer_id),
   constraints fk_answer_question_id foreign key (answer_question_id) references question(question_id) on delete cascade
);

-- 파일 테이블
create table image_attachment (
    image_id number,
    image_type number,
    image_category char(1),
    image_original_filename varchar2(500),
    image_renamed_filename varchar2(500),
    image_file_size number,
    image_created_at timestamp default systimestamp,
    constraint pk_image_attachment_id primary key(image_id)
);

-- 포인트 테이블
create table point (
    point_id number,
    point_member_id varchar2(20),
    point_current number,
    point_type varchar2(100),
    point_amount number not null,
    point_date timestamp default sysdate,
    constraint pk_point_id primary key (point_id),
    constraint fk_point_member_id foreign key (point_member_id) references member(member_id)
);

create sequence seq_member_id;
create sequence seq_answer_answer_id;
create sequence seq_question_question_id;
create sequence seq_image_attachment_image_id;
create sequence seq_point_point_id;

select * from member;
select * from question;
select * from answer;
select * from point;
select * from image_attachment;

--drop table member;
--drop table question;
--drop table answer;
--drop table point;
--drop table image_attachment;
--
--drop sequence seq_member_id;
--drop sequence seq_answer_answer_id;
--drop sequence seq_question_question_id;
--drop sequence seq_point_point_id;
--drop sequence seq_image_attachment_image_id;

------------------ member insert ---------------------------
insert into member (id, member_id, password, name, phone, email, enroll_date, address, birthday, member_role, point, field)
values (seq_member_id.nextval, 'member1', '1234', '김상훈', '01012345678', 'kim@naver.com', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 
'서울시 송파구 석촌동', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'ROLE_USER', 10000, 'N');

insert into member (id, member_id, password, name, phone, email, enroll_date, address, birthday, member_role, point, field)
values (seq_member_id.nextval, 'admin', '1234', '관리자', '01011112222', 'admin@naver.com', to_date('1990-01-01', 'YYYY-MM-DD'), 
'서울시 강남구 역삼동', to_date('1990-01-01', 'YYYY-MM-DD'), 'ROLE_ADMIN', 10000, 'Y');

------------------ qna insert ---------------------------
insert into question (question_id, question_title, question_category, question_member_id, question_email, question_content, question_created_at)
values (seq_question_question_id.nextval, '우동친이 머에요?', '상품' ,'member1', 'kh@naver.com', '우동친이 먼가요???? 우동친이 먼가요???? 우동친이 먼가요???? 우동친이 먼가요????', to_date('18/02/14', 'rr/mm/dd'));
insert into question (question_id, question_title, question_category, question_member_id, question_email, question_content, question_created_at)
values (seq_question_question_id.nextval, '배가 고파요', '배송', 'member1', 'kh@daum.net', '배가 고프다', to_date('18/02/14', 'rr/mm/dd'));

------------------ answer insert ---------------------------
insert into answer (answer_id, answer_admin_name, answer_question_id, answer_content, answer_created_at)
values (seq_answer_answer_id.nextval, '관리자', 1, '우동친은 우리집동물친구의 줄임말입니다~', sysdate);

insert into answer (answer_id, answer_admin_name, answer_question_id, answer_content, answer_created_at)
values (seq_answer_answer_id.nextval, '관리자', 2, '배고프면 밥을 드세요', sysdate);

------------------ point insert ---------------------------
insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date)
values (seq_point_point_id.nextval, 'member1', 1000, '적립', 500, to_date('2023-08-09', 'yyyy-mm-dd'));

insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date)
values (seq_point_point_id.nextval, 'member1', 800, '사용', -200, to_date('2023-08-09', 'yyyy-mm-dd'));


