<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR&family=Noto+Serif+KR:wght@200&display=swap');
</style>
<style>

#menuicon {
	display: none;
	width: 30px;
	height: 20px;
	
}

#menuicon+label {
	display: block;
	margin: 30px;
	width: 30px;
	height: 20px;
	position: absolute;
	z-index: 999;
	cursor: pointer;
	top: 80px;
    left: 325px;
}

#menuicon+label span {
	display: block;
	position: absolute;
	width: 100%;
	height: 1.6px;
	border-radius: 30px;
	background: #000;
	transition: all .35s;
}

#menuicon+label span:nth-child(1) {
	top: 0;
}

#menuicon+label span:nth-child(2) {
	top: 50%;
	transform: translateY(-50%);
}

#menuicon+label span:nth-child(3) {
	bottom: 0;
}

#menuicon:checked+label {
	z-index: 999;
}

#menuicon:checked+label span {
	background: #000;
}

#menuicon:checked+label span:nth-child(1) {
	top: 50%;
	transform: translateY(-50%) rotate(45deg);
}

#menuicon:checked+label span:nth-child(2) {
	opacity: 0;
}

#menuicon:checked+label span:nth-child(3) {
	bottom: 50%;
	transform: translateY(50%) rotate(-45deg);
}

.sidebar {
	width: 280px;
	height: 100%;
	position: fixed;
	top: 0;
	left: -300px;
	z-index: 3;
	transition: all .35s;
	background-color: #fff;
}

.sidebar-text {
	top: 105px;
	position: relative;
	font-family: 'Noto Sans KR', sans-serif;
}

#menuicon:checked+label+div {
	left: 0;
}

/* 2차 메뉴 숨기기 */
.sidebar>ul ul {
	display: none;
	position: absolute;
	top: 0;
	left: 100%; /* 부모 요소 오른쪽에 위치하도록 설정 */
	min-width: 200px;
	left: 100%; /* 2차 메뉴의 최소 너비 설정 (필요에 따라 조정) */
}

.sidebar>ul>li:hover>ul {
	display: block;
	background-color: #ffffffc2;
}

.sidebar ul>li>a {
	display: block;
	color: black;
	font-size: 20px;
	padding: 10px 20px;
}

.sidebar-text > li {
  position: relative; /* 부모 요소에 relative 설정 */
}

.sidebar-text > li:hover ul {
  display: block;
}

.sidebar-title{
	left:20px;
	font-size: 30px;
	font-family: 'Noto Sans KR', sans-serif;
}

.overlay {
    display: none;
    position: fixed;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0,0,0,0.5);
    z-index: 2;
}

.sidebar-loginbutton {
	position: relative;
  	left: 30px;
	box-sizing: border-box;
	border: 1.5px solid;
	cursor: pointer;
	background-color: white;
	font-family: 'Noto Sans KR', sans-serif;
	padding: 3px;
	bottom: 6px
}
.sidebar-text > span{
	position: relative;
	left:20px;
	font-size: 30px;
}

</style>
<div id="myOverlay" class="overlay"></div>
<input type="checkbox" id="menuicon">
<label for="menuicon"> <span></span> <span></span> <span></span>
</label>
<div class="sidebar">
	<ul class="sidebar-text">
		<c:if test="${empty loginMember}">
		<span>MY</span><input type="button" class="sidebar-loginbutton" value="로그인">
		<hr>
		</c:if>
		<li class="sidebar-title">카테고리</li>
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
				<li><a href="#">김대원</a></li>
				<li><a href="#">대원이</a></li>
				<li><a href="#">대원</a></li>
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
