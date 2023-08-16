package model;

public class orderModel {
    private String cartId;
    
    
    public orderModel(String cartId) {
        this.cartId = cartId;
       
    }
  
    public String getcartId() {
        return cartId;
    }

    public void setCartId(String cartId) {
        this.cartId= cartId;
    }

  

}
