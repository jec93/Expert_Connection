package kr.or.iei.payment.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.payment.model.dao.PaymentDao;
import kr.or.iei.payment.model.vo.Orders;
import kr.or.iei.payment.model.vo.Payment;

@Service("paymentService")
public class PaymentService {
	
	@Autowired
	@Qualifier("paymentDao")
	private PaymentDao paymentDao;

	public void insertOrderByOrderInfo(Orders orders) {
		// TODO Auto-generated method stub
		paymentDao.insertOrderByOrderInfo(orders);
	}

	public String createOrderNo() {
		// TODO Auto-generated method stub
		return paymentDao.createOrderNo();
	}

	public void updateOrderState(Payment payment) {
		// TODO Auto-generated method stub
		String orderNo = payment.getOrderNo();
		paymentDao.updateOrderState(orderNo);
	}

	public void insertPayInfoByPayInfo(Payment payment) {
		// TODO Auto-generated method stub
		paymentDao.insertPayInfoByPayInfo(payment);
	}

}
