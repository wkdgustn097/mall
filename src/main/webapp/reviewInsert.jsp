<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ page import="java.net.URLEncoder"%>
<%
	if(session.getAttribute("loginId") == null) {
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	}
	String msg = request.getParameter("msg");
%>
<jsp:include page="/inc/menu.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/reviewInsertAction.jsp">
		<table border="1">
    		<tr>
        		<td colspan="2">오더번호</td>
        		<td colspan="2"><input name="ordersNo"></td>
    		</tr>
    		<tr>
        		<td colspan="2">리뷰내용작성</td>
        		
            	<td colspan="2"><textarea name="reviewContent" rows="5" cols="50"></textarea> </td>
        		
    		</tr>
		</table>
		<button type="submit">리뷰입력</button>
	</form>
</body>
</html>