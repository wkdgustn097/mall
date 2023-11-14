<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>

<%@ page import="java.net.URLEncoder"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>

<%
	
	if(session.getAttribute("loginId") == null) {
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	}
	String msg = request.getParameter("msg");
%>
<%
	ReviewDao reviewDao = new ReviewDao();
	ArrayList<ReviewOrderGoodsJoin> ordersNoList = reviewDao.reviewOrdersNo((String)(session.getAttribute("loginId")));
	
	if(ordersNoList == null || ordersNoList.isEmpty()) {	// 주문번호가 없을시 main으로 보냄\
		String msg1 = URLEncoder.encode("리뷰는 배송완료된 상품에 한해서 입력이 가능합니다");
		response.sendRedirect(request.getContextPath()+"/review.jsp?msg1="+msg1);
		return;
	}
	
%>
<script>
    var ordersNoList = [
        <%
            for (ReviewOrderGoodsJoin n : ordersNoList) {
        %>
        {
            ordersNo: <%= n.getOrdersNo() %>,
            goodsTitle: '<%= n.getGoodsTitle() %>'
        },
        <% } %>
    ];
</script>
<script>
    function updateGoodsTitle(selectedOrdersNo) {
        var goodsTitle = getGoodsTitleFromList(selectedOrdersNo);
        document.getElementById("goodsTitleSpan").innerHTML = goodsTitle;
    }

    function getGoodsTitleFromList(ordersNo) {
        for (var i = 0; i < ordersNoList.length; i++) {
            if (ordersNoList[i].ordersNo == ordersNo) {
                return ordersNoList[i].goodsTitle;
            }
        }
        return "해당 상품명 없음";
    }
</script>
<script src="js/bootstrap.bundle.min.js"></script>
<script src="js/tiny-slider.js"></script>
<script src="js/custom.js"></script>
<jsp:include page="/inc/menu.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="author" content="Untree.co">
  <link rel="shortcut icon" href="favicon.png">

  <meta name="description" content="" />
  <meta name="keywords" content="bootstrap, bootstrap4" />

		<!-- Bootstrap CSS -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
		<link href="css/tiny-slider.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Start Hero Section -->
			<div class="hero">
				<div class="container">
					<div class="row justify-content-between">
						<div class="col-lg-5">
							<div class="intro-excerpt">
								<h1>리뷰작성</h1>
							</div>
						</div>
						<div class="col-lg-7">
							
						</div>
					</div>
				</div>
			</div>
			
			<!-- End Hero Section -->

		
		<div class="untree_co-section before-footer-section">
            <div class="container">
             <div class="p-3 p-lg-5 border bg-white">
             <h1 class="mb-4 section-title">리뷰 작성하기</h1>
             <br>
             <form action="<%=request.getContextPath()%>/reviewInsertAction.jsp">
				<table class ="table">
					<tr>
			            <td colspan="2">주문번호</td>
			            <td>
			                <select name="ordersNo" id="ordersNo" onchange="updateGoodsTitle(this.value)">
			                <option>주문번호선택</option>
			                    <%
			                        for(ReviewOrderGoodsJoin n : ordersNoList){
			                    %>
			                    <option value="<%=n.getOrdersNo()%>"><%=n.getOrdersNo()%></option>
			                    <% } %>
			                </select>
		            	</td>
		            <tr>
		            	<td>상품이름<td>
			       		<td><span id="goodsTitleSpan"></span></td>
			        
			        </tr>
			        </tr>
			        <tr>
			            <td colspan="2">리뷰내용작성</td>
			            <td colspan="2"><textarea name="reviewContent" rows="4" cols="50"></textarea></td>
			        </tr>
				</table>
				<button type="submit" type="button" class="btn btn-black btn-lg py-3 btn-block">리뷰입력</button>
			 </form>
			</div>
            </div>
          </div>
</body>
</html>