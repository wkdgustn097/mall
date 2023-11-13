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
<style>
* {
  margin: 0px;
  padding: 0px;
  text-decoration: none;
  font-family:sans-serif;

}

body {
  background-image:#34495e;
}

.joinForm {
  position:absolute;
  width:400px;
  height:400px;
  padding: 30px, 20px;
  background-color:#FFFFFF;
  text-align:center;
  top:40%;
  left:50%;
  transform: translate(-50%,-50%);
  border-radius: 15px;
}

.joinForm h2 {
  text-align: center;
  margin: 30px;
}

.textForm {
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
}


.id {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.pw {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.name {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.email {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.nickname {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.cellphoneNo {
  width: 100%;
  border:none;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

.btn {
  position:relative;
  left:40%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:80%;
  height:40px;
  background: linear-gradient(125deg,#81ecec,#6c5ce7,#81ecec);
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

.btn:hover {
  background-position: right;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/insertAction.jsp" method="POST" class="joinForm" id="insertForm">
                                                                                               
      <h2>회원가입</h2>
      <div class="textForm">
        <%
			if(msg != null) {
		%>
				<span><%=msg%></span>		
		<%
			}
		%>
        <input name="insertId" id="insertId" class="id" placeholder="아이디">
      </div>
      <div class="textForm">
        <input name="insertPw" id="insertPw" type="password" class="pw" placeholder="비밀번호">
      </div>
       <div class="textForm">
        <input name="insertPwCk" id="insertPwCk" type="password" class="pw" placeholder="비밀번호 확인">
      </div>
      <div class="textForm">
        <input name="insertName" id="insertName" type="text" class="name" placeholder="이름">
      </div>
      <div class="textForm">
        <input name="insertAddress" id="insertAddress" type="text" class="nickname" placeholder="주소">
      </div>
      <div class="textForm">
        <input name="insertPhone" id="insertPhone" type="text" class="cellphoneNo" placeholder="전화번호">
      </div>
      <button type="submit" class="btn" id="insertBtn">회원가입</button>
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
</body>
</html>