<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />
<%-- 1:1 문의 내역 (예라) --%>
<section class="common-section" id="common-section-List">
	<div class="common-title">1:1 문의 내역</div>
		<div class="common-container-side">
			<div class="common-div">
				<form:form name="questionSearchFrm" 
					action="${pageContext.request.contextPath}/servicecenter/inquiry/questionSearch.do" method="get">
					<div class="service-search">
						<img src="${pageContext.request.contextPath}/resources/images/home/search.png" alt="">
						<input type="text" name="searchKeyword" id="searchKeyword" value="" placeholder="제목 또는 내용" required>
					</div>
				</form:form>
			<form action="${pageContext.request.contextPath}/servicecenter/inquiry/questionCreate.do" class="form-inline">
				<button class="btn-add">1:1문의 쓰기</button>
			</form>
			<div class="service-util-div-sidebar">
				<table class="service-product-utility-sidebar">
					<thead>
						<tr>
							<th>번호</th>
							<th>상태</th>
							<th>제목</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${questions}" var="question" varStatus="vs">
							<sec:authentication var="currentUsername" property="principal.username"/>
								<c:if test="${question.questionMemberId == currentUsername}">
							        <tr class="question-row">
							            <td>
							                <a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.questionId}">${question.questionId}</a>
							            </td>
							            <td>
							                <a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.questionId}">
							                <c:if test="${question.answerCount <= 0}"><span>답변대기</span></c:if>
							                <c:if test="${question.answerCount >= 1}">답변완료</c:if>
							            </td>
							            <td><a href="${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=${question.questionId}">${question.questionTitle}</a></td>
							            <td class="qna-date">
							              	<fmt:parseDate value="${question.questionCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="questionCreatedAt" />
											<fmt:formatDate value="${questionCreatedAt}" pattern="yy/MM/dd" />
							            </td>
							        </tr>
							    </c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
<nav aria-label="...">
  	<ul class="pagination pagination-sm">
	    <c:forEach begin="1" end="${totalPages}" var="pageNumber">
	        <li class="page-item ${page == pageNumber ? 'active' : ''}">
	            <a class="page-link" href="${pageContext.request.contextPath}/servicecenter/inquiry/questionList.do?page=${pageNumber}">
                    <span class="page-number">${pageNumber}</span>
                </a>
	        </li>
	    </c:forEach>
	</ul>
</nav>
</section>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>

//실시간 검색 기능
$(document).ready(function(){
  $('#searchKeyword').on('input', function() {
    const searchKeyword = $(this).val();
  
    if (searchKeyword.length > 0) {
      $.ajax({
        type: 'GET',
        url: '${pageContext.request.contextPath}/servicecenter/inquiry/questionSearch.do',
        data: { searchKeyword: searchKeyword },
        dataType: 'json'
      }).done(function(data) {
        updateQuestionList(data.questions);
      }).fail(function(jqXHR, textStatus, errorThrown) {
        console.log('Error:', textStatus);
      });
    }
  });

  // 화면 업데이트 함수
  function updateQuestionList(questions) {
    const tableBody = document.querySelector('.service-product-utility tbody');
    tableBody.innerHTML = ''; // 기존의 내용을 모두 지우기

    questions.forEach(function(que) {
    console.log(que);
      const row = document.createElement('tr');
      
      const idCell = document.createElement('td');
      idCell.textContent = que.questionId;
      row.appendChild(idCell);

      const answerStatusCell = document.createElement('td');
      const answerStatusText = que.answerCount <= 1 ? '답변대기' : '답변완료';
      answerStatusCell.textContent = answerStatusText;
      answerStatusCell.style.color = que.answerCount <= 1 ? 'lightgray' : 'black'; // 색상 변경
      row.appendChild(answerStatusCell);

      const titleCell = document.createElement('td');
      titleCell.textContent = que.questionTitle;
      row.appendChild(titleCell);

      const createdAtCell = document.createElement('td');
      const questionCreatedAt = new Date(que.questionCreatedAt); // 날짜를 Date 객체로 파싱
      const formattedDate = questionCreatedAt.toLocaleString('en-US', { year: '2-digit', month: '2-digit', day: '2-digit' });
      createdAtCell.textContent = formattedDate;
      row.appendChild(createdAtCell);

      // 검색 결과 항목에 클릭 이벤트 추가
      row.addEventListener('click', function() {
        window.location.href = '${pageContext.request.contextPath}/servicecenter/inquiry/questionDetail.do?questionId=' + que.questionId;
      });

      tableBody.appendChild(row);
    });
  }
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />