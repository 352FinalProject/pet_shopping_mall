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

            .list {
                display: flex;
                flex-wrap: wrap;
            }

            .box {
                width: 275px;
                height: 400px;
                margin-right: 25px;
            }

            .box>img {
                width: 100%;
                height: 275px;
                object-fit: cover;
                margin-bottom: 10px;
            }

            .box p {
                font-size: 14px;
                margin: 0;
                padding-bottom: 10px;
            }

            .box h5 {
                margin: 0;
                line-height: 20px;
                font-size: 16px;
            }

            .box span {
                font-size: 14px;
            }

            .box span img {
                width: 10px;
                height: 10px;
                object-fit: cover;
                margin-right: 5px;
            }


            .box:nth-child(4n) {
                margin-right: 0;
            }
        </style>
        <div class="container">
            <div class="sub_title">찜 목록</div>
            <div class="list">
                <div class="box">
                    <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg" alt="">
                    <p>초경량 강아지 목줄 부드러운 초소형견 소형견 중형견 목줄</p>
                    <h5>11,000원</h5>
                    <span><img src="${pageContext.request.contextPath }/resources/images/상품/star.png" alt="">5.0 | 후기
                        153건</span>
                </div>
                <div class="box">
                    <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg" alt="">
                    <p>초경량 강아지 목줄 부드러운 초소형견 소형견 중형견 목줄</p>
                    <h5>11,000원</h5>
                    <span><img src="${pageContext.request.contextPath }/resources/images/상품/star.png" alt="">5.0 | 후기
                        153건</span>
                </div>
                <div class="box">
                    <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg" alt="">
                    <p>초경량 강아지 목줄 부드러운 초소형견 소형견 중형견 목줄</p>
                    <h5>11,000원</h5>
                    <span><img src="${pageContext.request.contextPath }/resources/images/상품/star.png" alt="">5.0 | 후기
                        153건</span>
                </div>
                <div class="box">
                    <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg" alt="">
                    <p>초경량 강아지 목줄 부드러운 초소형견 소형견 중형견 목줄</p>
                    <h5>11,000원</h5>
                    <span><img src="${pageContext.request.contextPath }/resources/images/상품/star.png" alt="">5.0 | 후기
                        153건</span>
                </div>
                <div class="box">
                    <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg" alt="">
                    <p>초경량 강아지 목줄 부드러운 초소형견 소형견 중형견 목줄</p>
                    <h5>11,000원</h5>
                    <span><img src="${pageContext.request.contextPath }/resources/images/상품/star.png" alt="">5.0 | 후기
                        153건</span>
                </div>
                <div class="box">
                    <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg" alt="">
                    <p>초경량 강아지 목줄 부드러운 초소형견 소형견 중형견 목줄</p>
                    <h5>11,000원</h5>
                    <span><img src="${pageContext.request.contextPath }/resources/images/상품/star.png" alt="">5.0 | 후기
                        153건</span>
                </div>
                <div class="box">
                    <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg" alt="">
                    <p>초경량 강아지 목줄 부드러운 초소형견 소형견 중형견 목줄</p>
                    <h5>11,000원</h5>
                    <span><img src="${pageContext.request.contextPath }/resources/images/상품/star.png" alt="">5.0 | 후기
                        153건</span>
                </div>
                <div class="box">
                    <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg" alt="">
                    <p>초경량 강아지 목줄 부드러운 초소형견 소형견 중형견 목줄</p>
                    <h5>11,000원</h5>
                    <span><img src="${pageContext.request.contextPath }/resources/images/상품/star.png" alt="">5.0 | 후기
                        153건</span>
                </div>
                <div class="box">
                    <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg" alt="">
                    <p>초경량 강아지 목줄 부드러운 초소형견 소형견 중형견 목줄</p>
                    <h5>11,000원</h5>
                    <span><img src="${pageContext.request.contextPath }/resources/images/상품/star.png" alt="">5.0 | 후기
                        153건</span>
                </div>
                <div class="box">
                    <img src="${pageContext.request.contextPath }/resources/images/상품/1.jpeg" alt="">
                    <p>초경량 강아지 목줄 부드러운 초소형견 소형견 중형견 목줄</p>
                    <h5>11,000원</h5>
                    <span><img src="${pageContext.request.contextPath }/resources/images/상품/star.png" alt="">5.0 | 후기
                        153건</span>
                </div>

            </div>
        </div>


    </body>

    </html>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />