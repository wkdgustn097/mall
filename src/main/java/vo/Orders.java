package vo;

public class Orders {
	private int ordersNo;
	private int goodsNo;
	private int customerNo;
	private int customerAddrNo;
	private int totalPrice;
	private int quantify;
	private String ordersState;
	private String createdate;
	private String updatedate;
	public int getOrdersNo() {
		return ordersNo;
	}
	public void setOrdersNo(int ordersNo) {
		this.ordersNo = ordersNo;
	}
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public int getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public int getCustomerAddrNo() {
		return customerAddrNo;
	}
	public void setCustomerAddrNo(int customerAddrNo) {
		this.customerAddrNo = customerAddrNo;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public int getQuantify() {
		return quantify;
	}
	public void setQuantify(int quantify) {
		this.quantify = quantify;
	}
	public String getOrdersState() {
		return ordersState;
	}
	public void setOrdersState(String ordersState) {
		this.ordersState = ordersState;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
}
