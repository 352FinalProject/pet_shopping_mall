<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<%-- 리뷰 수정 --%>
<section class="common-section" id="#">
	<div class="common-title">리뷰 수정</div>
	<div class="common-container">
		<div class="common-div">
			<form:form name= "reviewUpdateFrm" action="${pageContext.request.contextPath}/review/reviewUpdate.do" method="post">
				<div class="review-create">
					<div class="input-container">
						<table>
							<tr>
								<th>작성자</th>
								<td>
                    				<input type="text" id="reviewMemberId" name="reviewMemberId" value="<sec:authentication property="name"/>" required readonly/>
                    			</td>
							</tr>
							<tr>
								<th>제목</th>
			                    <td>
			                    	<input type="text" id="reviewTitle" name="reviewTitle" required/>
			                    </td>
							</tr>
							<tr>
								<th>별점</th>
								<td>
									<div class="star-rating">
							        	<input type="hidden" id="reviewStarRate" name="reviewStarRate">
									        <span class="star" onclick="setRating(1)">☆</span>
									        <span class="star" onclick="setRating(2)">☆</span>
									        <span class="star" onclick="setRating(3)">☆</span>
									        <span class="star" onclick="setRating(4)">☆</span>
									        <span class="star" onclick="setRating(5)">☆</span>
					   	 			</div>
								</td>
							</tr>
							<tr>
								<th>사진</th>
							</tr>
							<tr>
								<th>내용</th>
								<td>
                        			<textarea class="review-write-content" id="reviewContent" name="reviewContent" placeholder="리뷰 내용을 작성해주세요." required></textarea>
                    			</td>
							</tr>
						</table>
					</div>
				</div>
			    <div class="review-create-btn">
			        <button class="review-btn-reset" type="reset">초기화</button>
			        <input type="hidden" name="reviewId" value="${reviews.reviewId}">
			        <button class="review-btn-create" type="submit">수정하기</button>
			    </div>
		    </div>
		</div>
	</form:form>
</section>
<script>
    function setRating(rating) {
        const stars = document.querySelectorAll('.star');
        const reviewStarRateInput = document.getElementById('reviewStarRate');
        
        for (let i = 0; i < stars.length; i++) {
            if (i < rating) {
                stars[i].textContent = '★';
            } else {
                stars[i].textContent = '☆';
            }
        }
        reviewStarRateInput.value = rating;
    }
</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />