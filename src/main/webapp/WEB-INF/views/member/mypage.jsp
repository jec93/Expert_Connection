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
   width: 120px;
   height: 120px;
   overflow : hidden;
   position : relative;
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
   margin-left : 320px;
   margin-top : -90px;
}
.memberNickname{
   margin-left : 480px;
   margin-top : -100px;
   
}
.memberEmail{
   margin-left : 480px;
}

.profile-img {
    width: 100%;           /* 버튼 너비에 맞춤 */
    height: 100%;          /* 버튼 높이에 맞춤 */
    object-fit: cover;     /* 이미지 비율 유지하면서 잘라냄 */
    position: absolute;    /* 컨테이너 내 배치 */
    top: 0;
    left: 0;
}
.update-container{
 padding-left: 500px;

}
.update{
 padding-left: 950px;
 margin-bottom : 100px;
 display : flex;
 margin-top: -55px;
}
.update-nickname{
 padding-left: 200px;
}
.memberInfo-brife{
 padding-left: 200px;
}
.tab-item {
	width: calc(100%/ 3);
	height: 50px;
	line-height: 50px;
	font-size: 16px;
	text-align: center;
	color: black;
	transition: background-color 0.2s ease;
}

.tab-item:hover {
	opacity: 0.75;
	cursor: pointer;
}

/* 탭 내용 스타일 */
.tab-content {
	display: none;
	padding: 20px;
	font-size: 16px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

.tab-content.active {
	display: block;
}

/*라디오 버튼 삭제*/
input[name="tab-item"] {
	display: none;
}

.tab-item.active{
	background-color: #fff; 
	color: #223B24; /* 텍스트 색상을 강조색으로 변경 */
	border-bottom: 2px solid #223B24; /* 선택된 탭 하단 강조 */
}
#qualifications{
	margin-left : 110px;
}
#introduce{
	margin-left : 110px;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<c:choose>
    <c:when test="${loginMember != null && (loginMember.memberType == 1 || loginMember.memberType == 2 || loginMember.memberType == 3)}">
<div class="mypage">
      <div class="mypage">
         <input type="hidden" id="memberNo" name="memberNo" value="${loginMember.memberNo}">

         <div class="mypage-memberProfile">
            <div class="memberInfo-brife">
                <a href="javascript:void(0)" onclick="showProfilePopup()" class="circle-button" >
               <img src="${loginMember.profilePath + loginMember.profileName}" >
           		 <!-- <img src="${loginMember.profilePath + loginMember.profileName != null ? loginMember.profilePath + loginMember.profileName  : '/resources/logo/expert_connection_favicon.png'}" class="profile-img">-->
            </a>
            </div>
            <div class="update-nickname">
               <h3 class="memberNickname">${loginMember.memberNickname} 회원님</h3>
               <span class="memberEmail">${loginMember.memberEmail}</span>
            </div>
            <div class="update">
    			<a href="/member/updateFrm.exco" id="memberInfo-update">정보수정</a>
				<a href="/member/deleteFrm.exco" id="memberInfo-update">회원탈퇴</a>
            </div>
            <div class="update-container">
         
         
          <div class="mypage-first-group">
					<h3 class="mypage-group-title">서비스 이용내역</h3>
						<ul class="mypage_link_box">
							<li><a id="mypage_link" href="#">사용내역💰</a></li>
							<li><a id="mypage_link" href="#">찜한 전문가</a></li>
							<li><a id="mypage_link" href="#">리뷰</a></li>
						</ul>
		</div>
      
         
         <div class="mypage-group">
					<h3 class="mypage-group-title">커뮤니티</h3>
						<ul class="mypage_link_box">
							<li><a id="mypage_link" href="#">작성한 게시글 확인</a></li>
							<li><a id="mypage_link" href="#">작성한 댓글 확인</a></li>
						</ul>
		</div>
         
         <div class="mypage-group">
					<h3 class="mypage-group-title">채팅</h3>
						<ul class="mypage_link_box">
							<li><a id="mypage_link" href="#">채팅 내역</a></li>
						</ul>
		</div>
      
         <div class="mypage-last-group">
					<h3 class="mypage-group-title">가이드</h3>
						<ul class="mypage_link_box">
							<li><a id="mypage_link" href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4">공지사항</a></li>
							<li><a id="mypage_link" href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5">FAQ</a></li>
							<li><a id="mypage_link" href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6" class="mypage_link">1:1 문의</a></li>
							<li><a id="mypage_link" href="/cs/introduceMember.exco">사이트 이용 가이드</a></li>
						</ul>
		</div>
      </div>
   </div>
   </div>
   </div>
       </c:when>
       <c:when test="${loginMember != null && (loginMember.memberType == 4 || loginMember.memberType == 5 || loginMember.memberType == 6)}">
