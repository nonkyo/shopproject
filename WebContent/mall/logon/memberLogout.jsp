<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>logout</title>
</head>
<body>
	<%
	/*
	< 세션 삭제 방법 2가지 >
	1 session.invalidate(); - 모든 세션 무효화(삭제)
	2 session.removeAttribute(세션이름); - 해당하는 이름의 세션만 삭제
	*/
	
	session.removeAttribute("memberId");
	%>
	<script>
		alert('로그아웃 되었습니다.');
		location = '../shopping/shopAll.jsp';
	</script>
</body>
</html>