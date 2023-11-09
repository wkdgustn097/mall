<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	if(session.getAttribute("loginId") == null) { // 로그인 되어 있으면
		response.sendRedirect(request.getContextPath()+"/main.jsp");
		return;
	}

	String memberId = (String)(session.getAttribute("loginId")); //session 값 가져오기 
	
	int currentPage = 1; // 현재 페이지 
	
	int rowPerPage = 5; // 한 페이지에서 보여주는 갯수 
	int beginRow = (currentPage-1) * rowPerPage; // 시작 갯수 
	int total = 0;
	
	CartDao cartDao = new CartDao(); // MallDao 생성
	ArrayList<CartCustGoodsJoin> list = cartDao.selectCartList(beginRow, rowPerPage, memberId); // Dao에 값 넘기기 
	
	int totalRow = cartDao.lastPage(total); // lastPage를 위한 total값 전송 
	int lastPage = totalRow/rowPerPage; //lastPage 생성 
    if(totalRow % rowPerPage != 0){  
        lastPage = lastPage + 1;
        
     }
	

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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	</head>

	<body>
	 <script type="text/javaScript">
		 
		  let cartNo = [];
		  let newQuantity = [];
	 </script>

		<!-- Start Header/Navigation -->
		<jsp:include page="/inc/menu.jsp"></jsp:include>

		<!-- Start Hero Section -->
			<div class="hero">
				<div class="container">
					<div class="row justify-content-between">
						<div class="col-lg-5">
							<div class="intro-excerpt">
								<h1>장바구니</h1>
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
		        <div class="col-md-6">
		          <div class="row mb-5">
		            <div class="col-md-12">
		              <h2 class="h3 mb-3 text-black">장바구니</h2>
		              <div class="p-3 p-lg-5 border bg-white">
		                <table class="table site-block-order-table mb-5">
		                  <thead>
		                    <th>상품</th>
		                    <th></th>
		                    <th>총 가격</th>
		                  </thead>
		                	<%
								int i = 1;
		                		int totalSum = 0;
								for(CartCustGoodsJoin c : list) {
									
								int totalPrice = c.getGoodsPrice() * c.getQuantity();
								request.setAttribute("total", total);
								
								totalSum += totalPrice;
								
							%>
		                  <tbody>
		                    <tr>
		                      <td><%=c.getGoodsTitle()%><strong class="mx-2">x</strong><input id="quantity<%=i%>" value="<%=c.getQuantity()%>"></td>
		                      <td>
								<button class="plus btn btn-primary" data-id="<%=i%>">+</button>
								<button class="minus btn btn-primary" data-id="<%=i%>">-</button>
		                      </td>
		                      <td id="total<%=i%>"><%=totalPrice%></td>
		                    </tr>
		                    <input type="hidden" id="price<%=i%>" value="<%=c.getGoodsPrice()%>">  
		                    <input type="hidden" id="cartNo<%=i%>" value="<%=c.getCartNo()%>">
		                  </tbody>
		                  <%
		                  		System.out.println(c.getGoodsPrice() + "---price값---");
		                  		i=i+1;
								}
		                  %>
		                  <input type="hidden" id="totalSumElement" value="<%=totalSum%>">
		                  <tr>
		                  	<td>가격 합계</td>
		                  	<td></td>
		                  	<td id="totalSum"><%=totalSum%></td>
		                  </tr>
		                </table>   
		                <div class="form-group">
		                <form action="<%=request.getContextPath()%>/cartQuantityUpdate.jsp">
						  <input type="hidden" id="myInput" name="newQuantity"> <!-- hidden으로 값 숨기고 jQuery를 이용하여 value 값 저장후 넘기  --> 
						  <input type="hidden" id="myInput1" name="cartNo">		
		                  <button onclick="assignArrayToInput()" id="resultQuantity" type="submit" data-id="result" class="btn btn-primary">개수 변경</button>
		                </form>
		                <br>
		                <a href="<%=request.getContextPath()%>/cartOrderForm.jsp" class="btn btn-black btn-lg py-3 btn-block">주문 하기</a>
		                </div>
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
		<script>
			$('.plus').click(function() {
				
			    let id = $(this).data("id"); //변하는 id값을 id에 변수에 넣기 
			    let quantityElement = $('#quantity' + id); // 변하는 값들을 변수에 저장 
			    let quantity = Number(quantityElement.val()) + 1; // 버튼을 누를 경우 갯수가 1 증가 
			    let price = Number($('#price'+id).val())  // goodsPrice를 받아 옴 
			    console.log('Quantity value: ' + $('#quantity' + id).val());
			    console.log('Price value: ' + $('#price' + id).val());
			    let totalPrice = Number(price * quantity) // goodsPrice와 1증가 된 quantity를 곱함 
			    console.log(totalPrice); // 디버깅 
			    

			    if (quantity > 9) { // 최대 갯수는 10개이므로 제한 
			        quantity = 10;
			        alert('최대 숫자는 10 입니다.');
			    } else {
			    	
			    	// total값
				    let price = Number($('#price'+id).val()) // price값 가져오기 
			        
				    let totalSumElement = $('#totalSumElement').val() // total값 가져오기 
				    let totalSum = Number(Number(totalSumElement) + price) // 가져온 total값에 price 더해주기 
				    
				    $('#totalSum').text(totalSum);  // text로 더한값 업데이트 
				    $('#totalSumElement').val(totalSum);  // 더한값 value에 업데이트 
				    
				    $('#resultQuantity').val(quantity);
			    }
			    
			    quantityElement.val(quantity); // 수량 업데이트
			    $('#total' + id).text(totalPrice); // total 값 업데이트 
			    
			});
	
			$('.minus').click(function() {
				
			    let id = $(this).data("id"); //변하는 id값을 id에 변수에 넣기 
			    let quantityElement = $('#quantity' + id); // 변하는 값들을 변수에 저장 
			    let quantity = Number(quantityElement.val()) - 1; // 버튼을 누를 경우 갯수가 1 증가 
			    let price = Number($('#price'+id).val())  // goodsPrice를 받아 옴 
			    let totalPrice = Number(price * quantity) // goodsPrice와 1증가 된 quantity를 곱함 
			    console.log(totalPrice); // 디버깅 
			    
	
			    if (quantity < 1) { // 최소  갯수는 10개이므로 제한 
			        quantity = 1;
			        alert('최소 숫자는 1 입니다.'); 
			        $('#total' + id).text(price);
			        
			    } else {
				    quantityElement.val(quantity); // 수량 업데이트
				    $('#total' + id).text(totalPrice);
				    
			    	// total값
				    let price = Number($('#price'+id).val()) // price값 가져오기 
				    console.log(price + '<--price');

			        
				    let totalSumElement = $('#totalSumElement').val() // total값 가져오기 
				    let totalSum = Number(Number(totalSumElement) - price) // 가져온 total값에 price 더해주기 
				    
				    $('#totalSum').text(totalSum);  // text로 더한값 업데이트 
				    $('#totalSumElement').val(totalSum);  // 더한값 value에 업데이트 
				    
				    $('#resultQuantity').val(quantity); 
			    }

			});
			
			$('#resultQuantity').click(function(){
			    let id = $(this).data("id"); //변하는 id값을 id에 변수에 넣기 
			   	console.log(id);
			   	if(id=="result"){  
			   		for(let j=1;j<<%=i%>; j=j+1) {  // 장바구니에 있는 갯수 만큼 반복 
						cartNo.push($('#cartNo' + j).val())  // 배열에 장바구니에 있는 상품 갯수 순서대로 넣기 
						newQuantity.push($('#quantity' + j).val()) // 배열에 장바구니에 있는 상품 번호 순서대로 넣기 
						console.log(j); // 디버깅 
					}
					console.log(); // 디버깅 
					console.log(cartNo); // 디버깅 
					
			   	}
			   	
	            const inputElement = document.getElementById('myInput');  // form 안에 hidden 으로 있는 input지정 
	            inputElement.value = newQuantity; // input에 value값에 갯수 배열 넣기 
	            console.log(inputElement.value + 'inputElement'); // 디버깅 
	            
	            const inputElement1 = document.getElementById('myInput1'); // form 안에 hidden 으로 있는 input지정 
	            inputElement1.value = cartNo;  // input에 value값에 cart 번호 배열 넣기 
	            console.log(inputElement1.value + 'inputElement'); // 디버깅 
			});
			

		</script>
	</body>
</html>
