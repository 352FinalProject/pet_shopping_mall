<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=996ecdd9f48b29fc6a4f2ee5c20e6d3c&libraries=services"></script>

<style>
.reservation-btn {
	width: 100px;
	height: 30px;
	border-radius: 5px;
	border: none;
	font-size: 15px;
	color: #fff;
	background: #58ACFA;
	cursor: pointer;
	margin-top: 5px;
}

#keyword {
  width: 80px;
}

.hospital-search-btn {
	width: 60px;
	height: 20px;
	border: none;
	font-size: 10px;
	color: #fff;
	background: #c8c8c8;
	cursor: pointer;
}

#searchForm {
  display: flex; /* Flexbox 사용 */
  align-items: center; /* 수직 중앙 정렬 */
  justify-content: center; /* 수평 중앙 정렬 */
  flex-wrap: nowrap; /* 줄 바꿈 방지 */
  height: 35px;
}

#searchForm input[type="text"],
#searchForm button {
  margin: 0; /* 마진 초기화 */
}


</style>

<section class="common-section" id="common-section-List" style="padding-bottom: 350px;" >
<div class="common-title">내 주변 동물병원</div>
<div class="map_wrap">
    <div id="map" style="width:70%;height:100%;position:relative;overflow:hidden; margin: 0 auto;"></div>
    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form id="searchForm" onsubmit="searchPlaces(); return false;">
                    키워드 : &nbsp;<input type="text" value="동물병원" id="keyword"> 
                    <button class="hospital-search-btn" type="submit">검색하기</button> 
                </form>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>
<br><br><br>

<div>
<div class="places-info" >
    <div class="place-image">
        <img src="${pageContext.request.contextPath}/resources/images/hospital/hospitalBanner.png" style="height:800px; width:250px;">
    </div>
    <div class="place-details">
    	<ul id="placesResultList"></ul>
        <form action="${pageContext.request.contextPath}/petcare/reservation.do" method="GET">
		</form>
    </div>
</div>  
</div>


<script>
const getCurrentCoordinate = async () => {
	  console.log("getCurrentCoordinate 함수 실행!!!");
	  return new Promise((res, rej) => {
	    // HTML5의 geolocaiton으로 사용할 수 있는지 확인합니다.
	    if (navigator.geolocation) {
	      // GeoLocation을 이용해서 접속 위치를 얻어옵니다.
	      navigator.geolocation.getCurrentPosition(function (position) {
	        console.log(position);
	        const lat = position.coords.latitude; // 위도
	        const lon = position.coords.longitude; // 경도

	        const coordinate = new kakao.maps.LatLng(lat, lon);
	        res(coordinate);
	      });
	    } else {
	      rej(new Error("현재 위치를 불러올 수 없습니다."));
	    }
	  });
	};

// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
async function searchPlaces() {

    var keyword = document.getElementById('keyword').value;
    const currentCoordinate = await getCurrentCoordinate();
    console.log(currentCoordinate);
    var options = {
      location: currentCoordinate,
      radius: 10000,
      sort: kakao.maps.services.SortBy.DISTANCE,
      size: 10
    };

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch(keyword, placesSearchCB, options); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
         displayPlaces(data);
        console.log(data);
        displayPlacesResult(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

function displayPlacesResult(data) {
    var placesResultList = document.getElementById('placesResultList');
    placesResultList.innerHTML = ''; // 기존 목록 초기화
    
    for (var i = 0; i < data.length; i++) {
        var place = data[i];
        
        var listItem = document.createElement('li');
        listItem.className = 'place-item';
        
        var placeLink = document.createElement('a');
        placeLink.href = place.place_url;
        placeLink.target = '_blank'; // 링크를 새 탭에서 열기
        placeLink.textContent = place.place_name;
        placeLink.style.color = '#58ACFA'; 
        placeLink.style.fontSize = '18px'; 
        placeLink.style.fontWeight = 'bold'; 
        
        var placeAddress = document.createElement('p');
        placeAddress.textContent = place.road_address_name;
        
        var placePhone = document.createElement('p');
        if (place.phone) {
            placePhone.innerHTML = '📞' + place.phone;
        } else {
            placePhone.textContent = '전화번호가 존재하지 않습니다.';
        } 
        
        var Rbutton = document.createElement('button'); 
        Rbutton.className = 'reservation-btn'; 
        Rbutton.type = 'button'; 
        Rbutton.textContent = '예약하기'; 
        
        var form = document.createElement('form');
        form.action = '${pageContext.request.contextPath}/petcare/reservation.do'; // 이동할 URL
        form.method = 'GET'; 
        form.appendChild(Rbutton);
        
        Rbutton.onclick = function () {
        	form.submit();
        };
        
        listItem.appendChild(placeLink);
        listItem.appendChild(placeAddress);
        listItem.appendChild(placePhone);
        listItem.appendChild(Rbutton);
        
        listItem.appendChild(form);
        placesResultList.appendChild(listItem);
    }
}

var data = [
	  {
	    place_name: 'listItem',
	    place_url: 'placeLink',
	    road_address_name: 'placeAddress',
	    phone: 'placePhone'
	  }
	];

// 검색결과 목록을 생성하고 표시하는 함수 호출
displayPlacesResult(data); // data는 검색 결과 데이터를 의미하는 배열
console.log(data);




// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
    
}

    
 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
 
// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new kakao.maps.MapTypeControl();

// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
</script>

</section>






<jsp:include page="/WEB-INF/views/common/footer.jsp" />