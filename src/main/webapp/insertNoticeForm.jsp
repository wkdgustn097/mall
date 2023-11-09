<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.Manager" %>
<%	
	if(session.getAttribute("managerId") == null){
		response.sendRedirect(request.getContextPath()+"/notice.jsp");
		return;
	}
	String url = "jdbc:mariadb://localhost:3306/mall";
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
<html>
<head>
<meta charset="UTF-8">
<title>insertNoticeForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/insertNoticeAction.jsp">
		<table border="1">
    		<tr>
        		<td colspan="2">매니저번호</td>
       			<td colspan="2">
            		<select name="manager_no">
            			<option value="">선택하세요</option>
            			<%
            			for(Manager manager: managerList){ 
            			%>
            				<option value="<%= manager.getManagerNo() %>"><%= manager.getManagerNo() %></option>
            			<% 
            				} 
            			%> 
            		</select>
       			</td>
    	    </tr>
    		<tr>
        		<td colspan="2">공지제목</td>
        		<td colspan="2">
            		<input type="text" name="notice_title">
        		</td>
    		</tr>
    		<tr>
        		<td colspan="2">공지내용</td>
        		<td colspan="2">
            		<textarea name="notice_content" rows="5" cols="50"></textarea>
        		</td>
    		</tr>
		</table>
		<button>완료</button>

	</form>
		
</body>
</html>