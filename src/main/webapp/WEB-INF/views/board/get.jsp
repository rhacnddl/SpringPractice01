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
				<td><input type="text" name="writer" value="${pr.username }" readonly="readonly"></td>
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
			<button name="update">수정하기</button>
		</c:if>
	</form>
	<form class="form-default" action="/board/remove">
		<input type="hidden" value="${board.bno}" name="bno">
		<c:if test="${pr.username eq board.writer}">
			<button name="remove">삭제하기</button>
		</c:if>	
	</form>
</div>

<!-- 
<div class="form-default" align="center">
	<form action="/board/update" method="get">
		<div class="board-part">
			<label>Category</label>
			
			<c:if test="${division eq 100}">
				<input type="text" name="div" value="자유게시판" readonly="readonly">
			</c:if>
			<c:if test="${division eq 101}">
				<input type="text" name="div" value="인사게시판" readonly="readonly">
			</c:if>
		</div>
		<div class="board-part">
			<label>Board No.</label>
			<input type="text" name="bno" value="${board.bno}" readonly="readonly">
		</div>
		<div class="board-part">
			<label>Title</label>
			<input type="text" name="title" value="${board.title}" readonly="readonly">
		</div>
		<div class="board-part">
			<label>Content</label>
			<textarea rows="10" cols="30" readonly="readonly" name="content">${board.content}</textarea>
		</div>
		<div class="board-part">
			<label>Writer</label>
			<input type="text" name="writer" value="${pr.username }" readonly="readonly">
		</div>
		<div class="board-part">
			<label>Hit</label>
			<input type="text" name="hit" value="${board.hit}" readonly="readonly">
		</div>
		<div class="board-part">
			<label>Reg Date</label>
			<input type="text" name="regDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}"/>" readonly="readonly">
		</div>
		<div class="board-part">
			<label>Update Date</label>
			<input type="text" name="updateDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/>" readonly="readonly">
		</div>
	</form>
</div>
 -->
</body>
</html>