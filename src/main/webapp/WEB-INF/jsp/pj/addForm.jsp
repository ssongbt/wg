<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공연 정보 추가</title>
<style>
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
	body {
	    align-items: center;
	    background: #3d3f61;
	    color: #3d3f61;
	    display: grid;
	    font-family: $font-family;
	    font-size: 14px;
	    font-weight: 400;
	    height: 100vh;
	    justify-items: center;
	    weight: 100vw;
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
      line-height: 21px;
      padding-left: 5px;
      margin: 5px;}
	h3 { text-align:center; }
	label { text-align:right; display:inline-block; width:120px;  vertical-align:top;}
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
	#preview >img { width:100px; height:130px; margin-left:30px; }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript">
	
	function addperform(){
		
		var f = $("#files").get(0).files[0];
		if(f == undefined) {
			f = "";
		}
		
		var formData = new FormData(); 
		
		formData.append("name", $("#name").val()); 
		formData.append("startdate", $("#startdate").val());
		formData.append("enddate", $("#enddate").val());
		formData.append("loc", $("#loc").val());
		formData.append("genre", $("#genre").val());
		formData.append("run", $("#run").val());
		formData.append("cast", $("#cast").val());
		formData.append("synop", $("#synop").val());
		formData.append("files", f); 
		
	$.ajax({ 
	   url:'/wg/addPerform', 
	   method:'post',
	   enctype: 'multipart/form-data',
	   cache:false,
	   processData: false, 
	   contentType: false, 
	   data: formData,
	   dataType: 'json',
	   success: function(res) {
		   alert(res.addedPerform ? '공연정보 추가 성공' : '공연정보 추가  실패');
		   if(res.addedPerform) location.href='/wg/list';
	   },
	   error: function(xhr, status, err){
		   alert("에러:" + err);
	   }
	});
	return false;
	}
	

	function previewImage(f){

		var file = f.files;

		// 확장자 체크
		if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)){
			alert('gif, jpg, png 파일만 선택해 주세요.\n\n현재 파일 : ' + file[0].name);

			// 선택한 파일 초기화
			f.outerHTML = f.outerHTML;

			document.getElementById('preview').innerHTML = '';

		}
		else {

			// FileReader 객체 사용
			var reader = new FileReader();

			// 파일 읽기가 완료되었을때 실행
			reader.onload = function(rst){
				document.getElementById('preview').innerHTML = '<img src="' + rst.target.result + '">';
			}

			// 파일을 읽는다
			reader.readAsDataURL(file[0]);

		}
	}

	
</script>
</head>
<body>
<div class="form">
<form id="addForm"  method="post"  enctype="multipart/form-data" onsubmit="return addperform()">
<h2>공연 정보 추가</h2>
	<div>
	<label for="name">공연명</label>
		<input type="text" id="name" name="name">
	</div>
	<div>
	<label for="genre">장르</label>
		<input type="text" id="genre" name="genre">
	</div>
	<div>
	<label for="startdate">시작일</label>
		<input type="date" id="startdate" name="startdate">
	</div>
	<div>
	<label for="enddate">종료일</label>
		<input type="date" id="enddate" name="enddate">
	</div>
	<div>
	<label for="loc">공연장</label>
		<input type="text" id="loc" name="loc">
	</div>
	<div>
	<label for="run">러닝타임</label>
		<input type="text" id="run" name="run">
	</div>
	<div>
	<label for="cast">캐스트</label>
		<input type="text" id="cast" name="cast">
	</div>
	<div>
	<label for="synop">시놉시스</label>
		<textarea id="synop" name="synop" rows="5" cols="25"></textarea>
	</div>
	<div>
	<label for="imagepath">이미지</label>
		<input type="file" id="files" name="files" accept="image/*" onchange="previewImage(this);" />
		<div id="preview"></div>

	</div>
<div>
<button type="submit">저장</button>
<button type="reset">취소</button>
<button type="button" onclick="location.href='/wg/list'">목록</button>
</div>
</form>
</div>
</body>
</html>