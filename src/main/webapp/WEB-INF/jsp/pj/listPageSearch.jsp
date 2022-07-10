<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>list</title>
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
			    margin-right:710px;
			    border-radius: 0; position: sticky; }
	a { text-decoration:none; color:#dbd8d1; font-weight:lighter; }
	main { padding: 1rem; height: 100%;   }
	body { padding-top: 130px; background: #EEE; }
	body, html {	height: 100%;	}
	.search { padding:6px;
				margin-top:-9px;
			}
	.keyword {   
				  width: 500px;
				  height: 32px;
				  font-size: 15px;
				  border: 3px solid #3d3f61;
				  border-radius: 0;
				  outline: none;
				  padding-left: 10px;
				  background-color: rgb(233, 233, 233);}
	.bt {  	 text-transform: uppercase;
			  outline: 0;
			  font-weight:bold;
			  background: #8d97ca;
			  color:#3d3f61;
			  width: 60px;
			  height:39px;
			  border: 0;
			  padding: 0px;
			  font-size: 15px;
			  cursor: pointer;}	
	.bt:hover,.bt:active,.bt:focus {
					  background: #3d3f61;
					  color: #dbd8d1;
					}
	#wrap { margin-top:10px; padding:5px; text-align:center; }
	#wrap>img { float:left; margin-right:10px; width:200px; overflow:hidden; }
	img { width:200px; height:280px; }
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
	#add { float:right; margin-right:26px; font-size:12px; color:#3d3f61; margin-top:8px;}
</style>
</head>
<body>
<header>
  <h1>공연 목록</h1><a href="/wg/home"><img src="/images/home.png"></a>
  <nav>
    <span><a href="/wg/list">공연</a></span>
    <span> ｜ </span>
    <span><a href="/wg/mylist">나의 극장</a></span>
    <span> ｜ </span>
    <span><a href="/wg/myinfo">내 정보</a></span>
  </nav>
</header>
<div style="clear:both"></div>

<section class="search">
	<form action="" method="get">
	<input type="hidden" id="pageNum" name="pageNum" value="${pageNum}">
			<input class="keyword" type="text" id="keyword" name="keyword" placeholder="Search" value="${keyword}"/>
			<button class="bt" type="submit">검색</button>
	</form>
</section>
<div style="clear:both"></div>
<div id="wrap">
<article>
<c:forEach var="u" items="${pageInfo.list}">
	 <a href='/wg/detail?num=${u.num}'>
 	<img src ="/images/${u.imagepath}" alt="">
 	</c:forEach> </a>	</article>
</div>
<div style="clear:both"></div>

<div class="page">
<c:forEach var="pageNum" items="${pageInfo.navigatepageNums}">
	<c:choose>
		<c:when test="${pageInfo.pageNum==pageNum}">
			<div class="num"><a class="now" href="/wg/list?pageNum=${pageNum}">${pageNum}</a></div>
		</c:when>
		<c:otherwise>
			<div class="num"><a href="/wg/list?pageNum=${pageNum}">${pageNum}</a></div>
		</c:otherwise>
	</c:choose>
	
</c:forEach>
</div>
<input type="hidden" name="pageNum" value="1">
<div style="clear:both"></div>
<footer>
<div>
<a id="add" href='/wg/addPerform'">추가</a>
</div>
</footer>
</body>
</html>