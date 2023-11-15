<!-- managerInsert -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!DOCTYPE html>
<%
	if(session.getAttribute("managerId") == null) {
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	}
	String msg = request.getParameter("msg");
%>
<jsp:include page="/inc/menuLogin.jsp"></jsp:include> <!-- 네비게이션바 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


</head>
<body>
	<div class="container">
	<br>
		<h1>매니저 전용 페이지</h1>
	<br>
		<form action="<%=request.getContextPath()%>/managerInsertAction.jsp" id="insertForm"> <!-- from으로 데이터 전송 -->
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
			<td><input type="text" name="insertName" id="insertName" ></td>
		</tr>
		</table>
		<button type="button" class="btn btn-success" id="insertBtn">매니저 계정생성</button>
		</form>
		<script>
			
			$(document).ready(function(){
			$('#insertBtn').click(function(){
				
				let getId= RegExp(/^[a-zA-Z0-9]{4,12}$/);
				let getName= RegExp(/^[가-힣]+$/);
				let getPw = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{1,50}).{8,16}$/;

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
				if (!getPw.test($('#insertPw').val())){
					alert("비밀번호는 영문,숫자,특수문자를 각각 하나씩 포함한 8~16자리로 설정해주세요.");
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
				
				
				$('#insertForm').submit();
			});
			});
			
		</script>
		
	</div>
	
</body>

</html>