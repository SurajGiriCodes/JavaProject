 <%@page import="resources.MyConstants"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="controller.dbconnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
    
<%! SessionManage mySession = new SessionManage(); %>


<% 
	//setting absolute path
	String mainPath = request.getContextPath();
	// invoking session username
	String user = (String) session.getAttribute("user");

	// Creating new database model object
	DbConnection dbConn = new DbConnection();
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport"content="width=device-width, initial-scale=1">
	<title>FASHION CLUB | Ecommerce website</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/home13.css" />
</head>
<body>

	<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" 
    	url="jdbc:mysql://localhost:3306/fashionclub" user="root" password=""/>
    <!-- Executing Query Using SQL Tag Library -->
    <sql:query var="allUser" dataSource="${dbConnection}">
       SELECT product_id, product_name, category,unit_price, description, brand, stock, ratings,image  FROM products;
    </sql:query>
    
	
		<section id="header"> 
			<a href="#"><img src="image/Lo.png" class="logo" alt=""></a>
			
			
	<div class="search-container">
		<form class= "search" action="product_search.jsp" method="get">
			<label for="search">Search:</label>
			<input type="text" id="search" name="search">
			<input type="submit" value="Search">
		</form>
		
		<form class= "search1" action="searching.jsp" method="get">
			<label for="category">Category:</label>
			<select id="category" name="category">
				<option value="">All Categories</option>
				<option value="men">Men</option>
				<option value="Women">Women</option>
				
			</select>
			<label for="sort">Sort By:</label>
			<select id="sort" name="sort">
				<option value="">Default</option>
				<option value="price_desc">Price - Highest to Lowest</option>
				<option value="price_asc">Price - Lowest to Highest</option>
				<option value="rating_desc">Rating - Highest to Lowest</option>
				<option value="rating_asc">Rating - Lowest to Highest</option>
			</select>
			<input type="submit" value="Filter">
		</form>
		</div>	          
	            <ul id="navbar">
	                <li><a class="active"href="home.jsp">Home</a></li>
	                <li><a href="pages/profile.jsp">Profile</a></li>
	                <li><a href="order.jsp">Orders</a></li>
	                <li><a href="Cart.jsp"><img src="image/shopinglogo.png" alt=""></a></li>
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
	        
		</section>
	
		  <div class="image-container">	
		   <img src="${pageContext.request.contextPath}/image/index1.png" >
		    <div class="image-text">
		      <h4>Be the Style Icon!</h4>
		      
			      <button class="cta">
			        <span >Shop Now</span>
				        <svg viewBox="0 0 13 10" height="10px" width="15px">
				        </svg>
			      </button>
		    </div>
		  </div>
		  

			<div class = "products">
				<h2> Products </h2>
			</div>
			
			<div class="product-info">
		    	<div class="productrc">
		        <c:forEach var="product" items="${allUser.rows}">
		            <div class="card">
		                <img src="http://localhost:8007/images/<c:out value="${product.image}"/>" class="card-img-top" alt="...">
		                <div class="card-body">
		                    <h4 class="card-title">${product.brand} </h4>
		                    <h5 class="card-text1">${product.product_name}</h5>
		                    <p class="card-text2">${product.unit_price}</p>
		                    <p class="card-text3">Stock: ${product.stock}</p>
		                    <p class="card-text4">Ratings: ${product.ratings}</p>
		   
		                    
		                    <c:if test="${not empty user}">
		                    <form method="post" action="${pageContext.request.contextPath}/CartServlet">
							  	<input type="hidden" name="productId" value="${product.product_id}" />
							  	<button class="shop-now-button">Add to Cart</button>                     
							</form>
							</c:if>
							    				
		                </div>                
		            </div>
		        </c:forEach>
		    </div>
		</div>
</body>
</html>


    
        