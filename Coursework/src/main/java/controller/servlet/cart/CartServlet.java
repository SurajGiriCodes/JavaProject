package controller.servlet.cart;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import controller.dbconnection.DbConnection;
import model.User;
import model.cartModel;
import resources.MyConstants;
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
  
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    HttpSession session = request.getSession(false);
		String userId = (String) session.getAttribute("userId");
	    String productId = request.getParameter("productId");
		
		cartModel cart = new cartModel(userId, productId);
		
		DbConnection conn= new DbConnection();
		int result = conn.addProductToCart(MyConstants.INSERT_CART,cart);
			if(result == 1) {
				request.setAttribute("registerMessage", "Successfully added to cart");
				request.getRequestDispatcher("home.jsp").forward(request, response);
			}else if(result == -1) {
				request.setAttribute("registerMessage", "cart item already exists");
				request.getRequestDispatcher("product.jsp").forward(request, response);
			}else {
				request.getRequestDispatcher("Cart.jsp").forward(request, response);
			}
		}
	}

