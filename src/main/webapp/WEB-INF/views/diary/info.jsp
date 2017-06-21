<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	table.user_table{ width:100%; margin-top: 50px; font-size: 14px;}
	table.user_table th { padding:20px;}
	table.user_table td{padding:20px;}
	table.user_table td.btns{padding-top:30px !important;width:20%;} 
	table.user_table th{width:40%; text-align: right;}
	table.user_table td img{width:150px; height:150px;}
	#uPassForm, #pass2{display: none;}
	
	table.user_table td.btns span{display: none;}
	
	.empty-diary{margin-top: 100px;}
	.empty-diary img{margin-bottom: 30px; width:80px;}
	.empty-diary a.btn{margin-top: 25px;}
	
</style>
<section class="content haru_section">
	<div class="row">
		<div class="col-md-6 col-md-offset-3" >
			<div class="box">
				<div class="box-header text-center">
					<h3>다이어리 정보</h3>
					<hr class="star-primary">
				</div>
			</div>
			<div class="box">
				<div class="box-body">		
					<c:if test="${!empty diary }">			
						<table style="width:100%;" class="user_table table">
							<tr>
								<td colspan="3" class="text-center">
									<c:if test="${!empty diary.dpic }">
										<img alt="" src="${pageContext.request.contextPath }/display?filename=${diary.originalname}">
									</c:if>
									<c:if test="${empty diary.dpic }">
										<img alt="" src="${pageContext.request.contextPath }/resources/img/book-with-bookmark.png">
									</c:if>
								</td>
							</tr>
							<tr>
								<th>다이어리 이름</th>
								<td colspan="2">${diary.dtitle }</td>
							</tr>
							<tr>
								<th>다이어리 공개 여부</th>
								<td colspan="2"><b>${diary.dopen==true?"공개":"비공개" }</b></td>
							</tr>
							<tr>
								<th>다이어리 생성 날짜</th>
								<td colspan="2">${diary.dDateForm }</td>
							</tr>
							<tr>
								<td colspan="3" class="text-center btns">
									<a href="${pageContext.request.contextPath }/board/list.do" class='btn btn-success'>다이어리 보기</a>
									<a href="${pageContext.request.contextPath }/diary/mod.do" class='btn btn-primary'>다이어리 수정</a>
									<button class='btn btn-warning' id="btnDel">다이어리 삭제</button>
								</td>
							</tr>
						</table>
					</c:if>
					<c:if test="${empty diary }">
						<div class="text-center empty-diary">
							<img alt="" src="${pageContext.request.contextPath }/resources/img/cherry-blossom_b.png">
							<p>다이어리가 존재하지 않습니다.</p>
							<a href="${pageContext.request.contextPath }/diary/add.do" class="btn btn-primary">다이어리 생성하기</a>
						</div>
					</c:if>
				</div>
			</div>
		</div>		
	</div>
	<form name="delForm" action="${pageContext.request.contextPath }/diary/del" method="post">
		<input type="hidden" name="dno" value="${diary.dno }">
	</form>
	<script>
		$("#btnDel").click(function(){
			if(confirm("다이어리를 삭제하시면 등록한 일기들이 모두 삭제됩니다.\n 다이어리 삭제를 진행하시겠습니까?")==true){
				$("form[name='delForm']").submit();
			}
		});
	</script>
</section>
<%@ include file="../include/footer2.jsp" %>