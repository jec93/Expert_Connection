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
	
				<div class="mypage-memberProfile">
					<div class="memberInfo-brife">
						<a href="javascript:void(0)" onclick="showProfilePopup()" id="myProfile"><span>프로필 사진</span></a>
						<div class="mypage-memberInfo">
							<div id="mypage-myNickname">
								<h3>${loginMember.memberNickname}님</h3>
									<img id="mystate" src="/resources/logo/expert_connection_logo_03.png">
									<a href="/member/updateFrm.exco" id="memberInfo-update">정보수정</a>
									<a href="/member/deleteFrm.exco" id="memberInfo-update">회원탈퇴</a>
							</div>
							<span class="memberEmail">${loginMember.memberEmail}</span>
						</div>
					</div>
				</div>
				
				<div class="mypage-first-group">
					<h3 class="mypage-group-title">서비스 이용내역</h3>
						<ul class="mypage_link_box">
							<li><a id="mypage_link" href="#">사용내역💰</a></li>
							<li><a id="mypage_link" href="#">찜한 전문가</a></li>
							<li><a id="mypage_link" href="#">리뷰</a></li>
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
			</c:when>
			
			<%-- <c:when test="${loginMember != null}"> --%>
			<c:when test="${not empty loginMember && (loginMember.memberType == 4 || loginMember.memberType == 5 || loginMember.memberType == 6)}">
			<div class="mypage">
				<input type="hidden" id="memberNo" name="memberNo" value="${loginMember.memberNo}">
	
				<div class="mypage-memberProfile">
					<div class="memberInfo-brife">
						<a href="javascript:void(0)" onclick="showProfilePopup()" id="myProfile"><span>프로필 사진</span></a>
						<div class="mypage-memberInfo">
							<div id="mypage-myNickname">
								<h3>${loginMember.memberNickname} 전문가님</h3>
								<%-- <c:if test="${loginMember.expertGrade eq 1}">
								<img id="mystate" src="/resources/logo/expert_type_01.png">
								</c:if>
								<c:if test="${loginMember.expertGrade eq 2}">
								<img id="mystate" src="/resources/logo/expert_type_02.png">
								</c:if>
								<c:if test="${loginMember.expertGrade eq 3}"> --%>
								<img id="mystate" src="/resources/images/expert_type_03.png">
								<%-- </c:if> --%>
								<div class="mypage-update">
									<a href="/member/updateFrm.exco" id="memberInfo-update">정보수정</a>
									<a href="/member/deleteFrm.exco" id="memberInfo-update">회원탈퇴</a>
								</div>
							</div>
							<span class="memberEmail">${loginMember.memberEmail}</span>
							<a href="#" id="own-expertPage">전문가 상세페이지로 이동</a>
						</div>
					</div>
				</div>
				
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
			</c:when>
			
			<%-- 관리자 마이페이지 --%>
			<c:when test="${not empty loginMember && (loginMember.memberType == 0)}">
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