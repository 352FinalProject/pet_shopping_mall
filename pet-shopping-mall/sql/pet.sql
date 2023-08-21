--==============================
-- 관리자 계정 - pet 계정 생성
--==============================
alter session set "_oracle_script" = true;

create user pet
identified by pet
default tablespace users;

grant connect, resource to pet;

alter user pet quota unlimited on users;

grant create session,
grant create table to pet;

-- 모든 테이블 조회
SELECT *  FROM all_tables;

--==============================
-- 초기화 블럭
--==============================
--
--drop table review;
--drop table image_attachment;
--drop table image_attachment_mapping;
--drop table answer;
--drop table question;
--drop table point;
--drop table discount_rule;
--drop table product_category;
--drop table product;
--drop table product_option;
--drop table product_detail;
--drop table cart;
--drop table payment;
--drop table cartitem;
--drop table orderTbl;
--drop table order_detail;
--drop table refund;
--drop table cancel_order;
--drop table authority;
--drop table community;
--drop table wishlist;
--drop table pet;
--drop table persistent_logins;
--drop table image_attachment_mapping;
--drop table member;
--drop table ordertbl;
--drop table return;
--drop table terms;
--drop table terms_history;
--drop table chat;
--drop table chat_room;
--
---- 외래키 붙어있는 테이블삭제
--drop table member cascade constraints;
--drop table review cascade constraints;
--drop table product cascade constraints;
--drop table product_detail cascade constraints;
--drop table pet cascade constraints;
--drop table breed cascade constraints;
--drop table order_detail cascade constraints;
--
--drop sequence seq_question_id;
--drop sequence seq_answer_id;
--drop sequence seq_image_attachment_id;
--drop sequence seq_image_attachment_mapping_id;
--drop sequence seq_point_id;
--drop sequence seq_product_category_id;
--drop sequence seq_product_id;
--drop sequence seq_product_option_id;
--drop sequence seq_product_detail_id;
--drop sequence seq_cart_id;
--drop sequence seq_payment_id;
--drop sequence seq_cartitem_id;
--drop sequence seq_ordertbl_id;
--drop sequence seq_refund_id;
--drop sequence seq_cancel_order_id;
--drop sequence seq_authority_id;
--drop sequence seq_community_id;
--drop sequence seq_wishlist_id;
--drop sequence seq_pet_id;
--drop sequence seq_persistent_logins_id;
--drop sequence seq_member_id;
--drop sequence seq_review_id;
--drop sequence seq_chat_id;
--drop sequence seq_chat_room_id;
--drop sequence seq_cancel_id;
--drop sequence seq_history_id;
--drop sequence seq_terms_id;

--==============================
-- 테이블 생성
--==============================

-- 멤버 테이블
create table member (
    member_id varchar2(20),
    password varchar2(300) not null,
    name varchar2(50) not null,
    phone varchar2(11),
    email varchar2(200),
    enroll_date timestamp default systimestamp,
    address varchar2(500),
    birthday timestamp,
    subscribe char(1) default 'N' not null,
    constraints pk_member_id primary key(member_id)
);

-- 권한 테이블
create table authority(
    member_id varchar2(20),
    auth varchar2(50) default 'ROLE_USER',
    constraints pk_authority primary key(member_id, auth),
    constraints fk_authority_member_id foreign key(member_id)
                references member(member_id)
                on delete cascade
);

-- 펫 테이블
CREATE TABLE pet (
    pet_id number,
    member_id varchar2(20),
    pet_name VARCHAR2(50) NOT NULL,
    pet_DofB timestamp,
    pet_kind VARCHAR2(50),
    pet_breed VARCHAR2(50),
    pet_adoption timestamp,
    pet_gender CHAR(1),
    constraints pk_pet_id primary key(pet_id),
    constraints fk_pet_member_id foreign key(member_id) references member(member_id) on delete cascade,

    CONSTRAINT chk_pet_gender CHECK (pet_gender IN ('M', 'F'))
);

