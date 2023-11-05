<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	Gijoin gijoin = new Gijoin();
	MallDaoHs mallDaoHs = new MallDaoHs();
	
	
	// goodsNo db 열 가져와서 int로 변환하고, setGoodNo로 저장 --> goodsNo 정수형 저장 함수!
	gijoin.setGoodsNo(Integer.parseInt(request.getParameter("goodsNo")));
	System.out.println(gijoin.getGoodsNo() + "<--goodsNo");
	
	Gijoin gigjoin = mallDaoHs.selectShopOneList(gijoin);
%>
<!doctype html>
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
				
		<div class="untree_co-section">
			<div class="container">
			  <div class="row">
			 <div class="col-md-6 mb-5 mb-md-0">
			   <h2 class="h3 mb-3 text-black">상품 이미지</h2>
			   <div class="p-3 p-lg-5 border bg-white">  
		          <div class="form-group row">
                     <div class="col-md-6">
                        <img src="<%=request.getContextPath()%>/upload/<%=gigjoin.getOriginName()%>" class="img-fluid product-thumbnail" style="align-center">
                     </div>
                  </div>
                  <div class="form-group">
                    <label for="c_country" class="text-black">갯수</label>
                    <select id="c_country" class="form-control">
                      <option value="1">1</option>    
                      <option value="2">2</option>    
                      <option value="3">3</option>    
                      <option value="4">4</option>    
                      <option value="5">5</option>    
                      <option value="6">6</option>    
                      <option value="7">7</option>    
                      <option value="8">8</option>    
                      <option value="9">9</option> 
                      <option value="10">10</option>    
                    </select>
                  </div>
               </div>
               <br>
                <button type="submit" class="btn btn-success">상품 주</button>
             </div>
              
            
              <div class="col-md-6 mb-5 mb-md-0">
                <h2 class="h3 mb-3 text-black">상품 정보</h2>
                <div class="p-3 p-lg-5 border bg-white">
                    <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_companyname" class="text-black">상품 번호</label>
                      <input type="text" class="form-control" id="c_companyname" name="c_companyname"value="<%=gigjoin.getGoodsNo()%>" readonly="readonly">
                    </div>
                  </div>

                  <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_companyname" class="text-black">상품 이름</label>
                      <input type="text" class="form-control" id="c_companyname" name="c_companyname"value="<%=gigjoin.getGoodsTitle()%>" readonly="readonly">
                    </div>
                  </div>

                  <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_address" class="text-black">상품 가격</label>
                      <input type="text" class="form-control" id="c_address" name="c_address" value="<%=gigjoin.getGoodsPrice()%>" readonly="readonly">
                    </div>
                  </div>

                  <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_companyname" class="text-black">재고량</label>
                      <input type="text" class="form-control" id="c_companyname" name="c_companyname" value="<%=gigjoin.getSoldout()%>" readonly="readonly">
                    </div>
                  </div>

                 <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_companyname" class="text-black">상품 설명</label>
                      <input type="text" class="form-control" id="c_companyname" name="c_companyname"value="<%=gigjoin.getGoodsMemo()%>" readonly="readonly">
                    </div>
                  </div>
                 <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_companyname" class="text-black">상품 출시일</label>
                      <input type="text" class="form-control" id="c_companyname" name="c_companyname"value="<%=gigjoin.getCreatedate()%>" readonly="readonly">
                    </div>
                  </div>

                 <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_companyname" class="text-black">상품 업데이트일</label>
                      <input type="text" class="form-control" id="c_companyname" name="c_companyname"value="<%=gigjoin.getUpdatedate()%>" readonly="readonly">
                    </div>
                  </div>
                </div>
              </div>
              </div>
		      <!-- </form> -->
		     </div>
		    </div>
		<script src="js/bootstrap.bundle.min.js"></script>
		<script src="js/tiny-slider.js"></script>
		<script src="js/custom.js"></script>
	</body>

</html>
