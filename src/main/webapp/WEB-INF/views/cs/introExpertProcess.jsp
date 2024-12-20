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
							<li>고객센터</li>
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
							<h3>전문가 회원 승인절차 안내</h3>
						</div>
						<div class="introContent-box">
							<div class="introContent-box-header">
								<p>다양한 분야의 빛나는 전문가 여러분 Expert Connection과 함께 해주셔서 감사합니다. </p>
								<p>사용자분들의 선택의 기준을 제공하고자 전문가분들께서 보내주신 자료들을 바탕으로 객관적인 절차를 거쳐 전문가 여러분에게 이름을 붙여보았습니다.</p>
								<p>전문가 승인이 이루어지게 되면 <img id="expertType" src="/resources/images/expert_type_01.png"> 새싹전문가, <img id="expertType" src="/resources/images/expert_type_02.png"> 능숙한 전문가, <img id="expertType" src="/resources/images/expert_type_03.png"> 노련한 전문가 중 한 분의 전문가로 활동하시게 됩니다. 
								<p>따뜻한 열정으로 사용자 여러분들의 다양한 요청과 문제들을 정확하게 분석하고, 효율적인 방법으로 해결하며 성장하는 전문가 여러분</p>
								<p>일상속 포근한 행복처럼, 우연히 발견하는 행운처럼 모두에게 든든한 전문가가 되어주세요.</p>
							</div>		
						</div>
						<div class="process_box">
							<div class="process-box-header">
								<h3>전문가 회원 승인 절차</h3>
							</div>
							<ul class="expert_process">
								<li id="exco_txt">1. 전문가 회원가입 </li>
								<li> > </li>
								<li id="exco_txt">2. 포트폴리오, 자격증 등의 파일 등록</li>
								<li> > </li>
								<li id="exco_txt">3. 승인 검토</li>
								<li> > </li>
								<li id="exco_txt">4. 승인 종료</li>
							</ul>
						</div>
						<div class="introContent-box">
							<div class="process-intro">
								<div class="process_info">
									<div id="p_num">01</div>
									<div>
									<h3>전문가 회원가입</h3>
										<ul>
											<li>우선 전문가로 회원가입을 완료해주세요.</li>
										</ul>
									</div>
								</div>
							</div>
							<div class="process-intro">
								<div class="process_info">
									<div id="p_num">02</div>
									<div>
									<h3>포트폴리오, 자격증 등의 자료 등록</h3>
									<ul>
										<li>담당자와의 면담을 전제로 한 승인 신청과 허위사실 등의 부적절한 자료는 고려대상이 아니오니 지양해 주시기 바랍니다.</li>
										<li>활동하시려는 카테고리와 관련된 포트폴리오, 자격증 등의 자료들을 메일로 보내주시기 바랍니다.</li>
										<li>첨부파일 이상 등의 사유로 파일 재등록이 필요하시다면 expertconnection250114@gmail.com로 수정 또는 보완하신 파일 등을 보내주시기 바랍니다.</li>
										<li>다만, 광고성 메일 혹은 허위사실 등의 부적절한 메일은 확인 후 스팸처리 및 신고가 이루어지므로 신중하게 메일을 보내주시기 바랍니다.</li>
										<li>자료확인이 이루어지지 않으면 전문가로 활동하시기 어렵습니다.</li>
										<li>보내주신 일체의 자료는 전문가 승인 목적으로만 이용됩니다.</li>	
									</ul>
									</div>
								</div>
							</div>
							<div class="process-intro">
								<div class="process_info">
									<div id="p_num">03</div>
									<div>
									<h3>승인 검토</h3>
									<ul>
										<li>
											보내주신 자료는 5일 이내에 처리하는 것을 기본으로 하고 있습니다. <br>
											(단, 주요 자료 확인의 경우 시간이 조금 더 소요될 수 있으니 양해를 바랍니다.)
										</li>
										<li>담당자가 승인을 검토하는 과정에서 추가자료를 요청하거나 재문의할 수 있습니다.</li>
										<li>30일 이내에 예비전문가께서 담당자의 자료요청 또는 재문의에 회신을 하지 않는 경우, 해당 승인 절차는 종료처리됩니다.</li>
									</ul>
									</div>
								</div>
							</div>
							<div class="process-intro">
								<div class="process_info">
									<div id="p_num">04</div>
									<div>
									<h3>승인 종료</h3>
										<ul>
											<li>전문가 승인 자료의 검토 결과는 회원가입 시 입력하신 이메일 주소로 발송됩니다.</li>
											<li>전문가 승인이 결정되면, 담당자가 별도의 절차를 안내하고 해당 승인 절차를 종료합니다.</li>
											<li>부득이한 사정 등으로 전문가 승인이 어려운 경우, 가입 시 입력하신 일체의 정보는 자동파기 되며 보내주신 자료는 30일 후 자동파기 됩니다.</li>
										</ul>
									</div>
								</div>
							</div>
			            </div>
					</div>
				</div>
			</section>
		</main>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>