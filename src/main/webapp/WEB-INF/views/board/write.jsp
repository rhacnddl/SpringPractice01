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
	<form action="/board/write" method="post" enctype="multipart/form-data">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<div class="form-default">
			<label>Category</label>
			<select name="div">
				<option value="100" <c:if test="${division == 100}">selected="selected"</c:if>>자유게시판</option>
				<option value="101" <c:if test="${division == 101}">selected="selected"</c:if>>출석게시판</option>
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
		<!-- File Upload -->
		<div class="form-default">
			<input type="file" name="uploadFile" multiple="multiple">
		</div>
		<button>Submit</button>
	</form>
</div>
<div align="center">
	<a href="/board/list?div=${division}">목록</a>
</div>

</body>
</html>