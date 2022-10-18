<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴(삭제)</title>
</head>
<body>
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

MemberDAO memberDAO = MemberDAO.getInstance();
int cnt = memberDAO.deleteMember(id, pwd);

out.print("<script>");
if(cnt > 0){
	session.removeAttribute("memberId");
	out.print("alert('회원 탈퇴에 성공하였습니다.');");
	out.print("location='../shopping/shopAll.jsp';");
}else{
	out.print("alert('회원 탈퇴에 실패하였습니다.');");
	out.print("history.back();");
}
out.print("</script>");
%>

</body>
</html>