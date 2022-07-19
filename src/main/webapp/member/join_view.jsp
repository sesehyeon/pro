<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="searchDTO" class="member.SearchDTO"/>
<jsp:useBean id="pagination" class="member.pagination.Pagination"/>
<jsp:setProperty property="*" name="searchDTO"/>
<jsp:setProperty property="*" name="pagination"/>
<% response.setHeader("Cache-Control", "no-store"); %>
<% response.setHeader("Pragma", "no-cache"); %>
<% response.setDateHeader("Expire", 0); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="../css/member.css" rel="stylesheet">
</head>
<body>
	<div class="wrapper">
		<h1>회원가입</h1>
		<form name="joinForm" action="join.jsp" method="post">
			<c:forEach var="condition" items="${searchDTO.conditionList}">
			<input type="hidden" name="conditionList" value="${condition}">
			</c:forEach>	
			<input type="hidden" name="keyword" value="${searchDTO.keyword}">
			<input type="hidden" name="sortColumn" value="${searchDTO.sortColumn}">
			<input type="hidden" name="sortType" value="${searchDTO.sortType}">
			<input type="hidden" name="page" value="${pagination.page}">

			<table>
				<colgroup>
					<col width="30%">
					<col width="70%">
				</colgroup>
				<tbody>
					<tr>
						<th>아이디</th><td><input type="text" name="id" data-check-type="n-e" data-check-length="3~10"><input type="button" id="idCheck" value="중복확인" onclick="checkId();"></td>
					</tr>
					<tr>
						<th>비밀번호</th><td><input type="password" name="password" data-check-type="n-e-s" data-check-length="4~20"></td>
					</tr>
					<tr>
						<th>비밀번호 확인</th><td><input type="password" name="checkPassword" data-check-type="n-e-s" data-check-length="4~20"></td>
					</tr>
					<tr>
						<th>이름</th><td><input type="text" name="name" data-check-type="k" data-check-length="2~10"></td>
					</tr>
					<tr>
						<th>전화번호</th><td><input type="text" name="phone" data-check-type="p" data-check-length="0~11"></td>
					</tr>
					<tr>
						<th>주소</th><td><input type="text" name="address" data-check-length="0~100"></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align:center;padding: 20px;border: none;">
							<input type="button" value="가입" onclick="join();">
							<input type="button" value="회원목록" onclick="goList(document.joinForm);">
						</td>
					</tr>	
				</tbody>
			</table>
		</form>
	</div>
