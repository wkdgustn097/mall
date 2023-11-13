<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	if(session.getAttribute("managerId") == null){
	response.sendRedirect(request.getContextPath()+"/notice.jsp");
	return;
	}

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println("액션진입");
	System.out.println(noticeNo + "<--noticeNo");


    NoticeDao nd = new NoticeDao();
    Notice n = new Notice();
    n.setNoticeNo(noticeNo);
	
    int row = nd.deleteNoticeAction(n);
        if(row == 1){
            System.out.println("삭제 완료");
        
        }else {
        System.out.println("삭제 실패");
    	}
    
    response.sendRedirect(request.getContextPath() + "/notice.jsp");
%>
