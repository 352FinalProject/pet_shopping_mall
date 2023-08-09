<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
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

        .sub_menu {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding-bottom: 50px;
            border-bottom: 1px solid #ccc;
            margin-bottom: 80px;
        }


        .sub_menu li {
            padding: 0 50px;
            margin: 0 15px;
            border: 1px solid #ccc;
            text-align: center;
            height: 50px;
            line-height: 50px;
            cursor: pointer;
        }


        .question_top {
            display: flex;
            justify-content: space-between;
            width: 100%;
            border-bottom: 1px solid #ccc;
            align-items: flex-end;
            padding-bottom: 10px;
        }

        .question_top p {
            font-size: 22px;
            font-weight: bold;
        }

        .question_top form {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .question_top form button {
            height: 30px;
            width: auto;
            cursor: pointer;
            border: 0;
            background-color: #fff;
        }

        .question_top form button img {
            height: 100%;
            object-fit: cover;
        }

        .panel {

            background-color: #FFF;
            max-height: 0;
            overflow: hidden;
            transition: max-height .2s ease-out;
        }

        .panel p {
            margin: 10px 0;
            padding: 10px 18px;
            background-color: #f5f5f5;
            font-size: 18px;
        }

        .panel p span {
            font-size: 20px;
            color: #ebdb4b;
            margin-right: 20px;
        }

        .question {
            width: 100%;
            background-color: #fff;
            height: 65px;
            line-height: 65px;
            border: 0;
            border-bottom: 1px solid #ccc;
            text-align: start;
            font-size: 18px;
            outline: none;
            cursor: pointer;
        }

        .question span {
            color: #426ee9;
            font-size: 20px;
        }

        #question_search {
            width: 300px;
            height: 30px;
        }
    </style>
    <div class="container">
        <h3 class="sub_title">
            고객센터
        </h3>
        <ul class="sub_menu">
            <li><a href="<%= request.getContextPath() %>/servicecenter/">1:1 채팅</a></li>
            <li><a href="<%= request.getContextPath() %>/servicecenter/inquiry/questionList.do">1:1 문의</a></li>
        </ul>
        <div class="questions">
            <div class="question_top">
                <p>자주 묻는 질문 TOP5</p>
                <form action="" method="post">
                    <button type="submit"><img src="${pageContext.request.contextPath}/resources/images/home/search.png"
                            alt=""></button>
                    <input type="text" id="question_search">
                </form>
            </div>
            <div class="question_list">
                <button class="question"><span>Q</span> 교환/환불은 어떻게 하나요?</button>
                <div class="panel">
                    <p><span>A</span> Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
                        incididunt ut
                        labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
                        laboris nisi ut aliquip ex ea commodo consequat.</p>
                </div>
                <button class="question"><span>Q</span> 교환/환불은 어떻게 하나요?</button>
                <div class="panel">
                    <p><span>A</span>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
                        incididunt ut
                        labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
                        laboris nisi ut aliquip ex ea commodo consequat.</p>
                </div>
                <button class="question"><span>Q</span> 교환/환불은 어떻게 하나요?</button>
                <div class="panel">
                    <p><span>A</span>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
                        incididunt ut
                        labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
                        laboris nisi ut aliquip ex ea commodo consequat.</p>
                </div>

            </div>
        </div>
    </div>

    <script>
        var question = document.getElementsByClassName("question");
        var i;

        for (i = 0; i < question.length; i++) {
            question[i].addEventListener("click", function () {
                this.classList.toggle("active");
                var panel = this.nextElementSibling;
                if (panel.style.maxHeight) {
                    panel.style.maxHeight = null;
                } else {
                    panel.style.maxHeight = panel.scrollHeight + "px";
                }
            });
        }


    </script>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />