<!-- login -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ page import="java.net.URLEncoder"%>
<%
	if(session.getAttribute("loginId") != null) { // 로그인 되어 있으면
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	}
	String msg = request.getParameter("msg");
%>
<jsp:include page="/inc/menuLogin.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<br>
<div class="container ">
	
	<h1>Login</h1>
	<br>
	<%
		if(msg != null) {
	%>
			<div><%=msg%></div>		
	<%
		}
	%>
	
	<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
		
			<table>
			<tr>
				<td><div class="form-label"><h2>ID &nbsp;</h2></div></td>
				<td><h2><input type="text" name="id"></h2></td>
			</tr>
			<tr>
				<td><div class="form-label"><h2>PW </h2></div></td>
				<td><h2><input type="password" name="pw"></h2></td>
			</tr>
			</table>
			<br>
				
					<button type="submit" class="btn btn-primary">로그인</button>
					<a href="<%=request.getContextPath()%>/insert.jsp" 
					class="btn btn-success">회원가입</a>
					<a href="<%=request.getContextPath()%>/managerInsert.jsp" 
					class="btn btn-success">매니저가입</a>
				
		
	</form>
	</div>
	
</body>
</html>