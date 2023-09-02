<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="${pageContext.request.contextPath}/resources/js/memberCreate.js"></script>
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
   .common-div table td input[type="email"], .common-div table td input[type="address"] {
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
                           title="알파벳 대소문자, 숫자, - 를 사용하여 4자 이상 입력하세요." required> <input
                           type="hidden" id="idValid" value="0" /> <span
                           class="guide error">이 아이디는 이미 사용중입니다.</span>
                     </div>
                  </td>
               </tr>

               <tr>
                  <th>이름</th>
                  <td>
                     <div class="memberName-container">
                        <input type="text" name="name" id="name" value=""
                           placeholder="이름" pattern="[가-힣A-Za-z]+"
                           title="한글 또는 영어 대소문자 한 글자 이상의 길이를 가져야 합니다. " required>
                        <br>
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
					        <input type="button" class="address" onclick="sample4_execDaumPostcode();" value="주소 검색">
					    </div>
					    <br>
					    <div style="margin-top: -60px; position: absolute;">
					        <input type="text" class="address" id="roadAddress" placeholder="도로명주소" oninput="updateAddress()">
					    </div>
					    <br>
					    <div style="margin-top: -30px;">
					        <input type="text" class="address" id="jibunAddress" placeholder="지번주소" oninput="updateAddress()">
					    </div>
					    <br>
					    <span id="guide" style="color:#999;display:none"></span>
					    <div style="margin-top: -10px;">
					        <input type="text" class="address" id="detailAddress" placeholder="상세주소" oninput="updateAddress()">
					    </div>
					    <input type="hidden" name="address" id="address" value="" />
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
      <input type="text" id="sample4_postcode" placeholder="우편번호">
      <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
      <input type="text" id="extraAddress" placeholder="참고항목">
   </div>
</section>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script
   src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />