<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>관리자 페이지</title>

<link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>


</head>
<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<!-- Navbar Brand-->
		<a class="navbar-brand ps-3" href="${pageContext.request.contextPath}/">펫쇼핑몰</a>
		<!-- Sidebar Toggle-->
		<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!">
			<i class="fas fa-bars"></i>
		</button>
	</nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<a class="nav-link"	href="${pageContext.request.contextPath}/admin/admin.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 관리자 홈
						</a>
						<div class="sb-sidenav-menu-heading">회원목록</div>
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminMemberList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 전체 회원목록
						</a> <a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminSubscribeList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 구독 회원목록
						</a>
						<div class="sb-sidenav-menu-heading">상품</div>
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminProductList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 상품목록
						</a>
						<div class="sb-sidenav-menu-heading">주문</div>
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminOrderList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 주문목록
						</a>
						<div class="sb-sidenav-menu-heading">매출</div>
						<a class="nav-link"
							href="${pageContext.request.contextPath}/admin/adminStatisticsProduct.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-chart-area"></i>
							</div> 상품별 매출
						</a> <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
							data-bs-target="#collapsePages" aria-expanded="false"
							aria-controls="collapsePages">
							<div class="sb-nav-link-icon">
								<i class="fas fa-chart-area"></i>
							</div> 날짜별 매출
							<div class="sb-sidenav-collapse-arrow">
								<i class="fas fa-angle-down"></i>
							</div>
						</a>
						<div class="collapse" id="collapsePages"
							aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
							<nav class="sb-sidenav-menu-nested nav accordion"
								id="sidenavAccordionPages">
								<a class="nav-link collapsed"
									href="${pageContext.request.contextPath}/admin/adminStatisticsMonthly.do"
									data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth"
									aria-expanded="false" aria-controls="pagesCollapseAuth"> 월별
									매출
									<div class="sb-sidenav-collapse-arrow"></div>
								</a> 
								<a class="nav-link collapsed"
									href="${pageContext.request.contextPath}/admin/adminStatisticsDaily.do"
									data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth"
									aria-expanded="false" aria-controls="pagesCollapseAuth"> 일별
									매출
									<div class="sb-sidenav-collapse-arrow"></div>
								</a>
							</nav>
						</div>
						<div class="sb-sidenav-menu-heading">문의관련</div>
						<a class="nav-link" href="${pageContext.request.contextPath}/admin/adminQuestionList.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div> 문의 관리
						</a>
					</div>
				</div>
			</nav>
		</div>

</div><!-- layoutSidenav -->
<main>
<div class="container-fluid px-4">
<h1 class="mt-4">상품 등록</h1>
<div class="card mb-4">
<div class="productInfo-container justify-content-around">
	
	<!-- 상품기본 정보 -->
	<div class="product-container ">
		<!-- 상품카테고리 정보 -->
		<div class="product-category-info">
			<div class="row mb-3">
				<div class="col">
				  <label for="categoryId" class="col-sm-6">상품 카테고리</label>
				</div>
				  <div class="col">
		              <select name="categoryId" id="categoryId" class="form-select form-control ">
		              <option value="-선택-">-선택-</option>
		              <c:if test="${empty categories}">
		                <option value="1">카테고리가 없습니다. 카테고리를 추가해주세요</option>
		              </c:if>
		              <c:if test="${not empty categories}">
		                <c:forEach items="${categories}" var="category" varStatus="vs">
		                  <option value="${category.categoryId}" >${category.categoryName}</option>
		                </c:forEach>
		              </c:if>
		            </select>
				  </div>
			</div>
		</div>
		<!-- 상품이름 정보 -->
		<div class="product-name-info">
			<div class="row mb-3">
		      	<div class="col">
		            <label for="productName" class="form-label">제품 이름</label>
		      	</div>
		      	<div class="col">
		            <input type="text" name="productName" id="productName" class="form-control" placeholder="상품명 예시) 사이즈" required>
		      	</div>
	    	</div> 
		</div>
		
		<!-- 가격 정보 -->
		<div class="product-price-info">
			<div class="row mb-3">
				<div class="col">
		            <label for="productPrice" class="form-label">상품금액</label>		
				</div>
				<div class="col">
		            <input type="number" name="productPrice" id="productPrice" class="form-control" placeholder="상품값 예시) S" required>
				</div>
			</div>
		</div>
		<!-- 상품사진 -->
		<div class="product-attachment-info">
			<div class="row mb-3">
		      	<div class="col">
		            <label for="file" class="form-label">제품 사진</label>
		      	</div>
		      	<div class="col">
		            <input type="file" name="upFile" id="file" class="form-control">
		      	</div>
	    	</div> 
		</div>
	</div>
	
	<!-- 상품옵션 정보 -->
    <div class="productDetail-container-${productDetail.productDetailId}">
        <div class="row mb-3">
            <div class="col">
                <label for="optionName_${productDetail.productDetailId}" class="form-label">옵션명</label>
            </div>
            <div class="col">
                <input type="text" name="optionName" id="optionName_${productDetail.productDetailId}" class="form-control" value="${productDetail.optionName}">
            </div>
        </div>
        <div class="row mb-3">
            <div class="col">
                <label for="optionValue_${productDetail.productDetailId}" class="form-label">옵션값</label>
            </div>
            <div class="col">
                <input type="text" name="optionValue" id="optionValue_${productDetail.productDetailId}" class="form-control" value="${productDetail.optionValue}">
            </div>
        </div>
        <div class="row mb-3">
            <div class="col">
                <label for="additionalPrice_${productDetail.productDetailId}" class="form-label">옵션추가금</label>
            </div>
            <div class="col">
                <input type="number" name="additionalPrice" id="additionalPrice_${productDetail.productDetailId}" class="form-control" value="0">
            </div>
        </div>
        <div class="row mb-3">
            <div class="col">
                <label for="saleState_${productDetail.productDetailId}" class="form-label">판매상태</label>
            </div>
            <div class="col">
                <select name="saleState" id="saleState_${productDetail.productDetailId}" class="form-select">
                    <option value="0">판매대기</option>
                    <option value="1">판매중</option>
                    <option value="2">품절</option>
                    <option value="3">기타</option>
                </select>
            </div>
        </div>
    </div> 	
     <div class="d-flex justify-content-end">
       <button class="btn btn-secondary me-2" type="reset">초기화</button>
     </div>
	
