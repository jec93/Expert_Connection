<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		
		<main class="content">
			<section class="section cs-list-wrap">
				
				<div class="list-body">
					<div class="side-list">
						<ul class="side-menu-title">
							<li><a href="/cs/CS.exco">고객센터</a></li>
						</ul>
						<ul class="side-menu">
							<li><a href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4">공지사항</a></li>
							<li><a href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5">FAQ</a></li>
							<li><a href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6">1:1문의</a></li>
							<li><a href="/cs/siteTermsOfUse.exco">이용약관</a></li>
							<li><a href="/cs/personalInfoPolicy.exco">개인정보처리방침</a></li>
							<li><a href="/cs/siteIntro.exco">사이트소개</a></li>
						</ul>
					</div>
					<div class="list-content">
						<div class="cs-content-header">
							<img id="cs-siteIntro-header" src="/resources/logo/expert_connection_logo_h_03.png">
							<h5>일상 속 포근한 행복처럼, 우연히 발견한 행운같이</h5>
						</div>
						<div class="service_cont">
						         <h2>개인정보처리방침</h2><br><br>
						         <p>"엑스퍼트 커넥션(Expert Connection)"은 이용자의 개인정보를 안전하게 보호하고, 관련된 고충을 신속히 처리할 수 있도록 최선을 다합니다. 
						            <br>본 방침은 서비스 운영 및 관련 법규를 준수하기 위해 마련되었으며, 내부 정책의 변경이나 법적 요구사항에 따라 수정될 수 있습니다.
						            <br>변경된 방침은 공지사항을 통해 안내드립니다.</p><br>
						
						         <h3>1. 개인정보 수집에 대한 동의</h3>
						         <p>이용자가 회원가입 시 「동의」 버튼을 클릭하면 개인정보 수집 및 이용에 동의한 것으로 간주합니다. 
						         <br>동의를 거부할 권리가 있으나, 이 경우 일부 서비스 이용이 제한될 수 있습니다.</p><br>
						
						         <h3>2. 수집하는 개인정보 항목 및 수집방법</h3>
						         <ul>
						            <li><strong>필수 정보:</strong> 이름, 이메일, 아이디, 비밀번호</li>
						            <li><strong>선택 정보:</strong> 전화번호, 배송 주소</li>
						            <li><strong>수집 방법:</strong> 회원가입 양식, 문의 접수, 이벤트 응모</li>
						            <li><strong>자동 수집 정보:</strong> 접속 로그, IP 주소, 브라우저 종류 및 버전</li>
						         </ul><br>
						
						         <h3>3. 개인정보의 수집 및 이용 목적</h3>
						         <ul>
						            <li><strong>회원 관리:</strong> 본인 확인, 회원제 서비스 이용, 불량 회원 관리</li>
						            <li><strong>서비스 제공:</strong> 주문 처리, 결제 및 배송</li>
						            <li><strong>통계 분석 및 개선:</strong> 접속 빈도 분석, 서비스 품질 개선</li>
						            <li><strong>마케팅 활용:</strong> 신규 서비스 안내, 이벤트 알림</li>
						         </ul><br>
						
						         <h3>4. 개인정보의 보유 및 이용 기간</h3>
						         <p>수집된 개인정보는 회원 탈퇴 시 또는 이용 목적이 달성되면 지체 없이 파기합니다. 단, 법령에 따라 보존이
						            필요한 경우에는 다음과 같은 기간 동안 보관됩니다.</p>
						         <ul>
						            <li>계약 및 결제 관련 기록: 5년 (전자상거래법)</li>
						            <li>소비자 불만 또는 분쟁 처리 기록: 3년 (전자상거래법)</li>
						            <li>웹사이트 접속 기록: 3개월 (통신비밀보호법)</li>
						         </ul><br>
						
						         <h3>5. 개인정보의 파기 절차 및 방법</h3>
						         <ul>
						            <li><strong>파기 절차:</strong> 이용 목적이 달성된 개인정보는 별도의 데이터베이스에 옮겨져 일정 기간
						               저장된 후 파기됩니다. 법적 보존 기간이 종료된 개인정보도 지체 없이 삭제됩니다.</li>
						            <li><strong>파기 방법:</strong> 종이에 출력된 개인정보는 분쇄기로 파기하며, 전자 파일은 복구할
						               수 없도록 완전히 삭제합니다.</li>
						         </ul><br>
						
						         <h3>6. 개인정보의 보호를 위한 조치</h3>
						         <ul>
						            <li><strong>관리적 조치:</strong> 개인정보 보호를 위한 직원 교육 및 내부 관리 방침 수립</li>
						            <li><strong>기술적 조치:</strong> 암호화, 방화벽 설치, 접근 권한 관리</li>
						            <li><strong>물리적 조치:</strong> 데이터 보관 장소 접근 통제</li>
						         </ul><br>
						
						         <h3>7. 개인정보 보호 책임자</h3>
						         <p>개인정보 관련 문의는 아래로 연락 주시면 신속히 처리하겠습니다.</p>
						         <ul>
						            <li><strong>이름:</strong> 정아람</li>
						            <li><strong>소속/직위:</strong> 고객지원팀 / 팀장</li>
						            <li><strong>이메일:</strong> expertconnection250114@gmail.com</li>
						            <li><strong>전화번호:</strong> 070-1234-5678</li>
						         </ul><br>
						
						         <h3>8. 기타</h3>
						         <p>본 방침은 프로젝트를 위한 예시이며, 상업적인 서비스 운영 및 활용에는 법률 전문가의 검토가 필요합니다. 변경된
						            방침은 홈페이지 공지사항에 게시됩니다.</p>
						         <p>개인정보처리방침 시행일자: 2024-12-26</p><br><br>
						         <hr>
						      </div>
						
					</div>
				</div>
			</section>			
		</main>
		
		
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>