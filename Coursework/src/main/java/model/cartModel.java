package model;

public class cartModel {
    private String user_id;
    private String product_id;
    
    public cartModel(String userId, String prdId) {
        this.user_id = userId;
        this.product_id = prdId;
    }

  

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getProduct_id() {
        return product_id;
    }

    public void setProduct_id(String product_id) {
        this.product_id = product_id;
    }
}
