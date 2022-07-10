<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>전체 공연 보기</title>
<style>
	table { display:table-cell; line-height:200px;}
	img { float:left; width:200px; margin:5px; }
</style>
</head>
<body>
<h3>공연리스트</h3>
<section class="search">
	<form action="search.jsp" method="post">
			<input type="text" name="search"/>
			<input type="submit" value="검색"/>
	</form>
</section>
<div style="clear:both"></div>
<table style="table-layout:fixed">
<c:forEach var="u" items="${pageInfo.list}">
	<a href='/wg/detail?num=${u.num}'>
 	<img src ="/images/${u.imagepath}" alt=""></c:forEach> </a>	
</table>
<div style="clear:both"></div>
<c:forEach var="pageNum" items="${pageInfo.navigatepageNums}">
	<c:choose>
		<c:when test="${pageInfo.pageNum==pageNum}">
			[<a class="red" href="/wg/page?pageNum=${pageNum}">${pageNum}</a>]
		</c:when>
		<c:otherwise>
			[<a href="/wg/page?pageNum=${pageNum}">${pageNum}</a>]
		</c:otherwise>
	</c:choose>
	
</c:forEach>

<footer>
<div>
<button type="button" onclick="location.href='/wg/addPerform'">추가</button>
</div>
</footer>
</body>
</html>