<%@page import="login.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%response.setCharacterEncoding("utf-8"); %>
<%
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	LoginDAO dao= new LoginDAO();
	int result=dao.getCon(id,pwd);
	if(result==1){
		session.setAttribute("login", id);
		out.print(
			"<script>alert('"+id+"님 환영합니다');location.href='main.jsp'</script>"	);
	}else if(result==0){
		%>
		<script type="text/javascript">
		alert('비밀번호가 다릅니다.')
		location.herf='login.jsp'
		</script>
	<%  }else{
		%>
		<script type="text/javascript">
		alert('존재하지 않는 아이디 입니다.')
		location.herf='login.jsp'
		</script>
<% }%>


</body>
</html>