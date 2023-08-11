<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
    <style>
    .common-section{
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin:100px;
    }
	.common-container {
	width: 1000px;
	}
    .common-div {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
	}

    .common-title {
    font-size:24px;
    }
    </style>
    
    <section class="common-section" id="#" style="background-color:green;" >
        <div class="common-title">
            타이틀이 필요하다면 사용하고 필요 없다면 지우세요
        </div>
        <div class="common-container" style="background-color:magenta">
            <div class="common-div">
                <img src="${pageContext.request.contextPath}/resources/images/1690801774638.jpg" width=300px />
                <input type="text">
            </div>
        </div>
    </section>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>