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

<%
if(session.getAttribute("user") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
}
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport"content="width=device-width, initial-scale=1">
	<title>FASHION CLUB | Ecommerce website</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/profile1.css" />
</head>
<body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/fashionclub" user="root" password=""/>
	
	<!-- Executing Query Using SQL Tag Library -->
	<sql:query var="allUser" dataSource="${dbConnection}">
    SELECT user_id, first_name, last_name,address, email, username, image FROM user WHERE role="user" AND user_id="${userId}";
	</sql:query>
	
	
	
	<section id="header"> 
		<a href="#"><img src="../image/Lo.png" class="logo" alt=""></a>
		<div>
            
            <ul id="navbar">
                <li><a href="../home.jsp">Home</a></li>
              
                <li><a class="active" href="pages/profile.jsp">Profile</a></li>
                <li><a href="../order.jsp">Order</a></li>
                <li><a href="../Cart.jsp"><img src="../image/shopinglogo.png" alt=""></a></li>
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
	
		<div class="users-info">
	 	    <div class="users">
	 	    <c:forEach var="user" items="${allUser.rows}">
	            <div class="card">
	                <img src="http://localhost:8007/images/<c:out value="${user.image}"/>" class="card-img-top" alt="...">
	                <div class="card-body">
	                    <h4 class="card-title">${user.first_name} ${user.last_name}</h4>
	                    <h5 class="card-text">${user.username}</h5>
	                </div>
	                <c:url var="userUrl" value="/pages/update.jsp" />
					<form method="post" action="${userUrl}">
					    <input type="hidden" name="userId" value="${user.user_id}" />
					    <button type="submit" style="margin-left: 70px; margin-top: -10px;">Update</button>                       
					</form>
	                 
	            </div>
	      	</c:forEach>
	        </div>
		</div>
</body>
</html>


    
        