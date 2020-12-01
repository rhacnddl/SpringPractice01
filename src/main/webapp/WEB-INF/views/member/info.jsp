<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
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

<meta charset="utf-8" />
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

<%@include file="/WEB-INF/views/includes/footer.jsp" %>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/resources/dist/js/scripts.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
<script src="/resources/dist/assets/demo/datatables-demo.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
});
</script>

</body>
</html>