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
.reply-part-table{}
input:focus, textarea:focus{
	outline:none;
}
</style>
</head>
<body>

<sec:authentication property="principal" var="pr"/>
<c:set var="division" value='${board["div"]}'></c:set>

<div align="center">
	<h1>Board Get</h1>
</div>
<!-- Board 정보 Part -->
<div class="table-default" align="center">

	<a href="/board/list?div=${division}">목록</a>
	<table class="board-part-table">
		<tbody>
			<tr class="board-part">
				<th class="board-part">Category</th>
				<td class="board-part">
				<c:if test="${division eq 100}">
					<input type="text" name="div" value="자유게시판" readonly="readonly" class="board-part-input">
				</c:if>
				<c:if test="${division eq 101}">
					<input type="text" name="div" value="인사게시판" readonly="readonly" class="board-part-input">
				</c:if>
				</td>
			</tr>
			<tr class="board-part">
				<th class="board-part">Board No.</th>
				<td class="board-part"><input type="text" class="board-part-input" name="bno" value="${board.bno}" readonly="readonly"></td>
			</tr>
			<tr class="board-part">
				<th class="board-part">Title</th>
				<td class="board-part"><input type="text" class="board-part-input" name="title" value="${board.title}" readonly="readonly"></td>
			</tr>
			<tr class="board-part">
				<th class="board-part">Content</th>
				<td class="board-part"><textarea rows="4" cols="70" style="resize:none;height:99%;" class="board-part-input" name="content" readonly="readonly">${board.content}</textarea></td>
			</tr>
			<tr class="board-part">
				<th class="board-part">Hit</th>
				<td class="board-part"><input type="text" class="board-part-input" name="hit" value="${board.hit}" readonly="readonly"></td>
			</tr>
			<tr class="board-part">
				<th class="board-part">Writer</th>
				<td class="board-part"><input type="text" class="board-part-input" name="writer" value="${board.writer}" readonly="readonly"></td>
			</tr>
			<tr class="board-part">
				<th class="board-part">Write Date</th>
				<td class="board-part"><input type="text" class="board-part-input" name="regDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}"/>" readonly="readonly"></td>
			</tr>
			<tr class="board-part-tr">
				<th class="board-part">Update Date</th>
				<td class="board-part"><input type="text" class="board-part-input" name="updateDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/>" readonly="readonly"></td>
			</tr>
		</tbody>
	</table>
</div>
<!-- Board 정보 Part -->
<!-- File Part -->
<div align="center">
	<ul>
		<c:forEach items="${file}" var="f">
		<li><a href="/board/download?uuid=${f.uuid}">${f.fileName}</a></li>
		</c:forEach>
	</ul>
</div>
<!-- File Part -->
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
	<div class="reply-second-frame" style="border:3px solid">
		<!-- 댓글 작성 div -->
		<div class="reply-write">
			<form class="form-reply-write" action="/reply/write" method="post">
				<input type="text" name="content">
				
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<input type="hidden" name="writer" value="${pr.username}">
				<input type="hidden" name="bno" value="${board.bno}">
				<button type="submit">작성</button>
			</form>
		</div>
		<!-- 댓글 작성 div -->
		<!-- 댓글 리스트 div -->
		<div class="reply-list">
			<table>
				<tbody>
					<c:forEach items="${reply}" var="r">
						<c:if test="${r.r_rno == null || r.r_rno == 0}">
						<tr>
							<th>${r.writer} </th>
							<td> : ${r.content}  </td>
							<td> / <fmt:formatDate value="${r.regDate}" pattern="yy-MM-dd HH:mm:ss"/> </td>
							<c:if test="${r.updateDate != null}">
								<td> / <fmt:formatDate value="${r.updateDate}" pattern="yy-MM-dd HH:mm:ss"/> </td>
							</c:if>
								
								<td>
								<button name="r_reply" class="button-default">답글</button>
								<c:if test="${r.writer == pr.username}">
									<button name="modify" class="button-default">수정</button>
									<button name="remove" class="button-default">삭제</button>
								</c:if>
								</td>
						</tr>
						</c:if>
						<!-- 대댓글 부분 -->
						<c:forEach var="r_r" items="${reply}">
							<c:if test="${r_r.r_rno == r.rno}">
								<tr>
									<th>${r.writer} <- ${r_r.writer}</th>
									<td> : ${r_r.content}  </td>
									<td> / <fmt:formatDate value="${r_r.regDate}" pattern="yy-MM-dd HH:mm:ss"/> </td>
									<c:if test="${r.updateDate != null}">
										<td> / <fmt:formatDate value="${r_r.updateDate}" pattern="yy-MM-dd HH:mm:ss"/> </td>
									</c:if>
										
									<td>
									<c:if test="${r_r.writer == pr.username}">
										<button name="modify" class="button-default">수정</button>
										<button name="remove" class="button-default">삭제</button>
									</c:if>
									</td>
								</tr>
							</c:if>
						</c:forEach>
						
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- 댓글 리스트 div -->
	</div>
</div>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	var bnoValue = ${board.bno};
	
	$("button[name='r_reply']").on("click", function(e){
		
		
		
	});
	
});
</script>

</body>
</html>