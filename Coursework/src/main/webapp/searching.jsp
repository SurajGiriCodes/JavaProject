<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="controller.dbconnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>



<%! SessionManage mySession = new SessionManage(); %>


<% 
	//setting absolute path
	String mainPath = request.getContextPath();
	// invoking session username
	String user = (String) session.getAttribute("user");

%>




<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Product Filter Results</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/view1.css"/>
</head>
<body>
	
	<c:set var="category" value="${param.category}" />
	<c:set var="sort" value="${param.sort}" />
	<sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/fashionclub" user="root" password="" />
	<sql:query var="products" dataSource="${db}">
	SELECT *, CAST(unit_price AS DOUBLE) AS unit_priceDouble, CAST(ratings AS DOUBLE) AS ratingsDouble FROM products
	<c:if test="${not empty category}">
		WHERE category = '${category}'
	</c:if>
	<c:choose>
		<c:when test="${sort == 'price_desc'}">
			ORDER BY unit_priceDouble DESC
		</c:when>
		<c:when test="${sort == 'price_asc'}">
			ORDER BY unit_priceDouble ASC
		</c:when>
		<c:when test="${sort == 'rating_desc'}">
			ORDER BY ratingsDouble DESC
		</c:when>
		<c:when test="${sort == 'rating_asc'}">
			ORDER BY ratingsDouble ASC
		</c:when>
	</c:choose>
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

			<c:if test="${not empty products.rows}">
			<div class="product-info">
				<c:forEach var="product" items="${products.rows}">
					<div class="card">
					<img src="http://localhost:8007/images/${product.image}" class="card-img-top" alt="...">
						<h4 class="card-title">${product.brand}</h4>
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
				</c:forEach>
			</div>
		</c:if>
		<c:if test="${empty products.rows}">
			<p>No products found.</p>
		</c:if>

</body>
</html>