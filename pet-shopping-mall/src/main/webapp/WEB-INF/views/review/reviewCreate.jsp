<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/sidebar2.jsp" />


<%-- 리뷰작성 (혜령) --%>

<section class="common-section" id="#">
<div class="common-title">리뷰작성</div>
<br>
	<div class="common-container">
    	<div class="common-div">
        <form:form id="reviewFrm" action="${pageContext.request.contextPath}/review/reviewCreate.do"
        enctype="multipart/form-data" method="post">
            <table class="review-write-table">
                <tr>
                    <th>작성자</th>
                    <td class="review-create-writer">
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
            </table>
            <div class="review-create-btn">
                <button class="review-btn-rset" type="reset">초기화</button>
				    <input type="hidden" name="productDetailId" value="${productDetailId}" />
				    <input type="hidden" name="productId" value="${productId}" />
				    <input type="hidden" name="orderId" value="${orderId}" />
				<button class="review-btn-submit" onclick="submitFrm();" >작성하기</button>
            </div>
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
};

const submitFrm = () => {
	const frm = document.querySelector("#reviewFrm");
    const reviewStarRateInput = document.getElementById('reviewStarRate');
    const reviewTitleInput = document.getElementById('reviewTitle');
    const upFileInput = document.getElementById('upFile1');

    if (reviewStarRateInput.value === '') {
        event.preventDefault(); 
        alert('별점을 선택해주세요.');
        return; 
    }

    if (reviewTitleInput.value.trim() === '') {
        event.preventDefault();
        alert('제목을 입력해주세요.');
        return;
    }
    
    if (reviewTitleInput.value.trim().length > 25) {
        event.preventDefault();
        alert('제목은 25글자 이하여야 합니다.');
        return; // Stop form submission if validation fails
    }
    
    frm.submit();
};

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />