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
	.empty-diary{margin-bottom: 100px;}
	.empty-diary img{width: 100px; height: 100px; margin-bottom: 10px;}
</style>
<section class="haru_section">
	<div class="row">
		<div class="col-lg-12">
			<div class="box">
				<div class="box-header text-center">
					
					<h3>
						<a href="#" id="goPrev">&lt;&nbsp;&nbsp;&nbsp;</a>
						${date }
						<a href="#" id="goNext">&nbsp;&nbsp;&nbsp;&gt;</a>
					</h3>
					
					<hr class="star-primary">
				</div>
			</div>
			<div class="box">
				<form id="delForm" method="post">
				<c:if test="${!empty bList }">
					<c:forEach items="${bList }" var="board">
						<div class="col-sm-3 portfolio-item pItem text-center">
							<div class="pItem">
								<input type="checkbox" name="delFiles" class="pCheck" value="${board.bno }">
								<c:if test="${!empty board.bpic }">
									<img alt="${board.originalname }"
										src="${pageContext.request.contextPath }/display?filename=${board.bpic }"
										class="img-responsive">
								</c:if>
								<c:if test="${empty board.bpic }">
									<img alt=""
										src="${pageContext.request.contextPath }/resources/img/cherry-blossom_b.png"
										class="img-responsive">
								</c:if>

								<div class="portfolio-caption">
									<h4>${board.bcontent }<br>
										<small style="color:purple;">${board.btoday }</small>
										<small>${board.bopen==true?"공개":"비공개" }</small><br>
										<small><a href="${pageContext.request.contextPath }/board/list/${board.dno.dno}">${board.dno.dtitle }(${board.dno.dopen==true?"공개":"비공개" })</a></small><br>
										<small>${board.dno.uid }</small>
									</h4>
									<p class="text-muted"></p>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				</form>
				<c:if test="${empty bList }">
					<div class="text-center empty-diary">
						<img alt="" src="${pageContext.request.contextPath }/resources/img/cherry-blossom_b.png">
						<p>등록된 일기가 없습니다.</p>
					</div>
				</c:if>
			</div>						
		</div>
		<div class="col-md-12">
			<div class="box">
				<div class="text-center">
					<span class="boardDel">
						<c:if test="${!empty bList }">
							<button id="selDelBtn" class="btn btn-warning btn_haru">선택 삭제</button>
						</c:if>	
					</span>
					<span class="selectDel">
						<button id="delBtn" class="btn btn-danger btn_haru">삭제</button>
						<button id="cancelBtn" class="btn btn_haru">취소</button>
					</span>
					<a href="${pageContext.request.contextPath }/board/list.do" class="btn btn-primary">목록 보기</a>
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
		// 이전 일 달력 보여주기
		$("#goPrev").click(function(){
			today.setFullYear(Number(theDate[0]), (Number(theDate[1])-1), Number(theDate[2])-1);
			location.href = "${pageContext.request.contextPath}/admin/list.do/"+today.getTime();
		});
		// 다음 일 달력 보여주기
		$("#goNext").click(function(){
			today.setFullYear(Number(theDate[0]), (Number(theDate[1])-1), Number(theDate[2])+1);
			location.href = "${pageContext.request.contextPath}/admin/list.do/"+today.getTime();
		});
		
		
		$("#selDelBtn").click(function(){//선택 삭제 버튼 클릭 시 
			/* #delBtn{display: none;}
			#cancelBtn{display: none;} */
			<c:if test="${empty bList}">
				swal({
				  title: "삭제할 항목이 없습니다.",
				  text: "당신의 하루",
				  type: "error",
				  showCancelButton: false,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "확인"
				});
			</c:if>
			<c:if test="${!empty bList}">
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
		
		$("#allDelBtn").click(function(){
			<c:if test="${empty bList}">
				swal({
				  title: "삭제할 항목이 없습니다.",
				  text: "당신의 하루",
				  type: "error",
				  showCancelButton: false,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "확인"
				});
				
			</c:if>
			<c:if test="${!empty bList}">
				swal({
				  title: "삭제하시겠습니까?",
				  text: "당신의 하루",
				  type: "info",
				  showCancelButton: true,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "확인",
				  cancelButtonText:"취소"
				},
				function(){
					location.href="del";
				});
				
			</c:if>
			
		});//전체 삭제 버튼
		
		$("#delBtn").click(function(){
			swal({
				  title: "선택한 항목을 삭제하시겠습니까?",
				  text: "당신의 하루",
				  type: "info",
				  showCancelButton: true,
				  confirmButtonColor: "#DD6B55",
				  confirmButtonText: "확인",
				  cancelButtonText:"취소"
				},
				function(){
					$("#delForm").attr("action", "${pageContext.request.contextPath}/board/del.do");
					$("#delForm").submit();
				});
		});//선택 삭제 버튼
		
		
	});//ready
</script>
<%@ include file="../include/footer2.jsp" %>
