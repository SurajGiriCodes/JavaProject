package model;

import java.io.File;

import javax.servlet.http.Part;

import resources.MyConstants;

public class User {
	String firstName, lastName, address,  email, contact_no, username, password, role, imageUrlFromPart;
	

	public User() {}
	
	public User(String firstName, String lastName,String address,  String email,  String contact_no, 
			String username, String password, String role, Part part){
		this.firstName = firstName;
		this.lastName = lastName;
		this.address = address;
		this.email = email;
		this.contact_no = contact_no;
		this.username = username;
		this.password = password;
		this.role = role;
		this.imageUrlFromPart = getImageUrl(part);
	}
	
	
	public User(String firstName, String lastName,String address,  String email,  String contact_no, 
			String username, String password, String role, String image){
		this.firstName = firstName;
		this.lastName = lastName;
		this.address = address;
		this.email = email;
		this.contact_no = contact_no;
		this.username = username;
		this.password = password;
		this.role = role;
		this.imageUrlFromPart = image;
	}
	
	public String getImageUrl() {
		return imageUrlFromPart;
	}
	
	
	public String getImageUrlFromPart() {
		return imageUrlFromPart;
	}
	
	public void setImageUrlFromPart(Part part) {
		this.imageUrlFromPart = getImageUrl(part);
	}
	
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	

	public String getaddress() {
		return address;
	}
	public void setaddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getcontact_no() {
		return contact_no;
	}
	public void setcontact_no(String contact_no) {
		this.contact_no = contact_no;
	}
	
	public String getUsername() {
		return username	;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	private String getImageUrl(Part part) {
		String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
		File fileSaveDir = new File(savePath);
		String imageUrlFromPart = null;
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}
		if(part!=null) {
			String contentDisp = part.getHeader("content-disposition");
			String[] items = contentDisp.split(";");
			for (String s : items) {
				if (s.trim().startsWith("filename")) {
					imageUrlFromPart = s.substring(s.indexOf("=") + 2, s.length() - 1);
				}
			}
		}else {
			if(imageUrlFromPart == null || imageUrlFromPart.isEmpty()) {
				imageUrlFromPart= "download.png";
			}
		}
		return imageUrlFromPart;
	}
}

