package kr.or.iei.payment.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.payment.model.vo.Orders;
import kr.or.iei.payment.model.vo.Payment;

@Repository("paymentDao")
public class PaymentDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	public void insertOrderByOrderInfo(Orders orders) {
		// TODO Auto-generated method stub
		sqlSession.insert("payment.insertOrderByOrderInfo",orders);
	}

	public String createOrderNo() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("payment.createOrderNo");
	}

	public void updateOrderState(String orderNo) {
		// TODO Auto-generated method stub
		sqlSession.update("payment.updateOrderState",orderNo);
	}

	public void insertPayInfoByPayInfo(Payment payment) {
		// TODO Auto-generated method stub
		sqlSession.insert("payment.insertPayInfoByOrderInfo",payment);
	}

}
