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
    	console.log(xhr);
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

    xhr.open('POST', `/pet/email/send`, true);
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
    };
    
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
    };
    
    // 입력이 변경될 때마다 이름 유효성 검사 실행
    nameInput.addEventListener("input", validateName);
};

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
    emailInput.addEventListener("input", vaslidateEmail);
};

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
            var jibunAddress = data.jibunAddress; // Add this line
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