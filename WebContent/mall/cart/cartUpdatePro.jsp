<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*, manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수량 변경 처리</title>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");

if(memberId == null){
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../logon/memberLoginForm.jsp';</script>");
}
int cart_id = Integer.parseInt(request.getParameter("cart_id"));
int buy_count = Integer.parseInt(request.getParameter("buy_count"));
int product_id = Integer.parseInt(request.getParameter("product_id"));

// Product DB 연동 -> 재고 수량 팦악
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);
int product_count = product.getProduct_count();

// Cart DB 연동
out.print("<script>");
if(buy_count > product_count){		// 구매수량이 재고보다 많을 때
	out.print("alert('상품의 재고 수량을 초과하였습니다. (현재 재고수량: " + product_count + "개)\\n구매수량을 다시 입력하시오.');");
}else{								// 구매수량보다 재고가 많으르 때
	CartDAO cartDAO = CartDAO.getInstance();
	cartDAO.updateCart(cart_id, buy_count);
}
out.print("location='cartList.jsp';");
out.print("</script>");
%>
</body>
</html>