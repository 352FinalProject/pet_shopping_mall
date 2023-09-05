<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/popup.css" />

<meta charset="UTF-8">
</head>
<body>

<!-- layer popup content -->
<div class="layerPopup" id="layer_popup" style="visibility: visible;">
    <div class="layerBox">
        <h4 class="title">🌟우리집동물친구 공지사항🌟</h4>
        <div class="cont">
            <p>
				<img class="popup" src="${pageContext.request.contextPath}/resources/images/home/newservice_.gif" width=550 height=500 usemap="#popup" alt="공지사항">
            </p>
        </div>
          <form name="pop_form">
        <div id="check" ><input type="checkbox" name="chkbox" value="checkbox" id='chkbox' >
        	<label for="chkbox">&nbsp&nbsp오늘 하루동안 보지 않기</label></div>
		<div id="close" ><a href="javascript:closePop();">닫기</a></div>    
		</form>
	</div>
</div>

<script>

function setCookie( name, value, expiredays ) {
    var todayDate = new Date();
    todayDate.setDate( todayDate.getDate() + expiredays ); 
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}

function closePop() {
    if ( document.pop_form.chkbox.checked ){
        setCookie( "pet_popup", "done" , 1 );
    }
    document.all['layer_popup'].style.visibility = "hidden";
	}

cookiedata = document.cookie;   
	if ( cookiedata.indexOf("pet_popup=done") < 0 ){     
    	document.all['layer_popup'].style.visibility = "visible";
	} else {
	    document.all['layer_popup'].style.visibility = "hidden";
	}
	
</script>
</body>
</html>