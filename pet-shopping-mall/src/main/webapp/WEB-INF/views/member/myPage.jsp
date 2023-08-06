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
</style>

<!-- 마이페이지 (혜령) -->
<!-- 아이디, 이름, 생일 수정X -->
    <section class="common-section" id="#">
    	<div class="common-title">마이페이지</div>
    	<br>
    	<div class="common-container">
    		<div class="common-div">
    			<form name="memberCreateFrm" action="" method="POST">
    			<table>
					<tr>
		                <th>아이디</th>
		                <td>
		                    <input type="text" name="memberId" id="memberId" value="" readonly required />
		                </td>
		                <td rowspan="2" class="pet-info-container">
		                    <div class="pet-info">
		                        <img src="${pageContext.request.contextPath}/resources/images/마이페이지/1.png" />
		                        <div>펫 등록1</div>
		                    </div>
		                </td>
		            </tr>
		            <tr>
		                <th>이름</th>
		                <td>
		                    <input type="text" name="name" id="name" value="" readonly required>
		                </td>
		            </tr>				
    				<tr>
    					<th>비밀번호</th>
    					<td>
    						<input type="password" name="password" id="password" value="" required>
    					</td>
		                <td rowspan="2" class="pet-info-container">
		                    <div class="pet-info">
		                        <img src="${pageContext.request.contextPath}/resources/images/마이페이지/2.png" />
		                        <div>펫 등록2</div>
		                    </div>
		                </td>
    				</tr>
    				<tr>
    					<th>비밀번호 확인</th>
    					<td>
    						<input type="password" id="passwordConfirm" value="" required>
    					</td>
    				</tr>
    				<tr>
    					<th>핸드폰 번호</th>
    					<td>
    						<input type="tel" name="tel" id="tel" value="" required>
    						<input type="button" value="핸드폰 인증" onclick="telCheck()">
    					</td>
    					<td rowspan="2" class="pet-info-container">
		                    <div class="pet-info">
		                        <img src="${pageContext.request.contextPath}/resources/images/마이페이지/3.png" />
		                        <div>펫 등록3</div>
		                    </div>
		                </td>
    				</tr>
    				<tr>
    					<th>생일</th>
    					<td>
    						<input type="date" name="birthday" id="birthday" value="" readonly required>
						</td>
    				</tr>
    				<tr>
    					<th>이메일</th>
    					<td>
    						<input type="email" name="email" id="email" placeholder="pet@gmail.com" value="" required>
    					</td>
    				</tr>
    				<tr>
    					<th>주소</th>
    					<td>
    						<input type="text" name="address" id="address" value="" required>
    						<input type="button" value="주소 검색">
    					</td>
    				</tr>
    				<tr>
    					<td class="resetAndSubmit" colspan="2">
			    			<input type="reset" value="돌아가기">
			    			<input type="submit" value="수정하기">
			    		</td>
    				</tr>
    			</table>
    			</form>
    </section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>