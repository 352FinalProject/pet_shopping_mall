<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>



</style>
<div class="sidebar2">
	<ul class="sidebar2-text">
		<li class="sidebar2-title">마이페이지</li>
		<li class="sidebar2-mysp">
			<h2 class="sidebar2-title2">마이 쇼핑</h2></a>
			<ul>
				<li><a href="${pageContext.request.contextPath}/order/orderList.do">주문내역</a></li>
				<li><a href="${pageContext.request.contextPath}/order/cancelOrderList.do">취소내역</a></li>
				<li><a href="${pageContext.request.contextPath}/wishlist/myWishlist.do">찜한상품</a></li>
				<li><a href="<%= request.getContextPath() %>/servicecenter/inquiry/questionList.do">내가 쓴 문의</a></li>
				<li><a href="${pageContext.request.contextPath}/review/reviewList.do">내가 쓴 리뷰</a></li>
			</ul>
		</li>
		<li class="sidebar2-mybe">
			<h2 class="sidebar2-title2">마이 혜택</h2></a>
			<ul>
				<li><a href="${pageContext.request.contextPath}/point/pointList.do">포인트 내역</a></li>
				<li><a href="${pageContext.request.contextPath}/coupon/couponList.do">쿠폰 내역</a></li>
			</ul>
		</li>
		<li class="sidebar2-pro">
			<h2 class="sidebar2-title2">마이 정보</h2></a>
			<ul>
				<li><a href="${pageContext.request.contextPath}/member/updateMember.do">회원정보 수정</a></li>
				<li><a href="${pageContext.request.contextPath}/pet/petList.do">펫 목록</a></li>
				<li><a href="${pageContext.request.contextPath}/pet/petProfile.do">펫 등록</a></li>
			</ul>
		</li>
		<li class="sidebar2-member">
			<h2 class="sidebar2-title2"></h2></a>
			<form:form id="deleteMemberForm" action="${pageContext.request.contextPath}/member/deleteMember.do" method="post">
				<a  type="button" href="#" onclick="closeIdFinderModal();">회원 탈퇴</a>
			</form:form>
		</li>
	</ul>
</div>
<div id="deleteMember-div" class="deleteMember-class">
	<div class=deleteMember>
		<span class="deletememberForm-close" >&times;</span>
		<h2>회원 탈퇴</h2>
		<p>정말 탈퇴하시겠습니까??</p>
		<form:form id="deleteMemberForm"
			onsubmit="submitIdFinderForm(); return false;">
			<label for="deleteMember-password">비밀번호입력:</label> <input
				class="deleteMemberForm-input-password" type="password" id="password"
				name="password" required>
			<button class="deleteMemberForm-button" type="submit" >회원탈퇴</button>
				<button type="button" id="deleteMemberForm-closeModalBtn" onclick="closDeleteMemberModal();">닫기</button>
		</form:form>
	</div>
</div>
<script>
$(document).ready(function() {
	  const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
	  const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

	  $("#deleteMemberForm-closeModalBtn").click(function() {
	    const deleteMemberPassword = $("#deleteMember-password").val();
	    $.ajax({
	      type: 'POST',
	      url: '${pageContext.request.contextPath}/member/deleteMember.do',
	      data: {
	        'password': deleteMemberPassword
	      },
	      dataType: "text",
	      beforeSend: function(xhr) {
	        xhr.setRequestHeader(csrfHeader, csrfToken); // Add CSRF token to header
	      },
	      success: function(result) {
	        console.log(result);
	        if (result === "no") {
	          alert('비밀번호가 틀렸습니다.');
	        } else {
	          alert('회원 탈퇴완료ㅠㅠ.');
	        }
	      },
	      error: function() {
	        console.log('에러 체크!!');
	      }
	    });
	  });
</script>
