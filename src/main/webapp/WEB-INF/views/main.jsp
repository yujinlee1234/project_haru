<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${empty auth }">
		로그인이 필요합니다. <a href="/haru/member/login">로그인하기</a>
	</c:if>
	<c:if test="${!empty auth }">
		${auth.uid } 님 반갑습니다. <a href="/haru/member/logout">로그아웃하기</a><br>
		<c:if test="${!empty diary }">
			<a href="/haru/board">${diary }</a>보기
		</c:if>
	</c:if>
</body>
</html>