-- 품종 테이블
CREATE TABLE breed (
    breed_id number,
    pet_kind VARCHAR2(50),
    pet_breed VARCHAR2(50),
    CONSTRAINT chk_pet_breed CHECK (pet_breed IN ('C', 'D', 'E'))
);

-- qna 질문 테이블
create table question(
    question_id number,
    question_member_id varchar2(20) not null,
    question_category varchar2(50) not null,
    question_email varchar2(200),
    question_title varchar2(500) not null,
    question_content varchar2(4000) not null,
    question_created_at timestamp default systimestamp,
    constraints pk_question_id primary key(question_id),
    constraints fk_question_member_id foreign key(question_member_id) references member(member_id) on delete cascade
);

-- qna 답변 테이블
create table answer(
   answer_id number,
   answer_admin_name varchar2(20) default '관리자',
   answer_question_id number not null,
   answer_content varchar2(4000) not null,
   answer_created_at timestamp default systimestamp,
   constraints pk_answer_id primary key(answer_id),
   constraints fk_answer_question_id foreign key (answer_question_id) references question(question_id) on delete cascade
);

-- 이미지 파일 테이블
create table image_attachment (
    image_id number,
    image_type number not null,
    image_category char(1),
    image_original_filename varchar2(500),
    image_renamed_filename varchar2(500),
    image_file_size number,
    image_created_at timestamp default systimestamp,
    constraint pk_image_attachment_id primary key(image_id)
);

-- 이미지 파일 매핑 테이블
create table image_attachment_mapping (
    mapping_id number,
    ref_table varchar2(50) not null,
    ref_id number not null,
    image_id number not null,
    constraint pk_question_image_mapping_id primary key(mapping_id),
    constraint fk_image_id foreign key(image_id) references image_attachment(image_id) on delete cascade
);

-- 상품 카테고리 테이블
create table product_category (
    category_id number, -- pk
    category_name varchar2(100) not null,
    constraints pk_category_id primary key(category_id)
);

-- 상품 테이블
create table product (
    product_id number, -- pk
    category_id number, -- fk
    product_name varchar2(200) not null,
    product_price number not null,
    thumbnail_img number, -- 썸네일 이미지(fk)
    product_img number, -- 제품상세 이미지(fk)
    create_date timestamp default sysdate, -- 등록일
    expire_date timestamp default null, -- 유통기한
    like_cnt number default 0, -- 좋아요수
    view_cnt number default 0, -- 조회수
    constraints pk_product_id primary key(product_id),
    constraints fk_category_id foreign key(category_id) references product_category(category_id) on delete cascade
);

-- 상품 옵션 테이블
create table product_option (
    option_id number, -- pk
    product_id number, -- fk
    option_name varchar2(100), -- 옵션명(option은 예약어라 사용불가) (사이즈)
    option_value varchar2(200), -- 옵션속성 (S, M, L)
    constraints pk_option_id primary key(option_id),
    constraints fk_product_id foreign key(product_id) references product(product_id) on delete cascade
);
-- 상품상세 테이블
create table product_detail (
    product_detail_id number, -- pk
    option_id number, -- fk
    additional_price number default 0, -- 옵션에 따른 추가금
    stock number default 0,
    sale_state number default 0, -- 0: 판매대기, 1: 판매중, 2: 품절, 3: 기타 
    constraints pk_product_detail_id primary key(product_detail_id),
    constraints fk_option_id foreign key(option_id) references product_option(option_id) on delete cascade
);

-- 주문테이블
-- order 가 오라클 예약어여서 테이블명 이렇게 했습니다.
-- order_no : 230814(날짜)-001 이런식으로 만들거여서 varchar2
create table orderTbl (
    order_id number,
    order_no varchar2(20) not null,
    member_id varchar2(50),
    order_date timestamp default systimestamp not null,
    order_status number default 0 not null,
    payment_status number default 0,
    total_price number not null,
    delivery_fee number default 3000 not null,
    discount number default 0,
    amount number not null,
    discount_code varchar2(20),
    constraint pk_order_id primary key(order_id),
    constraint fk_orderTbl_member_id foreign key(member_id) references member(member_id) on delete cascade
);

