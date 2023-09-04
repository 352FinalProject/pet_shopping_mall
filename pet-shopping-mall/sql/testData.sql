------------------ member insert ---------------------------
insert into member (member_id, password, name, phone, email, address, birthday, subscribe)
values ('admin', '1234', '관리자', '01011112222', 'admin@naver.com', '서울시 강남구 역삼동', to_date('1990-01-01', 'YYYY-MM-DD'), 'Y');
select * from member;
select * from point order by point_date desc;
select * from pet;
select * from review order by review_created_at desc;
select * from coupon;
select * from member_coupon order by member_coupon_id desc;
select * from terms;
select * from terms_history;
select * from product_category;
select * from product;
select * from terms_history;
select * from image_attachment;
select * from image_attachment_mapping;
select * from product;
select * from orderTbl order by order_id desc;
select * from order_detail;
select * from product_detail;
select * from product;
select * from member_coupon;
select * from notification;
select * from question;
select * from answer;
select * from cartitem;
select * from cart;
select * from wishlist;
select * from notification;    
            
-- 멤버 쿠폰 입력
insert into member_coupon (member_coupon_id, coupon_id, member_id, create_date, end_date, use_status, use_date)
values ( seq_member_coupon_id.nextval, '1', 'null@naver', sysdate, add_months(sysdate, 1), 0, null);

delete from member_coupon where member_id = '2971776209@kakao'; 

select * from member_coupon where coupon_id = 1 and member_id = 'member3' and end_date >= current_timestamp and use_status = 0;

delete from member where name = '예라'; 
delete from wishlist where wishlist_id = 10; 

select count(*) from orderTbl o Left Join order_detail od on o.order_id = od.order_id left join review r on od.product_detail_id = r.product_detail_id where r.order_id = 53 and r.product_detail_id = 23 and o.member_id = 'null@naver';

select * from payment;
select * from orderTbl where order_no='1693296419851';
select 
    *
from 
    product p
    left join 
        review r on p.product_id = pd.product_id
where 
    p.product_id = 1;
    
select * from review
where product_id = 1;
    
    select * from review
where product_id = #{productId};

select * from member_coupon m left join coupon c on m.coupon_id = c.coupon_id where m.member_id = 'member1';

insert into cartitem (cartitem_id, cart_id, product_detail_id, quantity) values (30, 1, 21, 1);
insert into cartitem (cartitem_id, cart_id, product_detail_id, quantity) values (30, 1, 21, 1);

delete from product where product_id = 1;

delete from cartitem where cartitem_id = '111';
delete from orderTbl where order_id = '2';
update orderTbl set order_status = 4 where order_id = 76;

select * from orderTbl order by order_id desc;
UPDATE orderTbl SET order_date = '2023-05-02 00:00:00' WHERE order_id = 40;


update product set product_id = 1 where product_id = 21;
update product_detail set product_id = 1 where product_id = 22;

select count(*) from review where review_member_id = 'member1' and order_id = 2;
select count(*) from member_coupon where member_id = 'member4';

--==============================
--sample data 생성
--==============================
-- member insert
insert into member (member_id, password, name, phone, email, enroll_date, address, birthday, subscribe)
values ('member1', '$2a$10$V6DMY985chA4/fMc/vY20e15i/OaPr.GpQ0v2W0zNqshEWutOxm9q', '김상훈', '01012345678', 'kim@naver.com', '서울시 송파구 애냐동', to_date('1977-01-01', 'YYYY-MM-DD'), 'Y');

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
insert into product_category (category_id, category_name) values (seq_product_category_id.nextval, '장난감');
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
    
insert into product (product_id, category_id, product_name, product_price, image_id, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 6, '개고기 개껌', 50000, null, default, to_date('2023-10-11', 'yyyy-mm-DD'), 33, 120);
    
insert into product (product_id, category_id, product_name, product_price, image_id, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 6, '고양이고기', 21000, null, default, to_date('2023-10-11', 'yyyy-mm-DD'), 33, 120);

