<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp" %>
<style>
	form{margin-top: 100px;}
	
</style>
<section class="content haru_section">
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<div class="box">
				<div class="box-header text-center">
					<h3>다이어리 등록</h3>
					<hr class="star-primary">
				</div>
				<div class="box-body">
					<form role="form" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label>다이어리 이미지</label>
							<input type="file" name="imagefiles" class="form-control">
						</div>
						<br>
						<div class="form-group">
							<label>다이어리 제목</label>
							<input type="text" placeholder="Enter Content" name="dtitle" class="form-control">
						</div>
						<br>
						<div class="form-group">
							<label>다이어리 공개</label>
							<div>
								<input type="checkbox" name="openSwitch" data-on-color="success" data-on-text="&nbsp;" data-off-text="&nbsp;" data-size="large" class="openSwitch">
								<input type="hidden" name="dopen">
							</div>
						</div>
						<br><br><br><br>
						<div class="form-group text-center">
							<button type="submit" class="btn btn-primary">다이어리 등록</button>
							<button type="reset" class="btn" id="btnBack">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
	$(function(){
		$(".openSwitch").bootstrapSwitch("state", true);
		$("#btnBack").click(function(){
			location.href="mylist.do";
		});
		$("form").on("submit", function(){
			var content = $("input[name='dtitle']").val();
			if(content == "" || content == undefined){
				Alert("다이어리 이름을 입력해 주세요.");
				return false;
			}
			
			var checked = $("input.openSwitch").prop("checked");	
			console.log(checked);
			$("input[name='dopen']").val(checked);
			
			
			
			$(this).attr("action","${pageContext.request.contextPath }/diary/add");
		});
		
		$(".openSwitch").click(function(){
			var checked = $("input[name='openSwitch']").prop("checked");	
			console.log("BOPEN : "+checked);
		});
		
		$(document).on('switchChange.bootstrapSwitch', 'input.openSwitch', function(event, state) {			
			$(this).parents(".openSwitchA").click();
			  console.log(this); // DOM element
			  console.log(event); // jQuery event
			  console.log(state); // true | false
		});	
	});
	
</script>
<%@ include file="../include/footer2.jsp" %>

