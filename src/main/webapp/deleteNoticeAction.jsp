<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	NoticeDao nd = new NoticeDao();
	Notice n = new Notice();
	n.setNoticeTitle(request.getParameter("getNoticeTitle"));
	n.setNoticeContent(request.getParameter("getNoticeContent"));
	
	int row = nd.deleteNoticeAction(n);
	
	if(row==1){
		System.out.println("삭제완료");
		
	}
	response.sendRedirect(request.getContextPath()+"/notice.jsp");
	
%>
