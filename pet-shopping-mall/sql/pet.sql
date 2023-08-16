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

--drop table member;
--drop table question;
--drop table answer;
--drop table image_attachment;
--drop table image_attachment_mapping;
--drop table point;
--drop table product_category;
--drop table product;
--drop table product_detail;
--drop table cart;
--drop table payment;
--drop table cartitem;
--drop table orderTbl;
--drop table refund;
--drop table cancel_order;
--drop table authority;
--drop table product_category;
--drop table community;
--drop table wishlist;
--drop table pet;
--drop table persistent_logins;
--drop table image_attachment_mapping;
--
--
--drop sequence seq_member_id;
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

--==============================
-- 테이블 생성
--==============================

-- 멤버 테이블
create table member (
    member_id varchar2(20),
    password varchar2(300) not null,
    name varchar2(50) not null,
    phone varchar2(11) not null,
    email varchar2(200),
    enroll_date timestamp default sysdate,
    address varchar2(500),
    birthday timestamp,
    subscribe char(1) default 'N' not null,
    constraints pk_member_id primary key(member_id)
);


-- 권한 테이블
create table authority(
    member_id varchar2(20),
    auth varchar2(50),
    constraints pk_authority primary key(member_id, auth),
    constraints fk_authority_member_id foreign key(member_id)
                references member(member_id)
                on delete cascade
);

-- 펫 테이블
create table pet (
    pet_id number,
    pet_member_id varchar2(20),
    pet_name VARCHAR2(50) NOT NULL,
    pet_DofB timestamp,
    pet_kind VARCHAR2(50),
    pet_breed VARCHAR2(50),
    pet_adoption timestamp,
    pet_gender CHAR(1),
    constraints pk_pet_id primary key(pet_id),
    constraints fk_pet_member_id foreign key(pet_member_id) references member(member_id) on delete cascade,
    CONSTRAINT chk_pet_gender CHECK (pet_gender IN ('M', 'F'))
);

-- 찜한 목록 테이블
create table wishlist(
    wishlist_id number,
    wishlist_member_id varchar2(20),
    wishlist_product_id number,
    wishlist_created_at timestamp default sysdate,
    constraints pk_wishlist_id primary key(wishlist_id),
    constraints fk_wishlist_member_id foreign key(wishlist_member_id) references member(member_id) on delete cascade,
    constraints fk_wishlist_product_id foreign key(wishlist_product_id) references product(product_id) on delete cascade
);

