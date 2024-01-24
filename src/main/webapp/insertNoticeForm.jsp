<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.Manager" %>
<%	
	if(session.getAttribute("managerId") == null){
		response.sendRedirect(request.getContextPath()+"/notice.jsp");
		return;
	}
	String url = "jdbc:mariadb://3.36.253.196/mall";
	String dbuser = "root";
	String dbpw = "java1234";

	Connection conn = DriverManager.getConnection(url, dbuser, dbpw);

	String sql = "SELECT manager_no managerNo, manager_name managerName FROM manager";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();

	List<Manager> managerList = new ArrayList<Manager>();

	while (rs.next()) {
    	Manager manager = new Manager();
    	manager.setManagerNo(rs.getInt("managerNo"));
    	manager.setManagerName(rs.getString("managerName"));
    	managerList.add(manager);
	}

	request.setAttribute("managerList", managerList);

	rs.close();
	stmt.close();
	conn.close();	
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
	 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="author" content="Untree.co">
  <link rel="shortcut icon" href="favicon.png">

  <meta name="description" content="" />
  <meta name="keywords" content="bootstrap, bootstrap4" />

		<!-- Bootstrap CSS -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
		<link href="css/tiny-slider.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<title>Furni Free Bootstrap 5 Template for Furniture and Interior Design Websites by Untree.co </title>
</head>
<body>
	<jsp:include page="/inc/menu.jsp"></jsp:include>
	
	<!-- Start Hero Section -->
			<div class="hero">
				<div class="container">
					<div class="row justify-content-between">
						<div class="col-lg-5">
							<div class="intro-excerpt">
								<h1>QnA</h1>
							</div>
						</div>
						<div class="col-lg-7">
							
						</div>
					</div>
				</div>
			</div>
		<!-- End Hero Section -->
		
		<div class="untree_co-section before-footer-section">
            <div class="container">
             <div class="p-3 p-lg-5 border bg-white">
             <h1 class="mb-4 section-title">QnA</h1>
             <br>
				<form action="<%=request.getContextPath()%>/insertNoticeAction.jsp">
				<table class ="table">
    		
    		<tr>
        		<td><p>공지제목</p></td>
        		<td><input type="text" name="notice_title"></td>
    		</tr>
    		<tr>
        		<td><p>공지내용</p></td>
        		<td><textarea name="notice_content" rows="5" cols="50"></textarea>
        		</td>
    		</tr>
		</table>
		<button class="btn btn-black btn-lg py-3 btn-block">완료</button>

	</form>
	</div>
            </div>
          </div>

		<script src="js/bootstrap.bundle.min.js"></script>
		<script src="js/tiny-slider.js"></script>
		<script src="js/custom.js"></script>	
</body>
</html>