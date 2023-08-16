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

	// Creating new database model object
	DbConnection dbConn = new DbConnection();

	// Deleting item on database when delete button is clicked.
		if (request.getParameter("deleteId") != null) {
		    String id = request.getParameter("deleteId");
		    dbConn.deleteProduct(MyConstants.DELETE_PRODUCT, id);
		}
	
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/adminproduct.css"/>
</head>
<body>

    <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" 
    	url="jdbc:mysql://localhost:3306/fashionclub" user="root" password=""/>
    <!-- Executing Query Using SQL Tag Library -->
    <sql:query var="allUser" dataSource="${dbConnection}">
       SELECT product_id, product_name, category,unit_price, description, brand, stock, ratings,image  FROM products;
    </sql:query>
    
       <div class="container">
        <div class="sidebar">
            <h2>Admin Dashboard</h2>
            <ul>
                <li><a href="productadd.jsp">Add Product</a></li>
                <li><a href="Adminproduct.jsp">Product</a></li>
                <li><a href="Orderlist.jsp">Order list</a></li>
               
            </ul> 
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
					
					
						<c:url var="updateUrl" value="/Adminpages/updateproduct.jsp" />
						<form method="post" action="${updateUrl}">
						  <input type="hidden" name="productId" value="${product.product_id}" />
						  <button class="shop-now-button1">Edit</button>                      
						</form>

					
					 <form method="post">
	                         <input type="hidden" name="deleteId" value="${product.product_id}" />
	                        <button class="shop-now-button">Delete</button>
	               	</form>
                </div>                
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>