insert into product (product_id, category_id, product_name, product_price, image_id, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 2, '카카오74퍼', 26000, null, default, to_date('2023-10-11', 'yyyy-mm-DD'), 33, 120);
insert into product (product_id, category_id, product_name, product_price, image_id, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 3, '물물물', 31000, null, default, to_date('2023-10-11', 'yyyy-mm-DD'), 33, 120);
insert into product (product_id, category_id, product_name, product_price, image_id, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 4, '에어팟', 43000, null, default, to_date('2023-10-11', 'yyyy-mm-DD'), 33, 120);
insert into product (product_id, category_id, product_name, product_price, image_id, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 5, '아이폰', 32000, null, default, to_date('2023-10-11', 'yyyy-mm-DD'), 33, 120);
insert into product (product_id, category_id, product_name, product_price, image_id, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 6, '냉장고', 16000, null, default, to_date('2023-10-11', 'yyyy-mm-DD'), 33, 120);
    
    
select * from product;

-- 제품상세 등록
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price,sale_state)
    values (seq_product_detail_id.nextval, 1, null, null, default, default);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price,sale_state)
    values (seq_product_detail_id.nextval, 1, '색', '빨강', default, 1);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price,sale_state)
    values (seq_product_detail_id.nextval, 4, '색', '민트', default, 1);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price,sale_state)
    values (seq_product_detail_id.nextval, 5, null, null, default, 1);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price,sale_state)
    values (seq_product_detail_id.nextval, 4, '맛', '닭고기맛', default, 1);
insert into product_detail (product_detail_id, product_id, option_name, option_value, additional_price,sale_state)
    values (seq_product_detail_id.nextval, 4, '맛', '연어맛', 2000, 1);
select * from product_detail;
commit;

-- 주문테이블 등록
insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, member_coupon_id)
    values (seq_orderTbl_id.nextval, '230811-001', 'honggd', sysdate, 0,  0, 35000, 3000, 0, 38000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, member_coupon_id)
    values (seq_orderTbl_id.nextval, '230811-002', 'honggd', sysdate, 1,  1, 35000, 3000, 0, 38000, null);
    
 insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, member_coupon_id)
    values (seq_orderTbl_id.nextval, '230811-003', 'member5', sysdate, 1,  1, 35000, 3000, 0, 38000, null);


insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-004', 'member2', sysdate, 1,  1, 35000, 3000, 0, 38000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, member_coupon_id)
    values (seq_orderTbl_id.nextval, '230811-005', 'member3', sysdate, 1,  1, 25000, 3000, 0, 28000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, member_coupon_id)
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

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, member_coupon_id)
    values (seq_orderTbl_id.nextval, '1692683868583', 'honggd', '2023-06-22 14:57:48.69', 2, 1, 27000,3000, 0, 30000, 0);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, member_coupon_id)
    values (seq_orderTbl_id.nextval, '1692683868583', 'honggd', '2023-01-22 14:57:48.69', 2, 1, 27000,3000, 0, 30000, 0);
        
insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, member_coupon_id)
    values (seq_orderTbl_id.nextval, '231231', 'honggd', default, 2, 1, 27000,3000, 0, 30000, 0);

------------------ point insert ---------------------------
insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date)
values (seq_point_id.nextval, '2971776209@kakao', 3000, '회원가입', 3000, to_date('2023-08-09', 'yyyy-mm-dd'));

insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date)
values (seq_point_id.nextval, 'member1', 3000, '구매적립', 3000, to_date('2023-08-09', 'yyyy-mm-dd'));

insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date)
values (seq_point_point_id.nextval, 'member1', 800, '사용', -200, to_date('2023-08-09', 'yyyy-mm-dd'));


commit;

update set member_role from member where member_id = 77;

delete from answer where answer_id = '2';

SELECT * FROM product WHERE id = 3;

select * from question where id = '4';

select * from orderTbl;


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

select * from payment;

select * from product_detail;
select * from member_coupon;
insert into product_detail values(seq_product_detail_id.nextval, 1, '추가1', '금칠 추가', 190000, 2);
insert into product_detail values(seq_product_detail_id.nextval, 2, '추가1', '파란망토', 1900, 9);
insert into product_detail values(seq_product_detail_id.nextval, 2, '추가2', '빨간망토', 1900, 9);

insert into cart values(1, 'member3');

select * from cart;
insert into cartitem values(seq_cartitem_id.nextval, 1, 3, 1);
insert into cartitem values(seq_cartitem_id.nextval, 2, 3, 1);
select * from cartitem;
select * from member;
delete from cartitem where cart_id = 5;
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
    
    

