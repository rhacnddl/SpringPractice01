<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Board List</title>
<link href="/resources/dist/css/styles.css" rel="stylesheet" />
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">

<sec:authentication property="principal" var="pr"/>

<%@include file="/WEB-INF/views/includes/header.jsp" %>

<main>

	<form action="/board/list" method="get" id="actionForm">
    	<input type="hidden" name="div" value="${divis}">
    	<input type="hidden" name="page" value="${pageMaker.p.page}">
    	<input type="hidden" name="amount" value="${pageMaker.p.amount}">
    </form>
    
    <div class="container-fluid">
    <c:if test="${divis == 100}">
		<div align="left">
			<h1 class="mt-4">자유게시판</h1>
		</div>
	</c:if>
	<c:if test="${divis == 101}">
		<div align="left">
			<h1 class="mt-4">출석게시판</h1>
		</div>
	</c:if>
	<c:if test="${divis == 102}">
		<div align="left">
			<h1 class="mt-4">맛집게시판</h1>
		</div>
	</c:if>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="/home">Home</a></li>
            <li class="breadcrumb-item active">Tables</li>
        </ol>
		<div class="card mb-4">
            <div class="card-body">
            ===
                <a href="/home">Return Home</a>===
                .
            </div>
        </div>
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-table mr-1"></i>
                Board List
                <a align="left" href="/board/write?div=${divis}" class="btn btn-primary">게시글 작성</a>
            </div>
				
            <form id="searchForm" action="/board/list?">
				<select name="amount">
					<option value="10">10개씩</option>
					<option value="15">15개씩</option>
				</select>
				<select name="type">
					<option value=""></option>
					<option value="T">제목</option>
					<option value="C">내용</option>
					<option value="W">작성자</option>
					<option value="TC">제목+내용</option>
					<option value="TW">제목+작성자</option>
					<option value="CW">내용+작성자</option>
					<option value="TCW">제목+내용+작성자</option>
				</select>
				<input type="hidden" name="div" value="${divis}">
				<input type="text" name="key">
				<button type="submit" class="btn btn-primary"><i class="fas fa-search"></i></button>
			</form>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered"  width="100%" cellspacing="0">
                        <thead>
                            <tr>
                            	<th>No.</th>
                                <th>Title</th>
                                <th>Writer</th>
                                <th>Register Date</th>
                                <th>Hits</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="notice" items="${notice}">
							<fmt:formatDate var="dateTempParse" pattern="yyyy-MM-dd" value="${notice.regDate}"/>
							<tr>
						    <td align="center">${notice.bno}</td>
					    	<td align="center"><b><a class="move" href="${notice.bno}" style="color:magenta">[공지]${notice.title}</a></b>
					    		<c:if test="${notice.cnt > 0}">
					    		<b style="color: red;">[${notice.cnt}]</b>
					    		</c:if>
					    	</td>
					    	<td align="center">${notice.writer}</td>
					    	<td align="center">${dateTempParse}</td>
					    	<td align="center">${notice.hit}</td>
							</tr>
							</c:forEach>
							
							<c:forEach var="list" items="${list}">
							<fmt:formatDate var="dateTempParse" pattern="yyyy-MM-dd" value="${list.regDate}"/>
								<tr><!-- 첫번째 줄 시작 -->
							    <td align="center">${list.bno}</td>
								<!-- 제목 옆 댓글 수 -->
						    	<td align="center"><a class="move" href="${list.bno}">${list.title}</a>
						    		<c:if test="${list.cnt > 0}">
						    		<b style="color: red;">[${list.cnt}]</b>
						    		</c:if>
						    	</td>
						    	<td align="center">${list.writer}</td>
						    	<td align="center">${dateTempParse}</td>
						    	<td align="center">${list.hit}</td>
								</tr><!-- 첫번째 줄 끝 -->
							</c:forEach>
                        </tbody>
                    </table>
                    <!-- Pager 부분 -->
				    <div class="pager-first">
				    	<ul class="pagination">
				    		<!-- [이전] -->
				    		<c:if test="${pageMaker.prev}">
				    			<li class="paginate_btn_prev"><a href="${pageMaker.startPage - 1}" class="page-link">Prev</a></li>
				    		</c:if>
				    		
				    		<!-- [페이저] -->
				    		<c:forEach var="n" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					    		<c:if test="${n == pageMaker.p.page}"><c:set var="color" value="style='color:orange;'"/></c:if>
					    		<c:if test="${n != pageMaker.p.page}"><c:set var="color" value=""/></c:if>
					    		
				    			<li class="paginate_btn"><a ${color} href="${n}" class="page-link">[${n}]</a></li>
				    		</c:forEach>
				    		
				    		<!-- [다음] -->
				    		<c:if test="${pageMaker.next}">
				    			<li class="paginate_btn_next"><a href="${pageMaker.endPage + 1}" class="page-link">Next</a></li>
				    		</c:if>
				    	</ul>
				    </div>
				    <!-- Pager 부분 -->
                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="/WEB-INF/views/includes/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/resources/dist/js/scripts.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
<script src="/resources/dist/assets/demo/datatables-demo.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	var actionForm = $("#actionForm");
	
	//검색 처리의 key와 type 처리
	var key = '${pageMaker.p.key}';
	var type = '${pageMaker.p.type}';
	
    if(key != '' && type != '') {//검색처리 값이 있으면 액션폼에 추가
		var str = "<input type='hidden' value=" + key + " name='key'>" +
				  "<input type='hidden' value=" + type + " name='type'>";
		actionForm.append(str);
	}
	
	$("input[name='key']").val(key);

	     if(type == 'T') {$("option[value='T']").attr("selected", true);} 
	else if(type == 'C') {$("option[value='C']").attr("selected", true);}
	else if(type == 'W') {$("option[value='W']").attr("selected", true);}
	else if(type == 'TC') {$("option[value='TC']").attr("selected", true);}
	else if(type == 'TW') {$("option[value='TW']").attr("selected", true);}
	else if(type == 'CW') {$("option[value='CW']").attr("selected", true);}
	else if(type == 'TCW') {$("option[value='TCW']").attr("selected", true);}
	
   
	     
	//amount == 10? 10개씩 selected:15개씩 selected
	var amount = ${pageMaker.p.amount};
	
	if(amount == 10) {
		$("option[value='10']").attr('selected', true);
		$("option[value='15']").attr('selected', false);
	}
	else {
		$("option[value='10']").attr('selected', false);
		$("option[value='15']").attr('selected', true);
	}
	
	//페이저 [1][2][3][4][5]...Click --> 리스트 페이지 이동
	$(".paginate_btn").on("click", function(e){
		
		e.preventDefault();
		
		actionForm.find("input[name='page']").val($(this).find('a').attr('href'));
		
		
		
		actionForm.submit();
	});
	
	//게시물의 Title 클릭 -> 게시물 상세페이지
	$(".move").on("click", function(e){
		
		var bnoValue = $(this).attr('href');
		var str = '<input type="hidden" name="bno" value="' + bnoValue + '">';
		
		e.preventDefault();
		actionForm.append(str);
		actionForm.attr("action", "/board/get");
		actionForm.submit();
	});
	
	//prev 버튼 Click
	$(".paginate_btn_prev").on("click", function(e){
		
		e.preventDefault();
		actionForm.find("input[name='page']").val($(this).find('a').attr('href'));
		actionForm.submit();
	});
	//next 버튼 Click
	$(".paginate_btn_next").on("click", function(e){
		
		e.preventDefault();
		actionForm.find("input[name='page']").val($(this).find('a').attr('href'));
		actionForm.submit();
	});
	
});
</script>
</body>
</html>