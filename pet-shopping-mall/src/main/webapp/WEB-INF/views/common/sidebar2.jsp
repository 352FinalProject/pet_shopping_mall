<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.deleteMember {
	background-color: white;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
	width: 700px;
	height: 300px; justify-content : center; /* 수평 가운데 정렬 */
	align-items: center; /* 수직 가운데 정렬 */
	text-align: center; /* 내부 요소를 가운데 정렬 */
	z-index: 9999; /* 다른 요소 위에 표시되도록 설정 */
	margin-top: 500px;
	margin-left: 900px;
	justify-content: center;
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
	margin-right: 570px;
}

#deleteMemberForm-closeModalBtn {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 8px 16px;
	border-radius: 4px;
	margin-top: 670px;
	margin-right: 690px;
	height: 35px;
	cursor: pointer;
	font-size: 18px;
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
			<form id="deleteMemberForm" action="">
				<a id="deleteMemberBtn" type="button" href="#" onclick="">회원 탈퇴</a>
			</form>
		</li>
	</ul>
</div>
<div id="deleteMember-div" class="deleteMember-class"
	style="display: none;">
	<div class="deleteMember">
		<h2>회원 탈퇴</h2>
		<p>정말 탈퇴하시겠습니까??</p>
		<form id="deleteMemberForm">
			<label for="deleteMember-password">비밀번호입력:</label> <input
				class="deleteMemberForm-input-password" type="password"
				id="deleteMember-password" name="password" required>
			<button class="deleteMemberForm-button" type="button">회원탈퇴</button>
			<button type="button" id="deleteMemberForm-closeModalBtn"
				onclick="closeDeleteMemberModal();">닫기</button>
		</form>
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

	$(document).ready(function() {
	    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
	    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

	    $(".deleteMemberForm-button").click(function() {
	        const deleteMemberPassword = $("#deleteMember-password").val();
	        $.ajax({
	            type: 'POST',
	            url: '${pageContext.request.contextPath}/member/deleteMember.do',
	            data: {
	                'password': deleteMemberPassword
	            },
	            dataType: "text",
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader(csrfHeader, csrfToken); // 헤더에 CSRF 토큰 추가
	            },
	            success: function(result) {
	                console.log(result);
	                if (result === "no") {
	                    alert('비밀번호가 틀렸습니다.');
	                } else {
	                    alert('회원 탈퇴완료ㅠㅠ.');
	                    window.location.href = '${pageContext.request.contextPath}/';
	                }
	            },
	            error: function() {
	                console.log('에러 체크!!');
	            }
	        });
	    });
	});

	function sample4_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 참고 항목 변수

	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample4_postcode').value = data.zonecode;
	            document.getElementById("roadAddress").value = roadAddr;
	            document.getElementById("jibunAddress").value = data.jibunAddress;
	         
	            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	            if(roadAddr !== ''){
	                document.getElementById("extraAddress").value = extraRoadAddr;

	            } else {
	                document.getElementById("extraAddress").value = '';
	            }
	            document.getElementById('roadAddress').value = roadAddr;
	           
	            // 도로명 주소와 지번 주소, 상세 주소를 합쳐서 전체 주소로 설정한다.
	            var jibunAddress = data.jibunAddress; // Add this line
	            var fullAddress = roadAddr + jibunAddress + " " + document.getElementById("detailAddress").value;
	            document.getElementById("address").value = fullAddress;
	        }
	    }).open();
	};

	function updateAddress() {
	    const roadAddress = document.getElementById("roadAddress").value;
	    const jibunAddress = document.getElementById("jibunAddress").value;
	    const detailAddress = document.getElementById("detailAddress").value;

	    var fullAddress = roadAddress + jibunAddress + " " + detailAddress;
	    document.getElementById("address").value = fullAddress;
	}	
	
	
</script>

