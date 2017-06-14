<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header2.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
	<c:if test="${!empty result }">
		alert("${result }");
		<c:if test="${!empty returnTo }">
			location.href = '${pageContext.request.contextPath }/${returnTo }';
		</c:if>
	</c:if>
</script>
<section class="content haru_section">
	<div class="row">
		<div class="col-md-6 col-md-offset-3" >
			<div class="box">
				<div class="box-body">
					<%-- <c:if test="${!empty dList }">
						<c:forEach items="${dList }" var="diary">
							<div>
								<p><a href="${pageContext.request.contextPath }/board/list/${diary.dno }" >${diary.dtitle }</a></p>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${empty dList }">
						<c:forEach items="${dList }" var="diary">
							<p>다이어리가 없습니다.</p>
						</c:forEach>
					</c:if> --%>
				</div>
			</div>
		</div>
	</div>
</section>
</body>
</html>