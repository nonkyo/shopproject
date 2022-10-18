<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Volkhov&display=swap');
#container {width: 1200px; margin: 0 auto;}
a {text-decoration: none; color: black;}
/*상단 메인, 서브타이틀 */
.t_title {font-family: 'Volkhov', serif; font-size: 2em; text-align:center; margin-bottom: 30px; margin-top: 30px;}

/* 중단 입력창 */
.f_input {width:450px; text-align: center; border: 1px solid #ccc; padding: 10px; margin: 0 auto;}
.f_input .c_id, .f_input .c_pwd {height: 45px; padding-left: 5px; margin-top: 20px;}
.f_input #btn_login {width: 405px; height: 47px; margin-top: 25px; background: black; 
color:white; font-weight: bold; font-size:16px; cursor: pointer; margin-top: 20px; margin-bottom: 10px;}
.f_input .f_chk {text-align: left; margin:10px 0 0 20px; font-size: 0.9em; color: gray;}
/* 하단 - 찾기, 회원가입*/
.f_a {text-align: center; margin-top: 30px; font-size: 0.9em;}
.f_a a { color: lightgray;}
.t_line {border: 1px solid #e9ecef; margin: 30px 0;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function(){
		let form = document.loginForm;
		
		// 로그인 버튼을 클릭했을 때 유효성 검사(공백 유무)
		let btn_login = document.getElementById("btn_login");
		btn_login.addEventListener("click", function(){
			if(!form.id.value){
				alert('아이디를 입력하세요');
				form.id.focus();
				return;
			}
			if(!form.pwd.value){
				alert('비밀번호를 입력하세요');
				form.pwd.focus();
				return;
			}
			form.submit();
		})
			
		// 쿠키가 생성돼있을 때 쿠키에 저장된 값(아이디)을 아이디 입력상자에 넣도록 하는 작업
		// 쿠키 확인 - 쿠키가 존재한다면
		if(document.cookie.length > 0){		//쿠키가 존재한다면
			let search = "cookieId=";
			let idx = document.cookie.indexOf(search); // 쿠키 중에서 cookieId= 이 나오는 위치를 찾음
			if(idx != -1){		// cookieId 값이 존재한다면
				idx += search.length;
				let end = document.cookie.indexOf(';', idx);
				
				if(end == -1){
					end = document.cookie.length;
				}
				
				form.id.value = document.cookie.substring(idx, end);
				form.chk.checked = true;
			}		
		}
		
		// 로그인 상태 유지 체크박스 체크했을 때 -> 쿠키 
		// http 속성: 연결상태를 유지하지 않음
		// Cookie session 속성: 연결 상태를 유지, cookie: 연결 정보를 클라이언트 쪽에 저장, session: 연결정보를 서버쪽에 저장
		// escape()함수 - *, -, _, +, ., / 를 제외한 모든 문자를 16진수로 변환하는 방법 
		// 쉼표, 세미콜론 등과 같은 문자가 쿠키에서 사용되는 문자열과 충돌을 방지하기 위해 사용
		let chk = document.getElementById("chk");
		chk.addEventListener("click", function(){
			let now = new Date();		// 오늘 날짜
			let name = "cookieId";		// 쿠키의 이름 정함
			let value = form.id.value;	// 쿠키의 값 설정
			
			if(form.chk.checked == true){		// 체크했을 때 -> 쿠키 생성, 쿠키 만료시간 설정
				now.setDate(now.getDate() + 7);	// 만료시간: 날짜를 지금으로부터 일주일 후로 설정
			}else{								// 체크 해제했을 때 -> 쿠키 삭제
				now.setDate(now.getDate() + 0);	// 만료시간: 현재시간으로 설정
			}
			// 쿠키 생성시에 필요한 정보: 쿠키의 이름과 값, 쿠키 위치, 만료시간
			document.cookie = name + "=" + escape(value) + 
			";path=/;expires=" + now.toGMTString() + ";";
			
		})
		
	})
	
</script>
</head>
<body>
<div id="container">
	<jsp:include page="../common/shopTop.jsp" />
	<div class="t_title">LOGIN</div>
	<form action="memberLoginPro.jsp" method="post" name="loginForm">
		<div class="f_input">
			<div class="f_id"><input type="text" id="id" name="id" class="c_id" placeholder="아이디" size="55"></div>
			<div class="f_pwd"><input type="password" id="pwd" name="pwd" class="c_pwd" placeholder="비밀번호" size="55"></div>
			<div class="f_chk">
				<input type="checkbox" id="chk" class="c_chk" size="55">&ensp;
				<label for="chk">아이디 저장</label>
			</div>
			<div class="f_submit"><input type="button" value="로그인" id="btn_login"></div>
		</div>
		<div class="f_a">
			<a href="">비밀번호 찾기</a>&emsp;|&emsp;
			<a href="">아이디 찾기</a>&emsp;|&emsp;
			<a href="../member/memberJoinForm.jsp">회원가입</a>
		</div>
	</form>
	<hr class="t_line">
	<jsp:include page="../common/shopBottom.jsp"></jsp:include>
</div>
</body>
</html>