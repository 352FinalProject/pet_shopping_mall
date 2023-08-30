<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>

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

.sub_menu a {
	margin-top: -2px;
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
	background-color: #f5f5f5;
}

.panel p {
	margin-top: 10px;
	margin-left: 15px;
	padding: 10px 18px;
	background-color: #f5f5f5;
	font-size: 15.5px;
	text-align: left;
	margin-top: -36px;
}

.panel p span {
	font-size: 20px;
	color: #ebdb4b;
	margin-right: 20px;
}

.panel span {
	font-size: 20px;
	color: #ebdb4b;
	margin-right: 20px;
}

.questions {
	width: 1200px;
}
    
.question {
	width: 100%;
	background-color: #fff;
	height: 65px;
	line-height: 65px;
	border: 0;
	border-bottom: 1px solid #ccc;
	text-align: start;
	font-size: 16px;
	outline: none;
	cursor: pointer;
}

.question span {
	color: #426ee9;
	font-size: 20px;
	margin-right: 8px;
}

#question_search {
	width: 300px;
	height: 30px;
}

.A {
    margin-top: 10px;
    margin-left: 10px;
}

</style>
<section class="common-section" id="#">
	<div class="common-title">고객센터</div>
	<div class="common-container">
		<div class="common-div">
			<ul class="sub_menu">
				<li><a
					href="<%= request.getContextPath() %>/servicecenter/inquiry/questionList.do">1:1
						문의</a></li>
			</ul>
			<div class="questions">
				<div class="question_top">
					<p>자주 묻는 질문 TOP5</p>
				</div>
				<div class="question_list">
					<button class="question">
						<span>Q</span> 회원으로 가입하지 않고 상품을 구매할 수 있나요?
					</button>
					<div class="panel">
						<div class="A"><span>A</span> </div>
						<p>보호자님. 죄송스럽게도 우동친에서 판매하는 상품은 비회원으로 주문하실 수가 없습니다.<br/>
							온라인 주문 결제와 배송서비스를 받으실 수 있도록 회원가입 후 이용 부탁드립니다.
						</p>
					</div>
					<button class="question">
						<span>Q</span> 택배 배송 일정은 어떻게 되나요?
					</button>
					<div class="panel">
						<div class="A"><span>A</span> </div>
						<p>
							택배는 보통 오후 1시 이전 결제된 주문건의 경우 당일 출고가 진행되고 있습니다. (주말 및 공휴일 제외)
						</p>
					</div>
					<button class="question">
						<span>Q</span> 포인트는 어떻게 사용할 수 있나요?
					</button>
					<div class="panel">
						<div class="A"><span>A</span> </div>
						<p>
							포인트는 마이페이지 홈이나 포인트 내역에서 확인하실 수 있으며 구매하실 때 현금처럼 사용이 가능합니다.
						</p>
					</div>
					<button class="question">
						<span>Q</span> 상품에 대해서 물어보고 싶은데 어디서 물어보나요?
					</button>
					<div class="panel">
						<div class="A"><span>A</span> </div>
						<p>
							회원가입을 하셔야 문의글 작성이 가능하며 고객센터 1:1 문의 클릭 후 문의 부탁드립니다. 
						</p>
					</div>
					<button class="question">
						<span>Q</span> 상품 유통기한 기준은 어떻게 되나요?
					</button>
					<div class="panel">
						<div class="A"><span>A</span> </div>
						<p>
							상품마다 유통기한 기준은 다르니, 우선적으로 상품 상세설명을 참고해주시고 자세한 사항은 고객센터로 문의 부탁드립니다. 
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

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