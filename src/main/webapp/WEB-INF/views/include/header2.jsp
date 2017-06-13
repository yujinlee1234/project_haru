<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>당신의 하루</title>

    <!-- Bootstrap Core CSS -->
    <link href="${pageContext.request.contextPath }/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Theme CSS -->
    <link href="${pageContext.request.contextPath }/resources/css/freelancer.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath }/resources/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />

	<!-- Switch(Toggle radio/checkbox) CSS -->
	<link href="${pageContext.request.contextPath }/resources/css/bootstrap-switch.min.css" rel="stylesheet">
    
    <!-- Custom Fonts -->
    <link href="${pageContext.request.contextPath }/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
     <!-- jQuery -->
    <script src="${pageContext.request.contextPath }/resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="${pageContext.request.contextPath }/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Switch(Toggle radio/checkbox) JS -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap-switch.min.js"></script>
    <!-- Plugin JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>

    <!-- Contact Form JavaScript -->
    <script src="${pageContext.request.contextPath }/resources/js/jqBootstrapValidation.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/contact_me.js"></script>

    <!-- Theme JavaScript -->
    <script src="${pageContext.request.contextPath }/resources/js/freelancer.min.js"></script>
    <style type="text/css">
    	section.haru_section{height:740px; margin-top:100px; overflow: auto;}   	
    	.text-left{text-align: left !important;}
    	.text-right{text-align: right !important;}
    	#logo{width:30px; margin-left:10px; display: inline-block !important;}
    	
    </style>
    
</head>

<body id="page-top" class="index">
<div id="skipnav"><a href="#maincontent">Skip to main content</a></div>

    <!-- Navigation -->
    <nav id="mainNav" class="navbar navbar-default navbar-fixed-top navbar-custom">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand" href="${pageContext.request.contextPath }/">당신의 하루<img id="logo" src="${pageContext.request.contextPath }/resources/img/cherry-blossom.png"></a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li class="page-scroll">
                        <a href="${pageContext.request.contextPath }/diary/list.do">오늘의 일기</a>
                    </li>
                    <li class="page-scroll">
                        <a href="${pageContext.request.contextPath }/board/list.do">당신의 하루</a>
                    </li>
                    <li class="dropdown user user-menu">
		                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
		                	<c:if test="${!empty auth }">
		                		<c:if test="${!empty auth.upic }">
		                			<img src="${pageContext.request.contextPath }/display?filename=${auth.upic } class="user-image" alt="User Image"/>
		                		</c:if>
		                		<c:if test="${empty auth.upic }">
		                			<img src="${pageContext.request.contextPath }/resources/img/user.png" class="user-image" alt="User Image"/>
		                		</c:if>
		                  		<span class="hidden-xs">${auth.uid }님</span>
		                	</c:if>
		                  	<c:if test="${empty auth }">
		                  		<img src="${pageContext.request.contextPath }/resources/img/user.png" class="user-image" alt="User Image"/>
		                  		<span class="hidden-xs">로그인</span>
		                  	</c:if>
		                </a>
		                <ul class="dropdown-menu">
		                  <!-- User image -->
		                  <li class="user-header">
		                    <img src="${pageContext.request.contextPath }/resources/img/user2.png" class="img-circle" alt="User Image" />
		                    <c:if test="${!empty auth }">
		                    	<p>
			                      ${auth.uid }
			                    </p>
		                    </c:if>
		                    <c:if test="${empty auth }">
		                    	<p>
			                      	로그인이 필요합니다
			                    </p>
		                    </c:if>                    
		                  </li>
		                  <!-- Menu Footer-->
		                  <li class="user-footer">
		                    <c:if test="${empty auth }">
			                    <div class="pull-left">
			                      <a href="${pageContext.request.contextPath }/member/join" class="btn btn-default btn-flat">회원가입</a>
			                    </div>
			                    <div class="pull-right">
			                      <a href="${pageContext.request.contextPath }/member/login.do" class="btn btn-default btn-flat">로그인</a>
			                    </div>
		                    </c:if>
		                    <c:if test="${!empty auth }">
			                    <div class="pull-right">
			                      <a href="${pageContext.request.contextPath }/member/logout" class="btn btn-default btn-flat">로그아웃</a>
			                    </div>
		                    </c:if>
		                  </li>
		                </ul>
		              </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>