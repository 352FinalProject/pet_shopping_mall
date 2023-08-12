<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="admin-member-search-container">
       <form:form
		name="adminMemberSearchFrm" 
		action="${pageContext.request.contextPath}/admin/adminMemberSearchByNameOrId.do"
		method="get">
        <label for="searchKeyword">회원검색:</label>
        <select name="searchCategory">
            <option value="memberName">회원명</option>
            <option value="memberId">아이디</option>
        </select>
        <input type="text" id="searchKeyword" name="searchKeyword" placeholder="회원명 또는 아이디">
        <input type="submit" value="검색">
   	</form:form>
</div>

<table class="table table-striped table-hover">
	<thead class="table-dark">
		<tr>
			<th>no</th>
			<th>회원번호</th>
			<th>회원아이디</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>가입일</th>
			<th>주소</th>
			<th>생일</th>
			<th>포인트</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${empty members}">
			<tr>
				<td colspan="5" class="text-center">조회된 회원이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty members}">
			<c:forEach items="${members}" var="members" varStatus="vs">
				<tr>
					<td>${vs.count}</td>
					<td>${members.id}</td>
					<td>${members.memberId}</td>
					<td>${members.name}</td>
					<td>${members.phone}</td>
					<td>${members.email}</td>
					<td>${members.enrollDate}</td>
					<td>${members.address}</td>
					<td>${members.birthday}</td>
					<td>${members.point}</td>
					<td><button onclick="submit">수정</button></td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>



<jsp:include page="/WEB-INF/views/common/footer.jsp" />