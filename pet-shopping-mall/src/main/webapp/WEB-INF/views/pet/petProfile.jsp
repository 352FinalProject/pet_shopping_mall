<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />
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

/* 등록하기 버튼 */
.resetAndSubmit input[type="submit"] {
   background-color: #5886d3;
   width: 120px;
   height: 40px;
   border-radius: 20px;
   border: 1px solid #e7e7e7;
   color: white;
   
}

/* 성별선택 버튼 */

.gender-button-container {
    display: flex;
   ustify-content: flex-start;
    margin-top: 10px; /* 버튼과의 간격을 설정하거나 필요에 따라 조정하세요 */
    margin-left: 10px; 
}
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
        const successMessage = document.querySelector('.success-message');
        const confirmButton = document.getElementById('confirmButton');

        genderButtons.forEach(button => {
            button.addEventListener("click", function() {
                const selectedGender = this.value;
                genderInput.value = selectedGender;

                genderButtons.forEach(btn => btn.classList.remove("selected"));
                this.classList.add("selected");
            });
        });

        if (successMessage) {
            confirmButton.addEventListener('click', function() {
                location.href = "/pet/petList.do";
            });
        }
    });
</script>

<!-- 펫 프로필 입력 (혜령) -->
<section class="common-section" id="#">
    <div class="common-title">펫 프로필 입력</div>
    <br>
    <div class="common-container">
        <div class="common-div">
            <form:form action="${pageContext.request.contextPath}/pet/petProfile.do" method="POST"> <!-- 2. 이부분 ${pageContext.request.contextPath} 추가 
                                                                                    3. 상단에 시큐리티 태그 링크, form:form 추가 -->
            
                <table>
                  <tr>
                        <th>아이디</th>
                        <td>
                            <input type="text" name="memberId" id="memberId" value="<sec:authentication property="name"/>" readonly>
                        </td>
                    </tr>
                    
                    <tr>
                        <th>펫 이름</th>
                        <td>
                            <input type="text" name="petName" id="petName" placeholder="이름을 입력해 주세요.">
                        </td>
                    </tr>
                    
                    <tr>
                        <th>나이</th>
                        <td>
                            <input type="text" name="petAge" id="petAge" placeholder="나이를 입력해 주세요.">
                        </td>
                    </tr>

                    <tr>
                        <th>타입</th>
                        <td>
                            <input type="text" name="petKind" placeholder="ex:강아지">
                        </td>
                    </tr>
                
                    <tr>
                        <th>품종</th>
                        <td>
                            <input type="text" name="petBreed" placeholder="ex:말티즈" >
                        </td>
                    </tr>
                    <tr>
                        <th>몸무게</th>
                        <td>
                            <input type="text" name="petWeight" placeholder="몸무게를 입력해 주세요." >
                        </td>
                    </tr>                    
                    <tr>
                        <th>입양일</th>
                        <td>
                            <input type="date" name="petAdoption" id="petAdoptionDate">
                        </td>
                    </tr>
                    <tr>
                        <th>성별</th>
               <td>
                   <input type="hidden" name="petGender" id="genderInput" value="${petInfo.petGender}">
                   <div class="gender-button-container">
                       <input type="button" name="gender" value="M" onclick="selectGender('M')" ${petInfo.petGender == 'M' ? 'class="selected"' : ''}>
                       <input type="button" name="gender" value="F" onclick="selectGender('F')" ${petInfo.petGender == 'F' ? 'class="selected"' : ''}>
                   </div>
               </td>
                    </tr>
                    <tr>
                  <td class="resetAndSubmit" colspan="2"><input type="reset" value="돌아가기"
                     onclick="location.href='${pageContext.request.contextPath}/'">
                     <input type="submit" value="등록하기">
                        </td>
                    </tr>
                </table>
            </form:form>
        </div>
    </div>
</section>
<script>
// 펫 등록 젠더 선택
function selectGender(gender) {
    $("#genderInput").val(gender);
    $("#selectedGender").text(gender === 'M' ? '♂' : '♀');
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>