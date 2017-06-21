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
	table#dTable th{padding:5px;}
	table#dTable th, td{border:1px solid black;}
	table#dTable td{height: 100px; vertical-align: top;}
	table#dTable td img{width:90%;}
	
	form#delForm{width:100%;}
	.tdDate{float: left;margin-left: 10px;}
	
	a.showImage{width:90%; height: 100px; display: inline-block; clear: both; }
	a.showImage img{display:inline !important; width:100%; height: 90%; line-height: 100px;}
	
	img.emptyImg{width:50px !important; height: 50px !important;margin:0 auto; margin-top: 25px;}
	button.btn_haru{width:85px !important;}
	div.board-user{position: relative;}
	div#board-user-btn{width:90px; position: fixed; top:300px; right:50px; }
</style>

<section class="content haru_section">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="box">
				<div class="box-header text-center">
					<h3>일기 관리</h3>
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
					<table id="dTable" class="table">						
							
					</table>
					</form>	
				</div>
				
				<br>
			</div>
			
		</div>
	</div>
</section>
<style>
	#myModal .modal-dialog{width:600px !important;}
	#myModal .modal-dialog .modal-content{ height:800px !important;}
	#myModal .modal-dialog .modal-body{ width:600px !important; height:680px !important; text-align: center;}
	#myModal .modal-dialog .modal-body #diary-modal{margin: 0 auto; position:relative; width:500px; height:660px; padding : 10px 30px; border: 1px solid #ccc; box-shadow:1px 1px 1px #ccc;}
	#myModal .modal-dialog .modal-body #diary-modal p, #myModal .modal-dialog .modal-body #diary-modal div#fileName{width:400px; margin: 0 auto;margin-bottom:5px; display: block;}
	#myModal .modal-dialog .modal-footer{height: 60px !important;}
	#myModal .modal-dialog #modalImg{width: 400px; height:500px;}
	#myModal #btoday{position: absolute; text-align:right !important; bottom:10px; }
</style>

<script>
	$(function(){		
		var today = new Date();
		var date = setmonth(today);
		setScreen(date);	
		
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
			url:"${pageContext.request.contextPath }/admin/list.do?date="+dateObj.getTime(),
			type:"post",
			dataType:"json",
			async:true,
			success:function(data){
				// data.bList - array(넘어온 dateObj의 정보를 바탕으로 해당 년, 월의 일기 목록 array형태로 반환), data.diary - object
				console.log(data);
				var bdList = data.bdList;

				setTable(bdList, dateObj);
				
				$("p.tdCheck a").css("color","black");
				$("p.sun").css("color","red");
				$("p.sat").css("color","blue");
				$("p.sun a").css("color","red");
				$("p.sat a").css("color","blue");
				$("img.dExist").css("width","80%");
				$("img.dExist").css("display","block");
				$("img.dExist").css("margin","0 auto");
				$("img.dExist").css("padding","15%");
				
				
			}
		});	
	}
	
	
	// section 내 월별 다이어리 목록 보여주는 화면
	function setTable(bdList, dateObj){
		var today = new Date();
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
		
		var bdIndex = 0;
		
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
					tableForm +='<td>';							
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
						tableForm += '<a class="dateA" title="'+aTitle+'" href="${pageContext.request.contextPath }/admin/list.do/'+date.getTime()+'">'+dNum;
						
						if(typeof bdList != "undefined"){
							if(bdList[bdIndex] == date.getDate()){
								tableForm += '<br><img class="dExist" src="${pageContext.request.contextPath}/resources/img/cherry-blossom_b.png">';		
							}
						}
						tableForm += '</a></p></td>';
						
					}else{
						tableForm += '<a class="dateA">'+dNum+'</a></p></td>';
					}
					dNum++;
				}					
					
			}	
				tableForm +='</tr>';
		}
		$("#dTable").append(tableForm);	
	}			
</script>
<style>
	.wrap_chkbox {            
	    text-align: left; 
	    float: right;
	    margin-right:5px;
	    margin-top:5px;
	    width:30px;
	}
	.wrap_chkbox .chkbox {
	    display: inline-block;
	    vertical-align: top; 
	}
	.wrap_chkbox .chkbox input[type=checkbox] {
	    display: none; /*체크박스 이미지만 보여지게 하기 위해 none으로 설정*/
	}
	.wrap_chkbox .chkbox img {
	    width: 40px; 
	}
	.wrap_chkbox p {
	    
	    margin-top:5px;
	    padding-left: 5px;
	    text-align: left;
	    display: inline-block;
	    vertical-align: middle; 
	 }    

</style>
<%@ include file="../include/footer2.jsp" %>