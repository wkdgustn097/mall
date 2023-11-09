<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%		
		int managerNo = 2;
		if(request.getParameter("manager_no") != null){
			managerNo = Integer.parseInt(request.getParameter("manager_no"));
		}
    	String noticeTitle = null;
    	if(request.getParameter("notice_title") != null){
    		noticeTitle = request.getParameter("notice_title");
    	}
    	String noticeContent = null;
    	if(request.getParameter("notice_content") != null){
    		noticeContent = request.getParameter("notice_content");
    	}
    

    
        NoticeDao nd = new NoticeDao();
        Notice n = new Notice();
        n.setManagerNo(managerNo);
        n.setNoticeTitle(noticeTitle);
        n.setNoticeContent(noticeContent);

        int row = nd.insertNoticeAction(n);
        if (row == 1) {
            System.out.println("입력성공");
        
    } else {
        System.out.println("입력실패");
    }

    response.sendRedirect(request.getContextPath() + "/notice.jsp");
%>