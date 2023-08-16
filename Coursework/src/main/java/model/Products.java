package model;

import java.io.File;

import javax.servlet.http.Part;

import resources.MyConstants;

public class Products {
	String productName, category, unitPrice,description, brand, stock, ratings, imageUrlFromPart;

	
	public Products(String productName, String category, String unitPrice, String description, 
			String brand, String stock, String ratings, Part part){
		this.productName = productName;
		this.category = category;
		this.unitPrice = unitPrice;
		this.imageUrlFromPart = getImageUrl(part);
		this.description = description;
		this.brand = brand;
		this.stock = stock;
		this.ratings = ratings;
	}
	
	public Products(String productName, String category, String unitPrice, String description, 
			String brand, String stock, String ratings, String image){
		this.productName = productName;
		this.category = category;
		this.unitPrice = unitPrice;
		this.imageUrlFromPart = image;
		this.description = description;
		this.brand = brand;
		this.stock = stock;
		this.ratings = ratings;
	}
	
	public Products() {
		// TODO Auto-generated constructor stub
	}

	public String getImageUrl() {
		return imageUrlFromPart;
	}
	
	
	public String getproductName() {
		return productName;
	}
	public void setproductName(String productName) {
		this.productName = productName;
	}
	public String getcategory() {
		return category;
	}
	
	public void setcategory(String category) {
		this.category = category;
	}
	public String getunitPrice() {
		return unitPrice;
	}
	
	public void setunitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getImageUrlFromPart() {
		return imageUrlFromPart;
	}
	
	public void setImageUrlFromPart(Part part) {
		this.imageUrlFromPart = getImageUrl(part);
	}
	public String getdescription() {
		return description;
	}
	public void setdescription(String description) {
		this.description = description;
	}
	
	public String getbrand() {
		return brand;
	}
	public void setbrand(String brand) {
		this.brand = brand;
	}
	public String getstock() {
		return stock;
	}
	public void setstock(String stock) {
		this.stock = stock;
	}
	public String getratings() {
		return ratings;
	}
	public void setratings(String ratings) {
		this.ratings = ratings;
	}
	
	private String getImageUrl(Part part) {
		String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
		File fileSaveDir = new File(savePath);
		String imageUrlFromPart = null;
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				imageUrlFromPart = s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		if(imageUrlFromPart == null || imageUrlFromPart.isEmpty()) {
			imageUrlFromPart= "download.png";
		}
		return imageUrlFromPart;
	}


	
}



