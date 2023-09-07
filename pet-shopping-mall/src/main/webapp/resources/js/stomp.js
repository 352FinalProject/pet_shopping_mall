console.log('Hello stomp.js');

const ws = new SockJS(`http://${location.host}/pet/stomp`); // endpoint
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
    console.log('Connected:', frame);

    stompClient.subscribe(`/pet/notice/${memberId}`, (message) => {
        console.log(`/pet/notice/${memberId} : `, message.body);
        renderMessage(message.body);
    });
});

const renderMessage = (message) => {
    const { id, notiCategory, notiContent, notiCreatedAt, memberId } = JSON.parse(message);
    const $notificationPopup = $("#notificationPopup");
    const $popupContent = $notificationPopup.find(".notiPopup-content");

    const newNotificationContainer = document.createElement("div");
    newNotificationContainer.className = "notification-container";
    newNotificationContainer.id = id;
    
    const newNotification = document.createElement("div");
    newNotification.className = "notification-content";

    const notificationText = document.createElement("p");
    notificationText.innerHTML = `${notiContent}<br>${notiCreatedAt}`;

    const deleteButtonContainer = document.createElement("div"); // 추가: 버튼을 감싸는 div
    deleteButtonContainer.className = "delete-button-container"; // 스타일을 위한 클래스

    const deleteButton = document.createElement("button");
    deleteButton.innerHTML = `X`;
    deleteButton.className = "notification-delete-button";
    deleteButton.id = id;
    deleteButton.onclick = function() {
        notificationDelete(id); 
    };
    clearNotifications();
   
    deleteButtonContainer.appendChild(deleteButton); // 버튼을 div 안에 추가

    newNotification.appendChild(notificationText);
    newNotification.appendChild(deleteButtonContainer); // 변경: div로 감싼 버튼을 추가

    newNotificationContainer.appendChild(newNotification);

    $popupContent.prepend(newNotificationContainer);

    $notificationPopup.addClass("active");
    
    const notificationBellImg = document.getElementById("notificationBell");
    notificationBellImg.setAttribute("src", "/pet/resources/images/home/notiBello.png"); 
    notificationBellImg.classList.add("pulse-button");
    
};
