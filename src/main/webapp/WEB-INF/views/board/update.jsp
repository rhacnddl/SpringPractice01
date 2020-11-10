<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Update</title>
</head>
<body>

<sec:authentication property="principal" var="pr"/>
<c:set var="bno" value="${board.bno}"/>
<c:set var="division" value="${board['div']}"/>

<div align="center">
	<h1>Board Update</h1>
</div>

<div class="table-default" align="center">
	<a href="/board/get?bno=${bno}">이전</a>
	<form action="/board/update" method="post">
		<table>
			<tbody>
				<tr class="board-part">
					<th>Category</th>
					<td>
					<c:if test="${division eq 100}">
						<input type="text" value="자유게시판" readonly="readonly">
					</c:if>
					<c:if test="${division eq 101}">
						<input type="text" value="인사게시판" readonly="readonly">
					</c:if>
					</td>
				</tr> -
				<tr class="board-part">
					<th>Board No.</th>
					<td><input type="text" name="bno" value="${board.bno}" readonly="readonly"></td>
				</tr>
				<tr class="board-part">
					<th>Title</th>
					<td><input type="text" name="title" value="${board.title}"></td>
					
					<th>Hit</th>
					<td><input type="text" name="hit" value="${board.hit}" readonly="readonly"></td>
				</tr>
				<tr class="board-part">
					<th>Content</th>
					<td><textarea rows="8" cols="60" name="content">${board.content}</textarea></td>
				</tr>
				<tr class="board-part">
					<th>Writer</th>
					<td><input type="text" name="writer" value="${board.writer}" readonly="readonly"></td>
				</tr>
				<tr class="board-part">
					<th>Write Date</th>
					<td><input type="text" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}"/>" readonly="readonly"></td>
				</tr>
				<tr class="board-part">
					<th>Update Date</th>
					<td><input type="text" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/>" readonly="readonly"></td>
				</tr>
				<tr>
					<td><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"></td>
					<td><input type="hidden" name="div" value="${division}">
				</tr>
			</tbody>
		</table>
		<input type="submit" value="수정하기">
	</form>
</div>
<div align="center">
	<a href="/board/get?bno=${bno}">이전</a>
</div>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	var bnoValue = ${board.bno};
	
});
</script>
</body>
</html>