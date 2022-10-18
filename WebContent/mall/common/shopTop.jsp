<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 쇼핑몰 상단 페이지 : 쇼핑몰의 모든 페이지 상단에 포함되는 페이지 --%>

<style>
@import url('https://fonts.googleapis.com/css2?family=Anton&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Hahmlet:wght@300&display=swap');
/*전체 레이아웃*/
.top a {text-decoration:none; color: black;}
.t_box1, .t_box2, .t_box3, .t_box4 {display:inline-block; padding: 2%;}
.t_box1, .t_box3 {width: 60%;}
.t_box2, .t_box4 {width: 30%;}
/*구역1(상단 좌측) - 타이틀, 검색*/
.t_box1 .m_title {font-family: 'Anton', sans-serif; font-size: 3.3em; text-align: left;}
.t_box1 .s_title {font-family: 'Hahmlet', serif; font-size: 18px; text-align: left;}
.t_box1 .t_search { width: 500px; margin-top: 15px; margin-left: 350px;
border: 1px solid black; border-radius: 35px; padding: 5px;}
.t_box1 .t_search #keyword {height: 35px; width: 300px; border: none; font-size: 1.1em;}
.t_box1 .t_search #keyword:focus {outline: none; }
.t_box1 .t_search button {border: none; background: #fff; cursor: pointer; margin-left: 140px;}
/*구역2(상단 우측) - 회원정보, 구매정보, 장바구니*/
.t_box2 {float: right; text-align: right; line-height: 100px;}
.t_box2 .t_b2_img1:hover {content: url('../../icons/user2.png');}
.t_box2 .t_b2_img2:hover {content: url('../../icons/buy2.png');}
.t_box2 .t_b2_img3:hover {content: url('../../icons/cart2.png');}
/*구역3(하단 좌측) - 메인메뉴(하위메뉴)*/
.t_box3 {float: left; position: relative;}
.m_menu0 {display: inline-block;}
.m_menu0 .m_menu_img:hover {content: url('../../icons/menu2.png');}
.m_menu {display: inline-block;}
.m_menu a {font-family: 'Do Hyeon', sans-serif; font-size: 20px; color: blue; width: 100px; padding: 5px; margin: 5px; }
.mm1, .mm2, .mm3, .mm4, .mm5 a {padding-right: 40px;}
.mm1 {padding-left: 30px;}
.s_menu {display: none; position: absolute; top: 55px; width: 130px; z-index: 10; background: #e9e1f4;}
.sm1 {left: 70px;}
.sm2 {left: 150px;}
.sm3 {left: 240px;}
.sm4 {left: 345px;}
.sm5 {left: 446px;}

.m_menu a:hover {color:purple; text-shadow: 1px 1px 1px lightgray;}
.m_menu:hover .s_menu {display: block;}
.s_menu div {padding: 10px 0;}
.s_menu div a {font-family: '고딕'; font-size: 0.9em; color: black;}
.s_menu div a:hover {font-weigth: bold; font-size: 1.0em; text-shadow:1px 1px 1px gray;}
/*구역4(하단 우측) - 로그인, 회원가입, 고객센터 ...*/
.t_box4 {float: right; text-align: right;}
.t_box4 a {color: gray; font-size: 0.9em; font-weight: bold;}
.top_end {clear:both;}
</style>
<%
String memberId = (String)session.getAttribute("memberId");
%>
<div class="top">
	<div class="t_box1">
		<%-- 구역1(상단 좌측) - 타이틀, 검색 --%>
		<div class="m_title">
			<a href="../shopping/shopAll.jsp">Puppy Lover</a>
		</div>
		<div class="s_title">with Happy</div>
		<div class="t_search">
			<form action="" method="post" name="searchForm">
				<input type="search" name="keyword" id="keyword">
				<button type="submit"><img src="../../icons/paw.png" width="25" height="25"></button>
			</form>
		</div>
		
	</div>
	<div class="t_box2">
		<%-- 구역2(상단 우측) - 회원정보, 구매정보, 장바구니 --%>
		<a href="../member/memberInfoForm.jsp"><img src="../../icons/user1.png" width="30" title="회원정보" class="t_b2_img1"></a>&emsp;&emsp;
		<a href="../buy/buyList.jsp"><img src="../../icons/buy1.png" width="30" title="구매내역" class="t_b2_img2"></a>&emsp;&emsp;
		<a href="../cart/cartList.jsp"><img src="../../icons/cart1.png" width="30" title="장바구니" class="t_b2_img3"></a>
	</div>
	<div class="t_box3"><%-- 구역3(하단 좌측) - 메인메뉴(하위메뉴) --%>
		<div class="m_menu0"><a href="#"><img src="../../icons/menu1.png" width="25" class="m_menu_img"></a></div>
		<div class="m_menu mm1">
			<a href="#">리빙</a>
			<div class="s_menu sm1">
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=110#t_kind">하우스</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=120#t_kind">쿠션</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=130#t_kind">그루밍</a></div>
			</div>
		</div>
		<div class="m_menu mm2">
			<a href="#">푸드</a>
			<div class="s_menu sm2">
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=210#t_kind">사료</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=220#t_kind">습식</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=230#t_kind">영양제</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=240#t_kind">간식</a></div>
			</div>
		</div>
		<div class="m_menu mm3">
			<a href="#">외출</a>
			<div class="s_menu sm3">
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=310#t_kind">목줄/하네스</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=320#t_kind">리드줄</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=330#t_kind">이동장</a></div>
			</div>
		</div>
		<div class="m_menu mm4">
			<a href="#">의류</a>
			<div class="s_menu sm4">
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=410#t_kind">올인원</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=420#t_kind">상의</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=430#t_kind">드레스</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=440#t_kind">아우터</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=450#t_kind">악세사리</a></div>
			</div>
		</div>
		<div class="m_menu mm5">
			<a href="#">장난감</a>
			<div class="s_menu sm5">
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=610#t_kind">패브릭</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=620#t_kind">실리콘</a></div>
				<div><a href="/PuppyLover/mall/shopping/shopAll.jsp?product_kind=630#t_kind">노즈워크</a></div>
			</div>
		</div>
	</div>
	<div class="t_box4">
		<%-- 구역4(하단 우측) - 로그인, 회원가입, 고객센터 ... --%>
		<%if(memberId == null) {%>
			<a href="../logon/memberLoginForm.jsp"><span>로그인</span></a> &ensp;|&ensp;
			<a href="../member/memberJoinForm.jsp"><span>회원가입</span></a>&ensp;|&ensp; 
		<%}else{ %>
			<a href="../member/memberInfoForm.jsp"><%=memberId %>님</a> &ensp;|&ensp;<a href="../logon/memberLogout.jsp">로그아웃</a>&ensp;|&ensp; 
		<%} %>
		<a href=""><span>고객센터</span></a>
	</div>
</div>
<div class="top_end"></div>