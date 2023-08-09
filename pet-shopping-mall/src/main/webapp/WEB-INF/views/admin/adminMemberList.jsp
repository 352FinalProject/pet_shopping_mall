<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<table class="table table-striped table-hover">
	<thead class="table-dark">
		<tr>
			<th>회원번호</th>
			<th>회원아이디</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>가입일</th>
			<th>주소</th>
			<th>생일</th>
			<th>포인트</th>
			<th>구독유무</th>
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach begin="0" end="20" step="1" varStatus="status">
			<tr>
				<td>member.id</td>
				<td>member.memberId</td>
				<td>member.name</td>
				<td>member.phone</td>
				<td>member.email</td>
				<td>member.createAt</td>
				<td>member.address</td>
				<td>member.birthday</td>
				<td>member.point</td>
				<td>member.subscribe</td>
				<td><button onclick="">수정</button> <button onclick="">삭제</button></td>
			</tr>
		</c:forEach>
	</tbody>
</table>


















<jsp:include page="/WEB-INF/views/common/footer.jsp" />