<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
/* 전체 채팅 목록 컨테이너 스타일 */
.chat-container {
    width: 70%;
    margin: 0 auto;
    font-family: Arial, sans-serif;
    margin-bottom: 30px; /* 요소 간 간격 설정 */
}

/* 채팅 목록 제목 스타일 */
.chat-header {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
}

/* 채팅방 목록 스타일 */
.chat-list {
    display: flex;
    flex-direction: column;
    gap: 15px; /* 채팅방 간의 간격 */
}

.chat-hide-btn {
	background: none;
	border: none;
	font-size: 16px;
	color: #999;
	cursor: pointer;
	align-self: flex-start;
	margin-right: -10px;
	margin-top: -10px;
}

.chat-hide-btn:hover {
    color: #ff6666;
}

/* 개별 채팅방 스타일 */
.chat-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    border: 1px solid #ccc;
    border-radius: 10px;
    padding: 15px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    background-color: #fff;
    cursor: pointer;
}

.chat-item:hover {
    background-color: #f9f9f9;
}

/* 채팅방 이미지 스타일 */
.chat-img {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: #ddd;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    color: #777;
}

/* 채팅방 이름 및 마지막 메시지 스타일 */
.chat-details {
    flex: 1;
    margin-left: 15px;
}

.chat-details .chat-name {
    font-size: 18px;
    font-weight: bold;
    color: #333;
}

.chat-details .chat-message {
    font-size: 14px;
    color: #666;
    margin-top: 5px;
    
    white-space: nowrap;        /* 한 줄로 표시 */
    overflow: hidden;           /* 넘치는 텍스트 숨기기 */
    text-overflow: ellipsis;    /* 말줄임표(...) 추가 */
    max-width: 250px;           /* 최대 너비 설정 */
}

/* 마지막 채팅 날짜 스타일 */
.chat-date {
    font-size: 14px;
    color: #999;
}

</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<main class="content">
			<a href="/expert/expertList.exco">전문가리스트 (테스트)</a>
			<a href="/expert/expertBotSearch.exco">챗봇 (테스트)</a>
			


			<!-- 채팅방 목록 -->
			<div class="chat-header">채팅 목록</div>
			<c:forEach var="room" items="${roomList}">
				<div class="chat-container">
					<div class="chat-list">
						<div class="chat-item" data-room-id="${room.roomId}"
							onclick="location.href='/chat/getChatList.exco?roomId=${room.roomId}'">
							<div class="chat-img">프로필 사진</div>
							<div class="chat-details">
								<div class="chat-name">${room.displayName}</div>
								<div class="chat-message">${room.msg}</div>
							</div>
							<div class="chat-date">${room.msgDate}</div>
							<button class="chat-hide-btn" onclick="fn.hideRoom(event, this)">X</button>
						</div>
					</div>
				</div>
			</c:forEach>

		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

	<script>
	//웹소켓 연결
	const socket = new WebSocket("ws://localhost/chat/doChat.exco") // IP 변경
	
	socket.onmessage = function(event) {
	    const data = JSON.parse(event.data);

	    if (data.type === "chat") {
	        const hiddenChat = document.querySelector(`.chat-item[data-room-id="${data.roomId}"]`);
	        if (hiddenChat) {
	            hiddenChat.style.display = 'flex';
	        } else {
	            const chatList = document.querySelector('.chat-list');
	            if (chatList) {
	                const newChatItem = document.createElement('div');
	                newChatItem.className = 'chat-item';
	                newChatItem.setAttribute('data-room-id', data.roomId);
	                newChatItem.innerHTML = `
	                    <div class="chat-img">프로필 사진</div>
	                    <div class="chat-details">
	                        <div class="chat-name">채팅방</div>
	                        <div class="chat-message">${data.msg}</div>
	                    </div>
	                    <button class="chat-hide-btn" onclick="fn.hideRoom(event, this)">X</button>
	                `;
	                chatList.appendChild(newChatItem);
	            }
	        }
	    }
	};

	
	socket.onopen = function() {
		console.log("WebSocket 연결 성공");
	};
	
	socket.onerror = function() {
		console.log("WebSocket 오류 : ", error);
	};
	
	socket.onclose = function() {
		console.log("WebSocket 연결 종료");
	};
	
	let fn = {
		createRoom : function(){
			let top = (window.innerHeight - 300) / 2 + window.screenY;
			let left = (window.innerWidth - 200) / 2 + window.screenX;
			
			window.open("/chat/createRoomFrm.exco", "creatRoom", "width="+300+", height="+200+", top="+top+", left="+left);
		},
		
		// 채팅방 숨기기 함수
	    hideRoom: function(event, button) {
	        // 이벤트 전파 차단
	        event.stopPropagation();

	        // 버튼의 부모 요소(chat-item)를 찾는다
	        let chatItem = button.closest('.chat-item');
	        if (chatItem) {
	            let roomId = chatItem.getAttribute('data-room-id'); //채팅방 ID 가져오기
	            
	            $.ajax({
	            	url: '/chat/hideRoom.exco',
	            	method: 'POST',
	            	data: {roomId: roomId},
	            	success: function(response) {
	            		if(response === 'success') {
	            			// 성공 시 UI에서 숨김 처리
	            			chatItem.style.display = 'none';
	            		}else {
	            			alert('채팅방 숨기기에 실패했습니다.');
	            		}
	            	},
	            	error: function() {
	            		alert('서버와의 통신 중 오류가 발생했습니다.');
	            	}
	            });
	        }
	    }
	};
	</script>
</body>
</html>