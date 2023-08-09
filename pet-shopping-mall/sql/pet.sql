--==============================
-- 관리자 계정 - pet 계정 생성
--==============================

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
    reg_date date default sysdate,
    address varchar2(500),
    birthday date,
    member_role varchar(20) default 'ROLE_USER' not null,
    point number default 0,
    field char(1),
    constraints pk_member_id primary key(id),
    constraints uq_member_member_id unique (member_id)
);

-- qna 질문 테이블
create table question(
    id number,
    member_id varchar2(20),
    title varchar2(500),
    content varchar2(4000),
    reg_date date default sysdate,
    constraints pk_question_id primary key(id),
    constraints fk_question_member_writer foreign key(member_id) references member(member_id) on delete cascade
);

-- qna 답변 테이블
create table answer(
   id number,
   admin_name varchar2(20) default '관리자',
   question_id number,
   content varchar2(4000),
   reg_date date default sysdate,
   constraints pk_answer_id primary key(id),
   constraints fk_answer_question_id foreign key (question_id) references question(id) on delete cascade
);

create sequence seq_member_id;
create sequence seq_answer_id;
create sequence seq_question_id;

select * from member;
select * from question;
select * from answer;

--drop table member;
--drop table question;
--drop table answer;

--drop sequence seq_member_id;
--drop sequence seq_answer_id;
--drop sequence seq_question_id;

------------------ member insert ---------------------------
insert into member (id, member_id, password, name, phone, email, address, birthday, member_role, point, field)
values (seq_member_id.nextval, 'member1', '1234', '김상훈', '01012345678', 'kim@naver.com', '서울시 송파구 석촌동', to_date('1990-01-01', 'YYYY-MM-DD'), 'ROLE_USER', 10000, 'N');

insert into member (id, member_id, password, name, phone, email, address, birthday, member_role, point, field)
values (seq_member_id.nextval, 'admin', '1234', '관리자', '01011112222', 'admin@naver.com', '서울시 강남구 역삼동', to_date('1990-01-01', 'YYYY-MM-DD'), 'ROLE_ADMIN', 10000, 'Y');

------------------ qna insert ---------------------------
insert into question (id, title, member_id, content, reg_date)
values (seq_question_id.nextval, '우동친이 머에요?', 'member1', '우동친이 먼가요???? 우동친이 먼가요???? 우동친이 먼가요???? 우동친이 먼가요????', to_date('18/02/14', 'rr/mm/dd'));
insert into question (id, title, member_id, content, reg_date)
values (seq_question_id.nextval, '배가 고파요', 'member1', '배가 고프다', to_date('18/02/14', 'rr/mm/dd'));

------------------ answer insert ---------------------------
insert into answer (id, admin_name, question_id, content, reg_date)
values (seq_member_id.nextval, '관리자', 1, '우동친은 우리집동물친구의 줄임말입니다~', sysdate);
insert into answer (id, admin_name, question_id, content, reg_date)
values (seq_member_id.nextval, '관리자', 2, '배고프면 밥을 드세요', sysdate);


delete from answer where id = '3';
