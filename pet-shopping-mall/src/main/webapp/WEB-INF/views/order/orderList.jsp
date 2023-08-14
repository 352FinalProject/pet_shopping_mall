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
        </style>
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
                                <p>12345555555</p> <button>취소 신청</button>
                            </td>
                            <td>
                                <a href="<%= request.getContextPath() %>/member/order_details">

                                    <div class="flex">
                                        <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg"
                                            alt="">
                                        <div>
                                            <p>리드줄</p>
                                            <br>
                                            <p>옵션: 노란색</p>
                                            <p>수량: 1개</p>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>7,990원</td>
                            <td>
                                <h3>주문 완료</h3>
                            </td>
                        </tr>
                        <tr>
                            <td>2023.08.06</td>
                            <td>
                                <p>12345555555</p> <button>교환/환불 신청</button>

                            </td>
                            <td>
                                <a href="<%= request.getContextPath() %>/member/order_details">

                                    <div class="flex">
                                        <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg"
                                            alt="">
                                        <div>
                                            <p>리드줄</p>
                                            <br>
                                            <p>옵션: 노란색</p>
                                            <p>수량: 1개</p>
                                        </div>
                                    </div>
                                </a>
                            </td>
                            <td>7,990원</td>
                            <td>
                                <h3>주문 완료</h3> <button>리뷰쓰기</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>


    </body>

    </html>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />