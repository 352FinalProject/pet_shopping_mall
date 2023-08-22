<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>

h2 {
    text-align: center;
 /*   font-size: 24px;  원하는 폰트 크기로 조정 */
    font-weight: bold;
    margin-bottom: 20px; /* 원하는 여백 크기로 조정 */
}
    /* 스타일 수정 */
    .pet-details, .pet-text-input {
        width: 50%;
        padding: 20px;
        border: 1px solid lightgray;
        margin: 10px;
    }
    
    .pet-info-table {
        width: 100%;
    }
    
    .pet-info-table th, .pet-info-table td {
        padding: 5px;
        border-bottom: 1px solid lightgray;
    }
    
    .pet-text-input textarea {
        width: 100%;
        height: 100px;
        resize: none;
        box-sizing: border-box;
    }
    
    /* 돌아가기&수정하기 버튼 */
    .resetAndSubmit {
        text-align: center;
    }
    
 /* 돌아가기 버튼 */
.return-button {
    background-color: #5886d3;
    margin-right: 10px;
    width: 120px;
    height: 40px;
    border-radius: 20px;
    color: white;
    border: 1px solid #e7e7e7;
    margin-top: 30px;
    cursor: pointer;
}

/* 수정하기 버튼 */
.update-button {
    background-color: #5886d3;
    width: 120px;
    height: 40px;
    border-radius: 20px;
    border: none;
    color: white;
    cursor: pointer;
}
</style>

<!-- 펫 상세 정보 페이지 내용 -->
<section class="common-section" id="pet-detail-section">
    <div class="common-title">펫 상세 정보</div>
    <div class="common-container">
        <div class="common-div">
            <div class="pet-details">
                      <h2>${petInfo.petName}의 정보입니다.</h2>
                    <table class="pet-info-table">
 					<tr>
                        <th>이름:</th>
                        <td>${petInfo.petName}</td>
                    </tr>
                    <tr>
                        <th>타입:</th>
                        <td>${petInfo.petKind}</td>
                    </tr>
                    <tr>
                        <th>품종:</th>
                        <td>${petInfo.petBreed}</td>
                    </tr>
                    <tr>
                        <th>몸무게:</th>
                        <td>${petInfo.petWeight}</td>
                    </tr>
                    <tr>
                        <th>나이: </th>
                        <td>${petInfo.petAge}</td>
                    </tr>
                    <tr>
                        <th>성별</th>
                        <td>${petInfo.petGender == 'M' ? '♂ ' : '♀ '}</td>
                    </tr>
                    <tr>
                        <th>등록일</th>
                        <td>${petInfo.petAdoptionDateFix}</td>
                    </tr>
                </table>
            </div>
       
            <div class="resetAndSubmit">
                <button type="button" class="return-button" onclick="location.href='${pageContext.request.contextPath}/pet/petList.do'">돌아가기</button>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

 <!--           <div class="pet-text-input">
                <h2>텍스트 입력</h2>
                <form action="/member/savePetText" method="post">
                    <textarea rows="5" cols="50" placeholder="텍스트를 입력하세요" name="petText"></textarea>
                    <input type="hidden" name="petId" value="${petInfo.petId}">
                    <input type="submit" value="저장">
                </form>
            </div> --> 