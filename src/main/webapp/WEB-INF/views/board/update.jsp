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
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="/resources/dist/css/styles.css" rel="stylesheet" />
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
<title>Board Update</title>
</head>
<body class="sb-nav-fixed">

<sec:authentication property="principal" var="pr"/>
<c:set var="bno" value="${board.bno}"/>
<c:set var="division" value="${board['div']}"/>

<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div align="center">
	<h1>Board Update</h1>
</div>

<div class="table-default" align="center">

	<form action="/board/list" method="get" id="actionForm">
		<input type="hidden" value="${division}" name="div">
		<input type="hidden" value="${p.page}" name="page">
		<input type="hidden" value="${p.amount}" name="amount">
	</form>
	
	<a class="go-to-list" href="#">이전</a>
	<form id="boardForm" action="/board/update" method="post" enctype="multipart/form-data">
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
		<button class="btn-submit">수정하기</button>
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
	<a class="go-to-list" href="#">이전</a>
</div>

<%@include file="/WEB-INF/views/includes/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/resources/dist/js/scripts.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
<script src="/resources/dist/assets/demo/datatables-demo.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	var bnoValue = ${board.bno};
	
	var boardForm = $("#boardForm");
	var actionForm = $("#actionForm");
	
	var key = '${p.key}';
	var type = '${p.type}';
	
	if(key != '' && type != '') {//검색처리 값이 있으면 액션폼에 추가
		var str = "<input type='hidden' value=" + key + " name='key'>" +
				  "<input type='hidden' value=" + type + " name='type'>";
		actionForm.append(str);
	}
	
	//목록 눌렀을 때
	$(".go-to-list").on("click", function(e){
		
		e.preventDefault();
		actionForm.submit();
	});
	
	//수정하기 눌렀을 때
	$(".btn-submit").on("click", function(e){
		
		e.preventDefault();
		var str = '<input type="hidden" value="${p.page}" name="page">' + 
				  '<input type="hidden" value="${p.amount}" name="amount">';
				  
		boardForm.append(str);
		boardForm.submit();
	});
	
});
</script>
</body>
</html>