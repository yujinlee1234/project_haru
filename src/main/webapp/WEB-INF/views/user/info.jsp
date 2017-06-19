<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	table.user_table{width:100%; margin-top: 50px;}
	table.user_table th {padding:30px;}
	table.user_table td{padding:30px;}
	
	table.user_table th{width:20%; text-align: right;}
	table.user_table td img{width:100px; height:100px;}
	#upass,#pass2{display: none;}
	#uPassForm{display: inline;}
	#fileForm{display: inline;}
	input[name='umail']{display: none;}
	input[name='imagefiles'] ,input[name='uname']{display: none;}
	table.user_table td.btns span{display: none;}
	#btnExit{margin-top: 30px;}
	.btnICancel{display: none;}	
</style>
<section class="content haru_section">
	<div class="row">
		<div class="col-md-6 col-md-offset-3" >
			<div class="box">
				<div class="box-header text-center">
					<h3>회원 정보</h3>
					<hr class="star-primary">
				</div>
			</div>
			<div class="box">
				<div class="box-body">					
					<table style="width:100%;" class="user_table table">
						<tr>
							<td colspan="3" class="text-center">
								<c:if test="${! empty user.upic }">
									<img alt="" src="${pageContext.request.contextPath }/display?filename=${user.upic}"  class="img-circle">
								</c:if>
								<c:if test="${empty user.upic }">
									<img alt="" src="${pageContext.request.contextPath }/resources/img/user2.png"  class="img-circle">
								</c:if>
								<br>
								<br>
								<form role="form" method="post" enctype="multipart/form-data" id="fileForm">
									<input type="hidden" name="uid" value="${user.uid}">
									<c:if test="${! empty user.upic }">
										<input type="hidden" name="upic" value="${user.upic}">
									</c:if>
									<input type="file" name="imagefiles">
								</form>
								<button id="btnIChange" class="btn btn-danger btn-init">변경</button><span><button class="btnICancel btn">취소</button></span>
							</td>
						</tr>
						<tr>
							<th>아이디</th>
							<td colspan="2">${user.uid }${user.uadmin==true?"(관리자 계정입니다.)":"" }</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<form id="uPassForm" method="post">
									<input type="password" id="upass">									
									<input type="password" id="pass2">
								</form>		
								<button id="btnCheck" type="button" class="btn btn-success btn-init">비밀번호 변경</button>					
							</td>								
							<td class="text-right btns"><span id="pBtns"><button id="btnChange" class="btn btn-danger">변경</button><button class="btnCancel btn">취소</button></span></td>
						</tr>
						<tr>
							<th>이름</th>
							<td>
								<span id="ori_uname">${user.uname }</span>
								<form id="uNameForm" method="post">
									<input type="text" name="uname" required="required">									
								</form>	
							</td>
							<td class="text-right btns"><button id="btnNChange" class="btn btn-danger btn-init">변경</button><span><button class="btnCancel btn">취소</button></span></td>
						</tr>						
						<tr>
							<th>이메일</th>
							<td><span id="ori_umail">${user.umail }</span>
								<form id="uMailForm" method="post">
									<input type="text" name="umail">									
								</form>
							</td>
							<td class="text-right btns"><button id="btnMChange" class="btn btn-danger btn-init">변경</button><span><button class="btnCancel btn">취소</button></span></td>
						</tr>
						<c:if test="${!user.uadmin }">
							<tr>
								<td class="text-center" colspan="3"><button id="btnExit" class="btn btn-warning">회원 탈퇴</button></td>
							</tr>
						</c:if>						
					</table>
				</div>
			</div>
		</div>
		<c:if test="${!user.uadmin }">
			<div class="col-md-8 col-md-offset-2" >
				<div class="text-center ">
					<small>회원정보는 개인정보처리방침에 따라 안전하게 보호되며, 회원님의 명백한 동의 없이 공개 또는 제
							3자에게 제공되지않습니다. 개인정보처리방침</small>
				</div>
			</div>
		</c:if>
	</div>
