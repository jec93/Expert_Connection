package kr.or.iei.payment.model.vo;

public class Orders {
	private String orderNo; //주문 번호
	private String customerNo; //구매자 번호(member_no)
	private String customerName; //구매자 이름
	private String customerEmail; //구매자 이메일
	private String sellerNo; //전문가 번호
	private String sellerName; //전문가 이름
	private int totalAmount; //최종 금액
	private String state; //주문 상태
	private String orderDate; //주문날짜
	
	public Orders() {
		super();
		// TODO Auto-generated constructor stub
	}

	

	public Orders(String orderNo, String customerNo, String customerName, String customerEmail, String sellerNo,
			String sellerName, int totalAmount, String state, String orderDate) {
		super();
		this.orderNo = orderNo;
		this.customerNo = customerNo;
		this.customerName = customerName;
		this.customerEmail = customerEmail;
		this.sellerNo = sellerNo;
		this.sellerName = sellerName;
		this.totalAmount = totalAmount;
		this.state = state;
		this.orderDate = orderDate;
	}


	

	public String getSellerNo() {
		return sellerNo;
	}



	public void setSellerNo(String sellerNo) {
		this.sellerNo = sellerNo;
	}



	public String getSellerName() {
		return sellerName;
	}



	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}



	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(String customerNo) {
		this.customerNo = customerNo;
	}
	public String getCustomerEmail() {
		return customerEmail;
	}
	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}

	public int getTotalAmount() {
		return totalAmount;
	}


	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}


	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	
	
}
