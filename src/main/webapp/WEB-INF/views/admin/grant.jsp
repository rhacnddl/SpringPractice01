<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.table-default{
	border:1px solid;
}
</style>

<title>Auth Grant Page</title>
</head>
<body>


<div>
	<h1>Authority Grant By Admin</h1>
</div>

<div class="table-default-div">
	<form action="/admin/grant" method="post">
		<table class="table-default">
			<tbody>
				<tr>
					<th>User ID</th>
					<th>Authority</th>
				</tr>
				<c:forEach items="${auth}" var="a">
				
				<c:set var="mem" value=""/>
				<c:set var="man" value=""/>
				<c:set var="adm" value=""/>
				<c:if test="${a.authority == 'ROLE_MEMBER'}">
				<c:set var="mem" value="selected='selected'"/>
				<c:set var="man" value=""/>
				<c:set var="adm" value=""/>
				</c:if>
				<c:if test="${a.authority == 'ROLE_MANAGER'}">
				<c:set var="mem" value=""/>
				<c:set var="man" value="selected='selected'"/>
				<c:set var="adm" value=""/>
				</c:if>
				<c:if test="${a.authority == 'ROLE_ADMIN'}">
				<c:set var="mem" value=""/>
				<c:set var="man" value=""/>
				<c:set var="adm" value="selected='selected'"/>
				</c:if>
				
				<tr>
					<td><input type="text" name="userid" value="${a.userid}" readonly="readonly"></td>
					<td>
						<select id="authority" name="authority">
							<option value="ROLE_MEMBER" ${mem}>Member</option>
							<option value="ROLE_MANAGER" ${man}>Manager</option>
							<option value="ROLE_ADMIN" ${adm}>Admin</option>
						</select>
					</td>
				</tr>
				</c:forEach>
				
				<c:set var="ids" value=""/>
				<c:set var="auths" value=""/>
				<c:forEach items="${auth}" var="a">
					<c:set var="ids" value="${ids} ${a.userid}"/>
					<c:set var="auths" value="${auths} ${a.authority}"/>
				</c:forEach>
				
			</tbody>
		</table>
		<input type="hidden" name="id" value="${ids}">
		<input type="hidden" name="auth" value="${auths}">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<input type="submit" value="변경">
	</form>

</div>
<div>
	<a href="/home">이전페이지</a>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#authority").on("change", function(e){
		var au = $("#authority").value;
		
	});
	
});
</script>
</body>
</html>