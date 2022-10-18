<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 폼</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Paytone+One&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
#container { width: 550px; margin: 0 auto;}
a { text-decoration: none; color: black;}
/* 상단 - 메인, 서브 타이틀 */
.m_title { font-family: 'Paytone One', sans-serif; font-size: 3em; text-align: center;}
.s_title { font-family: 'Do Hyeon', sans-serif; font-size: 2em; text-align: center; margin-bottom: 30px;}
a { text-decoration: none; color: #59637f; font-size: 0.95em; font-weight: bold;}
.c_logout { text-align: center; margin-bottom: 10px;}
.c_logout a { color: #99424f;}
/* 중단 - 상품 등록 테이블 */
table { width: 100%; border: 1px solid #2f9e77; border-collapse: collapse; 
border-top: 3px solid #2f9e77; border-bottom: 3px solid #2f9e77; border-left: hidden; border-right: hidden;}
tr { height: 35px;}
td, th { border: 1px solid #2f9e77;}
th { background: #d8f4e6;}
td { padding-left: 5px;}
/* 중단 - 테이블 안의 입력상자 */
input[type="number"] { width: 100px;}
textarea { margin-top: 5px;}
/* 하단 - 버튼 */
select { height: 24px;}
input::file-selector-button { width: 90px; height: 28px; background: #2f9e77; color: #fff; border: none;
border-radius: 3px; font-weight: bold; cursor: pointer;}
.btns { text-align: center; margin-top: 10px;}
.btns input { width: 100px; height: 37px; border: none; background: #495057; color: #fff; 
font-weight: bold; margin: 5px; cursor: pointer;}
.btns input:nth-child(1) { background: #2f9e77;}
.btns input:nth-child(1):hover { border: 2px solid #2f9e77; background: #fff; color: #2f9e77; font-weight: bold;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.registerForm;
		// 상품 등록 처리 페이지로 이동
		let btn_register = document.getElementById("btn_register");
		btn_register.addEventListener("click", function() {
			if(!form.product_name.value) {
				alert('상품 제목을 입력하시오.');
				return;
			}
			if(!form.product_price.value) {
				alert('상품 가격을 입력하시오.');
				return;
			}
			if(!form.product_count.value) {
				alert('상품 재고를 입력하시오.');
				return;
			}
			if(!form.discount_rate.value) {
				alert('상품 할인율을 입력하시오.');
				return;
			}
			form.submit();
		})
		
		// 상품 목록 페이지로 이동
		let btn_list = document.getElementById("btn_list");
		btn_list.addEventListener("click", function() {
			location = 'productList.jsp';
		})
		
		// 관리자 페이지로 이동
		let btn_main = document.getElementById("btn_main");
		btn_main.addEventListener("click", function() {
			location = '../managerMain.jsp';
		})
		
	})
</script>
</head>
<body>
<%
String managerId = (String)session.getAttribute("managerId");
if(managerId == null) {
	out.print("<script>location='../logon/managerLoginForm.jsp';</script>");
}
%>
<div id="container">
	<div class="m_title"><a href="../managerMain.jsp">Puppy Lover</a></div>
	<div class="s_title">상품 등록</div>
	
	<form action="productRegisterPro.jsp" method="post" name="registerForm" enctype="multipart/form-data">
		<table>
			<tr>
				<th width="20%">상품 분류</th>
				<td width="80%">
					<select name="product_kind">
						<option value="110" selected>하우스</option>
						<option value="120">쿠션</option>
						<option value="130">그루밍</option>
						<option value="210">사료</option>
						<option value="220">습식</option>
						<option value="230">영양제</option>
						<option value="240">간식</option>
						<option value="310">목줄/하네스</option>
						<option value="320">리드줄</option>
						<option value="330">이동장</option>
						<option value="410">올인원</option>
						<option value="420">상의</option>
						<option value="430">드레스</option>
						<option value="440">아우터</option>
						<option value="450">악세사리</option>
						<option value="510">패브릭</option>
						<option value="520">실리콘</option>
						<option value="530">노즈워크</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>상품 제목</th>
				<td><input type="text" name="product_name" size="56"></td>
			</tr>
			<tr>
				<th>상품 가격</th>
				<td><input type="number" name="product_price" min="1000" max="1000000">원</td>
			</tr>
			<tr>
				<th>상품 색깔</th>
				<td><input type="text" name="product_color"></td>
			</tr>
			<tr>
				<th>상품 사이즈</th>
				<td><input type="text" name="product_size" size="56"></td>
			</tr>
			<tr>
				<th>상품 재고</th>
				<td><input type="number" name="product_count"></td>
			</tr>
			<tr>
				<th>상품 이미지(메인)</th>
				<td><input type="file" name="product_image1"></td>
			</tr>
			<tr>
				<th>상품 상세 이미지1</th>
				<td><input type="file" name="product_image2"></td>
			</tr>
			<tr>
				<th>상품 상세 이미지2</th>
				<td><input type="file" name="product_image3"></td>
			</tr>
			<tr>
				<th>상품 내용</th>
				<td><input type="file" name="product_content"></td>
			</tr>
			<tr>
				<th>할인율</th>
				<td><input type="number" name="discount_rate" min="0" max="90">%</td>
			</tr>
		</table>
		<div class="btns">
			<input type="button" value="상품 등록" id="btn_register">
			<input type="reset" value="다시 입력">
			<input type="button" value="상품 목록" id="btn_list">
			<input type="button" value="관리자 페이지" id="btn_main">
		</div>
	</form>
</div>
</body>
</html>