-- 주문 취소 내역 불러오기
select
    m.name,
    m.phone,
    ot.order_no,
    ot.order_date,
    ot.order_status,
    ot.total_price,
    p.payment_method,
    p.payment_date,
    ot.payment_status,
    ot.amount,
    ot.discount
from
    orderTbl ot left join member m on ot.member_id = m.member_id 
    left join payment p on p.order_id = ot.order_id
where
    order_date >= ADD_MONTHS(TRUNC(SYSDATE), -#{period})
 
	select
		m.name,
		m.phone,
		ot.order_no,
		ot.order_date,
		ot.order_status,
		ot.total_price,
		p.payment_method,
		p.payment_date,
		ot.payment_status,
		ot.amount,
		ot.discount
	from
		orderTbl ot left join member m on ot.member_id = m.member_id
		left join payment p on p.order_id = ot.order_id
		left join cancel_order c on ot.order_id = c.order_id
	where
		c.request_date >= ADD_MONTHS(TRUNC(SYSDATE), -3);
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

update orderTbl set payment_status = 1 where order_no = '1692609071018';

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

UPDATE orderTbl
SET order_date = TO_TIMESTAMP('2023-08-19 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
WHERE order_id = ;

------------------------

insert into order_detail (order_id, product_detail_id, quantity) values (4,29,default);
insert into order_detail (order_id, product_detail_id, quantity) values (15,29,default);
insert into order_detail (order_id, product_detail_id, quantity) values (19,6,default);
insert into order_detail (order_id, product_detail_id, quantity) values (20,6,default);
insert into order_detail (order_id, product_detail_id, quantity) values (21,6,default);
insert into order_detail (order_id, product_detail_id, quantity) values (22,6,default);
insert into order_detail (order_id, product_detail_id, quantity) values (23,2,default);
insert into order_detail (order_id, product_detail_id, quantity) values (26,1,default);
------------------------
insert into product_detail values(seq_product_detail_id.nextval, 1, '추가1', '금칠 추가', 190000, 2);
insert into product_detail values(seq_product_detail_id.nextval, 2, '추가2', '빨간망토', 1900, 9);


insert into product (product_id, category_id, product_name, product_price, thumbnail_img, product_img, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 2, '말랑 개껌', 35000, null, null, default, to_date('2023-11-21', 'yyyy-mm-DD'), default, default);
    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(19, 1, systimestamp, 100000, 19);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(20, 1, systimestamp, 11000, 20);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(21, 1, systimestamp, 12000, 21);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(22, 1, systimestamp, 120000, 22);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(23, 1, systimestamp, 80000, 23);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(24, 1, systimestamp, 90000, 24);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(25, 1, systimestamp, 160000, 25);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(26, 1, systimestamp, 140000, 26);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(27, 1, systimestamp, 160000, 27);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(28, 1, systimestamp, 70000, 28);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(29, 1, systimestamp, 750000, 29);  
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(30, 1, systimestamp, 61000, 30);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(31, 1, systimestamp, 61000, 31);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(32, 1, systimestamp, 61000, 32);    
insert into payment (payment_id, payment_method, payment_date, amount, order_id) values(33, 1, systimestamp, 61000, 33);    

------------------------
insert into product (product_id, category_id, product_name, product_price, thumbnail_img, product_img, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 1, '오리젠 퍼피', 32000, null, null, default, to_date('2023-12-31', 'yyyy-mm-DD'), default, default);
insert into product (product_id, category_id, product_name, product_price, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 2, '말랑 개껌', 10000, default, to_date('2023-11-21', 'yyyy-mm-DD'), default, default);
insert into product (product_id, category_id, product_name, product_price, create_date, expire_date, like_cnt, view_cnt)
    values (seq_product_id.nextval, 3, '프릴프릴 원피스 소형견', 20000, default, null, 31, 156);
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
insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-001', 'member1', sysdate, 4,  1, 35000, 3000, 0, 38000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-002', 'member2', sysdate, 4,  1, 35000, 3000, 0, 38000, null);
    
 insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-003', 'member2', sysdate, 4,  1, 35000, 3000, 0, 38000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-004', 'member1', sysdate, 4,  1, 35000, 3000, 0, 38000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-005', 'member2', sysdate, 1,  1, 25000, 3000, 0, 28000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-006', 'member2', sysdate, 1,  1, 22000, 3000, 0, 25000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-007', 'member1', sysdate, 1,  1, 17000, 3000, 0, 20000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-008', 'member1', sysdate, 1,  1, 24000,3000, 0, 27000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-009', 'member1', sysdate, 2,  1, 22000,3000, 0, 25000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-010', 'member1', sysdate, 3,  1, 19000,3000, 0, 22000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-011', 'member1', sysdate, 2, 1, 20000,3000, 0, 23000, null);

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230811-012', 'honggd', sysdate, 2, 1, 27000,3000, 0, 30000, null);
    
insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230823-001', 'honggd', sysdate, 5, 1, 27000,3000, 0, 30000, null);    

insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, discount_detail)
    values (seq_orderTbl_id.nextval, '230823-002', 'honggd', sysdate, 1, 0, 27000,3000, 0, 30000, null);
    
