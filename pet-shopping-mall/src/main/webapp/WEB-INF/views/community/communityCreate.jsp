<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css" />

<script>
	$(document).ready(function() {
		  $('#summernote').summernote({
	 	    	placeholder: '게시글의 내용을 작성해주세요.',
		        minHeight: 470,
		        maxHeight: null,
		        focus: true, 
		        lang : 'ko-KR'
		  });
		});
	
	function goWrite(frm) {
		var title = frm.title.value;
		var writer = frm.writer.value;
		var content = frm.content.value;
		
		if (title.trim() == ''){
			alert("제목을 입력해주세요");
			return false;
		}
		if (writer.trim() == ''){
			alert("작성자를 입력해주세요");
			return false;
		}
		if (content.trim() == ''){
			alert("내용을 입력해주세요");
			return false;
		}
		frm.submit();
	}
	
    $('#summernote').summernote({
        // 에디터 높이
        height: 150,
        // 에디터 한글 설정
        lang: "ko-KR",
        // 에디터에 커서 이동 (input창의 autofocus라고 생각)
        focus : true,
        toolbar: [
            // 글꼴 설정
            ['fontname', ['fontname']],
            // 글자 크기 설정
            ['fontsize', ['fontsize']],
            // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
            ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
            // 글자색
            ['color', ['forecolor','color']],
            // 표만들기
            ['table', ['table']],
            // 글머리 기호, 번호매기기, 문단정렬
            ['para', ['ul', 'ol', 'paragraph']],
            // 줄간격
            ['height', ['height']],
            // 코드보기, 확대해서보기, 도움말
            ['view', ['codeview','fullscreen', 'help']]
        ],
        // 추가한 글꼴
        fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
        // 추가한 폰트사이즈
        fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']

    });
</script>
<title>글쓰기</title>


		<div class="header">
			<span id="notification"></span>
			<ul class="utility">
			<sec:authorize access="isAuthenticated()">
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
				<li class="logout_li"><a
					href="${pageContext.request.contextPath}/servicecenter/service.do">고객센터</a>
				</li>
				<li class="admin_li"><a
					href="${pageContext.request.contextPath}/admin/admin.do">관리자페이지</a>
				</li>
				<sec:authorize access="isAuthenticated()">
					<li><a class="" type="button" href="#"
						onclick="document.memberLogoutFrm.submit(); return false;">로그아웃</a>
					</li>
					<li>
						<form:form id="deleteMemberForm" action="${pageContext.request.contextPath}/member/deleteMember.do" method="post">
							<a  type="button" href="#" onclick="deleteMember();">회원 탈퇴</a>
						</form:form>
					</li>
				</sec:authorize>
				<li class="community_li"><a
					href="<%=request.getContextPath()%>/community/communityList.do">펫스토리</a>
				</li>
				<li class="community_li"><a
					href="<%=request.getContextPath()%>/community/communityCreate.do">게시글작성</a>
				</li>
				<li class="community_li"><a
					href="<%=request.getContextPath()%>/review/reviewCreate.do">리뷰작성</a>
				</li>
			</ul>
			<div class="logo_top_wrap">
				<div class="logo_wrap">
					<!-- 로고 이미지 -->
					<div class="logo_img">
						<a href="${pageContext.request.contextPath}/"> <img
							src="${pageContext.request.contextPath}/resources/images/home/logo.png"
							id="center-image" alt="로고" />
						</a>
					</div>
					<div class="cdt">
						<!-- 검색 -->
						<div class="search_top_btn">
							<!-- 검색 창 -->
							<div class="search_box">
								<form name="searchBoxForm" id="searchBoxForm" action="">
									<img
										src="${pageContext.request.contextPath}/resources/images/home/search.png"
										id="center-image" alt="검색" />
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
			</div>

</head>
<body>
<h2 style="text-align: center;">글 작성</h2><br><br><br>

<div style="width: 60%; margin: auto;">
	<form method="post" action="/write">
		<input type="text" name="title" style="width: 40%;" placeholder="제목"/>
		<br><br> 
		<textarea id="summernote" name="content"></textarea>
		<br>
		<input id="subBtn" type="button" value="글 작성" style="float: right;" onclick="goWrite(this.form)"/>
	</form>
</div>

</body>

</html>

