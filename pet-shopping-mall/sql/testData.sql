------------------ member insert ---------------------------
insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('admin', '1234', '관리자', '01011112222', 'admin@naver.com', '서울시 강남구 역삼동', to_date('1990-01-01', 'YYYY-MM-DD'), 'Y');
select * from member;
--==============================
--sample data 생성
--==============================
-- member insert
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
values ('honggd', '1234', '홍지디', '01014567828', 'honggd@naver.com', '서울시 송파구 하하동', to_date('1991-01-01', 'YYYY-MM-DD'), 'Y');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('hogd', '1234', '홍박사', '01015314318', 'honggd@naver.com', '서울시 송파구 타파동', to_date('1978-01-01', 'YYYY-MM-DD'), 'N');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('ho12d', '1234', '홍사', '01015315558', 'ho12d@naver.com', '서울시 송파구 자카동', to_date('1989-01-01', 'YYYY-MM-DD'), 'Y');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('haad', '1234', '홍박', '01015315538', 'haad@naver.com', '서울시 송파구 사아동', to_date('1998-01-01', 'YYYY-MM-DD'), 'N');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('hoeerd', '1234', '홍양파', '01012314328', 'hoeerd@naver.com', '서울시 송파구 마바동', to_date('1988-01-01', 'YYYY-MM-DD'), 'Y');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('htruyd', '1234', '홍대파', '01011231238', 'htruyd@naver.com', '서울시 송파구 다라동', to_date('1999-01-01', 'YYYY-MM-DD'), 'N');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('hfnd', '1234', '홍쪽파', '01015123458', 'hfnd@naver.com', '서울시 송파구 가나동', to_date('1995-01-01', 'YYYY-MM-DD'), 'Y');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('hsssd', '1234', '홍당근', '01015314128', 'hsssd@naver.com', '서울시 송파구 촌동', to_date('1994-01-01', 'YYYY-MM-DD'), 'Y');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('hoqfghhd', '1234', '홍마늘', '01015124328', 'hoqfghhd@naver.com', '서울시 송파구 니촌동', to_date('1992-01-01', 'YYYY-MM-DD'), 'Y');

insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('h123qd', '1234', '홍당무', '01015312328', 'h123qd@naver.com', '서울시 송파구 나동', to_date('1991-07-01', 'YYYY-MM-DD'), 'Y');

------------------ authority insert ---------------------------
insert into authority values ('abcde', 'ROLE_USER');
insert into authority values ('qwerty', 'ROLE_USER');
insert into authority values ('admin', 'ROLE_USER');
insert into authority values ('admin', 'ROLE_ADMIN');
insert into authority values ('member1', 'ROLE_USER');
insert into authority values ('member1', 'ROLE_ADMIN');

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
INSERT INTO point (point_id, point_member_id, point_current, point_type, point_amount)
VALUES (2, '사용자2', 50, '사용', -500);

------------------ product insert ---------------------------
-- 카테고리 생성
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '사료');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '간식');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '패션용품');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '산책용품');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '위생용품');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '고양이');
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '기타용품');
select * from product_category;

-- 제품등록 (이미지는 현재 null 처리)
insert into product (product_id, category_id, product_name, product_price, image_id, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 1, '오리젠 퍼피', 32000, null, default, to_date('2023-12-31', 'yyyy-mm-DD'), default, default);
insert into product (product_id, category_id, product_name, product_price, image_id, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 3, '프릴프릴 원피스 소형견', 20000, null, default, null, 31, 156);
insert into product (product_id, category_id, product_name, product_price, image_id, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 4, '말랑 하네스', 15000, null, default, null, default, default);
insert into product (product_id, category_id, product_name, product_price, image_id, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 6, '츄릅츄릅 츄르 10개입', 20000, null, default, to_date('2023-10-11', 'yyyy-mm-DD'), 33, 120);
select * from product;

-- 제품상세 등록
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price,sale_state)
    values (seq_product_detail_id.nextval, 1, null, null, default, default);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price,sale_state)
    values (seq_product_detail_id.nextval, 2, '색', '빨강', default, 1);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price,sale_state)
    values (seq_product_detail_id.nextval, 2, '색', '민트', default, 1);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price,sale_state)
    values (seq_product_detail_id.nextval, 3, null, null, default, 1);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price,sale_state)
    values (seq_product_detail_id.nextval, 4, '맛', '닭고기맛', default, 1);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price,sale_state)
    values (seq_product_detail_id.nextval, 4, '맛', '연어맛', 2000, 1);
select * from product_detail;
commit;

