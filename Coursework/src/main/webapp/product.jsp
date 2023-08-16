<%@page import="resources.MyConstants"%>
<%@page import="model.Products"%>
<%@page import="java.util.List"%>
<%@page import="controller.dbconnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%!
SessionManage mySession = new SessionManage();
%>

<% 
	//setting absolute path
	String mainPath = request.getContextPath();
	// invoking session username
	String user = (String) session.getAttribute("user");

	// Creating new database model object
	DbConnection dbConn = new DbConnection();

	// Deleting item on database when delete button is clicked.
		if (request.getParameter("deleteId") != null) {
		    String id = request.getParameter("deleteId");
		    dbConn.deleteUser(MyConstants.DELETE_USER, id);
		}
	
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/view.css"/>
</head>
<body>
    <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" 
    	url="jdbc:mysql://localhost:3306/fashionclub" user="root" password=""/>
    <!-- Executing Query Using SQL Tag Library -->
    <sql:query var="allUser" dataSource="${dbConnection}">
       SELECT product_id, product_name, category,unit_price, description, brand, stock, ratings,image FROM products;
    </sql:query>
    
     <sql:query var="allUser" dataSource="${dbConnection}">
       SELECT product_id, product_name, category,unit_price, description, brand, stock, ratings,image FROM products;
    </sql:query>
    
    
    
    	
	<section id="header"> 
		<a href="#"><img src="image/Lo.png" class="logo" alt=""></a>
		<div>
            
            <ul id="navbar">
                <li><a href="home.jsp">Home</a></li>
                <li><a class="active" href="product.jsp">Product</a></li>
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
        </div>	 
	</section>
	
		<div class = "products">
			<h2> New Collection </h2>
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