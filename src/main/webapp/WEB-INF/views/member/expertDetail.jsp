<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전문가 상세 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}

.content {
    max-width: 1200px;
    margin: 20px auto;
    padding: 30px;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
}

.profile-header {
    text-align: left;
    margin-bottom: 20px;
}

.profile-header .profile-img {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    border: 2px solid #ddd;
    margin-bottom: 15px;
    object-fit: cover; /* 이미지를 비율 유지하며 자름 */
}

.profile-header h1 {
    font-size: 24px;
    color: #333;
    margin: 0;
}

.profile-header p {
    font-size: 14px;
    color: #666;
    margin: 5px 0;
}

.profile-header .actions {
    margin-top: 15px;
    display: flex;
    gap: 10px;
}

.profile-header .actions button {
    padding: 10px 20px;
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
}

.profile-header .actions button:hover {
    background-color: #218838;
}

.like-review {
    display: flex;
    margin-top: 20px;
    gap: 20px;
}

.like-review .like,
.like-review .review {
    font-size: 16px;
    color: #555;
}

.like-review .like span,
.like-review .review span {
    font-weight: bold;
    color: #333;
}

.tabs {
    margin-top: 20px;
    border-bottom: 1px solid #ddd;
    display: flex;
    gap: 20px;
}

.tabs button {
    background: none;
    border: none;
    font-size: 16px;
    color: #666;
    padding: 10px 0;
    cursor: pointer;
    border-bottom: 2px solid transparent;
    transition: color 0.3s, border-bottom-color 0.3s;
}

.tabs button.active {
    color: #007bff;
    border-bottom-color: #007bff;
    font-weight: bold;
}

.tab-content {
    display: none;
    margin-top: 20px;
}

.tab-content.active {
    display: block;
}

.tab-content .details {
    display: flex;
    flex-direction: column;
    gap: 10px;
}
.profile-header-title {
    display: flex; /* 텍스트와 이미지를 한 줄로 배치 */
    align-items: center; /* 텍스트와 이미지의 높이를 맞춤 */
    gap: 10px; /* 텍스트와 이미지 사이의 간격 */
    font-size: 24px; /* 제목 크기 */
    color: #333; /* 텍스트 색상 */
    margin: 0;
}

.grade-icon {
    width: 30px; /* 이미지 너비 */
    height: 30px; /* 이미지 높이 */
    object-fit: contain; /* 이미지 비율 유지 */
    vertical-align: middle; /* 텍스트와 정렬 */
}
</style>

</head>
<body>
	<div class="wrap">
	
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<div class="content">
			<div class="profile-header">
				<img class="profile-img" src="/resources/logo/expert_connection_favicon.png" alt="프로필 사진">
				<h1 class="profile-header-title">
				    ${expertDetail.expertNickname}
				    <c:choose>
				        <c:when test="${expertDetail.expertGrade == 0}">
				            <img src="/resources/images/expert_type_01.png" alt="등급 0" class="grade-icon">
				        </c:when>
				        <c:when test="${expertDetail.expertGrade == 1}">
				            <img src="/resources/images/expert_type_02.png" alt="등급 1" class="grade-icon">
				        </c:when>
				        <c:when test="${expertDetail.expertGrade == 2}">
				            <img src="/resources/images/expert_type_03.png" alt="등급 2" class="grade-icon">
				        </c:when>
				    </c:choose>
				</h1>
				
				<p> ${expertDetail.thirdCategoryNm} 전문가 | ${expertDetail.expertAddr}</p>
				<p>전문가의 간단한 소개 내용이 여기에 들어갑니다.</p>
				<div class="actions">
					<button>찜</button>
					<button onclick="createOneRoom('${expertDetail.memberNo}')">채팅</button>
				</div>
			</div>
			<div class="like-review">
				<div class="like">
					❤️ 좋아요 수: <span>120</span>
				</div>
				<div class="review">
					⭐ 리뷰: <span>4.8 / 5.0</span>
				</div>
			</div>
			<div class="tabs">
				<button class="active" data-tab="info-tab"
					onclick="showTab('info-tab')">전문가 정보</button>
				<button data-tab="portfolio-tab" onclick="showTab('portfolio-tab')">포트폴리오</button>
			</div>
			<div id="info-tab" class="tab-content active">
				<h2>정보</h2>
				<div class="details">
					<p>경력: 10년</p>
					<p>직원 수: 1명</p>
					<p>연락 가능 시간: 오전 6시 ~ 오후 11시</p>
					<p>결제 방법: 현금 가능</p>
				</div>
			</div>
			<div id="portfolio-tab" class="tab-content">
				<h2>포트폴리오</h2>
				<p>포트폴리오 내용이 여기에 표시됩니다.</p>
			</div>
		</div>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		
	</div>
	
	<script>
	//채팅 버튼 눌렀을 때 해당 전문가랑 채팅방 생성
	function createOneRoom(memberNo) {
        const roomName = "1:1 Chat with " + memberNo; 

        $.ajax({
            url: '/payment/goChat.exco',
            method: 'GET',
            data: {
                roomName: roomName,
                members: memberNo //상대방 ID만 전달
            },
            success: function(roomId) {
                /* // 생성된 채팅방으로 이동
                window.opener.location.href="/chat/getChatList.exco?roomId=" + roomId; //새창 열어서 이동
                self.close(); //기존 팝업창 닫기 */
                window.location.href = "/chat/getChatList.exco?roomId=" + roomId;  //바로 이동 
            },
            error: function() {
                alert('1:1 채팅방 생성에 실패했습니다.');
            }
        });
    }
	
	// 해당 탭(정보, 포트폴리오)으로 이동
	function showTab(tabId) {
	    document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
	    document.getElementById(tabId).classList.add('active');
	    document.querySelectorAll('.tabs button').forEach(btn => btn.classList.remove('active'));
	    document.querySelector(`[data-tab="${tabId}"]`).classList.add('active');
	}
	</script>
</body>
</html>
