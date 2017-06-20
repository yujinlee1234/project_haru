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
				<c:if test="${empty returnTo }">
					location.href = '${pageContext.request.contextPath }/';
				</c:if>
			});
		//swal("${result }", "", "${type}");
		//alert("${result }");		
	</c:if>
</script>
</body>
</html>