<div class="mypage">
      <div class="content">
        <input type="hidden" id="memberNo" name="memberNo" value="${loginMember.memberNo}">

         <div class="mypage-memberProfile">
            <div class="memberInfo-brife">
                <a href="javascript:void(0)" onclick="showProfilePopup()" class="circle-button" >
           		<img src="${loginMember.profilePath + loginMember.profileName}" >
            <span>프로필 사진</span>
            </a>
            </div>
            <div class="update-nickname">
               <h3 class="memberNickname">${loginMember.memberNickname} 전문가님</h3>
               <span class="memberEmail">${loginMember.memberEmail}</span>
            </div>
            <div class="update">
    			<a href="/member/updateFrm.exco" id="memberInfo-update">정보수정</a>
				<a href="/member/deleteFrm.exco" id="memberInfo-update">회원탈퇴</a>
            </div>
            <div class="update-container">
         
         
         <div class="mypage-first-group">
					<h3 class="mypage-group-title">서비스 이용내역</h3>
						<ul class="mypage_link_box">
							<li><a id="mypage_link" href="#">사용내역💰</a></li>
						</ul>
				</div>
				
				<div class="mypage-group">
					<h3 class="mypage-group-title">채팅</h3>
						<ul class="mypage_link_box">
							<li><a id="mypage_link" href="#">채팅 내역</a></li>
							<li><a id="mypage_link" href="#">자동응답 설정</a></li>
						</ul>
				</div>
				
				<div class="mypage-group">
					<h3 class="mypage-group-title">커뮤니티</h3>
						<ul class="mypage_link_box">
							<li><a id="mypage_link" href="#">작성한 게시글 확인</a></li>
							<li><a id="mypage_link" href="#">작성한 댓글 확인</a></li>
							<li><a id="mypage_link" href="/board/list.exco?reqPage=1&boardType=1&boardTypeNm=1">전문가 게시판</a></li>
							<li><a id="mypage_link" href="/board/list.exco?reqPage=1&boardType=2&boardTypeNm=2">전문가 노하우</a></li>
							<li><a id="mypage_link" href="/board/list.exco?reqPage=1&boardType=3&boardTypeNm=3">그룹레슨</a></li>
						</ul>
				</div>
				
					<div class="mypage-group">
					<h3 class="mypage-group-title">PR</h3>
						<ul class="mypage_link_box">
							<li> <label class="tab-item" for="information" onclick="switchTab('portfolio-content', this)">포트폴리오</label> 
							     <input id="portfolio" type="radio" name="tab-item" /></li>
							<li><label class="tab-item" for="menu" onclick="switchTab('introduce-content', this)" id="introduce">소개</label> 
						        <input id="introduce" type="radio" name="tab-item" /></li>
							<li><label class="tab-item" for="review" onclick="switchTab('qualifications-content', this)" id="qualifications">자격증</label> 
					        	<input id="qualifications" type="radio" name="tab-item" /></li>			      
						</ul>
				</div>
				  <div class="PR-detail-content">
					        	<div class="tab-content" id="portfolio-content">포트폴리오</div>			
								<div class="tab-content" id="introduce-content">소개</div>						
								<div class="tab-content" id="qualifications-content">자격증</div>
				  </div>
				
				
				<div class="mypage-last-group">
					<h3 class="mypage-group-title">가이드</h3>
						<ul class="mypage_link_box">
							<li><a id="mypage_link" href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4">공지사항</a></li>
							<li><a id="mypage_link" href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5">FAQ</a></li>
							<li><a id="mypage_link" href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6" class="mypage_link">1:1 문의</a></li>
							<li><a id="mypage_link" href="/cs/introduceExpert.exco">사이트 이용 가이드</a></li>
						</ul>
				</div>
      </div>
   </div>
   </div>
   </div>
       </c:when>
       <c:when test="${loginMember != null && (loginMember.memberType == 0)}">
	<div class="mypage">
				<input type="hidden" id="memberNo" name="memberNo" value="${loginMember.memberNo}">

				<div class="mypage-adminProfile">
					<div class="memberInfo-brife">
						<a href="javascript:void(0)" onclick="showProfilePopup()" id="myProfile"><span>프로필 사진</span></a>
						<div class="mypage-memberInfo">
							<div id="mypage-myNickname">
								<h3>${loginMember.memberNickname}님</h3>
								<img id="mystate" src="/resources/logo/expert_connection_logo_02.png">
							</div>
							<span class="memberEmail">${loginMember.memberEmail}</span>
						</div>
					</div>
					<div class="adminPage-group">
						<div class="adminPage_management">
							<h4 class="mypage-group-title">회원관리</h4>
							<div class="adminPage_link_box">
							<ul class="adminPage_link_box">
								<li><a id="adminPage_link" href="#">신고내역 관리</a></li>
								<li><a id="adminPage_link" href="#">전문가 승인 검토</a></li>
							</ul>
							</div>
						</div>
						<div class="adminPage_management">
							<h4 class="mypage-group-title">사이트 관리</h4>
							<ul class="adminPage_link_box">
								<li><a id="adminPage_link" href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4">공지사항 관리</a></li>
								<li><a id="adminPage_link" href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5">FAQ 관리</a></li>
								<li><a id="adminPage_link" href="/board/adminManageList.exco?reqPage=1&boardType=${board.boardType}&searchName=">커뮤니티 관리</a></li>
								<li><a id="adminPage_link" href="#">카테고리 관리</a></li>
								<li><a id="adminPage_link" href="/admin/reportManageFrm.exco">신고항목 관리</a></li>								
							</ul>
						</div>
					</div>
				</div>
				<div class="mypage-manage-box">
						<h4 class="mypage-group-title">1:1문의 관리</h4>
					<div>
						<table class="tbl">
	                     <tr>
	                        <th style="width:8%">번호</th>
	                        <th style="width:30%">제목</th>
	                        <th style="width:15%">작성자</th>
	                        <th style="width:15%">작성일</th>
	                        <th style="width:10%">조회수</th>
	                     </tr>
	                     <c:forEach var="board" items="${boardList}">
	                     <tr>
	                        <td>${board.boardNo}</td>
	                        <td><a class="boardTitle" href="/board/viewBoardFrm.exco?boardNo=${board.boardNo}&boardType=${board.boardType}">${board.boardTitle}</a></td>
	                        <td>${board.boardWriter}</td>
	                        <td>${board.boardDate}</td>
	                        <td>${board.boardCount}</td>
	                     </tr>
                     </c:forEach>
                  </table>
               <div id="pageNavi">${pageNavi}</div>
					</div>
				</div>
			</div>
       </c:when>
    <c:otherwise>
    </c:otherwise>
</c:choose>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
function showProfilePopup() {
    
     var popupURL = "/member/profileUpdateFrm.exco";
     var popupProperties = "width=500,height=400,scrollbars=yes";
     
     window.open(popupURL, "Popup", popupProperties);
   }
   
function switchTab(contentId, tabElement) {
    // 현재 활성화된 콘텐츠와 탭 찾아서 제거
    const activeContent = document.querySelector('.tab-content.active');
    const activeTab = document.querySelector('.tab-item.active');
    
    if (activeContent) {
        activeContent.classList.remove('active'); // 현재 활성화된 콘텐츠 숨김
    }
    if (activeTab) {
        activeTab.classList.remove('active'); // 현재 활성화된 탭 비활성화
    }

    // 새로운 콘텐츠와 탭 활성화
    const newContent = document.getElementById(contentId);
    if (newContent) {
        newContent.classList.add('active'); // 선택된 콘텐츠 표시
    }
    tabElement.classList.add('active'); // 선택된 탭 강조
}
</script>
</body>
</html>