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

/* 성별선택 버튼 */
    input[type="button"][name="gender"] {
        border: 1px solid lightgray;
        border-radius: 20px;
        padding: 5px 10px;
        margin-right: 10px;
        background-color: white;
        cursor: pointer;
    }

    input[type="button"][name="gender"].selected {
        background-color: #5886d3;
        color: white;
    }
    
</style>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const genderButtons = document.querySelectorAll('input[type="button"][name="gender"]');
        const genderInput = document.getElementById("genderInput");

        genderButtons.forEach(button => {
            button.addEventListener("click", function() {
                const selectedGender = this.value;
                genderInput.value = selectedGender;

                // 버튼 스타일 변경 (선택한 버튼 강조)
                genderButtons.forEach(btn => btn.classList.remove("selected"));
                this.classList.add("selected");
            });
        });
    });
</script>

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
    					<th>타입</th>
    					<td>
    						<input type="text" placeholder="반려동물의 종류를 입력해 주세요.">
    					</td>
    				</tr>
 				
    				<tr>
    					<th>품종</th>
    					<td>
    						<input type="text" placeholder="반려동물의 품종을 입력해 주세요.">
    					</td>
    				</tr>
    				
    				<tr>
    					<th>입양일</th>
    					<td>
    						<input type="date" name="birthday" id="birthday" >
						</td>
    				</tr>

                    <tr>
                        <th>성별</th>
                        <td>
                            <label><input type="button" name="gender" value="♂"></label>
                            <label><input type="button" name="gender" value="♀"></label>
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