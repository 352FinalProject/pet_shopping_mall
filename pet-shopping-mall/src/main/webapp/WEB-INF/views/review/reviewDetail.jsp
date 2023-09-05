<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Image Slider Example</title>
<!-- Bootstrap CSS 포함 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
/* 부트스트랩 색깔 지정 */
a {
    color: black;
}
</style>
<%-- 리뷰 상세 조회 (혜령) --%>
<section class="common-section" id="#">
	<div class="common-title">리뷰 상세</div>
	<br>
	<div class="review-container">
		<%-- 작성일 --%>
		<div id="review-div"></div>
			<div class="review-createdAt">					
				<fmt:parseDate value="${reviews.reviewCreatedAt}" pattern="yyyy-MM-dd'T'HH:mm"
							   var="createdAt" /> <fmt:formatDate value="${createdAt}"
							   pattern="yyyy.MM.dd" /><span class="small-space"></span>
			</div>
		<br>
		<%-- 리뷰제목 --%>
		<div id="review-div"></div>
			<span class="review-div-title">${reviews.reviewTitle}</span><span class="small-space"></span>
		<br>
		<%-- 펫 이름, 성별, 나이, 몸무게, 품종 --%>
 		<div id="review-div"></div>
			<div id="review-div">
				<c:if test="${reviews.petId != 0}">
				     <em class="review-pet-name">${reviews.petName} &nbsp; <em class="review-em">|</em></em>
				     <em class="review-pet-gender">${reviews.petGender} &nbsp;<em class="review-em">|</em></em>
				     <em class="review-pet-age">${reviews.petAge}살 &nbsp;<em class="review-em">|</em></em>
				     <em class="review-pet-weight">${reviews.petWeight}kg &nbsp;<em class="review-em">|</em></em>
				     <em class="review-pet-breed">${reviews.petBreed} &nbsp;<em class="review-em">|</em></em>
				</c:if>
				<c:if test="${reviews.petId == 0}">
				   <em class="review-pet-name">등록된 펫 정보가 없습니다.</em>
				</c:if>
			</div><span class="small-space"></span>
		<br><span class="small-space"></span>
		<%-- 상품 옵션 --%>
		<div id="review-div"></div>
			<div id="review-div">
			${reviewProduct.productName}
			<br>
			<c:if test="${reviewProduct.optionValue eq null}">
				선택된 옵션이 없습니다.
			</c:if>
			<c:if test="${reviewProduct.optionValue ne null }">
				${reviewProduct.optionName}:${reviewProduct.optionValue}
			</c:if>
			</div><span class="small-space"></span>
		<br>
		<%-- 별점 --%>
		<div id="review-div"></div>
			<div id="review-div-star">
				<!-- <div class="star-rating-detail" id="starContainer"></div></div> -->
	            <c:choose>
			        <c:when test="${reviews.reviewStarRate == 1}">
			            <span class="star-rating-detail">★☆☆☆☆</span> (1.0)
			        </c:when>
			        <c:when test="${reviews.reviewStarRate == 2}">
			            <span class="star-rating-detail">★★☆☆☆</span>  (2.0)
			        </c:when>
			        <c:when test="${reviews.reviewStarRate == 3}">
			            <span class="star-rating-detail">★★★☆☆</span> (3.0)
			        </c:when> 
			        <c:when test="${reviews.reviewStarRate == 4}">
			            <span class="star-rating-detail">★★★★☆</span> (4.0)
			        </c:when>
			        <c:when test="${reviews.reviewStarRate == 5}">
			            <span class="star-rating-detail">★★★★★</span> (5.0)
			        </c:when>
				</c:choose>
			</div><span class="small-space"></span>
		<br>
		
		<%-- 이미지 --%>
		<div class="review-img">
			<div style="display: inline-block;"></div>
			<br>
				<div id="imageCarousel" class="carousel slide"
					data-interval="false">
					<div class="carousel-inner">
						<c:forEach var="attachment" items="${reviewDetails.attachments}"
							varStatus="loop">
							<c:set var="imageRenamedFilename"
								value="${attachment.imageRenamedFilename}" />
							<c:set var="imagePath"
								value="resources/upload/review/${imageRenamedFilename}" />
							<c:set var="imageSrc"
								value="${pageContext.request.contextPath}/${imagePath}" />
							<div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
								<img class="review-img2" alt="리뷰이미지" src="${imageSrc}">
							</div>
						</c:forEach>
					</div>
					<a class="carousel-control-prev" href="#imageCarousel"
						data-slide="prev"> <span class="carousel-control-prev-icon"></span>
					</a> <a class="carousel-control-next" href="#imageCarousel"
						data-slide="next"> <span class="carousel-control-next-icon"></span>
					</a>
				</div>
			</div>
			<br>
		</div>
	<br>
	<table class="review-write-table2">
		<tr>
			<td><textarea class="review-detail-content"
					name="review-content" id="reviewContent" rows="10" cols="59"
					readonly style="resize: none; text-align: left;">
					${reviews.reviewContent}
					</textarea></td>
		</tr>
	</table>
	<div class="review-create-btn">
		<form action="${pageContext.request.contextPath}/review/reviewList.do"
			class="form-inline">
			<button class="review-btn-rset" type="submit">목록</button>
		</form>
		<button type="button" onclick="reviewDelete();"
			class="review-btn-delete">삭제하기</button>
		<c:if test="${!empty reviews.reviewContent}">
			<form
				action="${pageContext.request.contextPath}/review/reviewUpdate.do?reviewId=${reviews.reviewId}">
				<input type="hidden" name="reviewId" value="${reviews.reviewId}">
				<button class="review-btn-update" type="submit">수정하기</button>
			</form>
		</c:if>
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>



<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />