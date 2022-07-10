<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공연 상세정보</title>
<style>
		header {
			  position: fixed;
			  top: 0;
			  left: 0;
			  right: 0;
			  
			  height: 75px;
			  padding: 1rem;
			  color: #dbd8d1;
			  background: #56473c;
			  font-weight: bold;
			  display: flex;
			  justify-content: space-between;
			  align-items: center;
			}
		header>a>img { width: 35px;
			    height: 35px;
			    margin-top:18px;
			    margin-right:820px;
			    border-radius: 0; position: sticky; }
		a { text-decoration:none; color:#dbd8d1; font-weight:lighter; }
	body { padding-top: 105px; background: #EEE; }
	body, html {	height: 130%;	}
	img { width:200px; float:left; margin-left:10px; margin-right:20px; margin-bottom:20px; margin-top:25px; }
	.content { align-items:center; padding:5px; }
	.content>h3 { color:#56473c; }
	.content .main { color:#56473c;  }
	.content::after { content:""; clear:both; display:table;}
	#menu { float:right; margin-right:26px; font-size:12px; color:#3d3f61; margin-top:8px;}
	#map { width:600px; height:400px; margin:0 auto; }
	#map_text { padding:15px; text-align:center; color:#3d3f61;}
	#video { margin:0 auto; text-align: center; float:left; }

</style>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fefe54713afff65d5e6b73e9a2b6fd73"></script>
<script type="text/javascript">
function deleted(num) {
	if(!confirm('정말 삭제하시겠어요?')) {
		return;
	}
	
	var obj = {};
	obj.num = num;
		
	$.ajax({
		url:'/wg/deletePerform',
		method:'post',
		cache:false,
		data:obj,
		dataType:'json',
		success:function(res){
			alert(res.deletedPerform ? '삭제 성공' : '삭제 실패');
			if(res.deletedPerform) location.href='/wg/list';
		},
		error:function(xhr,status,err){
			alert('에러:'+err);
		}
	});

}

</script>

<body>
<header>
  <h1>공연 상세정보</h1><a href="/wg/home"><img src="/images/home.png"></a>
  <nav>
    <span><a href="/wg/addmylist?per_num=${perform.num}">저장</a></span>
    <span> ｜ </span>
    <span><a href="/wg/list">목록</a></span>

  </nav>
</header>
	 	<c:choose>
	 		<c:when test ="${fn:length(perform.image)>0}">
			 	<c:forEach var="i" items="${perform.image}"> 
						<img src="/images/${i.imagepath}">
				</c:forEach>
	 		</c:when>
	 		<c:otherwise>
	 			첨부파일 없음
	 		</c:otherwise>
	 	</c:choose>
	<div class="content">
		<h3>${perform.name}</h3>
		<p class="main">${perform.genre}</p>
		<p class="main">${perform.startdate} ~ ${perform.enddate}</p>
		<p class="main">${perform.loc} <input type="button" value="위치보기" onclick="viewmap();document.getElementById('map_text').style.display='block';"/></p> 
		<p class="main">${perform.run}</p>
		<p class="main">${perform.cast}</p>
		<p class="main">${perform.synop}</p>
	</div>
<div style="clear:both"></div>


				<fmt:parseDate var="sdate" value="${perform.startdate}"  pattern="yyyy-MM-dd"/>
				<fmt:formatDate var="sdate" value="${perform.startdate}" pattern="yyyy" />
				<fmt:parseDate var="edate" value="${perform.enddate}"  pattern="yyyy-MM-dd"/>
				<fmt:formatDate var="edate" value="${perform.enddate}" pattern="yyyy" />
<div id="video">
<c:choose>
<c:when test="${perform.name=='마타하리' && sdate=='2022' && edate==2022}">
<iframe width="560" height="315" src="https://www.youtube.com/embed/MXLRT15VQGA?controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</c:when>
<c:when test="${perform.name=='니진스키' && sdate=='2022' && edate==2022}">
<iframe width="560" height="315" src="https://www.youtube.com/embed/iWJdAyUCvVs?controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</c:when>
<c:when test="${perform.name=='킹아더' && sdate=='2022' && edate==2022}">
<iframe width="560" height="315" src="https://www.youtube.com/embed/Ocq6pIvh_Uk?controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</c:when>
<c:when test="${perform.name=='더테일 에이프릴 풀스' && sdate=='2022' && edate==2022}">
<iframe width="560" height="315" src="https://www.youtube.com/embed/iG1O5qhZWto?controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</c:when>
<c:otherwise></c:otherwise>
</c:choose>
</div>

<div id="map">
	
</div>
<div id="map_text"  style="display:none;" >
	<c:forEach var="l" items="${perform.location}"> 
	<c:choose>
	<c:when test="${perform.loc==l.gu_location}">
	<p class="loc">${l.location} (구 ${l.gu_location})</p>
	</c:when>
	<c:otherwise>
	<p class="loc">${l.location} </p>
	</c:otherwise>
	</c:choose>
</div>


<script type="text/javascript">
function viewmap(){
	
	
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(${l.latitude}, ${l.longitude}), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(${l.latitude}, ${l.longitude}), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(${l.latitude}, ${l.longitude}); 
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);

	/*
	// 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
	var iwContent = '<div style="padding:5px;">'+ document.getElementById('map_text') +'</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
	    content : iwContent
	});

	// 마커에 마우스오버 이벤트를 등록합니다
	kakao.maps.event.addListener(marker, 'mouseover', function() {
	  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
	    infowindow.open(map, marker);
	});

	// 마커에 마우스아웃 이벤트를 등록합니다
	kakao.maps.event.addListener(marker, 'mouseout', function() {
	    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
	    infowindow.close();
	});*/
	
	
}
	
	</script>
</c:forEach>



<div>
<c:if test="${uid=='smith'}">
	<a id="menu" href="javascript:deleted('${perform.num}')">삭제</a>
	<a id="menu">｜</a>
	<a id="menu" href="/wg/updatePerform?num=${perform.num}">수정</a>
</c:if>
</div>
</body>
</html>