<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member's Personal Info</title>
<style type="text/css">
.board-part-table{
	border:1px solid;
	border-collapse: collapse;
	
}
.board-part{
	border:1px solid;
	
}
.board-part-input{
	width:98%;
	border:0;
}
.reply-part-table{}
input:focus, textarea:focus{
	outline:none;
}
</style>
</head>
<body>

<sec:authentication property="principal" var="pr"/>

<div align="center">
	<h1>Member's Personal Info</h1>
</div>

<div class="table-default" align="center">

	<a href="/home">이전페이지</a>
	<form action="/member/info" method="post">
		<table class="board-part-table">
			<tbody>
				<tr class="board-part">
					<th class="board-part">User ID</th>
					<td class="board-part"><input type="text" class="board-part-input" name="userid" value="${member.userid}"></td>
				</tr>
				<tr class="board-part">
					<th class="board-part">User Name</th>
					<td class="board-part"><input type="text" class="board-part-input" name="username" value="${member.username}"></td>
				</tr>
				<tr class="board-part">
					<th class="board-part">Reg Date</th>
					<td class="board-part"><input type="text" class="board-part-input" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${member.regDate}"/>" readonly="readonly" style="font-weight:bold;"></td>
				</tr>
				<tr class="board-part-tr">
					<th class="board-part">E-mail</th>
					<td class="board-part"><input type="text" class="board-part-input" name="email" value="${member.email}"></td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<sec:authorize access="${pr.username == member.userid}">
		<input type="submit" value="변경">
		</sec:authorize>
	</form>
</div>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
});
</script>

</body>
</html>