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
	.common-div table td input[type="email"], .common-div table td input[type="address"]
	{
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
									name="memberId" id="memberId" value=""
									pattern='[A-Za-z0-9_]{4,}'
									title="알파벳 대소문자, 숫자, - 를 사용하여 4자 이상 입력하세요." required><input
									type="hidden" id="idValid" value="0" />
									<div style="margin-left:25px"><span class="guide error">이 아이디는 이미 사용중입니다.</span></div>
							</div>
						</td>
					</tr>

					<tr>
						<th>이름</th>
						<td>
							<div class="memberName-container">
								<input type="text" name="name" id="name" value=""
									placeholder="이름" pattern="^[가-힣a-zA-Z\s]+$"
									title="한글 또는 영어 대소문자 두 글자 이상의 길이를 가져야 합니다." required>
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
							placeholder="핸드폰번호" required></td>
					</tr>

					<tr>
						<th>생일</th>
						<td><input type="date" name="birthday" id="birthday"
							placeholder="생년월일" required pattern=" ^\d{4}-\d{2}-\d{2}$"
							title="연도, 월, 일이 각각 4자리, 2자리, 2자리 숫자입력."></td>
					</tr>

					<tr>
						<th>이메일</th>
						<td><input type="email" name="email" id="emailInput"
							placeholder="이메일" value="" required> <input type="button"
							id="emailButton" value="이메일 인증" onclick="emailCheck()"
							pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$"
							title="부적합한 이메일 형식입니다."></td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<div style="text-align: right;">
								<input type="button" class="address"
									onclick="sample4_execDaumPostcode();" value="주소 검색">
							</div> <br>
							<div style="margin-top: -60px; position: absolute;">
								<input type="text" class="address" id="roadAddress"
									placeholder="도로명주소" oninput="updateAddress()">
							</div> <br>
							<div style="margin-top: -30px;">
								<input type="text" class="address" id="jibunAddress"
									placeholder="지번주소" oninput="updateAddress()">
							</div> <br> <span id="guide" style="color: #999; display: none"></span>
							<div style="margin-top: -10px;">
								<input type="text" class="address" id="detailAddress"
									placeholder="상세주소" oninput="updateAddress()">
							</div> <input type="hidden" name="address" id="address" value="" />
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
	<div id="kakaoInput" hidden="true">
		<input type="text" id="sample4_postcode" placeholder="우편번호"> <input
			type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" id="extraAddress" placeholder="참고항목">
	</div>
</section>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
};
   
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
    };

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
            return;
        };
        
        e.preventDefault();

    });
});

  window.onload = function() {
    // 필요한 요소들을 가져오기
    var passwordInput = document.getElementById("password");
    var confirmPasswordInput = document.getElementById("passwordConfirm");
    
    // 비밀번호 일치 여부 확인 함수
    function validatePassword() {
        var password = passwordInput.value;
        var confirmPassword = confirmPasswordInput.value;
        
        if (password === confirmPassword) {
            // 비밀번호 일치 시 스타일 변경
            passwordInput.style.border = "1px solid #5886d3";
            confirmPasswordInput.style.border = "1px solid #5886d3";
        } else {
            // 비밀번호 불일치 시 스타일 변경
            passwordInput.style.border = "1px solid red";
            confirmPasswordInput.style.border = "1px solid red";
        }
    };
    

    // 입력이 변경될 때마다 비밀번호 일치 여부 확인
    passwordInput.addEventListener("input", validatePassword);
    confirmPasswordInput.addEventListener("input", validatePassword); 

    
    // 이름 유효성 검사 함수
    const nameInput = document.getElementById("name");

    nameInput.addEventListener("input", function() {
    	const namePattern = /^[가-힣a-zA-Z\s]+$/;
        if (nameInput.value === "") {
            nameInput.style.borderColor = ""; // 초기 테두리 색상 (기본값)으로 변경
        } else if (namePattern.test(nameInput.value)) {
            nameInput.style.borderColor = "#5886d3";
        } else {
            nameInput.style.borderColor = "red";
        }
    });
}; 

