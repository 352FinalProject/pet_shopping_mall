<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#scrollToTop {
    position: fixed; 
    bottom: 20px; 
    right: 20px; 
    z-index: 1000; 
    cursor: pointer; 
    display: none; 
    width:50px;
}
</style>
<div>
	<img id="scrollToTop" src="${pageContext.request.contextPath}/resources/images/home/up-arrow.png" onclick="scrollToTop();"/>
</div>
<script>
const scrollToTop = () => {
	window.scrollTo({
		top: 0,
		behavior: 'smooth'
	});
};

window.addEventListener('scroll', () => {
	const scrollToTopButton = document.getElementById('scrollToTop');
	if (window.scrollY > 100) {
		scrollToTopButton.style.display = 'block';
	} else {
		scrollToTopButton.style.display = 'none';
	}
});

const button = document.getElementById('scrollToTop');
button.addEventListener('click', scrollToTop);
</script>