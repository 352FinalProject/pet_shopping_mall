console.log('Hello stomp.js');

const ws = new SockJS(`http://${location.host}/pet/stomp`); // endpoint
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
	console.log('open : ', frame);
	
	stompClient.subscribe(`/app/notice/${memberId}`, (message) => {
		console.log(`/app/notice/${memberId} : `, message);
		renderMessage(message);
	});
	
});

const renderMessage = (message) => {
	const {id, from, notiCategory, notiContent, notiCreatedAt, memberId} = JSON.parse(message.body);
	console.log(id, from, notiCategory, notiContent, notiCreatedAt, memberId);
	
	const $noticeModal = $("#noticeModal");
	$noticeModal.find(".modal-title").html(`<span class='badge badge-primary from'>${to}</span>`);
	$noticeModal.find(".modal-body").html(content);
	$noticeModal.find(".modal-footer .from").html(from); 
	$noticeModal.modal();
}

