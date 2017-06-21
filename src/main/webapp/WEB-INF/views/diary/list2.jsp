<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	div.pItem{width:200px; display:inline-block; margin: 10px;}
	.pItem .pCheck{display: none; float: left;}
	.pItem p{text-align: right;padding-right: 22px;}
	.pItem img{width: 90px; height: 90px; margin: 0 auto !important;}
	.pItem portfolio-caption{text-align: center;}
	div#noItem figure{width: 100%; text-align: center;}
	#delBtn{display: none;}
	#cancelBtn{display: none;}	
	section{padding: 15px;}
	div#diary-box{margin-top: 20px;}
</style>
<section class="haru_section">
	<div class="row">
		<div class="col-lg-8 col-lg-offset-2 text-center">
			<div class="box">
				<div class="box-header text-center">
					<h3>오늘의 일기</h3>
					<hr class="star-primary">
				</div>
			</div>
			<div class="box" id="diary-box">
				<c:if test="${!empty dList }">
					<c:forEach items="${dList }" var="diary">
						<div class="portfolio-item pItem text-center">
							<a
								href="${pageContext.request.contextPath }/board/list/${diary.dno }"
								class="portfolio-link"> <c:if test="${!empty diary.dpic }">
									<img alt="${diary.originalname }"
										src="${pageContext.request.contextPath }/display?filename=${diary.originalname }"
										class="img-responsive">
								</c:if> <c:if test="${empty diary.dpic }">
									<img alt=""
										src="${pageContext.request.contextPath }/resources/img/book-with-bookmark.png"
										class="img-responsive">
								</c:if>
							</a>
							<div class="portfolio-caption">
								<h4>${diary.dtitle }<br>
									<small class="uids">${diary.uid }님</small>
								</h4>
								<p class="text-muted"></p>
							</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${empty dList }">
					<div class="col-sm-4 portfolio-item text-center">
						<a href="#">
							<div class="caption">
								<div class="caption-content">
									<i class="fa fa-search-plus fa-3x"></i>
								</div>
							</div> <img alt=""
							src="${pageContext.request.contextPath }/resources/dist/img/book-with-bookmark.png"
							class="img-circle img-responsive">
						</a>
						<div class="portfolio-caption">
							<h4></h4>
							<p class="text-muted">등록된 다이어리가 없습니다.</p>
						</div>
					</div>
				</c:if>
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
		var $ids = $(".uids");
		var myID = "${auth.uid}";
		if(typeof $ids != "undefined"){
			for(var i=0;i<$ids.length; i++){
				var $id = $ids[i];
				var thatID = $id.innerHTML;
				console.log(thatID.substring(0, thatID.length-1));
				if(thatID.substring(0, thatID.length-1)==myID){
					$id.innerHTML = "(내 다이어리)";
				}
			}
		} 
	});//ready
</script>
<%@ include file="../include/footer2.jsp" %>
