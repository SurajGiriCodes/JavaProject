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

%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/cart2.css"/>
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
	    INNER JOIN user u ON c.user_id = u.user_id
	    WHERE u.username = '${user}'
	</sql:query>
    
    
    <section id="header"> 
		<a href="#"><img src="image/Lo.png" class="logo" alt=""></a>
		<div>
            <ul id="navbar">
                <li><a href="home.jsp">Home</a></li>
               
                <li><a href="pages/profile.jsp">Profile</a></li>
                <li><a class="active" href="order.jsp">Orders</a></li>
                <li><a href="Cart.jsp"><img src="image/shopinglogo.png" alt=""></a></li>
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
    
    <h1 >Order list</h1>
    
    <table>
    <caption>Order list</caption>
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Total Price</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${allUser.rows}" var="item">
                <tr>
                
                
                    <td>${item.product_name}</td>
                    <td>${item.unit_price}</td>
                </tr>  
            </c:forEach>
                       	
        </tbody>
    	</table>    
</body>
</html>
