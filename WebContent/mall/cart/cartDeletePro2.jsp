<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 또는 여러개 상품 삭제 처리</title>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");

if(memberId == null){
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../logon/memberLoginForm.jsp';</script>");
}
// 1. 삭제할 카트 아이디 값 획득 
String cart_ids_list = request.getParameter("cart_id");
String[] cart_ids = cart_ids_list.split(","); 
// 2.DB 연동
CartDAO cartDAO = CartDAO.getInstance();
cartDAO.deleteCartList(cart_ids);
// 3. 이동
response.sendRedirect("cartList.jsp");
%>
</body>
</html>