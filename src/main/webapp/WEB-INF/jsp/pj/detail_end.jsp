<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>나의 공연 상세보기</title>
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
	img {  width:200px; float:left; margin-left:10px; margin-right:20px; margin-bottom:20px; margin-top:25px; }
	.content { align-items:center; padding:10px; }
	.content>h3 { color:#56473c; }
	.content .main { color:#56473c; font-weight:bold; }
	.content .main a { color:#3d3f61; font-weight:normal; }
	.content::after { content:""; clear:both; display:table;}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">
function deleted(num) {
	if(!confirm('정말 삭제하시겠어요?')) {
		return;
	}
	
	var obj = {};
	obj.num = num;
		
	$.ajax({
		url:'/wg/mylist/end/delete',
		method:'post',
		cache:false,
		data:obj,
		dataType:'json',
		success:function(res){
			alert(res.deleteendperform ? '삭제 성공' : '삭제 실패');
			if(res.deleteendperform) location.href='/wg/myendlist';
		},
		error:function(xhr,status,err){
			alert('에러:'+err);
		}
	});

}

</script>
<body>
<header>
  <h1>관람한 공연</h1><a href="/wg/home"><img src="/images/home.png"></a>
  <nav>
    <span><a href="/wg/mylist/end/update?ep_num=${endperform.ep_num}">수정</a></span>
    <span> ｜ </span>
    <span><a href="javascript:deleted('${endperform.ep_num}')">삭제</a></span>
    <span> ｜ </span>
    <span><a href="/wg/myendlist">목록</a></span>
  </nav>
</header>

<c:forEach var="p" items="${endperform.perform}">
	<c:forEach var="i" items="${p.image}">
		<img src="/images/${i.imagepath}">
	<div class="content">
			<h3>${p.name}</h3>
	<p class="main">${p.genre} ｜ ${p.loc}</p>
		</c:forEach>
	</c:forEach>
	<p class="main">관람일 <a> ${endperform.ep_date}</a></p>
	<p class="main">관람시간 <a> ${endperform.ep_time}</a></p>
	<p class="main">좌석 <a>${endperform.ep_seat}</a></p>
	<p class="main">캐스트 <a>${endperform.ep_cast}</a></p>
	<p class="main"> 평점
	<c:choose>
		<c:when test="${endperform.ep_rating == 1}"> ★ </c:when>
		<c:when test="${endperform.ep_rating == 2}"> ★★ </c:when>
		<c:when test="${endperform.ep_rating == 3}"> ★★★ </c:when>
		<c:when test="${endperform.ep_rating == 4}"> ★★★★ </c:when>
		<c:when test="${endperform.ep_rating == 5}"> ★★★★★ </c:when>
		<c:otherwise>  </c:otherwise>
	</c:choose>
	<p class="main">리뷰<a> ${endperform.ep_review}</a></p>
	</p>

<div style="clear:both"></div>

 
</body>
</html>