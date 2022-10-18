<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 폼</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
#container { width: 300px; margin: 0 auto;}
a { text-decoration: none; color: black;}
/* 상단 - 메인, 서브 타이틀 */
.m_title { font-family: 'Paytone One', sans-serif; font-size: 3em; text-align: center;}
.s_title { font-family: 'Do Hyeon', sans-serif; font-size: 2em; text-align: center; margin-bottom: 30px;}
/* 중단 - 로그인 박스 */
.b_box { border: 1px solid lightgray; padding: 5px; margin: 10px;}
.b_box input[type='text'], .b_box input[type='password'] { height: 30px; padding-left: 30px; border: none;}
.b_box input[type='text']:focus, .b_box input[type='password']:focus { outline: none;}
.b_box input[type='text'] { background: url('../../icons/login_id.png') no-repeat; 
background-size: 26px; background-position: left center;}
.b_box input[type='password'] { background: url('../../icons/login_pwd.png') no-repeat; 
background-size: 23px; background-position: left center;}
.c_box { margin: 10px;}
.c_box input[type='button'] { width: 280px; height: 45px; border: none; background: #5e869c; color: #fff;
font-weight: bold; font-size: 1.03em;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
	let form = document.managerLoginForm;
	
	let btn_login = document.getElementById("btn_login");
	btn_login.addEventListener("click", function() {
		if(!form.managerId.value) {
			alert('아이디를 입력하시오.');
			return;
		}
		if(!form.managerPwd.value) {
			alert('비밀번호를 입력하시오.');
			return;
		}
		form.submit();
	})
})
</script>
</head>
<body>

<div id="container">
	<div class="m_title"><a href="#">Puppy Lover</a></div>
	<div class="s_title">관리자 로그인</div>
	
	<form action="managerLoginPro.jsp" method="post" name="managerLoginForm">
		<div class="a_box">
			<div class="b_box">
				<input type="text" name="managerId" id="managerId" placeholder="아이디" size="28">
			</div>
			<div class="b_box">
				<input type="password" name="managerPwd" id="managerPwd" placeholder="비밀번호" size="28">
			</div>
			<div class="c_box">
				<input type="button" value="로그인" id="btn_login">
			</div>
		</div>
	</form>
</div>

</body>
</html>