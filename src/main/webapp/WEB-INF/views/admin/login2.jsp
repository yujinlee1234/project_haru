<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<section class="content haru_section">
	<div class="row">
		<div class="col-md-6 col-md-offset-3" >
			<div class="box">
				<div class="box-body">
					<fieldset>
						<legend>
							<h1>
						    	<small>Login</small>
							</h1>
						</legend>
						<form role="form" action="${pageContext.request.contextPath }/member/login" method="post">
							<div class="form-group">
								<label>아이디</label>
								<input type="text" placeholder="Enter ID" name="uid" class="form-control">
							</div>
							<div class="form-group">
								<label>비밀번호</label>
								<input type="password" placeholder="Enter Password" name="upass" class="form-control inputPw">
							</div>
							<div class="form-group text-center">
								<button type="submit" class="btn btn-primary">로그인</button>
							</div>
						</form>
						<a href="http://naver.com" target="_blank"></a>
					</fieldset>
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file="../include/footer2.jsp" %>