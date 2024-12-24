<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<style>
.circle-button {
	width: 90px;
	height: 90px;
	border-radius: 50%;
	color: #fff;
	font-size: 12px;
	font-weight: bold;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	text-align: center;
	text-decoration: none;
	cursor: pointer;
	transition: background-color 0.3s ease;
	margin: 10px;
	border : 1px solid black;
	margin-left : 350px;
	margin-top : 70px;
}
.memberNickname{
	margin-left : 480px;
	margin-top : -100px;
	
}
.memberEmail{
	margin-left : 480px;
}
.update{
	margin-left : 650px;
	margin-top : -50px;
}
.update-button{
	background-color : white;
	width : 80px;
}
.update-button:hover{
	background-color : gray;
}
.first-group{
	margin-left : 350px;
	margin-top : 120px;
}
.first-title{
	font-weight : bold;
	font-size : 18px;
	margin-bottom : 10px;
}
.usage-detail{
	display : inline-block;
}
.save-expert{
	display : inline-block;
	margin-left : 80px;
}
.review{
	display : inline-block;
	margin-left : 80px;
}
.second-group{
	margin-left : 350px;
	margin-top : 70px;
}
.second-title{
	font-weight : bold;
	font-size : 18px;
	margin-bottom : 10px;
}
.mypage-board{
	display : inline-block;
}
.mypage-comment{
	display : inline-block;
	margin-left : 80px;
}
.third-group{
	margin-left : 350px;
	margin-top : 70px;
}
.third-title{
	font-weight : bold;
	font-size : 18px;
	margin-bottom : 10px;
}
.chat-history{
	display : inline-block;
}
.fourth-group{
	margin-left : 350px;
	margin-top : 70px;
}
.fourth-title{
	font-weight : bold;
	font-size : 18px;
	margin-bottom : 10px;
}
.notice{
	display : inline-block;
}
.FAQ{
	display : inline-block;
	margin-left : 80px;
}
.inquiry{
	display : inline-block;
	margin-left : 80px;
}
.site-introduce{
	display : inline-block;
	margin-left : 80px;
}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		
		<main class="content">
			<section class="section mypage-wrap">
			
			<c:choose>
			<c:when test="${(loginMember != null) && (loginMember.memberType == 1 || loginMember.memberType == 2 || loginMember.memberType == 3)}">
			<%-- <c:when test="${not empty loginMember && (loginMember.memberType == 1 || loginMember.memberType == 2 || loginMember.memberType == 3)}"> --%>
			<div class="mypage">
				<input type="hidden" id="memberNo" name="memberNo" value="${loginMember.memberNo}">
	
				<div class="button-group-container">
					<div class="button-group">
						<a href="javascript:void(0)" onclick="showProfilePopup()" class="circle-button"><span>프로필 사진</span></a>
					</div>
					<div>
						<h3 class="memberNickname">${loginMember.memberNickname} 회원님</h3>
						<span class="memberEmail">${loginMember.memberEmail}</span>
					</div>
					<div class="update">
					<button class="update-button"><a href="/member/updateFrm.exco">정보수정</a></button>
					<button class="update-button"><a href="/member/deleteFrm.exco">회원탈퇴</a></button>
					</div>
				</div>
				
				<div class="first-group">
					<div class="first-title">서비스 이용내역</div>
						<div class="first-children">
							<a href="#" class="mypage_link">사용내역💰</a>
							<a href="#" class="mypage_link">찜한 전문가</a>
							<a href="#" class="mypage_link">리뷰</a>
						</div>
				</div>
				
				<div class="second-group">
					<div class="second-title">채팅</div>
						<div class="second-children">
							<a href="#" class="mypage_link">채팅 내역</a>
						</div>
				</div>
				
				<div class="third-group">
					<div class="third-title">커뮤니티</div>
						<div class="third-children">
							<a href="#" class="mypage_link">커뮤니티 작성글</a>
							<a href="#" class="mypage_link">댓글</a>
						</div>
				</div>
				
				<div class="fourth-group">
					<div class="fourth-title">가이드</div>
						<div class="fourth-children">
							<a href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4" class="mypage_link">공지사항</a>
							<a href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5" class="mypage_link">FAQ</a>
							<a href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6" class="mypage_link">1:1 문의</a>
							<a href="/cs/introduceMember.exco"  class="mypage_link">사이트 이용 가이드</a>
						</div>
				</div>
			</div>
			</c:when>
			
			<%-- <c:when test="${loginMember != null}"> --%>
			<c:when test="${not empty loginMember && (loginMember.memberType == 4 || loginMember.memberType == 5 || loginMember.memberType == 6)}">
			<div class="mypage">
				<input type="hidden" id="memberNo" name="memberNo" value="${loginMember.memberNo}">
	
				<div class="button-group-container">
					<div class="button-group">
						<a href="javascript:void(0)" onclick="showProfilePopup()" class="circle-button"><span>프로필 사진</span></a>
					</div>
					<div>
						<h3 class="memberNickname">${loginMember.memberNickname} 전문가님</h3>
						
						<span class="memberEmail">${loginMember.memberEmail}</span>
					</div>
					<div class="update">
					<button class="update-button"><a href="/member/updateFrm.exco">정보수정</a></button>
					<button class="update-button"><a href="/member/deleteFrm.exco">회원탈퇴</a></button>
					</div>
				</div>
				
				<div class="first-group">
					<div class="first-title">서비스 이용내역</div>
						<div class="first-children">
							<a href="#" class="mypage_link">사용내역💰</a>
							<a href="#" class="mypage_link">찜한 전문가</a>
							<a href="#" class="mypage_link">리뷰</a>
						</div>
				</div>
				
				<div class="second-group">
					<div class="second-title">채팅</div>
						<div class="second-children">
							<a href="#" class="mypage_link">채팅 내역</a>
							
						</div>
				</div>
				
				<div class="third-group">
					<div class="third-title">커뮤니티</div>
						<div class="third-children">
							<a href="#" class="mypage_link">커뮤니티 작성글</a>
							<a href="#" class="mypage_link">댓글</a>
						</div>
				</div>
				
				<div class="fourth-group">
					<div class="fourth-title">가이드</div>
						<div class="fourth-children">
							<a href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4" class="mypage_link">공지사항</a>
							<a href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5" class="mypage_link">FAQ</a>
							<a href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6" class="mypage_link">1:1 문의</a>
							<a href="/cs/introduceExpert.exco"  class="mypage_link">사이트 이용 가이드</a>
						</div>
				</div>
			</div>
			</c:when>
			
			<c:when test="${not empty loginMember && (loginMember.memberType == 0)}">
			<div class="mypage">
				<input type="hidden" id="memberNo" name="memberNo" value="${loginMember.memberNo}">

				<div class="button-group-container">
					<div class="button-group">
						<a href="javascript:void(0)" onclick="showProfilePopup()" class="circle-button"><span>프로필 사진</span></a>
					</div>
					<div>
						<div class="mypage-userInfo">
							<h3 class="">${loginMember.memberNickname}님</h3>
							<img id="expertType" src="/resources/logo/expert_connection_logo_02.png">
						</div>
						<span class="memberEmail">${loginMember.memberEmail}</span>
					</div>
					
				</div>
				
				<div class="first-group">
					<div class="first-title">서비스 이용내역</div>
						<div class="first-children">
							<a href="#" class="mypage_link">사용내역💰</a>
							<a href="#" class="mypage_link">찜한 전문가</a>
							<a href="#" class="mypage_link">리뷰</a>
						</div>
				</div>
				
				<div class="second-group">
					<div class="second-title">채팅</div>
						<div class="second-children">
							<a href="#" class="mypage_link">커뮤니티 작성글</a>
							<a href="#" class="mypage_link">댓글</a>
						</div>
				</div>
				
				<div class="third-group">
					<div class="third-title">커뮤니티</div>
						<div class="third-children">
							<a href="#" class="mypage_link">채팅 내역</a>
						</div>
				</div>
				
				<div class="fourth-group">
					<div class="fourth-title">가이드</div>
						<div class="fourth-children">
							<a href="#" class="mypage_link">공지사항</a>
							<a href="#" class="mypage_link">FAQ</a>
							<a href="#" class="mypage_link">1:1 문의</a>
							<a href="#" class="mypage_link">사이트 소개</a>
						</div>
				</div>
			</div>
			</c:when>
			
			<c:otherwise>
			
			</c:otherwise>
			
			</c:choose>
			
			</section>
		</main>
				
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

<script>
function showProfilePopup() {
	 
	  var popupURL = "/member/profileUpdateFrm.exco";
	  var popupProperties = "width=600,height=500,scrollbars=yes";
	  
	  window.open(popupURL, "Popup", popupProperties);
	}
</script>
</body>
</html>