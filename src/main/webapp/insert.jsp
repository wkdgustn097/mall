<!-- insertMember -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h1>회원가입</h1>
		<form action="<%=request.getContextPath()%>/insertAction.jsp"> <!-- from으로 데이터 전송 -->
		<table border="1" class="table table-primary">
		<tr>
			<td>아이디</td>
			<td><input type="text" name="insertId"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="insertPw"></td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td><input type="password" name="insertPwCh"></td>
		</tr>
		
		<tr>
			<td>이름</td>
			<td><input type="text" name="insertName" ></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input type="text" name="insertPhone" ></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><input type="text" name="insertAddress" ></td>
		</tr>
		</table>
		<button type="submit" class="btn btn-success">회원가입</button>
		</form>
	</div>
</body>
</html>