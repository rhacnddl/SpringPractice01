<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>

<h1>Create Account</h1>
<div class="form-login">
	<form action="/createAccount" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<div class="standard-rectangle">
			<label>ID</label>
			<input type="text" name="userid" placeholder="ID">
		</div>
		<div class="standard-rectangle">
			<label>Password</label>
			<input type="password" name="pw" placeholder="Password">
		</div>
		<div class="standard-rectangle">
			<label>Name</label>
			<input type="text" name="username" placeholder="Name">
		</div>
		<div class="standard-rectangle">
			<label>E-mail</label>
			<input type="text" name="email" placeholder="E-mail">
		</div>
		<div>
			<input type="submit" class="submit" value="Submit">
		</div>
	</form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
});
</script>
</body>
</html>