-- 주문테이블 등록
insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-001', 'honggd', sysdate, 0,  0, 35000, 3000, 0, 38000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-002', 'honggd', sysdate, 1,  1, 35000, 3000, 0, 38000, null);
    
 insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-003', 'member5', sysdate, 1,  1, 35000, 3000, 0, 38000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-004', 'member2', sysdate, 1,  1, 35000, 3000, 0, 38000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-005', 'member3', sysdate, 1,  1, 25000, 3000, 0, 28000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-006', 'member5', sysdate, 1,  1, 22000, 3000, 0, 25000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-007', 'member6', sysdate, 1,  1, 17000, 3000, 0, 20000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-008', 'member7', sysdate, 1,  1, 24000,3000, 0, 27000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-009', 'member8', sysdate, 2,  1, 22000,3000, 0, 25000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-010', 'member9', sysdate, 3,  1, 19000,3000, 0, 22000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-011', 'member10', sysdate, 2, 1, 20000,3000, 0, 23000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-012', 'honggd', sysdate, 2, 1, 27000,3000, 0, 30000, null);
    
    

------------------ point insert ---------------------------
insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date)
values (seq_point_id.nextval, 'member1', 3000, '회원가입', 3000, to_date('2023-08-09', 'yyyy-mm-dd'));

insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date)
values (seq_point_id.nextval, 'member1', 3000, '구매적립', 3000, to_date('2023-08-09', 'yyyy-mm-dd'));

insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date)
values (seq_point_point_id.nextval, 'member1', 800, '사용', -200, to_date('2023-08-09', 'yyyy-mm-dd'));


commit;

update set member_role from member where member_id = 77;

delete from answer where answer_id = '2';

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

select * from orderTbl;
select * from member;
select * from point where point_member_id = 'member1';
delete from point where point_id = 2;

-- 장바구니 테스트 데이터
select * from product_category;
insert into product_category values(1, '사료');
insert into product_category values(2, '옷');
insert into product values(seq_product_id.nextval, 1, '에르메스 사료', 15000, 1, 1, systimestamp, systimestamp, 111, 111);
insert into product values(seq_product_id.nextval, 2, '육포', 17000, 2, 2, systimestamp, systimestamp, 222, 222);
select * from cartitem;
select * from cart;
update cartitem set product_detail_id = 1 where cart_id = (select cart_id from cart where member_id='honggd');
select* from product;
select * from product_detail;
select * from orderTbl;


update cartitem set product_detail_id=2 where product_detail_id=1;

delete from cartitem where cartitem_id = 2;
delete from product where product_id = 4;

update cartitem set product_detail_id=1 where product_detail_id=0;
select * from cartitem;

select * from product_detail;

insert into product_detail values(seq_product_detail_id.nextval, 1, '추가1', '금칠 추가', 190000, 2);
insert into product_detail values(seq_product_detail_id.nextval, 2, '추가1', '파란망토', 1900, 9);
insert into product_detail values(seq_product_detail_id.nextval, 2, '추가2', '빨간망토', 1900, 9);

insert into cart values(1, 'honggd');

insert into cartitem values(seq_cartitem_id.nextval, 1, 2, 1);
insert into cartitem values(seq_cartitem_id.nextval, 1, 1, 1);
select * from cartitem;
select * from member;

select * from cancel_order;
select 
    *
from
    cartitem i left join cart c on i.cart_id = c.cart_id
where
    c.member_id='honggd';
    
select * from product_detail;


SELECT 
    pd.*, 
    p.product_price
FROM 
    product_detail pd
JOIN 
    product p ON pd.product_id = p.product_id;
    
select * from cart;
-- 이렇게 불러오기..    
select 
    ci.cartitem_id,
    p.product_id,
    ci.product_detail_id,
    p.product_name,
    pd.option_name,
    pd.option_value,
    (select sum(product_price) from product where product_id = p.product_id) product_price,
    (select sum(additional_price) from product_detail where product_detail_id = ci.product_detail_id) additional_price,
    ci.quantity
from 
    product p left join product_detail pd on p.product_id = pd.product_id
    left join cartitem ci on pd.product_detail_id = ci.product_detail_id
where 
    ci.product_detail_id = 2;
-------------------------------------------------------------------

    
select 
    p.product_id,
    ci.product_detail_id,
    p.product_name,
    pd.option_name,
    pd.option_value,
    (select sum(product_price) from product where product_id = p.product_id) product_price,
    (select sum(additional_price) from product_detail where product_detail_id = ci.product_detail_id) additional_price,
    ci.quantity
from 
    product p 
left join product_detail pd on p.product_id = pd.product_id
left join cartitem ci on pd.product_detail_id = ci.product_detail_id;


    
update cartitem set product_detail_id = 2, quantity = 2 where cartitem_id =13;

delete from orderTbl where member_id = 'honggd'; 

