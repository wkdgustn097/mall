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
<div class="container ">
	<h1>로그인</h1>
	<%
		if(msg != null) {
	%>
			<div><%=msg%></div>		
	<%
		}
	%>
	<form method="post" action="<%=request.getContextPath()%>/loginAction.jsp">
		<table border="1" class="table table-bordered table-striped">
			<tr>
				<th><h2>아이디</h2></th>
				<td><h2><input type="text" name="id"></h2></td>
			</tr>
			<tr>
				<th><h2>패스워드</h2></th>
				<td><h2><input type="password" name="pw"></h2></td>
			</tr>
			<tr>
				<th colspan="2">
					<button type="submit" class="btn btn-primary">로그인</button>
					<a href="<%=request.getContextPath()%>/insert.jsp" 
					class="btn btn-success">회원가입</a>
					<a href="<%=request.getContextPath()%>/managerInsert.jsp" 
					class="btn btn-success">매니저가입</a>
				</th>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>