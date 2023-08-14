<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
    </head>

    <body>
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


            .s_title {
                height: 30px;
                font-size: 22px;
                font-weight: bold;
                line-height: 30px;
                display: flex;
                align-items: center;
            }

            .s_title a {
                height: 23px;
                line-height: 25px;
                padding: 0 8px;
                color: #555;
                font-size: 14px;
                border: 1px solid #ccc;
                margin-left: 5px;
            }

            .details {
                display: flex;
                justify-content: space-between;
                margin-top: 50px;
            }

            .area {
                width: 47%;

            }

            .box {
                width: 100%;
                height: 300px;

            }

            .mb {
                margin-bottom: 50px;
            }

            .s_box {
                width: 100%;
                height: 150px;
            }

            .border {
                width: 100%;
                min-height: 220px;
                border: 1px solid #ccc;
                padding-top: 10px;
                margin-top: 10px;
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
            }

            #order_table tr td:nth-child(1) {
                width: 15%;
            }

            #order_table tr td:nth-child(2) {
                width: 15%;
            }

            #order_table tr td:nth-child(3) {
                width: 40%;
            }

            #order_table tr td:nth-child(4) {
                width: 15%;
            }

            #order_table tr td:nth-child(5) {
                width: 15%;
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

            .flex div {
                height: 130px;
            }

            .flex p {
                margin: 0;
                margin-bottom: 5px;
            }

            .flex {
                margin-top: 10px;
                width: 100%;
                display: flex;
                align-items: center;
                text-align: left;

            }

            .flex_b {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 15px;
            }

            .flex_b p {
                line-height: 40px;
                margin: 0;
            }

            .flex_b p a {
                padding: 2px 7px;
                border: 1px solid #ccc;
                font-size: 14px;
                color: #555;
                margin-left: 5px;
            }

            .flex_b p span {
                color: red;
                margin-right: 5px;
            }

            .flex_b_B {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 15px;
            }

            .flex_b_B p {
                line-height: 40px;
                margin: 0;
                font-size: 20px;
                font-weight: bold;
            }

            .flex_b_h3 {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 15px;
            }

            .flex_b_h3 p {
                line-height: 50px;
                margin: 0;
                font-size: 24px;
                font-weight: bold;
            }

            .line {
                width: 100%;
                height: 1px;
                background-color: #333;
            }
        </style>
        <div class="container">
            <div class="sub_title">상세내용</div>
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
                            <p>12345555555</p> <button>취소 신청</button>
                        </td>
                        <td>
                            <div class="flex">
                                <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg" alt="">
                                <div>
                                    <p>리드줄</p>
                                    <br>
                                    <p>옵션: 노란색</p>
                                    <p>수량: 1개</p>
                                </div>
                            </div>
                        </td>
                        <td>7,990원</td>
                        <td>
                            <h3>주문 완료</h3>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="details">
                <div class="area">
                    <div class="s_box">
                        <div class="s_title">주문자</div>
                        <p>전예라</p>
                        <p>010-1234-5678</p>
                    </div>
                    <div class="s_box mb">
                        <div class="s_title">
                            <p>배송지</p> <a href="#">수정</a>
                        </div>
                        <p>전예라</p>
                        <p>010-1234-5678</p>
                        <p>[03321] 서울시 강남구 역삼동 kh정보교육원</p>
                    </div>
                    <div class="box">
                        <div class="s_title">배송현황</div>
                        <div class="border">
                            <div class="flex_b">
                                <p>택배사</p>
                                <p>kh택배</p>
                            </div>
                            <div class="flex_b">
                                <p>운송장번호<a href="#">배송조회</a></p>
                                <p>123-44-45455-22</p>
                            </div>
                            <div class="flex_b">
                                <p>배송상태</p>
                                <p>배송완료</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="area">
                    <div class="box mb">
                        <div class="s_title">결제금액</div>
                        <div class="border" style="height: 250px;">
                            <div class="flex_b_B">
                                <p>상품금액</p>
                                <p>11,100원</p>
                            </div>
                            <div class="flex_b">
                                <p>배송비</p>
                                <p><span>(+)</span>3,000원</p>
                            </div>
                            <div class="flex_b">
                                <p>쿠폰<a href="#">내역</a></p>
                                <p><span>(-)</span>생일축하 쿠폰 (10%)</p>
                            </div>
                            <div class="flex_b">
                                <p>적립금<a href="#">내역</a></p>
                                <p><span>(-)</span>2,000원</p>
                            </div>
                            <div class="flex_b">
                                <p>할인금액</p>
                                <p>3,110원</p>
                            </div>
                            <div class="line"></div>
                            <div class="flex_b_h3">
                                <p>최종 결제 금액</p>
                                <p>7,990원</p>
                            </div>
                        </div>
                    </div>
                    <div class="box">
                        <div class="s_title">배송현황</div>
                        <div class="border">
                            <div class="flex_b">
                                <p>주문번호</p>
                                <p>123444555555</p>
                            </div>
                            <div class="flex_b">
                                <p>주문날짜</p>
                                <p>2023.08.06</p>
                            </div>
                            <div class="flex_b">
                                <p>결제일시</p>
                                <p>2023.08.06 16:25:24</p>
                            </div>
                            <div class="flex_b">
                                <p>결제수단</p>
                                <p>카드결제</p>
                            </div>
                            <div class="flex_b">
                                <p>결제금액</p>
                                <p>7,990원</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </body>

    </html>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />