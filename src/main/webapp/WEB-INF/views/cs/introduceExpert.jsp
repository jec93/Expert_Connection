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
					<div class="page-title">전문가 사이트 이용 가이드</div>
						<div class="cs-content-header">
							<img id="cs-siteIntro-header" src="/resources/logo/expert_connection_logo_h_01.png">
							<h6>Expert Connection을 이용하는 전문가분들을 위한 사이트 이용 가이드입니다.</h6>
						</div>
						<div class="cs-content">
							<div class="cs-box">
								<div class="siteIntro-txt">
									<h2>더 많은 사용자들을 만나 문제를 해결해보세요.</h2>
								</div>
								<div class="siteIntro-body">
									<div class="siteIntro-link">
										<h3>전문가 회원 승인 절차를 확인하셨나요?</h3>
										<p>예비전문가님들께서는 Expert Connection에서 다음과 같은 절차를 거쳐 최종 승인이 결정되면</p>
										<p><img id="expertType" src="/resources/images/expert_type_01.png"> 새싹전문가, <img id="expertType" src="/resources/images/expert_type_02.png"> 능숙한 전문가, <img id="expertType" src="/resources/images/expert_type_03.png"> 노련한 전문가 중 한 분의 전문가로 활동하시게 됩니다. 
									</div>
									<div class="siteIntro-link">
									<a class="cs-conList" href="/cs/introExpertProcess.exco">
										전문가 회원 승인 절차 안내
										<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
									</a>
									</div>
								</div>
									<div class="process-box-header">
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
								<div class="siteIntro-txt">
									<h3>커뮤니티를 통해 더 많은 정보를 얻어보세요.</h3>
									<p>전문가님만의 노하우를 공유해 더 많은 사용자들에게 도움이 되보세요. 다음 서비스 이용에 좋은 인상을 받을 수도 있어요.</p>
									<p>그룹레슨을 시작해 보시겠어요? 더 많은 사용자들을 만나는 기회가 될거에요.</p>
									<div class="siteIntro-body">
										<div class="siteInfo-link-box">
						            		<div class="community-link">
							            		<a href="/board/list.exco?reqPage=1&boardType=0&boardTypeNm=0" class="info-community">
						            			<img id="community_icon" src="/resources/images/img_audience01.png">
								            		사용자 게시판 바로가기
							            		</a>
							            		<a href="/board/list.exco?reqPage=1&boardType=1&boardTypeNm=1" class="info-community">
							            		<img id="community_icon" src="/resources/images/img_audience02.png">
								            		전문가 게시판 바로가기
							            		</a>
							            		<a href="/board/list.exco?reqPage=1&boardType=2&boardTypeNm=2" class="info-community">
						            			<img id="community_icon" src="/resources/images/img_idea.png">
						            				전문가 노하우 바로가기
							            		</a>
							            		<a href="/board/list.exco?reqPage=1&boardType=3&boardTypeNm=3" class="info-community">
							            		<img id="community_icon" src="/resources/images/img_openbook.png">
							            			그룹레슨 시작하기
							            		</a>
						            		</div>
					            		</div>
									</div>
									<div class="siteIntro-txt">
										그룹레슨에 대해 조금 더 자세히 설명해드릴게요
									</div>
									<ul class="expert_process">
										<li id="exco_txt">1. 그룹레슨 준비 </li>
										<li> > </li>
										<li id="exco_txt">2. 그룹레슨 모집 시작</li>
										<li> > </li>
										<li id="exco_txt">3. 그룹레슨 모집 종료 </li>
										<li> > </li>
										<li id="exco_txt">4. 그룹레슨 시작</li>
									</ul>
								</div>
								<div class="introContent-box">
							<div class="process-intro">
								<div class="process_info">
									<div id="p_num">01</div>
									<div>
									<h3>그룹레슨 준비</h3>
										<ul>
											<li>그룹레슨 페이지 혹은 전문가 페이지에서 그룹레슨 시작하기 버튼을 눌러주세요.</li>
										</ul>
									</div>
								</div>
							</div>
							<div class="process-intro">
								<div class="process_info">
									<div id="p_num">02</div>
									<div>
									<h3>그룹레슨 모집 시작</h3>
									<ul>
										<li>장소, 참여인원, 일시 등에 대한 정보를 입력해주세요.</li>
										<li>어떤 레슨이 진행될지 자세한 설명을 덧붙여 주시면 좋을 것 같아요.</li>
										<li>사용자분들이 댓글이나 채팅을 통해 문의를 남길거에요. 늦더라도 기간내에 성실한 답변을 부탁드려요</li>
									</ul>
									</div>
								</div>
							</div>
							<div class="process-intro">
								<div class="process_info">
									<div id="p_num">03</div>
									<div>
									<h3>그룹레슨 모집 종료</h3>
									<ul>
										<li>마감 기한 내에 이르게 모집이 완료될 수도 있고, 기한이 다 되었는데도 참여인원이 부족할 수도 있어요.</li>
										<li>참여인원이 부족하더라도 걱정하지 마세요. 전문가님께서 레슨을 진행하실지 말지 결정하실 수 있습니다.</li>
									</ul>
									</div>
								</div>
							</div>
							<div class="process-intro">
								<div class="process_info">
									<div id="p_num">04</div>
									<div>
									<h3>그룹레슨 시작</h3>
										<ul>
											<li>레슨 시작일이 되면 사용자님과 전문가님 두분 모두에게 유익한 시간이 되길 바라요.</li>
										</ul>
									</div>
								</div>
							</div>
			            </div>
								<div class="siteIntro-txt">
									<h3>다른 사용자들과 전문가들을 배려하고 존중하는 사이트 이용을 부탁드립니다.</h3>
									<p>지나친 욕설 사용, 혹은 비방 및 음해 등의 건전하지 못한 사이트 이용은 신고의 대상이 될 수 있으며, </p>
									<p>일정 횟수의 신고 누적은 사이트 이용 일시 제한과 영구 제한으로 이어집니다.</p>
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