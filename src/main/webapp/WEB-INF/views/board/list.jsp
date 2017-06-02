<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	div.pItem{width:200px; float: left; margin: 10px;}
	.pItem .pCheck{display: none; float: left;}
	.pItem p{text-align: right;padding-right: 22px;}
	.pItem img{width: 178px; height: 100px;}
	.pItem figcaption{text-align: right; padding-right: 22px;}
	div#noItem figure{width: 100%; text-align: center;}
	#delBtn{display: none;}
	#cancelBtn{display: none;}	
</style>
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-body">		
					<button id="allDelBtn" class="btn btn-warning">전체 삭제</button>
					<button id="selDelBtn" class="btn btn-primary">선택 삭제</button>				
				</div>
			</div>
			<div class="box">
				<div class="box-header with-border">
				</div>
				<div class="box-body">
					<form id="delForm" method="post">
					<c:if test="${!empty bList }">
						<c:forEach items="${bList }" var="pic">
							<div class="pItem">
								<p><input type="checkbox" name="delFiles" class="pCheck" value="${pic.bpic }">${pic.getBdateTimeForm() }</p>	
								<figure>
									<a href="#" class="showImage">
										<c:if test="${!empty pic.bpic }">
											<img alt="${pic.originalname }" src="${pageContext.request.contextPath }/display?filename=${pic.bpic }">
										</c:if>
										<c:if test="${empty pic.bpic }">
											<img alt="" src="${pageContext.request.contextPath }/resources/dist/img/empty-folder.png">
										</c:if>
									</a>
									<figcaption>${pic.bcontent }(${pic.bopen==true?'공개':'비공개' })</figcaption>
								</figure>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${empty bList }">
						<div id="noItem">
							<figure>
								<img alt="" src="${pageContext.request.contextPath }/resources/dist/img/empty-folder.png">
								<figcaption> 등록된 일기가 없습니다. </figcaption>
							</figure>
						</div>						
					</c:if>
					</form>
				</div>
				<div class="box-footer">
					<div class="pull-right">
						<button id="delBtn" class="btn btn-danger">삭제</button>
						<button id="cancelBtn" class="btn">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">${diary.dtitle }</h4>
      </div>
      <div class="modal-body">
        <img alt="" src="" id="modalImg"><br>
        <span id="fileName"></span>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
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
		$(".showImage").click(function(){
			var path = $(this).find("img").attr("alt");
			var filename = $(this).parents(".pItem").find("figcaption").text();
			console.log("File Name : "+filename);
			console.log("Path : "+path);
			if(path != ""){
				$("#modalImg").attr("src","display?filename="+path);
			}else{
				$("#modalImg").attr("src","${pageContext.request.contextPath }/resources/dist/img/empty-folder.png");
			}
			$("#fileName").text(filename);
			$(this).attr("data-toggle","modal").attr("data-target","#myModal");
			 //data-toggle="modal" data-target="#myModal"
		});
		
		$("#selDelBtn").click(function(){//선택 삭제 버튼 클릭 시 
			/* #delBtn{display: none;}
			#cancelBtn{display: none;} */
			<c:if test="${empty bList}">
				alert("삭제할 항목이 없습니다.");
			</c:if>
			<c:if test="${!empty bList}">
				if($("#delBtn").css("display") == "none"){
					$(".pCheck").css("display","inline");
					$("#delBtn").css("display","inline");
					$("#cancelBtn").css("display","inline");
				}else{
					$(".pCheck").css("display","none");
					$("#delBtn").css("display","none");
					$("#cancelBtn").css("display","none");
				}
			</c:if>
			
		});
		
		$("#cancelBtn").click(function(){
			$(".pCheck").css("display","none");
			$("#delBtn").css("display","none");
			$("#cancelBtn").css("display","none");
		});
		
		$("#allDelBtn").click(function(){
			<c:if test="${empty bList}">
				alert("삭제할 항목이 없습니다.");
			</c:if>
			<c:if test="${!empty bList}">
				if(confirm("삭제하시겠습니까?")){
					location.href="del";
				}
			</c:if>
			
		});//전체 삭제 버튼
		
		$("#delBtn").click(function(){
			if(confirm("선택한 항목을 삭제하시겠습니까?")){
				$("#delForm").attr("action", "del");
				$("#delForm").submit();
				
			}
		});//선택 삭제 버튼
		
		
	});//ready
</script>
<%@ include file="../include/footer.jsp" %>