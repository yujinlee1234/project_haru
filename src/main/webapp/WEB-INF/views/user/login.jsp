<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
  <!-- Content Header (Page header) -->
<section class="content-header">
  <h1>
    	당신의 하루
    	<small>Login</small>
  </h1>

</section>
<section class="content">
	<div class="row">
		<div class="col-md-6 col-md-offset-3" >
			<div class="box">
				<div class="box-body">
					<form role="form" action="${pageContext.request.contextPath }/member/login" method="post">
						<div class="form-group">
							<label>아이디</label>
							<input type="text" placeholder="Enter ID" name="uid" class="form-control">
						</div>
						<div class="form-group">
							<label>비밀번호</label>
							<input type="password" placeholder="Enter Password" name="upass" class="form-control inputPw">
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary">로그인</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file="../include/footer.jsp" %>