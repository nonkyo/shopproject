<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "mall.member.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 확인 폼</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
#container {width: 1200px; margin: 0 auto;}
a {text-decoration :none; color: black;}
input[type="text"], input[type="password"] {height: 18px;}

/*상단 - 메인, 서브 타이틀*/
.t_title {font-family: 'Do Hyeon', sans-serif; margin-top: 10px;
 font-size: 2em; text-align:center; margin: 30px 0;}
 
 /* 중단 - 입력 테이블  */
 table {width: 500px; border: 1px solid black; border-collapse: collapse; margin: 0 auto;}
 tr { height: 60px; }
 th, td {border: 1px solid black; padding-left: 5px;}
 th { background: #ced4da;}
 .c_id {background: #ccc;}
 .s_id {color: red; font-size: 0.8em;}
 .addr_row {height: 100px;}
 .addr_row input {margin: 2px 0;}
#btn_address {width: 100px; height: 23px; border: none; background:#2f9277; 
 color: white; font-size: 13px; cursor: pointer; border-radius: 5px}
 table span {font-size: 0.8em;}
 
/* 하단 - 버튼 */
.btns {text-align: center; margin-top: 30px;}
.btns input[type=button] {width: 130px; height: 30px; background: black; 
color:white; border: none; font-weight: bold;cursor:pointer;}
.t_line {border:1px soild #e9ecef; margin: 30px 0;}
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<script>

	document.addEventListener("DOMContentLoaded", function() {
		let form = document.infoForm;	//폼 받기
		
		// 비밀번호 - pwd
		// 비밀번호 유효성 검사 - 4글자 이상의 비밀번호 생성
		let chk_pwd = document.getElementById("chk_pwd");
		form.pwd.addEventListener("keyup", function(){
			if(form.pwd.value.length < 4){
				chk_pwd.innerText = "비밀번호는 4글자 이상이어야 합니다";	
				chk_pwd.style.color = "red";
			}else{
				chk_pwd.innerText = "사용가능한 비밀번호입니다";
				chk_pwd.style.color ="blue";
			}
		})
		
		//비밀번호 확인- pwd2
		// 비밀번호와 비밀번호 확인 내용이 동일한지 유무 판단
		let chk_pwd2 = document.getElementById("chk_pwd2");
		form.pwd2.addEventListener("keyup", function(){
			if(form.pwd.value == form.pwd2.value){
				chk_pwd2.innerText = "비밀번호가 일치합니다.";
				chk_pwd2.style.color = "blue";
			}else{
				chk_pwd2.innerText = "비밀번호가 일치하지 않습니다.";
				chk_pwd2.style.color ="red";
			}
		})
		
		// 이메일 형식 검사 함수
		// 1. '@' 포함 하는지의 여부, 아이디가 세글자 이상인지 판별
		// 2. '@' 다음에 '.'을 포함하고 있는지의 여부 확인, 회사 이름도 세글자 이상인지 판별
		let isEmail = function(value){
			return (value.indexOf('@') > 2) && (value.split('@')[1].indexOf('.') > 2)
		}
		
		// 이메일 확인 유효성 검사
		let chk_email = document.getElementById("chk_email");
		
		form.email.addEventListener("keyup", function(event){
			let value = event.currentTarget.value;
			if(isEmail(value)){	//이메일 형식이 올바를때
				chk_email.innerText = "올바른 이메일 형식입니다 : " + value;
				chk_email.style.color = "blue";
			}else{	// 이메일 형식이 맞지 않을 때
				chk_email.innerText = "올바른 이메일 형식이 아닙니다 : " + value;
				chk_email.style.color = "red";
			}
		})
		
		// 주소 찾기 버튼 - 다음 라이브러리 사용
		let btn_address = document.getElementById("btn_address");
		btn_address.addEventListener("click", function(){
			new daum.Postcode({	// 라이브러리 이용
				oncomplete:function(data){  //제이슨 방법
					form.address.value = data.address;
				}
			}).open();
		})
		
		//회원정보수정버튼 클릭
		// 회원 수정 페이지의 전체 내용 입력 유무에 따른 유효성 검사와 페이지 이동 처리
		let btn_update = document.getElementById("btn_update");
		
		btn_update.addEventListener("click", function(){
			if(form.pwd.value.length == 0){
				alert('비밀번호를 입력하세요.');
				form.pwd.focus();
				return;
			}
			if(form.pwd2.value.length == 0){
				alert('비밀번호 확인을 하세요.');
				form.pwd2.focus();
				return;
			}
			if(form.pwd.value != form.pwd2.value){
				alert('비밀번호 확인이 비밀번호와 다릅니다.');
				form.pwd2.focus();
				return;
			}
			
			if(form.name.value.length == 0){
				alert('이름을 입력하세요');
				form.name.focus();
				return;
			}
			if(form.email.value.length == 0){
				alert('이메일을 입력하세요');
				form.email.focus();
				return;
			}
			if(form.tel.value.length == 0){
				alert('전화번호를 입력하세요');
				form.tel.focus();
				return;
			}
			if(form.address.value.length == 0){
				alert('주소 찾기 버튼을 눌러 주소를 입력하세요');
				form.address.focus();
				return;
			}
			if(form.address2.value.length == 0){
				alert('상세주소를 입력하세요');
				form.address2.focus();
				return;
			}
			
			// 최종적으로 실행 - > 폼 전송
			form.submit();
		})
		
		// 회원 탈퇴(삭제)
		let btn_delete = document.getElementById("btn_delete");
		btn_delete.addEventListener("click" , function(){
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
			if(!form.pwd2.value){
				alert('비밀번호 확인을 입력하세요');
				form.pwd2.focus();
				return;
			}
			if(form.pwd.value != form.pwd2.value){
				alert('비밀번호가 일치하지 않습니다.');
				form.pwd2.focus();
				return;
			}
			
			let answer = confirm('회원을 탈퇴하시겠습니까?');
			if(answer){
				form.action = 'memberDeletePro.jsp'; //폼에 걸려있는 액션을 변경하는 방법, 다른 페이지로 넘어갈수있음
				form.submit();
			}else{
				return;
			}
		})
		
	})
</script>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");

if(memberId == null){
	out.print("<script>location='../logon/memberLoginForm.jsp'</script>");
}

// 세션 멤버 아이디가 있을 때 실행
MemberDAO memberDAO = MemberDAO.getInstance();
MemberDTO member = new MemberDTO();
member = memberDAO.getMember(memberId);	//세션으로 받은 아이디를 memberDTO 객체에 넣음

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

%>
<div id="container">
	<jsp:include page="../common/shopTop.jsp"/>
	<div class="t_title">회원 정보 확인</div>
	
	<form action="memberUpdatePro.jsp" method="post" name="infoForm">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="id" size="15" value="<%=member.getId()%>" class="c_id" readonly>
					&ensp;<span class="s_id">아이디는 변경 불가</span>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="pwd" size="15" value="<%=member.getPwd()%>"><br>
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
				<td><input type="text" name="name" size="15" value="<%=member.getName()%>"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="email" size="30" value="<%=member.getEmail()%>"><br>
					<span id="chk_email"></span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="tel" size="20" value="<%=member.getTel()%>"></td>
			</tr>
			<tr class="addr_row">
				<th>주소</th>
				<td>
					<input type="button" value="주소 찾기" id="btn_address"><br>
					<input type="text" name="address" size="45"><br>
					<input type="text" name="address2" size="45">
				</td>
			</tr>
			<tr>
				<th>가입 일시</th>
				<td><%=sdf.format(member.getRegDate()) %></td>			
			</tr>
		</table>
		<div class="btns">
			<input type="button" value="회원정보수정" id="btn_update">&emsp;&emsp;
			<input type="button" value="회원 탈퇴" id="btn_delete">
		</div>
	</form>
	<hr class="t_line">
	<jsp:include page="../common/shopBottom.jsp" />
</div>
</body>
</html>