<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />

<!-- 펫 등록 리스트 -->
<section class="common-section" id="common-section-List">
    <div class="common-title">펫 등록 리스트</div>
    <div class="common-container">
        <div class="common-div">
            <!-- 검색 폼 -->
            <form:form name="petSearchFrm"
                action="${pageContext.request.contextPath}/pet/search.do"
                method="get">
                <div class="service-search">
                    <img
                        src="${pageContext.request.contextPath}/resources/images/home/search.png"
                        alt=""> <input type="text" name="searchKeyword"
                        id="searchKeyword" value="" placeholder="펫 이름 검색" required>
                    <div class="searchKeyword2">
                        <input type="submit" id="searchKeyword2" value="검색">
                    </div>
                </div>
            </form:form>

            <!-- 펫 등록 버튼 -->
            <form action="${pageContext.request.contextPath}/pet/petProfile.do"
                class="form-inline">
                <button class="btn-add">펫 등록</button>
            </form>

            <!-- 펫 리스트 테이블 -->
            <div class="service-util-div">
                <table class="service-product-utility">
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
                                <td><a href="${pageContext.request.contextPath}/pet/petGoDetail.do?petId=${pet.petId}"> 수정 </a></td>
                                <td><a href="javascript:void(0)" onclick="fnDelete('${pet.petId}');"> 삭제 </a></td>
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