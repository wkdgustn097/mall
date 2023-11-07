<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	if(session.getAttribute("loginId") == null) { // 로그인 되어 있으면
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	}

	String memberId = (String)(session.getAttribute("loginId")); //session 값 가져오기 
	int customerNo = Integer.parseInt(request.getParameter("customerNo"));
	int customerAddrNo = Integer.parseInt(request.getParameter("customerAddrNo"));
	System.out.println(customerAddrNo + "<--customerAddrNo");
	
	CartDao cartDao = new CartDao(); // MallDao 생성
	CartCustJoin cart = cartDao.selectCartOrder(customerNo); // Dao에 memberId값 넘겨주기 
    int goodsNo = cart.getGoodsNo(); // Dao에서 select된 GoodsNo 값 가져오기 
    int goodsPrice = cart.getGoodsPrice(); // Dao에서 select된 GoodsPrice 값 가져오기 
    int quantity = cart.getQuantity(); // Dao에서 select된 quantity 값 가져오기
    int totalPrice = 0;
    totalPrice = quantity * goodsPrice;
    
    Orders order = cartDao.insertCartOrder(goodsNo, customerNo, customerAddrNo, quantity,totalPrice); 
    
    response.sendRedirect(request.getContextPath()+"/thankYou.jsp");
%>
