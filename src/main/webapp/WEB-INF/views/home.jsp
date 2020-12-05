<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Home</title>
<link href="/resources/dist/css/styles.css" rel="stylesheet" />
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>

<body class="sb-nav-fixed">

<sec:authentication property="principal" var="pr"/>
<%@include file="/WEB-INF/views/includes/header.jsp" %>

	<main>
        <div class="container-fluid">
            <h1 class="mt-4">HOME</h1>
            <div class="user-info">
				<sec:authentication property="principal.member.userid"/> 님 환영합니다.
		</div>
		<div class="logout">
			<form action="/customLogout" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<button type="submit" class="btn-primary">Logout</button>
			</form>
		</div>
	        <ol class="breadcrumb mb-4">
	            <li class="breadcrumb-item active">Categories</li>
	        </ol>
	        <div class="row">
	            <div class="col-xl-3 col-md-6">
	                <div class="card bg-primary text-white mb-4">
	                    <div class="card-body">자유게시판</div>
	                    <div class="card-footer d-flex align-items-center justify-content-between">
	                        <a class="small text-white stretched-link" href="/board/list?div=100">View Details</a>
	                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
	                    </div>
	                </div>
	            </div>
	            <div class="col-xl-3 col-md-6">
	                <div class="card bg-warning text-white mb-4">
	                    <div class="card-body">출석게시판</div>
	                    <div class="card-footer d-flex align-items-center justify-content-between">
	                        <a class="small text-white stretched-link" href="/board/list?div=101">View Details</a>
	                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
	                    </div>
	                </div>
	            </div>
	            <div class="col-xl-3 col-md-6">
	                <div class="card bg-success text-white mb-4">
	                    <div class="card-body">맛집게시판</div>
	                    <div class="card-footer d-flex align-items-center justify-content-between">
	                        <a class="small text-white stretched-link" href="/board/list?div=102">View Details</a>
	                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
	                    </div>
	                </div>
	            </div>
	            <div class="col-xl-3 col-md-6">
	                <div class="card bg-danger text-white mb-4">
	                    <div class="card-body">개인정보</div>
	                    <div class="card-footer d-flex align-items-center justify-content-between">
	                        <a class="small text-white stretched-link" href="/member/info?userid=${pr.username}">View Details</a>
	                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
	                    </div>
	                </div>
	            </div>
	            <div class="col-xl-3 col-md-6">
	                <div class="card bg-primary text-white mb-4">
	                    <div class="card-body">메일보내기</div>
	                    <div class="card-footer d-flex align-items-center justify-content-between">
	                        <a class="small text-white stretched-link" id="go-to-mail" href="/member/info?userid=${pr.username}">View Details</a>
	                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
	                    </div>
	                </div>
	            </div>
	            
			<sec:authorize access="hasRole('ADMIN')">
				<div class="col-xl-3 col-md-6">
	                <div class="card bg-warning text-white mb-4">
	                    <div class="card-body">멤버 권한 관리</div>
	                    <div class="card-footer d-flex align-items-center justify-content-between">
	                        <a class="small text-white stretched-link" href="/admin/grant">View Details</a>
	                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
	                    </div>
	                </div>
	            </div>
	        </sec:authorize>
	        <div class="col-xl-3 col-md-6">
	                <div class="card bg-success text-white mb-4">
	                    <div class="card-body">채팅</div>
	                    <div class="card-footer d-flex align-items-center justify-content-between">
	                        <a class="small text-white stretched-link" href="/chat">View Details</a>
	                        <div class="small text-white"><i class="fas fa-angle-right"></i></div>
	                    </div>
	                </div>
	            </div>
	        </div>
	       
	    </div><!-- </div class="container-fluid"> -->
	</main>

<%@include file="/WEB-INF/views/includes/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/resources/dist/js/scripts.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
<script src="/resources/dist/assets/demo/datatables-demo.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#go-to-mail").on("click", function(e){
		
		//e.preventDefault();
		$(this).attr('href', '/mail/send');
	});
});
</script>

</body>
</html>