<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Send E-Mail</title>
</head>
<body>

<sec:authentication property="principal" var="pr"/>

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


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
});
</script>
</body>
</html>