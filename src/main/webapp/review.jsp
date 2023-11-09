<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<div class="container">
	<br>
	<br>
	<a href="<%=request.getContextPath()%>/main.jsp" class="btn btn-success">홈으로</a>
	<br>
	<br>
	<a href="<%=request.getContextPath()%>/reviewInsert.jsp" class="btn btn-success">리뷰입력</a>
</div>
</body>
</html>