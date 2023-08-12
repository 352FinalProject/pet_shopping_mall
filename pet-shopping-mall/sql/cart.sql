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


-- cart.sql용 추가 테이블
CREATE TABLE cart_item (
    cartitem_id VARCHAR2(20),
    product_code VARCHAR2(20),
    quantity NUMBER,
    constraints pk_cartitem_id primary key(cartitem_id),
    constraints fk_product_product_code foreign key(product_code) references product(product_code)
);
insert into cart_item values ('230810-001','A1002', 2);

select
    *
from
    cart_item i left join cart c on i.cartitem_id = c.cartitem_id
where
    c.member_id='honggd';

CREATE TABLE cart (
    cart_id VARCHAR2(20), 
    member_id VARCHAR2(20), 
    cartitem_id VARCHAR2(20), 
    constraints pk_cart_id primary key(cart_id),
    constraints fk_cart_item_cartitem_id foreign key(cartitem_id) references cart_item(cartitem_id),
    constraints fk_member_member_id foreign key(member_id) references member(member_id)
);
insert into cart values ('cart-honggd','honggd', '230810-001');
-- cart.sql용 추가 테이블

drop table cart;


-- 구현할 때 테스트용으로 임시로 만든 테이블 이걸로 사용 금지
create table product (
    id number,
    product_code varchar2(100),
    product_name varchar2(100),
    constraints pk_product_id primary key(id),
    constraints uq_product_product_code unique(product_code)
);
insert into product values(seq_product_id.nextval, 'A1002', '리드줄');

create table member (
    id number,
    member_id varchar2(20),
    password varchar2(300) not null,
    name varchar2(50) not null,
    constraints pk_member_id primary key(id),
    constraints uq_member_member_id unique (member_id)
);
insert into member values(seq_member_id.nextval, 'honggd', '1234', '홍길동');

create sequence seq_member_id;
create sequence seq_product_id;


-- order 가 오라클 예약어여서 테이블명 이렇게 했습니다.
create table orderTbl (
    id number,
    order_no varchar2(20),
    member_id varchar2(20),
    order_date timestamp default sysdate,
    order_state number default 0,
    payment_state number default 0,
    total_price number,
    delivery_fee number,
    discount number,
    amount number
);
-- 할인코드는 미추가 상태입니다.
