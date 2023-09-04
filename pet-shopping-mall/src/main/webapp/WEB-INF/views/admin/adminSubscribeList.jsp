<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<div id="layoutSidenav_content">
	<main>
		<div class="container-fluid px-4">
			<h2 class="mt-3">구독회원 조회</h2>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"></li>
			</ol>
			<div class="card mb-4">
				<div class="card-body">
					<div class="admin-member-search-container">
						<form:form name="adminMemberSearchFrm"
							action="${pageContext.request.contextPath}/admin/adminSubscribeSearchByNameOrId.do"
							method="get">
							<div class="input-group">
								<input type="text" id="searchKeyword" name="searchKeyword" placeholder="회원명 또는 아이디">
								<input type="submit" value="검색" class ="btn btn-secondary" >
							</div>
						</form:form>
					</div>
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">
					<i class="fas fa-table me-1"></i> 현재 구독회원 : ${totalCount}명
				</div>
				
				<div class="card-body">
					<table id="datatablesSimple">
						<thead>
							<th>회원아이디</th>
							<th>이름</th>
							<th>전화번호</th>
							<th>이메일</th>
							<th>가입일</th>
							<th>주소</th>
							<th>생일</th>
						</thead>
						<tbody>
							<c:forEach items="${subscribedMembers}" var="member" varStatus="vs">
								<tr>
									<td>${member.memberId}</td>
									<td>${member.name}</td>
									<td>${member.phone}</td>
									<td>${member.email}</td>
									<td>${member.enrollDate}</td>
									<td>${member.address}</td>
									<td>${member.birthday}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>