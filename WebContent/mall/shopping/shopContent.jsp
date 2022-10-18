<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import=" mall.member.*, manager.product.*, java.text.*, java.util.*, mall.review.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세</title>
<style>
.container {width: 1200px; margin: 0 auto;}
.d_kind {margin: 20px 0;}
.d_kind a {text-decoration: none; color: black; font-size: 16px; color: #32708d; font-weight: bold;}
.d_kind a:hover {text-shadow: 1px 1px 1px lightgray;}
/*구역1: 왼쪽 상단, 상품이미지*/
.s1 {width: 50%; float: left; text-align: center;}
.big_img {transition: 0.5s;}
.big_img:hover {transform: scale(1.01);}
.small_imgs {margin: 20px;}
.small_imgs .thumb {margin: 0 10px; cursor:pointer;}
.small_imgs .thumb:hover {opacity: 50%;}

/*구역2: 오른쪽 상단, 상품 기본 정보, 버튼*/
.s2 {width: 44%; float: left; background: #EBF7FF; padding: 30px 30px 0 30px; }
.s2 > div {margin-bottom: 23px;}
.s2_d1 {font-size: 1.5em; font-weight: bold; color: #32708d;}
.s2_d2 {font-size: 0.9em; color: gray;}
.s2 .ss {display:inline-block; width: 100px; font-size: 0.9em; color: gray;}
.s2_d3 span:nth-child(2) {font-weight:bold; color: gray;}
.s2_d4 span:nth-child(2), .s2_d5 span:nth-child(2) {color: orange;}
.s2_d4 b {font-size:1.5em;}
.s2_d7 span:not(.ss) {font-size: 0.9em; color: gray; }
.s2_d7 b {font-size: 1.05em; color: blue;}
.s2_d8 span:nth-child(2) {font-size:0.9em; color: gray;}
.btns {margin-top: 65px; text-align: center;}
.btns input {width: 240px; height: 60px; border: 0; font-size: 1.15em; font-weight: bold; cursor:pointer;}
.btns #btn_cart {background: #2f9e77; color: #fff; margin-right: 10px;}
.btns #btn_cart:hover {background: white; color: #2f9e77; border: 1px solid #2f9e77; font-weight: bold;}
.btns #btn_buy {background: #1e9faa; color: #fff; margin-right: 10px;}
.btns #btn_buy:hover {background: white; color:#1e9faa; border: 1px solid #1e9faa; font-weight: bold;}

/*number 화살표 항상 보이는 효과*/
.s2_d6 input[type=number]::-webkit-inner-spin-button, 
.s2_d6 input[type=number]::-webkit-outer-spin-button { -webkit-appearance: "Always Show Up/Down Arrows"; opacity:1;}

/*구역3: 하단, 상품 내용, 상품 리뷰*/
.t_line {border:1px solid #e9ecef; margin: 30px 0; clear: both;}
.s3_c1 { background: #050099; padding: 10px; border-radius: 5px; margin-bottom: 40px;}
.s3_c1 span {display: inline-block; width: 120px; height: 30px; padding:10px; margin:0 10px; border:2px solid #050099;
text-align: center; line-height: 30px; border-radius: 5px; color: white; font-size: 1.05em; font-weight: bold; cursor:pointer;}
.s3_c1 span:hover {border: 2px solid white;}
.s3_c2 {line-height: 40px; text-align: justify; padding: 20px; text-align: center;}
.s3_c3 {display: none;}

.s3_c3 .s3_review {line-height: 27px; text-align:justify; padding: 20px; padding-bottom:40px; width:100%; height: 150px; margin-bottom: 35px;}
.s3_review .s3_r1 {width: 75%; float:left; padding: 20px; background: #F6F6F6; mragin-right: 20px;}
.s3_r1 .s3_subject {font-size: 1.1em; font-weight: bold; margin-bottom: 10px;}
.s3_r1 .s3_content {width: 100%; height: 110px; white-space:pre-line; overflow: hidden; font-size: 0.9em;}
.s3_r1 .s3_content_all, .s3_r1 .s3_content_part {font-size: 0.9em; color: green; cursor:pointer;}
.s3_r1 .s3_content_part {display: none;}
.s3_review .s3_r2 {width: 16%; height: 173px; float:right; padding: 20px; background: #D9E5FF; font-size:0.9em; color: gray;}
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
		let form = document.contentForm;
		
		// 이미지 변환 효과
		let big_img = document.querySelector(".big_img");
		let thumb_imgs = document.querySelectorAll(".thumb");
		
		for(let thumb of thumb_imgs){
			thumb.addEventListener("mouseover", function(){
				big_img.src = thumb.src;
			})
		}
		
		//상품 수량을 1이상 100미만으로 제한 
		let buy_count = document.getElementById("buy_count");
		buy_count.addEventListener("keyup", function(event){
			if(buy_count.value < 1){
				buy_count.value = 1;
			} else if(buy_count.value > 100){
				buy_count.value = 100;
			}
			
		})
		
		//상세보기에서 구매하기 
		let btn_buy = document.getElementById("btn_buy");
		btn_buy.addEventListener("click", function(){
			location = "../buy/buyForm.jsp?product_id="+form.product_id.value+"&buy_count="+form.buy_count.value+"&part=2";
		})
		
		
		//하단 - 상세설명, 상품리뷰 변화 효과
		let s3_c2 = document.querySelector(".s3_c2"); //상세설명
		let s3_c3 = document.querySelector(".s3_c3"); // 리뷰
		let ss1 = document.querySelector(".ss1");
		let ss2 = document.querySelector(".ss2");
		
		ss1.addEventListener("click", function(){
			s3_c2.style.display = "block"
			s3_c3.style.display= "none";
		})
		ss2.addEventListener("click", function(){
			s3_c2.style.display = "none";
			s3_c3.style.display = "block";
		})
		
		// 더보기 클릭 시 리뷰 전체 보기
		let content = document.querySelectorAll(".s3_content");
		let content_all = document.querySelectorAll(".s3_content_all");
		let content_part = document.querySelectorAll(".s3_content_part");
		for(let i in content_all){
			content_all[i].addEventListener("click", function(){
				content[i].style.overflow = "visible";
				content[i].style.height= "350px";
				content[i].style.display ="block";
				content_part[i].style.display = "block";
	
			})
		}

		
	})
</script>
<%
String memberId = (String)session.getAttribute("memberId");
int product_id = Integer.parseInt(request.getParameter("product_id"));

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
DecimalFormat df = new DecimalFormat("#,###,###");

//상품DB연결, 질의
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);

//회원 DB연결, 질의  - 세션의 여부 확인후 처리 (세션이 있을때(로그인을했을때) 처리)
MemberDAO memberDAO = null;
MemberDTO member = null;
String name = null;
String address = null;
String local = null;
String d_day = null;
if(memberId != null){
	memberDAO = MemberDAO.getInstance();
	member = memberDAO.getMember(memberId);
	name = member.getName();
	address = member.getAddress();
	local = address.substring(0, 2); //주소에서 지역 2글자만 추출
	
	//배송날짜 계산과 포맷
	// 규칙 1 서울 - 다음날 배송, 경기 - 2일안에 배송, 지방 - 3일안에 배송, 제주도 - 5일안에 배송
	// 규칙 2 토요일, 일요일 제외. 
	// 현재 날짜와 시간, 주소 판단, 요일판단

	int n = 0;	//추가되는 날짜
	Calendar c = Calendar.getInstance();
	int w = c.get(Calendar.DAY_OF_WEEK); //요일 1~7 1:일  2:월 ... 7:토 

	switch(local){
	case "서울": ; 
		if(w >= 2 && w <= 5) ++n;
		else if(w == 6 || w == 7) n+= 3;
		else if(w == 1) n+=2; 
		break;
	case "경기": ; 
		if(w >= 2 && w <= 4) n += 2;
		else if(w >= 5 && w <= 7) n += 4;
		else if(w == 1) n+=3;
		break;
	case "제주": ; 
		n += 7;
		break;
	default: 
		if(w == 2 || w == 3) n += 3;
		else if(w >= 4 && w <= 7) n += 5;
		else if(w == 1) n += 4;
		break;
	}

	//추가된 일수를 더한 날짜 
	c.add(Calendar.DATE, n);
	int month = c.get(Calendar.MONTH)+1;	//0~11로 표현, 1을 더해서 보정 
	int date = c.get(Calendar.DATE);
	int week = c.get(Calendar.DAY_OF_WEEK);	// 1~7 표현
	String[] weekday = {"", "일", "월", "화", "수", "목", "금", "토"};
	
	//배송일 
	d_day = month + "월 " + date + "일 (" + weekday[week] + ")"; 
	//System.out.print("배송일: " + month + "월 " + date + "일 (" + weekday[week] + "요일)");
}

//########## 페이징(paging) 처리 ##########
//페이징(paging) 처리를 위한 변수 선언
int pageSize = 5; // 1페이지에 5건의 게시글을 보여줌.
String pageNum = request.getParameter("pageNum"); // 페이지 번호
if(pageNum == null) pageNum = "1";                // 페이지 번호가 없다면 1페이지로 설정

int currentPage = Integer.parseInt(pageNum);    // 현재 페이지
int startRow = (currentPage -1) * pageSize + 1; // 현재 페이지의 첫번째 행
int endRow = currentPage * pageSize;            // 현재 페이지의 마지막 행
//##########                  ##########

// 상품 리뷰 DB연결, 질의
ReviewDAO reviewDAO = ReviewDAO.getInstance();
List<ReviewDTO> reviewList = reviewDAO.getReviewList(startRow, pageSize, product_id);
int cnt = reviewDAO.getReviewCount(product_id);

//상품 분류별 상품명 설정
String product_kindName = "";
String product_kind = product.getProduct_kind();
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

//판매가 계산
int price = product.getProduct_price();
int d_rate = product.getDiscount_rate();
int sale_price = price - (price*d_rate/100);

// 개인쇼핑몰에서 사용 1번만 not null 이고 나머지는 nothing.jpg가 저장돼있다고 가정할 때 1번의 이미지로 변경해 보여주는 방법

String product_image1 = product.getProduct_image1();
if(product.getProduct_image2().equals("nothing.jpg")) product.setProduct_image2(product_image1);
if(product.getProduct_image3().equals("nothing.jpg")) product.setProduct_image3(product_image1);  
%>
</head>
<body>
<div class="container">
	<jsp:include page="../common/shopTop.jsp" />
	<div class="d_kind"><a href="shopAll.jsp#t_kind">홈</a>&ensp;>&ensp;<a href="shopAll.jsp?product_kind=<%=product_kind%>#t_kind"><%=product_kindName %></a></div>
	<div class="detail">
		<%--구역1: 왼쪽 상단, 상품이미지 --%>
		<div class="s1">
			<div><img src="/images_puppyLover/<%=product.getProduct_image1() %>"  class="big_img" width="450" height="600"></div>
			<div class="small_imgs">
				<img src="/images_puppyLover/<%=product.getProduct_image1() %>" width="60" height="80" class="thumb">
				<img src="/images_puppyLover/<%=product.getProduct_image2() %>" width="60" height="80" class="thumb">
				<img src="/images_puppyLover/<%=product.getProduct_image3() %>" width="60" height="80" class="thumb">
			</div>
		</div>
		<%--구역2: 오른쪽 상단, 상품 기본 정보, 버튼 --%>
		<form action="../cart/cartInsertPro.jsp" method="post" name="contentForm">
			<%-- buyForm.jsp(구매하기)로 이동: product_id --%>
			<input type="hidden" name="product_id" value="<%=product_id%>">
			<%-- cartList.jsp(장바구니)로 이동cart_id, buy_count를 제외한 10가지 필드정보를 가지고 장바구니로 이동  --%>
			<input type="hidden" name="buyer" value="<%=memberId %>">
			<input type="hidden" name="product_name" value="<%=product.getProduct_name()%>">
			<input type="hidden" name="product_color" value="<%=product.getProduct_color() %>">
			<input type="hidden" name="product_size" value="<%=product.getProduct_size() %>">
			<input type="hidden" name="product_price" value="<%=product.getProduct_price() %>">
			<input type="hidden" name="discount_rate" value="<%=product.getDiscount_rate() %>">
			<input type="hidden" name="buy_price" value="<%=sale_price%>">
			<input type="hidden" name="product_image1" value="<%=product.getProduct_image1()%>">
		<div class="s2">
			<div class="s2_d1"><%=product.getProduct_name() %></div>
			<div class="s2_d3"><span class="ss">정가</span><span><%=df.format(price) %>원</span></div>
			<div class="s2_d4"><span class="ss">판매가</span><span></span><b><%=df.format(sale_price) %></b>원</div>
			<div class="s2_d5"><span class="ss">할인율</span><span><b><%=product.getDiscount_rate() %></b>%</span></div>
			<div class="s2_d6"><span class="ss">구매 수량</span><input type="number" name="buy_count" id="buy_count" value="1" min="1" max="99" maxlength="2"></div>
			<div class="s2_d7"><span class="ss">배송안내</span><br>
				<%if(memberId != null) {%>
				<span><b><%=name %></b>님의 주소로 <b><%=d_day %></b>까지 배송됩니다.</span><br>
				<span>주소: <b><%=address %></b></span>
				<%} else {%>
				<span>
					배송일은 서울이면 익일,경기는 2일,지방은 3일,제주는 평균 5일이 소요됩니다.<br>
					단 토/일, 공휴일은 배송일에서 제외됩니다.
				</span>
				<%} %>
			</div>
			<div class="s2_d8"><span class="ss">배송비</span>
				<span>무료<br>
					제주도 : 3,000원 / 도서산간: 3,000원 
				</span>
			</div>
			<div class="btns">
				<input type="submit" value="장바구니" id="btn_cart">
				<input type="button" value="구매하기" id="btn_buy">
			</div>
		</div>
	</form>
	<hr class="t_line">
		<%--구역3: 하단, 상품 내용, 상품 리뷰  --%>
		<div class="s3" id="s3">
			<div class="s3_c1"><span class="ss1">상세설명</span><span class="ss2">상품리뷰</span><span class="ss3">상품문의</span><span class="ss4">교환/반품</span></div>
			<div class="s3_c2"><img src="/images_puppyLover/<%=product.getProduct_content() %>"></div>
			<div class="s3_c3">
			<%for(ReviewDTO review : reviewList) {%>
				<div class="s3_review">
					<div class="s3_r1">
						<div class="s3_subject"><%=review.getSubject() %></div>
						<div class="s3_content"><%=review.getContent() %></div>
						<div class="s3_content_all">더보기 ▼</div>
						<div class="s3_content_part">내용 접기▲</div>
					</div>
					<div class="s3_r2">
						<div>작성자: <%=review.getMember_id() %></div>
						<div>등록일: <%=sdf.format(review.getRegDate()) %></div>
						<div>조회수: <%=review.getReadcount() %></div>
					</div>
				</div>
				<%} %>
				<%-- 하단: 페이징 처리 --%>
				<div id="paging">
				<%
				if(cnt > 0) {
					int pageCount = cnt / pageSize + (cnt%pageSize==0 ? 0 : 1); // 전체 페이지수
					int startPage = 1;  // 시작 페이지 번호
					int pageBlock = 5; // 페이징의 개수
					
					// 시작 페이지 설정
					if(currentPage % 5 != 0) startPage = (currentPage/5) * 5 + 1;
					else startPage = (currentPage/5-1) * 5 + 1;
						
					// 끝 페이지 설정
					int endPage = startPage + pageBlock - 1;
					if(endPage > pageCount) endPage = pageCount;
					
					// 맨 처음 페이지 이동 처리
					if(startPage > 5) {
						out.print("<a href='shopContent.jsp?pageNum=1&product_kind="+product_kind+"&product_id="+product_id+"#s3'><div id='pBox' class='pBox_b' title='첫 페이지'>"+"〈〈"+"</div></a>");
					}
					
					// 이전 페이지 이동 처리
					if(startPage > 5) {
						out.print("<a href='shopContent.jsp?pageNum="+(currentPage-3)+"&product_kind="+product_kind+"&product_id="+product_id+"#s3' title='이전 5페이지'><div id='pBox' class='pBox_b'>"+"〈"+"</div></a>");
					}
					
					// 페이징 블럭 출력 처리
					for(int i=startPage; i<=endPage; i++) {
						if(currentPage == i) { // 선택된 페이지가 현재 페이지일 때
							out.print("<div id='pBox' class='pBox_c'>" + i + "</div>");
						} else {               // 다른 페이지일 때 -> 이동에 대한 링크 설정
							out.print("<a href='shopContent.jsp?pageNum="+i+"&product_kind="+product_kind+"&product_id="+product_id+"#s3'><div id='pBox'>"+i+"</div></a>");
						}
					}
					
					// 다음 페이지 이동 처리
					if(endPage < pageCount) {
						int movePage = currentPage + 5;
						if(movePage > pageCount) movePage = pageCount;
						out.print("<a href='shopContent.jsp?pageNum="+movePage+"&product_kind="+product_kind+"&product_id="+product_id+"#s3' title='다음 5페이지'><div id='pBox' class='pBox_b'>"+"〉"+"</div></a>");
					}
					
					// 맨 끝 페이지 이동 처리
					if(endPage < pageCount) {
						out.print("<a href='shopContent.jsp?pageNum="+pageCount+"&product_kind="+product_kind+"&product_id="+product_id+"#s3' title='마지막 페이지'><div id='pBox' class='pBox_b'>"+"〉〉"+"</div></a>");
					}
				}
				%>
				</div>
			</div>
		</div>
	</div>
	<hr class="t_line">
	<jsp:include page="../common/shopBottom.jsp" />
</div>
</body>
</html>