<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>My Info</title>
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
			body { padding-top: 105px; background: #EEE; }
	body, html {	height: 130%;	}
		.my-page {  width: 360px; padding: 8% 0 0; margin: auto; }
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
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>

var passchecked = false;

function updateuser() {

	if(!passchecked) {
		alert('패스워드를 확인해주세요');
		return ;
	} 
	
	else if(passchecked){
		alert('정말 수정하시겠어요?');

		var serData = $('#updateUserForm').serialize();
		
		$.ajax({
			url:'/wg/myinfo/update',
			method:'post',
			cache:false,
			traditional : true,
			async:false,
			data:serData,
			dataType:'json',
			success:function(res){
				alert(res.updateduser ? '회원정보가 수정되었습니다' : '회원정보 수정에 실패했습니다');
				if(res.updateduser) location.href='/wg/myinfo';
			},
			error:function(xhr,status,err){
				alert('에러:'+err);
			}
		});
		return false;
	}
	}

function passcheck(){
	
	var pwd1 = $('#pwd').val();
	var pwd2 = $('#pwd_check').val();
	if (pwd1!=pwd2) {
	   alert('패스워드가 불일치합니다');
	}else if(pwd1==pwd2){
		passchecked = true;
	}
}

function deleteuser(uid) {
	
	if(!passchecked || $('#pwd_check').val()==null) {
		alert('패스워드를 확인해주세요');
		return ;
	} 
	
	if(passchecked){
		if(!confirm('정말 탈퇴하시겠어요?')) {
			return false;
		}
	
	var obj = {};
	obj.uid = uid;
	
	$.ajax({
		url:'/wg/myinfo/delete',
		method:'post',
		cache:false,
		data:obj,
		dataType:'json',
		success:function(res){
			alert(res.deleteduser ? '탈퇴되었습니다. 이용해주셔서 감사했어요!' : '탈퇴 실패');
			if(res.deleteduser) location.href='/wg/login';
		},
		error:function(xhr,status,err){
			alert('에러:'+err);
		}
	});
	}

}

</script>
</head>
<body>
<header>
  <h1>나의 정보</h1><a href="/wg/home"><img src="/images/home.png"></a>
  <nav>
    <span> ${user.nick} 님</span>
    <span> ｜ </span>
    <span> <a href="/wg/logout">로그아웃</a></span>

  </nav>
</header>

<main>
<div class="my-page">
<div class="form">
<form id="updateUserForm" onsubmit="return updateuser();" method="post">
<input type="hidden">
	<div>
		<input type="text" id="uid" name="uid" value="${user.uid}" readonly="readonly">
	</div>
	<div>
		<input type="text" id="nick" name="nick" value="${user.nick}">
	</div>
	<div>
		<input type="password" id="pwd" name="pwd" value="${user.pwd}">
	</div>
	<div>
		<input type="password" id="pwd_check" name="pwd_check"  placeholder="password check" onchange="passcheck();">
	</div>
	<div>
		<button type="button" onclick="javascript:updateuser();">EDIT</button>
	</div>
	<p class="message">탈퇴를 원하신다면? <a href="javascript:deleteuser('${user.uid}')">Unregister</a></p>
</form>
</div>
</div>
</main>
</body>
</html>