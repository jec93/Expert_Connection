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
					<div class="list-body"></div>
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
							<div class="page-title">사이트 소개</div>
							<div class="siteIntro_header">
								<img id="cs-siteIntro-header" src="/resources/logo/expert_connection_logo_h_05.png">
							<h4>일상속 포근한 행복처럼, 우연히 발견한 행운같이</h4>
							
							 <div class="siteIntro-txt">
				                <h3>전문가 추천</h3>
				                <p>전문가 추천 멘트</p>
				            </div>
							<div class="siteIntro-body">
							
							</div>
							<div class="siteIntro-txt">
				                <h3>전문가 검색</h3>
				                <p>어떤 문제들을 해결하려고 하는지, 어떤 도움을 받을 수 있을지, 어느 전문가들이 있는지 찾아보세요. 다양한 분야의 전문가님들이 기다리고 있어요.</p>
				                <p>여러분께 꼭 맞는 전문가님을 찾으실 수 있을거에요</p>
				            </div>
							<div class="siteIntro-body">
							
							</div> 
							<div class="siteIntro-txt">
				                <h3>카테고리</h3>
				                <p>어떤 분야의 전문가님들이 있는지 확인해보세요!</p>
				            </div>
							<div class="siteInfoCard">
								<div class="site-card-inner">
									<div class="siteIntro-category">
										<img id="" src="">
										<a href="">취미</a>
									</div>
									<div class="siteIntro-category">
										<img id="" src="">
										<a href="">이사</a>
									</div>
									<div class="siteIntro-category">
										<img id="" src="">
										<a href="">외주</a>
									</div>
									<div class="siteIntro-category">
										<img id="" src="">
										<a href="">이벤트</a>
									</div>
									<div class="siteIntro-category">
										<img id="" src="">
										<a href="">뷰티</a>
									</div>
									<div class="siteIntro-category">
										<img id="" src="">
										<a href="">취업</a>
									</div>
									<div class="siteIntro-category">
										<img id="" src="">
										<a href="">과외</a>
									</div>
									<div class="siteIntro-category">
										<img id="" src="">
										<a href="">차량</a>
									</div>
									<div class="siteIntro-category">
										<img id="" src="">
										<a href="">금융/법률</a>
									</div>
								</div>
							</div>
							<div class="siteIntro-txt">
				                <h3>커뮤니티</h3>
				                <p>다른 사용자들은 어떤 문제를 해결하고 있을까요? 어떤 전문가가 좋았었는지 대한 정보와 노하우도 찾아볼 수 있어요.</p>
				                <p>전문가님들이 운영하는 일일 클래스나 레슨, 강의 등의 스케줄을 확인하시고 참여해보세요!</p>
				            </div>
				            <div class="">
				            	<div class="siteIntro-community">
				            		<img id="" src="">
				            		<a href="/board/list.exco?reqPage=1&boardType=0&boardTypeNm=0">사용자 게시판</a>
				            	</div>
				            	<div class="siteIntro-community">
				            		<img id="" src="">
				            		<a href="/board/list.exco?reqPage=1&boardType=1&boardTypeNm=1">전문가 게시판</a>
				            	</div>
				            	<div class="siteIntro-community">
				            		<img id="" src="">
				            		<a href="/board/list.exco?reqPage=1&boardType=2&boardTypeNm=2">전문가 노하우</a>
				            	</div>
				            	<div class="siteIntro-community">
				            		<img id="" src="">
				            		<a href="/board/list.exco?reqPage=1&boardType=3&boardTypeNm=3">그룹레슨</a>
				            	</div>
				            </div>
				            <div class="siteIntro-txt">
			               <h3>고객센터</h3>
			               <p>사이트 이용에 불편하신 점이 있으시다면 편하게 말씀해주세요!</p>
			               <p>이용자 여러분의 의견을 수용해 항상 노력하는 withTrip이 되겠습니다.</p>
			            </div>
			               <div class="siteInfoCard">
				               <div class="link-box-cs">
				               	   <a href="/cs/CS.exco" class="link-box-btn">고객센터 바로가기 
		                           		<img src="/resources/images/icon_arrow_outward_white.png" id="direct-arrow">
		                           </a>
					               <a href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4" class="link-box-btn">공지사항 바로가기 
		                           		<img src="/resources/images/icon_arrow_outward_white.png" id="direct-arrow">
		                           </a>
		                           <a href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5" class="link-box-btn">자주 물어보는 질문 바로가기 
		                           		<img src="/resources/images/icon_arrow_outward_white.png" id="direct-arrow">
		                           </a>
		                           <a href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6" class="link-box-btn">1:1문의 바로가기 
		                           		<img src="/resources/images/icon_arrow_outward_white.png" id="direct-arrow">
		                           </a>          
				               </div>
			               </div>
			               <div class="siteNotice">				               
				               <p>Expert Connection의 대부분의 서비스는 회원가입이 필요하지 않지만</p>
				               <p><b>사용자 게시판</b>, <b>전문가 게시판</b>과 <b>1:1문의</b> 작성 그리고 <b>그룹레슨 신청</b>과 <b>채팅, 알림등의 서비스 이용</b>은 <b>회원가입 후 로그인을 하셔야 가능합니다.</b></p>
				               <p>Expert Connection에 가입해보세요. 더 많은 행운이 한 걸음 더 가까워 질거에요!</p>
			               </div>
						</div>
					</div>
				</section>
			</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>