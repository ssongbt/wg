<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	#flex { display:inline-flex; flex-wrap: wrap; width:1300px;  }
   	#flex .item { width:200px; height:280px;  text-align: center; float:left; margin:0 auto; padding:10px; margin-bottom:62px; font-size:15px;}
   	#flex .name { color: #56473c; }
   	#flex .name1 { color: #56473c; font-weight:bold;  }
	#flex img { width:200px; height:280px; }
	figure {
			  width: 200px;
			  height: 280px;
			  margin: 0;
			  padding: 0;
			  background: #fff;
			  overflow: hidden;
			}
			figure:hover+span {
			  bottom: -36px;
			  opacity: 1;
			}
	#flex figure:hover img {
							  opacity: 1;
							  -webkit-animation: flash 1.5s;
							  animation: flash 1.5s;
							}
	@-webkit-keyframes flash {
						  0% {
						    opacity: .4;
						  }
						  100% {
						    opacity: 1;
						  }
						}
						@keyframes flash {
						  0% {
						    opacity: .4;
						  }
						  100% {
						    opacity: 1;
						  }
						}
	.text_ { margin-top:50px; text-align:center; color:#3d3f61; }
	.text_ .s { color:#8d97ca; font-size:12px; }
	
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

<c:choose>
	<c:when test="${pageInfo.pages==0}">
	<div class="text_"> 찾는 공연이 없으시다면 공연을 추가해보세요! <input type="button" onclick="location.href='/wg/addPerform'" value="추가"/>
			<p class="s">추가된 정보는 관리자에 의해 확인 후 수정될 수 있습니다</p>
	</div>
	</c:when>

	<c:otherwise>
		<div id="flex">
		<c:forEach var="u" items="${pageInfo.list}">
			<div class="item"><a href='/wg/detail?num=${u.num}'>
		 	<figure><img src ="/images/${u.imagepath}" alt=""></figure>
		 	 	<div class="name">
				<fmt:parseDate var="sdate" value="${u.startdate}"  pattern="yyyy-MM-dd"/>
				<fmt:formatDate var="sdate" value="${u.startdate}" pattern="yyyy" />
				<fmt:parseDate var="edate" value="${u.enddate}"  pattern="yyyy-MM-dd"/>
				<fmt:formatDate var="edate" value="${u.enddate}" pattern="yyyy" />
				<c:choose>
					<c:when test="${sdate != edate}">${sdate} - ${edate}</c:when>
					<c:otherwise>${sdate }</c:otherwise>
				</c:choose> </div>
		 	<div class="name">${u.genre}<<span class="name1">${u.name}</span>></div>
		
		 	</div>
		 	</c:forEach> </a>
		</div>
	</c:otherwise>
</c:choose>


<div style="clear:both"></div>

<div class="page">
<c:choose>
	<c:when test="${keyword!=null}">
	<c:choose >
	<c:when test="${pageInfo.navigateLastPage>5}">
		<div class="num"> <a href="/wg/list?pageNum=${pageInfo.navigateFirstPage}&keyword=${keyword}">${pageInfo.navigateFirstPage}</a></div>
		<div class="num"> ... </div>
		<c:choose>
			<c:when test="${pageInfo.prePage<1}"></c:when>
			<c:otherwise>
			<div class="num"><a href="/wg/list?pageNum=${pageInfo.prePage}&keyword=${keyword}">${pageInfo.prePage}</a></div>
			</c:otherwise>
		</c:choose>
		<div class="num"><a class="now" href="/wg/list?pageNum=${pageInfo.pageNum}&keyword=${keyword}">${pageInfo.pageNum}</a></div>
			<c:choose>
			<c:when test="${pageInfo.nextPage>pageInfo.navigateLastPage || pageInfo.nextPage==0 }"></c:when>
			<c:otherwise>
			<div class="num"><a href="/wg/list?pageNum=${pageInfo.nextPage}&keyword=${keyword}">${pageInfo.nextPage}</a></div>
			</c:otherwise>
		</c:choose>
		<div class="num"> ... </div>
		<div class="num"> <a href="/wg/list?pageNum=${pageInfo.pages}&keyword=${keyword}">${pageInfo.pages}</a></div>
		</c:when>
		<c:otherwise>
			<c:forEach var="pageNum" items="${pageInfo.navigatepageNums}">
				<c:choose>
					<c:when test="${pageInfo.pageNum==pageNum}">
						<div class="num"><a class="now" href="/wg/list?pageNum=${pageNum}&keyword=${keyword}">${pageNum}</a></div>
					</c:when>
					<c:otherwise>
						<div class="num"><a href="/wg/list?pageNum=${pageNum}&keyword=${keyword}">${pageNum}</a></div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</c:when>
	<c:otherwise>
		<c:choose >
	<c:when test="${pageInfo.navigateLastPage>5}">
		<div class="num"> <a href="/wg/list?pageNum=${pageInfo.navigateFirstPage}">${pageInfo.navigateFirstPage}</a></div>
		<div class="num"> ... </div>
		<c:choose>
			<c:when test="${pageInfo.prePage<1}"></c:when>
			<c:otherwise>
			<div class="num"><a href="/wg/list?pageNum=${pageInfo.prePage}">${pageInfo.prePage}</a></div>
			</c:otherwise>
		</c:choose>
		<div class="num"><a class="now" href="/wg/list?pageNum=${pageInfo.pageNum}">${pageInfo.pageNum}</a></div>
			<c:choose>
			<c:when test="${pageInfo.nextPage>pageInfo.navigateLastPage || pageInfo.nextPage==0 }"></c:when>
			<c:otherwise>
			<div class="num"><a href="/wg/list?pageNum=${pageInfo.nextPage}">${pageInfo.nextPage}</a></div>
			</c:otherwise>
		</c:choose>
		<div class="num"> ... </div>
		<div class="num"> <a href="/wg/list?pageNum=${pageInfo.pages}">${pageInfo.pages}</a></div>
		</c:when>
		<c:otherwise>
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
		</c:otherwise>
	</c:choose>
	</c:otherwise>
</c:choose>

</div>

<input type="hidden" name="pageNum" value="1">
<div style="clear:both"></div>
<footer>
<div>
<c:if test="${uid=='smith'}">
	<a id="add" href="/wg/addPerform">추가</a>
</c:if>
</div>
</footer>
</body>
</html>