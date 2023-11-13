<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%

	int intPage = 0;


	// 페이징 변수 
	// rowPerPage 8로 잡
	int currentPage = 1;	
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 4;
	int beginRow = (currentPage-1) * rowPerPage;
	int total = 0;

	Gijoin gijoin = new Gijoin();
	ShopOneListDao shoponedao = new ShopOneListDao();
	ReviewCustJoin reviewOne = new ReviewCustJoin();
	ShopListDao shopdao = new ShopListDao();
	
	ArrayList<ReviewCustJoin> list = new ArrayList<ReviewCustJoin>();

	
	// goodsNo db 열 가져와서 int로 변환하고, setGoodNo로 저장 --> goodsNo 정수형 저장 함수!
	gijoin.setGoodsNo(Integer.parseInt(request.getParameter("goodsNo")));
	System.out.println(gijoin.getGoodsNo() + "<--goodsNo");
	
	
	// 밑에서 넘어온 goodsNo를 바탕으로 cuurentPage가 1이 아닐시 넘어온 goodsNo를 바탕으로 select 
	if(request.getParameter("currentPage") != null){
		ReviewCustJoin reviewPage = new ReviewCustJoin();
		intPage = Integer.parseInt(request.getParameter("goodsNo"));
		reviewPage.setGoodsNo(intPage);
		list = shopdao.bestFormOne(reviewPage, beginRow, rowPerPage);
	} else {
		reviewOne.setGoodsNo(Integer.parseInt(request.getParameter("goodsNo")));
		list = shopdao.bestFormOne(reviewOne, beginRow, rowPerPage);
	}
	System.out.println(intPage + "<--intPage");
	System.out.println(currentPage + "<--currentPage");
	
	Gijoin gigjoin = shoponedao.selectShopOneList(gijoin);
	
	int totalRow = shopdao.lastPage(total);
	int lastPage = totalRow/rowPerPage;
    if(totalRow % rowPerPage != 0){
        lastPage = lastPage + 1;
     }
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
		<form action="<%=request.getContextPath()%>/orderForm.jsp">
		<div class="untree_co-section">
			<div class="container">
			  <div class="row">
			 <div class="col-md-6 mb-5 mb-md-0">
			   <h2 class="h3 mb-3 text-black">상품 이미지</h2>
			   <div class="p-3 p-lg-5 border bg-white">  
		          <div class="form-group row">
                     <div class="col-md-6">
                        <img src="<%=request.getContextPath()%>/upload/<%=gigjoin.getOriginName()%>" class="img-fluid product-thumbnail">
                     </div>
                  </div>
                  <div class="form-group">
                    <label for="c_country" class="text-black">갯수</label>
                    <select id="c_country" class="form-control" name="quantity">
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
                    <br>
                    <%
                		int i = 1;
                    	int lastGoodsNo = -1; // 마지막 goodsNo를 저장할 변수 추가
                		for(ReviewCustJoin r : list) {
                			i = i+1;
                	        intPage = r.getGoodsNo();
                	        lastGoodsNo = intPage; // 현재의 goodsNo를 저장
                	        System.out.println(intPage + "<--intPage에 들어가는 값");
                	        System.out.println(r.getGoodsNo() + "<--r.getGoodsNo()에 들어가는 값");
                	        

                		}
                    
                    %>
                    <p>사용자 리뷰&nbsp;(<%=i-1%>)</p>
                    <%

						for(ReviewCustJoin r : list) {
				
                    %>
                   		<input value="ID : <%=r.getCustomerId()%>" class="form-control" id="c_companyname" readonly="readonly">
                   		<input value="<%=r.getReviewContent()%>" class="form-control" id="c_companyname" readonly="readonly">
                   		<br>
                    <%
						}
                    %>
                   <ul class="pagination">
                   	  <%
		 				 if(currentPage > 1) {
		 					 // lastGoodsNo에 저장된 goodsNo값을 가지고 넘
  					  %>
                    <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/bestFormOne.jsp?currentPage=<%=currentPage-1%>&goodsNo=<%=lastGoodsNo%>">이전</a></li>
                     <%
		 				 }
                   	  
                   		 if(currentPage < lastPage-1) {	
                     %>
                    <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/bestFormOne.jsp?currentPage=<%=currentPage+1%>&goodsNo=<%=lastGoodsNo%>">다음</a></li>
                    <%
                   		 }
                    %>
                   </ul> 
                  </div>
               </div>
               <br>
              <%  
				   if(session.getAttribute("managerId") != null){
              %> 
          		   <a href="<%=request.getContextPath()%>/updateShopForm.jsp?goodsNo=<%=gijoin.getGoodsNo()%>"  class="btn btn-success">수정</a>
		  		   <a href="<%=request.getContextPath()%>/deleteShopAction.jsp?goodsNo=<%=gijoin.getGoodsNo()%>" class="btn btn-success">삭제</a>
              <%
              		}
              %>
             </div>
             

            
              <div class="col-md-6 mb-5 mb-md-0">
                <h2 class="h3 mb-3 text-black">상품 정보</h2>
                <div class="p-3 p-lg-5 border bg-white">
                    <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_companyname" class="text-black">상품 번호</label>
                      <input type="text" class="form-control" id="c_companyname" name="goodsNo"value="<%=gigjoin.getGoodsNo()%>" readonly="readonly">
                    </div>
                  </div>

                  <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_companyname" class="text-black">상품 이름</label>
                      <input type="text" class="form-control" id="c_companyname" name="goodsTitle"value="<%=gigjoin.getGoodsTitle()%>" readonly="readonly">
                    </div>
                  </div>

                  <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_address" class="text-black">상품 가격</label>
                      <input type="text" class="form-control" id="c_address" name="goodsPrice" value="<%=gigjoin.getGoodsPrice()%>" readonly="readonly">
                    </div>
                  </div>

                  <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_companyname" class="text-black">재고량</label>
                      <input type="text" class="form-control" id="c_companyname" name="soldout" value="<%=gigjoin.getSoldout()%>" readonly="readonly">
                    </div>
                  </div>

                 <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_companyname" class="text-black">상품 설명</label>
                      <input type="text" class="form-control" id="c_companyname" name="goodsMemo"value="<%=gigjoin.getGoodsMemo()%>" readonly="readonly">
                    </div>
                  </div>
                 <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_companyname" class="text-black">상품 출시일</label>
                      <input type="text" class="form-control" id="c_companyname" name="createdate"value="<%=gigjoin.getCreatedate()%>" readonly="readonly">
                    </div>
                  </div>

                 <div class="form-group row">
                    <div class="col-md-12">
                      <label for="c_companyname" class="text-black">상품 업데이트일</label>
                      <input type="text" class="form-control" id="c_companyname" name="updatedate"value="<%=gigjoin.getUpdatedate()%>" readonly="readonly">
                    </div>
                  </div>
                </div>
                <br>
                <button type="submit" class="btn btn-success">상품 주문</button>
                <input type="submit" class="btn btn-success" name="action" value="장바구니 추가">
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