update orderTbl set order_status = 5 where order_no = '1692609071018';

select 
	ci.cartitem_id,
    p.product_id,
    ci.product_detail_id,
    p.product_name,
    pd.option_name,
    pd.option_value,
    (select sum(product_price) from product where product_id = p.product_id) product_price,
    (select sum(additional_price) from product_detail where product_detail_id = ci.product_detail_id) additional_price,
    ci.quantity
from 
    product p left join product_detail pd on p.product_id = pd.product_id
    left join cartitem ci on pd.product_detail_id = ci.product_detail_id
where
    p.product_id = 2;
    
select 
	ci.cartitem_id,
    p.product_id,
    pd.product_detail_id,
    p.product_name,
    pd.option_name,
    pd.option_value,
    (select sum(product_price) from product where product_id = p.product_id) product_price,
    (select sum(additional_price) from product_detail where product_detail_id = ci.product_detail_id) additional_price,
    ci.quantity
from 
    product p left join product_detail pd on p.product_id = pd.product_id
    left join cartitem ci on pd.product_detail_id = ci.product_detail_id
where 
    p.product_id = 2;
    
    
    
delete from cartitem where product_detail_id = 3;

delete from cartitem ci where ci.cart_id = (select cart_id from cart where member_id ='honggd');   
    
insert into point (point_id, point_member_id, point_current, point_type, point_amount)
values (
    seq_point_id.nextval,
    'member1',
    0,
    '구매사용',
    -3000
);

select * from point order by point_id desc;

delete from point where point_id = '9';

alter table point add review_id number;
alter table point add constraint fk_point_review_id foreign key (review_id) references review(review_id) on delete cascade;

-------------------------------------------------
-- 주문조회용 쿼리
-------------------------------------------------
SELECT
    ot.order_id,
    ot.order_date,
    ot.order_no,
    p.product_name,
    ot.order_status,
    ot.payment_status,
    ot.member_id,
    ot.amount,
    ot.delivery_fee,
    pay.payment_method
FROM
    orderTbl ot
LEFT JOIN
    order_detail od ON ot.order_id = od.order_id
LEFT JOIN
    product_detail pd ON od.product_detail_id = pd.product_detail_id
LEFT JOIN
    product p ON pd.product_id = p.product_id
LEFT JOIN
    payment pay ON ot.order_id = pay.order_id;
    
-------------------------------------------------------------------
-- 주문조회 테스트 쿼리 
-------------------------------------------------
SELECT
    ot.order_id,
    ot.order_date,
    ot.order_no,
    p.product_name,
    ot.order_status,
    ot.payment_status,
    ot.member_id,
    ot.amount,
    ot.delivery_fee,
    pay.payment_method
FROM
    orderTbl ot
LEFT JOIN
    order_detail od ON ot.order_id = od.order_id
LEFT JOIN
    product_detail pd ON od.product_detail_id = pd.product_detail_id
LEFT JOIN
    product p ON pd.product_id = p.product_id
LEFT JOIN
    payment pay ON ot.order_id = pay.order_id
    ORDER BY
    ot.order_id deSC;
------------------------
select * from product;
select * from product_detail;
select * from orderTbl;
select * from order_detail;
select * from payment;

------------------------
insert into order_detail (order_id, product_detail_id, quantity) values (17,6,default);
insert into order_detail (order_id, product_detail_id, quantity) values (18,6,default);
insert into order_detail (order_id, product_detail_id, quantity) values (19,6,default);
insert into order_detail (order_id, product_detail_id, quantity) values (20,6,default);
insert into order_detail (order_id, product_detail_id, quantity) values (21,6,default);
insert into order_detail (order_id, product_detail_id, quantity) values (22,6,default);
insert into order_detail (order_id, product_detail_id, quantity) values (23,2,default);
insert into order_detail (order_id, product_detail_id, quantity) values (24,5,default);
------------------------
insert into product_detail values(seq_product_detail_id.nextval, 1, '추가1', '금칠 추가', 190000, 2, 1);
insert into product_detail values(seq_product_detail_id.nextval, 2, '추가2', '빨간망토', 1900, 9, 1);

insert into product (product_id, category_id, product_name, product_price, thumbnail_img, product_img, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 2, '말랑 개껌', 35000, null, null, default, to_date('2023-11-21', 'yyyy-mm-DD'), default, default);
    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(1, 0, systimestamp, 38000, 13);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(2, 0, systimestamp, 38000, 14);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(3, 0, systimestamp, 38000, 15);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(4, 0, systimestamp, 25000, 17);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(6, 0, systimestamp, 20000, 18);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(7, 0, systimestamp, 27000, 19);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(8, 0, systimestamp, 25000, 20);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(9, 0, systimestamp, 22000, 21);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(10, 0, systimestamp, 23000, 22);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(13, 0, systimestamp, 30000, 16);    

