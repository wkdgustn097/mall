<!-- myPage -->
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
	String myPageOpen = request.getParameter("myPageOpen");
%>
<jsp:include page="/inc/menuLogin.jsp"></jsp:include> <!-- 네비게이션바 -->
<!DOCTYPE html>
<html>
<style>
	.my-input {border-radius : 5px;
	
	}
	.my-text{
		font-weight: 700;
	}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
	<br>
	<h1> 회원정보 수정 </h1>
	<%
		if(msg != null) {
	%>
			<div><%=msg%></div>		
	<%
		}
	%>
	
		<%
			if(myPageOpen == null || "false".equals(myPageOpen)) {
		%>
				<form action="<%=request.getContextPath()%>/myPageAction.jsp">	<!-- 비밀번호 확인 전송 form -->
					<table border="1" class="table">
						<tr>
							<td class="my-text">아이디</td>
							<td class="my-text"><%=loginId%></td>
						</tr>	
						<tr>
							<td class="my-text">원래 비밀번호</td>
							<td class="my-text"><input class="my-input" type="password" name="beforePw" id="beforePw"></td>
						</tr>
					</table>
					<button type="submit" class="btn btn-success">수정</button>
				</form>
		<%
			}
		%>
		<%
			if("true".equals(myPageOpen)) {	//비밀번호 확인 후 마이페이지 노출
		%>
			<form action="<%=request.getContextPath()%>/myPageActionGo.jsp" id="myPageForm">	<!-- 마이페이지 수정 form -->
				<table border="1" class="table">
						<tr>
							<td class="my-text">아이디</td>
							<td class="my-text"><%=loginId%></td>
						</tr>
				<tr>
					<td class="my-text">새로운비밀번호</td>
					<td><input class="my-input" type="password" name="updatePw" id="updatePw"></td>
				</tr>
				<tr>
					<td class="my-text">비밀번호 확인</td>
					<td><input class="my-input" type="password" name="updatePwCk" id="updatePwCk"></td>
				</tr>
				
				<tr>
					<td class="my-text">이름</td>
					<td><input class="my-input" type="text" name="updateName" id="updateName"></td>
				</tr>
				<tr>
					<td class="my-text">전화번호</td>
					<td><input class="my-input" type="text" name="updatePhone" id="updatePhone"></td>
				</tr>
				<tr>
					<td class="my-text">주소</td>
					<td><input class="my-input" type="text" name="updateAddress" id="updateAddress"></td>
				</tr>
			
				</table>
				<button type="button" class="btn btn-success" id="myPageBtn">수정</button>
	

				<script>
					$(document).ready(function(){
					$('#myPageBtn').click(function(){
		

						let getId= RegExp(/^[a-zA-Z0-9]{4,12}$/);
						let getName= RegExp(/^[가-힣]+$/);
						let getExp = /^\d{3}-\d{3,4}-\d{4}$/;
						
						
						
						
						if($('#updatePw').val()==""){ 
							alert("비밀번호를 입력하세요");        
							$('#insertPw').focus();     
							return false;
						}
						if($('#updatePw').val()==" " || $('#updatePw').val()=="  " || $('#updatePw').val()=="   "){ 
							alert("공백은 입력 불가능 합니다");
							$("#updatePw").val("");
							$('#updatePw').focus();    
							return false;
						}
						
						if($('#updatePwCk').val()==""){
							alert("비밀번호 확인을 입력하세요"); 
							$('#updatePwCk').focus();
							return false;
						}
						if($('#updatePwCk').val()==" " || $('#updatePwCk').val()=="  " || $('#updatePwCk').val()=="   "){
							alert("공백은 입력 불가능 합니다"); 
							$("#updatePwCk").val("");
							$('#updatePwCk').focus(); 
							return false;
						}
						if($('#updatePw').val() != $('#updatePwCk').val()){
							alert('비밀번호가 맞지 않습니다 다시 입력해주세요');
							$('#updatePw').val('');
							$('#updatePwCk').val('');
							return false;
						}
						
						
						if($('#updateName').val()==""){
							alert("이름을 입력하세요");  
							$('#updateName').focus(); 
							return false;
						}
						if($('#updateName').val()==" " || $('#updateName').val()=="  " || $('#updateName').val()=="   "){
							alert("공백은 입력 불가능 합니다"); 
							$("#updateName").val("");
							$('#updateName').focus(); 
							return false;
						}
						if(!getName.test($("#updateName").val())){
							alert("이름은 한글만 입력 가능합니다.")
							$("#updateName").val("");
							$("#updateName").focus();
							return false;
						}
						
						
						if($('#updatePhone').val()==""){
							alert("전화번호를 입력하세요"); 
							$('#updatePhone').focus();
							return false;
						}
						if($('#updatePhone').val()==" " || $('#updatePhone').val()=="  " || $('#updatePhone').val()=="   "){
							alert("공백은 입력 불가능 합니다");
							$("#updatePhone").val("");
							$('#updatePhone').focus(); 
							return false;
						}
						if(!getExp.test($("#updatePhone").val())){
							alert("유효한 휴대폰번호를 입력해주세요 (010-****-****)");
							$("#updatePhone").val("");
							$("#updatePhone").focus();
							return false;
						}
						
						
						if($('#updateAddress').val()==""){
							alert("주소를 입력하세요");  
							$('#updateAddress').focus(); 
							return false;
						}
						if($('#updateAddress').val()==" " || $('#updateAddress').val()=="  " || $('#updateAddress').val()=="   "){
							alert("공백은 입력 불가능 합니다");
							$("#updateAddress").val("");
							$('#updateAddress').focus(); 
							return false;
						}
						
						
						
						$('#myPageForm').submit();
					});
					}); 
					
				</script>
		</form>
		<%
			}
		%>
	
	</div>
	
</body>
</html>