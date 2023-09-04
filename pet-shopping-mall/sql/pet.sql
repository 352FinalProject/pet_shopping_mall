--==============================
-- 관리자 계정 - pet 계정 생성
--==============================
alter session set "_oracle_script" = true;

create user pet
identified by pet
default tablespace users;

grant connect, resource to pet;

grant unlimited tablespace to pet;

grant create session,
grant create table to pet;

-- 모든 테이블 조회
SELECT *  FROM all_tables;

select * from member;
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
--drop table product_detail;
--drop table cart;
--drop table payment;
--drop table cartitem;
--drop table orderTbl;
--drop table order_detail;
--drop table refund;
--drop table cancel_order;
--drop table authority;
--drop table product_category;
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
--drop table breed;
--drop table coupon;
--drop table member_coupon;
--drop table sub_member;
--drop table sub_payment;
--drop table image_attachment;
--drop table product_category;
--drop table notification;
--
---- 외래키 붙어있는 테이블삭제
--drop table member cascade constraints;
--drop table review cascade constraints;
--drop table product cascade constraints;
--drop table product_detail cascade constraints;
--drop table pet cascade constraints;
--drop table breed cascade constraints;
--drop table order_detail cascade constraints;
--drop table notification cascade constraints;
--
--
--drop sequence seq_question_id;
--drop sequence seq_answer_id;
--drop sequence seq_image_attachment_id;
--drop sequence seq_image_attachment_mapping_id;
--drop sequence seq_point_id;
--drop sequence seq_product_category_id;
--drop sequence seq_product_id;
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
drop sequence seq_product_option_id;
--drop sequence seq_member_coupon_id;
--drop sequence seq_coupon_id;
--drop sequence seq_category_id;
--drop sequence seq_terms_history_id;
--drop sequence seq_notification_id;
--drop sequence seq_sub_payment_id;
--drop sequence seq_sub_subscribe_id;

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

-- 대충 시큐리티 테이블 없으면 오류남
create table persistent_logins (
    username varchar(64) not null,
    series varchar(64) primary key, -- pk
    token varchar(64) not null, -- username, password, expiry time을 hasing한 값
    last_used timestamp not null
);

-- 펫 테이블
CREATE TABLE pet (
    pet_id number,
    member_id varchar2(20),
    pet_name VARCHAR2(50) NOT NULL,
    pet_age number,
    pet_kind VARCHAR2(50),
    pet_breed VARCHAR2(50),
    pet_weight NUMBER,
    pet_adoption timestamp,
    pet_gender CHAR(1),
    pet_created_at timestamp default systimestamp,
    pet_text VARCHAR2(2000),
    constraints pk_pet_id primary key(pet_id),
    constraints fk_member_id foreign key(member_id) references member(member_id) on delete cascade,
    CONSTRAINT chk_pet_gender CHECK (pet_gender IN ('M', 'F'))
);


-- qna 질문 테이블
create table question(
    question_id number,
    question_member_id varchar2(50) not null,
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
    image_original_filename varchar2(500) not null,
    image_renamed_filename varchar2(500) not null,
    image_file_size number not null,
    thumbnail char(1) not null,
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
    category_id number,
    category_name varchar2(100) not null,
    constraints pk_category_id primary key(category_id)
);


-- 상품 테이블
create table product (
    product_id number, -- pk
    category_id number, -- fk
    product_name varchar2(200) not null,
    product_price number not null,
    image_id number, -- 제품상세 이미지(fk)
    create_date timestamp default systimestamp, -- 등록일
    like_cnt number default 0, -- 좋아요수
    constraints pk_product_id primary key(product_id),
    constraints fk_category_id foreign key(category_id) references product_category(category_id) on delete cascade
);

 -- 상품 디테일 테이블
create table product_detail (
    product_detail_id number, -- pk
    product_id number, -- fk
    option_name varchar2(100), -- 옵션명(option은 예약어라 사용불가)
    option_value varchar2(200), -- 옵션속성
    additional_price number default 0, -- 옵션에 따른 추가금
    constraints pk_product_detail_id primary key(product_detail_id),
    constraints fk_product_id foreign key(product_id) references product(product_id) on delete cascade
);

