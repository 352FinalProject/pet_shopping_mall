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

------------------ point insert ---------------------------
INSERT INTO point (point_id, point_member_id, point_current, point_type, point_amount)
VALUES (2, '사용자2', 50, '사용', -500, SYSTIMESTAMP);

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
select * from product;

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
commit;



------------------ point insert ---------------------------
insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date)
values (seq_point_point_id.nextval, 'member1', 1000, '적립', 500, to_date('2023-08-09', 'yyyy-mm-dd'));

insert into point (point_id, point_member_id, point_current, point_type, point_amount, point_date)
values (seq_point_point_id.nextval, 'member1', 800, '사용', -200, to_date('2023-08-09', 'yyyy-mm-dd'));


select * from pet;

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


-- 장바구니 테스트 데이터
select * from product_category;
insert into product_category values(1, '사료');
insert into product_category values(2, '옷');
insert into product values(seq_product_id.nextval, 1, '에르메스 사료', 15000, 1, 1, systimestamp, systimestamp, 111, 111);
insert into product values(seq_product_id.nextval, 2, '꼬까옷', 17000, 2, 2, systimestamp, systimestamp, 222, 222);
select * from cartitem;
select* from product;
select * from product_detail;

update cartitem set product_detail_id=2 where product_detail_id=1;

insert into product_detail values(seq_product_detail_id.nextval, 1, '추가1', '금칠 추가', 190000, 2, 1);
insert into product_detail values(seq_product_detail_id.nextval, 2, '추가2', '빨간망토', 1900, 9, 1);

insert into cartitem values(seq_cartitem_id.nextval, 1, 2, 2);

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
    

-- 이렇게 불러오기..    
select 
    p.*,
    pd.*
from 
    product p left join product_detail pd on p.product_id = pd.product_id
    left join cartitem ci on pd.product_detail_id = ci.product_detail_id
where 
    ci.product_detail_id = 2;
    
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
    