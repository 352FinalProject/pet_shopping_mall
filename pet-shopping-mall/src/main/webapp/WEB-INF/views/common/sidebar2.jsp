<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
/* 모달 배경 스타일 */

#deleteMember-password {
	margin-top: 10px;
}
.deleteMemberForm-btn {
	display: flex;
	justify-content: center;
	gap: 10px;
}

.deleteMember-class {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* 반투명한 배경 색상 */
    z-index: 9999; /* 다른 요소보다 위에 표시 */
}

.deleteMember {
	background-color: white;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
	width: 600px;
	height: 350px;
	text-align: center; /* 내부 요소를 가운데 정렬 */
	z-index: 9999; /* 다른 요소 위에 표시되도록 설정 */
	margin-top: 320px;
	margin-left: 700px;
}

deleteMember h2 {
	font-size: 24px;
	margin-bottom: 10px;
	font-size: 24px;
	margin-bottom: 10px;
}

.deleteMember p {
	width: 100%;
	padding: 8px;
	margin-bottom: 10px;
}

.deleteMemberForm-button {
	background-color: #c8c8c8;
	color: white;
	border: none;
	padding: 8px 16px;
	border-radius: 4px;
	cursor: pointer;
}

#deleteMemberForm-closeModalBtn {
	background-color: #5886d3;
	color: white;
	border: none;
	padding: 8px 16px;
	border-radius: 4px;
	height: 34px;
	cursor: pointer;
	font-size: 14px;
}
</style>
<div class="sidebar2">
	<ul class="sidebar2-text">
		<li class="sidebar2-title">마이페이지</li>
		<li class="sidebar2-mysp">
			<h2 class="sidebar2-title2">마이 쇼핑</h2> </a>
			<ul>
				<li><a
					href="${pageContext.request.contextPath}/order/orderList.do">주문내역</a></li>
				<li><a
					href="${pageContext.request.contextPath}/order/cancelOrderList.do">취소내역</a></li>
				<li><a
					href="${pageContext.request.contextPath}/wishlist/myWishlist.do">찜한상품</a></li>
				<li><a
					href="<%=request.getContextPath()%>/servicecenter/inquiry/questionList.do">내가
						쓴 문의</a></li>
				<li><a
					href="${pageContext.request.contextPath}/review/reviewList.do">내가
						쓴 리뷰</a></li>
			</ul>
		</li>
		<li class="sidebar2-mybe">
			<h2 class="sidebar2-title2">마이 혜택</h2> </a>
			<ul>
				<li><a
					href="${pageContext.request.contextPath}/point/pointList.do">포인트
						내역</a></li>
				<li><a
					href="${pageContext.request.contextPath}/coupon/couponList.do">쿠폰
						내역</a></li>
			</ul>
		</li>
		<li class="sidebar2-pro">
			<h2 class="sidebar2-title2">마이 정보</h2> </a>
			<ul>
				<li><a
					href="${pageContext.request.contextPath}/member/updateMember.do">회원정보
						수정</a></li>
				<li><a href="${pageContext.request.contextPath}/pet/petList.do">펫
						목록</a></li>
				<li><a
					href="${pageContext.request.contextPath}/pet/petProfile.do">펫
						등록</a></li>
			</ul>
		</li>
		<li class="sidebar2-member">
			<h2 class="sidebar2-title2"></h2>
			<ul>
				<li><a
					href="${pageContext.request.contextPath}/petcare/petcareList.do">펫케어</a></li>
				</li>
			</ul>
			<form id="deleteMemberForm" action="">
				<a id="deleteMemberBtn" type="button" href="#" onclick="">회원 탈퇴</a>
			</form>
	</ul>
</div>
<div class="deleteMember-wrap">
	<div id="deleteMember-div" class="deleteMember-class"
		style="display: none;">
		<div class="deleteMember">
			<h2>회원 탈퇴</h2>
			<img class="checkimg" src="${pageContext.request.contextPath}/resources/images/존나우는어피치.png" width="100px" height="100px" />
			<p>정말 탈퇴하시겠습니까?</p>
			<form id="deleteMemberForm">
			<label for="deleteMember-password">비밀번호 입력:</label> <input
					class="deleteMemberForm-input-password" type="password"
					id="deleteMember-password" name="password" required>
				<div class="deleteMemberForm-btn">
					<div class="deleteMemberForm-btn1">
						<button class="deleteMemberForm-button" type="button">회원탈퇴</button>
					</div>
					<div class="deleteMemberForm-btn2">
						<button type="button" id="deleteMemberForm-closeModalBtn"
							onclick="closeDeleteMemberModal();">닫기</button></div>
				</div>
			</form>
		</div>
	</div>
</div>
<script>
const closeDeleteModalBtn = document
		.getElementById("deleteMemberForm-closeModalBtn");
const deleteMemberModal = document.getElementById("deleteMember-div");
// 회원탈퇴 버튼 클릭 시 모달 열기
const deleteMemberBtn = document.querySelector("#deleteMemberBtn"); // 수정된 부분
deleteMemberBtn.addEventListener("click", function() {
	deleteMemberModal.style.display = "block";
});

// 모달 닫기 버튼 클릭 시 모달 닫기
closeDeleteModalBtn.addEventListener("click", function() {
	deleteMemberModal.style.display = "none";
});

$(document)
	.ready(function() {
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

$(".deleteMemberForm-button").click(function() {
	const deleteMemberPassword = $("#deleteMember-password").val();
		$.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/member/deleteMember.do',
			data : {
				'password' : deleteMemberPassword
			},
			dataType : "text",
			beforeSend : function(
					xhr) {
				xhr
						.setRequestHeader(
								csrfHeader,
								csrfToken); // 헤더에 CSRF 토큰 추가
			},
			success : function(
					result) {
				console.log(result);
				if (result === "no") {
					alert('비밀번호가 틀렸습니다.');
				} else {
					alert('회원 탈퇴완료ㅠㅠ.');
					window.location.href = '${pageContext.request.contextPath}/';
				}
			},
			error : function() {
				console
						.log('에러 체크!!');
			}
		});
	});
});
</script>