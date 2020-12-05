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
.board-part-input{
	width:99%;
	border:0;
}
.reply-part-table{}
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
</head>
<body class="sb-nav-fixed">

<sec:authentication property="principal" var="pr"/>
<c:set var="division" value='${board["div"]}'></c:set>

<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div align="center">
	<h1>Board Get</h1>
</div>
<!-- Board 정보 Part -->
<div class="table-default" align="center">

	<form action="/board/list" method="get" id="actionForm">
		<input type="hidden" value="${division}" name="div">
		<input type="hidden" value="${p.page}" name="page">
		<input type="hidden" value="${p.amount}" name="amount">
	</form>
	<a class="go-to-list" href="#">목록</a>
	<div align="center">
		<c:if test="${not empty next}">
			<button class="btn-next">다음 글</button>
		</c:if>
		<c:if test="${not empty prev}">
			<button class="btn-prev">이전 글</button>
		</c:if>
	</div>
	
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<th scope="row">Category</th>
				<td>
				<c:if test="${division eq 100}">
					<input type="text" name="div" value="자유게시판" readonly="readonly" class="board-part-input">
				</c:if>
				<c:if test="${division eq 101}">
					<input type="text" name="div" value="인사게시판" readonly="readonly" class="board-part-input">
				</c:if>
				<c:if test="${division eq 102}">
					<input type="text" name="div" value="맛집게시판" readonly="readonly" class="board-part-input">
				</c:if>
				</td>
			</tr>
			<tr>
				<th scope="row">Board No.</th>
				<td><input type="text" class="board-part-input" name="bno" value="${board.bno}" readonly="readonly"></td>
			</tr>
			<tr>
				<th scope="row">Title</th>
				<td><input type="text" class="board-part-input" name="title" value="${board.title}" readonly="readonly"></td>
			</tr>
			<tr>
				<th scope="row">Content</th>
				<td>
					<textarea rows="4" cols="70" style="resize:none;height:99%;" class="board-part-input" name="content" readonly="readonly">${board.content}</textarea>
					<c:if test="${not empty map}">
						<div id="staticMap" style="width:600px;height:350px;"></div> 
					</c:if>
				</td>
			</tr>
			<tr>
				<th scope="row">Hit</th>
				<td><input type="text" class="board-part-input" name="hit" value="${board.hit}" readonly="readonly"></td>
			</tr>
			<tr>
				<th scope="row">Writer</th>
				<td><input type="text" class="board-part-input" name="writer" value="${board.writer}" readonly="readonly"></td>
			</tr>
			<tr>
				<th scope="row">Write Date</th>
				<td><input type="text" class="board-part-input" name="regDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}"/>" readonly="readonly"></td>
			</tr>
			<tr class="board-part-tr">
				<th scope="row">Update Date</th>
				<td><input type="text" class="board-part-input" name="updateDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/>" readonly="readonly"></td>
			</tr>
		</tbody>
	</table>
</div>
<!-- Board 정보 Part -->
<!-- File Part -->
<div align="center">
	<ul>
		<c:forEach items="${board.fileList}" var="f">
		<li>
		<a href="/board/download?uuid=${f.uuid}">${f.fileName}</a>
		</li>
		</c:forEach>
	</ul>
</div>
<!-- File Part -->
<div class="row">
	<div class="col"></div>
	<div class="col">
		<a class="go-to-list" href="#">목록</a>
	<c:if test="${pr.username eq board.writer}">
		<button class="btn-update btn-primary">수정하기</button>
	</c:if>
	<c:if test="${pr.username eq board.writer}">
		<button class="btn-remove btn-primary">삭제하기</button>
	</c:if>	
	</div>
	<div class="col"></div>
</div>
<script type="text/javascript">
	<!-- -->
