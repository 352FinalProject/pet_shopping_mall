<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<h1>
	<c:forEach begin="1" end="30" var="count">
    <span>관리자 홈입니다.</span>
	</c:forEach>
</h1>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>