<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 리뷰 상세 조회 (혜령) --%>
<section class="common-section" id="#">
	<div class="common-title">리뷰 상세</div>
	<br>
	<div class="common-container">
		<div class="common-div">
					<table class="review-detail-table">
						<tr>
							<th>제목</th>
							<td class="review-detail-title input[type="text"]">
								<input type="text" name="reviewTitle" id="reivewTitle" readonly value="${reviews.reviewTitle}"required>
							</td>
						</tr>
						<tr>
							<th>작성일</th>
							<td class="revew-createdAt"> 
								<fmt:parseDate value="${reviews.reviewCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
								<fmt:formatDate value="${createdAt}" pattern="yy/MM/dd HH:mm"/>
							</td>
						</tr>
						<tr>
							<th>별점</th>
							<td>
								<div class="star-rating-detail" id="starContainer"></div>
							</td>
						<tr>
							<th>이미지</th>
						    <td>
						    </td>
						</tr>
					</table>
					<br>
				</div>
			</div>
		</div>
		<table class="review-write-table2">
			<tr>
				<td>
					<textarea class="review-detail-content" name="review-content" id="reviewContent"
						rows="10" cols="59" readonly style="resize: none; text-align:left; ">
					${reviews.reviewContent}
					</textarea>
				</td>
			</tr>
		</table>
		<div class="review-create-btn">
			<form
				action="${pageContext.request.contextPath}/review/reviewList.do"
				class="form-inline">
				<button class="review-btn-rset" type="submit">목록</button>
			</form>
			<button type="button" onclick="reviewDelete();"
				class="review-btn-delete">삭제하기</button>
			<c:if test="${!empty reviews.reviewContent}">
				<form
					action="${pageContext.request.contextPath}/review/reviewUpdate.do?reviewId=${reviews.reviewId}">
					<input type="hidden" name="reviewId"
						value="${reviews.reviewId}">
					<button class="review-btn-update" type="submit">수정하기</button>
				</form>
			</c:if>
		</div>
	</div>
<form:form name="reviewDeleteFrm"
	action="${pageContext.request.contextPath}/review/reviewDelete.do"
	method="POST">
	<input type="hidden" name="reviewId" value="${reviews.reviewId}" />
</form:form>
</section>

<script>

// 리뷰 삭제
const reviewDelete = () => {
	if(confirm("작성한 리뷰를 삭제하시겠습니까? \n리뷰를 삭제하시면 리뷰작성 포인트도 함께 차감됩니다.")) {
		document.reviewDeleteFrm.submit();
	}
};

// 별점
function displayStars(starRate) {
    const starContainer = document.getElementById('starContainer');
    starContainer.innerHTML = ''; 

    for (let i = 1; i <= 5; i++) {
        const star = document.createElement('span');
        star.className = 'star';
        
        if (i <= starRate) {
            star.textContent = '★';
        } else {
            star.textContent = '☆';
        }
        
        starContainer.appendChild(star);
    }
}

// 별 찍히게 하기
const reviewStarRate = ${reviews.reviewStarRate};
displayStars(reviewStarRate);


</script>



<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />