<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div id="chat">
  <div id="messages"></div>
  <input type="text" id="message">
  <button onclick="sendMessage()">Send</button>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<script>

const roomId = window.location.pathname.split('/').pop();

let socket = new SockJS('servicecenter/chat');
let stompClient = Stomp.over(socket);

stompClient.connect({}, function (frame) {
  // 특정 채팅방 구독
  stompClient.subscribe('/queue/' + roomId, function (message) {
    showMessage(JSON.parse(message.body).content);
  });
});

function sendMessage() {
  let message = document.getElementById('message').value;
  // 특정 채팅방으로 메시지 전송
  stompClient.send(`/app/chat/${roomId}/sendMessage`, {}, JSON.stringify({'content': message}));
}

function showMessage(message) {
  let messages = document.getElementById('messages');
  messages.innerHTML += "<div>" + message + "</div>";
}
</script>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />