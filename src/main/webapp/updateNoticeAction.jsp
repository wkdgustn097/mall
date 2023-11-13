<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%	
	request.setCharacterEncoding("UTF-8");

	String noticeTitle = request.getParameter("notice_title");
	String noticeContent = request.getParameter("notice_content");
	int noticeNo = Integer.parseInt(request.getParameter("notice_no"));

	
	NoticeDao nd = new NoticeDao();
	Notice n = new Notice();
	n.setNoticeTitle(noticeTitle);
	n.setNoticeContent(noticeContent);
	n.setNoticeNo(noticeNo);
	
	int row = nd.updateNoticeAction(n);
	
	if(row == 1){
		System.out.println("수정완료");
		
	}
		response.sendRedirect(request.getContextPath()+"/notice.jsp");
%>
