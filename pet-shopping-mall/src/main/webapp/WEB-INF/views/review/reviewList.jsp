<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
    .accordion-content {
        display: none;
        padding: 10px;
        background-color: white;
    }
</style>
<%-- 내 리뷰 조회 (혜령) --%>
<section class="common-section" id="common-section-List">
    <div class="common-title">내가 쓴 리뷰</div>
    <div class="common-container">
        <div class="common-div">
    		<form:form name="questionSearchFrm" 
			action="${pageContext.request.contextPath}/review/reviewList.do" method="get">
            <div class="service-util-div">
                <table class="service-product-utility">
					<thead>
						<tr>
							<th>번호</th>
							<th>상품명</th>
							<th>옵션</th>
							<th>별점</th>
							<th>날짜</th>
						</tr>
					</thead>
                    <tbody>
                    	<c:if test="${empty reviews}">
                    		<tr>
                    			<td colspan="5">작성된 리뷰가 없습니다.</td>
                    		</tr>
                    	</c:if>
                    	<c:if test="${not empty reviews}">
                    	<c:forEach items="${reviews}" var="review" varStatus="vs">
                        <tr class="table-row">
                        	<td>
                        		<a href="${pageContext.request.contextPath}/review/reviewDetail.do?reviewId=${review.reviewId}">${review.reviewId}</a>
                        	</td>
                            <td>
                                <div style="display: flex; align-items: center;">
                                    <img style="width: 100px; height: 100px; margin-right: 10px; cursor: pointer;" alt="상품이미지" 
                                        class="product-img"
                                        src="${pageContext.request.contextPath}/resources/images/상품/1.jpeg"
                                        onclick="toggleAccordion(this);">
                                    <div style="text-align: center;">
                                        귀여운 리드줄
                                    </div>
                                </div>
                            </td>
                            <td style="vertical-align: middle;">
                                <div style="display: flex; flex-direction: column;">
                                    <div>색상 : 노란색</div>
                                    <div>수량 : 1개</div>
                                </div>
                            </td>
                            <td style="vertical-align: middle;">
                                ${review.reviewStarRate}
                            </td>
                            <td style="vertical-align: middle;">
								<fmt:parseDate value="${review.reviewCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
								<fmt:formatDate value="${createdAt}" pattern="yy/MM/dd HH:mm"/>
                            </td>
                        </tr>
                        </c:forEach>
                        </c:if>
                    </tbody>
                </table>
            </div>
            </form:form>
        </div>
    </div>
</section>

<section class="myReview accordion-content">
    <h3>혜령공주</h3>
    <div> 두부 | 여 | 8살 | 4.0kg | 비숑 </div>
    <div>
        ★(5)
    </div>
    <div>
        <img style="width: 100px; height: 100px; margin-right: 10px;" alt="상품이미지" 
            class="product-img"
            src="${pageContext.request.contextPath}/resources/images/상품/1.jpeg">
    </div>
    <div>
        졸려 졸려 졸려 
    </div>
</section>

<script>
    function toggleAccordion(imageElement) {
        const accordionContent = imageElement.closest('.table-row').nextElementSibling;
        if (accordionContent) {
            accordionContent.classList.toggle('active');
        }
    }
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />