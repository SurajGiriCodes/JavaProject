package controller.servlet.login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class Adminloginsevlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/Adminloginsevlet" })
public class Adminloginsevlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String USER_ID = "admin";
	private final String USER_PASSWORD = "admin";
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String user = request.getParameter("username");
		String pwd = request.getParameter("password");
		
		
		if(USER_ID.equals(user) && USER_PASSWORD.equals(pwd)){
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			//setting session to expiry in 30 mins
			session.setMaxInactiveInterval(30*60);

			Cookie userName = new Cookie("user", user);
			userName.setMaxAge(30*60);
			response.addCookie(userName);
			response.sendRedirect(request.getContextPath()+"/Adminpages/Admin.jsp");
		}else{
			// set error message
		    request.setAttribute("errorMessage", "Invalid username or password!!");
		    // forward request to login page
		    RequestDispatcher dispatcher = request.getRequestDispatcher("/Adminpages/Adminlogin.jsp");
		    dispatcher.include(request, response);
		}
	}
	

}