<script type="text/javascript">
	var permissionId = false;	// 아이디 중복확인 여부 전역변수
	
	document.body.onload = function() {
		injectEvent(document.joinForm);
	}

	// keyup, blur 이벤트에 유효성 검사 이벤트 적용
	function injectEvent(form) {
		if(form && typeof form != 'undefined') {
			for(var i=0; i<form.length; i++) {
				var element = form[i];
				
				// 키보드 입력 직후
				if(typeof element.onkeyup != 'undefined') {
					element.onkeyup = function() {
						checkElement(this);
					}
				}
				
				// 포커스를 잃었을 때
				if(typeof element.onblur != 'undefined') {
					element.onblur = function() {
						var permission = checkElement(this);
	
						if(permission && (this.name == 'password' || this.name == 'checkPassword')) {
							var checkPwd = checkPassword();
							
							if(checkPwd) {
								message(form.password, checkPwd);
								message(form.checkPassword, checkPwd);
							} else {
								message(this, checkPwd, '비밀번호가 다릅니다.');
							}
						}
					}
				}
				
				// 아이디 이벤트
				if(element.name && element.name == 'id') {
					element.onchange = function() {
						document.getElementById('idCheck').style.color = '#f00';
						permissionId = false;
					}
				}
				
				// input에 포커스가 있을 때 enter 눌렀을 때
				if(typeof element.onkeypress != 'undefined') {
					element.onkeypress = function() {
						if(event.keyCode == 13) {
							join();
						}
					}
				}	
			} // for
		} // if
	}
	
	// 해당 요소의 유효성 확인
	function checkElement(element) {
		var check = makeCheck(element);
		var value = element.value;
		var permission = true;
		
		if(value.length > 0) {
			// 형식 확인
			if(check.typeCheck && !check.pattern.test(value)) {
				permission = false;
				message(element, permission, check.message);
				return permission;
			}
			
			// 길이 확인
			if(check.lengthCheck) {
				if(value.length > check.max) {
					var msg = check.max + '자리 이하로 입력할 수 있습니다.';
					
					permission = false;
					message(element, permission, msg);
					return permission;
				}
				
				if(event.type == 'blur' && value.length < check.min) {
					var msg = check.min + '자리 이상으로 입력할 수 있습니다.';
					
					permission = false;
					message(element, permission, msg);
					return permission;
				}
			}
		}
		
		message(element, permission, message);
		return permission;
	}
	
	// 가입전에 최종 유효성 확인
	function checkForm(form) {
		for(var i=0; i<form.length; i++) {
			var messageName = '해당 요소는';
			var element = form[i];
			var check = makeCheck(element);
			var value = element.value;
		
			switch(element.name) {
			case 'id' : messageName = '아이디는';
				break;
			case 'password' : messageName = '비밀번호는';
				if(!checkPassword()) {
					alert('비밀번호가 다릅니다.');
					return false;
				}
				break;
			case 'checkPassword' : messageName = '비밀번호 확인';
				if(!checkPassword()) {
					alert('비밀번호가 다릅니다.');
					return false;
				}
				break;	
			case 'name' : messageName = '이름은';
				break;
			case 'phone' : messageName = '전화번호는';
				break;
			case 'address' : messageName = '주소는';
				break;
			}
			
			// 형식 확인
			if(check.typeCheck) {
				if(value.length > 0 && !check.pattern.test(value)) {
					alert(messageName + ' ' + check.message);
					element.value = value.replace(check.replace, '');
					element.focus();
					return false;
				}				
			}
			
			// 길이 확인
			if(check.lengthCheck) {
				if(check.min > 0 && value.length < check.min || value.length > check.max) {
					alert(messageName + ' ' + check.min + '자리 이상 ' + check.max + '자리 이하로 입력할 수 있습니다.');
					element.value = value.slice(0, check.max);
					element.focus();
					return false;
				}
			}
		}
		
		return true;
	}	
	
	// 아이디 유효성 검사 및 중복 확인
	function checkId() {
		var id = document.joinForm.id.value;
		var check = makeCheck(document.joinForm.id);
		var xhr = new XMLHttpRequest();
		var result = -1;
		
		if(id.length == 0) {
			alert('아이디를 입력해주십시오.');
			return;
		}
		
		if(!check.pattern.test(id)) {
			alert(check.message);
			return;
		}
		
		if(id.length < check.min) {
			alert('아이디는 ' + check.min + '이상으로 입력해주십시오.');
			return;
		}
		
		if(id.length > check.max) {
			alert('아이디는 ' + check.max + '이하로 입력해주십시오.');
			return;
		}
				
		xhr.open('get', 'checkId.jsp?id='+id, false);
		xhr.send();
		
		result = Number(xhr.responseText);
		
		if(result > 0) {
			alert('중복된 아이디입니다.');
			return;
		} 
		
		if (result == 0) {
			alert('사용가능한 아이디입니다.');
			document.getElementById('idCheck').style.color = '#000';
			permissionId = true;
			return;
		}
		
		if (result < 0) {
			alert('아이디 중복확인에 실패했습니다.');
			return;
		}
	}
	
	// 비밀번호 확인
	function checkPassword() {
		var password = document.joinForm.password;
		var checkPassword = document.joinForm.checkPassword;

		if(password.value.length > 0  && checkPassword.value.length > 0 
				&& password.value != checkPassword.value) {
			return false;
		}
		return true;
	}
	
	// 회원가입
	function join() {
		var form = document.joinForm;
		
		if(form.id.value.replace(/\s/gi).length == 0) {
			alert('아이디를 입력해주십시오.');
			return;
		}
		
		if(!permissionId) {
			alert('아이디 중복 확인을 해주십시오.');
			return;
		}
		
		if(checkForm(form)){
			form.submit();
		}
	}
	
	// 해당 요소에 부합하는 check 객체 생성(정규표현식, 메시지, 제거값, 해당 유효성 검사 대상 여부)
	function makeCheck(element) {
		var result = new Object();
		var checkPatternStr = '';
		var permissionStr = '';
		var min = 0, max = 0;
		var typeCheck = false;
		var lengthCheck = false;

		// 형식 확인
		if(element.dataset.hasOwnProperty('checkType')) {
			var checkTypeList = element.dataset.checkType.split('-');
			
			for(var i=0; i<checkTypeList.length; i++) {
				var ct = checkTypeList[i];
				
				if(checkPatternStr.length > 0) {
					checkPatternStr += '|';
				}
				
				if(permissionStr.length > 0) {
					permissionStr += ', ';
				}
				
				// data typ : n(숫자), e(영어), k(한글), s(특수문자), p(전화번호)
				switch(ct) {
				case 'n' : checkPatternStr += '\\d';
					permissionStr += '숫자';
					break;
				case 'p' : checkPatternStr += '\\d';
					permissionStr += '숫자';
					break;	
				case 'e' : checkPatternStr += 'a-z';
					permissionStr += '영문';
					break;
				case 'k' : checkPatternStr += 'ㄱ-ㅎ|가-힣';
					permissionStr += '한글';
					break;
				case 's' : checkPatternStr += '\W';
					permissionStr += '특수문자';
					break;
 				}
			}
			
			if(!typeCheck) {
				typeCheck = true; // 형식 확인 대상
			}		
		}
		
		// 길이 확인
		if(element.dataset.hasOwnProperty('checkLength')) {
			var checkLength = element.dataset.checkLength.split('~');
			
			if(checkLength.length > 1) {
				min = checkLength[0];
				max = checkLength[1];
			} 
			
			if(!lengthCheck) {
				lengthCheck = true; // 길이 확인 대상
			}
		}
		
		result.replace = new RegExp('[^' + checkPatternStr + ']', 'gi');
		checkPatternStr = '^[' + checkPatternStr + ']*$';
		result.pattern = new RegExp(checkPatternStr, 'gi');
		result.message = permissionStr + '만 입력할 수 있습니다.';
		result.min = min;
		result.max = max;
		result.typeCheck = typeCheck;
		result.lengthCheck = lengthCheck;
	
		return result;
	}
	
	// 해당 유효성 확인 메세지를 보여주거나 삭제
	function message(element, permission, message) {
		var msg = document.getElementById(element.name);
		
		if(msg != null) {
			remove(msg);
		}
		
		// 해당 유효성에 적합하지 않을 경우 메세지 출력
		if(!permission) {
			msg = document.createElement('p');	
			msg.innerText = message;
			msg.className = 'msg';
			msg.id = element.name;
			
			element.parentElement.appendChild(msg);
		}
	}

	function append(element, newElement) {
		element.parentElement.appendChild(newElement);
	}
	
	function remove(element) {
		element.parentElement.removeChild(element);
	}
	
	// 회원 목록 페이지로 이동
	function goList(form) {
		form.action = 'list.jsp';
		form.method = 'get';
		form.submit();
	}
</script>
</body>
</html>