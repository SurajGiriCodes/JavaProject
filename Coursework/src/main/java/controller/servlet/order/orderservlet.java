package controller.servlet.order;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.x.protobuf.MysqlxCrud.Order;

import controller.dbconnection.DbConnection;
import model.cartModel;
import model.orderModel;
import resources.MyConstants;

/**
 * Servlet implementation class orderservlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/orderservlet" })
public class orderservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		    String CartId = request.getParameter("CartId");
			
			orderModel order = new orderModel(CartId);
			
			DbConnection conn= new DbConnection();
			int result = conn.InsertOrder(MyConstants.INSERT_ORDER, order);
				if(result == 1) {
					request.setAttribute("registerMessage", "Successfully added to cart");
					request.getRequestDispatcher("Cart.jsp").forward(request, response);
				}else if(result == -1) {
					request.setAttribute("registerMessage", "cart item already exists");
					request.getRequestDispatcher("Cart.jsp").forward(request, response);
				}else {
					request.getRequestDispatcher("Cart.jsp").forward(request, response);
				}
			}

	

}
