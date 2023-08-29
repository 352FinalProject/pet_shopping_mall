console.log('Hello stomp.js');

const ws = new SockJS(`http://${location.host}/pet/stomp`); // endpoint
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
    console.log('Connected:', frame);
	
	stompClient.subscribe('/pet/notice', (message) => {
		console.log('/pet/notice : ', message);
		renderMessage(message);
	});
	
    stompClient.subscribe(`/pet/notice/${memberId}`, (message) => {
    console.log('/pet/notice/${memberId} : ', message);
        renderMessage(message);
    });
});

const renderMessage = (message) => {
    const { id, notiCategory, notiContent, notiCreatedAt, memberId } = JSON.parse(message);
    // id, notiCategory, notiContent, notiCreatedAt, memberId 속성이 있는 개체로 변환
    const $notificationPopup = $("#notificationPopup"); // $notificationPopup은 전체 알림 팝업 요소
    const $popupContent = $notificationPopup.find(".popup-content"); // popupContent는 알림이 표시될 팝업 내의 콘텐츠 컨테이너

    const newNotification = document.createElement("p"); // 새로운 <p> 요소가 생성
    newNotification.className = "notification-content";
    newNotification.textContent = `알림${memberId}님 ${notiContent}.${notiCreatedAt}`;

    $popupContent.prepend(newNotification);

    $notificationPopup.addClass("active");

    console.log(newNotification.textContent);
};