<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR&family=Noto+Serif+KR:wght@200&display=swap');
</style>
<div id="myOverlay" class="overlay"></div>
<input type="checkbox" id="menuicon">
<label for="menuicon"> <span></span> <span></span> <span></span>
</label>
<div class="sidebar">
	<ul class="sidebar-text">
		<sec:authorize access="isAnonymous()">
		<input type="button" class="sidebar-loginbutton" value="로그인" onclick="location.href='${pageContext.request.contextPath}/member/memberLogin.do'">
		<hr>
		</sec:authorize>
		<li class="sidebar-title">카테고리</li>
			<li class="sidebar-title1"><a href="${pageContext.request.contextPath}/product/productList.do?categoryId=1">사료</a></li>
			<li><a href="${pageContext.request.contextPath}/product/productList.do?categoryId=2">간식</a></li>
			<li><a href="${pageContext.request.contextPath}/product/productList.do?categoryId=3">패션용품</a></li>
			<li><a href="${pageContext.request.contextPath}/product/productList.do?categoryId=4">산책용품</a></li>
			<li><a href="${pageContext.request.contextPath}/product/productList.do?categoryId=5">위생용품</a></li>
			<li><a href="${pageContext.request.contextPath}/product/productList.do?categoryId=6">장난감</a></li>
			<li><a href="${pageContext.request.contextPath}/product/productList.do?categoryId=7">고양이</a></li>
			<li><a href="${pageContext.request.contextPath}/product/productList.do?categoryId=8">기타용품</a></li>
		<li class="sidebar-title2"><a href="#">마이페이지</a>
			<ul>
				<li><a href="${pageContext.request.contextPath}/member/updateMember.do">회원정보 수정</a></li>
				<li><a href="${pageContext.request.contextPath}/pet/petList.do">펫 목록</a></li>
				<li><a href="${pageContext.request.contextPath}/pet/petProfile.do">펫 등록</a></li>
				<li><a href="${pageContext.request.contextPath}/pet/petUpdate.do">펫 정보 수정</a></li>
			</ul>
		</li>
		<li><a href="#">고객센터</a>
			<ul>
				<li><a href="${pageContext.request.contextPath}/servicecenter/service.do">자주묻는질문</a></li>
				<li><a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionList.do">Q&A</a></li>
			</ul>
		</li>
	</ul>
</div>
<script>
/* 화면 어둡게 */
document.getElementById('menuicon').addEventListener('change', function() {
    document.getElementById('myOverlay').style.display = this.checked ? 'block' : 'none';
});

/* 화면 눌렀을 때 닫히는 기능 */
const menuIcon = document.getElementById('menuicon');
const overlay = document.getElementById('myOverlay');

// 체크박스 상태 변경에 따른 오버레이 표시/숨김
menuIcon.addEventListener('change', function() {
    overlay.style.display = this.checked ? 'block' : 'none';
});

// 오버레이 클릭 시 체크박스 상태 변경 및 오버레이 숨김
overlay.addEventListener('click', function() {
    menuIcon.checked = false;
    overlay.style.display = 'none';
});
</script>
