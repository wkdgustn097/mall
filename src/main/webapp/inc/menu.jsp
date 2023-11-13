<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<nav class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">

			<div class="container">
				<a class="navbar-brand" href="main.jsp">Furni<span>.</span></a>

				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarsFurni">
					<ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
						<li class="nav-item">
							<a class="nav-link" href="shopListForm.jsp">SHOP</a>
						</li>
						<li><a class="nav-link" href="bestForm.jsp">BEST</a></li>
						<li><a class="nav-link" href="notice.jsp">NOTICE</a></li>
						<li><a class="nav-link" href="review.jsp">REVIEW</a></li>
						<li><a class="nav-link" href="contact.html">Q&A</a></li>
						<%
							if(session.getAttribute("managerId") != null) { 	// 매니저 로그인 되어 있으면	
						%>
						<li><a class="nav-link" href="delivery.jsp">배송관리</a></li>
						<%
							}
						%>
					</ul>

					<ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
						<li><a class="nav-link" href="login.jsp"><img src="images/user.svg"></a></li>
						
						<%
							if(session.getAttribute("loginId") != null) { 	// 로그인 되어 있으면	
						%>
						<li><a class="nav-link" href="logout.jsp">Logout</a></li>
						<li><a class="nav-link" href="myPageInfo.jsp">MyPage</a></li>
						<%
							}
						%>
						
						<li><a class="nav-link" href="cartForm.jsp"><img src="images/cart.svg"></a></li>
					</ul>
				</div>
			</div>
				
		</nav>