-- 포인트 테이블
create table point (
    point_id number,
    point_member_id varchar2(20) not null,
    point_current number not null,
    point_type varchar2(100) not null,
    point_amount number not null,
    point_date timestamp default systimestamp,
    review_id number
    constraint pk_point_id primary key (point_id),
    constraint fk_point_member_id foreign key (point_member_id) references member(member_id) on delete cascade,
    constraint fk_point_review_id foreign key (review_id) references review(review_id) on delete cascade;
);

create table cancel_order (
    cancel_id number,
    request_date timestamp default systimestamp not null,
    receipt_date timestamp,
    cancel_status number default 0 not null,
    order_id number,
    constraint pk_cancel_id primary key(cancel_id),
    constraint fk_cancel_order_id foreign key(order_id) references orderTbl(order_id) on delete cascade

);

-- 대충 시큐리티 테이블 없으면 오류남
create table persistent_logins (
    username varchar(64) not null,
    series varchar(64) primary key, -- pk
    token varchar(64) not null, -- username, password, expiry time을 hasing한 값
    last_used timestamp not null
);

-- 주문상세 테이블
create table order_detail (
    order_id number,
    product_detail_id number,
    quantity number default 1 not null,
    constraint pk_order_detail primary key (order_id, product_detail_id),
    constraint fk_order_id foreign key (order_id) references orderTbl(order_id) on delete cascade,
    constraint fk_product_detail_id foreign key (product_detail_id) references product_detail(product_detail_id) on delete cascade
);

-- 찜한 목록 테이블
create table wishlist(
    wishlist_id number,
    wishlist_member_id varchar2(20),
    wishlist_product_id number,
    wishlist_created_at timestamp default systimestamp,
    constraints pk_wishlist_id primary key(wishlist_id),
    constraints fk_wishlist_member_id foreign key(wishlist_member_id) references member(member_id) on delete cascade,
    constraints fk_wishlist_product_id foreign key(wishlist_product_id) references product(product_id) on delete cascade
);

-- 리뷰테이블
create table review (
    review_id number,
    pet_id number,
    order_id number,
    review_member_id varchar(20) not null,
    product_detail_id number,
    review_title varchar2(50),
    review_content varchar2(3000),
    review_star_rate number default 1 not null,
    review_created_at timestamp default systimestamp,
    constraint pk_review_id primary key(review_id),
    constraint fk_pet_id foreign key(pet_id) references pet(pet_id) on delete cascade,
    constraint fk_review_member_id foreign key(review_member_id) references member(member_id) on delete cascade,
    constraint fk_order_detail_id foreign key (order_id, product_detail_id) references order_detail(order_id, product_detail_id) on delete cascade,
    constraint ck_review_review_star_rate check(review_star_rate >= 1 and review_star_rate <= 5)
);

create table community (
    community_id number,
    community_member_id varchar2(50),
    community_title varchar2(500),
    community_content varchar2(4000),
    community_created_at timestamp default systimestamp,
    constraint pk_community_id primary key(community_id),
    constraint fk_community_member_id foreign key(community_member_id) references member(member_id) on delete cascade
);

create table payment (
    payment_id number,
    payment_method number not null,
    payment_date timestamp default systimestamp not null,
    amount number not null,
    order_id number,
    constraint pk_payment_id primary key(payment_id),
    constraint fk_payment_order_id foreign key(order_id) references orderTbl(order_id) on delete cascade
);

-- 반품테이블
-- create table return (
--     return_id number,
--     return_status number default 0 not null,
--     request_date timestamp default systimestamp not null,
--     receipt_date timestamp,
--     withdraw_data timestamp,
--     order_id number,
--     constraint pk_return_id primary key(return_id),
--     constraint fk_return_order_id foreign key(order_id) references orderTbl(order_id) on delete cascade
-- );

