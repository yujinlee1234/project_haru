<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	#pwCheck{
		color: red;
	}
</style>
<section class="content haru_section">
	<div class="row">
		<div class="col-md-6 col-md-offset-3">
			<div class="box">
				<div class="box-header text-center">
		            <h3>회원 가입</h3>
		            <hr class="star-primary">
		        </div>			
			</div>
			<div class="box">
				<form role="form" id="form1" action="${pageContext.request.contextPath }/member/join" method="post" enctype="multipart/form-data">					
					<div class="form-group">
						<label>아이디</label>
						<div class="input-group">
							<input type="text" placeholder="Enter ID" name="uid" class="form-control" required="required">
							<span class="input-group-btn" style="width:10%;">
								<button type="button" class="btn btn-primary" id="chkID">중복 확인</button>
							</span>
						</div>
					</div>
					<div class="form-group">
						<label>비밀번호</label>
						<input type="password" placeholder="Enter Password" name="upass" class="form-control inputPw" required="required">
					</div>
					<div class="form-group">
						<label>비밀번호 확인</label>
						<input type="password" placeholder="Enter Password" class="form-control inputPw" id="upwChk">
						<span id="pwCheck"></span>
					</div>						
					<div class="form-group">
						<label>이름</label>
						<input type="text" placeholder="Enter Name" name="uname" class="form-control" required="required">
					</div>
					<div class="form-group">
						<label>이메일</label>
						<input type="text" placeholder="Enter Email" name="umail" class="form-control" required="required">
					</div>
					<div class="form-group">
						<label>이미지</label>
						<input type="file" name="imagefiles" class="form-control">
					</div>
					<div class="form-group text-center">
						<button type="submit" class="btn btn-primary">회원가입</button>
					</div>
				</form>
				
			</div>
		</div>
	</div>
</section>
<script>
	$("#chkID").click(function(){
		//중복확인 버튼 클릭
		var result = checkID();
		if(result != undefined){
			if(result == true){
				swal({
					  title: "가입 가능한 아이디입니다.",
					  text: "당신의 하루",
					  type: "success",
					  showCancelButton: false,
					  confirmButtonColor: "#DD6B55",
					  confirmButtonText: "확인",
					  cancelButtonText:"취소"
					},function(){
						$("input[name='upass']").focus();		
					});					
			}else{
				swal({
					  title: "이미 존재하는 아이디입니다.",
					  text: "당신의 하루",
					  type: "warning",
					  showCancelButton: false,
					  confirmButtonColor: "#DD6B55",
					  confirmButtonText: "확인",
					  cancelButtonText:"취소"
					},function(){
						$("input[name='uid']").val("");
						$("input[name='uid']").focus();		
					});	
			}
		}
	});	
	
	$("#form1").submit(function(){		
		//비밀번호 확인 input이 focus를 잃었을 때
		var oPW = $("input[name='upass']").val();
		var cPW = $("#upwChk").val();
		
		//case1. 비밀번호가 입력 안되어있을 때		
		if(cPW.length==0||cPW == null){
			$("#pwCheck").text("비밀번호를 입력해 주세요.");
			$("#upwChk").focus();
			return false;
		}else if(oPW != cPW){
			$("#pwCheck").text("비밀번호가 일치하지 않습니다.");
			$("#upwChk").focus();
			return false;
		}else if(checkID() != undefined && checkID() == false){
			swal({
				  title: "이미 존재하는 아이디입니다.",
				  text: "당신의 하루",
				  type: "warning",
				  showCancelButton: false,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "확인",
				  cancelButtonText:"취소"
				},function(){
					$("input[name='uid']").val("");
					$("input[name='uid']").focus();		
				});	
			return false;
		}	
	});
	
function checkID(){
	var result;
	var checkId = $("input[name='uid']").val();
	if(checkId.length>0){
		$.ajax({
			url:"check/"+checkId,
			type:"get",
			dataType:"text",
			async:false,
			success:function(data){
				console.log(data);
				if(data == "SUCCESS"){
					result = true;					
				}else{
					result = false;					
				}
			}
		});
	}else{
		swal({
			  title: "아이디를 입력해 주세요.",
			  text: "당신의 하루",
			  type: "warning",
			  showCancelButton: false,
			  confirmButtonColor: "#DD6B55",
			  confirmButtonText: "확인",
			  cancelButtonText:"취소"
			},function(){
				$("input[name='uid']").focus();		
			});	
	}
	
	return result;
}
</script>
<%@ include file="../include/footer2.jsp" %>