-- 포인트 테이블
create table point (
    point_id number,
    point_member_id varchar2(50) not null,
    point_current number not null,
    point_type varchar2(100) not null,
    point_amount number not null,
    point_date timestamp default systimestamp,
    review_id number,
    constraint pk_point_id primary key (point_id),
    constraint fk_point_member_id foreign key (point_member_id) references member(member_id) on delete cascade
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
    discount_detail varchar2(50),
    amount number not null,
    member_coupon_id number, -- null 사용하면 고유 번호 들어가게  
    constraint pk_order_id primary key(order_id),
    constraint fk_orderTbl_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraint fk_orderTbl_member_coupon_id foreign key(member_coupon_id) references member_coupon(member_coupon_id) on delete cascade
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

 -- 취소 테이블
create table cancel_order (
    cancel_id number,
    request_date timestamp default systimestamp not null,
    receipt_date timestamp,
    cancel_status number default 0 not null,
    order_id number,
    constraint pk_cancel_id primary key(cancel_id),
    constraint fk_cancel_order_id foreign key(order_id) references orderTbl(order_id) on delete cascade
);

-- 찜한 목록 테이블
create table wishlist(
    wishlist_id number,
    wishlist_member_id varchar2(50),
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
    product_id number,
    review_member_id varchar(20) not null,
    product_detail_id number,
    review_title varchar2(50),
    review_content varchar2(3000),
    review_star_rate number default 1 not null,
    review_created_at timestamp default systimestamp,
    constraint pk_review_id primary key(review_id),
    constraint fk_reivew_pet_id foreign key(pet_id) references pet(pet_id) on delete cascade,
    constraint fk_reivew_product_product_id foreign key (product_id) references product(product_id) on delete cascade,
    constraint fk_reivew_order_id foreign key (order_id) references orderTbl(order_id) on delete cascade,
    constraint ck_review_review_star_rate check(review_star_rate >= 1 and review_star_rate <= 5)
);

 -- 결제 테이블
create table payment (
    payment_id number,
    payment_method number not null,
    payment_date timestamp default systimestamp not null,
    amount number not null,
    order_id number,
    constraint pk_payment_id primary key(payment_id),
    constraint fk_payment_order_id foreign key(order_id) references orderTbl(order_id) on delete cascade
);

-- 구독자 결제 저장용 테이블
create table sub_payment (
    sub_payment_id number,
    member_id varchar2(50),
    payment_date timestamp default systimestamp not null,
    constraint pk_sub_payment_id primary key(sub_payment_id),
    constraint fk_sub_payment_member_id foreign key(member_id) references member(member_id) on delete cascade
);

-- 구독자 정리하는 테이블
create table sub_member (
    subscribe_id number,
    member_id varchar2(50),
    merchant_uid varchar2(30) not null,
    schedule_at timestamp,
    schedule_status varchar2(20),
    amount number,
    constraint pk_subscribe_id primary key(subscribe_id),
    constraint fk_sub_member_id foreign key(member_id) references member(member_id) on delete cascade
);

 -- 장바구니 테이블
create table cart (
    cart_id number,
    member_id varchar2(50),
    constraint pk_cart_id primary key(cart_id),
    constraint fk_cart_member_id foreign key(member_id) references member(member_id) on delete cascade
);


 -- 장바구니 아이템 테이블
create table cartitem (
    cartitem_id number,
    cart_id number,
    product_detail_id number not null,
    quantity number default 1 not null,
    constraint pk_cartitem_id primary key(cartitem_id),
    constraint fk_cart_id foreign key(cart_id) references cart (cart_id)
);

 -- 약관 테이블
create table terms (
 history_id number,
 terms_id number,
 member_id varchar2(50),
 accept_yn char(1) not null,
 accept_date timestamp default systimestamp not null,
 constraint pk_history_id primary key(history_id, terms_id),
 constraint fk_terms_member_id foreign key(member_id) references member(member_id) on delete cascade
);

-- 약관동의 이력 테이블
create table terms_history (
 terms_id number,
 title varchar2(100),
 content varchar2(4000),
 required char(1) not null,
 constraint pk_terms_id primary key(terms_id)
);

-- 쿠폰 테이블
create table coupon (
 coupon_id number,
 coupon_name varchar(100) not null, -- 쿠폰 이름 (ex. 배송비 무료 쿠폰 / 생일축하 쿠폰)
 discount_amount number, -- 할인 금액 (ex. 3,000원 - 배송비 무료 쿠폰)
 discount_percentage number(5, 2), -- 할인 비율 (ex. 10% - 생일 쿠폰)
 constraint pk_coupon_id primary key(coupon_id)
);

-- 멤버 쿠폰 테이블
create table member_coupon (
 member_coupon_id number,
 coupon_id number,
 member_id varchar2(50),
 create_date timestamp default systimestamp not null, -- 발급 날짜
 end_date timestamp not null, -- 유효기간 (언제까지)
 use_status number(1) default 0, -- 사용 여부 (사용 안 하면 0, 사용하면 1)
 use_date timestamp, -- 사용 날짜
 constraint pk_member_coupon_id primary key(member_coupon_id),
 constraint fk_member_coupon_member_id foreign key(member_id) references member(member_id) on delete cascade,
 constraint fk_member_coupon_coupon_id foreign key(coupon_id) references coupon(coupon_id) on delete cascade
);

-- 알림 테이블
create table notification (
    id number,
    noti_category number, -- // 0.공지사항 1.주문알림 2.구독알림 3.기타알림
    noti_content varchar2(2000),
    noti_created_at timestamp default systimestamp not null,
    member_id varchar2(50),
    constraint pk_notification_id primary key(id),
    constraint fk_notification_member_id foreign key(member_id) references member(member_id) on delete cascade    
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
create sequence seq_product_detail_id;
create sequence seq_review_id;
create sequence seq_payment_id;
create sequence seq_cancel_id;
create sequence seq_cart_id;
create sequence seq_cartitem_id;
create sequence seq_chat_id;
create sequence seq_chat_room_id;
create sequence seq_terms_id;
create sequence seq_terms_history_id;
create sequence seq_terms_id;
create sequence seq_member_coupon_id;
create sequence seq_coupon_id;
create sequence seq_history_id;
create sequence seq_category_id;
create sequence seq_notification_id;
create sequence seq_sub_payment_id;
create sequence seq_subscribe_id;


-- 회원가입시 자동으로 장바구니가 생성되는 트리거
create or replace trigger cart_create_trriger
after insert on member
for each row
begin
    insert into cart(cart_id, member_id) values(seq_cart_id.nextval, :NEW.member_id);
end;
/

-- 회원가입시 자동으로 멤버 롤이 들어가는 트리거
create or replace trigger user_role_create_trriger
after insert on member
for each row
begin
    insert into authority(member_id, auth ) values(:NEW.member_id, default);
end;
/


-----------------------------------------
-- 이용약관 쿼리
-----------------------------------------
insert into terms_history (terms_id, title, content, required) values (seq_terms_id.nextval, '이용약관 동의 (필수)', '여러분을 환영합니다.우리집동물친구 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 우리집동물친구 서비스의 이용과 관련하여 반려동물 쇼핑몰 서비스를 제공하는 우리집동물친구(이하 ‘우동친’)와 이를 이용하는 우리집동물친구 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 우리집동물친구 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.', 'Y');
insert into terms_history (terms_id, title, content, required) values (seq_terms_id.nextval, '개인정보 수집 및 이용에 대한 안내 (필수)', '개인정보보호법에 따라 우동친에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다. 1. 수집하는 개인정보 이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 우동친 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 우동친는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.', 'Y');
insert into terms_history (terms_id, title, content, required) values (seq_terms_id.nextval, '이벤트 등 프로모션 알림 메일 수신 (선택)', '우동친 서비스 및 제휴 이벤트・혜택 등의 정보를 휴대전화(우동친앱 알림 또는 문자), 이메일로 받을 수 있습니다. 일부 서비스(별개의 회원 체계 운영, 우동친 가입 후 추가 가입하는 서비스 등)의 경우, 수신에 대해 별도로 안내드리며 동의를 구합니다.', 'N');

-----------------------------------------
-- 쿠폰 데이터
-----------------------------------------
-- 회원가입시 배송비 쿠폰 (3000원)
insert into coupon (coupon_id, coupon_name, discount_amount, discount_percentage)
values (1, '회원가입 배송비 무료 쿠폰', 3000, null);

-- 생일 축하 10% 쿠폰
insert into coupon (coupon_id, coupon_name, discount_amount, discount_percentage)
values (2, '생일축하 10% 할인 쿠폰', null, 10);

----------------------------------------------
-- 카테고리
----------------------------------------------
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '사료');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '간식');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '패션용품');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '산책용품');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '위생용품');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '장난감');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '고양이');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '기타용품');
----------------------------------------------------------
-- 폐기 테이블
---------------------------------------------------------
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

create table community (
    community_id number,
    community_member_id varchar2(50),
    community_title varchar2(500),
    community_content varchar2(4000),
    community_created_at timestamp default systimestamp,
    constraint pk_community_id primary key(community_id),
    constraint fk_community_member_id foreign key(community_member_id) references member(member_id) on delete cascade
);
