package controller.dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import controller.servlet.product.product;
import model.PasswordEncryptionWithAes;
import model.Products;
import model.User;
import model.cartModel;
import model.orderModel;
import resources.MyConstants;

public class DbConnection {
	public Connection getConnection(){
		try {
			Class.forName(MyConstants.DRIVER_NAME);
			Connection connection = DriverManager.getConnection(
					MyConstants.DB_URL,
					MyConstants.DB_USER_NAME,
					MyConstants.DB_USER_PASSWORD);
			return connection;
		}catch(SQLException | ClassNotFoundException ex) {
			ex.printStackTrace();
			return null;
		}
	}
		//start region and read Operation
		public List<User> getAllData(String query) {
	        List<User> dataList = new ArrayList();
			Connection DbConnection = getConnection();
			if(DbConnection != null) {
				try {
		            Statement statement = (Statement) DbConnection.createStatement();
		            ResultSet rs = ((java.sql.Statement) statement).executeQuery(query);
		            while (rs.next()) {
		            	User data = new User();
		              
		                data.setUsername(rs.getString("username"));
		                data.setPassword(rs.getString("password"));
		                dataList.add(data);
		            }
		            rs.close();
		            ((Connection) statement).close();
		            DbConnection.close();
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
			}
	        return dataList;
		}
		
		
		public ResultSet selectWhereQuery(String query, String id) {
			Connection DbConnection = getConnection();
			if(DbConnection != null) {
				try {
					PreparedStatement statement = DbConnection.prepareStatement(query);
					statement.setString(1, id);
					ResultSet result = statement.executeQuery();
					return result;
				} catch (SQLException e) {
					return null;
				}
			}else {
				return null;
			}
		}
		public Boolean isUserAlreadyRegistered(String username) {
			Connection DbConnection = getConnection();
			if(DbConnection != null) {
				try {
					PreparedStatement statement = DbConnection.prepareStatement(MyConstants.CHECK_LOGIN_INFO);
					statement.setString(1, username);
					ResultSet result = statement.executeQuery();
					if(result.next()) {
						return true;		
					}else return false;
				} catch (SQLException e) { return null; }
			}else { return null; }
							
		}
		
		
		public Boolean isUserRegistered(String query, String username, String password) {
			Connection dbConnection = getConnection();
			if(dbConnection != null) {
				try {
					PreparedStatement statement = dbConnection.prepareStatement(query);
					statement.setString(1, username);
					ResultSet result = statement.executeQuery();
					if(result.next()) {
						String userDb = result.getString("username");
						String passwordDb  = result.getString("password");
						String decryptedPwd = PasswordEncryptionWithAes.decrypt(passwordDb, username);
						if(decryptedPwd!=null && userDb.equals(username) && decryptedPwd.equals(password)) return true;
						else return false;
					}else return false;
				} catch (SQLException e) { return null; }
			}else { return null; }
		}
		
		public String getuserid(String query, String username) {
			Connection dbConnection = getConnection();
			if(dbConnection != null) {
				try {
					PreparedStatement statement = dbConnection.prepareStatement(query);
					statement.setString(1, username);
					ResultSet result = statement.executeQuery();
					if(result.next()) {
						String userid = result.getString("user_id");
						if(userid!=null ) return userid;
						else return null;
					}else return null;
				} catch (SQLException e) { return null; }
			}else { return null; }
		}
		

		
		
		//Start region Create operation
		public int registerUser(String query, User userModel) {
			Connection DbConnection = getConnection();
			if(DbConnection != null) {
				try {
					if(isUserAlreadyRegistered(userModel.getUsername())) return -1;
					
					PreparedStatement statement = DbConnection.prepareStatement(query);
					statement.setString(1, userModel.getFirstName());
					statement.setString(2, userModel.getLastName());
					statement.setString(3, userModel.getaddress());
					statement.setString(4, userModel.getEmail());
					statement.setString(5, userModel.getcontact_no());
					statement.setString(6, userModel.getUsername());
					statement.setString(7, PasswordEncryptionWithAes.encrypt(
							userModel.getUsername(), userModel.getPassword()));
					statement.setString(8, userModel.getRole());
					statement.setString(9, userModel.getImageUrlFromPart());

					int result = statement.executeUpdate();
					if(result>=0) return 1;
					else return 0;
				} catch (Exception e) { return -2; }
			}else { return -3; }
		}
		//	End region Create operation

		
//		Start region Delete operation
		public Boolean deleteUser(String query, String username) {
			Connection dbConnection = getConnection();
			if(dbConnection != null) {
				try {
					PreparedStatement statement = dbConnection.prepareStatement(query);
					statement.setString(1, username);
					int result = statement.executeUpdate();
					if(result>=0)return true;
					else return false;
				} catch (SQLException e) { return null; }
			}else { return null; }
		}
		//	End region Delete operation
		
		//Start region Update operation		
		public int updateUser(String query, User userModel, String userId) {
			Connection DbConnection = getConnection();
			if(DbConnection != null) {
				try {
					PreparedStatement statement = DbConnection.prepareStatement(query);
					statement.setString(1, userModel.getFirstName());
					statement.setString(2, userModel.getLastName());
					statement.setString(3, userModel.getaddress());
					statement.setString(4, userModel.getEmail());
					statement.setString(5, userModel.getcontact_no());
					statement.setString(6, userModel.getUsername());
					statement.setString(7, PasswordEncryptionWithAes.encrypt(
							userModel.getUsername(), userModel.getPassword()));
					statement.setString(8, userModel.getRole());
					statement.setString(9, userModel.getImageUrlFromPart());
					statement.setString(10,userId);

					int result = statement.executeUpdate();
					if(result>=0) return 1;
					else return 0;
				} catch (Exception e) { 
					return -2; 
					}
			}else {
				return -3; 
				}
		}
		
		public User getSpecificUser(int userId) {
			Connection DbConnection = getConnection();
			if(DbConnection != null) {
				try {
					PreparedStatement statement = DbConnection.prepareStatement(MyConstants.GET_USER_INFO);
					statement.setInt(1, userId);
					ResultSet result = statement.executeQuery();
					if(result.next()) {
						User users = new User(
								result.getString("first_name"),
								result.getString("last_name"),
								result.getString("address"),
								result.getString("email"),
								result.getString("contact_no"),
								result.getString("username"),
								result.getString("password"),
								result.getString("role"),
								result.getString("image")
								);
						return users;
					}else {
						return null;
					}
				} catch (Exception e) { 
					return null; 
					}
			}else {
				return null; 
				}
			}
		
		//	End region Update operation
		
		
		//start production section
		public List<Products> getAlData(String query) {
	        List<Products> dataList = new ArrayList();
			Connection DbConnection = getConnection();
			if(DbConnection != null) {
				try {
		            Statement statement = (Statement) DbConnection.createStatement();
		            ResultSet rt = ((java.sql.Statement) statement).executeQuery(query);
		            while (rt.next()) {
		            	Products datas = new Products();
		                datas.setproductName(rt.getString("productName"));
		                datas.setunitPrice(rt.getString("unitPrice"));
		                datas.setcategory(rt.getString("category"));
		                datas.setdescription(rt.getString("description"));
		                datas.setbrand(rt.getString("brand"));
		                datas.setstock(rt.getString("stock"));
		                datas.setratings(rt.getString("ratings"));      
		                dataList.add(datas);
		            }
		            rt.close();
		            ((Connection) statement).close();
		            DbConnection.close();
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
			}
	        return dataList;
		}
		
		//product insert
		public int insertProduct(String query, Products productModel) {
			Connection DbConnection = getConnection();
			if(DbConnection != null) {
				try {
					PreparedStatement statement = DbConnection.prepareStatement(query);
					statement.setString(1, productModel.getproductName());
					statement.setString(2, productModel.getcategory());
					statement.setString(3, productModel.getunitPrice());
					statement.setString(4, productModel.getdescription());
					statement.setString(5, productModel.getbrand());
					statement.setString(6, productModel.getstock());
					statement.setString(7, productModel.getratings());
					statement.setString(8, productModel.getImageUrlFromPart());
					int result = statement.executeUpdate();
					if(result>=0) return 1;
					
				} catch (Exception e) { return -2; }
			}else { return -3; }
			return 0;
		}
		
      //Start region Delete operation of product
		public Boolean deleteProduct(String query, String product_name) {
			Connection dbConnection = getConnection();
			if(dbConnection != null) {
				try {
					PreparedStatement statement = dbConnection.prepareStatement(query);
					statement.setString(1, product_name);
					int result = statement.executeUpdate();
					if(result>=0)return true;
					else return false;
				} catch (SQLException e) { return null; }
			}else { return null; }
		}
		//	End region Delete operation

		//Start region Update operation		
				public int updateproduct(String query, Products productModel, String productId) {
					Connection DbConnection = getConnection();
					if(DbConnection != null) {
						try {
							PreparedStatement statement = DbConnection.prepareStatement(query);
							statement.setString(1, productModel.getproductName());
							statement.setString(2, productModel.getcategory());
							statement.setString(3, productModel.getunitPrice());
							statement.setString(4, productModel.getdescription());
							statement.setString(5, productModel.getbrand());
							statement.setString(6, productModel.getstock());
							statement.setString(7, productModel.getratings());
							statement.setString(8, productModel.getImageUrlFromPart());
							statement.setString(9, productId);
							int result = statement.executeUpdate();
							if(result>=0) return 1;
							else return 0;
						} catch (Exception e) { 
							return -2; 
							}
					}else {
						return -3; 
						}
				}
				
				
				public Products getSpecificProduct(int productId) {
					Connection DbConnection = getConnection();
					if(DbConnection != null) {
						try {
							PreparedStatement statement = DbConnection.prepareStatement(MyConstants.GET_PRODUCT_INFO);
							statement.setInt(1, productId);
							ResultSet result = statement.executeQuery();
							if(result.next()) {
								Products product = new Products(
										result.getString("product_name"),
										result.getString("category"),
										result.getString("unit_price"),
										result.getString("description"),
										result.getString("brand"),
										result.getString("stock"),
										result.getString("ratings"),
										result.getString("image")
										);
								return product;
							}else {
								return null;
							}
						} catch (Exception e) { 
							return null; 
							}
					}else {
						return null; 
						}
					}
				

				
				
				 public int addProductToCart(String query, cartModel cart) {
					 Connection DbConnection = getConnection();
					 if(DbConnection != null) {
					 try {
						 PreparedStatement preparedStatement = DbConnection.prepareStatement(query);
						 preparedStatement.setString(1, cart.getProduct_id());
						 preparedStatement.setString(2, cart.getUser_id());
						 int result = preparedStatement.executeUpdate();
						 if(result>=0) return 1;
						 else return 0;
					 	}catch (Exception e) { 
					 		return -2; 
					 		}
					 }else { 
						 return -3; 
						 }
					 }
				 
				 public int InsertOrder(String query, orderModel order) {
					 Connection DbConnection = getConnection();
					 if(DbConnection != null) {
					 try {
						 PreparedStatement preparedStatement = DbConnection.prepareStatement(query);
						 preparedStatement.setString(1, order.getcartId());
						 int result = preparedStatement.executeUpdate();
						 if(result>=0) return 1;
						 else return 0;
					 	}catch (Exception e) { 
					 		return -2; 
					 		}
					 }else { 
						 return -3; 
						 }
					 }
				 
				 
				 
//					Start region Delete operation
					public Boolean deleteCartProduct(String query, String card_id) {
						Connection dbConnection = getConnection();
						if(dbConnection != null) {
							try {
								PreparedStatement statement = dbConnection.prepareStatement(query);
								statement.setString(1, card_id);
								int result = statement.executeUpdate();
								if(result>=0)return true;
								else return false;
							} catch (SQLException e) { return null; }
						}else { return null; }
					}
					//	End region Delete operation
		
}
	
	
	
	