</div><!-- productInfo-container -->
</div>
</div>
</main>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
//ajax 요청시 사용할 csrf 글로벌 변수설정
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(function() {
    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
});

//상품 업데이트 함수
const updateProduct = () => {
    const productId = '${product.productId}'; // 상품 ID
    const productName = document.getElementById('productName').value; // 상품명 입력란의 값
    const productPrice = document.getElementById('productPrice').value; // 상품금액 입력란의 값
    const categoryId = document.getElementById('categoryId').value; // 카테고리 선택값

    const requestData = {
        productId: productId,
        categoryId: '${product.categoryId}',
        productName: productName,
        productPrice: productPrice,
        categoryId: categoryId,
        imgageId : '${product.imageId}'
        // 여기에 다른 필드들도 추가하면 됩니다.
    };
	console.log(requestData);
    // Ajax 요청
    $.ajax({
        url: '${pageContext.request.contextPath}/admin/adminProductUpdate.do',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(requestData),
        success: function(response) {
          alert('상품이 성공적으로 업데이트되었습니다.');
        }
    });
};

// 상품 삭제 
const deleteProduct = (productId) => {
    if (confirm('정말로 이 상품을 삭제하시겠습니까?')) {
        const requestData = {
            productId: productId // Remove unnecessary backticks and curly braces
        };
		console.log(requestData);
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/adminProductDelete.do',
            type: 'POST',
            dataType: 'json',
            data: JSON.stringify(requestData),
            contentType: 'application/json',
            success: function(response) {
                alert('삭제 성공했습니다');
                window.location.href = '${pageContext.request.contextPath}/admin/adminProductList.do';
            },
            error: function(xhr, textStatus, errorThrown) {
                // Handle error if needed
                alert('삭제 실패했습니다');
            }
        });
    }
};



//상품 옵션 업데이트 함수
const updateProductOption = (productDetailId) => {
	console.log(productDetailId);
    const optionName = document.getElementById(`optionName_\${productDetailId}`).value;
    const optionValue = document.getElementById(`optionValue_\${productDetailId}`).value;
    const additionalPrice = document.getElementById(`additionalPrice_\${productDetailId}`).value;
    const saleState = document.getElementById(`saleState_\${productDetailId}`).value;

    const requestData = {
        productDetailId: productDetailId,
        optionName: optionName,
        optionValue: optionValue,
        additionalPrice: additionalPrice,
        saleState: saleState
        // 여기에 다른 필드들도 추가하면 됩니다.
    };
	console.log(requestData);
    
    // Ajax 요청
    $.ajax({
        url: '${pageContext.request.contextPath}/admin/adminProductDetailUpdate.do?id=' + productDetailId,
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(requestData),
        success: function(response) {
            if (response.code === 200) {
                alert('상품 옵션이 성공적으로 업데이트되었습니다.');
                // 업데이트된 내용을 화면에 반영하거나 다른 작업을 수행할 수 있습니다.
            } else {
                alert('상품 옵션 업데이트 실패! 관리자에게 문의하세요.');
            }
        },
        error: function() {
            alert('상품 옵션 업데이트 요청 실패! 서버 오류가 발생했습니다.');
        }
    });
};
// 상품옵션 삭제 요청
const deleteProductOption = (productDetailId) => {
    const requestData = {
            productDetailId: `\${productDetailId}`
        };
	console.log(requestData);
	if (confirm('정말로 이 옵션을 삭제하시겠습니까?')) {
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/adminProductOptionDelete.do',
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(requestData),
            success: function(response) {
                if (response.code === 200) {
                    alert('옵션이 성공적으로 삭제되었습니다.');
                } else {
                    alert('옵션 삭제 실패! 관리자에게 문의하세요.');
                }
            }
        });
    }
};

// 파일업로드
document.querySelectorAll("[name=upFile]").forEach((input) => {
	input.onchange = (e) => {
		const label = e.target.previousElementSibling;
		const files = e.target.files;
		if(files[0]) {
			label.innerHTML = files[0].name;
		}
		else {
			label.innerHTML = "파일을 선택하세요";
		}
	}
});
</script>

			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; 김대원김대원김대원입니다?</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
	</div>
	<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
	<script	src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/datatables-simple-demo.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
	
</body>
</html>