-- qna 질문 테이블
create table question(
    question_id number,
    question_member_id varchar2(20) not null,
    question_category varchar2(50) not null,
    question_email varchar2(200),
    question_title varchar2(500) not null,
    question_content varchar2(4000) not null,
    question_created_at timestamp default sysdate,
    constraints pk_question_id primary key(question_id),
    constraints fk_question_member_id foreign key(question_member_id) references member(member_id) on delete cascade question_member_id varchar2(20) not null
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

-- 포인트 테이블
create table point (
    point_id number,
    point_member_id varchar2(20) not null,
    point_current number not null,
    point_type varchar2(100) not null,
    point_amount number not null,
    point_date timestamp default sysdate,

    constraint pk_point_id primary key (point_id),
    constraint fk_point_member_id foreign key (point_member_id) references member(member_id) on delete cascade
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
    thumbnail_img number, -- 썸네일 이미지(fk)
    product_img number, -- 제품상세 이미지(fk)
    product_date timestamp default sysdate, -- 등록일
    expire_date timestamp default sysdate, -- 유통기한
    like_cnt number, -- 좋아요수
    view_cnt number, -- 조회수
    constraints pk_product_id primary key(product_id),
    constraints fk_category_id foreign key(category_id) references product_category(category_id) on delete cascade
);

-- 상품상세 테이블
create table product_detail (
    product_detail_id number, -- pk
	product_id number, -- fk
    option_name varchar2(100), -- 옵션명(option은 예약어라 사용불가)
    option_value varchar2(200), -- 옵션속성
    additional_price number, -- 옵션에 따른 추가금
    stock number default 0,
    sale_state number default 0, -- 0: 판매대기, 1: 판매중, 2: 품절, 3: 기타 
    constraints pk_product_detail_id primary key(product_detail_id),
    constraints fk_product_id foreign key(product_id) references product(product_id) on delete cascade
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

-- 상품상세 테이블
create table product_detail (
    product_detail_id number, -- pk
	product_id number, -- fk
    option_name varchar2(100), -- 옵션명(option은 예약어라 사용불가)
    option_value varchar2(200), -- 옵션속성
    additional_price number, -- 옵션에 따른 추가금
    stock number default 0,
    sale_state number default 0, -- 0: 판매대기, 1: 판매중, 2: 품절, 3: 기타 
    constraints pk_product_detail_id primary key(product_detail_id),
    constraints fk_product_id foreign key(product_id) references product(product_id)
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
    review_created_at timestamp default sysdate,
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
    community_created_at timestamp default sysdate,
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
create table return (
    return_id number,
    return_status number default 0 not null,
    request_date timestamp default systimestamp not null,
    receipt_date timestamp,
    withdraw_data timestamp,
    order_id number,
    constraint pk_return_id primary key(return_id),
    constraint fk_return_order_id foreign key(order_id) references orderTbl(order_id) on delete cascade
);

-- 환불테이블
create table refund (
    refund_id number,
    receipt_date timestamp default systimestamp not null,
    complete_date timestamp,
    refund_status number default 0 not null,
    refund_price number not null,
    refund_method number not null,
    refund_account varchar2(20),
    account_name varchar2(20),
    bank varchar2(20),
    order_id number,
    constraint pk_refund_id primary key(refund_id),
    constraint fk_refund_order_id foreign key(order_id) references orderTbl(order_id) on delete cascade
);

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
    constraint fk_cartitem_cart_id foreign key(cart_id) references cart(cart_id)
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

select * from member;
select * from question;
select * from answer;
select * from point;
select * from product;
select * from image_attachment;
select * from image_attachment_mapping;
select * from authority;
select * from pet;
select * from review;

-- 회원가입시 자동으로 장바구니가 생성되는 트리거
create or replace trigger cart_create_trriger
after insert on member
for each row
begin
    insert into cart(cart_id, member_id) values(seq_cart_id.nextval, :NEW.member_id);
end;
/
------------------ member insert ---------------------------
insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('admin', '1234', '관리자', '01011112222', 'admin@naver.com', '서울시 강남구 역삼동', to_date('1990-01-01', 'YYYY-MM-DD'), 'Y');

--==============================
--sample data 생성
--==============================
-- member insert
insert into member (member_id, password, name, phone, email, address, birthday, member_role, point, subscribe)
values ('admin', '1234', '관리자', '01011112222', 'admin@naver.com', '서울시 강남구 역삼동', to_date('1990-01-01', 'YYYY-MM-DD'), 'ROLE_ADMIN', 10000, 'Y');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member1', '1234', '김상훈', '01012345678', 'kim@naver.com', '서울시 송파구 애냐동', to_date('1977-01-01', 'YYYY-MM-DD'), 'Y');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member2', '1234', '대한훈', '01028283939', 'ghjwf@naver.com', '서울시 송파구 마니동', to_date('1995-01-01', 'YYYY-MM-DD'), 'Y');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member3', '1234', '건곤훈', '01011223344', 'qwerrt@naver.com', '서울시 송파구 베내동', to_date('1998-01-01', 'YYYY-MM-DD'), 'N');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member4', '1234', '덩셍훈', '010133663344', 'dfhdfg@naver.com', '서울시 송파구 메메동', to_date('1987-01-01', 'YYYY-MM-DD'), 'N');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member5', '1234', '누나훈', '01012347755', 'kim@naver.com', '서울시 송파구 차차동', to_date('1993-01-01', 'YYYY-MM-DD'), 'N');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member6', '1234', '삼촌훈', '01099007766', 'fghew@naver.com', '서울시 송파구 재재동', to_date('1992-01-01', 'YYYY-MM-DD'), 'N');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member7', '1234', '할멈훈', '01088776655', 'rtyhm@naver.com', '서울시 송파구 어어동', to_date('1991-01-01', 'YYYY-MM-DD'), 'N');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member8', '1234', '할아버지훈', '01012123232', 'kdfhim@naver.com', '서울시 송파구 하하동', to_date('1994-01-01', 'YYYY-MM-DD'), 'Y');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member9', '1234', '딸훈', '01011556633', 'kinjmm@naver.com', '서울시 송파구 매매동', to_date('1997-01-01', 'YYYY-MM-DD'), 'Y');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member10', '1234', '아들훈', '01012322678', 'kixvm@naver.com', '서울시 송파구 내내동', to_date('1999-01-01', 'YYYY-MM-DD'), 'N');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member11', '1234', '아빠훈', '01012552278', 'kewim@naver.com', '서울시 송파구 배배동', to_date('1993-01-01', 'YYYY-MM-DD'), 'N');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member12', '1234', '엄마훈', '01012342238', 'ghjkim@naver.com', '서울시 송파구 마자동', to_date('1994-01-01', 'YYYY-MM-DD'), 'N');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member13', '1234', '이모훈', '01012123418', 'svxkim@naver.com', '서울시 송파구 우동', to_date('1996-01-01', 'YYYY-MM-DD'), 'N');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('member14', '1234', '고모훈', '01012244238', 'qwewkim@naver.com', '서울시 송파구 석비촌동', to_date('1999-01-01', 'YYYY-MM-DD'), 'Y');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('honggd', '1234', '홍지디', '01015314328', 'honggd@naver.com', '서울시 송파구 석나니촌동', to_date('1991-01-01', 'YYYY-MM-DD'), 'ROLE_USER', 10000, 'Y');

