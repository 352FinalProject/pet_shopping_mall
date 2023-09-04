<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<sec:authorize access="isAuthenticated()">
	<script>
	const memberId = '<sec:authentication property="principal.username"/>';
	</script>
</sec:authorize>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js" integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="${pageContext.request.contextPath}/resources/js/notification.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/stomp.js"></script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"></jsp:include>
<c:if test="${not empty msg}">
   <script>
      alert('${msg}');
   </script>
</c:if>
<style>

deleteMember-class.active {
    display: flex; /* 모달이 보이도록 변경 */
}

/* 모달 내부 요소 스타일 */
.deleteMember h2 {
    font-size: 24px;
    margin-bottom: 10px;
}

.deleteMember p {
    font-size: 16px;
    margin-bottom: 20px;
}

.deleteMemberForm-input-password {
    width: 100%;
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.deleteMemberForm-button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
}

/* 닫기 버튼 스타일 */
.deleteMemberForm-close,
#deleteMemberForm-closeModalBtn {
    top: 10px;
    right: 10px;
    font-size: 20px;
    cursor: pointer;
}
.search-input {
   display: none;
   position: absolute;
   top: 0;
   left: 0;
   z-index: 1;
   margin-left: 30px;
   padding: 10px;
   border: 1px solid #ccc;
   border-radius: 4px;
   background-color: #fff;
   box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
   transition: all 0.3s ease;
   width: 200px;
}
.on {
	display: block;
}
.search_box {
   position: relative;
   z-index: 999;
   cursor: pointer;
}

.search-input:focus {
   border-color: #3498db;
   box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1), 0 0 8px rgba(52, 152, 219, 0.6);
   outline: none;
}

.search-input::placeholder {
   color: #aaa;
   
}
</style>
<title>반려동물 쇼핑몰</title>


</head>
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/style.css" />
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/swiper.css" />
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/product.css" />
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/serviceCenter.css" />
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/review.css" />
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/sidebar.css" />
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/point.css" />
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/cartOrder.css" />
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/petcare.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
   <sec:authorize access="isAuthenticated()">
      <form:form name="memberLogoutFrm"
         action="${pageContext.request.contextPath}/member/memberLogout.do"
         method="POST">
      </form:form>
   </sec:authorize>
   <header>
      <div class="header">
         <span id="notification"></span>
         <ul class="utility">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
			    권한 : <sec:authentication property="authorities"/>
			    아이디 : <sec:authentication property="principal.username"/>
			</sec:authorize>
            <sec:authorize access="isAnonymous()">
               <li class="login_li"><a
                  href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
               </li>
               <li class="signup_li"><a
                  href="${pageContext.request.contextPath}/member/terms.do">회원가입</a>
               </li>
            </sec:authorize>
            <li class="petcare_li"><a
               href="${pageContext.request.contextPath}/petcare/petcareList.do">펫케어</a>
            </li>
            <li class="logout_li"><a
               href="${pageContext.request.contextPath}/servicecenter/service.do">고객센터</a>
            </li>
            <sec:authorize access="hasRole('ROLE_ADMIN')">
	            <li class="admin_li"><a
	               href="${pageContext.request.contextPath}/admin/admin.do">관리자페이지</a>
	            </li>
			</sec:authorize>
            <sec:authorize access="isAuthenticated()">
               <li><a class="" type="button" href="#"
                  onclick="document.memberLogoutFrm.submit(); return false;">로그아웃</a>
               </li>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
               <div class="notification-container">
               	  <button id="openPopupBtn" onclick="loadNotifications(memberId)">
					 <img src="${pageContext.request.contextPath}/resources/images/home/notiBellx.png" id="notificationBell" alt="Notification" />
                  </button>
                  <div id="notificationPopup" class="notiPopup">
                     <div class="notiPopup-content">
                     </div>
                  </div>
               </div>
            </sec:authorize>
         </ul>
		        <div class="logo_top_wrap">
            <div class="logo_wrap">
               <!-- 로고 이미지 -->
               <div class="logo_img">
                  <a href="${pageContext.request.contextPath}/"> <img
                     src="${pageContext.request.contextPath}/resources/images/home/logo.png"
                     class="center-image" alt="로고" />
                  </a>
               </div>
          </div>
          <div class="cdt-info">
              <div class="cdt">
                 <!-- 검색 -->
                 <div class="search_top_btn">
                    <!-- 검색 창 -->
                    <div class="search_box">
                       <form name="searchBoxForm" id="searchBoxForm" method="GET" action="${pageContext.request.contextPath}/product/searchProduct.do">
                          <img
                             src="${pageContext.request.contextPath}/resources/images/home/search.png"
                             id="search-img" alt="검색" />
                             <input class="search-input" type="text" value="" placeholder="입력" name="searchQuery" />
                       </form>
                    </div>
                 </div>
                 <!-- 주문조회 -->
                 <div class="order_checks_top_btn">
                    <a href="${pageContext.request.contextPath}/member/myPage.do">
                       <img
                       src="${pageContext.request.contextPath}/resources/images/home/login.png"
                       id="center-image" alt="주문조회" />
                    </a>
                 </div>
                 <!-- 장바구니 -->
                 <div class="cart_top_btn">
                    <a href="${pageContext.request.contextPath}/cart/shoppingCart.do">
                       <img
                       src="${pageContext.request.contextPath}/resources/images/home/cart.png"
                       id="center-image" alt="장바구니" />
                    </a>
                 </div>
              </div>
         </div>
         <div class="menu-container">
            <ul class="nav">
               <ul>
                  <li class="on"><a
                     href="${pageContext.request.contextPath}/product/productList.do?categoryId=1"
                     class="font">사료</a></li>
                  <li><a
                     href="${pageContext.request.contextPath}/product/productList.do?categoryId=2"
                     class="font">간식</a></li>
                  <li><a
                     href="${pageContext.request.contextPath}/product/productList.do?categoryId=3"
                     class="font">패션용품</a></li>
                  <li><a
                     href="${pageContext.request.contextPath}/product/productList.do?categoryId=4"
                     class="font">산책용품</a></li>
                  <li><a
                     href="${pageContext.request.contextPath}/product/productList.do?categoryId=5"
                     class="font">위생용품</a></li>
                  <li><a
                     href="${pageContext.request.contextPath}/product/productList.do?categoryId=6"
                     class="font">장난감</a></li>
                  <li><a
                     href="${pageContext.request.contextPath}/product/productList.do?categoryId=7"
                     class="font">고양이</a></li>
                  <li><a
                     href="${pageContext.request.contextPath}/product/productList.do?categoryId=8"
                     class="font">기타용품</a></li>
               </ul>
            </ul>
         </div>
      </div>
   </header>
<script>
const searchBoxForm = document.getElementById("searchBoxForm");
const searchImg = document.getElementById("search-img");
const searchInput = document.querySelector(".search-input"); // 추가: searchInput 변수 선언

searchImg.addEventListener("click", function(event) {
  searchInput.classList.add("on");
  event.stopPropagation();
});

// 추가: 입력 상자에 대한 keyup 이벤트 처리
searchInput.addEventListener("keyup", function(event) {
  if (event.key === "Enter") {
    event.preventDefault();
    searchBoxForm.submit();
  }
});

document.addEventListener("click", function() {
  searchInput.classList.remove("on");
});

searchInput.addEventListener("click", function(event) {
  event.stopPropagation();
})
</script>
