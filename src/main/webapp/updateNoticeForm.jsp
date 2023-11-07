<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeOne</title>
</head>
<%
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
%>
<body>
	<form action="<%=request.getContextPath()%>/updateNoticeAction.jsp">
		<table border="1">
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="notice_title">
				</td>
			</tr>
			<tr>
    			<td>공지내용</td>
    			<td>
       				 <textarea name="notice_content" rows="5" cols="50"></textarea>
    			</td>
			</tr>
			


		</table>
		<button>공지사항수정</button>
	</form>
</body>
</html>