------------------ authority insert ---------------------------
insert into authority values ('abcde', 'ROLE_USER');
insert into authority values ('qwerty', 'ROLE_USER');
insert into authority values ('admin', 'ROLE_USER');
insert into authority values ('admin', 'ROLE_ADMIN');
insert into authority values ('member1', 'ROLE_USER');

------------------ qna insert ---------------------------
insert into question (question_id, question_title, question_category, question_member_id, question_email, question_content, question_created_at)
values (seq_question_question_id.nextval, '우동친이 머에요?', '상품' ,'member1', 'kh@naver.com', '우동친이 먼가요???? 우동친이 먼가요???? 우동친이 먼가요???? 우동친이 먼가요????', to_date('18/02/14', 'rr/mm/dd'));
insert into question (question_id, question_title, question_category, question_member_id, question_email, question_content, question_created_at)
values (seq_question_question_id.nextval, '배가 고파요', '배송', 'member1', 'kh@daum.net', '배가 고프다', to_date('18/02/14', 'rr/mm/dd'));

------------------ answer insert ---------------------------
insert into answer (answer_id, answer_admin_name, answer_question_id, answer_content, answer_created_at)
values (seq_answer_answer_id.nextval, '관리자', 47, '우동친은 우리집동물친구의 줄임말입니다~', sysdate);

insert into answer (answer_id, answer_admin_name, answer_question_id, answer_content, answer_created_at)
values (seq_answer_answer_id.nextval, '관리자', 2, '배고프면 밥을 드세요', sysdate);

------------------ product insert ---------------------------
insert into product (id, product_code, product_category, product_name, product_price, product_stock, expire_date)
values (seq_member_id.nextval, 101, '사료', '오리젠 퍼피', 32000, 100, to_date('2023-12-31', 'yyyy-mm-DD'));

insert into product (id, product_code, product_category, product_name, product_price, product_stock, expire_date)
values (seq_member_id.nextval, 102, '하네스', '말랑 하네스', 15000, 100, to_date('2023-12-31', 'yyyy-mm-DD'));

------------------ point insert ---------------------------
insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date)
values (seq_point_point_id.nextval, 'member1', 1000, '적립', 500, to_date('2023-08-09', 'yyyy-mm-dd'));

insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date)
values (seq_point_point_id.nextval, 'member1', 800, '사용', -200, to_date('2023-08-09', 'yyyy-mm-dd'));


select * from pet;

commit;

update set member_role from member where member_id = 77;

delete from pet where pet_id = '1';

SELECT * FROM product WHERE id = 3;

select * from question where id = '4';

select * from member;


select * from member M left join authority A on M.member_id = A.member_id where M.member_id = '4';
select q.*, (select count(*) from answer where answer_question_id = q.question_id) awnser_count from question q order by question_id desc;

@Insert("insert into member (member_id, password, name, phone, email, address, birthday, point) " +
        "values (#{member.memberId}, #{member.password}, #{member.name}, #{member.phone}, #{member.email}, " +
        "#{member.address}, #{member.birthday, jdbcType=DATE}, #{member.point})")
int insertMember(@Param("member") MemberCreateDto member);


SELECT
    q.question_id,
    q.question_title,
    q.question_content,
    ia.image_original_filename,
    ia.image_renamed_filename
FROM 
    question q
LEFT JOIN 
    image_attachment_mapping iam ON q.question_id = iam.ref_id AND iam.ref_table = 'question'
LEFT JOIN
    image_attachment ia ON iam.image_id = ia.image_id
WHERE 
    q.question_id = 25;

update member
set member_role = 'ROLE_ADMIN'
where id = 77;


select * from review where review_member_id = 'member1';
