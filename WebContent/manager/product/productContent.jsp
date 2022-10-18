<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 보기</title>
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
table { width: 100%; border: 1px solid #705e7b; border-collapse: collapse; 
border-top: 3px solid #705e7b; border-bottom: 3px solid #705e7b; border-left: hidden; border-right: hidden;}
tr { height: 35px;}
td, th { border: 1px solid #705e7b;}
th { background: #e6c9e1;}
td { padding-left: 5px;}
/* 중단 - 테이블 안의 입력상자 */
.c_p_id, .c_p_reg_date { background: #e9ecef;}
.s_p_id, .s_p_reg_date { color: #f00; font-size: 0.8em; font-weight: bold; margin-left: 10px;}
.s_p_image { color: #00f; font-size: 0.8em;}
input[type="number"] { width: 100px;}
textarea { margin-top: 5px;}
/* 하단 - 버튼 */
select { height: 24px;}
input::file-selector-button { width: 90px; height: 28px; background: #705e7b; color: #fff; border: none;
border-radius: 3px; font-weight: bold; cursor: pointer;}
.btns { text-align: center; margin-top: 10px;}
.btns input { width: 100px; height: 37px; border: none; background: #495057; color: #fff; 
font-weight: bold; margin: 5px; cursor: pointer;}
.btns input:nth-child(1), .btns input:nth-child(2) { background: #705e7b;}
.btns input:nth-child(1):hover, .btns input:nth-child(2):hover { border: 2px solid #2f9e77; background: #fff; color: #2f9e77; font-weight: bold;}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		let form = document.updateForm;
		
		// 상품 분류가 선택되도록 설정 
		let product_kind = form.product_kind;   // select 태그
		let p_kind = form.p_kind;               // ex) 자기계발: 310이 있는 input 태그
		for(let i=0; i<product_kind.length; i++) {
			if(p_kind.value == product_kind[i].value) {
				product_kind[i].selected = true;
				break;
			}
		}
		
		// 상품 수정 처리 페이지로 이동
		let btn_update = document.getElementById("btn_update");
		btn_update.addEventListener("click", function() {
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
				alert('할인율을 입력하시오.');
				return;
			}
			form.submit();
		})
		
		// 상품 삭제 처리 페이지로 이동
		let product_id = form.product_id.value;
		let pageNum = form.pageNum.value;
		let btn_delete = document.getElementById("btn_delete");
		btn_delete.addEventListener("click", function() {
			location = 'productDeletePro.jsp?product_id=' + product_id + "&pageNum=" + pageNum;
		})
		
		// 상품 목록 페이지로 이동
		let btn_list = document.getElementById("btn_list");
		btn_list.addEventListener("click", function() {
			location = 'productList.jsp?pageNum=' + pageNum;
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

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

String pageNum = request.getParameter("pageNum");
int product_id = Integer.parseInt(request.getParameter("product_id"));

// DB 연결, 질의
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);
%>
<div id="container">
	<div class="m_title"><a href="../managerMain.jsp">Puppy Lover</a></div>
	<div class="s_title">상품 정보 확인</div>
	
	<form action="productUpdatePro.jsp" method="post" name="updateForm" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<table>
			<tr>
				<th>상품번호</th>
				<td>
					<input type="text" name="product_id" value="<%=product.getProduct_id()%>" size="10" readonly class="c_p_id">
					<span class="s_p_id">상품번호는 변경불가</span>
				</td>
			</tr>
			<tr>
				<th width="20%">상품 분류</th>
				<td width="80%">
					<input type="hidden" name="p_kind" value="<%=product.getProduct_kind()%>">
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
				<td><input type="text" name="product_name" size="56" value="<%=product.getProduct_name() %>"></td>
			</tr>
			<tr>
				<th>상품 가격</th>
				<td><input type="number" name="product_price" min="1000" max="1000000" value="<%=product.getProduct_price() %>">원</td>
			</tr>
			<tr>
				<th>상품 색깔</th>
				<td><input type="text" name="product_color" value="<%=product.getProduct_color() %>"></td>
			</tr>
			<tr>
				<th>상품 사이즈</th>
				<td><input type="text" name="product_size" size="56" value="<%=product.getProduct_size() %>"></td>
			</tr>
			<tr>
				<th>상품 재고</th>
				<td><input type="number" name="product_count" value="<%=product.getProduct_count() %>"></td>
			</tr>
			<tr>
				<th>상품 이미지(메인)</th>
				<td><input type="file" name="product_image1" ></td>
			</tr>
			<tr>
				<th>상품 상세 이미지1</th>
				<td><input type="file" name="product_image2" ></td>
			</tr>
			<tr>
				<th>상품 상세 이미지2</th>
				<td><input type="file" name="product_image3" ></td>
			</tr>
			<tr>
				<th>상품 내용</th>
				<td><input type="file" name="product_content" ></td>
			</tr>
			<tr>
				<th>할인율</th>
				<td><input type="number" name="discount_rate" min="0" max="90" value="<%=product.getDiscount_rate() %>">%</td>
			</tr>
		</table>
		<div class="btns">
			<input type="button" value="상품 정보 수정" id="btn_update">
			<input type="button" value="상품 정보 삭제" id="btn_delete">
			<input type="button" value="상품 목록" id="btn_list">
			<input type="button" value="관리자 페이지" id="btn_main">
		</div>
	</form>
</div>
</body>
</html>