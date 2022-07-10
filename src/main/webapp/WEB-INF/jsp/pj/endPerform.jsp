<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<style>
	img { width: 200px; }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	$(function(){
		$('#range_out').val(3);
	});
	function showRangeVal(num){
		$('#range_out').val(num);
		
	}
	function addendperform(){
		var serData = $('#addendPerform').serialize();
		
	$.ajax({ 
	   url:'/wg/addEndPerform', 
	   method:'post',
	   cache: false,  
	   data: serData,
	   dataType: 'json',
	   success: function(res) {
		   alert(res.addendPerform ? '업로드 성공' : '업로드 실패');
		   if(res.addendPerform) location.href='/wg/list';
	   },
	   error: function(xhr, status, err){
		   alert("에러:" + err);
	   }
	});
	return false;
	}
	
</script>
</head>
<body>
<h3>관람한 공연</h3>
<form id="addendPerform" method="post" onsubmit="return addendperform()">
	<input type="hidden" name="per_num" value="${perform.num}">
	<div>
	<img src="/images/${perform.imagepath}">
	</div>
	<div>
	<label>좌석</label>
		<input type="text" id="seat" name="seat">
	</div>
	<div>
	<label>관람일</label>
		<input type="date" id="date" name="date">
	</div>
	<div>
	<label>캐스트</label>
		<input type="text" id="cast" name="cast">
	</div>
	<div>
	<label>평점</label>
		<input type="range" id="rating" name="rating" min="1" max="5" oninput="showRangeVal(this.value);">
		<output id="range_out"></output>
	</div>
	<div>
	<label>리뷰</label>
		<textarea id="review" name="reivew" rows="5" cols="25"></textarea>
	</div>
	
	<div>
	<button type="submit">저장하기</button>
	</div>
</form>
</body>
</html>