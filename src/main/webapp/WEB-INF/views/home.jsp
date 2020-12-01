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

<h1>HOME</h1>
<div class="user-info">
	<sec:authentication property="principal.member.userid"/> 님 환영합니다.
</div>
<div class="logout">
	<form action="/customLogout" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<button type="submit">Logout</button>
	</form>
</div>
<div class="home-list">
	<ul>
		<sec:authorize access="hasRole('ADMIN')">
		<li><a href="/admin/grant">멤버 권한 관리</a></li>
		</sec:authorize>
		<li><a href="/member/info?userid=${pr.username}">개인정보</a></li>
	</ul>
	<ul>
		<li><a href="/board/list?div=100">자유게시판</a></li>
		<li><a href="/board/list?div=101">출석게시판</a></li>
		<li><a href="/board/list?div=102">맛집게시판</a></li>
	</ul>
	<ul>
		<li><a id="go-to-mail" href="#">메일보내기</a></li>
	</ul>
</div>

<%@include file="/WEB-INF/views/includes/footer.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script> -->
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