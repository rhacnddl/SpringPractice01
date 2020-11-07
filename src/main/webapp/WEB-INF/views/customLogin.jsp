<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Custom Login</title>
</head>
<body>

<h1>Login Here</h1>
<div class="form-login">
	<form action="/login" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<div class="standard-rectangle">
			<label>ID</label>
			<input type="text" name="userid" placeholder="ID">
		</div>
		<div class="standard-rectangle">
			<label>Password</label>
			<input type="password" name="pw" placeholder="Password">
		</div>
		<div>
			<input type="submit" class="submit" value="Login">
			<a href="createAccount">Create Account</a>
		</div>
	</form>
</div>

<script type="text/javascript">
	$(document).ready(function(){
	
	});
</script>
</body>
</html>