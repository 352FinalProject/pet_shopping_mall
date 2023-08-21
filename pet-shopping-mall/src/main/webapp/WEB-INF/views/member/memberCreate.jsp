<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
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

button, input {
	cursor: pointer;
}
</style>
<!-- 회원가입 (혜령) -->
<section class="common-section" id="#">
	<div class="common-title">회원가입</div>
	<br>
	<div class="common-container">
		<div class="common-div">
			<form:form name="memberCreateFrm" action="" method="POST">
				<table>
					<tr>
						<th>아이디</th>
						<td>
							<div id="memberId-container">
								<input type="text"
								class="form-control"
								placeholder=""
								name="memberId"
								id="memberId"
								value=""
								pattern="\w{4,}"
								required>
								<input type="button" id="idCheckButton" value="중복 확인">
								<input type="hidden" id="idValid" value="0"/>
							</div>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="name" id="name" value=""
							required></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="password" id="password"
							value="" required></td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td><input type="password" id="passwordConfirm" value=""
							required></td>
					</tr>
					<tr>
						<th>핸드폰 번호</th>
						<td><input type="tel" name="phone" id="tel" value="" required>
							<input type="button" value="핸드폰 인증" onclick="telCheck()">
						</td>
					</tr>
					<tr>
						<th>생일</th>
						<td><input type="date" name="birthday" id="birthday" required>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type="email" name="email" id="email"
							placeholder="" required></td>
					</tr>
					<tr>
						<th>주소</th>
						<td><input type="text" name="address" id="address" required>
							<input type="button" value="주소 검색"></td>
					</tr>
					<tr>
						<td class="resetAndSubmit" colspan="2">
							<form action="/member/memberCreateComplte.do">
								<input type="reset" value="돌아가기"> <input type="submit"
									value="가입하기">
							</form>
						</td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
</section>
<script>
document.querySelector("#idCheckButton").onclick = () => {
	const memberIdInput = document.querySelector("#memberId");
	const value = memberIdInput.value;

	if (value.length >= 4) {
		$.ajax({
			url: "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
			data: {
				memberId: value
			},
			method: "GET",
			dataType: "json",
			success: function(responseData) {
				console.log(responseData);
				const idValid = document.querySelector("#idValid");
				const guideOk = document.querySelector(".guide.ok");
				const guideError = document.querySelector(".guide.error");
				
				const { available } = responseData;
				if (available) {
					alert("사용 가능한 아이디입니다.");
					guideOk.style.display = "inline";
					guideError.style.display = "none";
					idValid.value = "1";
				} else {
					alert("이미 사용 중인 아이디입니다.");
					guideOk.style.display = "none";
					guideError.style.display = "inline";
					idValid.value = "0";
				}
			}
		});
	} else {
		alert("아이디를 최소 4자 이상 입력해주세요.");
		idValid.value = "0";
	}
};

document.memberCreateFrm.onsubmit = (e) => {
	const idValid = document.querySelector("#idValid");
	const password = document.querySelector("#password");
	const passwordConfirmation = document.querySelector("#passwordConfirm");

	if (idValid.value === "0") {
		alert("사용 가능한 아이디를 입력해주세요.");
		return false;
	}

	if (password.value !== passwordConfirmation.value) {
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />