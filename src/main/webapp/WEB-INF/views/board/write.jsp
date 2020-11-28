<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<style>
.map_wrap {position:relative;width:100%;height:350px;}
.title {font-weight:bold;display:block;}
.hAddr {position:absolute;left:200px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
#centerAddr {display:block;margin-top:2px;font-weight: normal;}
.bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=73c4181cf7d5a318ee22ad876d96dcdb&libraries=services"></script>
<meta charset="UTF-8">
<title>Board Write</title>
</head>
<body>

<sec:authentication var="writer" property='principal.username'/>
<h1 align="center">Board Write</h1>
<div align="center">
	<a href="/board/list?div=${division}">목록</a>
</div>
<div class="form-board-write" align="center">
	<form action="/board/write" method="post" enctype="multipart/form-data">
		<div class="form-default">
			<label>Category</label>
			<select name="div">
				<option value="100" <c:if test="${division == 100}">selected="selected"</c:if>>자유게시판</option>
				<option value="101" <c:if test="${division == 101}">selected="selected"</c:if>>출석게시판</option>
				<option value="102" <c:if test="${division == 102}">selected="selected"</c:if>>맛집게시판</option>
			</select>
		</div>
		<div class="form-default">
			<label>Title</label>
			<input type="text" name="title">
		</div>
		<div class="form-default">
			<label>Content</label>
			<div>
				<textarea rows="10" cols="100" name="content"></textarea>
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
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<input type="hidden" name="lat">
		<input type="hidden" name="lng">
		<button>Submit</button>
	</form>
	
	
	<div class="map_wrap">
		<button id="btn-map">지도</button>
		<div>
			<b>검색</b>
			<input type="hidden" name="keyword">
		</div>
    	<div id="map" style="width:500px;height:100%;position:relative;overflow:hidden;"></div>

</div>
</div>

<div align="center">
	<a href="/board/list?div=${division}">목록</a>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$("#btn-map").on("click", function(){
	var keyword = $("input[name='keyword']");
	keyword.attr('type', 'text');
	
	keyword.on("change", function(e){
		//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});		
		
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 
		
		// 키워드로 장소를 검색합니다
		ps.keywordSearch(keyword.val(), placesSearchCB); 
		
		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
		
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();
		
		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       
		
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } 
		}
		
		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
		    
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });
		
		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        infowindow.open(map, marker);
		    });
		}
	});
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
	    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	
	
	// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
	    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
	        if (status === kakao.maps.services.Status.OK) {
	            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
	            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
	            
	            var content = '<div class="bAddr">' +
	                            '<span class="title">법정동 주소정보</span>' + 
	                            detailAddr + 
	                        '</div>';
	
	            // 마커를 클릭한 위치에 표시합니다 
	            marker.setPosition(mouseEvent.latLng);
	            marker.setMap(map);
	
	            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
	            infowindow.setContent(content);
	            infowindow.open(map, marker);
	            
	            var latlng = mouseEvent.latLng;
	           /*
	            var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
	            message += '경도는 ' + latlng.getLng() + ' 입니다';
	            alert(message);
	           */
	            $("input[name='lat']").val(latlng.getLat());
	            $("input[name='lng']").val(latlng.getLng());
	        }   
	    });
	});

	function searchDetailAddrFromCoords(coords, callback) {
	    // 좌표로 법정동 상세 주소 정보를 요청합니다
	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}
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
	

});
</script>
</body>
</html>