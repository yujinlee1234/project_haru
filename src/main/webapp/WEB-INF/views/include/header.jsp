<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Haru</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.4 -->
    <link href="${pageContext.request.contextPath }/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons -->
    <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="${pageContext.request.contextPath }/resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="${pageContext.request.contextPath }/resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
  </head>
      <!-- jQuery 2.1.4 -->
    <script src="${pageContext.request.contextPath }/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    
  <body class="skin-blue sidebar-mini">
    <div class="wrapper">
      
      <header class="main-header">
        <!-- Logo -->
        <a href="${pageContext.request.contextPath }/board/list" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini"><b>Yu</b>jin</span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><b>Yujin</b> Photo</span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <!-- HEADER MENU CUSTOM 필요 -->
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- Messages: style can be found in dropdown.less-->
              <li class="dropdown messages-menu">
                <a href="${pageContext.request.contextPath }/board/add" title="사진 추가">
                  <img alt="" src="${pageContext.request.contextPath }/resources/dist/img/add.png" style="width:20px;">
                </a>
              </li>
              <!-- Notifications: style can be found in dropdown.less -->
              <li class="dropdown notifications-menu">
                <a href="${pageContext.request.contextPath }/board/list" title="사진 리스트 보기">
                  <img alt="" src="${pageContext.request.contextPath }/resources/dist/img/home.png" style="width:20px;">
                </a>
              </li>
              <!-- User Account: style can be found in dropdown.less -->
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                	<c:if test="${!empty auth }">
                		<img src="${pageContext.request.contextPath }/resources/dist/img/1571218602_B.jpg" class="user-image" alt="User Image"/>
                  		<span class="hidden-xs">${auth.uid }</span>
                	</c:if>
                  	<c:if test="${empty auth }">
                  		<img src="${pageContext.request.contextPath }/resources/dist/img/1571218602_B.jpg" class="user-image" alt="User Image"/>
                  		<span class="hidden-xs">로그인</span>
                  	</c:if>
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  <li class="user-header">
                    <img src="${pageContext.request.contextPath }/resources/dist/img/1571218602_B.jpg" class="img-circle" alt="User Image" />
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
	                      <a href="${pageContext.request.contextPath }/member/login" class="btn btn-default btn-flat">로그인</a>
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
              <!-- Control Sidebar Toggle Button -->
              <li>
                <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
              </li>
            </ul>
          </div>
        </nav>
      </header>
      <!-- Left side column. contains the logo and sidebar -->
      <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
          <!-- Sidebar user panel -->
          <div class="user-panel">
            <div class="pull-left image">
              <img src="${pageContext.request.contextPath }/resources/dist/img/1571218602_B.jpg" class="img-circle" alt="User Image" />
            </div>
            <div class="pull-left info">
            	<c:if test="${!empty auth }">
              		<p>${auth.uid }</p>
              		<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
              		 <c:if test="${!empty diary }">
		            	<a href="${pageContext.request.contextPath }/board/list">${diary.dtitle }</a>  		
		       		</c:if>
              	</c:if>
              	<c:if test="${empty auth }">
              		<br>
              		<a href="${pageContext.request.contextPath }/member/login"><i class="fa fa-circle text-fail"></i> Offline</a>
              	</c:if>              
            </div>
           
          </div>
        </section>
        <!-- /.sidebar -->
      </aside>

      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Haru
            <small>Preview</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Yujin</a></li>
            <li class="active">Photo</li>
          </ol>
        </section>