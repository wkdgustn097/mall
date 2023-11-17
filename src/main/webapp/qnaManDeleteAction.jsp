<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	if(session.getAttribute("managerId") == null){
		response.sendRedirect(request.getContextPath()+"/qnaForm.jsp");
		return;
	}

	int questionCommentNo = Integer.parseInt(request.getParameter("questionCommentNo"));
	System.out.println(questionCommentNo + "questionCommentNo");
	
	QnaDao qnaDao = new QnaDao();
	//QuestionComment qc = QnaDao.qnaManDelete(questionCommentNo);
	// a=qc.setQuestionCommentNo(questionCommentNo)
	int row = qnaDao.qnaManDelete(questionCommentNo);
	if(row == 1){
     	System.out.println("삭제 완료");
 
 	}else {
 		System.out.println("삭제 실패");
		}
	response.sendRedirect(request.getContextPath() +"/qnaForm.jsp");
	
%>