</script>
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
			<table class="table table-bordered table-striped">
				<tbody>
					<c:forEach items="${reply}" var="r">
						<c:if test="${r.r_rno == null || r.r_rno == 0}">
						<tr>
							<th scope="row">${r.writer} </th>
							<td><input type="text" class="reply_content" value="${r.content}" readonly>  </td>
							<td> / <fmt:formatDate value="${r.regDate}" pattern="yy-MM-dd HH:mm:ss"/> </td>
							<c:if test="${r.updateDate != null}">
								<td> / <fmt:formatDate value="${r.updateDate}" pattern="yy-MM-dd HH:mm:ss"/> </td>
							</c:if>
								
								<td>
								<input type="hidden" class="reply_rno" value="${r.rno}">
								<button name="r_reply" class="btn-reply-r_reply">답글</button>
								<c:if test="${r.writer == pr.username}">
									<button name="modify" class="btn-reply-update">수정</button>
									<button name="remove" class="btn-reply-remove">삭제</button>
									<input type="hidden" name="update" value="send">
									<input type="hidden" name="originalContent" value="${r.content}">
								</c:if>
								</td>
						</tr>
						</c:if>
						<tr id="tr-r_reply">
							
						</tr>
						<!-- 대댓글 부분 -->
						<c:forEach var="r_r" items="${reply}">
							<c:if test="${r_r.r_rno == r.rno}">
								<tr>
									<th scope="row">${r.writer} <- ${r_r.writer}</th>
									<td><input type="text" class="reply_content" value="${r_r.content}" readonly>  </td>
									<td> / <fmt:formatDate value="${r_r.regDate}" pattern="yy-MM-dd HH:mm:ss"/> </td>
									<c:if test="${r_r.updateDate != null}">
										<td> / <fmt:formatDate value="${r_r.updateDate}" pattern="yy-MM-dd HH:mm:ss"/> </td>
									</c:if>
										
									<td>
									<c:if test="${r_r.writer == pr.username}">
										<input type="hidden" class="reply_rno" value="${r_r.rno}">
										<button name="modify" class="btn-reply-update">수정</button>
										<button name="remove" class="btn-reply-remove">삭제</button>
										<input type="hidden" name="update" value="send">
										<input type="hidden" name="originalContent" value="${r_r.content}">
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

<%@include file="/WEB-INF/views/includes/footer.jsp" %>

<!-- jQuery -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/resources/dist/js/scripts.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
<script src="/resources/dist/assets/demo/datatables-demo.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=73c4181cf7d5a318ee22ad876d96dcdb&libraries=services"></script>
<script>
//var lat = 37.652726262357035;
//var lng = 127.04659752349303;

	var lat = ${map.lat};
	var lng = ${map.lng};
	
	// 이미지 지도에서 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(lat, lng); 
	
	// 이미지 지도에 표시할 마커입니다
	// 이미지 지도에 표시할 마커는 Object 형태입니다
	var marker = {
	    position: markerPosition
	};
	
	var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
	    staticMapOption = { 
	        center: new kakao.maps.LatLng(lat, lng), // 이미지 지도의 중심좌표
	        level: 3, // 이미지 지도의 확대 레벨
	        marker: marker // 이미지 지도에 표시할 마커 
	    };    
	
	// 이미지 지도를 생성합니다
	var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
</script>

