<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Send E-Mail</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="/resources/dist/css/styles.css" rel="stylesheet" />
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">

<sec:authentication property="principal" var="pr"/>
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<h1>Send E-mail</h1>
<div class="form-email">
	<form action="/mail/send" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<div class="standard-rectangle">
			<label>수신자</label>
			<input type="text" name="to">
		</div>
		<div class="standard-rectangle">
			<label>메일 제목</label>
			<input type="text" name="subject">
		</div>
		<div class="standard-rectangle">
			<label>본문</label>
			<textarea rows="8" cols="60" name="text"></textarea>
		</div>
		<div class="standard-rectangle">
			<label>발신자</label>
			<input type="text" name="from">
		</div>
		<div>
			<input type="submit" class="submit" value="Submit">
		</div>
	</form>
</div>
<form action="/home">
	<button>이전페이지</button>
</form>


<%@include file="/WEB-INF/views/includes/footer.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script> -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/resources/dist/js/scripts.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
<script src="/resources/dist/assets/demo/datatables-demo.js"></script>
</body>
</html>