</section>
<script>
	$(function(){
		$("#btnIChange").click(function(){
			console.log($("input[name='imagefiles']").css("display"));
			if($(".btnICancel").css("display") == "none"){
				$("input[name='imagefiles']").css("display","inline");
				$(".btnICancel").css("display","inline");
			}else if($("input[name='imagefiles']").css("display") == "inline"){
				console.log("====");
				$("form#fileForm").attr("action","${pageContext.request.contextPath}/member/mod");
				$("form#fileForm").submit();
			}
		});
		
		$(".btnICancel").click(function(){									
			$("input[name='imagefiles']").css("display","none");
			$(".btnICancel").css("display","none");
		
		});
		
		$("#btnCheck").click(function(){
			if($("#btnCheck").text()=="비밀번호 변경"){
				$("#upass").prop("placeholder"," 현재 비밀번호");
				$("#upass").css("display","inline");
				$("#pass2").css("display","none");
				$("#btnCheck").text("확인");
				$("#btnCheck").css("display","inline");
			}else if($("#btnCheck").text()=="확인"){
				var upass = $("#upass").val();
				
				$.ajax({
					url:"${pageContext.request.contextPath}/member/check",
					type:"post",
					data:{"upass":upass},
					success:function(data){
						
						console.log(data);
						
						if(data == "SUCCESS"){
							$("#upass").val("");
							$("#upass").prop("placeholder","변경할 비밀번호");
							$("#pass2").css("display","inline");
							$("#pass2").prop("placeholder","변경할 비밀번호 확인");
							$("#btnCheck").text("비밀번호 변경");
							$("#btnCheck").css("display", "none");
							$("#pBtns").css("display","inline");	
						}
					}
				});
			}
		});
		
		$("#btnChange").click(function(){
			var upass = $("#upass").val();
			var pass2 = $("#pass2").val();
			
			if(upass.trim() == pass2.trim()){
				$.ajax({
					url:"${pageContext.request.contextPath}/member/mod",
					type:"put",
					data:{"upass":upass},
					success:function(data){
						
						console.log(data);
						$("#upass").val("");
						$("#pass2").val("");
						$("#upass").css("display","none");
						$("#pass2").css("display","none");
						
						$("#btnCheck").text("비밀번호 변경");
						$("#btnCheck").css("display", "inline");
						$("#pBtns").css("display","none");	
						
						
						if(data == "SUCCESS"){
							swal({
								  title: "비밀번호가 변경되었습니다.",
								  text: "당신의 하루",
								  type: "success",
								  showCancelButton: false,
								  confirmButtonColor: "#DD6B55",
								  confirmButtonText: "확인"
								},
								function(){	
									location.href="${pageContext.request.contextPath}/member/logout.do";
								});
						}else{
							swal({
								  title: "비밀번호가 변경되지 못했습니다.",
								  text: "당신의 하루",
								  type: "error",
								  showCancelButton: false,
								  confirmButtonColor: "#DD6B55",
								  confirmButtonText: "확인"
								});
							
						}										
					}
				});
			}
		});
		
		$(".btnCancel").click(function(){
			$(this).parents("tr").find("td input").val("");			
			$(this).parents("tr").find("input").css("display", "none");
			$(this).parent().css("display", "none");
			$(this).parents("tr").find("td .btn-init").css("display", "inline");
			$("#ori_uname").css("display", "inline");
			$("#ori_umail").css("display", "inline");
		});
		
		$("#btnExit").click(function(){
			swal({
			  title: "회원탈퇴 시 저장된 일기와 정보가 모두 삭제 됩니다.",
			  text: "계속 진행하시겠습니까?",
			  type: "success",
			  showCancelButton: true,
			  confirmButtonColor: "#DD6B55",
			  confirmButtonText: "확인",
			  cancelButtonText:"취소"
			},
			function(){	
				location.href="${pageContext.request.contextPath}/member/exit";
			});
		});
		
		$("#btnNChange").click(function(){
			console.log( $("#ori_uname").css("display"));
			if($("#ori_uname").css("display")=="inline"){
				$("#ori_uname").css("display", "none");								
				$("input[name='uname']").css("display","inline");
				$("input[name='uname']").val($("#ori_uname").text());
				$(this).next().css("display","inline");	
			}else if($("#ori_uname").css("display")=="none"){
				var uname = $("input[name='uname']").val();
				if(uname.trim().length > 0){
					$.ajax({
						url:"${pageContext.request.contextPath}/member/mod",
						type:"put",
						data:{"uname":uname},
						success:function(data){												
							if(data == "SUCCESS"){
								swal({
									  title: "이름이 변경되었습니다.",
									  text: "당신의 하루",
									  type: "success",
									  showCancelButton: false,
									  confirmButtonColor: "#DD6B55",
									  confirmButtonText: "확인",
									  cancelButtonText:"취소"
									},
									function(){	
										location.href="${pageContext.request.contextPath}/member/info.do";
									});
								
							}else{
								swal({
									  title: "이름이 변경되지 못했습니다.",
									  text: "당신의 하루",
									  type: "error",
									  showCancelButton: false,
									  confirmButtonColor: "#DD6B55",
									  confirmButtonText: "확인",
									  cancelButtonText:"취소"
									});
								
							}										
						}
					});
				}
			}								
		});
		
		$("#btnMChange").click(function(){
			console.log( $("#ori_umail").css("display"));
			if($("#ori_umail").css("display")=="inline"){
				$("#ori_umail").css("display", "none");								
				$("input[name='umail']").css("display","inline");
				$("input[name='umail']").val($("#ori_umail").text());
				$(this).next().css("display","inline");	
			}else if($("#ori_umail").css("display")=="none"){
				var umail = $("input[name='umail']").val();
				if(umail.trim().length > 0){
					$.ajax({
						url:"${pageContext.request.contextPath}/member/mod",
						type:"put",
						data:{"umail":umail},
						success:function(data){												
							if(data == "SUCCESS"){
								swal({
									  title: "메일이 변경되었습니다.",
									  text: "당신의 하루",
									  type: "success",
									  showCancelButton: false,
									  confirmButtonColor: "#DD6B55",
									  confirmButtonText: "확인",
									  cancelButtonText:"취소"
									},function(){
										location.href="${pageContext.request.contextPath}/member/info.do";		
									});								
							}else{
								swal({
									  title: "메일이 변경되지 못했습니다.",
									  text: "당신의 하루",
									  type: "error",
									  showCancelButton: false,
									  confirmButtonColor: "#DD6B55",
									  confirmButtonText: "확인",
									  cancelButtonText:"취소"
									});							
							}										
						}
					});
				}
			}								
		});
	});
</script>
<%@ include file="../include/footer2.jsp" %>