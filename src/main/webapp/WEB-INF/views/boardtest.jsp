<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/haru/board/create" method="post">
		<input type="text" name="bcontent" placeholder="bcontent"><br>
		<input type="hidden" name="bopen" value="true">
		<input type="hidden" name="bcal" value="true">
		<input type="text" name="btoday"  placeholder="btoday"><br>
		<input type="submit">
	</form>
</body>
</html>