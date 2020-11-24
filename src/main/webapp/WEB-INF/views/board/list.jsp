<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board List</title>
</head>
<body>

<sec:authentication property="principal" var="pr"/>

<c:if test="${divis == 100}">
	<div align="left">
		<h2>자유게시판</h2>
	</div>
</c:if>
<c:if test="${divis == 101}">
	<div align="left">
		<h2>출석게시판</h2>
	</div>
</c:if>
		<div align="center">
			<form action="viewList">
				<select>
					<option selected>제목</option>
				</select>
				<input type="text" name="query">
				<input type="submit" value="검색"/>
			</form>
		</div>
		
		<div class="button-default" align="center">
			<a href="/board/write?div=${divis}">게시글 작성</a>
		</div>
		<div>
		<table border="1" width="700" height = "130" align="center" style="border-collapse: collapse;">
			<tr bgcolor="yellow" align="center">
				<th>No.</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일자</th>
				<th>조회수</th>
			</tr>
			
			<c:forEach var="list" items="${list}">
			<fmt:formatDate var="dateTempParse" pattern="yyyy-MM-dd" value="${list.regDate}"/>
				<tr><!-- 첫번째 줄 시작 -->
			    <td align="center">${list.bno}</td>
			<!-- 제목 옆 댓글 수 -->
		    	<td align="center"><a href="/board/get?bno=${list.bno}"> ${list.title}</a>
		    		<c:if test="${list.reply_Cnt > 0}">
		    		<b style="color: red;">[${list.reply_Cnt}]</b>
		    		</c:if>
		    	</td>
		    	<td align="center">${list.writer}</td>
		    	<td align="center">${dateTempParse}</td>
		    	<td align="center">${list.hit}</td>
				</tr><!-- 첫번째 줄 끝 -->
			</c:forEach>
	    </table>
    </div>
   
    <div align="center">
    	<a href="/home">이전페이지</a>
    </div>

</body>
</html>