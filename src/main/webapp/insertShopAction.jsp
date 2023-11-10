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
	
	String goodsTitle = multiReq.getParameter("goodsTitle");
	String goodsPrice = multiReq.getParameter("goodsPrice");
	String goodsMemo = multiReq.getParameter("goodsMemo");
	String contentType = multiReq.getContentType("goodsImage");
	String filename = multiReq.getFilesystemName("goodsImage"); // 서버에 저장되는 파일명
	String originName = multiReq.getOriginalFileName("goodsImage"); // 클라이언트에서 등록할 시점의 파일명
	
	System.out.println(goodsTitle);
	System.out.println(goodsPrice);
	System.out.println(goodsMemo);
	System.out.println(contentType);
	System.out.println(filename);
	System.out.println(originName);
	
	if(!(contentType.equals("image/jpeg") || contentType.equals("image/png"))){
		File file = new File(uploadPath+"/"+filename);
		if(file.exists()){
			file.delete();
		}
		response.sendRedirect(request.getContextPath()+"/shopListForm.jsp");
		return;
	}
	
	ShopListDao shopListDao = new ShopListDao();
	Gijoin gijoin = shopListDao.insertShopGoods(goodsTitle, goodsPrice, goodsMemo, contentType, filename, originName);
	
    response.sendRedirect(request.getContextPath() + "/shopListForm.jsp");


%>
