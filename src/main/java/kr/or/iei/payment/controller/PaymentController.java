package kr.or.iei.payment.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.iei.chat.model.service.ChatService;
import kr.or.iei.member.model.vo.Member;
import kr.or.iei.payment.model.service.PaymentService;
import kr.or.iei.payment.model.vo.Orders;
import kr.or.iei.payment.model.vo.Payment;

@Controller
@RequestMapping("/payment")
public class PaymentController {

	@Autowired
	@Qualifier("chatService")
	private ChatService chatService;
	
	@Autowired
	@Qualifier("paymentService")
	private PaymentService paymentService;
	
	@GetMapping("/chatOrder.exco")
	@ResponseBody
	public ResponseEntity<Orders> createRoomAndRedirect(HttpSession session, String sellerNo, String sellerName) {
		Member loginMember = (Member) session.getAttribute("loginMember");

	    String newOrderNo = paymentService.createOrderNo();
	    
	    Orders orders = new Orders();
	    
	    orders.setOrderNo(newOrderNo);
	    orders.setCustomerNo(loginMember.getMemberNo());
	    orders.setCustomerEmail(loginMember.getMemberEmail());
	    orders.setCustomerName(loginMember.getMemberNickname());
	    orders.setState("결제 중");
	    orders.setTotalAmount(1000); //총금액은 나중에 기능에 따라 수정함
	    orders.setSellerNo(sellerNo);
	    orders.setSellerName(sellerName);
	    
	    paymentService.insertOrderByOrderInfo(orders);
	    
		return ResponseEntity.ok(orders);
	}
	
	@PostMapping("/chatPay.exco")
	@ResponseBody
	public ResponseEntity<String> order(@RequestBody Payment payment){
		try {
			paymentService.updateOrderState(payment); //결제중 -> 결제 완료
			
			paymentService.insertPayInfoByPayInfo(payment); //결제 완료 테이블 저장
			return ResponseEntity.ok("1"); // 성공 시 1 반환
		}catch(Exception e){
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("0"); // 실패 시 0 반환
		}
	}
}
