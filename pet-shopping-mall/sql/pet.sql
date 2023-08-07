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
    phone char(20) not null,
    email varchar2(200),
    reg_date date default sysdate,
    address varchar(100),
    birthday date,
    member_role varchar(20) default 'ROLE_USER' not null,
    point number default 0,
    field char(1),
    constraints pk_member_id primary key(id),
    constraints ck_member_field check(field in ('Y', 'N'))
);

-- qna 질문 테이블
create table question(
    id number,
    member_id number,
    title varchar(50),
    content varchar(4000),
    reg_date date default sysdate,
    constraints pk_question_id primary key(id),
    constraints fk_question_member_id foreign key(member_id) references member(id) on delete cascade
);

-- qna 답변 테이블
create table answer(
   id number,
   member_id number,
   question_id number,
   content varchar2(4000),
   reg_date date default sysdate,
   constraints pk_answer_id primary key(id),
   constraints fk_answer_question_id foreign key (question_id) references question(id) on delete cascade,
   constraints fk_answer_member_id foreign key(member_id) references member(id) on delete cascade
);

create sequence seq_member_id;
create sequence seq_answer_id;
create sequence seq_question_id;

select * from question;
select * from answer;