<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	#delBtn{display: none;}
	#cancelBtn{display: none;}
	
	table#dTable{width:100%; table-layout: fixed;}
	table#dTable .tdCheck{float: left; margin-left: 10px; margin-top: 10px;}
	table#dTable .tdSwitch{float: right;margin-top: 10px; margin-right: 5px;}
	table#dTable figure{clear:both;}
	table#dTable th{padding:5px !important;}
	table#dTable th, td{border-bottom :1px solid #003344; }
	table#dTable td{height: 150px; vertical-align: top;}
	table#dTable td img{width:90%;}
	
	form#delForm{width:100%;}
	.tdDate{float: left;margin-left: 10px;}
	
	a.showImage{width:90%; height: 100px; display: inline-block; clear: both; }
	a.showImage img{display:inline !important; width:100%; height: 90%; line-height: 100px;}
	
	img.emptyImg{width:50px !important; height: 50px !important;margin:0 auto; margin-top: 10px;}
	button.btn_haru{width:85px !important;}
	div.board-user{position: relative;}
	div#board-user-btn{width:90px; position: fixed; top:300px; right:50px; }
	div#diaryOpen{display:inline; float: none;width: 24px; height:24px;margin-left: 10px;}
	div#diaryOpen img{width: 24px; height:24px;}
	input.scrap{display: none;}
</style>

<section class="content haru_section">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="box">
				<div class="box-header text-center">
					<h3>
						${diary.dtitle }
						<div class="wrap_chkbox" id="diaryOpen">
							<div class="chkbox">
								<c:if test="${diary.dopen }">
									<input type="checkbox" name="chk" class="chk" checked="checked"/>
								</c:if>
								<c:if test="${!diary.dopen }">
									<input type="checkbox" name="chk" class="chk"/>
								</c:if>
								<img src="${pageContext.request.contextPath }/resources/img/chkbox_${diary.dopen }.png"/>
								<input type="hidden" class="checkDno" value="${diary.dno }"/>
							</div>
						</div>						
					</h3>
					<hr class="star-primary">
				</div>
			</div>
			<div class="box">
				<div class="box-header with-border">
					<h4 class=" text-center">
						<a href="#" id="goPrev">&lt;&nbsp;&nbsp;&nbsp;</a>
						<span id="dMonth"></span>
						<a href="#" id="goNext">&nbsp;&nbsp;&nbsp;&gt;</a>
					</h4>
				</div>
				<div class="box-body">
				<form id="delForm" method="post">
					<table id="dTable" class="table table-responsive">						
							
					</table>
					</form>	
				</div>
				
				<br>
			</div>
			
		</div>
		<div class="text-center col-md-1 board-user">
			<div id="board-user-btn">
				<button id="addBtn" class="btn btn-success btn_haru">일기 등록</button>
				<button id="goScrapBtn" class="btn btn-info btn_haru">스크랩</button>
				<span class="boardDel">				
					<button id="selDelBtn" class="btn btn-primary btn_haru">선택 삭제</button>	
					<button id="allDelBtn" class="btn btn-warning btn_haru">전체 삭제</button>
				</span>
				<span class="selectDel">
					<button id="delBtn" class="btn btn-danger btn_haru">삭제</button>
					<button id="cancelBtn" class="btn btn_haru">취소</button>
				</span>
				
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
      	<div id="diary-modal">
      		<div class="wrap_chkbox_scrap">
				<div class="chkbox">						
					<input type="checkbox" name="chk" class="chk" id="scrap_chk"/>						
					<img src="${pageContext.request.contextPath }/resources/img/bookmark_true.png"/>
				</div>
			</div>
	      	<p class="text-left" id="bdate"></p>
	        <img alt="" src="" id="modalImg"><br>
	        <div id="fileName">
	        	<h3 id="bcontent"></h3>
	        	<p id="btoday"></p>
	        </div>
        </div>
      </div>
      <div class="modal-footer">
      	<input type="hidden" value="" id="modalBno">
      	<button type="button" class="btn btn-primary" id="btnMod">수정</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>

  </div>
