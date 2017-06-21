<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp" %>
<style>
	input[type='checkbox']{display: block;}
	input[type='file']{clear: both;}
	button#btnPicDel{font-weight: bold; }
	
</style>
<section class="content haru_section">
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<div class="box">
				<div class="box-header text-center">
					<h3>일기 등록</h3>
					<hr class="star-primary">
				</div>
				<div class="box-body">
					<form role="form" id="addForm" method="post" enctype="multipart/form-data">
						<input type="hidden" name="bno" value=${board.bno }>
						<input type="hidden" name="diaryNo" value=${board.dno.dno }>
						<div class="form-group">
							<label>오늘은?</label>
							<input type="date" name="date" value=${board.bdateForm } class="form-control" required="required" disabled="disabled">
						</div>
						<div class="form-group">
							<label>오늘의 이미지</label><br>
							<c:if test="${!empty board.bpic }">								
									<p id="ori_pic">
										<input type="hidden" name="bpic" value="${board.bpic }">
										<img alt="" src="${pageContext.request.contextPath }/display?filename=${board.bpic}" style="width:80px;">
										<small>${board.getOriginalFilename() }</small>
										<button id="btnPicDel" type="button" class="btn btn-flat" title="이미지 삭제">X</button>
									</p>
								
							</c:if>
							<c:if test="${empty board.bpic }">
								<p><small>등록된 이미지가 없습니다.</small></p>
							</c:if>
							<input type="file" name="imagefiles" class="form-control">
						</div>
						<div class="form-group">
							<label>오늘의 한 줄</label>
							<textarea name="bcontent" class="form-control" required="required">${board.bcontent }</textarea>
						</div>
						<div class="form-group">
							<label>당신의 오늘은?</label>
							<input type="text" placeholder="Enter Tag" name="btoday" class="form-control" value="${board.btoday }">
						</div>
						<div class="form-group text-right">
							<label>공개</label>
							<input type="checkbox" name="openSwitch" data-on-color="success" data-on-text="&nbsp;" data-off-text="&nbsp;" class="openSwitch">
							<input type="hidden" name="bopen">
						</div>
						<div class="form-group text-center">
							<button type="button" class="btn btn-primary" id="btnAdd">일기 수정</button>
							<button type="reset" class="btn btn-warning" id="btnBack">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<script>


	$(function(){		
		$(".openSwitch").bootstrapSwitch("state",${board.bopen});
		
		$("#btnBack").click(function(){
			location.href="${pageContext.request.contextPath }/board/list.do";
		});
		
		$("#btnAdd").click(function(){
			var content = $("input[name='bcontent']").val();
			if(content == "" || content == undefined){
				alert("오늘의 한 줄을 입력해 주세요.");
				return false;
			}
			
			if($("input[name='openSwitch']").prop("checked") == true){
				$("input[name='bopen']").val(true);
			}else{
				$("input[name='bopen']").val(false);
			}
			$("#addForm").attr("action", "${pageContext.request.contextPath }/board/mod");
			$("#addForm").submit();
		});
		
		$("#btnPicDel").click(function(){
			swal({
				  title: "기존의 이미지를 삭제하시겠습니까?",
				  text: "당신의 하루",
				  type: "info",
				  showCancelButton: true,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "확인",
				  cancelButtonText:"취소",
				  closeOnConfirm:false
				},
				function(){
					swal({
						  title: "이미지를 삭제하였습니다.",
						  text: "당신의 하루",
						  type: "success",
						  showCancelButton: false,
						  confirmButtonColor: "#DD6B55",
						  confirmButtonText: "확인",
						  cancelButtonText:"취소"
						},
						function(){
							$("#ori_pic").css("display","none");
							$("input[name='bpic']").val("");
						});
				});
		});
		
	});//ready

</script>
<%@ include file="../include/footer2.jsp" %>

