<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>mylist</title>
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
			    margin-top:5px;
			    margin-right:480px;
			    border-radius: 0; position: sticky; }
	a#none { text-decoration:none; color:#dbd8d1; font-weight:lighter; }
	a#now { text-decoration:none; color:#baa289; font-weight:bold; }
	main { padding: 1rem; height: 100%;   }
	body { padding-top: 75px; background: #EEE; }
	body, html {	height: 130%;	}
	#menu>div { float:left; margin:10px; }
	#dumb {clear:left;}
	
	.container { border:1px solid #56473c; height:135px; margin:20px; -webkit-box-shadow: 2px 2px 5px 2px #3d3f61; 
				box-shadow: 2px 2px 5px 2px #3d3f61;  border-radius: 6px; }
	.container>img	{ width:80px; float:left; margin:10px;}
	#name {color:#56473c; margin-top:20px; margin-bottom:10px; font-weight:bold; }
	.container::after { content:""; clear:both; display:table;}
	#textbox {margin:10px; font-size:14px; margin-top:10px; margin-bottom:10px;}
	#textbox a { text-decoration:none; color:#56473c; }}
	#textbox .textline { color:#8d97ca; }
	#textbox .textline .point { font-weight:bold; color:#3d3f61; }
	
	.container2 { border:1px solid #56473c; height:135px; margin:20px; -webkit-box-shadow: 2px 2px 5px 2px #3d3f61; 
				box-shadow: 2px 2px 5px 2px #3d3f61;  border-radius: 6px; }
	.container2>img	{ width:80px; float:left; margin:10px;}
	#name2 {color:#56473c; margin-top:20px; margin-bottom:10px; font-weight:bold; }
	.container2::after { content:""; clear:both; display:table;}
	#textbox2 {margin:10px; font-size:14px; margin-top:10px; margin-bottom:10px;}
	#textbox2 a { text-decoration:none; color:#56473c; }
	#textbox2 .textline { color:#8d97ca; }
	#textbox2 .textline .point { font-weight:bold; color:#3d3f61; }
	
	.container3 { border:1px solid #56473c; height:135px; margin:20px; -webkit-box-shadow: 2px 2px 5px 2px #3d3f61; 
				box-shadow: 2px 2px 5px 2px #3d3f61;  border-radius: 6px; }
	.container3>img	{ width:80px; float:left; margin:10px;}
	#name3 {color:#56473c; margin-top:20px; margin-bottom:10px; font-weight:bold; }
	.container3::after { content:""; clear:both; display:table;}
	#textbox3 {margin:10px; font-size:14px; margin-top:10px; margin-bottom:10px;}
	#textbox3 a { text-decoration:none; color:#56473c; }
	#textbox3 .textline { color:#8d97ca; }
	#textbox3 .textline .point { font-weight:bold; color:#3d3f61; }
	.text_ { margin-top:50px; text-align:center; color:#3d3f61; }
	
	#dumb2 {clear:left;}
	.text1 {margin:10px; font-size:14px; margin-top:10px; margin-bottom:10px;}
	.texta { text-decoration:none; color:#56473c; }
	
	.page { float:right; text-align:center; margin-right:20px;}
	.page .num {  margin-right:1.5px; display:inline; vertical-align:middle;  }
	.page .num a { display:inline-block;
					vertical-align:text-top;
					padding:4px;
					margin-right:3px;
					width:15px;
					height:15px;
					color:#3d3f61;
					font-size:12px;
					border:1px solid #3d3f61;
					text-align:center;
					text-decoration:none;}
	.page .num a.now {
	 				color:#dbd8d1;
					background-color:#3d3f61;
					border:1px solid #3d3f61;
	}
	.page .num a:hover, .page .num a:focus {
					color:#dbd8d1;
					border:1px solid #3d3f61;
					background-color:#3d3f61;
	}
</style>
</head>
<body>
<header>
  <h1>나의 극장</h1><a href="/wg/home"><img src="/images/home.png"></a>
  <nav>
    <span><a id="now" href="/wg/mylist">전체</a></span>
    <span> ｜ </span>
    <span><a id="none" href="/wg/myendlist">관람한 공연</a></span>
    <span> ｜ </span>
    <span><a id="none" href="/wg/mywilllist">관람 예정 공연</a></span>
    <span> ｜ </span>
    <span><a id="none" href="/wg/myhopelist">관람 희망 공연</a></span>
  </nav>
</header>
<main>

<div id="dumb"></div>

<c:choose>
	<c:when test="${pageendInfo.pages==0 && pagewillInfo.pages==0 && pagehopeInfo.pages==0}">
	<div class="text_">극장이 비었어요! <a id=now href="/wg/list">공연</a>을 검색해서 나의 극장에 추가해보세요!</div>
	</c:when>
	
	<c:otherwise>

		<c:forEach var="e" items="${pageendInfo.list}">
			<div class="container">
				<img src="/images/${e.imagepath}">
				<div id="name">${e.name}</div>
				<div id="textbox">
				<a href="/wg/mylist/end?num=${e.ep_num}">
				<div class="text">${e.ep_date}</div>
				<div class="text">${e.ep_time}</div>
				<div class="text">${e.ep_cast}</div>
				<div class="text"> 평점
					<c:choose>
						<c:when test="${e.ep_rating == 1}"> ★ </c:when>
						<c:when test="${e.ep_rating == 2}"> ★★ </c:when>
						<c:when test="${e.ep_rating == 3}"> ★★★ </c:when>
						<c:when test="${e.ep_rating == 4}"> ★★★★ </c:when>
						<c:when test="${e.ep_rating == 5}"> ★★★★★ </c:when>
						<c:otherwise>  </c:otherwise>
					</c:choose>
				 </div>
				</a>
				</div>
				</div>
		</c:forEach>
		
		
		<c:forEach var="w" items="${pagewillInfo.list}">
		
			<div class="container">
				<img src="/images/${w.imagepath}">
				<div id="name">${w.name}</div>
				<div id="textbox">
				<a href="/wg/mylist/will?num=${w.wp_num}">
				<div class="text">${w.wp_date}</div>
				<div class="text">${w.wp_time}</div>
				<div class="text">${w.wp_seat}</div>
				
				
				<jsp:useBean id="today" class="java.util.Date" />
				<fmt:formatDate var="now" value="${today}" pattern="yyyyMMdd" />
				<fmt:parseNumber value="${today.time / (1000*60*60*24)}" integerOnly="true" var="now"></fmt:parseNumber>
				<fmt:parseDate var="ddate" value="${w.wp_date}"  pattern="yyyy-MM-dd"/>
				<fmt:formatDate var="ddate" value="${w.wp_date}" pattern="yyyyMMdd" />
				<fmt:parseNumber value="${w.wp_date.time / (1000*60*60*24)}" integerOnly="true" var="ddate"></fmt:parseNumber>
		
				<div class="textline"> 
					<c:choose>
						<c:when test="${(ddate-now +1)<0}">관람일이 지났습니다.</c:when>
						<c:otherwise>관람 <span class="point">${ddate-now +1}</span> 일 남았습니다.</c:otherwise>
					</c:choose>
				
				</div>
				</a>
				</div>
				</div>
		</c:forEach>
		
	</c:otherwise>
</c:choose>



<c:forEach var="h" items="${pagehopeInfo.list}">
	<div class="container">
		<img src="/images/${h.imagepath}">
		<div id="name">${h.name}</div>
		<div id="textbox">
		<a href="/wg/mylist/hope?num=${h.hp_num}">
		<div class="text">기대지수
			<c:choose>
				<c:when test="${h.hp_rating == 1}"> ★ </c:when>
				<c:when test="${w.hp_rating == 2}"> ★★ </c:when>
				<c:when test="${h.hp_rating == 3}"> ★★★ </c:when>
				<c:when test="${h.hp_rating == 4}"> ★★★★ </c:when>
				<c:when test="${h.hp_rating == 5}"> ★★★★★ </c:when>
				<c:otherwise>  </c:otherwise>
			</c:choose>
		</div>
		<div class="text">${h.hp_review}</div>
		</a>
		</div>
		</div>
</c:forEach>





<div class="page">
<c:choose >
<c:when test="${pageendInfo.navigateLastPage>5}">
	<div class="num"> <a href="/wg/mylist?pageNum=${pageendInfo.navigateFirstPage}">${pageendInfo.navigateFirstPage}</a></div>
	<div class="num"> ... </div>
	<c:choose>
		<c:when test="${pageendInfo.prePage<1}"></c:when>
		<c:otherwise>
		<div class="num"><a href="/wg/mylist?pageNum=${pageendInfo.prePage}">${pageendInfo.prePage}</a></div>
		</c:otherwise>
	</c:choose>
	<div class="num"><a class="now" href="/wg/mylist?pageNum=${pageendInfo.pageNum}">${pageendInfo.pageNum}</a></div>
		<c:choose>
		<c:when test="${pageendInfo.nextPage>pageendInfo.navigateLastPage || pageendInfo.nextPage==0 }"></c:when>
		<c:otherwise>
		<div class="num"><a href="/wg/mylist?pageNum=${pageendInfo.nextPage}">${pageendInfo.nextPage}</a></div>
		</c:otherwise>
	</c:choose>
	<div class="num"> ... </div>
	<div class="num"> <a href="/wg/mylist?pageNum=${pageendInfo.navigateLastPage}">${pageendInfo.navigateLastPage}</a></div>
	</c:when>
	<c:otherwise>
		<c:forEach var="pageNum" items="${pageendInfo.navigatepageNums}">
			<c:choose>
				<c:when test="${pageendInfo.pageNum==pageNum}">
					<div class="num"><a class="now" href="/wg/mylist?pageNum=${pageNum}">${pageNum}</a></div>
				</c:when>
				<c:otherwise>
					<div class="num"><a href="/wg/mylist?pageNum=${pageNum}">${pageNum}</a></div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:otherwise>
</c:choose>
</div>

</main>
</body>
</html>