// 핸드폰 유효성검사 이벤트처리 함수
const phoneInput = document.getElementById("tel");

phoneInput.addEventListener("input", function() {
    const phonePattern = /^010\d{8}$/;
    if (phoneInput.value === "") {
        phoneInput.style.borderColor = ""; // 초기 테두리 색상 (기본값)으로 변경
    } else if (phonePattern.test(phoneInput.value)) {
        phoneInput.style.borderColor = "#5886d3";
    } else {
        phoneInput.style.borderColor = "red";
    }
});

const birthdayInput = document.getElementById("birthday");

// 생일 입력란에 대한 input 이벤트 처리
birthdayInput.addEventListener("input", validateBirthday);

function validateBirthday() {
    const birthdayValue = birthdayInput.value;
    const birthdayPattern = /^\d{4}-\d{2}-\d{2}$/;

    if (birthdayPattern.test(birthdayValue)) {
        birthdayInput.style.borderColor = "#5886d3"; // 유효한 형식일 경우 테두리 색상을 파란색으로 변경
    } else if (birthdayValue.trim() === "") {
        birthdayInput.style.borderColor = ""; // 초기 테두리 색상 (기본값)으로 변경
    } else {
        birthdayInput.style.borderColor = "red"; // 유효하지 않은 형식일 경우 테두리 색상을 빨간색으로 변경
    }
}

// 이메일 유효성검사 이벤트처리 함수
const emailInput = document.getElementById("emailInput");

emailInput.addEventListener("input", function() {
    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    if (emailInput.value === "") {
        emailInput.style.borderColor = ""; // 초기 테두리 색상 (기본값)으로 변경
    } else if (emailPattern.test(emailInput.value)) {
        emailInput.style.borderColor = "#5886d3";
    } else {
        emailInput.style.borderColor = "red";
    }
});

// 주소 입력 필드들을 가져옵니다.
const roadAddressInput = document.getElementById('roadAddress');
const jibunAddressInput = document.getElementById('jibunAddress');
const detailAddressInput = document.getElementById('detailAddress');

// 각 주소 입력 필드의 입력 이벤트 리스너를 추가합니다.
roadAddressInput.addEventListener('input', validateAddress);
jibunAddressInput.addEventListener('input', validateAddress);
detailAddressInput.addEventListener('input', validateAddress);

function validateAddress() {
    // 각 주소 입력 필드의 값을 가져옵니다.
    const roadAddress = roadAddressInput.value;
    const jibunAddress = jibunAddressInput.value;
    const detailAddress = detailAddressInput.value;

    // 주소 유효성 검사를 위한 조건 (예: 길이가 2자 이상이어야 함)
    const addressValidationCondition = /.{2,}/;

    // 주소가 유효한지 확인합니다.
    const isAddressValid = addressValidationCondition.test(roadAddress) &&
                           addressValidationCondition.test(jibunAddress) &&
                           addressValidationCondition.test(detailAddress);

    // 유효한 주소인 경우 파란색 테두리를 설정합니다.
    if (isAddressValid) {
    	 roadAddressInput.style.border = '1px solid #5886d3';
         jibunAddressInput.style.border = '1px solid #5886d3';
         detailAddressInput.style.border = '1px solid #5886d3';
    }
    // 유효하지 않은 주소인 경우 빨간색 테두리를 설정합니다.
    else {
        roadAddressInput.style.border = '1px solid red';
        jibunAddressInput.style.border = '1px solid red';
        detailAddressInput.style.border = '1px solid red';
    }
}

function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("roadAddress").value = roadAddr;
            document.getElementById("jibunAddress").value = data.jibunAddress;
         
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("extraAddress").value = extraRoadAddr;

            } else {
                document.getElementById("extraAddress").value = '';
            }
            document.getElementById('roadAddress').value = roadAddr;
           
            // 도로명 주소와 지번 주소, 상세 주소를 합쳐서 전체 주소로 설정한다.
            var jibunAddress = data.jibunAddress;
            var fullAddress = roadAddr + jibunAddress + " " + document.getElementById("detailAddress").value;
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