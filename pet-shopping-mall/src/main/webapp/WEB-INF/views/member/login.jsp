<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/login.css">
</head>

<section class="common-section" id="#">
	<div class="common-container">
		<form action="login" method="post">
			<table class="table-bordered">
				<tr>
					<td>
						<div class="login-form">
							<h2>로그인</h2>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="login-input">
							<input type="text" id="inputId" class="form-control" required="required"
								placeholder="아이디" value="${sessionScope.saveok==null?"":sessionScope.myid }">
						</div>
						<div class="login-input">
							<input type="password" id="inputPassword" class="form-control2"
								required="required" placeholder="비밀번호">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="save-search">
							<label for="saveId"> <input type="checkbox" class="saveId"
								${sessionScope.saveok==null?"":"checked" }>아이디 저장
							</label>
							<button type="button" class="search" id="searchId">아이디찾기</button>
							<button type="button" class="search" id="searchPasword">비밀번호찾기</button>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="login-btnAll">
							<button type="button" name="id" id="loginButton"
								class="login-btn">로그인</button>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="login-btnAll">
							<button type="submit" class="kakao-btn">카카오 로그인</button>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="login-btnAll">
							<button type="submit" class="naver-btn">네이버 로그인</button>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="login-btnAll">
							<button type="submit" class="signUp-btn">회원가입</button>
						</div>
					</td>
				</tr>

			</table>
		</form>
	</div>
	<script>
	const checkInputs = () => {
	    const id = document.getElementById('inputId').value;
	    const password = document.getElementById('inputPassword').value;
	    const loginButton = document.getElementById('loginButton');

	    if (id && password) {
	        loginButton.style.backgroundColor = '#648CFF';
	        loginButton.disabled = false; // 버튼 활성화
	    } else {
	        loginButton.style.backgroundColor = '#c8c8c8';
	        loginButton.disabled = true; // 버튼 비활성화
	    }
	};

	// ID와 비밀번호 입력란에 이벤트 리스너를 추가하여 값이 변경될 때마다 checkInputs 함수를 호출
	document.getElementById('inputId').addEventListener('input', checkInputs);
	document.getElementById('inputPassword').addEventListener('input', checkInputs);

	// 초기 상태를 설정하기 위해 함수를 처음에 한 번 호출
	checkInputs();


	

	
	</script>
</section>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />