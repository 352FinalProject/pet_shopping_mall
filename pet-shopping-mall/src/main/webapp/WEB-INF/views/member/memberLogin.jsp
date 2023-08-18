<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
.table-bordered {
   display: flex;
   align-items: center;
   text-align: center;
   margin: 20px auto;
   align-content: stretch;
   justify-content: center;
}

.login-form {
   display: flex;
   text-align: center;
   margin: 0 auto;
   font-size: 35px;
   justify-content: center;
   margin-top: 10px;
   margin-bottom: 50px;
}

.form-control {
   display: flex;
   width: 400px;
   text-align: center;
   justify-content: center;
   margin: 20px auto;
   height: 70px;
   border-radius: 35px;
   font-size: 20px;
}

.form-control2 {
   display: flex;
   width: 400px;
   text-align: center;
   justify-content: center;
   margin: 20px auto;
   height: 70px;
   border-radius: 35px;
   font-size: 20px;
}

.save-search {
   margin-top: 20px;
   margin-bottom: 20px;
}

.saveId { /*    ̵      */
   margin-right: 50px;
   font-size: 25px;
   width: 25px;
   height: 25px;
   margin-botom: 10px;
   width: 40px;
   height: 40px;
}

.search {
   margin-left: 50px;
   border: none !important;
   font-size: 18px;
   background-color: white;
   border: none !important;
}

.login-btnAll {
   display: flex;
   text-align: center;
   border: none !important;
   justify-content: center;
   font-size: 70px;
   margin: 10px auto;
}

.login-btn {
   background-color: #c8c8c8;;
   width: 400px;
   height: 70px;
   border-radius: 35px;
   border: none !important;
   color: white;
   font-size: 25px;
}

.kakao-btn {
   background-color: #ffeb00;
   width: 400px;
   height: 70px;
   border-radius: 35px;
   border: none !important;
   color: white;
   font-size: 25px;
}

.naver-btn {
   background-color: #00c577;
   width: 400px;
   height: 70px;
   border-radius: 35px;
   border: none !important;
   color: white;
   font-size: 25px;
}

.signUp-btn {
   background: #c8c8c8;
   width: 400px;
   height: 70px;
   border-radius: 35px;
   border: none !important;
   color: white;
   font-size: 25px;
}

.login-btn2 {
   display: flex;
   text-align: center;
   background-color: #c8c8c8;
   border: none !important;
   margin: 0 auto;
   justify-content: center;
}

.login-btn.active {
   text-align: center;
   background-color: #5886d3;
   margin: 0 auto;
   justify-content: center;
}

button, input {
   cursor: pointer;
}
</style>
<section class="common-section" id="#">
   <div class="common-container">
      <form:form
         action="${pageContext.request.contextPath}/member/memberLogin.do"
         method="post">
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
                  <div class="login-modal">
                     <div class="login-input">
                        <input type="text" id="inputId" class="form-control"
                           name="memberId" required="required" placeholder="아이디" />
                     </div>
                     <div class="login-input">
                        <input type="password" id="inputPassword" class="form-control2"
                           name="password" required="required" placeholder="비밀번호">
                     </div>
                  </div>
               </td>
            </tr>
            <tr>
               <td>
                  <div class="save-search">
                     <label for="saveId"> <input type="checkbox"
                        class="saveId">아이디저장
                     </label>
                     <button type="button" class="search" id="searchId">아이디찾기</button>
                     <button type="button" class="search" id="searchPasword">비밀번호찾기</button>
                  </div>
               </td>
            </tr>
            <tr>
               <td>
                  <div class="login-btnAll">
                     <!-- 로그인 오류 메시지 출력 -->
                     <c:if test="${param.error ne null}">
                        <script>
                           alert('아이디 또는 비밀번호가 일치하지 않습니다.');
                       </script>
                     </c:if>
                     <!-- 로그인 버튼 -->
                     <button type="submit" name="btn-outline-success" id="loginButton"
                        class="login-btn">로그인</button>
                  </div>
               </td>
            </tr>
            <tr>
               <td>
                  <div class="login-btnAll">
                     <button type="submit" class="kakao-btn"
                        onclick="location.href='${pageContext.request.contextPath}/oauth2/authorization/kakao'">카카오
                        로그인</button>
                  </div>
               </td>
            </tr>
            <tr>
               <td>
                  <div class="login-btnAll">
                     <button type="submit" class="naver-btn"
                        onclick="location.href='${pageContext.request.contextPath}/oauth2/authorization/naver'">네이버
                        로그인</button>
                  </div>
               </td>
            </tr>
            <tr>
               <td>
                  <div class="login-btnAll">
                     <button type="submit" class="signUp-btn"
                        onclick="location.href='${pageContext.request.contextPath}/member/terms.do'">회원가입</button>
                  </div>
               </td>
            </tr>
         </table>
      </form:form>
   </div>
</section>
<script>

 const checkInputs = () => {
     const id = document.getElementById('inputId').value;
     const password = document.getElementById('inputPassword').value;
     const loginButton = document.getElementById('loginButton');

     if (id && password) {
       loginButton.style.backgroundColor = '#5886d3';
       loginButton.disabled = false; // 버튼 활성화
     } else {
       loginButton.style.backgroundColor = '#c8c8c8';
       loginButton.disabled = true; // 버튼 비활성화
     }
   };

   // ID와 비밀번호 필드에 대한 값 변경시 checkInputs 함수를 호출하도록 이벤트 리스너 추가
   document.getElementById('inputId').addEventListener('input', checkInputs);
   document.getElementById('inputPassword').addEventListener('input', checkInputs);

   // 초기 상태 설정을 위해 함수를 한 번 호출
   checkInputs();

   
   </script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />