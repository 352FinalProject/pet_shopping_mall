<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
.common-section {
	display: flex;
	flex-direction: column;
	margin: 100px;
}

.common-div {
	justify-content: center;
	align-items: left;
	display: flex;
}

/* 회원가입 타이틀 */
.common-title {
	font-size: 24px;
	justify-content: center;
	display: flex;
}

/* input 글씨 왼쪽정렬 */
.common-div table th {
	text-align: left;
}

/* 테이블 사이 간격 */
.common-div table td {
	padding: 5px;
}

/* input-button 태그 */
.common-div table td input {
	height: 30px;
	border-radius: 10px;
	border: 1px solid lightgray;
	background-color: white;
}

.common-div table td input[type="email"] {
	margin-bottom: 12px;
}

/* input 태그 */
.common-div table td input[type="text"], .common-div table td input[type="password"],
	.common-div table td input[type="tel"], .common-div table td input[type="date"],
	.common-div table td input[type="email"] {
	margin-right: 10px;
	margin-left: 10px;
	width: 250px;
	border-radius: 20px;
	height: 40px;
	border: 1px solid lightgray;
	padding: 2px 15px; /* 위아래 2px 좌우 15px 패딩 조정 */
}

/* 돌아가기&가입하기 버튼 */
.resetAndSubmit {
	text-align: center;
}

/* 돌아가기 버튼 */
.resetAndSubmit input[type="reset"] {
	background-color: #c8c8c8;
	margin-right: 10px;
	width: 120px;
	height: 40px;
	border-radius: 20px;
	color: white;
	border: 1px solid #e7e7e7;
	margin-top: 30px;
}

/* 가입하기 버튼 */
.resetAndSubmit input[type="submit"] {
	background-color: #5886d3;
	width: 120px;
	height: 40px;
	border-radius: 20px;
	border: 1px solid #e7e7e7;
	color: white;
}
/* 펫 정보 행 스타일 */
.pet-info-container {
	vertical-align: top; /* 맨 위로 정렬 */
}

/* pet-info 요소들 오른쪽 정렬 */
.pet-info {
	display: flex;
	flex-direction: column;
	align-items: center; /* 가운데 정렬 */
	margin-top: 10px; /* 각 요소 사이 간격 조정 */
}

.pet-info div {
	color: blue;
}

button, input {
	cursor: pointer;
}

</style>

<!-- 마이페이지 (혜령) -->
<!-- 아이디, 이름, 생일 수정X -->
<section class="common-section" id="#">
	<div class="common-title">회원정보 수정</div>
	<br>
	<div class="common-container">
		<div class="common-div">
			<form:form name="memberUpdateFrm"
				action="${pageContext.request.contextPath}/member/updateMember.do"
				method="POST">
				<table>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="memberId" id="memberId"
							value="${member.memberId}" required readonly /></td>
						<td rowspan="2" class="pet-info-container"></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="name" id="name"
							value="${member.name}" required readonly></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="password" id="password"
							value="" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
							title="최소 8자, 대소문자 및 숫자를 포함해야 합니다." required></td>
						<td rowspan="2" class="pet-info-container"></td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td><input type="password" id="passwordConfirm" value=""
							required></td>
					</tr>
					<tr>
						<th>핸드폰 번호</th>
						<td><input type="tel" name="phone" id="phone"
							value="${member.phone}" required></td>
						<td rowspan="2" class="pet-info-container"></td>
					</tr>
					<tr>
						<th>생일</th>
						<td><input type="date" name="birthday" id="birthday"
							value="${member.birthday}" readonly required></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type="email" name="email" id="email"
							placeholder="이메일" value="${member.email}" required readonly>
						</td>
					</tr>
					<%--  <tr>
						<th>주소</th> <!-- value="${member.address}" 생략되었지만 getter 사용됨 -->
						<td><input type="text" name="address" id="address"
							value="${member.address}" required> <input 
							type="button" onclick="sample4_execDaumPostcode();"  value="주소 검색"></td>
					</tr>  --%>
					<tr>
						<th>주소</th>
						<td>
							<div>
								<input type="text" name="address" id="address" value="${member.address}" />
							</div>
							<div style="text-align: right; margin-left:280px; margin-top:-30px;" >
								<input type="button" class="address"
									onclick="sample4_execDaumPostcode();" value="주소 검색">
							</div> <br>
							<div style="margin-top: -60px; position: absolute;">
								<input type="hidden" class="address" id="roadAddress"
									placeholder="도로명주소" oninput="updateAddress()">
							</div> <br>
							<div style="margin-top: -30px;">
								<input type="hidden" class="address" id="jibunAddress"
									placeholder="지번주소" oninput="updateAddress()">
							</div> <br> <span id="guide" style="color: #999; display: none"></span>
							<div style="margin-top: -10px;">
								<input type="hidden" class="address" id="detailAddress"
									placeholder="상세주소" oninput="updateAddress()">
							</div> 
						</td>
					</tr>
					<tr>
						<td class="resetAndSubmit" colspan="2"><input type="reset"
							value="돌아가기"
							onclick="location.href='${pageContext.request.contextPath}/'">
							<input type="submit" value="수정하기"></td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
	<div id="kakaoInput" hidden="true">
		<input type="text" id="sample4_postcode" placeholder="우편번호"> <input
			type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" id="extraAddress" placeholder="참고항목">
	</div>
</section>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

	function sample4_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var roadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 참고 항목 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample4_postcode').value = data.zonecode;
						document.getElementById("roadAddress").value = roadAddr;
						document.getElementById("jibunAddress").value = data.jibunAddress;

						// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						if (roadAddr !== '') {
							document.getElementById("extraAddress").value = extraRoadAddr;

						} else {
							document.getElementById("extraAddress").value = '';
						}
						document.getElementById('roadAddress').value = roadAddr;

						// 도로명 주소와 지번 주소, 상세 주소를 합쳐서 전체 주소로 설정한다.
						var jibunAddress = data.jibunAddress; // Add this line
						var fullAddress = roadAddr
								+ jibunAddress
								+ " "
								+ document.getElementById("detailAddress").value;
						document.getElementById("address").value = fullAddress;
					}
				}).open();
	};

	function updateAddress() {
		const roadAddress = document.getElementById("roadAddress").value;
		const jibunAddress = document.getElementById("jibunAddress").value;
		const detailAddress = document.getElementById("detailAddress").value;

		var fullAddress = roadAddress + jibunAddress + " " + detailAddress;
		document.getElementById("address").value = fullAddress;
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />