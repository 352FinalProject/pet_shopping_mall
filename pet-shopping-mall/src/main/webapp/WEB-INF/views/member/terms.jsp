<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/templates/header.jsp"%>
<section class="terms-section">
	<div>
		<form action="" id="joinForm">
			<ul class="join_box">
				<li class="checkBoxcheckTerms">
					<div class="terms-title">
						<input type="checkbox" name="checkAll" id="checkAll"
							onchange="toggleCheckBox();" /><label for="checkAll">전체선택</label>
						</br>이용약관, 개인정보 수집 및 이용, 위치정보 이용약관<span2>(선택)</span2>, 프로모션 안내 메일 수신<span2>(선택)</span2>에 모두 동의합니다. 
					</div>
				</li>
				<li class="checkBoxcheckTerms">
					<ul class="clearfix">
						<li class="checkBtn"><input id="checkBox1" type="checkbox"
							onclick="checkbox();" name="chk">이용약관 동의 <span>(필수)</span></li>
					</ul> <textarea class="terms-content" name="" id="">여러분을 환영합니다.
네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
				</li>
				<li class="checkBoxcheckTerms">
					<ul class="clearfix">
						<li class="checkBtn"><input id="checkBox2" type="checkbox"
							onclick="checkbox();" name="chk">개인정보 수집 및 이용에 대한 안내 <span>(필수)</span></li>
					</ul> <textarea class="terms-content" name="" id="">여러분을 환영합니다.
네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
				</li>
				<li class="checkBoxcheckTerms">
					<ul class="clearfix">
						<li class="checkBtn"><input type="checkbox" name="chk">
						위치정보 이용약관 동의 <span2>(선택)</span2></li>
					</ul> <textarea class="terms-content" name="" id="">여러분을 환영합니다.
네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
       </textarea>
				</li>
				<li class="checkBoxcheckTerms">
					<ul class="clearfix">
						<li class="checkBtn"><input type="checkbox" name="chk">
						이벤트 등 프로모션 알림 메일 수신 <span2>(선택)</span2></li>
					</ul>

				</li>
			</ul>
				<ul class="footBtwrap clearfix">
					<li><button id="disabled-button" type="button" disabled
							class="fpmgBt1" onclick="next();">동의</button></li>
					<!--  <li><button type="button" class="fpmgBt1"
					onclick="location.href= '<%=request.getContextPath()%>/';">비동의</button></li> -->
				</ul>
		</form>
	</div>
</section>
<script>


const checkbox = () => {
	const target = document.getElementById("disabled-button");
	const checkBox1 = document.getElementById("checkBox1");
	const checkBox2 = document.getElementById("checkBox2");
	const checkAll = document.getElementById("checkAll");
	
	if(checkBox1.checked && checkBox2.checked || checkAll.checked && checkBox1.checked && checkBox2.checked ){
		target.disabled = false;
	} else {
		target.disabled = true;
	}
};

	 
const next = () => {
	const box1 = document.querySelector("#checkBox1");
	const box2 = document.querySelector("#checkBox2");
	
	if(box1.checked && box2.checked ){
		location.href = '<%=request.getContextPath()%>/member/memberCreate';
	} else{
		alert("필수항목 체크해주세요");
	}
};

const toggleCheckBox = () => {
	const checkAll = document.getElementById("checkAll");
	
	const boxs = document.getElementsByName("chk"); // 태그 객체 배열
	
	for(let i=0; i<boxs.length; i++) {
		boxs[i].checked = checkAll.checked;
	}
	checkbox();
	
};
</script>
<%@ include file="/WEB-INF/views/templates/footer.jsp"%>