<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.logon.ManagerDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 처리</title>
</head>
<body>
<%
String managerId = request.getParameter("managerId");
String managerPwd = request.getParameter("managerPwd");
// cnt가 1이면 로그인 성공, cnt가 0이면 로그인 실패
ManagerDAO managerDAO = ManagerDAO.getInstance();
int cnt = managerDAO.checkManager(managerId, managerPwd);

out.print("<script>");
if(cnt == 1) { // cnt가 1일때, 로그인 성공 -> 세션 생성
	session.setAttribute("managerId", managerId);
	out.print("alert('로그인에 성공하였습니다.');location='../managerMain.jsp';");
} else {       // cnt가 0일때, 로그인 실패
	out.print("alert('로그인에 실패하였습니다.');history.back();");
}
out.print("</script>");
%>
</body>
</html>