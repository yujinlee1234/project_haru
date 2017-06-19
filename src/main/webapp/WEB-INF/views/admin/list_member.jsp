<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	div.pItem{width:200px; float: left; margin: 10px;}
	.pItem .pCheck{display: none; float: left;}
	.pItem p{text-align: right;padding-right: 22px;}
	.pItem img{width: 100px; height: 100px; margin: 0 auto !important;}
	.pItem portfolio-caption{text-align: center;}
	div#noItem figure{width: 100%; text-align: center;}
	#delBtn{display: none;}
	#cancelBtn{display: none;}	
	section{padding: 15px;}
</style>
<section class="haru_section">
	<div class="row">
		<div class="col-lg-12">
			<div class="box">
				<div class="box-header text-center">
					
					<h3>
						회원 관리
					</h3>
					
					<hr class="star-primary">
				</div>
			</div>
			<div class="box">
				<form id="delForm" method="post">
				<c:if test="${!empty uList }">
					<c:forEach items="${uList }" var="user">
						<div class="col-sm-3 portfolio-item pItem text-center">
							<div class="pItem">
								<c:if test="${empty user.uexitdate }">
									<input type="checkbox" name="delFiles" class="pCheck" value="${user.uid }">
								</c:if>
								<c:if test="${!empty user.upic }">
									<img alt=""
										src="${pageContext.request.contextPath }/display?filename=${user.upic }"
										class="img-circle img-responsive">
								</c:if>
								<c:if test="${empty user.upic }">
									<img alt=""
										src="${pageContext.request.contextPath }/resources/img/user2.png"
										class="img-responsive">
								</c:if>

								<div class="portfolio-caption">
									<h4>${user.uid }<br>
										<small >${user.uname }</small><br>
										<small>가입일자 : ${user.ujoindateForm }</small><br>
										<c:if test="${!empty user.uexitdate }">
											<small>탈퇴 일자 : ${user.uexitdateForm }</small>
										</c:if>
									</h4>
									<p class="text-muted"></p>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				</form>
				<c:if test="${empty uList }">
					<div class="text-center empty-diary">
						<img alt="" src="${pageContext.request.contextPath }/resources/img/cherry-blossom_b.png">
						<p>등록된 회원이 없습니다.</p>
					</div>
				</c:if>
			</div>						
		</div>
		<div class="col-md-12">
			<div class="box">
				<div class="text-center">
					<span class="boardDel">
						<button id="selDelBtn" class="btn btn-warning btn_haru">선택 탈퇴</button>	
					</span>
					<span class="selectDel">
						<button id="delBtn" class="btn btn-danger btn_haru">삭제</button>
						<button id="cancelBtn" class="btn btn_haru">취소</button>
					</span>
				</div>
			</div>
		</div>
	</div>

</section>

<style>
	#myModal .modal-dialog{width:70% !important;}
	#myModal .modal-dialog .modal-body{text-align: center;}
	#myModal .modal-dialog #modalImg{width: 80%;}
</style>
<script>
 	//var result = "${result}";
	if("${result}"=="SUCCESS"){
		alert("성공적으로 등록되었습니다.");
	}else if("${result}"=="rSUCCESS"){
		alert("성공적으로 삭제되었습니다.");
	}else if("${result}"=="FAIL"){
		alert("등록에 실패하였습니다.");
	}else if("${result}"=="rFAIL"){
		alert("삭제에 실패하였습니다.");
	}
	
	$(function(){
		var date =	"${date}";
		var theDate = date.split("-");
		var today = new Date();		
		var todayForm = today.getFullYear()+"-"+((today.getMonth()+1)<10?"0"+(today.getMonth()+1):(today.getMonth()+1))+"-"+(today.getDate()<10?"0"+today.getDate():today.getDate());
		if(date == todayForm){
			$("#goNext").css("display","none");
		}else{
			$("#goNext").css("display","inline");
		}
		// 이전 달 달력 보여주기
		$("#goPrev").click(function(){
			today.setFullYear(Number(theDate[0]), (Number(theDate[1])-1), Number(theDate[2])-1);
			location.href = "${pageContext.request.contextPath}/admin/list.do/"+today.getTime();
		});
		// 다음 달 달력 보여주기
		$("#goNext").click(function(){
			today.setFullYear(Number(theDate[0]), (Number(theDate[1])-1), Number(theDate[2])+1);
			location.href = "${pageContext.request.contextPath}/admin/list.do/"+today.getTime();
		});
		
		
		$("#selDelBtn").click(function(){//선택 삭제 버튼 클릭 시 
			/* #delBtn{display: none;}
			#cancelBtn{display: none;} */
			<c:if test="${empty uList}">
				swal({
				  title: "회원이 존재하지 않습니다.",
				  text: "당신의 하루",
				  type: "warning",
				  showCancelButton: false,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "확인",
				  cancelButtonText:"취소"
				},function(){
							
				});	
				
			</c:if>
			<c:if test="${!empty uList}">
				if($("#delBtn").css("display") == "none"){
					$(".pCheck").css("display","inline");
					$("#delBtn").css("display","inline");
					$("#cancelBtn").css("display","inline");
					$("#selDelBtn").css("display","none");
				}else{
					$(".pCheck").css("display","none");
					$("#delBtn").css("display","none");
					$("#cancelBtn").css("display","none");
					$("#selDelBtn").css("display","inline");
				}
			</c:if>
			
		});
		
		$("#cancelBtn").click(function(){
			$(".pCheck").css("display","none");
			$("#delBtn").css("display","none");
			$("#cancelBtn").css("display","none");
			$("#selDelBtn").css("display","inline");
		});
		
		$("#delBtn").click(function(){
			swal({
				  title: "선택된 회원들을 탈퇴시키겠습니까?",
				  text: "당신의 하루",
				  type: "warning",
				  showCancelButton: false,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "확인",
				  cancelButtonText:"취소"
				},function(){
					$("#delForm").attr("action", "${pageContext.request.contextPath}/member/exit");
					$("#delForm").submit();		
				});	
		});//선택 삭제 버튼
		
		
	});//ready
</script>
<%@ include file="../include/footer2.jsp" %>
