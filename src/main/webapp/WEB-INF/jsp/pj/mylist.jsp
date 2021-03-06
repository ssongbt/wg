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
	#textbox a { text-decoration:none; color:#56473c; }
	#textbox .textline { color:#8d97ca; }
	#textbox .textline .point { font-weight:bold; color:#3d3f61; }
	#dumb2 {clear:left;}
	.text1 {margin:10px; font-size:14px; margin-top:10px; margin-bottom:10px;}
	.texta { text-decoration:none; color:#56473c; }
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
  <h1>?????? ??????</h1><a href="/wg/home"><img src="/images/home.png"></a>
  <nav>
    <span><a id="now" href="/wg/mylist">??????</a></span>
    <span> ??? </span>
    <span><a id="none" href="/wg/myendlist">????????? ??????</a></span>
    <span> ??? </span>
    <span><a id="none" href="/wg/mywilllist">?????? ?????? ??????</a></span>
    <span> ??? </span>
    <span><a id="none" href="/wg/myhopelist">?????? ?????? ??????</a></span>
  </nav>
</header>
<main>

<div id="dumb"></div>

${pageInfo.pages}

<c:choose>
	<c:when test="${pageInfo.pages==0}">
	<div class="text_">????????? ????????????! <a id=now href="/wg/list">??????</a>??? ???????????? ?????? ????????? ??????????????????!</div>
	</c:when>
	
	<c:otherwise>

		<c:forEach var="l" items="${pageInfo.list}">
			<div class="container">
				<img src="/images/${l.imagepath}">
				<div id="name">${l.name}</div>
				<div id="textbox">
				<a href="/wg/mylist/end?num=${l.ep_num}">
				<div class="text">${l.ep_date}</div>
				<div class="text">${l.ep_time}</div>
				<div class="text">${l.ep_cast}</div>
				<c:choose>
				<c:when test="${l.ep_rating!=null}" ><div class="text">?????? 
					<c:choose>
						<c:when test="${l.ep_rating == 1}"> ??? </c:when>
						<c:when test="${l.ep_rating == 2}"> ?????? </c:when>
						<c:when test="${l.ep_rating == 3}"> ????????? </c:when>
						<c:when test="${l.ep_rating == 4}"> ???????????? </c:when>
						<c:when test="${l.ep_rating == 5}"> ??????????????? </c:when>
						<c:otherwise>  </c:otherwise>
					</c:choose>
					 </div></c:when> 
				<c:otherwise><div class="text"> ${l.ep_rating} </div></c:otherwise>
				</c:choose>
				</a>
				<a href="/wg/mylist/will?num=${l.wp_num}">
				<div class="text"> ${l.wp_date}</div>
				<div class="text"> ${l.wp_seat}</div>
				
				<c:choose>
				<c:when test="${l.wp_date !=null}">
				
				<jsp:useBean id="today" class="java.util.Date" />
				<fmt:formatDate var="now" value="${today}" pattern="yyyyMMdd" />
				<fmt:parseNumber value="${today.time / (1000*60*60*24)}" integerOnly="true" var="now"></fmt:parseNumber>
				<fmt:parseDate var="ddate" value="${l.wp_date}"  pattern="yyyy-MM-dd"/>
				<fmt:formatDate var="ddate" value="${l.wp_date}" pattern="yyyyMMdd" />
				<fmt:parseNumber value="${l.wp_date.time / (1000*60*60*24)}" integerOnly="true" var="ddate"></fmt:parseNumber>
		
				<div class="textline"> 
					<c:choose>
						<c:when test="${(ddate-now +1)<0}">???????????? ???????????????.</c:when>
						<c:otherwise>?????? <span class="point">${ddate-now +1}</span> ??? ???????????????.</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise></c:otherwise>		
				</c:choose>
						</div>
				</a>
				
				<a class="texta" href="/wg/mylist/hope?num=${l.hp_num}">
				<c:choose>
				<c:when test="${l.hp_rating!=null}" >
						<div class="text1">????????????
					<c:choose>
						<c:when test="${l.hp_rating == 1}"> ??? </c:when>
						<c:when test="${l.hp_rating == 2}"> ?????? </c:when>
						<c:when test="${l.hp_rating == 3}"> ????????? </c:when>
						<c:when test="${l.hp_rating == 4}"> ???????????? </c:when>
						<c:when test="${l.hp_rating == 5}"> ??????????????? </c:when>
						<c:otherwise>  </c:otherwise>
					</c:choose>
				</div>
				</c:when>
				<c:otherwise><div class="text1"> ${l.hp_rating} </div></c:otherwise>
				</c:choose>
				<div class="text1"> ${l.hp_review}</div>
				</a>
				</div>
				</div>
		</c:forEach>

	</c:otherwise>
</c:choose>


<div class="page">
<c:forEach var="pageNum" items="${pageInfo.navigatepageNums}">
	<c:choose>
		<c:when test="${pageInfo.pageNum==pageNum}">
			<div class="num"><a class="now" href="/wg/mywilllist?pageNum=${pageNum}">${pageNum}</a></div>
		</c:when>
		<c:otherwise>
			<div class="num"><a href="/wg/mywilllist?pageNum=${pageNum}">${pageNum}</a></div>
		</c:otherwise>
	</c:choose>
	
</c:forEach>
</div>

</main>
</body>
</html>