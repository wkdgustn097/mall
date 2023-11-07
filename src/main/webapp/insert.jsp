<!-- insert -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<%
if(session.getAttribute("loginId") != null) { // 로그인 되어 있으면
	response.sendRedirect(request.getContextPath()+"/main.jsp"); // 메인페이지 
	return;
}
	String msg = request.getParameter("msg");
%>
<jsp:include page="/inc/menuLogin.jsp"></jsp:include> <!-- 네비게이션바 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h1>회원가입</h1>
		<form action="<%=request.getContextPath()%>/insertAction.jsp" id="insertForm"> <!-- form으로 데이터 전송 -->
		<table border="1" class="table table-primary">
		<tr>
			<%
				if(msg != null) {
			%>
					<span><%=msg%></span>		
			<%
				}
			%>
			<td>아이디</td>
			<td><input type="text" name="insertId" id="insertId"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="insertPw" id="insertPw"></td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td><input type="password" name="insertPwCk" id="insertPwCk"></td>
		</tr>
		
		<tr>
			<td>이름</td>
			<td><input type="text" name="insertName" id="insertName"></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input type="text" name="insertPhone" id="insertPhone"></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><input type="text" name="insertAddress" id="insertAddress"></td>
		</tr>
		</table>
		<button type="submit" class="btn btn-success" id="insertBtn">회원가입</button>
		<script>
			
			$(document).ready(function(){
			$('#insertBtn').click(function(){
				
				let getId= RegExp(/^[a-zA-Z0-9]{4,12}$/);
				let getName= RegExp(/^[가-힣]+$/);
				
				
	        	if (!getId.test($('#insertId').val())){
					alert("아이디는 4~12자, 영문 대소문자, 숫자만 가능합니다.");
					$("#insertId").val("");
					$('#insertId').focus();
					return false;
	        	}
				 
				
				
				if($('#insertPw').val() != $('#insertPwCk').val()){
					alert('비밀번호가 맞지 않습니다 다시 입력해주세요');
					$('#insertPw').val('');
					$('#insertPwCk').val('');
					return false;
				}
				if(!getName.test($("#insertName").val())){
					alert("이름은 한글만 입력 가능합니다.")
					$("#insertName").val("");
					$("#insertName").focus();
					return false;
				} 
				$('#insertForm').submit();
			});
			});
			
		</script>
		
		
		</form>
	</div>
</body>
</html>