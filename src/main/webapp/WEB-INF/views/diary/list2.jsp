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
</style>
<section id="diaryList" class="haru_section">
	<div class="row">
		<div class="col-lg-12 text-center">
            <h3>오늘의 일기</h3>
            <hr class="star-primary">
        </div>
        <div class="row">
        <c:if test="${!empty dList }">
			<c:forEach items="${dList }" var="diary">
				<div class="col-sm-4 portfolio-item pItem">
                    <a href="${pageContext.request.contextPath }/board/list/${diary.dno }" class="portfolio-link">
                        <c:if test="${!empty diary.dpic }">
							<img alt="${diary.originalname }" src="${pageContext.request.contextPath }/display?filename=${diary.dpic }" class="img-responsive">
						</c:if>
						<c:if test="${empty diary.dpic }">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/empty-folder.png" class="img-responsive">
						</c:if>                        
                    </a>
                    <div class="portfolio-caption">
                        <h4>${diary.dtitle }</h4>
                        <p class="text-muted"></p>
                    </div>
                </div>
			</c:forEach>
		</c:if>
		<c:if test="${empty dList }">			
			<div class="col-sm-4 portfolio-item">
                   <a href="#">
                       <div class="caption">
                           <div class="caption-content">
                               <i class="fa fa-search-plus fa-3x"></i>
                           </div>
                       </div>
                       <img alt="" src="${pageContext.request.contextPath }/resources/dist/img/empty-folder.png" class="img-circle img-responsive">
                   </a>
                   <div class="portfolio-caption">
                       <h4></h4>
                       <p class="text-muted"> 등록된 다이어리가 없습니다. </p>
                   </div>
               </div>		
		</c:if>
       
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
<%@ include file="../include/footer2.jsp" %>
