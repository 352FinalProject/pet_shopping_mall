<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>

.common-title {
	font-size:24px;
	justify-content: center;
	display: flex;
}

.star {
   color: #5886d3; 
   cursor: pointer;
}

.review-write-table {
  height: 180px;
  width: 600px;
  justify-content: left;
  text-align: left;
  display: flex;
  border: 1px solid lightgray;
  background-color: white;
  margin: auto;
  padding: 20px;
}

.common-div table td {
	padding: 5px;
}

.review-write-content{
  height: 150px;
  width: 600px;
  justify-content: left;
  text-align: left;
  display: flex;
  border: 1px solid lightgray;
  background-color: white;
  margin: auto;
  padding: 10px;
  resize: none; /* textarea 사이즈 조절 금지 */
}

.resetAndSubmit {
    text-align: center; /* 버튼 가운데 정렬 */
    margin-top: 30px; /* 버튼 위 여백 조절 */
}

/* 돌아가기 버튼 */
.resetAndSubmit input[type="reset"] {
	background-color: #c8c8c8;
	margin-right: 10px;
	width: 120px;
	height: 40px;
	border-radius: 20px;
	color: white;
	border: 1px solid #e7e7e7;
	margin-top: 30px;
}

/* 가입하기 버튼 */
.resetAndSubmit input[type="submit"] {
	background-color: #5886d3;
	width: 120px;
	height: 40px;
	border-radius: 20px;
	border: 1px solid #e7e7e7;
	color: white;
}



</style>

<%-- 리뷰작성 (혜령) --%>

<section class="common-section" id="#">
<div class="common-title">상품 후기</div>
<br>
	<div class="common-container">
    	<div class="common-div">
        <form:form action="${pageContext.request.contextPath}/review/reviewCreate.do"
        enctype="multipart/form-data" method="post">
            <table class="review-write-table">
                <tr>
                    <th>작성자</th>
                    <td>
                    	<input type="text" id="reviewMemberId" name="reviewMemberId" value="<sec:authentication property="name"/>" required readonly/>
                    </td>
                </tr>
                <tr>
					<th><label for="starRating">별점</label></th>
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
                	<th>사진첨부</th>
	                <td>
              			<div class="input-group mb-3" style="padding:0px;">
			                  <div class="custom-file">
					    		<input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple>
					    		<label class="custom-file-label" for="upFile1"></label>
					 		  </div>
			 			</div>
			 		</td>
		 		</tr>
                <tr>
                    <th>제목</th>
                    <td>
                    	<input type="text" id="reviewTitle" name="reviewTitle" required/>
                    </td>
                </tr>
            </table>
            <br>
            <table>
            	<tr>
                    <td>
                        <textarea class="review-write-content" id="reviewContent" name="reviewContent" placeholder="리뷰 내용을 작성해주세요." required></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="resetAndSubmit" colspan="2">
                        <input type="reset" value="돌아가기">
                        <input type="submit" value="작성하기">
                    </td>
                </tr>
            </table>
        </form:form>
    </div>
</div>
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
<jsp:include page="/WEB-INF/views/common/footer.jsp" />