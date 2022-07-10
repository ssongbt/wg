<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인</title>
<style>
	.login-page {  width: 360px; padding: 8% 0 0; margin: auto; }
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
	.form .message {
					  margin: 15px 0 0;
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

	function login() {
		var serData = $('#loginForm').serialize();
		$.ajax({
			url:'/wg/login',
			method:'post',
			cache:false,
			data:serData,
			dataType:'json',
			success:function(res){
				alert(res.ok ? '로그인 성공' : '로그인 실패');
				if(res.ok) location.href='/wg/home';
			},
			error:function(xhr,status,err){
				alert('에러:'+err);
			}
		});
	return false;
}
</script>
</head>
<body>
<main>
<div class="login-page">
<div class="form">
	<form id="loginForm" onsubmit="return login();">
		<div>
			<img src="/images/logo.png">
		</div>
		<div>
			<input type="text" id="uid" name="uid" placeholder="user name"/>
		</div>
		<br>
		<div>
			<input type="password" id="pwd" name="pwd"  placeholder="password"/>
		</div>
		<br>
		<div>
			<button type="button" onclick="javascript:login()">LOGIN</button>
		</div>
		<p class="message">Not registered? <a href="/wg/join">Create an account</a></p>
	</form>
</div>
</div>
	<br>

</main>
</body>
</html>