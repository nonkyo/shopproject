<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
#container { width: 1200px; margin: 0 auto;}
a { text-decoration: none; color: black;}
input[type="text"], input[type="password"] { height: 18px;}
/* 상단 - 메인, 서브 타이틀 */
.t_title { font-family: 'Do Hyeon', sans-serif; font-size: 2em; text-align: center; margin: 30px 0;}
/* 중단 - 입력 테이블 */
table { width: 500px; border: 1px solid black; border-collapse: collapse; margin: 0 auto;}
tr { height: 65px;}
th, td { border: 1px solid black; padding-left: 5px;}
th { background: #ced4da;}
.addr_row { height: 100px;}
.addr_row input { margin: 2px 0;}
#btn_chk_id { width: 100px; height: 28px; border: none; background: #1e94be; color: white; font-size: 12px;
cursor: pointer; border-radius: 3px; margin-left: 10px;}
#btn_address { width: 100px; height: 28px; border: none; background: #2f9277; color: white; font-size: 12px;
cursor: pointer; border-radius: 3px;}
table span { font-size: 0.8em;}
/* 하단 - 가입, 취소 버튼 */
.btns { text-align: center; margin-top: 30px;}
.btns input[type="button"] { width: 120px; height: 40px; background: black; color: white; border: none;
font-size: 14px; font-weight: bold; cursor: pointer;}
.t_line {border:1px soild #e9ecef; margin: 30px 0;}
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<script>
	let isChk = false; // 전역변수
	
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.joinForm;
		
		// ID 중복 체크 버튼 - DB 작업: member 테이블에 똑같은 id가 있는지를 검사
		let btn_chk_id = document.getElementById("btn_chk_id");
		btn_chk_id.addEventListener("click", function() {
			isChk = true;
			if(form.id.value.length < 4) { // 아이드를 4글자 미만을 입력했을 때
				alert('아이디를 4글자 이상 입력해 주세요.');
				form.id.focus();
			} else { // 아이디를 4글자 이상 입력했을 때
				location = 'memberIdCheck.jsp?id=' + form.id.value;
			}
		})
		
		// 비밀번호 - pwd
		// 비밀번호 유효성 검사 - 4글자 이상이 비밀번호를 생성
		let chk_pwd = document.getElementById("chk_pwd");
		form.pwd.addEventListener("keyup", function() {
			if(form.pwd.value.length < 4) {
				chk_pwd.innerText = "비밀번호는 4글자 이상이어야 합니다.";
				chk_pwd.style.color = "red";
			} else {
				chk_pwd.innerText = "사용가능한 비밀번호입니다.";
				chk_pwd.style.color = "blue";
			}
		})
		
		// 비밀번호 확인 - pwd2
		// 비밀번호와 비밀번호 확인의 내용이 동일한지 유무를 판단
		let chk_pwd2 = document.getElementById("chk_pwd2");
		form.pwd2.addEventListener("keyup", function() {
			if(form.pwd.value == form.pwd2.value) {
				chk_pwd2.innerText = "비밀번호가 일치합니다.";
				chk_pwd2.style.color = "blue";
			} else {
				chk_pwd2.innerText = "비밀번호가 일치하지 않습니다.";
				chk_pwd2.style.color = "red";
			}
		})
		
		// 이메일 검사 함수
		let isEmail = function(value) {
			return (value.indexOf('@') > 2) && (value.split('@')[1].indexOf('.') > 2)
		}
		
		// 이메일 확인
		// 1. '@'문자를 포함하고 있는지의 여부 -> 아이디가 3글자 이상인지를 판별
		// 2. '@'문자 다음에 '.'을 포함하고 있는지의 여부 -> 회사이름도 3글자 이상인지를 판별
		let chk_email = document.getElementById("chk_email");
		form.email.addEventListener("keyup", function(event) {
			let value = event.currentTarget.value;
			
			if(isEmail(value)) { // 이메일 형식이 맞을 때
				chk_email.innerText = "이메일 형식이 맞습니다. : " + value;
				chk_email.style.color = "blue";
			} else { // 이메일 형식이 아닐 때
				chk_email.innerText = "이메일 형식이 아닙니다. : " + value;
				chk_email.style.color = "red";
			}
		})
		
		// 주소 찾기 버튼 - 다음 라이브러리 활용
		let btn_address = document.getElementById("btn_address");
		btn_address.addEventListener("click", function() {
			new daum.Postcode({
				oncomplete:function(data) {
					form.address.value = data.address;
				}
			}).open();
		})
		
		// 회원 가입 페이지의 전체 내용 입력 유무에 따른 유효성 검사와 페이지 이동 처리
		let btn_insert = document.getElementById("btn_insert");
		btn_insert.addEventListener("click", function() {
			if(form.id.value.length == 0) {
				alert('아이디를 입력하고, 아이디 중복 체크를 하시오!');
				form.id.focus();
				return;
			}
			if(!isChk) {
				alert('아이디 중복 체크를 하시오!');
				form.id.focus();
				return;
			}
			if(form.pwd.value.length == 0) {
				alert('비밀번호를 입력하시오!');
				form.pwd.focus();
				return;
			}
			if(form.pwd2.value.length == 0) {
				alert('비밀번호 확인을 입력하시오!');
				form.pwd2.focus();
				return;
			}
			if(form.pwd.value != form.pwd2.value) {
				alert('비밀번호 확인이 비밀번호와 다릅니다!');
				form.pwd2.focus();
				return;
			}			
			if(form.name.value.length == 0) {
				alert('이름을 입력하시오!');
				form.name.focus();
				return;
			}
			if(form.email.value.length == 0) {
				alert('이메일을 입력하시오!');
				form.email.focus();
				return;
			}
			if(form.tel.value.length == 0) {
				alert('전화번호를 입력하시오!');
				form.tel.focus();
				return;
			}
			if(form.address.value.length == 0) {
				alert('주소 찾기 버튼을 클릭하여 주소를 선택하시오!');
				form.address.focus();
				return;
			}
			if(form.address2.value.length == 0) {
				alert('상세주소 입력하시오!');
				form.address2.focus();
				return;
			}
			form.submit();		
		})
		//취소버튼 클릭
		let btn_cancle = document.getElementById("btn_cancle");
		btn_cancle.addEventListener("click", function(){
			location = '../shopping/shopAll.jsp';
		})
				
	})
</script>
</head>
<body>
<div id="container">
	<jsp:include page="../common/shopTop.jsp" />
	<div class="t_title">회원 가입</div>
	<form action="memberJoinPro.jsp" method="post" name="joinForm">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="id" size="15">
					<input type="button" value="ID 중복 체크" id="btn_chk_id"><br>
					<span id="chk_id"></span>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="pwd" size="15"><br>
					<span id="chk_pwd"></span>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>
					<input type="password" name="pwd2" size="15"><br>
					<span id="chk_pwd2"></span>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" size="15"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="email" size="30"><br>
					<span id="chk_email"></span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="tel" size="20"></td>
			</tr>
			<tr class="addr_row">
				<th>주소</th>
				<td>
					<input type="button" value="주소 찾기" id="btn_address"><br>
					<input type="text" name="address" size="49"><br>
					<input type="text" name="address2" size="49">
				</td>
			</tr>
		</table>
		<div class="btns">
			<input type="button" value="회원가입" id="btn_insert">&emsp;&emsp;
			<input type="button" value="취소" id="btn_cancel">
		</div>
	</form>
	<hr class="t_line">
	<jsp:include page="../common/shopBottom.jsp" />
</div>

</body>
</html>