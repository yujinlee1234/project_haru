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
					<h3 class="box-title">다이어리 등록</h3>
				</div>
				<div class="box-body">
					<form role="form" action="${pageContext.request.contextPath }/diary/add" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label>Image File</label>
							<input type="file" name="imagefiles" class="form-control">
						</div>
						<div class="form-group">
							<label>다이어리 제목</label>
							<input type="text" placeholder="Enter Content" name="dtitle" class="form-control">
						</div>
						<div class="form-group">
							<label>다이어리 공개</label>
							<input type="checkbox" name="open"><br>
							<input type="hidden" name="bopen">
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-primary">다이어리 등록</button>
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
		var content = $("input[name='dtitle']").val();
		if(content == "" || content == undefined){
			Alert("다이어리 이름을 입력해 주세요.");
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

