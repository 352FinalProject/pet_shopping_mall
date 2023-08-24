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

.guide.ok, .guide.error {
	display: none;
	color: red;
}

span duplicate {
	border: 2px solid red; /* 아이디 중복일 때 테두리 색상: 빨간색 */
}

#memberId-container {
	position: relative;
}

#memberId-container.valid input {
	border: 1px solid #5886d3; /* 파란색 테두리 */
}

#memberId-container.duplicate input {
	border: 1px solid red; /* 빨간색 테두리 */
}
</style>
<!-- 회원가입 (혜령) -->
<section class="common-section" id="#">
	<div class="common-title">회원가입</div>
	<br>
	<div class="common-container">
		<div class="common-div">
			<form:form name="memberCreateFrm"
				action="${pageContext.request.contextPath}/member/memberCreate.do"
				method="POST">
				<table>
					<tr>
						<th>아이디</th>
						<td>
							<div id="memberId-container">
								<input type="text" class="form-control" placeholder="아이디"
									name="memberId" id="memberId" value=""  pattern='[A-Za-z0-9_]{4,}' 
									title="알파벳 대소문자, 숫자, - 를 사용하여 4자 이상 입력하세요."
									required> <input type="hidden" id="idValid" value="0" />
								<span class="guide error">이 아이디는 이미 사용중입니다.</span>
							</div>
						</td>
					</tr>

					<tr>
						<th>이름</th>
						<td>
							<div class="memberName-container">
								<input type="text" name="name" id="name" value=""
									placeholder="이름" pattern="[가-힣A-Za-z]+" 
									title="한글 또는 영어 대소문자 한 글자 이상의 길이를 가져야 합니다. "
									required> <br>
							</div>
						</td>
					</tr>

					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="password" id="password"
							placeholder="비밀번호" value=""
							pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
							title="최소 8자, 대소문자 및 숫자를 포함해야 합니다." required></td>
					</tr>

					<tr>
						<th>비밀번호 확인</th>
						<td><input type="password" id="passwordConfirm" value=""
							placeholder="비밀번호 확인" required></td>
					</tr>

					<tr>
						<th>핸드폰 번호</th>
						<td><input class="" type="tel" name="phone" id="tel" value=""
							pattern="^010\d{8}$" title="010으로 시작하며 뒤에 8자리의 숫자가 오는 11자리 입력. "
							placeholder="핸드폰번호" required>
							</td>
					</tr>

					<tr>
						<th>생일</th>
						<td><input type="date" name="birthday" id="birthday"
							placeholder="생년월일" required
							pattern=" ^\d{4}-\d{2}-\d{2}$" title="연도, 월, 일이 각각 4자리, 2자리, 2자리 숫자입력.">
						</td>
					</tr>

					<tr>
						<th>이메일</th>
						<td><input type="email" name="email" id="emailInput"
							placeholder="이메일" value="" required> <input type="button"
							id="emailButton" value="이메일 인증" onclick="emailCheck()"
							pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$" title="부적합한 이메일 형식입니다.">
						</td>
					</tr>

					<tr>
						<th>주소</th>
						<td><input type="text" name="address" id="address"
							placeholder="주소" value="" required> <input type="button"
							value="주소 검색" pattern="^[가-힣0-9a-zA-Z\s-]+$" title="부적합한 주소 형식입니다.">
							</td>
					</tr>

					<tr>
						<td class="resetAndSubmit" colspan="2"><input type="reset"
							value="돌아가기"> <input type="submit" value="가입하기">
						</td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
</section>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
/* 이메일 인증 처리 */
let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");

/* 이메일 인증 처리 */
function emailCheck() {
    const email = document.getElementById('emailInput').value;
    
    if (!email.includes('@')) {
        alert('유효한 이메일을 입력해주세요.');
        return;
    }
    
    const xhr = new XMLHttpRequest();
    
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                const data = JSON.parse(xhr.responseText);
                if (data.success) {
                    alert('인증 메일이 발송되었습니다. 이메일을 확인해주세요.');
                } else {
                    alert('인증 메일이 발송되었습니다. 이메일을 확인해주세요.');
                }
            } else {
                alert('인증 메일이 발송되었습니다. 이메일을 확인해주세요.');
            }
        }
    };

    xhr.open('POST', `${pageContext.request.contextPath}/email/send`, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.setRequestHeader("X-CSRF-TOKEN", token);
    xhr.send(JSON.stringify({ email: email }));
}
	
