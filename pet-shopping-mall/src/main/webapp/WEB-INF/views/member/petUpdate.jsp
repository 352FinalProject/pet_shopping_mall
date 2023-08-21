<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
        width: 100%;
        height: 100px;
        resize: none;
        box-sizing: border-box;
    }
    
    /* 성별 선택 버튼 스타일 */
    .selected {
        background-color: lightblue;
    }
</style>

<!-- 펫 수정 페이지 내용 -->
<section class="common-section" id="pet-update-section">
    <div class="common-title">펫 프로필 수정</div>
    <br>
    <div class="common-container">
        <div class="common-div">
            <form:form action="${pageContext.request.contextPath}/member/petUpdate.do" method="POST">
                <input type="hidden" name="petId" value="${petInfo.petId}">
                <table>
                    <tr>
                        <th>아이디</th>
                        <td>
                            <input type="text" name="memberId" id="memberId" value="${petInfo.memberId}" readonly="readonly">
                        </td>
                    </tr>
                    <tr>
                        <th>펫 이름</th>
                        <td>
                            <input type="text" name="petName" id="petName" value="${petInfo.petName}" required>
                        </td>
                    </tr>
                    <tr>
                        <th>생일</th>
                        <td>
                            <input type="date" name="petDofBFix" id="petDofBFix" value="${petInfo.petDofBFix}" required>
                        </td>
                    </tr>
                    <tr>
                        <th>타입</th>
                        <td>
                            <input type="text" name="petKind" value="${petInfo.petKind}">
                        </td>
                    </tr>
                    <tr>
                        <th>품종</th>
                        <td>
                            <input type="text" name="petBreed" value="${petInfo.petBreed}">
                        </td>
                    </tr>
                    <tr>
                        <th>입양일</th>
                        <td>
                            <input type="date" name="petAdoptionDateFix" value="${petInfo.petAdoptionDateFix}">
                        </td>
                    </tr>
                    <tr>
                        <th>성별</th>
                        <td>
                            <input type="hidden" name="petGender" id="genderInput" value="${petInfo.petGender}">
                            <input type="button" name="gender" value="M" onclick="selectGender('M')" ${petInfo.petGender == 'M' ? 'class="selected"' : ''}>
                            <input type="button" name="gender" value="F" onclick="selectGender('F')" ${petInfo.petGender == 'F' ? 'class="selected"' : ''}>
                        </td>
                    </tr>
                </table>
                <button type="submit" class="edit-button">수정</button>
            </form:form>
        </div>
    </div>
</section>

<script>
    function selectGender(gender) {
        document.getElementById("genderInput").value = gender;
        var buttons = document.getElementsByName("gender");
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].classList.remove("selected");
        }
        var selectedButton = document.querySelector(`input[name="gender"][value="${gender}"]`);
        selectedButton.classList.add("selected");
    }
</script>

<section class="common-section" id="back-button-section">
    <div class="common-container">
        <div class="common-div">
            <form action="${pageContext.request.contextPath}/member/petList.do" class="form-inline">
                <button class="btn-add">돌아가기</button>
            </form>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />