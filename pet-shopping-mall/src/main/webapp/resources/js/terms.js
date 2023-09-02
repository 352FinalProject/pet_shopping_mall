const checkbox = () => {
	const target = document.getElementById("disabled-button");
	const checkBox1 = document.getElementById("checkBox1");
	const checkBox2 = document.getElementById("checkBox2");
	const checkAll = document.getElementById("checkAll");

	if ((checkBox1.checked && checkBox2.checked) || checkAll.checked) {
		target.style.backgroundColor = '#5886d3';
		target.disabled = false;
	} else {
		target.style.backgroundColor = '#c8c8c8';
		target.disabled = true;
	}
};

const next = () => {
	const box1 = document.getElementById("checkBox1");
	const box2 = document.getElementById("checkBox2");
	
	if (box1.checked && box2.checked) {
		location.href = '/pet/member/memberCreate.do';
	} else {
		alert("필수항목 체크해주세요");
	}
};

const toggleCheckBox = () => {
    const checkAll = document.getElementById("checkAll");
    const boxes = document.getElementsByName("chk"); // 태그 객체 배열
    
    for (let i = 0; i < boxes.length; i++) {
        boxes[i].checked = checkAll.checked;
    }
    checkbox();
    sendData(); // 여기에 sendData()를 호출하여 전체 선택 변경 시에도 데이터가 전송
};

// 페이지가 로딩되면 체크박스 상태를 초기화
window.addEventListener('load', () => {
	checkbox();
});

//체크박스 상태 변경 이벤트 핸들러
const handleCheckboxChange = () => {

    const checkBox1 = document.getElementById("checkBox1");
    const checkBox2 = document.getElementById("checkBox2");
    const promotionEmailAccept = document.getElementById("promotionEmailAccept");

    // 동의 체크박스가 선택되었을 때만 버튼 활성화
    const disabledButton = document.getElementById("disabled-button");
    if (checkBox1.checked && checkBox2.checked) {
        disabledButton.removeAttribute("disabled");
    } else {
        disabledButton.setAttribute("disabled", "disabled");
    }
};

//각 체크박스 변경 이벤트에 핸들러 연결
document.getElementById("checkBox2").addEventListener("change", handleCheckboxChange);
document.getElementById("promotionEmailAccept").addEventListener("change", handleCheckboxChange);

//체크박스 동의 여부를 전송
const sendData = () => {

    const checkBox1 = document.getElementById("checkBox1").checked ? 'Y' : 'N';
    console.log(checkBox1);
    const checkBox2 = document.getElementById("checkBox2").checked ? 'Y' : 'N';
    console.log(checkBox2);
    const promotionEmailAccept = document.getElementById("promotionEmailAccept").checked ? 'Y' : 'N';
    console.log(promotionEmailAccept);
    
    const formData = new URLSearchParams();
    formData.append('termsAccept', checkBox1);
    formData.append('privacyAccept', checkBox2);
    formData.append('emailAccept', promotionEmailAccept);
	
    const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

    fetch('/pet/member/updateTerms.do', { 
        method: 'POST',
        headers: {
            [csrfHeader]: csrfToken
        },
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // 성공
        } else {
            // 실패
        }
    })
    .catch(error => console.error("Fetch Error:", error));
}