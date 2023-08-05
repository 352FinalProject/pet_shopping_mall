<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
.common-section{
	display: flex;
    flex-direction: column;
    margin:100px;
}

.check-img {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: auto;
	margin-bottom: 10px;
}

.common-div {
  height: 250px;
  width: 600px;
  justify-content: center;
  text-align: center;
  display: flex;
  border-radius: 25px;
  border: 1px solid lightgray;
  background-color: white;
  margin: auto;
}

.pet-create {
  display: flex;
  justify-content: center; /* 가로 가운데 정렬 */
  align-items: center; /* 수직 가운데 정렬 */
  margin-top: 20px; 
  color: blue;
}

.pet-create div {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 0 20px; /* 펫 사진 간격 조정 */
}

/* 회원가입 타이틀 */
.common-title {
	font-size:24px;
	justify-content: center;
	display: flex;
}


/* 메인&로그인 버튼 공통 */
.mainAndLogin {
    text-align: center;
    display: flex;
    justify-content: center;
    margin-top: 30px;
}

/* 메인 버튼 */
.button-main {
	background-color: lightgray;
	margin-right: 10px;
	width: 120px;
	height: 40px;
	border-radius: 20px;
	color: white;
	border: 1px solid lightgray;

}

/* 로그인 버튼 */
.button-login {
	background-color: skyblue;
	width: 120px;
	height: 40px;
	border-radius: 20px;
	border: 1px solid lightgray;
}
</style>

<!-- 회원가입 완료 (혜령) -->
    <section class="common-section" id="#">
    	<img class="check-img" src="${pageContext.request.contextPath}/resources/images/회원가입/check.png" width="80px" height="80px"  />
    	<div class="common-title">회원가입이 완료되었습니다.</div><br>
    	<div class="common-container">
    		<div class="common-div">
    			<div>
    				<br>
    				🐶🐱🐰 펫 등록하러 가기 🐶🐱🐰
    				<div class="pet-create">
    					<div>
	    					<img src="${pageContext.request.contextPath}/resources/images/마이페이지/1.png" />
	    					<div>펫 등록1</div>
	    				</div>
	    				<div>
	    					<img src="${pageContext.request.contextPath}/resources/images/마이페이지/2.png" />
	    					<div>펫 등록2</div>
	    				</div>
	    				<div>
	    					<img src="${pageContext.request.contextPath}/resources/images/마이페이지/3.png" />
	    					<div>펫 등록3</div>
    					</div>
    				</div>
    			</div>
    		</div>
	    	<div class="mainAndLogin">
				<input class="button-main" type="button" value="메인으로">
				<input class="button-login" type="button" value="로그인">
	    	</div>
    	</div>
    </section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>