<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>

<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String reviewContent = request.getParameter("reviewContent");
	String loginId = (String)(session.getAttribute("loginId"));
	System.out.println(ordersNo + reviewContent);
	
	ReviewDao reviewDao = new ReviewDao();
	
	String result = reviewDao.reviewIn(ordersNo, reviewContent, loginId);
	if(result.equals("true")){
		System.out.println("액션 리뷰작성성공");
		String msg = URLEncoder.encode("리뷰작성 완료"); // 한글이 깨찜 방지
		response.sendRedirect(request.getContextPath()+"/review.jsp?msg="+msg);	
	}else if(result.equals("duplication")){
		System.out.println("리뷰 중복 메세지 출력");
		String msg = URLEncoder.encode("이미 리뷰를 작성하셨습니다"); // 한글이 깨찜 방지
		response.sendRedirect(request.getContextPath()+"/review.jsp?msg="+msg);	
	}else{
		System.out.println("리뷰등록 에러발생");
		String msg = URLEncoder.encode("리뷰 작성에 실패하였습니다 관리자에게 문의해주세요"); // 한글이 깨찜 방지
		response.sendRedirect(request.getContextPath()+"/review.jsp?msg="+msg);	
	}
	
%>