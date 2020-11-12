<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>

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
		<li><a href="/board/list?div=100">자유게시판</a></li>
		<li><a href="/board/list?div=101">출석게시판</a></li>
	</ul>
</div>

</body>
</html>