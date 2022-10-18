<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그아웃 처리</title>
</head>
<body>
<%
// 세션 삭제
session.removeAttribute("managerId");
%>
<script>
	alert('로그아웃 하였습니다.');
	location = 'managerLoginForm.jsp';
</script>
</body>
</html>