<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<style type="text/css">
#nav_menu ul li{
	display: inline;
	border-left: 1px solid;
	padding: 0px 0px 0px 5px;
	margin: 10px 0px 5px 0px;
}
#nav_menu ul li:first-child{
border-left: none;
}
#nav_menu ul li:hover a{
 background: silver;
 font-weight: bold;
}

ul{
	padding-left:0px;
	float:left;
	background-color: white;
	
	}
li{
	background-color: white;
	
	}
#nav_menu ul li a{
	color: black;
}
</style>

</head>
<body>

<div id="nav_menu">
	<nav class="navbar">
		<ul class="navbar-nav" style="list-style-type: none;">
		<li class="nav-item" style="display: inline; " ><a href="main.jsp" >Main</a></li>
		<li class="nav-item" style="display: inline; "><a href="login/login.jsp">login</a></li>
		<li class="nav-item" style="display: inline; "><a href="member/join_view.jsp">Join</a></li>
		</ul>
	</nav>

</div>

</body>
</html>