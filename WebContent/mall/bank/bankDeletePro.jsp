<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.bank.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>은행 카드 삭제</title>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../logon/memberLoginForm.jsp';</script>");
	return;
}

String cart_id = null;
String product_id = null;
String buy_count = null;

String card_no = request.getParameter("card_no");
String part = request.getParameter("part");

BankDAO bankDAO = BankDAO.getInstance();
bankDAO.deleteBank(memberId, card_no);

if(part.equals("1") || part.equals("2")){ 
	product_id = request.getParameter("product_id");
	buy_count = request.getParameter("buy_count");
	response.sendRedirect("../buy/buyForm.jsp?product_id="+product_id+"&buy_count="+buy_count+"&part="+part);
}else if(part.equals("3")){ 
	cart_id = request.getParameter("cart_id");
	response.sendRedirect("../buy/buyForm.jsp?cart_id="+cart_id+"&part="+part);
}
%>
</body>
</html>