<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />
<style>
.form-inline {
    display: flex;
    justify-content: center; /* 가운데 정렬 */
    margin-top: 45px; /* 위쪽 여백 조정 */
}

.btn-add {
    margin-left: 997px; /* 왼쪽 여백 */
    margin-right: 10px; /* 오른쪽 여백 */
}

/* 수정 및 삭제 링크 스타일 */
.edit-link {
	position: absolute;
	margin-left: 40px;
	margin-top: -10px;
	background: #fff;
	border: 1px solid lightgray;
	padding: 8px;
	cursor: pointer;
}
.delete-link {
	position: absolute;
	margin-left: 12px;
	margin-top: -10px;
	background: #fff;
	border: 1px solid lightgray;
	padding: 8px;
	cursor: pointer;
}
</style>
<!-- 펫 등록 리스트 -->
<section class="common-section" id="common-section-List">
    <div class="common-title">펫 등록 리스트</div>
    <div class="common-container-side">
        <div class="common-div">
 

            <!-- 펫 등록 버튼 -->
            <form action="${pageContext.request.contextPath}/pet/petProfile.do"
               class="form-inline">
				<button class="btn-add">펫 등록하기 </button>
            </form>

            <!-- 펫 리스트 테이블 -->
            <div class="service-util-div-sidebar">
                <table class="service-product-utility-sidebar">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>타입</th>
                            <th>품종</th>
                            <th>성별</th>
                            <th>몸무게</th>
                            <th>나이</th>
                            <th>이름</th>
                            <th>정보 수정</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${pets}" var="pet" varStatus="vs">
                            <tr class="pet-row">
                                <td>${vs.index + 1}</td>                                
                                <td><a href="${pageContext.request.contextPath}/pet/petDetail.do?petId=${pet.petId}">${pet.petKind}</a></td>
                                <td><a href="${pageContext.request.contextPath}/pet/petDetail.do?petId=${pet.petId}">${pet.petBreed}</a></td>
                                <td><a href="${pageContext.request.contextPath}/pet/petDetail.do?petId=${pet.petId}">${pet.petGender == 'M' ? '♂' : '♀'}</a></td>
                                <td><a href="${pageContext.request.contextPath}/pet/petDetail.do?petId=${pet.petId}">${pet.petWeight}</a></td>
                                <td><a href="${pageContext.request.contextPath}/pet/petDetail.do?petId=${pet.petId}">${pet.petAge}</a></td>
                                <td><a href="${pageContext.request.contextPath}/pet/petDetail.do?petId=${pet.petId}">${pet.petName}</a></td>
								<td><a class="edit-link" href="${pageContext.request.contextPath}/pet/petGoDetail.do?petId=${pet.petId}">수정</a></td>
								<td><a class="delete-link" href="javascript:void(0)" onclick="fnDelete('${pet.petId}');">삭제</a></td>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<!-- 펫 정보 삭제 폼 -->
<form:form name="PetDeleteFrm"
    action="${pageContext.request.contextPath}/pet/petDelete.do"
    method="POST">
    <input type="hidden" name="petId" id="getPetId" value="${pet.petId}" />
</form:form>

<!-- Footer Image -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
	$(document).ready(function() {
		var msg = [["${msg}"]];
		if(msg != "") alert(msg);
		
	});
	
	function fnDelete(petId) {
		if(confirm("삭제하시겠습니까?")) {
			$("#getPetId").val(petId);
            document.PetDeleteFrm.submit();
        }
	};
</script>