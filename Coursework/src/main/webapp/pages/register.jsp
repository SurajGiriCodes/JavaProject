<%@ page language="java" contentType="text/html; charset=ISO-8859-1"

pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register your account now</title>
<link rel="stylesheet" type="text/css"
href="${pageContext.request.contextPath}/CSS/register.css"/>
</head>
<body>

	<section id="header">
		<a href="#"><img src="../image/Lo.png" class="logo" alt=""></a>
			<div>
				<ul id="navbar">
				<li><a href="../home.jsp">Home</a></li>
				<li><a href="profile.jsp">Profile</a></li>
				<li><a href="../Cart.jsp"><img src="../image/shopinglogo.png" alt=""></a></li>	
				</ul>	
			</div>	
	</section>
	
		<div class="image-container">	
			<img src="../image/trees.jpg" alt="man-hero">	
		</div>
	
	<form class="form2" action="${pageContext.request.contextPath}/UserRegister" method="post" enctype="multipart/form-data">
	<p class="form-title2">Register</p>

	<div class="input-container2">
		<label for="Firstname">First Name</label>
		<input type="text" placeholder="Enter First Name" name="firstname" required>
	</div>

	<div class="input-container2">
		<label for="lastname">Last Name</label>
		<input type="text" placeholder="Enter Last Name" name="lastname" required>
	</div>

	<div class="input-container2">
		<label for="address">Address</label>
		<input type="text" placeholder="Enter Address" name="address" required>
	</div>

	<div class="input-container2">
		<label for="email">Email</label>
		<input type="email" placeholder="Enter Email" name="email" required>
	</div>

	<div class="input-container2">
		<label for="contact">Phone</label>
		<input type="tel" placeholder="Enter Phone Number" name="contact" required>
	</div>
	
	<div class="input-container2">
		<label for="username">Username</label>
		<input type="text" placeholder="Enter Username" name="username" required>
	</div>

	<div class="input-container2">
		<label for="password">Password</label>
		<input type="password" placeholder="Enter Password" name="password" required>
	</div>

	<div class="input-container2">
		<label for="confirmpassword">Confirm Password</label>
		<input type="password" placeholder="Confirm Password" name="confirmpassword" required>
	</div>


	<div class="input-container2">
		<label for="confirmpassword">Role</label>
		<input type="text" placeholder="role" name="role" required>
	</div>


	<div class="photo-selection">
		<p>
			<label class="photo-label">Select your photo<span>*</span></label>
			<input type="file" id="image" name="image">
		</p>
	</div>

	<button class="submit2" type="submit">Register</button>
	<p class="form-link">Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Sign in here</a></p>


</form>

</body>

</html>