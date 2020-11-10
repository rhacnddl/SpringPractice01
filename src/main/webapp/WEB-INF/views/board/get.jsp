<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Get</title>
</head>
<body>

<sec:authentication property="principal" var="pr"/>
<c:set var="division" value='${board["div"]}'></c:set>

<div align="center">
	<h1>Board Get</h1>
</div>

<div class="table-default" align="center">

	<a href="/board/list?div=${division}">목록</a>
	<table>
		<tbody>
			<tr class="board-part">
				<th>Category</th>
				<td>
				<c:if test="${division eq 100}">
					<input type="text" name="div" value="자유게시판" readonly="readonly">
				</c:if>
				<c:if test="${division eq 101}">
					<input type="text" name="div" value="인사게시판" readonly="readonly">
				</c:if>
				</td>
			</tr>
			<tr class="board-part">
				<th>Board No.</th>
				<td><input type="text" name="bno" value="${board.bno}" readonly="readonly"></td>
			</tr>
			<tr class="board-part">
				<th>Title</th>
				<td><input type="text" name="title" value="${board.title}" readonly="readonly"></td>
				
				<th>Hit</th>
				<td><input type="text" name="hit" value="${board.hit}" readonly="readonly"></td>
			</tr>
			<tr class="board-part">
				<th>Content</th>
				<td><textarea rows="8" cols="60" name="content" readonly="readonly">${board.content}</textarea></td>
			</tr>
			<tr class="board-part">
				<th>Writer</th>
				<td><input type="text" name="writer" value="${board.writer}" readonly="readonly"></td>
			</tr>
			<tr class="board-part">
				<th>Write Date</th>
				<td><input type="text" name="regDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}"/>" readonly="readonly"></td>
			</tr>
			<tr class="board-part">
				<th>Update Date</th>
				<td><input type="text" name="updateDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/>" readonly="readonly"></td>
			</tr>
		</tbody>
	</table>
</div>
<div align="center">
	<a href="/board/list?div=${division}">목록</a>
	<form class="form-default" action="/board/update">
		<input type="hidden" name="bno" value="${board.bno}">
		<c:if test="${pr.username eq board.writer}">
			<button class="button-update">수정하기</button>
		</c:if>
	</form>
	<form class="form-default" action="/board/remove">
		<input type="hidden" value="${board.bno}" name="bno">
		<c:if test="${pr.username eq board.writer}">
			<button class="button-remove">삭제하기</button>
		</c:if>	
	</form>
</div>

<!-- 이하 댓글창 -->
<div class="reply-first-frame" align="center">
	<label>Reply</label>
	<div class="reply-second-frame">
		<div class="reply-write">
			<form class="form-reply-write" action="/reply/write" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<input type="text" name="content">
				<input type="hidden" name="writer" value="${pr.username}">
				<input type="hidden" name="bno" value="${board.bno}">
				<input type="submit" value="작성">
			</form>
		</div>
		<div class="reply-list">
			<table>
				<tbody>
					<c:forEach items="${reply}" var="r">
						<tr>
							<th>${r.writer} : </th>
							<td> ${r.content} / </td>
							<td> <fmt:formatDate value="${r.regDate}" pattern="yy-MM-dd"/> </td>
							<c:if test="${r.updateDate != null}">
								<td>/ <fmt:formatDate value="${r.updateDate}" pattern="yy-MM-dd"/> </td>
							</c:if>
							<c:if test="${r.writer == pr.username}">
								<td>
								<button name="modify" class="button-default">수정</button>
								<button name="remove" class="button-default">삭제</button>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
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