<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>

<h1>Login Here</h1>
<div class="form-login">
	<form action="/login" method="post">
		<div class="standard-rectangle">
			<input type="text" name="userid" placeholder="ID">ID
		</div>
		<div class="standard-rectangle">
			<input type="password" name="pw" placeholder="Password">Password
		</div>
		<div>
			<input type="submit" class=>Login
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