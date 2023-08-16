<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"

href="${pageContext.request.contextPath}/CSS/addproduct.css"/>
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

		<form class="form2" action="${pageContext.request.contextPath}/product" method="post" enctype="multipart/form-data">
			<p class="form-title2">Add products</p>
			<div class="input-container2">
				<label for="productName">Product Name</label>
				<input type="text" placeholder="Enter product Name" name="productname" required>
			</div>
			<div class="input-container2">
				<label for="category">Category</label>
				<input type="text" placeholder="Enter product category" name="category" required>
			</div>
			
		
			<div class="input-container2">
		
				<label for="unitPrice">Unit Price</label>
				<input type="text" placeholder="Enter Unit Price" name="unitprice" required>
		
			</div>
		
			<div class="input-container2">
				<label for="description">Description</label>
				<input type="text" placeholder="Enter description" name="description" required>
			</div>
		
			<div class="input-container2">
				<label for="brand">Brand</label>
				<input type="text" placeholder="Enter brand" name="brand" required>
			</div>
		
			<div class="input-container2">
				<label for="stock">Stock</label>
				<input type="text" placeholder="Enter stock" name="stock" required>
			</div>
			<div class="input-container2">
				<label for="ratings">Ratings</label>
				<input type="text" placeholder="Enter ratings" name="ratings" required>
			</div>
		
			<div class="photo-selection">
				<p>
				<label class="photo-label">Select your photo<span>*</span></label>
				<input type="file" id="image" name="image">
				</p>
			</div>
		<button class="submit2" type="submit">Add</button>
		</form>

</body>
</html>