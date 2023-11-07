<!-- myPageDelete -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%    
	if(session.getAttribute("loginId") == null) { // 로그인이 안되어있으면 login.jsp로 보냄
		response.sendRedirect(request.getContextPath()+"/login.jsp");
		return;
	}
	String loginId = (String)(session.getAttribute("loginId"));
	String msg = request.getParameter("msg");
	String deleteMsg = request.getParameter("deletePageOpen");
%>
<jsp:include page="/inc/menu.jsp"></jsp:include> <!-- 네비게이션바 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<%
			if(msg != null) {
		%>
				<div><%=msg%></div>		
		<%
			}
		%>
		<%
			if(deleteMsg == null || "false".equals(deleteMsg)) {
		%>
		<form action="<%=request.getContextPath()%>/myPageDeleteCk.jsp">	<!-- 비밀번호 확인 전송 form -->
			<table border="1" class="table">
				<tr>
					<td>아이디</td>
					<td><%=loginId%></td>
				</tr>	
				<tr>
					<td>원래 비밀번호</td>
					<td><input type="password" name="beforePw" id="beforePw"></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-warning">계정삭제</button>
		</form>
		<%
			}
		%>
		<%
			if("true".equals(deleteMsg)) {	//비밀번호 확인 후 마이페이지 노출
		%>
		<form action="<%=request.getContextPath()%>/myPageDeleteAction.jsp">	<!-- 비밀번호 확인 전송 form -->
			<h1> <%=loginId%> 아이디를 정말 삭제하시겠습니까?</h1>
			<button type="submit" class="btn btn-danger">계정삭제</button>
			<a  href="<%=request.getContextPath()%>/main.jsp" class="btn btn-primary">홈페이지로</a>
		</form>
		<%
			}
		%>
	</div>
</body>
</html>