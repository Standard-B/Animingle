<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Animingle</title>
<%@ include file="/WEB-INF/views/inc/asset.jsp" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
<link rel="stylesheet" href="/animingle/asset/css/index.css">
<link rel="stylesheet" href="/animingle/asset/css/walktogether.css">
</head>
                
<body>
                
<%@ include file="/WEB-INF/views/inc/header.jsp" %>
<section class="content">
    <div class="mycontainer">
        <div class="leftbar">
            <!-- 왼쪽 사이드바 입니다. -->
        </div>
        <div class="maincontent">
            <div class="content-top">
                <div class="content-title">산책 친구 구하기</div>
            </div>

            <div id="map" style="width:100%;height:800px;">
            </div>

            <div class="btn-div">
                <button type="button" class="write-btn"
                    onclick="window.location='http://localhost:8090/animingle/board/walktogetheradd.do';">
                    <span class="material-symbols-outlined">
                        edit_note
                    </span>
                    작성하기
                </button>
            </div>

            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop"
                id="modalBtn">
                상세보기(마커로 버튼 변경 필요)
            </button>

            <!-- Modal -->
            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel">
                                산책친구 구해요
                                <span class="status">모집 중</span>
                            </h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h6>산책 루트</h6>
                            <div id="map2" style="width:100%;height:300px;"></div>
                            <div class="walkInfo">
                                <div class="petInfo">반려동물 종: 강아지</div>
                                <div class="timeInfo">산책 가능 요일/시간: 5월 30일 19시 이후</div>
                            </div>
                            <div class="walkInfo">
                                <div class="introInfo">우리 강아지 착해요</div>
                                <div></div>
                            </div>
                            <div class="modal-footer">
                                <div class="btn-div btn-margin">
                                    <button type="button" class="write-btn">
                                        <span class="material-symbols-outlined">sms</span>
                                        채팅하기
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="rightbar">
                <!-- 오른쪽 사이드바 입니다. -->
            </div>
        </div>
    </div>
</section>
<%@ include file="/WEB-INF/views/inc/footer.jsp" %>
    
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	6d88daddca380ab9ff45e48fab144915"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
    integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
    crossorigin="anonymous"></script>
