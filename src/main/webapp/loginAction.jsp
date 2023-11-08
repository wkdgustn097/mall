<!-- loginAction -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	String customerNo = null;
	String customerId = request.getParameter("id");
	String customerPw = request.getParameter("pw");
	String managerId = request.getParameter("id");
	String managerPw = request.getParameter("pw");
	
	UserDao userDao = new UserDao();

	ArrayList<Login> logOn = userDao.login(customerId,customerPw,managerId,managerPw);
	if (logOn.size() > 0) {	// logOn에 값이 없으면 로그인 실패로 보냄
		int customerNo1 = logOn.get(0).getCustomerNo();
		int managerNo1 = logOn.get(0).getManagerNo();
		String customerId1 = logOn.get(0).getCustomerId();
		String managerId1 = logOn.get(0).getManagerId();
		if(customerNo1 != 0) {									//고객 로그인 성공
			session.setAttribute("loginId", customerId1);
			response.sendRedirect(request.getContextPath()+"/main.jsp");
			System.out.println(customerNo1 + "<<<<고객번호");
			System.out.println(customerId1 + "<<<<고객아이디");	
			
		}else if((managerNo1 = logOn.get(0).getManagerNo()) != 0){ // 매니저 로그인 성공	
			session.setAttribute("loginId", managerId1);
			System.out.println(managerNo1 + "<<<<메니저번호");
			System.out.println(managerId1 + "<<<<매니저아이디");
			response.sendRedirect(request.getContextPath()+"/main.jsp");
		}	
	}else{														//로그인실패
		System.out.println("로그인 실패 확인");
		String msg = URLEncoder.encode("아이디,비밀번호를 확인하세요"); // 한글이 깨찜 방지
		response.sendRedirect(request.getContextPath()+"/login.jsp?msg="+msg);	
	} 
	
%>