insert into orderTbl (order_id, order_no, member_id, order_date, order_status, payment_status, total_price, delivery_fee, discount, amount, member_coupon_id)
    values (seq_orderTbl_id.nextval, '230823-002', 'honggd', sysdate, 5, 0, 27000,3000, 0, 30000, null);

select * from orderTbl;    

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
    WHERE
            pay.payment_method IN (0,1)
            AND ot.order_status IN (0,1,2,3,4,5,6)
            AND (ot.order_no LIKE '%' || '오' || '%' OR p.product_name LIKE '%' || '오' || '%')
	ORDER BY
	    ot.order_id DESC;


SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    pc.category_name,
    p.product_price,
    SUM(od.quantity) AS total_sold,
    SUM(od.quantity * p.product_price) AS total_price
FROM
    product p
    JOIN product_category pc ON p.category_id = pc.category_id
    JOIN product_detail pd ON p.product_id = pd.product_id
    LEFT JOIN order_detail od ON pd.product_detail_id = od.product_detail_id
    LEFT JOIN orderTbl ot ON od.order_id = ot.order_id
WHERE
    ot.payment_status = 1
GROUP BY
    p.product_id, p.product_name, p.category_id, pc.category_name, p.product_price
ORDER BY
    total_sold DESC;

SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    pc.category_name,
    p.product_price,
    SUM(od.quantity) AS total_sold,
    SUM(od.quantity * p.product_price) AS total_price
FROM
    product p
    JOIN product_category pc ON p.category_id = pc.category_id
    JOIN product_detail pd ON p.product_id = pd.product_id
    LEFT JOIN order_detail od ON pd.product_detail_id = od.product_detail_id
    LEFT JOIN orderTbl ot ON od.order_id = ot.order_id
WHERE
    ot.payment_status = 1
GROUP BY
    p.product_id, p.product_name, p.category_id, pc.category_name, p.product_price
ORDER BY
    total_price DESC;

SELECT
    TO_CHAR(order_date, 'YYYY-MM-DD') AS order_daily,
    SUM(total_price) AS daily_total_sales
FROM
    orderTbl
WHERE
    payment_status = 1
GROUP BY
    TO_CHAR(order_date, 'YYYY-MM-DD')
ORDER BY
    TO_CHAR(order_date, 'YYYY-MM-DD');
    
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS order_month,
    SUM(total_price) AS monthly_total_sales
FROM
    orderTbl
WHERE
    payment_status = 1
GROUP BY
    TO_CHAR(order_date, 'YYYY-MM')
ORDER BY
    TO_CHAR(order_date, 'YYYY-MM');
--------------------------------------------------------------------- 통계조회쿼리 끝






select * from image_attachment;

select 
	ci.cartitem_id,
    p.product_id,
    ci.product_detail_id,
    p.product_name,
    pd.option_name,
    pd.option_value,
    (select sum(product_price) from product where product_id = p.product_id) product_price,
    (select sum(additional_price) from product_detail where product_detail_id = ci.product_detail_id) additional_price,
    ci.quantity,
    ia.image_original_filename,
    ia.image_renamed_filename
from 
    product p left join product_detail pd on p.product_id = pd.product_id
    left join cartitem ci on pd.product_detail_id = ci.product_detail_id
    left join 
	    image_attachment_mapping iam on p.product_id = iam.ref_id and iam.ref_table = 'product';