</div>
<style>
	#myModal .modal-dialog{width:600px !important;}
	#myModal .modal-dialog .modal-content{ height:800px !important;}
	#myModal .modal-dialog .modal-body{ width:600px !important; height:680px !important; text-align: center;}
	#myModal .modal-dialog .modal-body #diary-modal{margin: 0 auto; position:relative; width:500px; height:660px; padding : 10px 30px; border: 1px solid #ccc; box-shadow:1px 1px 1px #ccc;}
	#myModal .modal-dialog .modal-body #diary-modal p, #myModal .modal-dialog .modal-body #diary-modal div#fileName{width:400px; margin: 0 auto;margin-bottom:5px; display: block;}
	#myModal .modal-dialog .modal-footer{height: 60px !important;}
	#myModal .modal-dialog #modalImg{width: 350px; height:450px; margin: 0 auto;}
	#myModal #btoday{position: absolute; text-align:right !important; bottom:10px; }
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
	
	var uid = "${auth.uid}";
	var dUid = "${diary.uid}";
	
	var scrapedCheck = "";
	
	$(function(){
		
		<c:if test="${empty diary}">
			location.href = "${pageContext.request.contextPath }/diary/mylist.do";
		</c:if>
		<c:if test="${!empty diary}">
		var today = new Date();
		var date = setmonth(today);
		setScreen(date);
		//본인만 일기 등록/삭제 가능하도록
		if(uid == "" || dUid != uid){
			$("div.board-user").css("display", "none");
			$("#btnMod").css("display","none");
			$("#diaryOpen").css("display","none");
		}
		
		if(uid == "" || dUid == uid){
			$(".wrap_chkbox_scrap").css("display","none");
		}
		</c:if>
		
		$(document).on("click",".showImage", function(){
			var path = $(this).find("img").attr("alt");
			var bcontent = $(this).find(".bcontent").val();
			var btoday = $(this).find(".btoday").val();
			var bdate = $(this).find(".bdate").val();
			var bno = $(this).find(".bno").val();
			var scrap = $(this).find(".scrap");
			
			
			
			if(typeof scrap != "undefined"){
				console.log(scrap);
				$(".wrap_chkbox_scrap").css("display", "block");
				if(scrap.prop("checked")==true){
					$("#scrap_chk").prop("checked","true");
					$(".wrap_chkbox_scrap img").attr("src","${pageContext.request.contextPath}/resources/img/bookmark_true.png");
				}else{
					$("#scrap_chk").prop("checked","false");
					$(".wrap_chkbox_scrap img").attr("src","${pageContext.request.contextPath}/resources/img/bookmark_false.png");
				}
				
				scrapedCheck = scrap;
			}else{
				$(".wrap_chkbox_scrap").css("display", "none");
			}
			
			if(uid == "" || dUid == uid){
				$(".wrap_chkbox_scrap").css("display","none");
			}
			
			console.log("Path : "+path);
			$("#bdate").html(bdate);
			$("#bcontent").text(bcontent);
			$("#btoday").html('<small>오늘 하루는?<span id="btodayTag" style="color: purple">'+btoday+'</span></samll>');
			$("#modalBno").val(bno);
			if(path != ""){
				$("#modalImg").css("display","block");
				$("#fileName").css("margin-top","0px");
				$("#fileName h3").css("margin-bottom","0px");
				$("#modalImg").attr("src","${pageContext.request.contextPath }/display?filename="+path);
			}else{
				$("#modalImg").css("display","none");
				$("#fileName").css("margin-top","200px");
				$("#fileName h3").css("margin-bottom","400px");
				//$("#modalImg").attr("src","${pageContext.request.contextPath }/resources/img/empty-folder.png");
			}
			
			//$(this).attr("data-toggle","modal").attr("data-target","#myModal");
			 //data-toggle="modal" data-target="#myModal"
		});
		
		$("#selDelBtn").click(function(){//선택 삭제 버튼 클릭 시 
			/* #delBtn{display: none;}
			#cancelBtn{display: none;} */
			<c:if test="${empty bList}">
				swal({
					  title: "삭제할 항목이 없습니다.",
					  text: "당신의 하루",
					  type: "warning",
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
				swal({
					  title: "삭제할 항목이 없습니다.",
					  text: "당신의 하루",
					  type: "warning",
					  showCancelButton: false,
					  confirmButtonColor: "#DD6B55",
					  confirmButtonText: "확인"
					});
			</c:if>
			<c:if test="${!empty bList}">
				swal({
					  title: "지금까지 작성한 모든 일기가 삭제됩니다.",
					  text: "계속 진행하시겠습니까?",
					  type: "info",
					  showCancelButton: true,
					  confirmButtonColor: "#DD6B55",
					  cancelButtonText:"취소",
					  confirmButtonText: "확인"
					},function(){
						location.href="${pageContext.request.contextPath }/board/del.do";
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
					  title: "선택된 항목을 삭제하시겠습니까?",
					  text: "당신의 하루",
					  type: "info",
					  showCancelButton: true,
					  confirmButtonColor: "#DD6B55",
					  cancelButtonText:"취소",
					  confirmButtonText: "확인"
					},function(){
						$("#delForm").attr("action", "${pageContext.request.contextPath }/board/del.do");
						$("#delForm").submit();
					});
			}else{
				swal({
					  title: "선택된 항목이 없습니다.",
					  text: "당신의 하루",
					  type: "warning",
					  showCancelButton: false,
					  confirmButtonColor: "#DD6B55",
					  confirmButtonText: "확인"
					});
			}
		});//선택 삭제 버튼	
		
		$("#addBtn").click(function(){
			var addToday = new Date();
			location.href="${pageContext.request.contextPath }/board/add.do?date="+addToday.getTime();
		});
		
		// 이전 달 달력 보여주기
		$("#goPrev").click(function(){
			console.log(date);
			date.setMonth(date.getMonth()-1);
			console.log("GO PREV : "+date);
			date = setmonth(date);
			console.log("GO PREV AFTER: "+date);
			setScreen(date);
		});
		// 다음 달 달력 보여주기
		$("#goNext").click(function(){
			console.log(date);
			date.setMonth(date.getMonth()+1);
			console.log("GO NEXT : "+date);
			date = setmonth(date);
			console.log("GO NEXT AFTER: "+date);
			setScreen(date);
		});
		// Modal 내 수정하기 버튼 클릭 시
		$("#btnMod").click(function(){
			var bno = $("#modalBno").val();
			location.href="${pageContext.request.contextPath }/board/mod.do/"+bno;
		});
		
		//일기 공개여부 Checkbox 클릭 시 
		$(document).on("click",'.wrap_chkbox img', function () {
			var bno = $(this).parent().find("input.checkBno").val();
          //console.log("클릭된요소 : "+this );
          //console.log($(this))
          //console.log("클릭된요소의 부모요소 : "+ (this.parentElement));
          //console.log($(this).parent())
         
          //체크 박스의 체크 유무를 확인하기 위해 checked값을 얻어옴.
          	var $chkImg = $(this);
          	var $checkbox = $(this).parent().find('input[name="chk"]');
          	var isChecked = $(this).parent().find('input[name="chk"]').prop("checked"); 
         	console.log(isChecked); //boolean값으로 true, false    
         	swal({
				  title: "일기를 "+(isChecked==true?"비공개":"공개")+"하시겠습니까?",
				  text: "당신의 하루",
				  type: "info",
				  showCancelButton: true,
				  confirmButtonColor: "#DD6B55",
				  cancelButtonText:"취소",
				  confirmButtonText: "확인",
				  closeOnConfirm:false,
				},function(){
					isChecked = !isChecked;	            
			  		console.log(bno);
		  			$.ajax({
		  				url:"${pageContext.request.contextPath }/board/modifyOpen/"+bno,
		  				type:"post",
		  				async:false,
		  				dataType:"text",
		  				success:function(result){
		  					console.log(result)
		  					if(result=='fail'){
		  						
		  						swal({
			  						  title: "일기를 공개/비공개 하지 못했습니다.",
			  						  text: "당신의 하루",
			  						  type:"error",
			  						  showCancelButton: false,
			  						  confirmButtonColor: "#DD6B55",
			  						  cancelButtonText:"취소",
			  						  confirmButtonText: "확인"
			  						});
		  						return false;
		  					}else if(result=='true'){
		  						swal({
		  						  title: "일기가 공개 되었습니다.",
		  						  text: "당신의 하루",
		  						  imageURL:"${pageContext.request.contextPath}/resources/img/chkbox_false",
		  						  showCancelButton: false,
		  						  confirmButtonColor: "#DD6B55",
		  						  cancelButtonText:"취소",
		  						  confirmButtonText: "확인"
		  						},function(){
		  							$checkbox.prop("checked",isChecked);
		  							$chkImg.attr("src", "${pageContext.request.contextPath }/resources/img/chkbox_" + isChecked + ".png");
		  						});
		  						
		  						
		  					}else if(result=='false'){
		  						swal({
			  						  title: "일기가 비공개 되었습니다.",
			  						  text: "당신의 하루",
			  						  imageURL:"${pageContext.request.contextPath}/resources/img/chkbox_true",
			  						  showCancelButton: false,
			  						  confirmButtonColor: "#DD6B55",
			  						  cancelButtonText:"취소",
			  						  confirmButtonText: "확인"
			  						},function(){
			  							$checkbox.prop("checked",isChecked);
			  							$chkImg.attr("src", "${pageContext.request.contextPath }/resources/img/chkbox_" + isChecked + ".png");
			  						});
		  					
		  					}
		  					
		  				}
		 			});		    
				});	       
        });
		
		//다이어리 공개여부 Checkbox 클릭 시 
		$(document).on("click",'#diaryOpen img', function () {
			var bno = $(this).parent().find("input.checkDno").val();         
          //체크 박스의 체크 유무를 확인하기 위해 checked값을 얻어옴.
          	var $chkImg = $(this);
          	var $checkbox = $(this).parent().find('input[name="chk"]');
          	var isChecked = $(this).parent().find('input[name="chk"]').prop("checked"); 
         	console.log(isChecked); //boolean값으로 true, false    
         	swal({
				  title: "다이어리를 "+(isChecked==true?"비공개":"공개")+"하시겠습니까?",
				  text: "당신의 하루",
				  type: "info",
				  showCancelButton: true,
				  confirmButtonColor: "#DD6B55",
				  cancelButtonText:"취소",
				  confirmButtonText: "확인",
				  closeOnConfirm:false,
				},function(){
					isChecked = !isChecked;	            
			  		console.log(bno);
		  			$.ajax({
		  				url:"${pageContext.request.contextPath }/diary/modifyOpen/"+bno,
		  				type:"post",
		  				async:false,
		  				dataType:"text",
		  				success:function(result){
		  					console.log(result)
		  					if(result=='fail'){
		  						//alert('[ERROR] 일기를 공개/비공개하지 못했습니다.');
		  						swal({
			  						  title: "다이어리를 공개/비공개 하지 못했습니다.",
			  						  text: "당신의 하루",
			  						  type:"error",
			  						  showCancelButton: false,
			  						  confirmButtonColor: "#DD6B55",
			  						  cancelButtonText:"취소",
			  						  confirmButtonText: "확인"
			  						});
		  						return false;
		  					}else if(result=='true'){
		  						swal({
		  						  title: "다이어리가 공개 되었습니다.",
		  						  text: "당신의 하루",
		  						  imageURL:"${pageContext.request.contextPath}/resources/img/chkbox_false.png",
		  						  showCancelButton: false,
		  						  confirmButtonColor: "#DD6B55",
		  						  cancelButtonText:"취소",
		  						  confirmButtonText: "확인"
		  						},function(){
		  							$checkbox.prop("checked",isChecked);
		  							$chkImg.attr("src", "${pageContext.request.contextPath }/resources/img/chkbox_" + isChecked + ".png");
		  						});
		  						//alert("일기가 공개 되었습니다.");
		  						
		  					}else if(result=='false'){
		  						swal({
			  						  title: "다이어리가 비공개 되었습니다.",
			  						  text: "당신의 하루",
			  						  imageURL:"${pageContext.request.contextPath}/resources/img/chkbox_true.png",
			  						  showCancelButton: false,
			  						  confirmButtonColor: "#DD6B55",
			  						  cancelButtonText:"취소",
			  						  confirmButtonText: "확인"
			  						},function(){
			  							$checkbox.prop("checked",isChecked);
			  							$chkImg.attr("src", "${pageContext.request.contextPath }/resources/img/chkbox_" + isChecked + ".png");
			  						});
		  						
		  					}
		  					
		  				}
		 			});		    
				});	 				        
        });
		
		//일기 스크랩 Checkbox 클릭 시 
		$(document).on("click",'.wrap_chkbox_scrap img', function () {
			var bno = $(this).parents("#myModal").find("#modalBno").val();
          //console.log("클릭된요소 : "+this );
          //console.log($(this))
          //console.log("클릭된요소의 부모요소 : "+ (this.parentElement));
          //console.log($(this).parent())
         
          //체크 박스의 체크 유무를 확인하기 위해 checked값을 얻어옴.
          	var $chkImg = $(this);
          	var $checkbox = $("#scrap_chk");
          	var isChecked = $("#scrap_chk").prop("checked"); 
         	console.log(isChecked); //boolean값으로 true, false    
         	swal({
				  title: "일기를 스크랩/스크랩 해지 하시겠습니까?",
				  text: "당신의 하루",
				  type: "info",
				  showCancelButton: true,
				  confirmButtonColor: "#DD6B55",
				  cancelButtonText:"취소",
				  confirmButtonText: "확인",
				  closeOnConfirm:false,
				},function(){
					isChecked = !isChecked;	            
			  		console.log(bno);
		  			$.ajax({
		  				url:"${pageContext.request.contextPath }/board/scrap/"+bno,
		  				type:"post",
		  				async:false,
		  				dataType:"text",
		  				success:function(result){
		  					console.log(result)
		  					if(result=='fail'){		  						
		  						swal({
			  						  title: "일기를 스크랩/스크랩 해지 하지 못했습니다.",
			  						  text: "당신의 하루",
			  						  type:"error",
			  						  showCancelButton: false,
			  						  confirmButtonColor: "#DD6B55",
			  						  cancelButtonText:"취소",
			  						  confirmButtonText: "확인"
			  						});
		  						return false;
		  					}else if(result=='true'){
		  						swal({
		  						  title: "일기가 스크랩되었습니다.",
		  						  text: "당신의 하루",
		  						  imageURL:"${pageContext.request.contextPath}/resources/img/bookmark_true.png",
		  						  showCancelButton: false,
		  						  confirmButtonColor: "#DD6B55",
		  						  cancelButtonText:"취소",
		  						  confirmButtonText: "확인"
		  						},function(){
		  							$checkbox.prop("checked",true);
		  							scrapedCheck.prop("checked",true);
		  							$chkImg.attr("src", "${pageContext.request.contextPath }/resources/img/bookmark_true.png");
		  						});
		  						
		  						
		  					}else if(result=='false'){
		  						swal({
			  						  title: "일기가 스크랩해지 되었습니다.",
			  						  text: "당신의 하루",
			  						  imageURL:"${pageContext.request.contextPath}/resources/img/bookmark_true.png",
			  						  showCancelButton: false,
			  						  confirmButtonColor: "#DD6B55",
			  						  cancelButtonText:"취소",
			  						  confirmButtonText: "확인"
			  						},function(){
			  							$checkbox.prop("checked",false);
			  							scrapedCheck.prop("checked",false);
			  							$chkImg.attr("src", "${pageContext.request.contextPath }/resources/img/bookmark_false.png");
			  						});
		  					
		  					}
		  					
		  				}
		 			});		    
				});	       
        });
		
		$("#goScrapBtn").click(function(){
			location.href="${pageContext.request.contextPath }/board/scrap.do";
		});
	});//ready
	
	
	// 달력 Table 위 yyyy.MM 형태로 월 보여주기
	function setmonth(date){
		var today = new Date();		
		if(date.getMonth() == today.getMonth() && date.getFullYear() == today.getFullYear()){
			$("#goNext").css("display","none");
		}else{
			$("#goNext").css("display","inline");
		}
		$("#dMonth").text(date.getFullYear()+"."+((date.getMonth()+1)<10?"0"+(date.getMonth()+1):(date.getMonth()+1)));
		
		return date;
	}
	
	// 달력 Table 구성하기 위한 ajax
	function setScreen(dateObj){
		var dno = "";
		<c:if test="${!empty diary}">
			dno = ${diary.dno};
		</c:if>
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth()+1;
		$.ajax({
			url:"${pageContext.request.contextPath }/board/list.do/"+dno+"?year="+year+"&month="+month,
			type:"get",
			dataType:"json",
			async:true,
			success:function(data){
				// data.bList - array(넘어온 dateObj의 정보를 바탕으로 해당 년, 월의 일기 목록 array형태로 반환), data.diary - object
				console.log(data);
				var bList = data.bList;
				var srcList = "";
				
				srcList = data.scrList;
				console.log(srcList);
				setTable(bList, dateObj, srcList);
				setCheckScrap(srcList);
				$(".pCheck").css("display", "none");
				
				$("p.tdCheck a").css("color","black");
				$("p.sun").css("color","red");
				$("p.sat").css("color","blue");
				$("p.sun a").css("color","red");
				$("p.sat a").css("color","blue");
				
			}
		});	
	}
	
	// section 내 월별 다이어리 목록 보여주는 화면
	function setTable(bList, dateObj, srcList){
		var today = new Date();
		//console.log(bList);
		//console.log(bList.length);
		
		var bIndex = 0;
		var tempDate = dateObj;//보여줄 년, 월 정보를 담고 있음
		
		var y = tempDate.getFullYear();
		var m = tempDate.getMonth();
		console.log("year : "+y+"month : "+m);
		var d = tempDate.getDate();
		
		var theDate = new Date(y,m,1);
		var theDay = theDate.getDay();
		
		var last = [31,28,31,30,31,30,31,31,30,31,30,31];
		
		if(y%4==0 && y%100!=0||y%400==0){
			last[1]=29;
		}
		var lastDate = last[m];
		var row = Math.ceil((theDay+lastDate)/7);
		
		$("#dTable").empty();
		
		var tableForm = "";
		
		tableForm +='<tr>';
		tableForm +='<th style="color: red">SUN</th>';
		tableForm +='<th>MON</th>';
		tableForm +='<th>TUE</th>';
		tableForm +='<th>WED</th>';
		tableForm +='<th>THR</th>';
		tableForm +='<th>FRI</th>';
		tableForm +='<th style="color: blue">SAT</th>';
		tableForm +='</tr>';
		
		var dNum = 1;
		for(var i=0; i < row; i++){
			tableForm +='<tr>';
			for(var j = 0; j < 7; j++){
				if(i==0 && j<theDay || dNum>lastDate){
					tableForm +='<td></td>';
				}else{
					var boardDate = null;
					if(bList.length > 0 ){
						boardDate = new Date(bList[bIndex].bdate);
					}
					tableForm +='<td>';
					
					if(bList.length>0 && dNum == boardDate.getDate()){
						//td 시작
						tableForm += '<div class="text-center">';
						// 날짜 및 삭제 시 필요한 checkbox
						if(j==0){
							tableForm +='<p class="tdCheck sun">';
						}else if(j==6){
							tableForm +='<p class="tdCheck sat">';
						}else{
							tableForm +='<p class="tdCheck">';
						}
						
						tableForm += '<input type="checkbox" name="delFiles" class="pCheck" value="'+bList[bIndex].bno+'">'+dNum;						
						
						// 일기의 공개 여부
						if(uid != "" && dUid == uid){
							tableForm += '<div class="wrap_chkbox">';
							tableForm += '<div class="chkbox">';
							if(bList[bIndex].bopen == true){
								tableForm += '<input type="checkbox" name="chk" class="chk" checked=true/>';	
							}else{
								tableForm += '<input type="checkbox" name="chk" class="chk"/>';
							}						
							tableForm += '<img src="${pageContext.request.contextPath }/resources/img/chkbox_' + bList[bIndex].bopen + '.png"/>';
							tableForm += '<input type="hidden" class="checkBno" value="'+bList[bIndex].bno+'"/>';
							tableForm += '</div>';
							tableForm += '</div>';
						}
						tableForm += '</p>';
						
						// 다이어리 사진
						tableForm += '<figure>';
						tableForm += '<a href="#myModal" data-toggle="modal" class="showImage">';
						if(bList[bIndex].bpic == null || bList[bIndex].bpic == undefined || bList[bIndex].bpic == ""){
							tableForm += '<img class="emptyImg" alt="" src="${pageContext.request.contextPath }/resources/img/cherry-blossom_b.png">';
						}else{
							tableForm += '<img alt="'+bList[bIndex].originalname +'" src="${pageContext.request.contextPath }/display?filename='+bList[bIndex].bpic+'">';
						}
						tableForm += '<br><p><small>'+bList[bIndex].btoday+'</small></p>';
						tableForm += '<input type="hidden" value="'+bList[bIndex].bno+'" class="bno"><input type="hidden" value="'+bList[bIndex].bcontent+'" class="bcontent"><input type="hidden" value="'+bList[bIndex].bdateForm+'" class="bdate"><input type="hidden" value="'+bList[bIndex].btoday+'" class="btoday">';
						
						if(uid != "" && dUid != uid){
							console.log(uid);
							console.log("srcList: " + srcList);
							//내가 스크랩 한 게시물인지 체크
							/* if(typeof srcList != "undefined"){
								if(srcList.length > 0){			
							
									var scrapForm = '<input type="checkbox" class="scrap" value="'+bList[bIndex].bno+'">';
									for(var i = 0; i < srcList.length; i++){
										if(bList[bIndex].bno == srcList[i].bno){
											scrapForm = '<input type="checkbox" class="scrap" value="'+bList[bIndex].bno+'" checked="checked">';
											break;
										}
									}
									tableForm += scrapForm;
								}else{ */
									tableForm += '<input type="checkbox" class="scrap" value="'+bList[bIndex].bno+'">';
								/* } */	
							/* } */
						}
						
						tableForm += '</a>';
						tableForm += '</figure>';						
						tableForm += '</div>';					
						tableForm += '</td>';
						
						if(bIndex < bList.length-1){
							bIndex++;
						}
					}else{
						
						var date = new Date(y,m,dNum);
						if(j==0){
							tableForm +='<p class="tdCheck sun">';
						}else if(j==6){
							tableForm +='<p class="tdCheck sat">';
						}else{
							tableForm +='<p class="tdCheck">';
						}
						
						if(date.getTime()<today.getTime()){
							var aTitle = y+'-'+((m+1)<10?"0"+(m+1):(m+1))+'-'+((dNum)<10?"0"+(dNum):(dNum));
							tableForm += '<a class="dateA" title="'+aTitle+'" href="${pageContext.request.contextPath }/board/add.do?date='+date.getTime()+'">'+dNum+'</a></p></td>';
						}else{
							tableForm += '<a class="dateA" title="일기를 등록할 수 없는 날짜입니다.">'+dNum+'</a></p></td>';
						}
					}
					
					dNum++;
				}			
			}
			tableForm +='</tr>';
		}		
		$("#dTable").append(tableForm);		
	}
	
	function setCheckScrap(srcList){
		var chkList = $(".scrap");
		console.log(chkList);
		if(typeof srcList != "undefined"){
			for(var i=0;i<srcList.length;i++){
				for(var j = 0; j < chkList.length; j++){
					var chkbox = chkList[j];
					console.log(chkbox);
					if(chkbox.defaultValue == srcList[i].bno+""){
						chkbox.checked = true;
					}
				}
			}
		}
	}
	
</script>
<style>
	.wrap_chkbox {            
	    text-align: left; 
	    float: right;
	    margin-right:5px;
	    margin-top:5px;
	    width:22px;
	}
	.wrap_chkbox .chkbox {
	    display: inline-block;
	    vertical-align: top; 
	}
	.wrap_chkbox .chkbox input[type=checkbox] {
	    display: none; /*체크박스 이미지만 보여지게 하기 위해 none으로 설정*/
	}
	.wrap_chkbox .chkbox img {
	    width: 20px; 
	}
	.wrap_chkbox p {
	    
	    margin-top:5px;
	    padding-left: 5px;
	    text-align: left;
	    display: inline-block;
	    vertical-align: middle; 
	 }    

	.wrap_chkbox_scrap{    
		position:absolute;
		right:20px;
		top:-16px;        
	    text-align: left; 
	    float: right;
	    margin-right:5px;
	    margin-top:5px;
	    width:30px;
	}
	
	.wrap_chkbox_scrap .chkbox {
	    display: inline-block;
	    vertical-align: top; 
	}
	.wrap_chkbox_scrap .chkbox input[type=checkbox] {
	    display: none; /*체크박스 이미지만 보여지게 하기 위해 none으로 설정*/
	}
	.wrap_chkbox_scrap .chkbox img {
	    width: 45px; 
	}
	.wrap_chkbox_scrap p {
	    
	    margin-top:5px;
	    padding-left: 5px;
	    text-align: left;
	    display: inline-block;
	    vertical-align: middle; 
	 }
</style>
<%@ include file="../include/footer2.jsp" %>