<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertNoticeForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/insertNoticeAction.jsp">
		<table border="1">
			<tr>
				<td>공지제목</td>
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
		<button>완료</button>
	</form>
</body>
</html>