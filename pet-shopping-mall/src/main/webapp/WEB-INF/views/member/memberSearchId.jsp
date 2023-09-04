<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />	
<style>
 #modal.modal-overlay {
 
 }
 

</style>
</head>

<body>
<%@ include file="./Modal.jsp" %>

	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			
				<div class="w3-center w3-large w3-margin-top">
					<h3>아이디 찾기</h3>
				</div>
				<div>
					<p>
						<label>이름</label>
						<input class="w3-input" type="text" id="name" name="name" placeholder="이름을 입력해주세요." required>
					</p>
					
					<p>
						<label>이메일</label>
						<input class="w3-input" type="text" id="email" name="email" placeholder="메일을 입력해주세요." required>
					</p>
					
					<p class="w3-center">
						<button type="button" id='find_id' onclick="findId_click()" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">찾기</button>
						<button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">취소</button>
					</p>
				</div>
			
		</div>
	</div>
<script>
/* 아이디 찾기 */ 
//아이디 & 스토어 값 저장하기 위한 변수
	// 아이디 값 받고 출력하는 ajax
	function findId_click(){
		var name=$('#name').val()
		var email=$('#email').val()
		
		$.ajax({
			url:"./memberSearchId",
			type:"POST",
			data:{"name":name, "email":email} ,
			success:function(data){
				if(data == 0){
					$('#id_value').text("회원 정보를 확인해주세요!");
					$('#name').val('');
					$('#email').val('');
				} else {
					$('#id_value').text(data);
					$('#name').val('');
					$('#email').val('');
					
				}
			},
			 error:function(){
	                alert("에러입니다");
	            }
		});
	};

const modal = document.getElementById("modal")
const btnModal = document.getElementById("memberSearchId")

btnModal.addEventListener("click", e => {
    modal.style.display = "flex"
})

    
const closeBtn = modal.querySelector(".close-area")
closeBtn.addEventListener("click", e => {
    modal.style.display = "none"
})

modal.addEventListener("click", e => {
    const evTarget = e.target
    if(evTarget.classList.contains("modal-overlay")) {
        modal.style.display = "none"
    }
})
</script>	
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />	
