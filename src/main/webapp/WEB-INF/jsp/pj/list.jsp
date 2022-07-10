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
<input type="search">

<div style="clear:both"></div>
<table style="table-layout:fixed">
<c:forEach var="p" items="${list}">
	<a href='/wg/detail?num=${p.num}'>
 		<c:forEach var="a" items="${p.image}">
 	<img src ="/images/${a.imagepath}" alt=""></c:forEach> </a>	
</c:forEach>
</table>
<div style="clear:both"></div>
<footer>
<div>
<button type="button" onclick="location.href='/wg/addPerform'">추가</button>
</div>
</footer>
</body>
</html>