select
  ot.order_id,
  ot.order_date,
  ot.order_no,
  ot.order_status,
  pd.product_id,
  (select product_name from product where product_id = pd.product_id)
  product_name,
  od.product_detail_id,
  od.quantity,
  ot.amount
from
  orderTbl ot left join order_detail od on ot.order_id = od.order_id
  left join product_detail pd on od.product_detail_id = pd.product_detail_id
  left join product p on p.product_id = pd.product_id
where
  ot.member_id = 'member2'
  order by
  ot.order_date desc;

select * from point;
select * from member;

delete from member where email='hulk1512@naver.com';
commit;


select 
    p.product_id,
    pd.product_detail_id,
    p.product_name,
    pd.option_name,
    pd.option_value,
    (select sum(product_price) from product where product_id = p.product_id) product_price,
    (select sum(additional_price) from product_detail where product_detail_id = pd.product_detail_id) additional_price,
	ia.image_renamed_filename
from 
    product p 
    left join 
        product_detail pd on p.product_id = pd.product_id
    left join 
	    image_attachment_mapping iam on p.product_id = iam.ref_id and iam.ref_table = 'product'
    left join
	    image_attachment ia ON iam.image_id = ia.image_id
where 
    p.product_id = 1;

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
--------------------------------------------알림
insert into (id, noti_category, noti_content, noti_created_at, member_id) 
    values (seq_notification_id.nextval, ?, ?, default, ?);

select * from orderTbl;

SELECT ot.order_no, ot.order_id, p.product_name, ot.order_status, ot.member_id
FROM orderTbl ot
JOIN order_detail od ON ot.order_id = od.order_id
JOIN product_detail pd ON od.product_detail_id = pd.product_detail_id
JOIN product p ON pd.product_id = p.product_id
where member_id = 'king';

select * from notification where member_id='king';
delete notification where member_id='king';

select * from orderTbl;

update orderTbl set order_date ='23/08/26' where order_no = '1693628893561'; 
select * from member;
select * from sub_member;
select * from sub_payment;

update member set subscribe = 'Y' where member_id = 'honggd';
update sub_member set schedule_status = 'cancel' where member_id = 'honggd';
update sub_member set schedule_at = sysdate where member_id = 'honggd';

SELECT *
FROM sub_member
WHERE schedule_status = 'cancel'
    AND TRUNC(schedule_at) <= TRUNC(SYSDATE);

select * from payment;
select * from sub_member;
select * from member;
update sub_member set schedule_at = '23/08/29' where member_id='sinsa';

select * from orderTbl;

select 
    * 
from 
    orderTbl 
where 
    order_date <= systimestamp - interval '7' day ;
    








SELECT
    p.product_id,
    p.category_id,
    p.create_date,
    p.product_name,
    p.product_price,
    ia.image_renamed_filename,
    DECODE(avg_star, NULL, 0.0, avg_star) AS review_star_rate
FROM
    product p
LEFT JOIN
    image_attachment_mapping iam ON p.product_id = iam.ref_id AND iam.ref_table = 'product'
LEFT JOIN
    image_attachment ia ON iam.image_id = ia.image_id
LEFT JOIN
    (SELECT product_id, ROUND(AVG(review_star_rate)) AS avg_star FROM review GROUP BY product_id) r
    ON p.product_id = r.product_id
WHERE
    p.product_name LIKE '%' || '옵' || '%';
 
select * from product;

        


		select
		    p.product_id,
		    p.category_id,
		    p.create_date,
		    p.product_name,
		    p.product_price,
		    ia.image_renamed_filename
		from 
		    product p
		left join 
		    image_attachment_mapping iam on p.product_id = iam.ref_id and iam.ref_table = 'product'
		left join
		    image_attachment ia ON iam.image_id = ia.image_id
        where
            p.category_id=1
        order by
            p.product_price desc;


select * from product where category_id = 1 order By product_price desc; --  가격 높은순
select * from product where category_id = 1 order By product_price asc; -- 가격 낮은순

select * from product where category_id = 1 order By create_date desc; --  최근 등록순

