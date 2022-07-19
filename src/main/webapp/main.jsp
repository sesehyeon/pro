<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My wash list</title>
<style type="text/css">
	h2{
		border:0;
		padding:0px;
		
		margin-left: 20px;
	}
	h4{
		margin-left: 30px;
	}
	.box1{
		
		margin-left:10px;
		float: left;
	}
	.box2{
	margin-left:10px;
		float: left;
	}
	.box3{
	margin-left:10px;
		float: left;
	}
	
	div a{
	color:black;
	 text-align: center;
	}
	
	.art{
	 margin-left: 10px;
	}
	
	
</style>
<script type="text/javascript">
	function zoomIn(event){
		event.target.style.width="120px";
		event.target.style.height="120px";
		event.target.style.transition="all 0.5s";
	}
	function zoomOut(event){
		event.target.style.width="100px";
		event.target.style.height="100px";
		event.target.style.transition="all 0.5s";
		
	}
</script>
</head>
<body>

<%@ include file="login/top.html" %>
<img alt="이미지를 불러올 수 없습니다" src="https://mblogthumb-phinf.pstatic.net/MjAxODAzMDNfMTE0/MDAxNTIwMDQxOTg0NzI4.LSj_QNuczlsqni-ifXcmYdcpCTtjtdQTHKnry7JzszEg.PgEucPcjQ-OD9TM8eO4dVNOcuNnVk-qe3l7ShA6xmbwg.PNG.osy2201/7_%2885%ED%8D%BC%EC%84%BC%ED%8A%B8_%ED%9A%8C%EC%83%89%29_%ED%9A%8C%EC%83%89_%EB%8B%A8%EC%83%89_%EB%B0%B0%EA%B2%BD%ED%99%94%EB%A9%B4_180303.png?type=w800" width="100%" height="200px" onclick="">

<div class= shopping style="width: 350px;">
<h2 >shopping</h2>
<div class="box1">

<a href="https://www.freitag.ch/en/f41?v=5443212"><img alt="이미지를 불러올 수 없습니다" src="https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20210830_295%2F163030393693767H2k_JPEG%2F31439825644147800_118582390.jpg&type=a340" height="100px" width="100px"border="1" onmouseenter="zoomIn(event)" onmouseleave="zoomOut(event)"></a>
<br>
<h4>Freitag</h4>
</div>

<div class="box2">
<a href="https://www.stussy.co.kr/"><img alt="이미지를 불러올 수 없습니다" src="https://mblogthumb-phinf.pstatic.net/MjAxNzA4MDRfMTAx/MDAxNTAxODQ4NjgzODI4.etJUS6S7ZR3tjwtXr44Xaq-Ychq_vExrNR4m2S7JlBEg.E2CnhNXxpDzknb_P7RkOUzZPLCeoKU6t-7ONhU8qKR0g.JPEG.noreplica01/1.jpg?type=w800" height="100px" width="100px"border="1"onmouseenter="zoomIn(event)" onmouseleave="zoomOut(event)"></a>
<br>
<h4>Stussy</h4>
</div>

<div class="box3">
<a href="https://www.nike.com/kr/launch/?type=feed"><img alt="이미지를 불러올 수 없습니다" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcarLva2M68d5AMxqBlElaveLuj7Rn6zu-PYksbszF-6vOhwOQHGi1drdJa18JNpEjlf4&usqp=CAU" height="100px" width="100px" border="1"onmouseenter="zoomIn(event)" onmouseleave="zoomOut(event)"></a>
<br>
<h4>Nike</h4>
</div>
</div>
<div class="perfume" style="width: 350px;float: left; margin-left: 20px;">
	<h2>Perfume</h2>

</div>
<br>
<br><br><br><br><br><br><br><br>

<div class="art" style="width: 500px;">
<h2>artist</h2>
<br>
<img alt="이미지를 불러올 수 없습니다" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRuvRiZIlQEh-wSgK2mi8Ee5uFJkrg2JN2EDUdB2VDm0rgV79ieBSYTV9yyEC8BkjYjxE&usqp=CAU" height="100px" width="100px" border="1" onmouseenter="zoomIn(event)" onmouseleave="zoomOut(event)">
<br>
<h4>ASH</h4>
</div>
<%@ include file="login/bottom.html" %>
</body>
</html>