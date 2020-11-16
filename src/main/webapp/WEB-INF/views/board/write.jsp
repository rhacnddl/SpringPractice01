<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Write</title>
</head>
<body>

<sec:authentication var="writer" property='principal.username'/>

<div class="form-board-write" align="center">
	<form action="/board/write" method="post" enctype="multipart/form-data">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<div class="form-default">
			<label>Category</label>
			<select name="div">
				<option value="100" <c:if test="${division == 100}">selected="selected"</c:if>>자유게시판</option>
				<option value="101" <c:if test="${division == 101}">selected="selected"</c:if>>출석게시판</option>
			</select>
		</div>
		<div class="form-default">
			<label>Title</label>
			<input type="text" name="title">
		</div>
		<div class="form-default">
			<label>Content</label>
			<div>
			
				<textarea id="ir1" rows="10" cols="100" name="content"></textarea>
			</div>
		</div>
		<div class="form-default">
			<label>Writer</label>
			<input name="writer" value="${writer}" readonly="readonly">
		</div>
		<!-- File Upload -->
		<div class="form-default">
			<input type="file" id="uploadFile" name="uploadFile" multiple="multiple">
			<button name="btn-delete">X</button>
		</div>
		<button>Submit</button>
	</form>
</div>

<div align="center">
	<a href="/board/list?div=${division}">목록</a>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "ir1",
	 sSkinURI: "/resources/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});
</script>
<script type="text/javascript">
$(document).ready(function(){
	
	//var input = $("#uploadFile");
	
	$("button[name='btn-delete']").on("click", function(e) { //파일 삭제버튼 
		e.preventDefault();
		//fn_deleteFile($(this));
		//var input = document.getElementById("uploadFile");
		//var input = $("#uploadFile");
		//input.value = null;
		$("#uploadFile").val('');
	});
	
	function fn_deleteFile(obj){
		obj.parent().value = null;
	}
	
	// ‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.
	function submitContents(elClickedObj) {
	 // 에디터의 내용이 textarea에 적용된다.
	 oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);

	 // 에디터의 내용에 대한 값 검증은 이곳에서
	 // document.getElementById("ir1").value를 이용해서 처리한다.

	 try {
	     elClickedObj.form.submit();
	 } catch(e) {}
	 
	 
	}
});
</script>
</body>
</html>