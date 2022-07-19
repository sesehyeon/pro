<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="searchDTO" class="member.SearchDTO"/>
<jsp:useBean id="pagination" class="member.pagination.Pagination"/>
<jsp:setProperty property="*" name="searchDTO"/>
<jsp:setProperty property="*" name="pagination"/>
<% response.setHeader("Cache-Control", "no-store"); %>
<% response.setHeader("Pragma", "no-cache"); %>
<% response.setDateHeader("Expire", 0); %>
<%
	String conditionArr = "";
	String keyword = "";
	
	int[] conditionList = new int[0];
	int sortColumn = 1;
	int sortType = 1;
	int presentPage = 1;
	int totalCount = 0;

	try {
		if(searchDTO.getConditionList() != null) {
			conditionList = searchDTO.getConditionList();
		}
		if(searchDTO.getKeyword() != null) {
			keyword = searchDTO.getKeyword();
		}
		if(searchDTO.getSortColumn() != 0) {
			sortColumn = searchDTO.getSortColumn();
		}
		if(pagination.getPage() != 0) {
			presentPage = pagination.getPage();
		}
		
		sortType = searchDTO.getSortType();
			
		searchDTO.setSearchDTO(conditionList, keyword, sortColumn, sortType);
		
		totalCount = dao.getTotalCount(searchDTO);
		pagination = pagination.setPageination(presentPage, totalCount);
		
		conditionArr = "[";	
		for(int i=0; i<conditionList.length; i++) {
			if(i> 0) {
				conditionArr += ",";
			}
			conditionArr += conditionList[i];
		}
		conditionArr += "]";
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<link href="../css/member.css" rel="stylesheet">
</head>
<body>
	<div class="wrapper ml">
		<h1>회원 목록</h1>
		<form name="listForm" action="./list.jsp" method="get">
			<input type="hidden" name="sortColumn" value="${searchDTO.sortColumn}">
			<input type="hidden" name="sortType" value="${searchDTO.sortType}">
			<input type="hidden" name="page" value="${pagination.page}">
			<input type="hidden" name="num" value="">
			
			<div class="searchArea">
				<div class="conditionArea"><b>검색 조건 :</b>
					<label><input type="checkbox" name="conditionList" value="1">아이디</label>
					<label><input type="checkbox" name="conditionList" value="2">이름</label>
					<label><input type="checkbox" name="conditionList" value="3">전화번호</label>
					<label><input type="checkbox" name="conditionList" value="4">주소</label>
					<label><input type="checkbox" name="conditionList" value="5">가입일</label>
					<label><input type="checkbox" name="conditionList" value="6">수정일</label>
				</div>
				<div class="keywordArea">
					<label><b>검색어 :</b>
						<input type="text" name="keyword" value="${searchDTO.keyword}" onkeydown="if(event.keyCode==13){search();}">
						<input type="button" onclick="search();" value="검색">
					</label>
				</div>
			</div>
			<table class="mlTbl">
				<colgroup>
					<col width="10%">
					<col width="15%">
					<col width="10%">
					<col width="15%">
					<col width="*%">
					<col width="12%">
					<col width="12%">
				</colgroup>
				<thead>
					<tr>
						<th class="mlfield" data-value="1" data-type="0">회원번호</th>
						<th class="mlfield" data-value="2" data-type="0">아이디</th>
						<th class="mlfield" data-value="3" data-type="0">이름</th>
						<th class="mlfield" data-value="4" data-type="0">전화번호</th>
						<th class="mlfield" data-value="5" data-type="0">주소</th>
						<th class="mlfield" data-value="6" data-type="0">가입일</th>
						<th class="mlfield" data-value="7" data-type="0">수정일</th>
					</tr>
				</thead>
				<tbody>
				<c:set var="list" value="${dao.getMemberList(searchDTO, pagination)}"/>
				<c:choose>
					<c:when test="${list.size() > 0}">
						<c:forEach var="dto" items="${list}">
					<tr class="mtr" data-value="${dto.num}">
						<td class="tac">${dto.num}</td>
						<td class="tac">${dto.id}</td>
						<td class="tac">${dto.name}</td>
						<c:choose>
							<c:when test="${dto.phone.length() == 11}">
						<td class="tac">${fn:substring(dto.phone, 0, 3)}-${fn:substring(dto.phone, 3, 7)}-${fn:substring(dto.phone, 7, 11)}</td>
							</c:when>
							<c:otherwise>
						<td class="tac">${dto.phone}</td>	
							</c:otherwise>
						</c:choose>
						<td>${dto.address}</td>
						<td class="tac"><fmt:formatDate value="${dto.joindate}" pattern="yyyy-MM-dd"/></td>
						<td class="tac"><fmt:formatDate value="${dto.modifydate}" pattern="yyyy-MM-dd"/></td>
					</tr>	
						</c:forEach>
						<c:set var="spaceRow" value="${pagination.rowNumber - list.size()}"/>
						<c:choose>
							<c:when test="${spaceRow > 0}">
								<c:forEach begin="1" end="${spaceRow}">
					<tr>
						<td>&nbsp;</td><td></td><td></td><td></td><td></td><td></td><td></td>
					</tr>		
								</c:forEach>
							</c:when>
						</c:choose>
					</c:when>
					<c:otherwise>
					<tr>
						<th colspan="7">등록된 회원이 없습니다.</th>
					</tr>	
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
			<div class="tac pageBtn">
				<button type="button" ${pagination.page > 1? '' : 'disabled'} onclick="pageMove(1);">&lt;&lt;</button>
				<button type="button" ${pagination.prevActive ? '' : 'disabled'} onclick="pageMove(${pagination.startPage-1});">&lt;</button>
				<c:forEach var="p" begin="${pagination.startPage}" end="${pagination.endPage}">
				<button type="button" onclick="pageMove(${p});" ${p eq pagination.page ? 'style="color: #00f;font-weight: bold;"' : ''}>${p}</button>
				</c:forEach>
				<button type="button" ${pagination.nextActive ? '' : 'disabled'} onclick="pageMove(${pagination.endPage+1});">&gt;</button>
				<button type="button" ${pagination.page < pagination.totalPage? '' : 'disabled'} onclick="pageMove(${pagination.totalPage});">&gt;&gt;</button>
				<input type="button" value="회원가입" onclick="goJoin();" style="margin-left: 20px;">
				<span style="float:right;">${pagination.page}/${pagination.totalPage}</span>
			</div>
		</form>
	</div>
<script type="text/javascript">
	document.body.onload = function() {
		setListForm();
	}
	
	// listForm 설정
	function setListForm() {
		var mlfieldList = document.getElementsByClassName('mlfield');
		var conditionList = document.getElementsByName('conditionList');
		var mtrList = document.getElementsByClassName('mtr');
		var conditionArr = <%=conditionArr%>;
		
		// list table 해당 컬럼으로 정렬
		for(var i=0; i<mlfieldList.length; i++) {
			var sortType = listForm.sortType.value;
			var mlfield = mlfieldList[i];
			
			if(Number(sortType) == 0) {
				mlfield.dataset.type = 1;
			} else {
				mlfield.dataset.type = 0;
			}
			
			mlfield.onclick = function() {
				var listForm = document.listForm
				
				listForm.sortColumn.value = this.dataset.value;
				listForm.sortType.value = this.dataset.type;
				search();
			}
		}
		
		// 검색 조건 checkbox 설정
		for(var i=0; i<conditionList.length; i++) {
			var condition = conditionList[i];
			
			for(var j=0; j<conditionArr.length; j++) {
				if(Number(condition.value) == Number(conditionArr[j])) {
					condition.checked = true;
				}
			}
		}
		
		// list table 해당 회원 수정페이지로 이동
		for(var i=0; i<mtrList.length; i++) {
			var mtr = mtrList[i];
			
			mtr.onclick = function() {
				var listForm = document.listForm;
				
				listForm.action = "modify_view.jsp?";
				listForm.num.value = this.dataset.value;
				listForm.submit();
			}
		}
	}
	
	// 페이지 이동
	function pageMove(page) {
		var listForm = document.listForm;
		
		listForm.action = 'list.jsp';
		listForm.page.value = page;
		listForm.submit();
	}
	
	// 검색
	function search() {
		var listForm = document.listForm;
		
		listForm.action = 'list.jsp';
		listForm.page.value = 1;
		listForm.submit();
	}
	
	// 회원가입 페이지로 이동
	function goJoin() {
		var listForm = document.listForm;
		
		listForm.action = 'join_view.jsp';
		listForm.method = 'get';
		listForm.submit();
	}
</script>	
</body>
</html>