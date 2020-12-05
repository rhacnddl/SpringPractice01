<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Custom Logout</title>
</head>
<body>
<h1>Custom Logout</h1>

<div>
	<form action="/controller/customLogout" method="post">
		<input type="hidden" value="${_csrf.token }" name="${_csrf.parameterName }">
		<button>Logout</button>
	</form>
</div>
</body>
</html>