------------------------
insert into orderTbl  (
    order_id,
    order_no,
    member_id,
    order_date,
    order_status,
    payment_status,
    total_price,
    delivery_fee,
    discount,
    amount,
    discount_code)
values (
    
);
------------------------
insert into product (product_id, category_id, product_name, product_price, thumbnail_img, product_img, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 1, '오리젠 퍼피', 32000, null, null, default, to_date('2023-12-31', 'yyyy-mm-DD'), default, default);
insert into product (product_id, category_id, product_name, product_price, thumbnail_img, product_img, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 2, '말랑 개껌', 10000, null, null, default, to_date('2023-11-21', 'yyyy-mm-DD'), default, default);
insert into product (product_id, category_id, product_name, product_price, thumbnail_img, product_img, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 3, '프릴프릴 원피스 소형견', 20000, null, null, default, null, 31, 156);
insert into product (product_id, category_id, product_name, product_price, thumbnail_img, product_img, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 4, '말랑 하네스', 15000, null, null, default, null, default, default);
insert into product (product_id, category_id, product_name, product_price, thumbnail_img, product_img, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 4, '짱 부드러운 목줄', 25000, null, null, default, null, 10, 112);
insert into product (product_id, category_id, product_name, product_price, thumbnail_img, product_img, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 6, '츄릅츄릅 츄르 10개입', 20000, null, null, default, to_date('2023-10-11', 'yyyy-mm-DD'), 33, 120);
    
-- 제품상세 등록
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price, stock, sale_state)
    values (seq_product_detail_id.nextval, 1, '용량', '1kg', default, 10, default);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price, stock, sale_state)
    values (seq_product_detail_id.nextval, 1, '용량', '2kg', 20000, 20, default);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price, stock, sale_state)
    values (seq_product_detail_id.nextval, 1, '용량', '5kg', 40000, 10, default);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price, stock, sale_state)
    values (seq_product_detail_id.nextval, 1, '맛', '소고기', default, 10, default);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price, stock, sale_state)
    values (seq_product_detail_id.nextval, 1, '맛', '닭고기', 20000, 20, default);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price, stock, sale_state)
    values (seq_product_detail_id.nextval, 1, '맛', '연어', 40000, 10, default);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price, stock, sale_state)
    values (seq_product_detail_id.nextval, 2, '맛', '소고기', default, 20, 1);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price, stock, sale_state)
    values (seq_product_detail_id.nextval, 2, '맛', '닭고기', default, 20, 1);
select * from product_detail;

----주문테이블 더미
insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-001', 'honggd', sysdate, 4,  1, 35000, 3000, 0, 38000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-002', 'honggd', sysdate, 4,  1, 35000, 3000, 0, 38000, null);
    
 insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-003', 'member5', sysdate, 4,  1, 35000, 3000, 0, 38000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-004', 'member2', sysdate, 4,  1, 35000, 3000, 0, 38000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-005', 'member3', sysdate, 1,  1, 25000, 3000, 0, 28000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-006', 'member5', sysdate, 1,  1, 22000, 3000, 0, 25000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-007', 'member6', sysdate, 1,  1, 17000, 3000, 0, 20000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-008', 'member7', sysdate, 1,  1, 24000,3000, 0, 27000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-009', 'member8', sysdate, 2,  1, 22000,3000, 0, 25000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-010', 'member9', sysdate, 3,  1, 19000,3000, 0, 22000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-011', 'member10', sysdate, 2, 1, 20000,3000, 0, 23000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_code)
    values (seq_orderTbl_id.nextval, '230811-012', 'honggd', sysdate, 2, 1, 27000,3000, 0, 30000, null);
-----------------------------------------
-- 통계조회 쿼리
-----------------------------------------
SELECT
    ot.order_id,
    ot.order_date,
    ot.order_no,
    p.product_name,
    ot.amount
FROM
    orderTbl ot
JOIN
    order_detail od ON ot.order_id = od.order_id
JOIN
    product_detail pd ON od.product_detail_id = pd.product_detail_id
JOIN
    product p ON pd.product_id = p.product_id;

select * from orderTbl;
select * from order_detail;

select
    ot.member_id,
    ot.order_date,
    ot.order_no,
    ot.order_status,
    (select product_name from product where product_id = pd.product_id) product_name,
    od.product_detail_id,
    od.quantity,
    ot.total_price
from
    orderTbl ot left join order_detail od on ot.order_id = od.order_id
    left join product_detail pd on od.product_detail_id = pd.product_detail_id
    left join product p on p.product_id = pd.product_id
where
    ot.member_id = 'honggd';
    
