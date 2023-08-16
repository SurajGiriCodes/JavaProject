<%@page import="resources.MyConstants"%>
<%@page import="controller.dbconnection.DbConnection"%>
<%@page import="controller.statemanagement.SessionManage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%!
SessionManage mySession = new SessionManage();
%>

<%
if(session.getAttribute("user") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
}
%>

<% 
//setting absolute path
	String mainPath = request.getContextPath();
	// invoking session username
	String user = (String) session.getAttribute("user");
	
    // Creating new database model object
    DbConnection dbConn = new DbConnection();

    // Deleting cart product from database when delete button is clicked.
    if (request.getParameter("deleteId") != null) {
        String cartId = request.getParameter("deleteId");
        dbConn.deleteCartProduct(MyConstants.DELETE_CART_PRODUCT, cartId);
    }
%>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/cart1.css"/>
     <script>
        function showMessage() {
            alert("Thank you for your purchase! *_*");
        }
    </script>
</head>
<body>
    <sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver" 
        url="jdbc:mysql://localhost:3306/fashionclub" user="root" password=""/>
    <!-- Executing Query Using SQL Tag Library -->
    <sql:query var="allUser" dataSource="${dbConnection}">
        SELECT c.cart_id, p.product_id, p.product_name, p.unit_price, p.image
        FROM cart c
        INNER JOIN user u ON c.user_id = u.user_id
        INNER JOIN products p ON c.product_id = p.product_id
        WHERE u.username = '${user}'
    </sql:query>
    
    
    <section id="header"> 
		<a href="#"><img src="image/Lo.png" class="logo" alt=""></a>
		<div>
            <ul id="navbar">
                <li><a href="home.jsp">Home</a></li>
                
                <li><a href="pages/profile.jsp">Profile</a></li>
                <li><a href="order.jsp">Orders</a></li>
                <li><a class="active" href="Cart.jsp"><img src="image/shopinglogo.png" alt=""></a></li>
                <li>
				    <form action="
				        <%
				            if(!mySession.checkUser(user)){
				                out.print(mainPath);
				            } else {
				                out.print(mainPath);
				            }
				        %>/LogoutServlet" method="post">
				        <input class="my-button" type="submit" value="
				        <%
				            if(mySession.checkUser(user)){
				                out.print("Logout");
				            } else {
				                out.print("Login");
				            }
				        %>" />
				    </form>
				</li>
            </ul>
        </div>	 
	</section>
    
 <h1>Shopping Cart</h1>
 

 
    <table>
    <caption>Shopping Cart</caption>
        <thead>
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Remove</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${allUser.rows}" var="item">
                <tr>
                    <td>
                        <div class="product-box">
                            <img src="http://localhost:8007/images/<c:out value="${item.image}"/>" alt="${item.product_name}" >
                            <span class="product-name">${item.product_name}</span>
                        </div>
                    </td>
                    
                   <td class="unit-price">${item.unit_price}</td>
                    
                    <td>
                        <form method="post">
                            <input type="hidden" name="deleteId" value="${item.cart_id}" />
                            <input class= "shopping-logo" type="image" src="image/delete.png" alt="Delete" />
                        </form>
                        
                    </td>
	               
	                <td> 
                        <form method="post" action="${pageContext.request.contextPath}/orderservlet">
				            <input type="hidden" name="CartId" value="${item.cart_id}" />
				            <button class="shop-now-button" onclick="showMessage()">Buy now</button>                     
					    </form>
				    </td>
                </tr>
            </c:forEach>           	
        </tbody>
     </table>			
    
</body>
</html>
