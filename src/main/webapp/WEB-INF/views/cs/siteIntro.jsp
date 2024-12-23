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
							<div class="page-title">사이트 소개</div>
							<div class="siteIntro-header">
								<img id="cs-siteIntro-header" src="/resources/logo/expert_connection_logo_h_01.png">
								<h4>일상 속 포근한 행복처럼, 우연히 발견한 행운같이</h4>
							</div>
							 <div class="siteIntro-txt">
				                <h3>전문가 추천</h3>
								<p>원하는 전문가를 찾기 어렵다면, 서비스 선택 기준을 정하기 어려우시다면</p> 
				                <p>챗봇을 통해 편하게 여러분께 꼭 맞는 전문가를 찾으시길 바라요.</p>
				                <p>다양한 분야의 전문가님들이 기다리고 있어요.</p>
								<div class="cs-content">
									<div class="siteInfo-link-box">
						           	   <a href="/categories/categoryFrm.exco" class="cs-conList">전문가 추천 바로가기 
				                       		<img src="/resources/images/icon_arrow_outward_white.png" id="direct-arrow">
				                       </a>
				                    </div>
								</div>
				            </div>
							<div class="siteIntro-txt">
				                <h3>카테고리 검색</h3>
				                <p>해결하려는 문제를 검색하거나 카테고리를 통해 어느 분야에 어떤 전문가들이 있는지 찾아보세요.</p>
				                <div class="cs-content">
									<div class="siteInfo-link-box">
					               	   <a href="" class="cs-conList">카테고리 검색 바로가기 
			                           		<img src="/resources/images/icon_arrow_outward_white.png" id="direct-arrow">
			                           </a>
			                        </div>
								</div>
								<div class="siteIntro-body"> 							
								<div class="siteIntro-category">
									<div class="firstCategory">
										<a class="info-firstCategory" href="">
											<img id="category_icon" src="/resources/images/img_hobby.png"><br>
											취미
										</a>
									</div>
									<div class="firstCategory">
										<a class="info-firstCategory" href="">
											<img id="category_icon" src="/resources/images/img_move.png"><br>
											이사
										</a>
									</div>
									<div class="firstCategory">
										<a class="info-firstCategory" href="">
											<img id="category_icon" src="/resources/images/img_outsourcing.png"><br>
											외주
										</a>
									</div>
									<div class="firstCategory">
										<a class="info-firstCategory" href="">											
											<img id="category_icon" src="/resources/images/img_event.png"><br>
											이벤트
										</a>
									</div>
									<div class="firstCategory">
										<a class="info-firstCategory" href="">
											<img id="category_icon" src="/resources/images/img_beuaty.png"><br>
											뷰티
											</a>
									</div>
									<div class="firstCategory">
										<a class="info-firstCategory" href="">
											<img id="category_icon" src="/resources/images/img_job.png"><br>
											취업
										</a>
									</div>
									<div class="firstCategory">
										<a class="info-firstCategory" href="">
											<img id="category_icon" src="/resources/images/img_lesson.png"><br>
											과외
										</a>
									</div>
									<div class="firstCategory">
										<a class="info-firstCategory" href="">
											<img id="category_icon" src="/resources/images/img_vehicle.png"><br>
											차량
										</a>
									</div>
									<div class="firstCategory">
										<a class="info-firstCategory" href="">
											<img id="category_icon" src="/resources/images/img_finance_law.png"><br>
											금융/법률
										</a>
									</div>
								</div>
								</div>
				            </div>
							
							<div class="siteIntro-txt">
				                <h3>커뮤니티</h3>
				                <p>다른 사용자들은 어떻게 문제를 해결하고 있을까요?</p>
				                <p>어떤 전문가가 좋을지 다른 사용자들에게 물어볼까요? 사용자들의 후기와 전문가 추천 정보 등을 확인해 보세요.</p>
				                <p>나만 아는 쏠쏠한 생활의 지혜가 있나요? 다른 사용자들과 공유해보는건 어떨까요?</p>
				                <p>그리고 전문가들의 반짝이는 노하우 역시 확인할 수 있어요.</p>
				                <p>전문가들이 운영하는 일일 클래스나 레슨, 강의 등의 스케줄을 확인하시고 참여해보세요!</p>
				            </div>
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
					            			그룹레슨 찾아보기
					            		</a>
				            		</div>
				            	</div>
				            </div>
				            <div class="siteIntro-txt">
				               <h3>고객센터</h3>
				               <p>사이트 이용에 불편하신 점이 있으시다면 편하게 말씀해주세요!</p>
				               <p>사용자 여러분의 의견을 수용해 항상 노력하는 Expert Connection이 되겠습니다.</p>
				               <div class="cs-content">
					               <div class="siteInfo-link-box">
					               	   <a href="/cs/CS.exco" class="cs-conList">고객센터 바로가기 
			                           		<img src="/resources/images/icon_arrow_outward_white.png" id="direct-arrow">
			                           </a>
						               <a href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4" class="cs-conList">공지사항 바로가기 
			                           		<img src="/resources/images/icon_arrow_outward_white.png" id="direct-arrow">
			                           </a>
			                           <a href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5" class="cs-conList">자주 물어보는 질문 바로가기 
			                           		<img src="/resources/images/icon_arrow_outward_white.png" id="direct-arrow">
			                           </a>
			                           <a href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6" class="cs-conList">1:1문의 바로가기 
			                           		<img src="/resources/images/icon_arrow_outward_white.png" id="direct-arrow">
			                           </a>          
					               </div>
				               </div>
			               </div>
			               <div class="siteNotice">				               
				               <p>Expert Connection의 대부분의 서비스는 회원가입이 필요하지 않지만</p>
				               <p><b>사용자 게시판</b>, <b>전문가 게시판</b>에 게시글과 댓글 작성 및 <b>1:1문의</b> 작성 </p>
				               <p>그리고 <b>그룹레슨 신청</b>과 <b>채팅, 알림 등의 서비스 이용</b>은 <b>회원가입 후 로그인을 하셔야 가능합니다.</b></p>
				               <p>Expert Connection에 가입해보세요. 더 많은 행운이 한 걸음 더 가까워 질거에요!</p>
			               </div>
							<div class="cs-conTxt-header">
								<img id="cs-conTxt-header" src="/resources/logo/expert_connection_logo_00.png">
								<img id="cs-conTxt-header" src="/resources/logo/expert_connection_logo_00.png">
								<img id="cs-conTxt-header" src="/resources/logo/expert_connection_logo_00.png">
								<h5>다른 도움이 필요하실까요?</h5>
							</div>								
							<div class="cs-conTxt">
								<h3>expertconnection250114@gmail.com</h3>
								<p>그외의 질문사항이나 문의 등은 엑스퍼트 커넥션의 지원팀에서 성실히 답해드리겠습니다.</p>
								<p>다만, 광고성 메일 등의 부적절한 메일은 확인 후 스팸처리 및 신고가 이루어지므로 신중하게 메일을 보내주시기 바랍니다.</p>
							</div>
					</div>
					</div>
				</section>
			</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>