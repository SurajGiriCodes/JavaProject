package resources;

import java.io.File;

public class MyConstants {
	// Start Region: Database Configuration
	public static final String DRIVER_NAME = "com.mysql.cj.jdbc.Driver";
	public static final String DB_URL = "jdbc:mysql://localhost:3306/fashionclub";
	public static final String DB_USER_NAME = "root"; 		
	public static final String DB_USER_PASSWORD= ""; 
	
	public static final String ADMIN = "admin";
	public static final String USER = "user";
	
	public static final String IMAGE_DIR = "xampp\\tomcat\\webapps\\images\\";
	public static final String IMAGE_DIR_SAVE_PATH = "C:" + File.separator + IMAGE_DIR;
	// End Region: Database Configuration
	
	// Start Region: Select Query
	public static final String CHECK_LOGIN_INFO = "SELECT user_id, username, password FROM user WHERE username = ?";
	public static final String GET_USERID = "SELECT user_id FROM user where username = ?";
	public static final String GET_PRODUCT_INFO = "SELECT product_name, category, unit_price, description, brand, stock, ratings, image FROM products WHERE product_id = ?";
	public static final String GET_USER_INFO = "SELECT first_name, last_name, address, email, contact_no, username, password, role, image FROM user WHERE user_id = ?";
	public static final String CHECK_ADMINLOGIN_INFO = "SELECT * FROM admin WHERE username=? AND pasword=?";
	public static final String GET_ALL_INFO = "SELECT * FROM user";
	
	public static final String GET_ALL_INFO_BY_ID = "SELECT * FROM user WHERE id = ?";
	public static final String IS_USER = "SELECT role FROM user WHERE username = ?";
	public static final String PRODUCT_INFO = "SELECT * FROM products";
	
	
	// Start Region: Insert Query
	public static final String USER_REGISTER = "INSERT INTO user"
			+ "(first_name, last_name, address, email, contact_no, username, password, role, image)"
			+ " VALUES(?,?,?,?,?,?,?,?,?)";
	public static final String INSERT_PRODUCT_INFO = "INSERT INTO products"
			+ "(product_name, category, unit_price, description, brand, stock, ratings,image)"
			+ " VALUES(?,?,?,?,?,?,?,?)";
	
	public static final String INSERT_CART = "INSERT INTO cart(product_id, user_id) VALUES (?, ?)";
	public static final String INSERT_ORDER = "INSERT INTO orders(cart_id) VALUES (?)";
	
	// End Region: Insert Query
	//start region: 
	
	
	// Start Region: Update Query
	public static final String UPDATE_USER_INFO = "UPDATE user SET first_name=?,"
				+ "last_name=?, address=?, email=? , contact_no=?, username=? ,password=?,role=?,image=? WHERE user_id=?";
	public static final String UPDATE_PRODUCT_INFO  = "UPDATE products SET product_name=?,"
				+"category=?, unit_price=?, description=?, brand=?, stock=?, ratings=?, image=? WHERE product_id=?";
	// End Region: Update Query
		
	
	// Start Region: Delete Query
	public static final String DELETE_USER = "DELETE FROM user WHERE username=?";
	public static final String DELETE_PRODUCT = "DELETE FROM products WHERE product_id=?";
	public static final String DELETE_CART_PRODUCT = "DELETE FROM cart WHERE cart_id=?";
	
	// End Region: Delete Query
	

	
	

}
