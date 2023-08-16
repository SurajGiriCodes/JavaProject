<!DOCTYPE html>
<html>
<head>
	<title>Product Search and Filter</title>
	<link rel="stylesheet" type="text/css"

href="${pageContext.request.contextPath}/CSS/search.css"/>
</head>
<body>
	<h1>Product Search and Filter</h1>
	<form action="product_search.jsp" method="get">
		<label for="search">Search:</label>
		<input type="text" id="search" name="search">
		<input type="submit" value="Search">
	</form>
	<form action="searching.jsp" method="get">
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
</body>
</html>