-- 환불테이블
-- create table refund (
--     refund_id number,
--     receipt_date timestamp default systimestamp not null,
--     complete_date timestamp,
--     refund_status number default 0 not null,
--     refund_price number not null,
--     refund_method number not null,
--     refund_account varchar2(20),
--     account_name varchar2(20),
--     bank varchar2(20),
--     order_id number,
--     constraint pk_refund_id primary key(refund_id),
--     constraint fk_refund_order_id foreign key(order_id) references orderTbl(order_id) on delete cascade
-- );

create table cart (
    cart_id number,
    member_id varchar2(50),
    constraint pk_cart_id primary key(cart_id),
    constraint fk_cart_member_id foreign key(member_id) references member(member_id) on delete cascade
);

create table cartitem (
    cartitem_id number,
    cart_id number,
    product_detail_id number not null,
    quantity number default 1 not null,
    constraint pk_cartitem_id primary key(cartitem_id),
    constraint fk_cartitem_cart_id foreign key(cart_id) references cart (cart_id)
);

-- 약관 테이블
create table  terms (
 history_id number,
 terms_id number,
 member_id varchar2(50),
 accept_yn char(1) not null,
 accept_date timestamp default systimestamp not null,
 constraint pk_history_id primary key(history_id, terms_id),
 constraint fk_terms_member_id foreign key(member_id) references member(member_id),
 constraint unique_terms_id unique(terms_id)
);

-- 약관동의 이력 테이블
create table terms_history (
 terms_id number,
 title varchar2(50),
 content varchar2(200),
 required char(1) not null,
 constraint pk_terms_id primary key(terms_id),
 constraint fk_terms_history_terms_id FOREIGN KEY (terms_id) REFERENCES terms(terms_id)
);

-- 채팅방 테이블
create table chat_room (
 chat_room_id varchar2(20) not null,
 chat_room_member_id varchar2(50) not null,
 chat_room_admin_roll varchar2(20) not null,
 chat_room_created_at timestamp default systimestamp not null,
 constraint pk_chat_room_id primary key(chat_room_id),
 constraint fk_chat_room_chat_room_member_id foreign key(chat_room_member_id) references member(member_id) on delete cascade
);

-- 채팅 로그 테이블
create table chat (
 chat_id number,
 chat_room_id varchar2(20) not null,
 chat_member_id varchar2(50) not null,
 chat_message varchar2(4000) not null,
 chat_created_at timestamp default systimestamp not null,
 chat_unread_count number,
 constraint pk_chat_id primary key(chat_id),
 constraint fk_chat_room_id foreign key (chat_room_id) references chat_room(chat_room_id) on delete cascade
);

create sequence seq_orderTbl_id;
create sequence seq_member_id;
create sequence seq_answer_id;
create sequence seq_question_id;
create sequence seq_image_attachment_id;
create sequence seq_image_attachment_mapping_id;
create sequence seq_point_id;
create sequence seq_pet_id;
create sequence seq_wishlist_id;
create sequence seq_product_category_id;
create sequence seq_product_id;
create sequence seq_product_option_id;
create sequence seq_product_detail_id;
create sequence seq_review_id;
create sequence seq_payment_id;
create sequence seq_cancel_id;
create sequence seq_cart_id;
create sequence seq_cartitem_id;
create sequence seq_chat_id;
create sequence seq_chat_room_id;
create sequence seq_terms_id;
create sequence seq_history_id;

select * from orderTbl order by order_id desc;
select * from point order by point_id desc;
select * from discount_rule;
select * from member;
select * from question;
select * from answer;
select * from product;
select * from image_attachment;
select * from image_attachment_mapping;
select * from authority;
select * from pet;
select * from review order by review_id desc;
select * from terms;
select * from terms_history;

-- 회원가입시 자동으로 장바구니가 생성되는 트리거
create or replace trigger cart_create_trriger
after insert on member
for each row
begin
    insert into cart(cart_id, member_id) values(seq_cart_id.nextval, :NEW.member_id);
end;
/