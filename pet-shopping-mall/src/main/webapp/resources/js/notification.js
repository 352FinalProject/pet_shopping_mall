const renderNotification = (notification) => {
    const { id, notiCategory, notiContent, notiCreatedAt, memberId } = notification;

    const $notificationPopup = $("#notificationPopup");
    const $popupContent = $notificationPopup.find(".popup-content");

    const newNotificationContainer = document.createElement("div");
    newNotificationContainer.className = "notification-container";
    
    const newNotification = document.createElement("p");
    newNotification.className = "notification-content";
    newNotification.textContent = `${memberId}님 ${notiContent}${notiCreatedAt}`;

    const deleteButton = document.createElement("button");
    deleteButton.innerHTML = `X`;
    deleteButton.className = "notification-delete-button";
    deleteButton.id = id;
	deleteButton.onclick = function() {
        notificationDelete(id); 
    };

    newNotification.appendChild(deleteButton);

    newNotificationContainer.appendChild(newNotification);

    $popupContent.prepend(newNotificationContainer);

    $notificationPopup.addClass("active");

    console.log(newNotification.textContent);
};

function clearNotifications() {
    const $popupContent = $("#notificationPopup .popup-content");
    $popupContent.empty();
}

/* 팝업창 열고 알림생성 */
function loadNotifications(memberId) {
    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
    const notificationPopup = document.getElementById("notificationPopup");
    
    if (notificationPopup.classList.contains("active")) {
        notificationPopup.classList.remove("active");
        clearNotifications();
    } else {
        notificationPopup.classList.add("active");
        $.ajax({
            method: "GET",
            url: "notification/findAllNotification.do",
            data: {
                "memberId": memberId
            },
            beforeSend: function (xhr) {
                   xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function (notifications) {
                clearNotifications();
                notifications.forEach(notification => {
                    renderNotification(notification);
                });
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
    	 async:true,
         method: "POST",
		 url: "notification/deleteNotification.do",
         data: {
               "id":notificationId
         },
         beforeSend: function (xhr) {
               xhr.setRequestHeader(csrfHeader, csrfToken);
         },
         success: function(result) {
			const containerDiv = document.getElementById(`notification${notificationId}`);
	         if (containerDiv) {
	            containerDiv.remove();
	         }
         }, 
         error: function(xhr, textStatus, errorThrown) {
               console.log('Error:');
         }
      });
      
   };