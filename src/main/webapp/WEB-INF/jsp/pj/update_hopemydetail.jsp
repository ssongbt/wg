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
		body {
	    align-items: center;
	    background: #EEE; 
	    color: #3d3f61;
	    display: grid;
	    font-family: $font-family;
	    font-size: 14px;
	    font-weight: 400;
	    height: 100vh;
	    justify-items: center;
	    weight: 100vw;
	    padding-top: 105px;
	}

	.content { align-items:center; padding:5px; width:650px;}
	.content>img {  width:200px; float:left; margin-left:10px; margin-right:20px; margin-bottom:20px; margin-top:10px; }
	.content>h3 { color:#56473c;  }
	.content .main { color:#56473c; font-weight:bold; }
	.content .main .info { color:#56473c; }
	.content::after { content:""; clear:both; display:table;}
	
	.select { padding: 15px 1px;  justify-items: center;}
	.select input[type=radio]{  appearance: none; display:none; }
	.select input[type=radio]+label{
				    display: inline-block;
				    cursor: pointer;
				    height: 60px;
				    width: 150px;
				    border: 1px solid #56473c;
				    line-height: 60px;
				    text-align: center;
				    font-weight:bold;
				    font-size:13px;
					}
	.select input[type=radio]+label{
				    background-color: #dbd8d1;
				    color: #333;
					}
	.select input[type=radio]:checked+label{
    				background-color: #3d3f61;
    				color: #fff;
					}
					
	.form {
			  position: relative;
			  z-index: 1;
			  background: #dbd8d1;
			  max-width: 400px;
			  margin: 0 auto 100px;
			  padding: 45px;
			  text-align: center;
			  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
			}
	
			
	input {
      border: 1px solid #dbd8d1;
      border-radius: 4px;
      height: 30px;
      line-height: 38px;
      padding-left: 5px;
      margin: 5px;
    }
    input, label {
        color: #3d3f61; }
    label, input, .imagepath {
      width: 200px;
    }
      textarea {border: 1px solid #dbd8d1;
      border-radius: 4px;
      height: 80px;
      width:200px;
      line-height: 21px;
      padding-left: 5px;
      margin: 5px;}
	label { text-align:right; display:inline-block; width:120px;  vertical-align:text-top;}
	label[for="ep_review"] {position:relative; vertical-align:42px;}
	label[for="hp_review"] {position:relative; vertical-align:42px;}
    .form button {
			  font-family: "Roboto", sans-serif;
			  text-transform: uppercase;
			  outline: 0;
			  background: #baa289;
			  width: 100%;
			  border: 0;
			  padding: 15px;
			  color: #FFFFFF;
			  font-size: 14px;
			  -webkit-transition: all 0.3 ease;
			  transition: all 0.3 ease;
			  cursor: pointer;
			  margin-top:10px;
			}
	.form button:hover,.form button:active,.form button:focus {
					  background: #56473c;
					}
</style>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">
	function changedocu(){
		var docu = document.getElementById('opt');
	}
	
	$(function(){
		$('#range_out').val(3);
	});
	function showRangeVal(num){
		$('#range_out').val(num);
		
	}
	
	
	$(function(){
		$('#range_out2').val(${hopeperform.hp_rating});
	});
	function showRangeVal2(num){
		$('#range_out2').val(num);
		
	}
	
	
	function addendperformdeletehope(){
		if(!confirm('기존의 정보는 초기화됩니다! 계속 하시겠어요?')) {
			return false;
		}
			 
			var serData = $('#updateendPerform').serialize();
			
			$.ajax({ 
			   url:'/wg/mylist/hope/update2', 
			   method:'post',
			   cache: false,  
			   data: serData,
			   dataType: 'json',
			   success: function(res) {
				   alert(res.deletehopeaddendperform ? '수정 성공' : '수정 실패');
				   if(res.deletehopeaddendperform) location.href='/wg/myendlist';
			   },
			   error: function(xhr, status, err){	
				   	alert("에러:" + err);				
			   }
			});

			return false; 
	}
	
	function addwillperformdeletehope(){
		if(!confirm('기존의 정보는 초기화됩니다! 계속 하시겠어요?')) {
			return false;
		}
			 
			var serData = $('#addwillPerform').serialize();
			
			$.ajax({ 
			   url:'/wg/mylist/hope/update3', 
			   method:'post',
			   cache: false,  
			   data: serData,
			   dataType: 'json',
			   success: function(res) {
				   alert(res.deletehopeaddwillperform ? '수정 성공' : '수정 실패');
				   if(res.deletehopeaddwillperform) location.href='/wg/mywilllist';
			   },
			   error: function(xhr, status, err){
				   if(serData.wp_uid==null) {
						alert('로그인이 필요한 서비스입니다')
						location.href='/wg/login';
					} else {
					   alert("에러:" + err);			
					}
			   }
			}); 
			return false; 
	}

	
	function updatehopeperform(){
		var serData = $('#addhopePerform').serialize();
		
	$.ajax({ 
	   url:'/wg/mylist/hope/update', 
	   method:'post',
	   cache: false,  
	   data: serData,
	   dataType: 'json',
	   success: function(res) {
		   alert(res.updatehopeperform ? '수정 성공' : '수정 실패');
		   if(res.updatehopeperform) location.href='/wg/myhopelist';
	   },
	   error: function(xhr, status, err){
		   if(serData.wp_uid==null) {
				alert('로그인이 필요한 서비스입니다')
				location.href='/wg/login';
			} else {
			   alert("에러:" + err);			
			}
	   }
	});
	return false;
	}
	

</script>
<body>
<header>
  <h2>관람 희망 공연</h2><a href="/wg/home"><img src="/images/home.png"></a>
  <nav>
    <span><a href="/wg/mylist">나의 극장</a></span>
    <span> ｜ </span>
    <span><a href="/wg/myhopelist">목록</a></span>
  </nav>
</header>

<div class="content">
<c:forEach var="p" items="${hopeperform.perform}">
	<c:forEach var="i" items="${p.image}">
		<img src="/images/${i.imagepath}">
			<h3>${p.name}</h3>
	<p class="main">${p.genre}</p>
		</c:forEach>
	</c:forEach>
	<p class="main">기대지수 <a class="info"> ${hopeperform.hp_rating}</a></p>
	<p class="main">기대평 <a class="info"> ${hopeperform.hp_review}</a></p>
	</div>

<div style="clear:both"></div>

<div class="select">
	<input type="radio" id="end" name="opt" value="end" 
	onclick="document.getElementById('opt_end').style.display='block';document.getElementById('opt_will').style.display='none';document.getElementById('opt_hope').style.display='none';">
	<label for="end">관람한 공연</label>
	
	<input type="radio" id="will" name="opt" value="will" 
	onclick="document.getElementById('opt_will').style.display='block';document.getElementById('opt_end').style.display='none';document.getElementById('opt_hope').style.display='none';">
	<label for="will">관람 예정 공연</label>
	
	<input type="radio" id="hope" name="opt" value="hope" checked="checked"
	onclick="document.getElementById('opt_hope').style.display='block';document.getElementById('opt_end').style.display='none';document.getElementById('opt_will').style.display='none';">
	<label for="hope">관람 희망 공연</label>
</div>

<div style="clear:both"></div>
<div class="form">
<div class="endform">
<div id="opt_end"  style="display:none;" >
	<form id="updateendPerform" method="post" onsubmit="return addendperformdeletehope();">
		<input type="hidden" name="hp_num" value="${hopeperform.hp_num}">
		<input type="hidden" name="ep_pernum" value="${hopeperform.hp_pernum}">
		<div>
		<label for="ep_date">관람일</label>
			<input type="date" id="ep_date" name="ep_date" >
		</div>
		<div>
		<label for="ep_seat">좌석</label>
			<input type="text" id="ep_seat" name="ep_seat">
		</div>
		<div>
		<label for="ep_time">관람시간</label>
			<input type="time" id="ep_time" name="ep_time" >
		</div>
		<div>
		<label for="ep_cast">캐스트</label>
			<input type="text" id="ep_cast" name="ep_cast">
		</div>
		<div>
		<label for="ep_rating">평점</label>
			<input type="range" id="ep_rating" name="ep_rating" min="1" max="5" oninput="showRangeVal(this.value);" >
			<output id="range_out"></output>
		</div>
		<div>
		<label for="ep_review">리뷰</label>
			<textarea id="ep_review" name="ep_review" rows="5" cols="25"></textarea>
		</div>
		
		<div>
		<button type="submit">저장하기</button>
		</div>
	</form>
</div>
</div>

<div class="willform">
<div id="opt_will"  style="display:none;" >
	<form id="addwillPerform" method="post" onsubmit="return addwillperformdeletehope();">
		<input type="hidden" name="hp_num" value="${hopeperform.hp_num}">
		<input type="hidden" name="wp_pernum" value="${hopeperform.hp_pernum}">
		<div>
		<label for="wp_date">관람일</label>
			<input type="date" id="wp_date" name="wp_date">
		</div>
		<div>
		<label for="wp_date">관람시간</label>
			<input type="time" id="wp_time" name="wp_time" >
		</div>
		<div>
		<label for="wp_seat">좌석</label>
			<input type="text" id="wp_seat" name="wp_seat"  >
		</div>
		
		<div>
		<button type="submit">저장하기</button>
		</div>
	</form>
</div>
</div>

<div class="hopeform">
<div id="opt_hope"  >
	<form id="addhopePerform" method="post" onsubmit="return updatehopeperform();">
		<input type="hidden" name="hp_num" value="${hopeperform.hp_num}">
		<input type="hidden" name="p_pernum" value="${hopeperform.hp_pernum}">
		<div>
		<label for="hp_rating">기대지수</label>
			<input type="range" id="hp_rating" name="hp_rating" min="1" max="5" oninput="showRangeVal2(this.value);" value="${hopeperform.hp_rating}">
			<output id="range_out2"></output>
		</div>
		<div>
		<label for="hp_review">기대평</label>
			<textarea id="hp_review" name="hp_review" rows="5" cols="25">${hopeperform.hp_review}</textarea>
		</div>
		<div>
		<button type="submit">저장하기</button>
		</div>
</form>
</div>
</div>
</div>
 
</body>
</html>