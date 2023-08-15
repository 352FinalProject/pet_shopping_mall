<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>




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
			<form action="${pageContext.request.contextPath}/pet/create.do"
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
							<th>생일</th>
							<th>이름</th>
							<th>정보 수정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pets}" var="pet" varStatus="vs">
							<tr class="pet-row">
								<td>${vs.index + 1}</td>
								<td>${pet.petKind}</td>
								<td>${pet.petBreed}</td>
								<td>${pet.petGender == 'M' ? '수컷' : '암컷'}</td>
								<td>${pet.petDofB}</td>
								<td>${pet.petName}</td>
								<td><a
									href="${pageContext.request.contextPath}/pet/updateForm.do?petId=${pet.petId}"> 수정 </a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
					<button type="button" onclick="PetDelete();" class="">삭제하기</button>
					<!-- 펫 정보 삭제 폼 -->
					<form:form name="PetDeleteFrm"
					   action="${pageContext.request.contextPath}/member/petDelete.do"
					   method="POST">
					   <input type="hidden" name="petId" value="${pet.petId}" />
					</form:form>
					</section>
					<script> // 
					const PetDelete = () => {
						   if(confirm("질문을 삭제하시겠습니까?")) {
						      document.PetDeleteFrm.submit();
						   }
						};
//const PetDelete = () => {
//	it(confirm("펫 정보를 삭제하시겠습니까?")) {
//		document.PetDeleteFrm.submit();
//	}
//};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
