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
<jsp:include page="/inc/menu.jsp"></jsp:include> <!-- 네비게이션바 -->
<!DOCTYPE html>
<html>
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
							<td>아이디</td>
							<td><%=loginId%></td>
						</tr>	
						<tr>
							<td>원래 비밀번호</td>
							<td><input type="password" name="beforePw" id="beforePw"></td>
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
							<td>아이디</td>
							<td><%=loginId%></td>
						</tr>
				<tr>
					<td>새로운비밀번호</td>
					<td><input type="password" name="updatePw" id="updatePw"></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="updatePwCk" id="updatePwCk"></td>
				</tr>
				
				<tr>
					<td>이름</td>
					<td><input type="text" name="updateName" id="updateName"></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="updatePhone" id="updatePhone"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="updateAddress" id="updateAddress"></td>
				</tr>
			
				</table>
				<button type="button" class="btn btn-success" id="myPageBtn">수정</button>
	

				<script>
					$(document).ready(function(){
					$('#myPageBtn').click(function(){
		
						let getName= RegExp(/^[가-힣]+$/);
						
		
						if($('#updatePw').val() != $('#updatePwCk').val()){
							alert('비밀번호가 맞지 않습니다 다시 입력해주세요');
							$('#updatePw').val('');
							$('#updatePwCk').val('');
							return false;
						}
						if(!getName.test($("#updateName").val())){
							alert("이름은 한글만 입력 가능합니다.")
							$("#updateName").val("");
							$("#updateName").focus();
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