/* 유효성 검사 */
$(document).ready(function() {
    function updateInputBorderStyle(idValidValue) {
        const memberIdContainer = $("#memberId-container");

        if (idValidValue === "1") {
            memberIdContainer.removeClass("duplicate").addClass("valid");
        } else if (idValidValue === "0") {
            memberIdContainer.removeClass("valid").addClass("duplicate");
        } else {
            memberIdContainer.removeClass("valid duplicate");
        }
    }

    $("#memberId").on("keyup", function(e) {
        const value = e.target.value;
        const guideOk = $(".guide.ok");
        const guideError = $(".guide.error");
        const idValid = $("#idValid");
        
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
                    const { available } = responseData;
                    if (available) {
                        guideOk.show();
                        guideError.hide();
                        idValid.val("1");
                    } else {
                        guideOk.hide();
                        guideError.show();
                        idValid.val("0");
                    }
                    updateInputBorderStyle(idValid.val()); // 스타일 업데이트 호출
                }
            });
        } else {
            guideOk.hide();
            guideError.hide();
            idValid.val("0");
            updateInputBorderStyle(idValid.val()); // 스타일 업데이트 호출
        }
    });
    


    $("#memberCreateFrm").on("submit", function(e) {
        const memberIdContainer = $("#memberId-container");
        const idValid = $("#idValid");
        const password = $("#password");
        const passwordConfirmation = $("#passwordConfirmation");

        if (idValid.val() === "0") {
            memberIdContainer.addClass("duplicate");
            alert("사용가능한 아이디를 작성해주세요.");
            e.preventDefault(); // 폼 제출을 중단
            return;
        }

   /*      if (password.val() !== passwordConfirmation.val()) {
            alert("비밀번호가 일치하지 않습니다.");
            e.preventDefault(); // 폼 제출을 중단
            return;
        } */
        
    });
});

window.onload = function() {
    // 필요한 요소들을 가져오기
    var passwordInput = document.getElementById("password");
    var confirmPasswordInput = document.getElementById("passwordConfirm");
    var nameInput = document.getElementById("name");
    
    // 비밀번호 일치 여부 확인 함수
    function validatePassword() {
        var password = passwordInput.value;
        var confirmPassword = confirmPasswordInput.value;
        
        if (password === confirmPassword) {
            // 비밀번호 일치 시 스타일 변경
            passwordInput.style.border = "1px solid #5886d3";
            confirmPasswordInput.style.border = "1px solid #58586d3";
        } else {
            // 비밀번호 불일치 시 스타일 변경
            passwordInput.style.border = "1px solid red";
            confirmPasswordInput.style.border = "1px solid red";
        }
    }
    
    // 입력이 변경될 때마다 비밀번호 일치 여부 확인
    passwordInput.addEventListener("input", validatePassword);
    confirmPasswordInput.addEventListener("input", validatePassword);

    // 이름 유효성 검사 함수
    function validateName() {
        var name = nameInput.value;
        
        if (name.length >= 2) {
            // 이름 조건에 맞을 때 스타일 변경
            nameInput.style.border = "1px solid #5886d3";
        } else {
            // 이름 조건에 맞지 않을 때 스타일 변경
            nameInput.style.border = "1px solid red";
        }
    }
    
    // 입력이 변경될 때마다 이름 유효성 검사 실행
    nameInput.addEventListener("input", validateName);
}



function validateEmail() {
    const emailInput = document.getElementById("emailInput");
    const emailValidationMessage = document.getElementById("emailValidationMessage");

    const emailPattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

    if (!emailPattern.test(emailInput.value)) {
        emailValidationMessage.textContent = "유효한 이메일 주소를 입력하세요.";
        emailValidationMessage.style.display = "block";
        emailInput.style.border = "1px solid red"; // 이메일 형식이 유효하지 않을 때 색상 변경
    } else {
        emailValidationMessage.textContent = "";
        emailValidationMessage.style.display = "none";
        emailInput.style.border = "1px solid #58586d3"; // 이메일 형식이 유효할 때 기본 색상으로 변경
    }
    nameInput.addEventListener("input", validateEmail);
}

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />