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
	<br>
		<h1>회원가입</h1>
	<br>
	
		<form action="<%=request.getContextPath()%>/insertAction.jsp" id="insertForm"> <!-- form으로 데이터 전송 -->
		<table class="table table-hover ">
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
				let getExp = /^\d{3}-\d{3,4}-\d{4}$/;
				
				
				if($('#insertId').val()==""){ //id값이 없을 경우
					alert("아이디를 입력하세요");         //메세지 경고창을 띄운 후
					$('#insertId').focus();     // id 텍스트박스에 커서를 위치
					return false;
				}
				if($('#insertId').val()==" " || $('#insertId').val()=="  " || $('#insertId').val()=="   "){ 
					alert("공백은 입력 불가능 합니다"); 
					$("#insertId").val("");
					$('#insertId').focus(); 
					return false;
				}
				if (!getId.test($('#insertId').val())){
					alert("아이디는 4~12자, 영문 대소문자, 숫자만 가능합니다.");
					$("#insertId").val("");
					$('#insertId').focus();
					return false;
	        	}
				
				
				if($('#insertPw').val()==""){ 
					alert("비밀번호를 입력하세요");        
					$('#insertPw').focus();     
					return false;
				}
				if($('#insertPw').val()==" " || $('#insertPw').val()=="  " || $('#insertPw').val()=="   "){ 
					alert("공백은 입력 불가능 합니다");
					$("#insertPw").val("");
					$('#insertPw').focus();    
					return false;
				}
				
				if($('#insertPwCk').val()==""){
					alert("비밀번호 확인을 입력하세요"); 
					$('#insertPwCk').focus();
					return false;
				}
				if($('#insertPwCk').val()==" " || $('#insertPwCk').val()=="  " || $('#insertPwCk').val()=="   "){
					alert("공백은 입력 불가능 합니다"); 
					$("#insertPwCk").val("");
					$('#insertPwCk').focus(); 
					return false;
				}
				if($('#insertPw').val() != $('#insertPwCk').val()){
					alert('비밀번호가 맞지 않습니다 다시 입력해주세요');
					$('#insertPw').val('');
					$('#insertPwCk').val('');
					return false;
				}
				
				
				if($('#insertName').val()==""){
					alert("이름을 입력하세요");  
					$('#insertName').focus(); 
					return false;
				}
				if($('#insertName').val()==" " || $('#insertName').val()=="  " || $('#insertName').val()=="   "){
					alert("공백은 입력 불가능 합니다"); 
					$("#insertName").val("");
					$('#insertName').focus(); 
					return false;
				}
				if(!getName.test($("#insertName").val())){
					alert("이름은 한글만 입력 가능합니다.")
					$("#insertName").val("");
					$("#insertName").focus();
					return false;
				}
				
				
				if($('#insertPhone').val()==""){
					alert("전화번호를 입력하세요"); 
					$('#insertPhone').focus();
					return false;
				}
				if($('#insertPhone').val()==" " || $('#insertPhone').val()=="  " || $('#insertPhone').val()=="   "){
					alert("공백은 입력 불가능 합니다");
					$("#insertPhone").val("");
					$('#insertPhone').focus(); 
					return false;
				}
				if(!getExp.test($("#insertPhone").val())){
					alert("유효한 휴대폰번호를 입력해주세요 (010-****-****)");
					$("#insertPhone").val("");
					$("#insertPhone").focus();
					return false;
				}
				
				
				if($('#insertAddress').val()==""){
					alert("주소를 입력하세요");  
					$('#insertAddress').focus(); 
					return false;
				}
				if($('#insertAddress').val()==" " || $('#insertAddress').val()=="  " || $('#insertAddress').val()=="   "){
					alert("공백은 입력 불가능 합니다");
					$("#insertAddress").val("");
					$('#insertAddress').focus(); 
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