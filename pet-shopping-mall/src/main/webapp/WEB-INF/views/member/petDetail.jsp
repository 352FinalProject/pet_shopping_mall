<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

<style>
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
        width: 100%; /* 텍스트 입력란이 부모 컨테이너의 너비에 맞게 설정 */
        height: 100px; /* 원하는 높이로 설정 */
        resize: none; /* 크기 조절 불가능하도록 설정 */
        box-sizing: border-box; /* padding과 border를 포함한 크기 계산 */
    }
</style>

<!-- 펫 상세 정보 페이지 내용 -->
<section class="common-section" id="pet-detail-section">
    <div class="common-title">펫 상세 정보</div>
    <div class="common-container">
        <div class="common-div">
            <div class="pet-details">
                      <h2>펫 기본 정보</h2>
                    <table class="pet-info-table">
                        <tr>
                            <th>이름</th>
                            <td><input type="text" name="petName" value="${petInfo.petName}"></td>
                        </tr>
                        <tr>
                            <th>생년월일:</th>
                            <td><input type="date" name="petDofB" value="${petInfo.petDofB}"></td>
                        </tr>
                        <tr>
                            <th>타입:</th>
                            <td><input type="text" name="petKind" value="${petInfo.petKind}"></td>
                        </tr>
                        <tr>
                            <th>품종:</th>
                            <td><input type="text" name="petBreed" value="${petInfo.petBreed}"></td>
                        </tr>
                        <tr>
                            <th>성별</th>
                            <td>
                                <select name="petGender">
                                    <option value="M" ${petInfo.petGender == 'M' ? 'selected' : ''}>♂</option>
                                    <option value="F" ${petInfo.petGender == 'F' ? 'selected' : ''}>♀</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
            <div class="pet-text-input">
                <h2>텍스트 입력</h2>
                <form action="/member/savePetText" method="post">
                    <textarea rows="5" cols="50" placeholder="텍스트를 입력하세요" name="petText"></textarea>
                    <input type="hidden" name="petId" value="${petInfo.petId}">
                    <input type="submit" value="저장">
                </form>
            </div>
        </div>
    </div>
</section>

<section class="common-section" id="back-button-section">
    <div class="common-container">
        <div class="common-div">
            <form action="${pageContext.request.contextPath}/member/petList.do"
                class="form-inline">
                <button class="btn-add">돌아가기</button>
            </form>
            <a href="/member/updatePet.do?petId=${petInfo.petId}" class="edit-button">수정</a>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
