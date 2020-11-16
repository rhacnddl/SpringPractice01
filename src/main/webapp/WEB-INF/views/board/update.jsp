<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.board-part-table{
	border:1px solid;
	border-collapse: collapse;
}
.board-part{
	border:1px solid;
}
.board-part-input{
	width:99%;
	border:0;
}
input:focus, textarea:focus{
	outline:none;
}
</style>
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
	<form action="/board/update" method="post" enctype="multipart/form-data">
		<table class="board-part-table">
			<tbody>
				<tr class="board-part">
					<th class="board-part">Category</th>
					<td class="board-part">
					<c:if test="${division eq 100}">
						<input type="text" value="자유게시판" readonly="readonly" class="board-part-input">
					</c:if>
					<c:if test="${division eq 101}">
						<input type="text" value="인사게시판" readonly="readonly" class="board-part-input">
					</c:if>
					</td>
				</tr>
				<tr class="board-part">
					<th class="board-part">Board No.</th>
					<td class="board-part"><input type="text" name="bno" value="${board.bno}" readonly="readonly" class="board-part-input"></td>
				</tr>
				<tr class="board-part">
					<th class="board-part">Title</th>
					<td class="board-part"><input type="text" name="title" value="${board.title}" class="board-part-input"></td>
				</tr>
				<tr class="board-part">
					<th class="board-part">Content</th>
					<td class="board-part"><textarea rows="4" cols="70" style="resize:none;" name="content" class="board-part-input">${board.content}</textarea></td>
				</tr>
				<tr  class="board-part">
					<th class="board-part">Hit</th>
					<td class="board-part"><input type="text" name="hit" value="${board.hit}" readonly="readonly" class="board-part-input"></td>
				</tr>
				<tr class="board-part">
					<th class="board-part">Writer</th>
					<td class="board-part"><input type="text" name="writer" value="${board.writer}" readonly="readonly" class="board-part-input"></td>
				</tr>
				<tr class="board-part">
					<th class="board-part">Write Date</th>
					<td class="board-part"><input type="text" class="board-part-input" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}"/>" readonly="readonly"></td>
				</tr>
				<tr class="board-part">
					<th class="board-part">Update Date</th>
					<td class="board-part"><input type="text" class="board-part-input" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/>" readonly="readonly"></td>
				</tr>
				<tr>
					<th class="board-part">File<th>
					<td class="board-part"><input type="file" class="board-part-input" name="uploadFile" multiple></td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<input type="hidden" name="div" value="${division}">
		<input type="submit" value="수정하기">
	</form>
</div>
<div align="center">
	<ul>
	<c:forEach items="${board.fileList}" var="f">
		<li>
		<a href="/board/download?uuid=${f.uuid}">${f.fileName}</a>
		<form action="/board/deleteFile" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<input type="hidden" name="uuid" value="${f.uuid}">
		<input type="hidden" name="bno" value="${board.bno}">
		<button type="submit">X</button>
		</form>
		</li>
	</c:forEach>
	</ul>
	
</div>
<div align="center">
	<a href="/board/get?bno=${bno}">이전</a>
</div>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	var bnoValue = ${board.bno};
	var arr = ${board.fileList};
	
	
});
</script>
</body>
</html>