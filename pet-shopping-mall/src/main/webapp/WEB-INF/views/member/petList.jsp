<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<%-- 1:1 문의 내역 (예라) --%>
<section class="common-section" id="common-section-List">

	<div class="common-title">나의 펫 정보</div>
	<div class="common-container">
		<div class="common-div">
			<form:form name="questionSearchFrm" 
				action="${pageContext.request.contextPath}/servicecenter/inquiry/questionSearch.do" method="get">
				<div class="service-search">
					<img src="${pageContext.request.contextPath}/resources/images/home/search.png" alt="">
					<input type="text" name="searchKeyword" id="searchKeyword" value="" placeholder="반려동물 이름" required>
				<div class="searchKeyword2">
       			<input type="submit" id="searchKeyword2" value="검색">
       			</div>
			</div>
			</form:form>

			<div class="service-util-div">
				<table class="service-product-utility">
			<table>
			    <thead>
			        <tr>
			            <th>번호</th>
			            <th>타입</th>
			            <th>품종</th>
			            <th>성별</th>
			            <th>생일</th>
			            <th>나이</th>
			            <th>이름</th>
			            <th>정보 수정</th>
			        </tr>
			    </thead>
					    <tbody>
					        <c:forEach items="${petList}" var="pet" varStatus="vs">
					            <tr>
					                <td>${vs.index + 1}</td>
					                <td>${pet.petKind}</td>
					                <td>${pet.petBreed}</td>
					                <td>${pet.petGender}</td>
					                <td>${pet.petDofB}</td>
					                <td>${calculateAge(pet.petDofB)}</td>
					                <td>${pet.petName}</td>
					                <td>
					                    <a href="${pageContext.request.contextPath}/edit/${pet.petId}"> 수정</a>
					                    <a href="${pageContext.request.contextPath}/delete/${pet.petId}">삭제</a>
					                </td>
					            </tr>
					        </c:forEach>
					    </tbody>
					</table>
				</table>
			</div>
		</div>
	</div>
<nav aria-label="...">
  	<ul class="pagination pagination-sm">
	    <c:forEach begin="1" end="${totalPages}" var="pageNumber">
	        <li class="page-item ${page == pageNumber ? 'active' : ''}">
	            <a class="page-link" href="${pageContext.request.contextPath}/member/petList.do?page=${pageNumber}">
                    <span class="page-number">${pageNumber}</span>
                </a>
	        </li>
	    </c:forEach>
	</ul>
</nav>
</section>
<script>
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />