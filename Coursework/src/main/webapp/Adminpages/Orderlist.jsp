<%@page import="resources.MyConstants"%>
<%@page import="controller.dbconnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%!
SessionManage mySession = new SessionManage();
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Adminorder.css"/>
</head>
<body>
    <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" 
        url="jdbc:mysql://localhost:3306/fashionclub" user="root" password=""/>
    <!-- Executing Query Using SQL Tag Library -->
    <sql:query var="allUser" dataSource="${dbConnection}">
		SELECT o.order_id, c.cart_id, p.product_name, u.username,p.unit_price
		FROM orders o
		INNER JOIN cart c ON o.cart_id = c.cart_id
		INNER JOIN products p ON c.product_id = p.product_id
		INNER JOIN user u ON c.user_id
		;
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
       
       
      
    
    <h1>Order list</h1>
    <table>
    <caption>Order list</caption>
        <thead>
            <tr>
            	<th>User Name</th>
                <th>Product Name</th>
                <th>Total Price</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${allUser.rows}" var="item">
                <tr>
                <td>${item.username}</td>
                    <td>${item.product_name}</td>
                    <td>${item.unit_price}</td>
                </tr>  
            </c:forEach>
                       	
        </tbody>
    	</table>    
</body>
</html>
