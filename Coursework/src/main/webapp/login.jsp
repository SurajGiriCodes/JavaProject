<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Login to your account</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/login1.css">
</head>
<body>
			<%
			String errorMessage = (String) request.getAttribute("errorMessage");
			String registerMessage = (String) request.getHeader("registerMessage");
			%>
			<% if (registerMessage != null) { %>
			<div class="register-message"><%= registerMessage %></div>
		<% } %>
<section id="header">
	<a href="#"><img src="image/Lo.png" class="logo" alt=""></a>
	  <div>
		<ul id="navbar">
		<li><a href="home.jsp">Home</a></li>
		<li><a href="pages/profile.jsp">Profile</a></li>
		<li><a href="order.jsp">Orders</a></li>
		<li><a href="Cart.jsp"><img src="image/shopinglogo.png" alt=""></a></li>
		</ul>
	  </div>
	</section>
	<div class="login-item">
		<form class="form1" action="LoginServlet" method="post">
			<% if (errorMessage != null) { %>
			<div class="error-message"><%= errorMessage %></div>
			<% } %>
			<p class="form-title1">Sign In</p>
				<div class="input-container1">
				<input id="login-username" type="text" class="form-input" placeholder="Username" name="username" required/>
				</div>
				<div class="input-container1">
				<input id="login-password" type="password" class="form-input" placeholder="Password" name="password" required>
				</div>
			<button class="submit1" type="submit">
			Sign in
			</button>
			<p class="signup-link1">
			Don't have an account?
			<a href="${pageContext.request.contextPath}/pages/register.jsp">Register</a></p>
			
			<button onclick="location.href='${pageContext.request.contextPath}/Adminpages/Adminlogin.jsp'" class="cat">
				Login as admin
			</button>
			
		      	
		</form>
</div>
</body>
</html>
