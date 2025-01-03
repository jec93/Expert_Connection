package kr.or.iei.payment.model.vo;

public class Payment {
	private String impUid; // 결제 API사 고유번호
    private String orderNo; // 주문번호
    private String tid; // PG사 결제 고유번호
    private int authDate; // 결제 승인 시간
    
    private String productName; //상품이름 ~~님과의 채팅
    private String totalAmount; //총 금액
    private String customerName; //구매자 이름
    private String customerEmail; //구매자 메일
    private String enrollDate; //구매 날짜
	public Payment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Payment(String impUid, String orderNo, String tid, int authDate, String productName, String totalAmount,
			String customerName, String customerEmail, String enrollDate) {
		super();
		this.impUid = impUid;
		this.orderNo = orderNo;
		this.tid = tid;
		this.authDate = authDate;
		this.productName = productName;
		this.totalAmount = totalAmount;
		this.customerName = customerName;
		this.customerEmail = customerEmail;
		this.enrollDate = enrollDate;
	}
	public String getImpUid() {
		return impUid;
	}
	public void setImpUid(String impUid) {
		this.impUid = impUid;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public long getAuthDate() {
		return authDate;
	}
	public void setAuthDate(int authDate) {
		this.authDate = authDate;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerEmail() {
		return customerEmail;
	}
	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}
	public String getEnrollDate() {
		return enrollDate;
	}
	public void setEnrollDate(String enrollDate) {
		this.enrollDate = enrollDate;
	}
}
