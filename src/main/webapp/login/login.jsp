<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>hello</title>
<style type="text/css">
boby{
	margin: 0px;
	
}

table{

margin-left:auto;
margin-right:auto;
background-color: white;
}
</style>
</head>
<body>


<%@ include file="top.html" %>

<img alt="이미지를 불러올 수 없습니다" src="https://mblogthumb-phinf.pstatic.net/MjAxODAzMDNfMTE0/MDAxNTIwMDQxOTg0NzI4.LSj_QNuczlsqni-ifXcmYdcpCTtjtdQTHKnry7JzszEg.PgEucPcjQ-OD9TM8eO4dVNOcuNnVk-qe3l7ShA6xmbwg.PNG.osy2201/7_%2885%ED%8D%BC%EC%84%BC%ED%8A%B8_%ED%9A%8C%EC%83%89%29_%ED%9A%8C%EC%83%89_%EB%8B%A8%EC%83%89_%EB%B0%B0%EA%B2%BD%ED%99%94%EB%A9%B4_180303.png?type=w800" width="100%" height="100px">
<br>
<br>
<form action="loginchk.jsp" method="post" class="login_form">
	<table border="1">
		<tr>
		 <th>ID:</th><th><input type="text" name="id" size="20"></th>
		</tr>
		
		<tr>
			<th>pw:</th><th><input type="password" name="pwd" size="20"></th>
		</tr>
		
		<tr>
			<th colspan="2">
			<input type="submit" value="로그인">
			</th>
		</tr>
	
	</table>
</form>
<%@ include file="bottom.html" %>
</body>
</html>