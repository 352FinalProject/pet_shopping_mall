<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
.common-section{
	display: flex;
    flex-direction: column;
    margin:100px;
}
.common-div {
	justify-content: center;
	align-items: left;
	display: flex;
} 

/* 회원가입 타이틀 */
.common-title {
	font-size:24px;
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
.common-div table td input{
	height: 30px;
 	border-radius: 10px;
 	border: 1px solid lightgray;
 	background-color: white;
}

.common-div table td input[type="email"] {
    margin-bottom: 12px;
}

/* input 태그 */
.common-div table td input[type="text"],
.common-div table td input[type="password"], 
.common-div table td input[type="tel"], 
.common-div table td input[type="date"],
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
	background-color: lightgray;
	margin-right: 10px;
	width: 120px;
	height: 40px;
	border-radius: 20px;
	color: white;
	border: 1px solid lightgray;
	margin-top: 30px;
}

/* 가입하기 버튼 */
.resetAndSubmit input[type="submit"] {
	background-color: skyblue;
	width: 120px;
	height: 40px;
	border-radius: 20px;
	border: 1px solid lightgray;
}
</style>

<!-- 펫 프로필 입력 (혜령) -->
    <section class="common-section" id="#">
    	<div class="common-title">펫 프로필 입력</div>
    	<br>
    	<div class="common-container">
    		<div class="common-div">
    			<form name="memberCreateFrm" action="" method="POST">
				
    			<table>
    				<tr>
    					<th>이름</th>
    					<td>
    						<input type="text" name="name" id="name" value="두부" required>
    					</td>
    				</tr>
    				<tr>
    					<th>생일</th>
    					<td>
    						<input type="date" name="birthday" id="birthday" required>
						</td>
    				</tr>
    				<tr>
    					<th>입양일</th>
    					<td>
    						<input type="date" name="birthday" id="birthday" >
						</td>
    				</tr>
    				<tr>
    					<th>품종</th>
    					<td>
    						<input type="text" placeholder="품종을 선택해 주세요.">
    					</td>
    				</tr>
    				<tr>
    					<th>몸무게</th>
    					<td>
    						<input type="text" placeholder="몸무게를 입력해 주세요.">
    					</td>
    				</tr>
    				<tr>
    					<th>음식 알레르기</th>
    					<td>
    						<input type="text" placeholder="알레르기가 있는 경우 선택해 주세요.">
    					</td>
    				</tr>
    				<tr>
    					<th>질병/질환</th>
    					<td>
    						<input type="text" placeholder="질병/질환을 선택해 주세요.">
    					</td>
    				</tr>
					<tr>
    					<td class="resetAndSubmit" colspan="2">
			    			<input type="reset" value="돌아가기">
			    			<input type="submit" value="등록하기">
			    		</td>
    				</tr>
    			</table>
    			</form>
    		</div>
    	</div>
    </section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>