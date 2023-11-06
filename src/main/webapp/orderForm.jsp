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
	

	OrderDao orderDao = new OrderDao(); 
	
	OrderFormJoin order = orderDao.selectAddrList(memberId); // Dao에 memberId값 넘겨주기 
    String address = order.getAddress(); // Dao에서 select된 address 값 가져오기 
    int customerNo = order.getCustomerNo(); // Dao에서 select된 customerNo 값 가져오기 
    int customerAddrNo = order.getCustomerAddrNo(); // Dao에서 select된 customerAddrNo 값 가져오기 
    
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	String soldout = request.getParameter("soldout");
	String goodsMemo = request.getParameter("goodsMemo");
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	
	int total = 0; // 총가격 구하
	total = quantity * goodsPrice;
	
	
	

%>
<!DOCTYPE html>
<html lang="en">
<head>
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
		<title>Furni Free Bootstrap 5 Template for Furniture and Interior Design Websites by Untree.co </title>
	</head>

	<body>

		<!-- Start Header/Navigation -->
		<jsp:include page="/inc/menu.jsp"></jsp:include>
		<!-- Start Hero Section -->
			<div class="hero">
				<div class="container">
					<div class="row justify-content-between">
						<div class="col-lg-5">
							<div class="intro-excerpt">
								<h1>Checkout</h1>
							</div>
						</div>
						<div class="col-lg-7">
							
						</div>
					</div>
				</div>
			</div>
		<!-- End Hero Section -->
		<form action="<%=request.getContextPath()%>/orderAction.jsp">
		<input type="hidden" name="goodsTotal" value="<%=total%>">
		<input type="hidden" name="customerNo" value="<%=customerNo%>">
		<input type="hidden" name="customerAddrNo" value="<%=customerAddrNo%>">
		<div class="untree_co-section">
		    <div class="container">
		      <div class="row">
		        <div class="col-md-6 mb-5 mb-md-0">
		          <h2 class="h3 mb-3 text-black">고객 & 상품 정보</h2>
		          <div class="p-3 p-lg-5 border bg-white">
		            <div class="form-group row">
		              <div class="col-md-12">
		                <label for="c_companyname" class="text-black">고객 ID</label>
		                <input type="text" class="form-control" id="c_companyname" name="c_companyname" value="<%=memberId%>">
		              </div>
		            </div>
		            
		            <div class="form-group row">
		              <div class="col-md-12">
		                <label for="c_companyname" class="text-black">고객 주소</label>
		                <input type="text" class="form-control" id="c_companyname" name="c_companyname" value="<%=address%>">
		              </div>
		            </div>
		            
		            
		            <div class="form-group row">
		              <div class="col-md-12">
		                <label for="c_companyname" class="text-black">상품 설명</label>
		                <input type="text" class="form-control" id="c_companyname" name="c_companyname" value="<%=goodsMemo%>">
		              </div>
		            </div>
		            
		            <div class="form-group row">
		              <div class="col-md-12">
		                <label for="c_companyname" class="text-black">수량</label>
		                <input type="text" class="form-control" id="c_companyname" name="quantity" value="<%=quantity%>">
		              </div>
		            </div>
		            
		            
		            <div class="form-group row">
		              <div class="col-md-12">
		                <label for="c_companyname" class="text-black">상품 번호</label>
		                <input type="text" class="form-control" id="c_companyname" name="goodsNo" value="<%=goodsNo%>">
		              </div>
		            </div>
		            
		            <div class="form-group row">
		              <div class="col-md-12">
		                <label for="c_companyname" class="text-black">상품 이름</label>
		                <input type="text" class="form-control" id="c_companyname" name="c_companyname" value="<%=goodsTitle%>">
		              </div>
		            </div>

			         <div class="form-group row">
		              <div class="col-md-12">
		                <label for="c_companyname" class="text-black">상품 가격</label>
		                <input type="text" class="form-control" id="c_companyname" name="c_companyname" value="<%=goodsPrice%>">
		              </div>
		            </div>
		            
		            <div class="form-group row">
		              <div class="col-md-12">
		                <label for="c_companyname" class="text-black">재고량</label>
		                <input type="text" class="form-control" id="c_companyname" name="c_companyname" value="<%=soldout%>">
		              </div>
		            </div>
		          </div>
		        </div>
		        
		        <div class="col-md-6">

		          <div class="row mb-5">
		            <div class="col-md-12">
		              <h2 class="h3 mb-3 text-black">주문 정보</h2>
		              <div class="p-3 p-lg-5 border bg-white">
		                <table class="table site-block-order-table mb-5">
		                  <thead>
		                    <th>상품</th>
		                    <th>총 가격</th>
		                  </thead>
		                  <tbody>
		                    <tr>
		                      <td><%=goodsTitle%><strong class="mx-2">x</strong><%=quantity%></td>
		                      <td><%=total%></td>
		                    </tr>
		                  </tbody>
		                </table>

		                <div class="form-group">
		                  <button class="btn btn-black btn-lg py-3 btn-block">주문하기</button>
		                </div>

		              </div>
		            </div>
		          </div>

		        </div>
		      </div>
		      <!-- </form> -->
		    </div>
		  </div>
		  </form>

		<script src="js/bootstrap.bundle.min.js"></script>
		<script src="js/tiny-slider.js"></script>
		<script src="js/custom.js"></script>
	</body>

</html>
