<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>

<script type="text/javascript">
	var result = Number(${dao.modify(dto)});
	
	if(result == 1) {
		alert('수정되었습니다.');
	} else {
		alert('수정에 실패했습니다.');
	}
	location.href = 'list.jsp'
</script>
