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
    
    const newNotification = document.createElement("p");
    newNotification.className = "notification-content";
    newNotification.textContent = `${notiContent}\n${notiCreatedAt}`;

    const deleteButton = document.createElement("button");
    deleteButton.innerHTML = `X`;
    deleteButton.className = "notification-delete-button"; 
    deleteButton.id = id; 
   deleteButton.onclick = function() {
        notificationDelete(id); 
    };
   clearNotifications();
   
    newNotification.appendChild(deleteButton);

    newNotificationContainer.appendChild(newNotification);

    $popupContent.prepend(newNotificationContainer);

    $notificationPopup.addClass("active");
    
    const notificationBellImg = document.getElementById("notificationBell");
    notificationBellImg.setAttribute("src", "/pet/resources/images/home/notiBello.png"); 
    notificationBellImg.classList.add("pulse-button");
    
    
};
