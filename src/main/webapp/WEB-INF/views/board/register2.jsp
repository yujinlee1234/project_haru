<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp" %>
<style>
	input[type='checkbox']{display: block;}
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
						<div class="form-group">
							<label>오늘은?</label>
							<input type="date" name="date" class="form-control" required="required">
							<p><small id="dateResult"></small></p>
						</div>
						<div class="form-group">
							<label>오늘의 이미지</label>
							<input type="file" name="imagefiles" class="form-control">
						</div>
						<div class="form-group">
							<label>오늘의 한 줄</label>
							<input type="text" placeholder="Enter Content" name="bcontent" class="form-control" required="required">
						</div>
						<div class="form-group">
							<label>당신의 오늘은?</label>
							<input type="text" placeholder="Enter Tag" name="btoday" class="form-control">
						</div>
						<div class="form-group text-right">
							<label>공개</label>
							<input type="checkbox" name="openSwitch" data-on-color="success" data-on-text="&nbsp;" data-off-text="&nbsp;" data-size="mini" class="openSwitch">
							<input type="hidden" name="bopen">
						</div>
						<div class="form-group text-center">
							<button type="button" class="btn btn-primary" id="btnAdd">일기 쓰기</button>
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
		var date = new Date();
		//임시 값 = 시작 값을 오늘로 지정 만약 달력으로 view 만들 시 선택된 날짜가 입력되도록
		$("input[name='date']").val("${date}");
		$("input[name='date']").attr("max",date.getFullYear()+"-"+((date.getMonth()+1)<10?"0"+(date.getMonth()+1):(date.getMonth()+1))+"-"+date.getDate());
		
		testDate();	
		
		$(".openSwitch").bootstrapSwitch("state",${diary.dopen});
		
		$("#btnBack").click(function(){
			location.href="list.do";
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
			$("#addForm").attr("action", "${pageContext.request.contextPath }/board/add");
			$("#addForm").submit();
		});
		
		$("input[name='date']").change(function(){
			testDate();			
		});
		$("input[name='date']").focus(function(){
			testDate();			
		});
		$("input[name='date']").focusout(function(){
			$("#dateResult").text("");
		});
	});//ready
		
	function testDate(){
		var date = $("input[name='date']").val();
		
		$.ajax({
			url:"${pageContext.request.contextPath }/board/checkDate/"+date,
			dataType:"text",
			type:"get",
			async:true,
			success:function(result){
				console.log(result);
				if(result == "success"){
					$("#dateResult").text("일기 작성이 가능한 날짜입니다.");
					$("#dateResult").css("color","green");
					$("#btnAdd").removeAttr("disabled");
					
				}else{
					if(result == "datefail"){
						$("#dateResult").text("날짜 형식이 알맞지 않습니다.");
						$("#dateResult").css("color","red");
					}else if(result == "fail"){
						$("#dateResult").text("이미 일기가 작성된 날짜입니다.");
						$("#dateResult").css("color","red");
					}
					$("#btnAdd").attr("disabled","disabled");
				}
			}
		});
	}
/* 	$("form").on("submit", function(){
		var content = $("input[name='bcontent']").val();
		if(content == "" || content == undefined){
			Alert("오늘의 한 줄을 입력해 주세요.");
			return false;
		}
		
		if($("input[name='openSwitch']").prop("checked") == true){
			$("input[name='bopen']").val(true);
		}else{
			$("input[name='bopen']").val(false);
		}
	}); */
</script>
<%@ include file="../include/footer2.jsp" %>

