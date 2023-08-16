package controller.servlet.registerupdate;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import controller.dbconnection.DbConnection;
import model.PasswordEncryptionWithAes;
import model.User;
import resources.MyConstants;

/**
 * Servlet implementation class updateservlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/updateservlet" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
	maxFileSize = 1024 * 1024 * 10, // 10MB
	maxRequestSize = 1024 * 1024 * 50)
public class updateservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String firstName = request.getParameter("firstname");
		String lastName = request.getParameter("lastname");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		String contact_no = request.getParameter("contact");
		String  username = request.getParameter("username");
		String  password = request.getParameter("password");
		String  role = request.getParameter("role");
		Part imagePart = request.getPart("image");	
		String  userId = request.getParameter("userId");
		User userModel = new User(firstName,lastName,address, email, contact_no, username, password, role, imagePart);
		
	    String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
	    String fileName = userModel.getImageUrlFromPart();
	    if(!fileName.isEmpty() && fileName != null)
	    	imagePart.write(savePath + fileName);
	    	
	    
	 // Create a new User object with the updated user information
	    DbConnection con = new DbConnection();
	    
		int result = con.updateUser(MyConstants.UPDATE_USER_INFO , userModel, userId);
		if(result == 1) {
			request.getRequestDispatcher("/pages/profile.jsp").forward(request, response);
		}else {
			request.getRequestDispatcher("/pages/update.jsp").forward(request, response);
		}
	    
	}

}


