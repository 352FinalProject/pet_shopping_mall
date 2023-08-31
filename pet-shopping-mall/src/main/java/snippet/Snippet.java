package snippet;

public class Snippet {
	 document.getElementById("tel").addEventListener("input", function() {
	        const telInput = document.getElementById("tel");
	        const telPattern = /^010\d{8}$/;
	        if (telPattern.test(telInput.value)) {
	            telInput.style.borderColor = "blue";
	        } else {
	            telInput.style.borderColor = "red";
	        }
	    });
}

