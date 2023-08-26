<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />

<%-- 내 리뷰 조회 (혜령) --%>
<section class="common-section" id="common-section-List" style="padding-bottom: 350px;" >
    <div class="common-title">내가 쓴 리뷰</div>
    <div class="common-container">
        <div class="common-div">
            <div class="review-util-div">
                <table class="service-product-utility">
					<thead>
						<tr>
							<th>번호</th>
							<th>상품명</th>
							<th>별점</th>
							<th>작성일</th>
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
                        <tr>
                        	<td>
                        		<a href="${pageContext.request.contextPath}/review/reviewDetail.do?reviewId=${review.reviewId}">${review.reviewId}</a>
                        	</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/review/reviewDetail.do?reviewId=${review.reviewId}">
	                                <c:if test="${not empty orderDetail}">
			                            <c:forEach var="orderMap" items="${orderDetail}">
										<c:forEach var="entry" items="${orderMap}">
										<c:set var="index" value="${entry.key.orderStatus}"/>
										<c:set var="option" value="${entry.key.optionName}" />
										<c:set var="amount" value="${entry.key.amount}" />
							            <%-- <div>
							                <p>index: ${index}, option: ${option}, amount: ${amount}</p>
							            </div> --%>
		                                <div style="display: flex; align-items: center;">
	                                        <img style="width: 100px; height: 100px; margin-right: 10px; cursor: pointer;"
		                                        	src="${pageContext.request.contextPath}/resources/upload/product/${entry.key.imageRenamedFileName}">
												<div>
													<p>${entry.key.productName}</p>
													<br />
													<c:if test="${option eq null}">
														<p>선택된 옵션이 없습니다.</p>
													</c:if>
													<c:if test="${option ne null}">
														<p>${entry.key.optionName} : ${entry.key.optionValue}</p>
													</c:if>
														<p>수량: ${entry.key.quantity}개</p>
		                                		</div>
		                                </c:forEach>
		                                </c:forEach>
	                                </c:if>
                                </a>
                            </td>
                            <td>
                            	<a href="${pageContext.request.contextPath}/review/reviewDetail.do?reviewId=${review.reviewId}">
                                <c:choose>
							        <c:when test="${review.reviewStarRate == 1}">
							            <span class="star-rating">★</span> (1)
							        </c:when>
							        <c:when test="${review.reviewStarRate == 2}">
							            <span class="star-rating">★★</span>  (2)
							        </c:when>
							        <c:when test="${review.reviewStarRate == 3}">
							            <span class="star-rating">★★★</span> (3)
							        </c:when> 
							        <c:when test="${review.reviewStarRate == 4}">
							            <span class="star-rating">★★★★</span> (4)
							        </c:when>
							        <c:when test="${review.reviewStarRate == 5}">
							            <span class="star-rating">★★★★★</span> (5)
							        </c:when>
    							</c:choose>
    							</a>
                            </td>
                            <td>
                            	<a href="${pageContext.request.contextPath}/review/reviewDetail.do?reviewId=${review.reviewId}">
								<fmt:parseDate value="${review.reviewCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
								<fmt:formatDate value="${createdAt}" pattern="yy/MM/dd HH:mm"/>
								</a>
                            </td>
                        </tr>
                        </c:forEach>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- 페이징 바 -->
	<nav aria-label="..." >
	  	<ul class="pagination pagination-sm">
		    <c:forEach begin="1" end="${totalPages}" var="pageNumber">
		        <li class="page-item ${page == pageNumber ? 'active' : ''}">
		            <a class="page-link" href="${pageContext.request.contextPath}/review/reviewList.do?page=${pageNumber}">
	                    <span class="page-number">${pageNumber}</span>
	                </a>
		        </li>
		    </c:forEach>
		</ul>
	</nav>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
