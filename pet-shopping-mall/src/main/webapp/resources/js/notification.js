
// 서버에서 날라온 notification 파싱
const renderNotification = (notification) => {
    const { id, notiCategory, notiContent, notiCreatedAt, memberId } = notification;
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

    deleteButtonContainer.appendChild(deleteButton); // 버튼을 div 안에 추가

    newNotification.appendChild(notificationText);
    newNotification.appendChild(deleteButtonContainer); // 변경: div로 감싼 버튼을 추가

    newNotificationContainer.appendChild(newNotification);

    $popupContent.prepend(newNotificationContainer);

    $notificationPopup.addClass("active");
};



// 알림없을때 메서드
const emptyNotification = () => {
    const $notificationPopup = $("#notificationPopup");
    const $popupContent = $notificationPopup.find(".notiPopup-content");

    const newNotificationContainer = document.createElement("div");
    newNotificationContainer.className = "notification-container";
    newNotificationContainer.id = 'empty';
    
    const newNotification = document.createElement("p");
    newNotification.className = "notification-content";
    newNotification.textContent = '조회된 알림이 없습니다.';

    newNotificationContainer.appendChild(newNotification);

    $popupContent.prepend(newNotificationContainer);

    $notificationPopup.addClass("active");
};

// 알림 초기화 메서드
function clearNotifications() {
    const $popupContent = $("#notificationPopup .notiPopup-content");
    $popupContent.empty();
    const notificationBellImg = document.getElementById("notificationBell");
    notificationBellImg.setAttribute("src", "/pet/resources/images/home/notiBellx.png");
    notificationBellImg.classList.remove("pulse-button");
}

// 팝업창 열고 알림생성 
function loadNotifications(memberId) {
    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
    const notificationPopup = document.getElementById("notificationPopup");
    
    if (notificationPopup.classList.contains("active")) {
        notificationPopup.classList.remove("active");
        const notificationBellImg = document.getElementById("notificationBell");
    	notificationBellImg.setAttribute("src", "/pet/resources/images/home/notiBellx.png");
    	notificationBellImg.classList.remove("pulse-button");
    } else {
        notificationPopup.classList.add("active");
        $.ajax({
            method: "GET",
            url: "/pet/notification/findAllNotification.do",
            data: {
                "memberId": memberId
            },
            beforeSend: function (xhr) {
                   xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function (notifications) {
                clearNotifications();
                if (notifications && notifications.length > 0) {
                    notifications.forEach(notification => {
                        renderNotification(notification);
                    });
                } else {
                    emptyNotification();
                }
            },
            error: function (xhr, textStatus, errorThrown) {
                console.log('Error:', textStatus);
            }
        });
    }
}

  /* 알림삭제 */
  function notificationDelete(notificationId) {
    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
    $.ajax({
        method: "POST",
        url: "/pet/notification/deleteNotification.do",
        data: {
            id: notificationId
        },
        beforeSend: function (xhr) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
        },
        success: function (result) {
            const containerDiv = document.getElementById(notificationId);
            containerDiv.remove();
        },
        error: function (xhr, textStatus, errorThrown) {
            console.log('Error:', textStatus);
        }
    });
}