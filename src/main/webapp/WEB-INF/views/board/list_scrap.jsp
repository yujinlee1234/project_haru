<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	div.pItem{width:230px; padding:10px; display:inline-block; margin: 10px;}
	div.board{width:210px; padding:10px; border: 1px solid #ccc; box-shadow:1px 1px 1px #ccc;}
	.pItem .pCheck{display: none; float: left;}
	.pItem p{text-align: right;padding-right: 22px;}
	.pItem img{width: 190px; height: 190px; margin: 0 auto !important; margin-bottom: 10px;}
	.pItem .btoday{float: right;}
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
		<div class="col-lg-8 col-lg-offset-2">
			<div class="box">
				<div class="box-header text-center">
					<h3>스크랩 목록</h3>					
					<hr class="star-primary">
				</div>
			</div>
			<div class="box text-center">
				<form id="delForm" method="post">
				<c:if test="${!empty bList }">
					<c:forEach items="${bList }" var="board">
						<div class="pItem text-center">
							<div class="board">
								<input type="checkbox" name="delFiles" class="pCheck" value="${board.bno }">
								<c:if test="${!empty board.bpic }">
									<img alt="${board.originalname }"
										src="${pageContext.request.contextPath }/display?filename=${board.originalname }"
										class="img-responsive">
								</c:if>
								<c:if test="${empty board.bpic }">
									<img alt=""
										src="${pageContext.request.contextPath }/resources/img/cherry-blossom_b.png"
										class="img-responsive">
								</c:if>

								<div class="portfolio-caption">
									<h4>${board.bcontent }<br><br>
										<span class="btoday"><small>오늘은 : </small><small style="color:purple;">${board.btoday }</small></span><br>
									</h4>
									<p class="text-muted"></p>
								</div>
							</div>
							<br>
							<a href="${pageContext.request.contextPath }/board/list/${board.dno.dno}"><small>${board.dno.dtitle }<br>(${board.dno.uid })</small></a>
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
					<a href="${pageContext.request.contextPath }/board/list.do" class="btn btn-primary">목록 보기</a>
					<span class="boardDel">
						<c:if test="${!empty bList }">
							<button id="allDelBtn" class="btn btn-success btn_haru">전체 삭제</button>
							<button id="selDelBtn" class="btn btn-warning btn_haru">선택 삭제</button>
						</c:if>	
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
					location.href="${pageContext.request.contextPath}/board/scrap/del";
				});
				
			</c:if>
			
		});//전체 삭제 버튼
		
		$("#delBtn").click(function(){
			var cList = new Array();
			$("input[name='delFiles']").each(function(i, obj) {
				if($(obj).prop("checked")==true){
					cList.push($(obj).val());
					console.log($(obj).val());
				}	
			});

			if(cList.length>0){
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
						$("#delForm").attr("action", "${pageContext.request.contextPath}/board/scrap/del");
						$("#delForm").submit();
					});
			}else{
				swal({
					  title: "선택된 항목이 없습니다.",
					  text: "당신의 하루",
					  type: "warning",
					  showCancelButton: false,
					  confirmButtonColor: "#DD6B55",
					  confirmButtonText: "확인",
					  cancelButtonText:"취소"
					});
			}
		});//선택 삭제 버튼
		
		
	});//ready
</script>
<%@ include file="../include/footer2.jsp" %>
