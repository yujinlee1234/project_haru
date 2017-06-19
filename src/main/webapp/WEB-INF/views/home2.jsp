<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ include file="include/header2.jsp" %>
<script>
	<c:if test="${!empty result }">
		swal({
			  title: "${result}",
			  text: "당신의 하루",
			  type: "${type}",
			  showCancelButton: false,
			  confirmButtonColor: "#DD6B55",
			  confirmButtonText: "확인"
			},
			function(){
				<c:if test="${!empty returnTo }">
					location.href = '${pageContext.request.contextPath }/${returnTo }';
				</c:if>
			});
		//swal("${result }", "", "${type}");
		//alert("${result }");		
	</c:if>
</script>
<div style="background-image: url('img/video-bg.jpg')"
	class="haru_main">
	<!-- video background-->
	<!-- replace URLs with your video content URL-->
	<video id="video-background" preload="auto" autoplay="true"
		loop="loop" muted="muted" volume="0">
		<!-- <source src="http://ondrejsvestka.cz/video/silver-lining-video.webm"
			type="video/webm"> -->
		<source src="${pageContext.request.contextPath }/resources/video/2017-06-19_Untitled.mp4"
			type="video/mp4">
	</video>
	<div class="overlay"></div>
	<div class="haru_container">
	</div>
</div>
</body>
</html>