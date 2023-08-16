package controller.servlet.product;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import controller.dbconnection.DbConnection;
import model.Products;
import resources.MyConstants;

/**
 * Servlet implementation class product
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/product" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10, // 10MB
maxRequestSize = 1024 * 1024 * 50)
public class product extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productName = request.getParameter("productname");
		String category = request.getParameter("category");
		String unitPrice = request.getParameter("unitprice");
		String description= request.getParameter("description");
		String brand = request.getParameter("brand");
		String stock = request.getParameter("stock");
		String  ratings = request.getParameter("ratings");
		Part imagePart = request.getPart("image");	
		
		Products productModel = new Products(productName, category, unitPrice,description, brand, stock, ratings, imagePart);
	
	  String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
	    String fileName = productModel.getImageUrlFromPart();
	    if(!fileName.isEmpty() && fileName != null)
  		imagePart.write(savePath + fileName);
	
	DbConnection con = new DbConnection();
	int result = con.insertProduct(MyConstants.INSERT_PRODUCT_INFO, productModel);
	if(result == 1) {
		request.setAttribute("registerMessage", "Successfully Registered");
		request.getRequestDispatcher("/Adminpages/Adminproduct.jsp").forward(request, response);
	}else if(result == -1) {
		request.setAttribute("registerMessage", "Product Already Exists");
		request.getRequestDispatcher("/Adminpages/productadd.jsp").forward(request, response);
	}else {
		request.getRequestDispatcher("/Adminpages/productadd.jsp").forward(request, response);
	}
	
}


	


	

}