-- 별점순
select 
p.*,
DECODE(avg_star, NULL, 0.0, avg_star) AS review_star_rate
from 
product p left join
(SELECT product_id, ROUND(AVG(review_star_rate)) AS avg_star FROM review GROUP BY product_id) r
on r.product_id = p.product_id
where 
category_id = 1 
order By 
review_star_rate
 desc;
 
 -- 리뷰많은 순
 select 
p.*,
(select count(*) from review where product_id = p.product_id) reviewCnt
from 
product p
where 
category_id = 1
order by
reviewCnt
desc;


 
 
 select * from orderTbl;
 update orderTbl set order_status = 3 where order_no = '1693467409526'; 
 
 select * from review;
 
 
 
 
 		select 
		    p.product_id,
		    pd.product_detail_id,
		    p.product_name,
		    pd.option_name,
		    pd.option_value,
		    p.product_price,
		    pd.additional_price,
			ia.image_renamed_filename
		from 
		    product p 
		    left join 
		        product_detail pd on p.product_id = pd.product_id
		    left join 
		        cartitem ci on pd.product_detail_id = ci.product_detail_id
		    left join 
			    image_attachment_mapping iam on p.product_id = iam.ref_id and iam.ref_table = 'product'
		    left join
			    image_attachment ia ON iam.image_id = ia.image_id
		where 
		    pd.product_detail_id = 1;
            
            
            update orderTbl set order_status=3 where order_no='1693535898716';
            
            
            
            select * from product_detail;
            
            
            
		select
		    p.product_id,
		    p.category_id,
		    p.create_date,
		    p.product_name,
		    p.product_price,
		    ia.image_renamed_filename,
            DECODE(avg_star, NULL, 0.0, avg_star) AS review_star_rate,
            (select count(*) from review where product_id = p.product_id) reviewCnt
		from 
		    product p
		left join 
		    image_attachment_mapping iam on p.product_id = iam.ref_id and iam.ref_table = 'product'
		left join
		    image_attachment ia ON iam.image_id = ia.image_id
        left join
	        	(SELECT product_id, ROUND(AVG(review_star_rate)) AS avg_star FROM review GROUP BY product_id) r
	            on r.product_id = p.product_id
        where
            p.category_id= 1
        order by
            p.product_price;
            
            select * from member;
            
            select * from cartitem;
            delete from cartitem where cartitem_id = 67;
            
            select * from orderTbl where order_no = '1693539663229';
            select * from terms;
            delete from member where member_id= 'qwerty';
            select * from authority;
            select * from member;
            select * from product;

            
            
      		select
		    p.product_id,
		    p.category_id,
		    p.create_date,
		    p.product_name,
		    p.product_price,
		    ia.image_renamed_filename as thumbnail,
		    decode(avg_star, NULL, 0.0, avg_star) as review_star_rate,
		    (select count(*) from review where product_id = p.product_id) reviewCnt
		from 
		    product p
		join 
			image_attachment_mapping iam on p.product_id = iam.ref_id and iam.ref_table = 'product'
		join
			image_attachment ia ON iam.image_id = ia.image_id and ia.thumbnail = 'Y'
		left join
			(select product_id, round(avg(review_star_rate)) as avg_star from review group by product_id) r
			on p.product_id = r.product_id;
            
            select * from member;
            select * from authority;
            update authority set auth = 'ROLE_ADMIN' where member_id = '2999960622@kakao'; 
            select * from product where category_id = 4;
            delete from product where category_id = 4;
            
            drop 
            
            
            select * from product;
         select
		    p.product_id,
            pd.product_detail_id,
		    p.category_id,
		    p.create_date,
		    p.product_name,
		    p.product_price,
		    ia.image_renamed_filename as thumbnail,
		    decode(avg_star, NULL, 0.0, avg_star) as review_star_rate,
		    (select count(*) from review where product_id = p.product_id) reviewCnt
		from 
		    product p
        join 
            product_detail pd on p.product_id = pd.product_id
		join 
			image_attachment_mapping iam on p.product_id = iam.ref_id and iam.ref_table = 'product'
		join
			image_attachment ia ON iam.image_id = ia.image_id and ia.thumbnail = 'Y'
		left join
			(select product_id, round(avg(review_star_rate)) as avg_star from review group by product_id) r
			on p.product_id = r.product_id;

