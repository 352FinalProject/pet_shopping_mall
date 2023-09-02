<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
.terms-section {
    width: 1200px;
    margin: 50px auto;
    font-family: 'Arial', sans-serif;
    background-color: #f5f5f5;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.terms-section ul {
    list-style-type: none;
    padding: 0;
}

.join_box {
    margin-bottom: 30px;
}

.checkBoxcheckTerms {
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    margin-bottom: 15px;
    border: 1px solid #ddd;
}

.terms-title {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 10px;
}

.terms-title input[type="checkbox"] {
    margin-right: 10px;
}

.terms-title label {
    cursor: pointer;
}

.terms-section span2 {
    color: #5886d3;
    font-weight: 600;
}

.terms-section span {
	color: red;
	font-weight: 600;
}

.clearfix::after {
    content: "";
    clear: both;
    display: table;
}

.checkBtn {
    margin-bottom: 10px;
}

.terms-content {
    width: 100%;
    height: 150px;
    resize: none;
    border: 1px solid #ddd;
    padding: 10px;
    font-size: 14px;
    border-radius: 5px;
}

.footBtwrap {
    margin-top: 20px;
}

.footBtwrap li {
    float: left;
    margin-right: 10px;
}

.fpmgBt1 {
    background-color: #c8c8c8;
    color: #fff;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.fpmgBt1:hover {
    background-color: #5886d3;
}

#disabled-button {
    background-color: #c8c8c8;
}

</style>
<section class="terms-section">
	<div>
		<form action="" id="joinForm">
			<ul class="join_box">
				<li class="checkBoxcheckTerms">
					<div class="terms-title">
						<input type="checkbox" name="checkAll" id="checkAll" 
							onchange="toggleCheckBox();" /><label for="checkAll">전체선택</label>
						</br>이용약관 동의, 개인정보 수집 및 이용에 대한 안내<span>(필수)</span>, 이벤트 등 프로모션 알림 메일 수신<span2>(선택)</span2>에 모두 동의합니다. 
					</div>
				</li>
				<li class="checkBoxcheckTerms">
					<ul class="clearfix">
						<li class="checkBtn"><input id="checkBox1" type="checkbox"
							onclick="checkbox(); sendData();" name="chk">이용약관 동의 <span>(필수)</span></li>
					</ul> <textarea class="terms-content" name="" id="">여러분을 환영합니다.
우리집동물친구 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 우리집동물친구 서비스의 이용과 관련하여 반려동물 쇼핑몰 서비스를 제공하는 우리집동물친구(이하 ‘우동친’)와 이를 이용하는 우리집동물친구 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 우리집동물친구 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
				</li>
				<li class="checkBoxcheckTerms">
					<ul class="clearfix">
						<li class="checkBtn"><input id="checkBox2" type="checkbox"
							onclick="checkbox(); sendData();" name="chk">개인정보 수집 및 이용에 대한 안내 <span>(필수)</span></li>
					</ul> <textarea class="terms-content" name="" id="">
개인정보보호법에 따라 우동친에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.

1. 수집하는 개인정보
이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 우동친 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 우동친는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.
       </textarea>
				</li>
				<li class="checkBoxcheckTerms">
					<ul class="clearfix">
						<input id="promotionEmailAccept" type="checkbox" name="chk" onclick="sendData();" >
						이벤트 등 프로모션 알림 메일 수신 <span2>(선택)</span2></li>
					</ul><textarea class="terms-content" name="" id="">우동친 서비스 및 제휴 이벤트・혜택 등의 정보를 휴대전화(우동친앱 알림 또는 문자), 이메일로 받을 수 있습니다. 일부 서비스(별개의 회원 체계 운영, 우동친 가입 후 추가 가입하는 서비스 등)의 경우, 수신에 대해 별도로 안내드리며 동의를 구합니다.
       </textarea>

				</li>
			</ul>
				<ul class="footBtwrap clearfix">
					<li><button id="disabled-button" type="button" disabled
							class="fpmgBt1" onclick="next();">동의</button></li>
				 <li><button type="button" class="fpmgBt1"
					onclick="location.href= '${pageContext.request.contextPath}/'">비동의</button></li>
				</ul>
		</form>
	</div>
</section>
<script src="${pageContext.request.contextPath}/resources/js/terms.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>