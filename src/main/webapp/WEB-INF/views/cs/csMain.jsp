<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
						<div class="page-title">고객센터</div>
						<div class="cs-content-header">
							<img id="cs-siteIntro-header" src="/resources/logo/expert_connection_logo_h_01.png">
							<h5>네잎클로버를 발견하는 기쁨처럼, Expert Connection입니다. 무엇을 도와드릴까요?</h5>
						</div>
						<div class="cs-content">
						<c:if test="${empty loginMember}">
							<div class="cs-conList-box">
								<div class="cs-box">
									<div class="cs-box-header">
										<h5>정보 찾기</h5>
									</div>
								<a class="cs-conList" href="javascript:void(0)" onclick="openFindId()">
									ID 찾기
									<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
								</a>
								<a class="cs-conList" href="javascript:void(0)" onclick="openFindPw()">
									비밀번호 찾기
									<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
								</a>
								<a class="cs-conList" href="/member/joinFrm.exco">
									사용자/전문가 회원가입
									<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
								</a>
								</div>
							</div>
						</c:if>
							<div class="cs-conList-box">
								<div class="cs-box">
									<div class="cs-box-header">
										<h5>사이트 이용 안내</h5>
									</div>
									<a class="cs-conList" href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4">
										공지사항 바로가기
										<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
									</a>
									<a class="cs-conList" href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5">
										FAQ 바로가기
										<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
									</a>
									<a class="cs-conList" href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6">
										1:1문의 바로가기
										<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
									</a>
									<a class="cs-conList" href="/cs/siteIntro.exco">
									사이트 소개
									<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
									</a>
								</div>
							</div>
							<div class="cs-conList-box">
							<div class="cs-box">
								<div class="cs-box-header">
									<h5>고객안내</h5>
								</div>
								<div class="cs-conList-box-if">
								<a class="cs-conList" href="/cs/introduceMember.exco">
									사이트 이용 가이드
									<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
								</a>
								</div>
							</div>
							<div class="cs-box">
								<div class="cs-box-header">
									<h5>전문가 안내</h5>
								</div>
								<div class="cs-conList-box-if">
								<a class="cs-conList" href="/cs/introExpertProcess.exco">
									전문가 회원 승인 절차 안내
									<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
								</a>
								<a class="cs-conList" href="/cs/introduceExpert.exco">
									사이트 이용 가이드
									<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
								</a>
								</div>
							</div>
							</div>
							<div class="cs-conList-box">
							<div class="cs-box">
									<div class="cs-box-header">
										<h5>정보 제공</h5>
									</div>
							<a class="cs-conList" href="/cs/siteTermsOfUse.exco">
								이용약관
								<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
							</a>
							<a class="cs-conList" href="/cs/personalInfoPolicy.exco">
								개인정보처리방침
								<img id="direct-arrow" src="/resources/images/icon_arrow_outward_white.png">
							</a>
							</div>
							</div>
						</div>
						<div class="cs-conList-box">
							<div class="cs-conTxt">
								<p>그룹레슨 신청, 채팅, 알림 등의 서비스 이용과 1:1문의 작성은 회원가입 완료 후 로그인을 하셔야 가능합니다.</p>
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
				</div>
			</section>
		</main>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>