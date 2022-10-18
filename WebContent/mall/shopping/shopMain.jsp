<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="manager.product.*, java.util.*, java.text.*" %>
<%-- 쇼핑몰 메인 페이지 : 상품이 나열되는 페이지 --%>
<%-- 상품의 분류별 전체 보기 --%>
<style>
/*상품 분류별*/
.t_kind {margin-top:80px;}
.d_kind1 {text-align: right; margin-bottom: 10px; margin-left: 27px;}
.d_kind1 .s_kind1 {display: inline-block; float: left;}
.d_kind1 .s_kind11 {font-size: 1.1em; color: blue;}
.d_kind1 .s_kind2 select {margin-right: 58px; width: 150px; height: 25px;}
.d_kind2 {margin-left: 27px; margin-bottom: 10px; clear:both;}
.d_kind2 .s_kind21 {color: orange;}
/*상품 분류별 노출 */
.d_kind3 {text-align: center; position:relative; float: left; font-size: 0.9em; margin-bottom: 0;}
.d_kind3 a { color: black; font-size: 0.9em;}
.c_product {display: inline-block; width:250px; height: 350px; padding: 10px; margin: 10px; padding: 8px;}
.c_product a {text-decoration: none;}
.c_product .c_p1, .c_product .c_p2 {text-align: center;}
.c_product .c_p1 .c_product .c_p2, .c_product .c_p3, .c_product .c_p4 {text-align: center;}
.c_product .c_p2, .c_product .c_p4 {font-weight:bold; margin-top: 15px;}
.c_product .c_p3 {font-size: 0.9em; color: #868e96;}
.c_product .c_p2, .c_product .c_p3 {white-space: nowrap; overflow: hidden; text-overflow: ellipsis;}
.c_p4_discount {color: red;}
/*상품 hover 효과*/
.c_product:hover {transform: scale(1.11); opacity: 50%;}
.d_kind3:hover .c_product2 {position:absolute; top:0; left:0; display: inline-block; 
float:left; width: 250px; height: 350px; text-align: center; line-height: 175px;
padding:10px; margin:10px; border: 1px solid gray; background:rgba(0,0,0,0.8);}
.d_kind3:hover .c_p5, .d_kind3:hover .c_p6 {display:inline-block; width: 70px; height: 70px; 
border: none; background: purple; border-radius: 50%; margin: 140px 5px 0 5px; text-align:center; line-height: 70px; 
font-size: 0.9em; font-weight: bold; color: white;}
/* 하단 - 페이징 영역 */
#paging { text-align: center; margin-top: 20px; clear:both;}
#paging a {color: black;}
#pBox { display: inline-block; width: 22px; height: 22px; padding: 5px; margin: 5px;}
#pBox:hover { background: skyblue; color: white; font-weight: bold; border-radius: 50%;}
.pBox_c { background: skyblue; color: white; font-weight: 900; border-radius: 50%;}
.pBox_b { font-weight: 900;}
.main_end {margin: 50px 0 20px 0;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function(){
	let product_kind = document.getElementById("product_kind");
	
	// 상품 분류 선택에 대한 change 이벤트 처리 - 해당 종류 상품이 출력
	product_kind.addEventListener("change", function(event){
		// product_kind를 가지고 shopAll.jsp로 이동
		location = 'shopAll.jsp?product_kind=' + product_kind.value + "#t_kind";
	})
	
})
</script>
<%
request.setCharacterEncoding("utf-8");
String product_kind = request.getParameter("product_kind");
if(product_kind == null) product_kind = "110"; 		//프로덕트카인드의 값이 없을 때는 110으로 설정 

// 상품 분류별 상품명 설정
String product_kindName = "";
switch(product_kind){
case "110": product_kindName = "하우스"; break;
case "120": product_kindName = "쿠션"; break;
case "130": product_kindName = "그루밍"; break;
case "210": product_kindName = "사료"; break;
case "220": product_kindName = "습식"; break;
case "230": product_kindName = "영양제"; break;
case "240": product_kindName = "간식"; break;
case "310": product_kindName = "목줄/하네스"; break;
case "320": product_kindName = "리드줄"; break;
case "330": product_kindName = "이동장"; break;
case "340": product_kindName = "악세사리"; break;
case "410": product_kindName = "올인원"; break;
case "420": product_kindName = "상의"; break;
case "430": product_kindName = "드레스"; break;
case "440": product_kindName = "아우터"; break;
case "450": product_kindName = "악세사리"; break;
case "510": product_kindName = "패브릭"; break;
case "520": product_kindName = "실리콘"; break;
case "530": product_kindName = "노즈워크"; break;
}

//########## 페이징(paging) 처리 ##########
//페이징(paging) 처리를 위한 변수 선언
int pageSize = 12; // 1페이지에 12건의 게시글을 보여줌.
String pageNum = request.getParameter("pageNum"); // 페이지 번호
if(pageNum == null) pageNum = "1";                // 페이지 번호가 없다면 1페이지로 설정

int currentPage = Integer.parseInt(pageNum);    // 현재 페이지
int startRow = (currentPage -1) * pageSize + 1; // 현재 페이지의 첫번째 행
int endRow = currentPage * pageSize;            // 현재 페이지의 마지막 행
//##########                  ##########

DecimalFormat df = new DecimalFormat("#,###,###");

ProductDAO productDAO = ProductDAO.getInstance();

// 분류별 상품에대한 페이징 처리 
List<ProductDTO> productList = productDAO.getProductList(startRow, pageSize, product_kind);
int cnt = productDAO.getProductCount(product_kind);

//for(ProductDTO product : productList){			//for-in문 - 식 간결 디버깅
//	System.out.println(product);
//}
%>
<%-- 분류별 상품을 한줄에 4개씩 3단으로 처리 --%>
<div class="t_kind" id="t_kind">
	<div class="d_kind1">
		<span class="s_kind1"><b class="s_kind11"><%=product_kindName %></b> 분야 상품 목록</span>
		<span class="s_kind2">
			<select id="product_kind">
				<option value="110" <%if(product_kind.equals("110")) {%> selected <%} %>>하우스</option>
				<option value="120" <%if(product_kind.equals("120")) {%> selected <%} %>>쿠션</option>
				<option value="130" <%if(product_kind.equals("130")) {%> selected <%} %>>그루밍</option>
				<option value="210" <%if(product_kind.equals("210")) {%> selected <%} %>>사료</option>
				<option value="220" <%if(product_kind.equals("220")) {%> selected <%} %>>습식</option>
				<option value="230" <%if(product_kind.equals("230")) {%> selected <%} %>>영양제</option>
				<option value="240" <%if(product_kind.equals("240")) {%> selected <%} %>>간식</option>
				<option value="310" <%if(product_kind.equals("310")) {%> selected <%} %>>목줄/하네스</option>
				<option value="320" <%if(product_kind.equals("320")) {%> selected <%} %>>리드줄</option>
				<option value="330" <%if(product_kind.equals("330")) {%> selected <%} %>>이동장</option>
				<option value="410" <%if(product_kind.equals("410")) {%> selected <%} %>>올인원</option>
				<option value="420" <%if(product_kind.equals("420")) {%> selected <%} %>>상의</option>
				<option value="430" <%if(product_kind.equals("430")) {%> selected <%} %>>드레스</option>
				<option value="440" <%if(product_kind.equals("440")) {%> selected <%} %>>아우터</option>
				<option value="450" <%if(product_kind.equals("450")) {%> selected <%} %>>악세사리</option>
				<option value="510" <%if(product_kind.equals("510")) {%> selected <%} %>>패브릭</option>
				<option value="520" <%if(product_kind.equals("520")) {%> selected <%} %>>실리콘</option>
				<option value="530" <%if(product_kind.equals("530")) {%> selected <%} %>>노즈워크</option>
			</select>
		</span>
	</div>
	<div class="d_kind2">상품 수: 총 <b class="s_kind21"><%=cnt %></b>건</div>
	<%for(ProductDTO product : productList){%>
	<div class="d_kind3">
		<div class="c_product">
			<a href="shopContent.jsp?product_id=<%=product.getProduct_id()%>">
				<div class="c_p1"><img src="/images_puppyLover/<%=product.getProduct_image1()%>" width="230" height="230"></div>
				<div class="c_p2"><span title="<%=product.getProduct_name()%>"><%=product.getProduct_name() %></span></div>
				<div class="c_p4"><span><%=df.format(product.getProduct_price()) %>원</span><span class="c_p4_discount">(<%=product.getDiscount_rate() %>% 할인)</span></div>
			</a>
		</div>
	</div>
	<%} %>
	<%-- 하단: 페이징 처리 --%>
	<div id="paging">
	<%
	if(cnt > 0) {
		int pageCount = cnt / pageSize + (cnt%pageSize==0 ? 0 : 1); // 전체 페이지수
		int startPage = 1;  // 시작 페이지 번호
		int pageBlock = 3; // 페이징의 개수
		
		// 시작 페이지 설정
		if(currentPage % 3 != 0) startPage = (currentPage/3) * 3 + 1;
		else startPage = (currentPage/3-1) * 3 + 1;
			
		// 끝 페이지 설정
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		
		// 맨 처음 페이지 이동 처리
		if(startPage > 3) {
			out.print("<a href='shopAll.jsp?pageNum=1&product_kind="+product_kind+"#t_kind'><div id='pBox' class='pBox_b' title='첫 페이지'>"+"〈〈"+"</div></a>");
		}
		
		// 이전 페이지 이동 처리
		if(startPage > 3) {
			out.print("<a href='shopAll.jsp?pageNum="+(currentPage-3)+"&product_kind="+product_kind+"#t_kind' title='이전 3페이지'><div id='pBox' class='pBox_b'>"+"〈"+"</div></a>");
		}
		
		// 페이징 블럭 출력 처리
		for(int i=startPage; i<=endPage; i++) {
			if(currentPage == i) { // 선택된 페이지가 현재 페이지일 때
				out.print("<div id='pBox' class='pBox_c'>" + i + "</div>");
			} else {               // 다른 페이지일 때 -> 이동에 대한 링크 설정
				out.print("<a href='shopAll.jsp?pageNum="+i+"&product_kind="+product_kind+"#t_kind'><div id='pBox'>"+i+"</div></a>");
			}
		}
		
		// 다음 페이지 이동 처리
		if(endPage < pageCount) {
			int movePage = currentPage + 3;
			if(movePage > pageCount) movePage = pageCount;
			out.print("<a href='shopAll.jsp?pageNum="+movePage+"&product_kind="+product_kind+"#t_kind' title='다음 3페이지'><div id='pBox' class='pBox_b'>"+"〉"+"</div></a>");
		}
		
		// 맨 끝 페이지 이동 처리
		if(endPage < pageCount) {
			out.print("<a href='shopAll.jsp?pageNum="+pageCount+"&product_kind="+product_kind+"#t_kind' title='마지막 페이지'><div id='pBox' class='pBox_b'>"+"〉〉"+"</div></a>");
		}
	}
	%>
	</div>
</div>
<hr class="main_end">