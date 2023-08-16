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


<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/updateproduct.css"/>
</head>
<body>

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
       
		<%
		    int productId = Integer.parseInt(request.getParameter("productId"));
		    DbConnection connection = new DbConnection();
		    Products product = connection.getSpecificProduct(productId);
		%>
		
		<form class="form2" action="${pageContext.request.contextPath}/updateproduct" method="post" enctype="multipart/form-data">
		
			<p class="form-title2">Edit products</p>
			
			<div class="input-container2">
			    <label for="productName">Product Name</label>
			    <input type="text" placeholder="Enter product Name" name="productname" value="<%out.print(product.getproductName()); %>" required>
			</div>
			
			<div class="input-container2">
			    <label for="category">Category</label>
			    <input type="text" placeholder="Enter product category" name="category" value="<%out.print(product.getcategory()); %>" required>
			</div>
			
			<div class="input-container2">
			
			    <label for="unitPrice">Unit Price</label>
			    <input type="text" placeholder="Enter Unit Price" name="unitprice" value="<%out.print(product.getunitPrice()); %>" required>
			
			</div>
			
			<div class="input-container2">
				<label for="description">Description</label>
				<input type="text" placeholder="Enter description" name="description"  value="<%out.print(product.getdescription()); %>" required>
			</div>
		
			<div class="input-container2">
			    <label for="brand">Brand</label>
			    <input type="text" placeholder="Enter brand" name="brand" value="<%out.print(product.getbrand()); %>" required>
			</div>
			
			<div class="input-container2">
			    <label for="stock">Stock</label>
			    <input type="text" placeholder="Enter stock" name="stock" value="<%out.print(product.getstock()); %>" required>
			</div>
			
			<div class="input-container2">
			    <label for="ratings">Ratings</label>
			    <input type="text" placeholder="Enter ratings" name="ratings" value="<%out.print(product.getratings()); %>" required>
			</div>
			
             <img src="http://localhost:8007/images/<%out.println(product.getImageUrlFromPart());%>" width="60" style="margin-left: 80px;"/>
			
			<div class="photo-selection">
			    <p>
			        <label class="photo-label">Select your photo<span>*</span></label>
			        <input type="file" id="image" name="image">
			    </p>
			</div>
			
		<input type="hidden" name="productId" value="<% out.print(productId);%>" />

		<button class="submit2" type="submit">Update</button>
		</form>

</body>
</html>