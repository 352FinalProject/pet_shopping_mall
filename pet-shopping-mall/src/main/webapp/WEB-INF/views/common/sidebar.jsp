<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR&family=Noto+Serif+KR:wght@200&display=swap');
</style>
<div id="myOverlay" class="overlay"></div>
<input type="checkbox" id="menuicon">
<label for="menuicon"> <span></span> <span></span> <span></span>
</label>
<div class="sidebar">
	<ul class="sidebar-text">
		<c:if test="${empty loginMember}">
		<span>MY</span><input type="button" class="sidebar-loginbutton" value="로그인" onclick="location.href='${pageContext.request.contextPath}/member/memberLogin.do'">
		<hr>
		</c:if>
		<li class="sidebar-title">카테고리f</li>
		<li><a href="#">사료</a>
			<ul>
				<li><a href="#">건식</a></li>
				<li><a href="#">습식</a></li>
				<li><a href="#">화식</a></li>
				<li><a href="#">생식</a></li>
				<li><a href="#">고양이</a></li>
			</ul>
		</li>
		<li><a href="#">간식</a>
			<ul>
				<li><a href="#">동결건조</a></li>
				<li><a href="#">져키류</a></li>
				<li><a href="#">껌류</a></li>
				<li><a href="#">뼈간식</a></li>
				<li><a href="#">기타간식</a></li>
			</ul>
		</li>
		<li><a href="#">패션용품</a>
			<ul>
				<li><a href="#">하네스/목줄</a></li>
				<li><a href="#">리드줄</a></li>
				<li><a href="#">배변용품</a></li>
			</ul>
		</li>
		<li><a href="#">위생용품</a>
			<ul>
				<li><a href="#">샴푸</a></li>
				<li><a href="#">욕조</a></li>
				<li><a href="#">물티슈</a></li>
				<li><a href="#">치약/칫솔</a></li>
				<li><a href="#">펫타올</a></li>
			</ul>
		</li>
		<li><a href="#">장난감</a>
			<ul>
				<li><a href="#">강아지</a></li>
				<li><a href="#">고양이</a></li>
			</ul>
		</li>
		<li><a href="#">고양이</a>
			<ul>
				<li><a href="#">모래</a></li>
				<li><a href="#">캣타워</a></li>
				<li><a href="#">화장실</a></li>
			</ul>
		</li>
		<li><a href="#">기타용품</a>
			<ul>
				<li><a href="#">식기</a></li>
				<li><a href="#">하우스</a></li>
				<li><a href="#">이동가방</a></li>
			</ul>
		</li>
		<hr>
		<li><a href="#">마이페이지</a>
			<ul>
				<li><a href="${pageContext.request.contextPath}/member/myPage.do">회원정보 수정</a></li>
				<li><a href="${pageContext.request.contextPath}/member/petList.do">펫 목록</a></li>
				<li><a href="${pageContext.request.contextPath}/member/petProfile.do">펫 등록</a></li>
				<li><a href="${pageContext.request.contextPath}/member/petUpdate">펫 정보 수정</a></li>
			</ul>
		</li>
		<li><a href="#">고객센터</a>
			<ul>
				<li><a href="#">자주묻는질문</a></li>
				<li><a href="#">Q&A</a></li>
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
