<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp" %>
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
	span.selectDel{}	
</style>
<section class="content haru_section">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="box">
				<div class="box-body text-right">
					<span class="boardDel">		
						<button id="allDelBtn" class="btn btn-warning">전체 삭제</button>
						<button id="selDelBtn" class="btn btn-primary">선택 삭제</button>	
					</span>
					<span class="selectDel">
						<button id="delBtn" class="btn btn-danger">삭제</button>
						<button id="cancelBtn" class="btn">취소</button>
					</span>
							
				</div>
			</div>
			<div class="box">
				<div class="box-header with-border">
				</div>
				<div class="box-body">
					<form id="delForm" method="post">
					<c:if test="${!empty bList }">
						<c:forEach items="${bList }" var="board">
							<div class="pItem">
								<p>
									<input type="checkbox" name="delFiles" class="pCheck" value="${board.bpic }">									
									${board.getBdateForm() }
									
								</p>	
								<figure>
									<a href="#" class="showImage">
										<c:if test="${!empty board.bpic }">
											<img alt="${board.originalname }" src="${pageContext.request.contextPath }/display?filename=${board.bpic }">
										</c:if>
										<c:if test="${empty board.bpic }">
											<img alt="" src="${pageContext.request.contextPath }/resources/img/empty-folder.png">
										</c:if>
									</a>
									<figcaption>${board.bcontent }(${board.bopen})</figcaption>
								</figure>
								
									<p class="switch">			
										<a class="openSwitchA">
										<input type="hidden" value="${board.bno }">
										<c:if test="${board.bopen }">
											<input type="checkbox" name="openSwitch" data-on-color="success" data-on-text="&nbsp;" data-off-text="&nbsp;" data-size="mini" class="openSwitch" checked=true data-state=true >
										</c:if>
										<c:if test="${!board.bopen }">
											<input type="checkbox" name="openSwitch" data-on-color="success" data-on-text="&nbsp;" data-off-text="&nbsp;" data-size="mini" class="openSwitch" checked=false data-state=false >
										</c:if>
										</a>
									</p>
								
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

<!-- Modal -->
<div id="openModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">다이어리 공개</h4>
      </div>
      <div class="modal-body">
        <p>다이어리를 공개하시겠습니까?</p>        
      </div>
      <div class="modal-footer">
      	<input type="hidden" value="" id="openBno">
      	<button type="button" class="btn btn-success" id="btnBopen">확인</button>
        <button type="button" class="btn btn-default" id="btnCancel" data-dismiss="modal">취소</button>
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
		//$("input.openSwitch").bootstrapSwitch();
		var uid = "${auth.uid}";
		var dUid = "${diary.uid}";
		if(uid == "" || dUid != uid){
			$("p.switch").css("display", "none");
		}
		
		$(".showImage").click(function(){
			var path = $(this).find("img").attr("alt");
			var filename = $(this).parents(".pItem").find("figcaption").text();
			console.log("File Name : "+filename);
			console.log("Path : "+path);
			if(path != ""){
				$("#modalImg").attr("src","${pageContext.request.contextPath }/display?filename="+path);
			}else{
				$("#modalImg").attr("src","${pageContext.request.contextPath }/resources/img/empty-folder.png");
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
					$("#allDelBtn").css("display","none");
					$("#selDelBtn").css("display","none");
				}else{
					$(".pCheck").css("display","none");
					$("#delBtn").css("display","none");
					$("#cancelBtn").css("display","none");
					$("#allDelBtn").css("display","inline");
					$("#selDelBtn").css("display","inline");
				}
			</c:if>
			
		});
		
		$("#cancelBtn").click(function(){
			$(".pCheck").css("display","none");
			$("#delBtn").css("display","none");
			$("#cancelBtn").css("display","none");
			$("#allDelBtn").css("display","inline");
			$("#selDelBtn").css("display","inline");
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
		
		//setScreen();
		setSwitch();
		
		$("#btnBopen").click(function(){
			var bno = $("#openBno").val();
			console.log(bno);
			$.ajax({
				url:"${pageContext.request.contextPath }/board/modifyOpen/"+bno,
				type:"post",
				async:true,
				dataType:"text",
				success:function(result){
					console.log(result)
					if(result=='fail'){
						alert('[ERROR] 일기를 공개/비공개하지 못했습니다.');
						return false;
					}else if(result=='true'){
						alert("일기가 공개 되었습니다.");
						
					}else if(result=='false'){
						alert("일기가 비공개 되었습니다.");
					}
					$("#btnCancel").click();
				}
			});
		});
		$(".openSwitchA").click(function(){
			var bno = $(this).find("input[type='hidden']").val();
			console.log(bno);
			$("#openBno").val(bno);
			$(this).attr("data-toggle","modal").attr("data-target","#openModal");
		}); 
		$('input.openSwitch').on('switchChange.bootstrapSwitch', function(event, state) {			
			$(this).parents(".openSwitchA").click();
			  console.log(this); // DOM element
			  console.log(event); // jQuery event
			  console.log(state); // true | false
		});
	});//ready
	
	function setScreen(){
		var $delForm = $("#delForm");
		$delForm.empty();
		
		<c:if test="${!empty bList }">
		<c:forEach items="${bList }" var="board">
			var appendForm = "";
			appendForm += '<div class="pItem">';
			appendForm += '<p>';
			appendForm += '<input type="checkbox" name="delFiles" class="pCheck" value="${board.bpic }">';									
			appendForm += '${board.getBdateForm() }';
			appendForm += '</p>';	
			appendForm += '<figure>';
			appendForm += '<a href="#" class="showImage">';
						<c:if test="${!empty board.bpic }">
							appendForm += '<img alt="${board.originalname }" src="${pageContext.request.contextPath }/display?filename=${board.bpic }">';
						</c:if>
						<c:if test="${empty board.bpic }">
							appendForm += '<img alt="" src="${pageContext.request.contextPath }/resources/img/empty-folder.png">';
						</c:if>
			appendForm += '</a>';
			appendForm += '<figcaption>${board.bcontent }(${board.bopen})</figcaption>';
			appendForm += '</figure>';
			appendForm += '<p>';
			<c:if test="${board.bopen }">
				appendForm += '<input type="checkbox" name="openSwitch" data-on-color="success" data-on-text="&nbsp;" data-off-text="&nbsp;" data-size="mini" class="openSwitch" data-switch=true >';
			</c:if>
			<c:if test="${!board.bopen }">
				appendForm += '<input type="checkbox" name="openSwitch" data-on-color="success" data-on-text="&nbsp;" data-off-text="&nbsp;" data-size="mini" class="openSwitch" data-switch=false >';
			</c:if>
			appendForm += '</p>';
			appendForm += '</div>';
			
			$delForm.append(appendForm);
		</c:forEach>
	</c:if>
	}
	
	function setSwitch(){
		var sList = $("input.openSwitch");
		if(sList.length > 0){
			$("input.openSwitch").each(function(i, obj){
				 console.log(obj);
				var checked = $(obj).attr("data-state");
				if(checked == 'false'){
					$(this).bootstrapSwitch('state',false);
				}else if(checked=='true'){
					$(this).bootstrapSwitch('state',true);
				}				
			});	
			
			
		}
		
	}
</script>
<%@ include file="../include/footer2.jsp" %>