<script>

    var lat = 37.4993;
    var lng = 127.0331;

    var container = document.getElementById('map');
    var options = {
        level: 4
    };

    var map;

    /* 현재 위치 받아서 기본 지도 화면 출력하기 */
    if (navigator.geolocation) {

        // GeoLocation을 이용해서 접속 위치를 얻어온다.
        navigator.geolocation.getCurrentPosition(function (position) {
            
            lat = position.coords.latitude, // 위도
            lng = position.coords.longitude; // 경도

            // 현재 위치를 받아온 후에 지도를 생성한다.
            options.center = new kakao.maps.LatLng(lat, lng);
            map = new kakao.maps.Map(container, options);
            
            boundInfo(map);
            kakao.maps.event.addListener(map, 'bounds_changed', function() {
                boundInfo(map);
            });
            
        }, function (error) {

            // 사용자가 위치 정보를 허용하지 않았을 경우, 기본 위치를 사용한다.
            options.center = new kakao.maps.LatLng(lat, lng);
            map = new kakao.maps.Map(container, options);

            boundInfo(map);
            kakao.maps.event.addListener(map, 'bounds_changed', function() {
                boundInfo(map);
            });      

        });

    } else {

        // 브라우저가 Geolocation을 지원하지 않는 경우, 기본 위치를 사용한다.
        options.center = new kakao.maps.LatLng(lat, lng);
        map = new kakao.maps.Map(container, options);

        boundInfo(map);
        kakao.maps.event.addListener(map, 'bounds_changed', function() {
            boundInfo(map);
        });       
    }

    
    
    /* 지도가 이동, 확대, 축소로 인해 지도영역이 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다 */
    function boundInfo(map) {  
        
	    // 지도 영역정보를 얻어옵니다 
	    var bounds = map.getBounds();
	    
	    // 영역정보의 남서쪽 정보를 얻어옵니다 
	    var sw = bounds.getSouthWest();
	    
	    // 영역정보의 북동쪽 정보를 얻어옵니다 
	    var ne = bounds.getNorthEast();
	    
	    $.ajax({
	        type: 'POST',
	        url: '/animingle/board/walktogetherlist.do',
	        data: {
	            swLat: sw.getLat(),
	            swLng: sw.getLng(),
	            neLat: ne.getLat(),
	            neLng: ne.getLng()
	        },
	        dataType: 'json',
	        success: (result)=>{
	            
	            var positions = [];
	         	
	        	/* TODO 모달창에 전달해야 하는 정보 
	        		- 경로 정보(wtPath)
	        		- 반려동물종(wt_petKind)
	        		- 산책가능요일/시간(wt_time)
	        		- 본문(wt_content)
	        		- 글쓴이 아이디(wt_id)
	        		- 글 번호(wt_seq)
	        	*/	        	   
	        	
	            // Iterate over each item in the result
	            $(result).each((index, item)=>{
	                
	                var filteredPlist = item.plist.filter(subList => subList[0]  === item.wt_seq);
	                
	                positions.push({
	                    petkind: item.wt_petkind,
	                    time: item.wt_time,
	                    latlng: new kakao.maps.LatLng(item.wtp_lat, item.wtp_lng),
	                	content: item.wt_content,
	                	id: item.wt_id,
	                	seq: item.wt_seq,
	                	pathlist: filteredPlist
	                });

	            });		            	            
	            
	            showMarkernInfo(positions, bounds);	            
	            
	        },
	        error: (a, b, c) => console.log(a, b, c)
	    });
  
    }
     
    function showMarkernInfo(positions, bounds) { 
        
        for (var i = 0; i < positions.length; i ++) {            
            
            var imageSrc = '/animingle/asset/commonimg/marker.png', // 마커이미지의 주소입니다    
            imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
            imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

	        // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	            markerPosition = new kakao.maps.LatLng(positions[i].latlng.Ma, positions[i].latlng.La); // 마커가 표시될 위치입니다
	
	        // 마커를 생성합니다
	        var marker = new kakao.maps.Marker({
	          position: markerPosition,
	          image: markerImage // 마커이미지 설정 
	        });
	
	        // 커스텀 오버레이가 표시될 위치입니다 
	        var position = new kakao.maps.LatLng(positions[i].latlng.Ma, positions[i].latlng.La);  
	
	        // 커스텀 오버레이를 생성합니다
	        var customOverlay = new kakao.maps.CustomOverlay({
	            map: map,
	            position: position,
	            content: `<div class="info"><ul><div><li>\${positions[i].petkind}</li><li>\${positions[i].time}</li></div></ul></div>`,
	            yAnchor: 2.1
	        });		   

	    	
	        // 마커가 지도 위에 표시되도록 설정합니다
	        marker.setMap(map);  
	        marker.customOverlay = customOverlay; // 마커에 커스텀 오버레이 참조를 저장합니다
	        marker.data = positions[i];
	        
	        customOverlay.setMap(null); //처음에는 커스텀 오버레이를 다 숨겨놓는다.
	        
	        kakao.maps.event.addListener(marker, 'mouseover', function() {
	            this.customOverlay.setMap(map); // 마커에 마우스를 올렸을 때, 커스텀 오버레이를 표시합니다.
	        });

	        kakao.maps.event.addListener(marker, 'mouseout', function() {
	            this.customOverlay.setMap(null); // 마커에서 마우스를 뗐을 때, 커스텀 오버레이를 숨깁니다.
	        });
	        
	     	//마커를 클릭하면 해당 모달창이 뜨도록 합니다. 
	        kakao.maps.event.addListener(marker, 'click', function() {
	            
	            // 클릭된 마커의 데이터를 가져옵니다.
	            var data = this.data;
	            
	            // 가져온 데이터를 이용하여 모달을 업데이트하고 표시합니다.
	            updateModal(data);
	            $('#myModal').modal('show');
	        });
	        
        }		
        
    }
    
    

    /* modal창 map */
    document.getElementById('modalBtn').addEventListener('click', function () {
        setTimeout(function () {
            var container2 = document.getElementById('map2');
            var options2 = {
                center: new kakao.maps.LatLng(37.4993, 127.0331),
                level: 4
            };
            var map2 = new kakao.maps.Map(container2, options2);
        }, 200);
    });

</script>
</body>

</html>