<script type="text/javascript">
$(document).ready(function(){
	
	var bnoValue = ${board.bno};
	var csrfToken = '${_csrf.token}';
	
	var r_reply = $(".btn-reply-r_reply");
	var reply_update = $(".btn-reply-update");
	
	/* 대댓글 작성버튼 Click */
	r_reply.on("click", function(e){
		
		if($(this).html() == '답글') {
			
			$(this).html('취소');
			
			var index = r_reply.index(this);
			var elements = r_reply.prevAll('input');
			var rnoValue = elements[(elements.length - 1) - index].value;
			var r_replyWriter = '${pr.username}';
			
			console.log("this reply's index : " + index);
			console.log("this reply's RNO : " + rnoValue);
			console.log("R_Reply writer : " + r_replyWriter);
			
			var str = "<div class='write_r_reply'><form action='/reply/write' method='post'>" +
					  "<input type='hidden' name='r_rno' value='" + rnoValue + "'>" +
					  "<input type='hidden' name='bno' value='" + bnoValue + "'>" +
					  "<input type='hidden' name='writer' value='" + r_replyWriter + "'>" +
					  "<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>" +
					  "<input type='text' name='content'>" +
					  "<input type='submit' value='작성'>" +
					  "</form></div>";
					  
			console.log(str);
			$(".reply-list").append(str);
		}
		else {
			$(this).html('답글');
			$(".write_r_reply").remove();
		}
	});
	
	/* 댓글/대댓글 수정버튼 Click */
	reply_update.on("click", function(e){
		
		var elements = $(this).closest('tr').find('.reply_content');
		var rnoValue = $(this).closest('tr').find('.reply_rno');
		var btn_update = $(this).closest('tr').find("input[name='update']");
		var originalContent = $(this).closest('tr').find("input[name='originalContent']");
		
		console.log("Original Content: " + originalContent.val());
		console.log("RNO : " + rnoValue.val());
		
		if($(this).html() == '수정') {
			
			$(this).html('이전');
			
			//elements.attr('readonly', false);
			elements.removeAttr('readonly');
			btn_update.attr('type', 'submit');
			
		}
		else {
			
			$(this).html('수정')

			elements.attr('readonly', true);
			elements.val(originalContent.val());
			
			btn_update.attr('type', 'hidden');
		}
	});
	
	/* 댓글/대댓글 수정버튼 -> send버튼 Click */
	$("input[name='update']").on("click", function(e) {
		
		$(this).attr('type', 'hidden');
			
		var elements = $(this).closest('tr').find('.reply_content');
		var rnoValue = $(this).closest('tr').find('.reply_rno');
		
		console.log("Reply Content : " + elements.val());
		console.log("RNO : " + rnoValue.val() + " BNO : " + bnoValue);
		
		$.ajax({
			type: 'POST',
			  url: '/reply/update',
			  data: {bno:bnoValue,
				  	 content:elements.val(),
				  	 rno:rnoValue.val(),
				  	 _csrf:csrfToken},
			  success: function(data){
				  
				  console.log("Success");
			  },
			  error: function(jqXHR, status, error){
				  
				  console.log("jqXHR : " + jqXHR);
				  console.log("Error : " + error);
				  alert(status);
			  },
			  complete:function(){
				  reply_update.html('수정');
				  elements.attr('readonly', true);
			  }
		}); //$.ajax end
		
	});
	
	/* 댓글 삭제버튼 Click */
	$(".btn-reply-remove").bind("click", function(e) {
		
		if(confirm("댓글을 삭제하시겠습니까?")) {
			var parent_tr = $(this).closest('tr');
			var rnoValue = $(this).closest('tr').find(".reply_rno");
			console.log("RNO : " + rnoValue.val());
			
			$.ajax({
				url : '/reply/remove',
				method : 'POST',
				data : {rno:rnoValue.val(),
						_csrf:csrfToken},
				success : function(data){
					parent_tr.remove();
					alert("RNO : " + rnoValue.val() + " 댓글이 삭제되었습니다.");
				},
				error : function(jqXHR, status, error){
					alert("Error: " + error);
					console.log(status);
				}
			}); //$.ajax end
		}
	});
	
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
	//수정하기 눌렀을 떄
	$(".btn-update").on("click", function(e){
		
		e.preventDefault();
		
		var str = "<input type='hidden' name='bno' value='${board.bno}'>";
		actionForm.append(str);
		actionForm.attr('action', '/board/update');
		actionForm.submit();
	});
	//삭제하기 눌렀을 때
	$(".btn-remove").on("click", function(e){
		
		e.preventDefault();
		if(confirm('삭제하시겠습니까?') == true) {
			var str = '<input type="hidden" value="${board.bno}" name="bno">';
			actionForm.append(str);
			actionForm.attr('action', '/board/remove');
			actionForm.submit();
		}
	});
	
	//이전 글, 다음 글 Click
	$(".btn-next").on("click", function(e){
		
		e.preventDefault();
		
		actionForm.attr("action", "/board/get");
		actionForm.append("<input type='hidden' name='bno' value='${next}'>");
		actionForm.submit();
	});
	$(".btn-prev").on("click", function(e){
		
		e.preventDefault();
		
		actionForm.attr("action", "/board/get");
		actionForm.append("<input type='hidden' name='bno' value='${prev}'>");
		actionForm.submit();
	});
});
</script>

</body>
</html>