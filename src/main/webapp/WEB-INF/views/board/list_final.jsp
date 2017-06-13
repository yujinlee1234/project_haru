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
	table#dTable{width:100%; table-layout: fixed;}
	table#dTable .tdCheck{float: left; margin-left: 10px; margin-top: 10px;}
	table#dTable .tdSwitch{float: right;margin-top: 10px; margin-right: 5px;}
	table#dTable figure{clear:both;}
	table#dTable th, td{border:1px solid black;}
	table#dTable td{height: 150px; vertical-align: top;}
	table#dTable td img{width:90%;}
	form#delForm{width:100%;}
	.tdDate{float: left;margin-left: 10px;}
	a.showImage{width:90%; height: 100px; display: inline-block; clear: both; }
	a.showImage img{display:inline !important; width:100%; height: 90%; line-height: 100px;}
	img.emptyImg{width:50px !important; height: 50px !important;margin:0 auto; margin-top: 25px;}
	div#diary-modal{width:80%; margin: 0 auto; }
</style>
<section class="content haru_section">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="box">
				<div class="box-header text-center">
					<h3>${diary.dtitle }</h3>
					<hr class="star-primary">
				</div>
			</div>
			<div class="box">
				<div class="box-header with-border">
					<h4 class=" text-center"><a href="#" id="goPrev">&lt;</a><span id="dMonth"></span><a href="#" id="goNext">&gt;</a></h4>
				</div>
				<div class="box-body">
				<form id="delForm" method="post">
					<table id="dTable" >						
							
					</table>
					</form>	
				</div>
				
				<br>
				
			</div>
			
		</div>
		<div class="text-center col-md-1 board-user">
			<button id="addBtn" class="btn btn-success">일기 등록</button>
			<span class="boardDel">				
				<button id="selDelBtn" class="btn btn-primary">선택 삭제</button>	
				<button id="allDelBtn" class="btn btn-warning">전체 삭제</button>
			</span>
			<span class="selectDel">
				<button id="delBtn" class="btn btn-danger">삭제</button>
				<button id="cancelBtn" class="btn">취소</button>
			</span>
					
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
	      	<p class="text-left" id="bdate"></p>
	        <img alt="" src="" id="modalImg"><br>
	        <span id="fileName"></span>
        </div>
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
        <p id="openText"></p>        
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
	#myModal .modal-dialog{width:60% !important;}
	#myModal .modal-dialog .modal-body{text-align: center;}
	#myModal .modal-dialog #modalImg{width: 100%;}
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
	
	$(function(){
		var today = new Date();
		var date = setmonth(today);
		setScreen(date);
		//본인만 일기 등록/삭제 가능하도록
		if(uid == "" || dUid != uid){
			$("div.board-user").css("display", "none");
		}
		
		$(document).on("click",".showImage", function(){
			var path = $(this).find("img").attr("alt");
			var bcontent = $(this).find(".bcontent").val();
			var btoday = $(this).find(".btoday").val();
			var bdate = $(this).find(".bdate").val();
			
			console.log("Path : "+path);
			if(path != ""){
				$("#modalImg").attr("src","${pageContext.request.contextPath }/display?filename="+path);
			}else{
				$("#modalImg").attr("src","${pageContext.request.contextPath }/resources/img/empty-folder.png");
			}
			$("#bdate").html(bdate);
			$("#fileName").html('<h3>'+bcontent+'</h3><p class="text-right"><small>오늘 하루는?<span id="btodayTag" style="color: purple">'+btoday+'</span></samll></p>');
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
					location.href="${pageContext.request.contextPath }/board/del.do";
				}
			</c:if>
			
		});//전체 삭제 버튼
		
		$("#delBtn").click(function(){
			if(confirm("선택한 항목을 삭제하시겠습니까?")){
				$("#delForm").attr("action", "del.do");
				$("#delForm").submit();
				
			}
		});//선택 삭제 버튼
		
		
		
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
		
		$("#btnCancel").click(function(){
			//bootStrapSwitch 다시 원위치로 되돌릴 필요있음 
		});
		
		$(document).on("click",".openSwitchA",function(){
			var bno = $(this).find("input[type='hidden']").val();
			var opened = $(this).find("input.openSwitch").prop("checked");
			console.log(bno);
			$("#openBno").val(bno);
			$("#openText").text(opened==true?"일기를 공개하시겠습니까?":"일기를 비공개 하시겠습니까?");
			$(this).attr("data-toggle","modal").attr("data-target","#openModal");
		}); 
		
		$(document).on('switchChange.bootstrapSwitch', 'input.openSwitch', function(event, state) {			
			$(this).parents(".openSwitchA").click();
			  console.log(this); // DOM element
			  console.log(event); // jQuery event
			  console.log(state); // true | false
		});		
		
		$("#addBtn").click(function(){
			var addToday = new Date();
			location.href="${pageContext.request.contextPath }/board/add.do?date="+addToday.getTime();
		});
		
		$("#goPrev").click(function(){
			console.log(date);
			date.setMonth(date.getMonth()-1);
			console.log("GO PREV : "+date);
			date = setmonth(date);
			console.log("GO PREV AFTER: "+date);
			setScreen(date);
		});
		
		$("#goNext").click(function(){
			console.log(date);
			date.setMonth(date.getMonth()+1);
			console.log("GO NEXT : "+date);
			date = setmonth(date);
			console.log("GO NEXT AFTER: "+date);
			setScreen(date);
		});
	});//ready
	
	
	
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
	
	function setScreen(dateObj){
		var dno = ${diary.dno};
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
				setTable(bList, dateObj);
				setSwitch();
				$(".pCheck").css("display", "none");
				
				if(uid == "" || dUid != uid){
					$("a.openSwitchA").css("display", "none");
				}
			}
		});	
	}
	
	// section 내 월별 다이어리 목록 보여주는 화면
	function setTable(bList, dateObj){
		console.log(bList);
		console.log(bList.length);
		
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
					if(j==0){
						tableForm +='<td style="color: red">';
					}else if(j==6){
						tableForm +='<td style="color: blue">';
					}else{
						tableForm +='<td>';
					}
					
					if(bList.length>0 && dNum == boardDate.getDate()){
						//td 시작
						tableForm += '<div class="text-center">';
						// 날짜 및 삭제 시 필요한 checkbox
						tableForm += '<p class="tdCheck"><input type="checkbox" name="delFiles" class="pCheck" value="'+bList[bIndex].bno+'">'+dNum;
						// 일기의 공개 여부
												
						tableForm += '<p class="switch tdSwitch">';
						tableForm += '<a class="openSwitchA">';	
						tableForm += '<input type="hidden" value="'+bList[bIndex].bno+'">';
						
						if(bList[bIndex].bopen == true){
							tableForm += '<input type="checkbox" name="openSwitch" data-on-color="success" data-on-text="&nbsp;" data-off-text="&nbsp;" data-size="mini" class="openSwitch" checked=true data-state=true>';		
						}else{
							tableForm += '<input type="checkbox" name="openSwitch" data-on-color="success" data-on-text="&nbsp;" data-off-text="&nbsp;" data-size="mini" class="openSwitch" checked=false data-state=false>';	
						}
						
						tableForm += '</a>';
						tableForm += '</p>';	
						
						// 다이어리 사진
						tableForm += '<figure>';
						tableForm += '<a href="#" class="showImage">';
						if(bList[bIndex].bpic == null || bList[bIndex].bpic == undefined || bList[bIndex].bpic == ""){
							tableForm += '<img class="emptyImg" alt="" src="${pageContext.request.contextPath }/resources/img/cherry-blossom_b.png">';
						}else{
							tableForm += '<img alt="'+bList[bIndex].originalname +'" src="${pageContext.request.contextPath }/display?filename='+bList[bIndex].bpic+'">';
						}
						tableForm += '<input type="hidden" value="'+bList[bIndex].bcontent+'" class="bcontent"><input type="hidden" value="'+bList[bIndex].bdateForm+'" class="bdate"><input type="hidden" value="'+bList[bIndex].btoday+'" class="btoday">';
						tableForm += '</a>';
						tableForm += '</figure>';						
						tableForm += '</div>';					
						tableForm += '</td>';
						
						if(bIndex < bList.length-1){
							bIndex++;
						}
					}else{
						var date = new Date(y,m,dNum);
						tableForm += '<p class="tdCheck"><a class="dateA" href="${pageContext.request.contextPath }/board/add.do?date='+date.getTime()+'">'+dNum+'</a></p></td>';
					}
					
					dNum++;
				}			
			}
			tableForm +='</tr>';
		}		
		$("#dTable").append(tableForm);		
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