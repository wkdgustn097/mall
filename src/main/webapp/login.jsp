<!-- login -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<%@ page import="java.net.URLEncoder"%>
<%
	if(session.getAttribute("loginId") != null) { // 로그인 되어 있으면
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	}
	String msg = request.getParameter("msg");
%>
<jsp:include page="/inc/menuLogin.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<style>
@import "bourbon";

body {
	background: #eee !important;	
}

.wrapper {	
	margin-top: 80px;
  margin-bottom: 80px;
}

.form-signin {
  max-width: 550px;
  padding: 15px 35px 45px;
  margin: 0 auto;
  background-color: #fff;
  border: 1px solid rgba(0,0,0,0.1);  

  .form-signin-heading,
	.checkbox {
	  margin-bottom: 30px;
	}

	.form-control {
	  position: relative;
	  font-size: 16px;
	  height: auto;
	  padding: 10px;
		@include box-sizing(border-box);

		&:focus {
		  z-index: 2;
		}
	}

	input[type="text"] {
	  margin-bottom: -1px;
	  border-bottom-left-radius: 0;
	  border-bottom-right-radius: 0;
	}

	input[type="password"] {
	  margin-bottom: 20px;
	  border-top-left-radius: 0;
	  border-top-right-radius: 0;
	}
}

</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<br>
	

  <div class="wrapper">

    <form class="form-signin" method="post" action="<%=request.getContextPath()%>/loginAction.jsp">       
      <h2 class="form-signin-heading">Please login</h2>
      <%
			if(msg != null) {
		%>
				<span><%=msg%></span>		
		<%
			}
		%>
      <input type="text" class="form-control" id="id" name="id" placeholder="User ID" value="admin1"/>
      <input type="password" class="form-control" id="pw" name="pw" placeholder="Password" value="1234"/>      
      <br>
      <button class="btn btn-lg btn-primary btn-block " type="submit">Login</button>
      <a href="<%=request.getContextPath()%>/insert.jsp" class="btn btn-success">회원가입</a>
      <br><br>
      <a href="#" id="getAdmin">관리자계정 로그인</a>
	  <br>
	  <a href="#"  id="getCustomer">고객계정 로그인</a> 
    </form>
  </div>
	
</body>
	<script>
	$('#getAdmin').click(function (){
		$('#id').val('admin1');
		$('#pw').val('1234');
	});
	$('#getCustomer').click(function (){
		$('#id').val('test2');
		$('#pw').val('1234');
	})

	</script>
</html>