<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>noticeOne</title>
</head>
<%
	
    int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
    Class.forName("org.mariadb.jdbc.Driver");
    System.out.println("드라이브 로딩 성공");
    String url = "jdbc:mariadb://localhost:3306/mall";
    String dbuser = "root";
    String dbpw = "java1234";
    Connection conn = DriverManager.getConnection(url, dbuser, dbpw);
    System.out.println("db접속 성공");

    String sql = "SELECT notice_title noticeTitle, notice_content noticeContent, createdate, updatedate from notice where notice_no = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setInt(1, noticeNo);
    ResultSet rs = stmt.executeQuery();
    Notice notice = null;

    if (rs.next()) {
        notice = new Notice();
        notice.setNoticeTitle(rs.getString("noticeTitle"));
        notice.setNoticeContent(rs.getString("noticeContent"));
        notice.setCreatedate(rs.getString("createdate"));
        notice.setUpdatedate(rs.getString("updatedate"));
    }
    rs.close();
    stmt.close();
    conn.close();
%>
<body>

    <h1>공지사항 상세페이지</h1>
    <table border="1">
        <tr>
            <th>notice_title</th>
            <td><%=notice.getNoticeTitle()%></td>
        </tr>
        <tr>
            <td>공지내용</td>
            <td>
                <textarea name="notice_content" rows="10" cols="50"><%=notice.getNoticeContent() %></textarea>
            </td>
        </tr>
    </table>
   	<div>
   		<a href="<%=request.getContextPath() %>/updateNoticeForm.jsp?noticeNo=<%=noticeNo%>">수정</a>

    	<a href="<%=request.getContextPath() %>/deleteNoticeAction.jsp?noticeNo=<%=noticeNo%>">삭제</a>
	</div>
</body>
</html>
