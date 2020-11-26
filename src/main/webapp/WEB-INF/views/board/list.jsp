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
<c:if test="${divis == 102}">
	<div align="left">
		<h2>맛집게시판</h2>
	</div>
</c:if>

		<div align="center">
			<form action="/board/list?div=${divis}">
				<select name="category">
					<option selected>제목</option>
				</select>
				<input type="hidden" name="div" value="${divis}">
				<input type="text" name="keyword">
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
		    		<c:if test="${list.cnt > 0}">
		    		<b style="color: red;">[${list.cnt}]</b>
		    		</c:if>
		    	</td>
		    	<td align="center">${list.writer}</td>
		    	<td align="center">${dateTempParse}</td>
		    	<td align="center">${list.hit}</td>
				</tr><!-- 첫번째 줄 끝 -->
			</c:forEach>
	    </table>
	     <!-- Pager 부분 -->
	    <div class="pager-first">
	    	<ul class="pagination">
	    		<!-- [이전] -->
	    		<c:if test="${pageMaker.prev}">
	    			<li class="paginate_btn_prev"><a href="#">Prev</a></li>
	    		</c:if>
	    		
	    		<c:forEach var="n" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
	    			<li class="paginate_btn"><a href="/board/list?div=${divis}&page=${n}">${n}</a></li>
	    		</c:forEach>
	    		
	    		<!-- [다음] -->
	    		<c:if test="${pageMaker.next}">
	    			<li class="paginate_btn_prev"><a href="#">Next</a></li>
	    		</c:if>
	    	</ul>
	    </div>
	    <!-- Pager 부분 -->
    </div>
   
   
    <div align="center">
    	<a href="/home">이전페이지</a>
    </div>

</body>
</html>