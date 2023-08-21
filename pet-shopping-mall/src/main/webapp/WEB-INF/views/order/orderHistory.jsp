<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        .container {
            margin: 0 auto;
            max-width: 1200px;
        }

        .sub_title {
            font-size: 32px;
            font-weight: bold;
            text-align: center;
            line-height: 120px;
        }
        #select {
            position: relative;
            outline: none;
            display: block;
            width: 150px;
            margin: 30px 0;
            font-size: 17px;
            color: #333;
            height: 40px;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            padding-right: 30px;
            padding-left: 10px;
            background: url('${pageContext.request.contextPath }/resources/images/상품/arrow-down.png') no-repeat 95% 50%/15px auto;
            border: 1px solid #999;
        }

        .order_top {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        a {
            color: #999;
            text-decoration: none;
        }

        table a {
            color: #333;
        }

        #order_table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
        }

        #order_table thead {
            width: 100%;
            height: 50px;
            border-top: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
        }

        #order_table tr td {
            height: 150px;
            border-bottom: 1px solid #ccc;
            text-align: center;
            vertical-align: middle;
        }

        #order_table tr td:nth-child(1),
        #order_table tr td:nth-child(2),
        #order_table tr td:nth-child(4),
        #order_table tr td:nth-child(5) {
            width: 20%;
        }

        #order_table tr td:nth-child(3) {
            width: 30%; /* Adjusted width for product information */
        }

        #order_table img {
            width: 130px;
            height: 130px;
            margin: 10px;
            margin-right: 30px;
            margin-left: 50px;
        }

        #order_table button {
            border: 1px solid #ccc;
            color: #ccc;
            width: 80%;
            margin: 0 auto;
            height: 35px;
            font-size: 17px;
            background-color: #fff;
            cursor: pointer;
        }

        .flex {
            display: flex;
            align-items: center;
        }

        .product-info {
            text-align: left;
            padding-left: 20px;
        }

        .product-info p {
            margin: 0;
            padding: 0;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="sub_title">주문내역</div>
        <div class="order">
            <div class="order_top">
                <select name="select" id="select">
                    <option value="3">최근 3개월</option>
                    <option value="6">최근 6개월</option>
                    <option value="9">최근 9개월</option>
                    <option value="12">최근 12개월</option>
                </select>
                <a style="margin-bottom: 10px;" href="#">내가 쓴 상품 후기 ▶</a>
            </div>
            <table id="order_table">
                <thead>
                    <tr>
                        <th>날짜</th>
                        <th>주문번호</th>
                        <th>상품</th>
                        <th>주문금액</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>2023.08.06</td>
                        <td>
                            <span>1234555555</span>
                            <button class="exchange-refund">교환/환불신청</button>
                        </td>
                        <td>
                            <img alt="상품이미지" class="product-img" src="${pageContext.request.contextPath}/resources/images/상품/1.jpeg">
                            <div class="product-desc">
                                <span class="product-name">리드줄 리드줄</span>
                                <span class="product-options">옵션: 노란색</span>
                                <span class="product-amount">수량: 1개</span>
                            </div>
                        </td>
                        <td>7,990원</td>
                        <td class="order-status">주문완료</td>
                    </tr>
                </tbody>
            </table>
            <div class="order-detail">
                <div class="order-detail-wrapper">
                    <!-- 주문자 -->
                    <div class="order-info client">
                        <div class="title">주문자</div>
                        <div class="info-details"></div>
                        <div class="info-details"></div>
                    </div>
                    <!-- 배송지 -->
                    <div class="order-info delivery-location">
                        <div class="title">배송지</div>
                        <div class="info-details"></div>
                        <div class="info-details"></div>
                    </div>
                    <!-- 배송현황 -->
                    <div class="order-info delivery-status">
                        <div class="title">배송현황</div>
                        <div class="info-details"></div>
                        <div class="info-details"></div>
                    </div>
                    <!-- 결제금액 -->
                    <div class="order-info total-price">
                        <div class="title">결제금액</div>
                    </div>
                    <!-- 주문결제정보 -->
                    <div class="order-info details">
                        <div class="title">주문결제정보</div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
