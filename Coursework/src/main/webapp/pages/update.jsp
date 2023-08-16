<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@page import="controller.dbconnection.DbConnection"%>
<%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/CSS/update1.css"/>
</head>

<%! SessionManage mySession = new SessionManage(); %>

<% 
	//setting absolute path
	String mainPath = request.getContextPath();
	
	//invoking session username
	String user = (String) session.getAttribute("user");

	// Creating new database model object
	DbConnection dbConn = new DbConnection();
	
%>

<body>

		<section id="header"> 
			<a href="#"><img src="../image/Lo.png" class="logo" alt=""></a>
			<div>

	            <ul id="navbar">
	                <li><a href="../home.jsp">Home</a></li>
	                <li><a class="active" href="profile.jsp">Profile</a></li>
	                <li><a href="../Cart.jsp"><img src="../image/shopinglogo.png" alt=""></a></li>
	                <li><form action="
			    				<%if(!mySession.checkUser(user)){
			    					out.print(mainPath);%>/login.jsp<%
			   					} 
			    				else {
			    					out.print(mainPath);%>/LogoutServlet<%
			   					}%>
			    			"
			    	method="post">
			  			<input class="my-button" type="submit" value="
			    			<%if(mySession.checkUser(user)){%>
					    		Logout
					   		<%}else{%>
					    		Login
					   		<%}%>
				   		"/>
			    	</form>
			    </li>
	            </ul>
	        </div>	 
		</section>
		

		<%
		    int userId = Integer.parseInt(request.getParameter("userId"));
		    DbConnection connection = new DbConnection();
		    User users = connection.getSpecificUser(userId);
		%>
		
		<form class= "update-form" action="${pageContext.request.contextPath}/updateservlet" method="post" enctype="multipart/form-data">
		
		<p class="form-title">Update your Details</p>
		 
			<div class="input-container">
				<label for="Firstname">First Name</label>
				<input type="text" placeholder="Enter First Name" name="firstname" value="<%out.print(users.getFirstName()); %>" required>
			</div>
	
			<div class="input-container">
				<label for="lastname">Last Name</label>
				<input type="text" placeholder="Enter Last Name" name="lastname" value="<%out.print(users.getLastName()); %>" required>
			</div>
					
			<div class="input-container">
				<label for="address">Address</label>
				<input type="text" placeholder="Enter Address" name="address" value="<%out.print(users.getaddress()); %>" required>
			</div>
			
			<div class="input-container">
				<label for="email">Email</label>
				<input type="email" placeholder="Enter Email" name="email" value="<%out.print(users.getEmail()); %>" required>
			</div>
	
			<div class="input-container">
				<label for="contact">Phone</label>
				<input type="text" placeholder="Enter Phone Number" name="contact" value="<%out.print(users.getcontact_no()); %>" required>
			</div>
			
			<div class="input-container">
				<label for="username">Username</label>
				<input type="text" placeholder="Enter Username" name="username" value="<%out.print(users.getUsername()); %>" required>
			</div>
			
			<div class="input-container">
				<label for="password">Password</label>
				<input type="password" placeholder="Enter password"  name="password" value="<%out.print(users.getPassword()); %>" required>
			</div>
			<div class="input-container">
				<label for="role">Role</label>
				<input type="text" placeholder="role" name="role" value="<%out.print(users.getRole()); %>" required>
			</div>
	
			 <img src="http://localhost:8007/images/<%out.println(users.getImageUrlFromPart());%>" width="60" style="margin-left: 250px;"/>
		
			<div class="photo-selection">
			    <p>
			        <label class="photo-label">Select your photo<span>*</span></label>
			        <input type="file" id="image" name="image">
			    </p>
			</div>
			
		    <input type="hidden" name="userId" value="<% out.print(userId);%>" />
			
			<button  class="submit" type="submit">Update</button>
		</form>
</body>
</html>
