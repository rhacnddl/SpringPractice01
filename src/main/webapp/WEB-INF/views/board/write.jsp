<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Write</title>
</head>
<body>

<sec:authentication var="writer" property='principal.username'/>

<div class="form-board-write" align="center">
	<form action="/board/write" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<div class="form-default">
			<label>Category</label>
			<select name="div">
				<option value="100" selected="selected">자유게시판</option>
				<option value="101">인사게시판</option>
			</select>
		</div>
		<div class="form-default">
			<label>Title</label>
			<input type="text" name="title">
		</div>
		<div class="form-default">
			<label>Content</label>
			<div>
				<textarea rows="10" cols="10" name="content"></textarea>
			</div>
		</div>
		<div class="form-default">
			<label>Writer</label>
			<input name="writer" value="${writer}" readonly="readonly">
		</div>
		<button>Submit</button>
	</form>
</div>

</body>
</html>