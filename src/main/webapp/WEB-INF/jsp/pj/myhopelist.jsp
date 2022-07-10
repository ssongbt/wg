<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	a { text-decoration:none; color:#dbd8d1; font-weight:lighter; }
	a#now { color:#baa289; font-weight:bold; }
	main { padding: 1rem; height: 100%;   }
	body { padding-top: 75px; background: #EEE; }
	body, html {	height: 130%;	}
	#menu>div { float:left; margin:10px; }
	#dumb {clear:left;}
	.container { border:1px solid #56473c; height:135px; margin:20px; -webkit-box-shadow: 2px 2px 5px 2px #3d3f61; 
				box-shadow: 2px 2px 5px 2px #3d3f61;  border-radius: 6px; }
	.container>img	{ width:80px; height:115px; float:left; margin:10px;}
	#name {color:#56473c; margin-top:20px; margin-bottom:10px; font-weight:bold; }
	.container::after { content:""; clear:both; display:table;}
	#textbox {margin:10px; font-size:14px; margin-top:10px; margin-bottom:10px;}
	#textbox a { text-decoration:none; color:#56473c; }}
	#dumb2 {clear:left;}
	.text_ { margin-top:50px; text-align:center; color:#3d3f61; }
	
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
    <span><a href="/wg/mylist">전체</a></span>
    <span> ｜ </span>
    <span><a href="/wg/myendlist">관람한 공연</a></span>
    <span> ｜ </span>
    <span><a href="/wg/mywilllist">관람 예정 공연</a></span>
    <span> ｜ </span>
    <span><a id="now" href="/wg/myhopelist">관람 희망 공연</a></span>
  </nav>
</header>
<main>

<div id="dumb"></div>

<c:choose>
	<c:when test="${pageInfo.pages==0}">
	<div class="text_">극장이 비었어요! <a id=now href="/wg/list">공연</a>을 검색해서 나의 극장에 추가해보세요!</div>
	</c:when>
	
	<c:otherwise>
		<c:forEach var="l" items="${pageInfo.list}">
			<div class="container">
				<img src="/images/${l.imagepath}">
				<div id="name">${l.name}</div>
				<div id="textbox">
				<a href="/wg/mylist/hope?num=${l.hp_num}">
				<div class="text">기대지수
					<c:choose>
						<c:when test="${l.hp_rating == 1}"> ★ </c:when>
						<c:when test="${l.hp_rating == 2}"> ★★ </c:when>
						<c:when test="${l.hp_rating == 3}"> ★★★ </c:when>
						<c:when test="${l.hp_rating == 4}"> ★★★★ </c:when>
						<c:when test="${l.hp_rating == 5}"> ★★★★★ </c:when>
						<c:otherwise>  </c:otherwise>
					</c:choose>
				</div>
				<div class="text">${l.hp_review}</div>
				</a>
				</div>
				</div>
		</c:forEach>
	</c:otherwise>
</c:choose>


<div class="page">
<c:choose >
<c:when test="${pageInfo.navigateLastPage>5}">
	<div class="num"> <a href="/wg/myhopelist?pageNum=${pageInfo.navigateFirstPage}">${pageInfo.navigateFirstPage}</a></div>
	<div class="num"> ... </div>
	<c:choose>
		<c:when test="${pageInfo.prePage<1}"></c:when>
		<c:otherwise>
		<div class="num"><a href="/wg/myhopelist?pageNum=${pageInfo.prePage}">${pageInfo.prePage}</a></div>
		</c:otherwise>
	</c:choose>
	<div class="num"><a class="now" href="/wg/myhopelist?pageNum=${pageInfo.pageNum}">${pageInfo.pageNum}</a></div>
		<c:choose>
		<c:when test="${pageInfo.nextPage>pageInfo.navigateLastPage || pageInfo.nextPage==0 }"></c:when>
		<c:otherwise>
		<div class="num"><a href="/wg/myhopelist?pageNum=${pageInfo.nextPage}">${pageInfo.nextPage}</a></div>
		</c:otherwise>
	</c:choose>
	<div class="num"> ... </div>
	<div class="num"> <a href="/wg/myhopelist?pageNum=${pageInfo.pages}">${pageInfo.pages}</a></div>
	</c:when>
	<c:otherwise>
		<c:forEach var="pageNum" items="${pageInfo.navigatepageNums}">
			<c:choose>
				<c:when test="${pageInfo.pageNum==pageNum}">
					<div class="num"><a class="now" href="/wg/myhopelist?pageNum=${pageNum}">${pageNum}</a></div>
				</c:when>
				<c:otherwise>
					<div class="num"><a href="/wg/myhopelist?pageNum=${pageNum}">${pageNum}</a></div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:otherwise>
</c:choose>
</div>

</main>
</body>
</html>