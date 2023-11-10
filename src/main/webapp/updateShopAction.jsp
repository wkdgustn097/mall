<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "com.oreilly.servlet.multipart.*"%>
<%@page import="com.oreilly.servlet.*"%>
<%@page import="java.io.File"%>
<%
	String uploadPath = request.getServletContext().getRealPath("/upload");

	MultipartRequest multiReq = new MultipartRequest(request,uploadPath,100*1024*1024,"UTF-8", new DefaultFileRenamePolicy());
	
	int goodsNo = Integer.parseInt(multiReq.getParameter("goodsNo"));
	
	String goodsTitle = multiReq.getParameter("goodsTitle");
	String goodsPrice = multiReq.getParameter("goodsPrice");
	String goodsMemo = multiReq.getParameter("goodsMemo");
	
	String oldName = multiReq.getParameter("oldName");
	
	String originName = multiReq.getOriginalFileName("goodsImage"); 
	String contentType = multiReq.getContentType("goodsImage");
	String filename = multiReq.getFilesystemName("goodsImage"); 
	
	System.out.println("-----------updateShopAction-----------------------");
	System.out.println(goodsTitle + "<--goodsTitle");
	System.out.println(goodsPrice + "<--goodsPrice");
	System.out.println(goodsMemo + "<--goodsMemo");
	System.out.println(oldName + "<--oldName");
	System.out.println(originName + "<--originName");
	System.out.println(contentType + "<--contentType");
	System.out.println(filename + "<--filename");
	
	
	ShopListDao shopListDao = new ShopListDao();
	GoodsSuccess goodsSuccess = shopListDao.updateShopGoods(goodsTitle, goodsPrice, goodsMemo, goodsNo);
	
	if(originName != null){
		File oldFile = new File(uploadPath+"/"+oldName);
		System.out.println(oldFile + "<-----oldFile");
		if(oldFile.exists()){
			oldFile.delete();
			System.out.println("<-----삭제성공");
		}
		Goods_img goods_img = shopListDao.updateShopGoodsImage(originName, filename, contentType, goodsNo);
		
	}
	
    response.sendRedirect(request.getContextPath() + "/shopListForm.jsp");

%>