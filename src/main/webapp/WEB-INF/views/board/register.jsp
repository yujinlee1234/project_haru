<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
	input[type='checkbox']{display: block;}
</style>
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">REGISTER PAGE</h3>
				</div>
				<div class="box-body">
					<form role="form" action="${pageContext.request.contextPath }/board/add" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label>Image File</label>
							<input type="file" name="imagefiles" class="form-control">
						</div>
						<div class="form-group">
							<label>오늘의 한 줄</label>
							<input type="text" placeholder="Enter Content" name="bcontent" class="form-control">
						</div>
						<div class="form-group">
							<label>당신의 오늘은?</label>
							<input type="text" placeholder="Enter Tag" name="btoday" class="form-control">
						</div>
						<div class="form-group">
							<label>공개</label>
							<input type="checkbox" name="open"><br>
							<input type="hidden" name="bopen">
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary">사진 추가</button>
							<button type="reset" class="btn btn-primary" id="btnBack">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
	$("#btnBack").click(function(){
		location.href="list";
	});
	$("form").on("submit", function(){
		var content = $("input[name='bcontent']").val();
		if(content == "" || content == undefined){
			Alert("오늘의 한 줄을 입력해 주세요.");
			return false;
		}
		
		if($("input[name='open']").prop("checked") == true){
			$("input[name='bopen']").val(true);
		}else{
			$("input[name='bopen']").val(false);
		}
	});
</script>
<%@ include file="../include/footer.jsp" %>

