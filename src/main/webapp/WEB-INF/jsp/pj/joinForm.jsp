<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>join</title>
<style>
	.join-page {  width: 360px; padding: 8% 0 0; margin: auto; }
	.form {
			  position: relative;
			  z-index: 1;
			  background: #dbd8d1;
			  max-width: 360px;
			  margin: 0 auto 100px;
			  padding: 45px;
			  text-align: center;
			  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
			}
	.form input {
				  font-family: "Roboto", sans-serif;
				  outline: 0;
				  background: #f2f2f2;
				  width: 100%;
				  border: 0;
				  margin: 0 0 15px;
				  padding: 15px;
				  box-sizing: border-box;
				  font-size: 14px;
				}
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
			}
	.form button:hover,.form button:active,.form button:focus {
					  background: #56473c;
					}
	.form .message {float:right;
					  margin: 0 0 10px;
					  color: #b3b3b3;
					  font-size: 12px;
					}
	.form .message a {
	  color: #3d3f61;
	  text-decoration: none;
	}
		body {
		  background: #3d3f61; /* fallback for old browsers */
		  background: #3d3f61;
		  font-family: "Roboto", sans-serif;
		  -webkit-font-smoothing: antialiased;
		  -moz-osx-font-smoothing: grayscale;      
		}	
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	var idchecked = false;
	
	function checked(uid) {
	
		var obj = {};
		obj.uid = uid;
		
		$.ajax({
	        url:'/wg/idcheck',
	        method:'post',
	        cache:false,
	        data:obj,
	        dataType:'json',
	        success:function(res){
	           alert(res.checked ? '사용가능한 ID입니다' : '중복된 ID입니다');
	           idchecked = res.checked;
	        },
	        error:function(xhr, status, err){
	           alert('에러:'+err);
	        }
	     });
		
	}

	function adduser() {
		if(!idchecked) {
			alert('ID중복검사를 해주세요')
			return;
		} 

		var serData = $('#joinForm').serialize();
		$.ajax({
			url:'/wg/join',
			method:'post',
			cache:false,
			async:false,
			data:serData,
			dataType:'json',
			success:function(res){
				alert(res.useradded ? '회원가입을 축하드립니다' : '정보를 다시 확인해주세요');
				if(res.useradded) location.href='/wg/login';
			},
			error:function(xhr,status,err){
				alert('에러:'+err);
			}
		});
		return false;
	}

	function passcheck(){
		
		var pwd1 = $('#pwd').val();
		var pwd2 = $('#pwd_check').val();
		if (pwd1!=pwd2) {
		   alert('패스워드가 불일치합니다');
		}
	}

</script>
</head>
<body>
<main>
<div class="join-page">
<div class="form">
		<div>
			<img src="/images/logo.png">
		</div>
<form id="joinForm" onsubmit="return adduser();">
<input type="hidden">
	<div>
		<input type="text" id="uid" name="uid" placeholder="ID">
		<p class="message"><a href="javascript:checked($('#uid').val());">ID check</a>
	</div>
	<div>
		<input type="text" id="nick" name="nick" placeholder="name">
	</div>
	<div>
		<input type="password" id="pwd" name="pwd" placeholder="password">
	</div>
	<div>
		<input type="password" id="pwd_check" name="pwd_check"  placeholder="password check" onchange="passcheck()">
	</div>
	<div>
		<button type="button" onclick="javascript:adduser()">CREATE</button>
	</div>
</form>
</div>
</div>
</main>
</body>
</html>