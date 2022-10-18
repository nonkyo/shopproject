<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="mall.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 처리 (입력받은 값을 추가함 insert)</title>
</head>
<body>
	<%request.setCharacterEncoding("utf-8");%>
	
	<!--  액션태그로 값을 받음  -->
	<jsp:useBean id="member" class="mall.member.MemberDTO" />
	<jsp:setProperty property="*" name="member"/>
	
	<% 
	// 완전한 주소: address(도로명주소)+address2(상세주소)
	String address2 = request.getParameter("address2");
	String address = member.getAddress()+" " + address2;
	
	MemberDAO memberDAO = MemberDAO.getInstance();	//클래스에서 만들어놓은 객체 리턴
	int cnt = memberDAO.insertMember(member);
	%>
	
	<script>
	<%if(cnt > 0) { %> <%--cnt=1 데이터 추가에 성공 --%>
		alert('회원가입에 성공하였습니다.');
		location = '../shopping/shopAll.jsp';
	<%}else{ %> <%--데이터 추가 실패 했을 때 cnt=0 --%>
		alert('회원가입에 실패하였습니다.');
		history.back();
	<%} %>
	</script>
	
	
	
</body>
</html>