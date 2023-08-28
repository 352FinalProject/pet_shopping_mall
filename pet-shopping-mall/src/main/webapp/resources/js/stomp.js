console.log('Hello stomp.js');

const ws = new SockJS(`http://${location.host}/pet/stomp`); // endpoint
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
	console.log('open : ', frame);
	
	// 구독신청 
	stompClient.subscribe('/app/notice', (message) => {
		console.log('/app/notice : ', message);
		renderMessage(message);
	});
	stompClient.subscribe(`/app/notice/${memberId}`, (message) => {
		console.log(`/app/notice/${memberId} : `, message);
		renderMessage(message);
	});
	
});

const renderMessage = (message) => {
	const {id, notiCategory, notiContent, notiCreatedAt, memberId} = JSON.parse(message.body);
	console.log(id, notiCategory, notiContent, notiCreatedAt, memberId);
	
	const $noticeModal = $("#noticeModal");
	$noticeModal.find(".modal-title").html(`<span class='badge badge-primary from'>${to}</span>`);
	$noticeModal.find(".modal-body").html(content);
	$noticeModal.find(".modal-footer .from").html(from); 
	$noticeModal.modal();
}