select * from product;
select * from product_detail;

		select
		    p.product_id,
		    p.category_id,
		    (select category_name from product_category where category_id = p.category_id) category_name,
		    p.create_date,
		    p.product_name,
		    p.product_price,
		    ia.image_renamed_filename as thumbnail,
		    decode(avg_star, NULL, 0.0, avg_star) as review_star_rate,
		    (select count(*) from review where product_id = p.product_id) reviewCnt
		from 
		    product p
		join 
			image_attachment_mapping iam on p.product_id = iam.ref_id and iam.ref_table = 'product'
		join
			image_attachment ia ON iam.image_id = ia.image_id and ia.thumbnail = 'Y'
		left join
			(select product_id, round(avg(review_star_rate)) as avg_star from review group by product_id) r
			on p.product_id = r.product_id;
            
		select
		    p.product_id,
		    p.category_id,
            pd.*,
		    (select category_name from product_category where category_id = p.category_id) category_name,
		    p.product_name,
		    p.product_price,
		    ia.image_renamed_filename as thumbnail
		from 
		    product p
        join
            product_detail pd on p.product_id = pd.product_id
		join 
			image_attachment_mapping iam on p.product_id = iam.ref_id and iam.ref_table = 'product'
		join
			image_attachment ia ON iam.image_id = ia.image_id and ia.thumbnail = 'Y'
		left join
			(select product_id, round(avg(review_star_rate)) as avg_star from review group by product_id) r
			on p.product_id = r.product_id;

select * from member;
update orderTbl set order_status = 3 where order_no = '1693809377750';
update authority set auth = 'ROLE_ADMIN' where member_id= 'sinsa1234';
select * from cancel_order;
		select
		    p.product_id,
		    p.category_id,
            
		    (select category_name from product_category where category_id = p.category_id) category_name,
		    p.product_name,
		    p.product_price,
		    ia.image_renamed_filename as thumbnail
		from 
		    product p
		join 
			image_attachment_mapping iam on p.product_id = iam.ref_id and iam.ref_table = 'product'
		join
			image_attachment ia ON iam.image_id = ia.image_id and ia.thumbnail = 'Y'
		left join
			(select product_id, round(avg(review_star_rate)) as avg_star from review group by product_id) r
			on p.product_id = r.product_id;

select * from product_category;


create table cancel_order (
    cancel_id number,
    request_date timestamp default systimestamp not null,
    receipt_date timestamp,
    cancel_status number default 0 not null,
    order_id number,
    constraint pk_cancel_id primary key(cancel_id),
    constraint fk_cancel_order_id foreign key(order_id) references orderTbl(order_id) on delete cascade
);

select * from cancel_order;

select 
    c.* 
from 
    cancel_order c
where
    c.order_id in (select order_id from orderTbl where member_id='dami');
    
select * from orderTbl where member_id='dami';

select * from product;
delete from product where product_id = 68;
update orderTbl set order_status=3 where order_no='1693815010798';
update orderTbl set order_date='23/02/18' order_no='1693815010798';
select * from orderTbl where member_id='hulk1512';
select * from member;
update orderTbl set order_status = 3 where member_id = 'hulk1512' and order_status=0;
delete from member where member_id = 'honggd';
update member set email = 'sinsa11@daum.net' where member_id = 'sinsa1234';
select * from member;
select count(*) from(select * from orderTbl where order_status = 4 and member_id='sinsa1234');
    select * from member;
   select
      m.name,
      m.phone,
      m.address,
      ot.order_no,
      ot.order_date,
      ot.order_status,
      ot.total_price,
      p.payment_method,
      p.payment_date,
      ot.payment_status,
      ot.amount,
      ot.discount
   from
      orderTbl ot left join member m on ot.member_id = m.member_id
      left join payment p on p.order_id = ot.order_id
   where
      ot.member_id = 'sinsa1234'
      and
      ot.order_status = 4;

Insert into PRODUCT_CATEGORY values (1,'사료');
Insert into PRODUCT_CATEGORY values (2,'간식');
Insert into PRODUCT_CATEGORY values (3,'패션용품');
Insert into PRODUCT_CATEGORY values (4,'산책용품');
Insert into PRODUCT_CATEGORY values (5,'위생용품');
Insert into PRODUCT_CATEGORY values (6,'장난감');
Insert into PRODUCT_CATEGORY values (7,'고양이');
Insert into PRODUCT_CATEGORY values (8,'기타용품');
