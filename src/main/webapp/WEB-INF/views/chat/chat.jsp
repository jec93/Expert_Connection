<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<style>
/* 전체 페이지 스타일 */
body {
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f7f7f7;
}

/* 채팅 화면 영역 스타일 */
#chatContainer {
    display: flex;
    width: 70%;
    margin: 20px auto;
    background: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
    overflow: hidden;
}

/* 채팅 메시지 영역 스타일 */
#chatSection {
    flex: 3;
    display: flex;
    flex-direction: column;
    padding: 15px;
    background-color: #f8fdfc;
}

/* 메시지 출력 영역 */
#msgArea {
    border: 1px solid #34805C;
    height: 350px;
    overflow-y: auto;
    padding: 15px;
    background-color: #ffffff;
    border-radius: 6px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* 참여 멤버 목록 스타일 */
#memberSection {
    flex: 1;
    background-color: #f3f7f6;
    padding: 15px;
    overflow-y: auto;
}

.member {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    padding: 5px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #ffffff;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.member .profile-img {
    width: 35px;
    height: 35px;
    border-radius: 50%;
    background-color: #cccccc;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 10px;
    font-size: 12px;
    color: #ffffff;
    overflow: hidden;
    border: 2px solid #82E3B6;
}

.member .profile-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.member .member-name {
    font-size: 13px;
    font-weight: bold;
    color: #333333;
}

/* 메시지 스타일 */
.message {
    display: flex;
    align-items: flex-start;
    margin-bottom: 10px;
}

.message .profile-img {
    width: 35px;
    height: 35px;
    border-radius: 50%;
    background-color: #cccccc;
    margin-right: 10px;
    overflow: hidden;
    border: 2px solid #82E3B6;
}

.message .profile-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.message-content {
	display: inline-block; /* 글자 수에 따라 너비가 조정되도록 설정 */
    background-color: #82E3B6;
    padding: 10px 14px;
    border-radius: 10px;
    font-size: 13px;
    line-height: 1.4;
    color: #000000;
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
    margin: 0; /* 메시지 여백 제거 */
}

.message-content.self {
    background-color: #34805C;
    color: #ffffff;
}

.chat-time {
    font-size: 10px;
    color: #777;
    margin-top: 3px;
    text-align: right;
}

/* 채팅 입력 영역 */
#chatInput {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-top: 15px;
}

#chatMsg {
    flex: 1;
    height: 20px;
    border: 2px solid #ddd;
    border-radius: 6px;
    padding: 5px;
    font-size: 13px;
}

button {
    height: 35px;
    background-color: #82E3B6;
    color: #000000;
    border: none;
    border-radius: 8px;
    padding: 0 20px;
    cursor: pointer;
    font-weight: bold;
    font-size: 13px;
}

button:hover {
    background-color: #34805C;
    color: #ffffff;
}

/* 파일 업로드 스타일 */
input[type="file"] {
    border: 1px solid #ddd;
    padding: 5px;
    border-radius: 6px;
    font-size: 12px;
}

/* 방 나가기 링크 스타일 */
a.leaveRoom {
    display: inline-block;
    color: #DE0707;
    font-weight: bold;
    margin-top: 10px;
    text-decoration: none;
}

a.leaveRoom:hover {
    text-decoration: underline;
}

/* 오른쪽 정렬 메시지 스타일 */
.message.self {
    justify-content: flex-end;
    text-align: right;
}

.message.self .profile-img {
    display: none;
}

.message.self .message-content {
    background-color: #34805C;
    color: #ffffff;
    text-align: right;
}

/* 검색 입력 필드 */
#searchContainer {
    display: flex;
    align-items: center;
    gap: 8px;
}

#searchMsg {
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 13px;
}

#searchContainer button {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 18px;
    color: #333333;
}

#searchContainer button:hover {
    color: #34805C;
}

#filePreview img {
    border: 1px solid #ddd;
    margin-right: 5px;
}

#filePreview span {
    font-size: 12px;
    margin-right: 5px;
    color: #555;
}

#filePreview button {
    background: none;
    border: none;
    color: #ff0000;
    font-size: 16px;
    cursor: pointer;
}

#responseList button {
    display: block;
    width: 100%;
    background-color: #f8f9fa;
    color: #333;
    border: 1px solid #ddd;
    padding: 10px;
    margin-bottom: 5px;
    border-radius: 6px;
    cursor: pointer;
    text-align: left;
}

#responseList button:hover {
    background-color: #e9ecef;
}

</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<main class="content">

			<div id="chatContainer">
			
				<!-- 참여 멤버 영역 -->
				<div id="memberSection">
					<c:forEach var="member" items="${memberList}">
						<div class="member">
							<div class="profile-img">
								<img src="/path/to/profileImage.jpg" alt="Profile Image">
							</div>
							<div>
								<div class="member-name">${member.memberNickname}(${member.memberNo})</div>
							</div>
						</div>
					</c:forEach>
				</div>

				<!-- 메시지 출력 영역 -->
				<div id="chatSection" style="position: relative;">
					<!-- 검색 -->
					<div id="searchContainer"
						style="position: absolute; top: 15px; right: 20px;">
						<input type="text" id="searchMsg" placeholder="검색..."
							style="width: 200px; padding: 5px; border: 1px solid #ddd; border-radius: 4px; display: none;">
						<button onclick="fn.toggleSearch()"
							style="border: none; background: none; cursor: pointer; font-size: 18px;">
							<svg xmlns="http://www.w3.org/2000/svg" height="24px"
								viewBox="0 -960 960 960" width="24px" fill="#5f6368">
								<path
									d="M784-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l252 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T380-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400Z" /></svg>
						</button>
					</div>

					<div id="msgArea">
						<c:forEach var="chat" items="${chatList}">
							<div class="message ${chat.memberNo == sessionScope.loginMember.memberNo ? 'self' : ''}">
							    <div class="profile-img">
							        <img src="/path/to/profileImage.jpg" alt="Profile Image">
							    </div>
							    <div>
							        <div class="member-id">${chat.memberNickname}</div>
							        <div class="message-content">
							            <c:if test="${chat.msgGb eq 1}">
							                <a href="javascript:void(0)" onclick="fn.chatFileDown('${chat.fileName}', '${chat.filePath}')">${chat.fileName}</a>
							            </c:if>
							            ${chat.msg}
							        </div>
							        <div class="chat-time">${chat.msgDate}</div>
							    </div>
							</div>
						</c:forEach>
					</div>

					<!-- 채팅 입력 영역 -->
					<div id="chatInput">
						<input type="text" id="chatMsg" placeholder="메시지를 입력하세요...">
						<input type="file" id="fileInput" style="display: none;" onchange="fn.previewFile()"> <!-- 숨김 처리 -->
					    <button onclick="document.getElementById('fileInput').click();">+</button> <!-- 버튼으로 트리거 -->
					    <button onclick="fn.sendValidate()">전송</button>
					</div>
					
					<div id="filePreview" style="display: flex; align-items: center; gap: 8px; margin-top: 10px;"></div>
					
					<!-- 방 나가기 링크 -->
					<%-- <a
						href="/chat/deleteChat.exco?roomId=${roomId}&memberNo=${loginMember.memberNo}"
						class="leaveRoom">방 나가기</a> --%> <!-- 일단 보류 -->  
				</div>
			</div>

		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>


	<script>
        var ws;
        var memberNo = '${sessionScope.loginMember.memberNo}';
        var roomId = '${roomId}';

        let fn = {
            init : function () {
                ws = new WebSocket("ws://localhost/chat/doChat.exco"); // 해당 PC IP로 변경할 것.
                ws.onopen = function() {
                    var msg = { type: "connect", memberNo: memberNo };
                    ws.send(JSON.stringify(msg));
                };
                
                
                ws.onmessage = function(e) {
                    var msgData = JSON.parse(e.data); 
                    
                    const memberNo = msgData.memberNo;
                    const msg = msgData.msg;
                    var currentTime = moment().format('YYYY-MM-DD HH:mm:ss'); 

                    let fileLink = '';
                    if (msgData.filePath && msgData.fileName) {
                    	fileLink = '<a href="' + msgData.filePath + '" download="' + msgData.fileName + '" class="file-link">' +
			                        msgData.fileName +
			                        '</a><br>';
                    }
                    
                 // 내가 보낸 메시지인지 확인
                    const isSelf = memberNo === '${sessionScope.loginMember.memberNo}';
                    const messageClass = isSelf ? 'self' : '';
                    
                    var messageHtml =
                        '<div class="message ' + messageClass + '">' +
                            '<div class="profile-img">' +
                                '<img src="/path/to/profileImage.jpg" alt="Profile Image">' +
                            '</div>' +
                            '<div>' +
                                '<div class="member-id">' + memberNo + '</div>' +
                                '<div class="message-content">' + fileLink + msg + '</div>' +
                                '<div class="chat-time">' + currentTime + '</div>' +
                            '</div>' +
                        '</div>';
                    
                    
                    $("#msgArea").append(messageHtml);
                    $("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
                };
                
                ws.onclose = function() {
                    console.log("연결종료");
                };
            },
            
            previewFile: function () {
                const fileInput = document.getElementById("fileInput");					
                const filePreview = document.getElementById("filePreview");

                filePreview.innerHTML = ""; // 기존 미리보기 초기화

                const file = fileInput.files[0];
                if (file) {
                    const fileName = file.name;
                    const reader = new FileReader();

                    reader.onload = function (e) {
                        // 이미지 파일인지 확인
                        if (file.type.startsWith("image/")) {
                            const img = document.createElement("img");
                            img.src = e.target.result;
                            img.style.width = "50px";
                            img.style.height = "50px";
                            img.style.objectFit = "cover";
                            img.style.borderRadius = "8px";
                            filePreview.appendChild(img);
                        } else {
                            // 이미지가 아닌 경우 파일 이름만 표시
                            const fileNameElement = document.createElement("span");
                            fileNameElement.textContent = fileName;
                            filePreview.appendChild(fileNameElement);
                        }

                        // 삭제 버튼 추가
                        const removeButton = document.createElement("button");
                        removeButton.textContent = "×";
                        removeButton.style.marginLeft = "10px";
                        removeButton.onclick = function () {
                            fileInput.value = ""; // 파일 선택 초기화
                            filePreview.innerHTML = ""; // 미리보기 초기화
                        };
                        filePreview.appendChild(removeButton);
                    };

                    reader.readAsDataURL(file); // 파일 읽기 (이미지용)
                }
            },
            
            sendValidate : function () {
				//파일 서버 업로드 -> 메시지 전송
				let file = $('input[type=file]')[0].files;

				if(file.length > 0){
					file = file[0];
					
					const formData = new FormData();
					formData.append("file", file);
					formData.append("memberNo", memberNo);
					
					$.ajax({
			            url: "/chat/fileUpload.exco",
			            type: "post",
			            data: formData,
			            processData: false,
			            contentType: false,
			            success: function(obj) {
			            	fn.sendChat(obj); // 파일 정보 전달
			            	fn.clearPreview(); // 파일 미리보기 초기화
			            	
			            },
			            error: function() {
			                alert("파일 업로드 실패: " + error);
			            }
			        });
				}else {
					let obj = {};
					fn.sendChat(obj);
				}
            },
            sendChat : function (sendObj) {
                sendObj.type = "chat";
                sendObj.roomId = roomId;
                sendObj.memberNo = memberNo;
                sendObj.msg = $("#chatMsg").val();
                
                ws.send(JSON.stringify(sendObj));
                
                $("#chatMsg").val(""); 
                $('input[type=file]').val("");
            },
            
            clearPreview: function () {
                document.getElementById("fileInput").value = ""; // 파일 선택 초기화
                document.getElementById("filePreview").innerHTML = ""; // 미리보기 초기화
            },
            
            chatFileDown : function(fileName, filePath){
				fileName = encodeURIComponent(fileName);
				filePath = encodeURIComponent(filePath);
				
				location.href = "/chat/fileDown.exco?fileName="+fileName+"&filePath="+filePath;

			},
			// ----------------- 여기서 부터 검색 기능 -----------------
			toggleSearch: function () {
		        const searchInput = document.getElementById("searchMsg");
		        if (searchInput.style.display === "none") {
		            searchInput.style.display = "inline-block";
		            searchInput.focus();
		        } else {
		            searchInput.style.display = "none";
		            searchInput.value = "";
		            fn.clearSearchHighlight(); // 기존 검색 강조 해제
		        }
		    },
		    searchMessages: function () {
		        const searchTerm = document.getElementById("searchMsg").value.toLowerCase();
		        if (!searchTerm) {
		            alert("검색어를 입력하세요.");
		            return;
		        }

		        const messages = document.querySelectorAll("#msgArea .message");
		        let firstMatch = null;
		        
		        messages.forEach(message => {
		            const content = message.querySelector(".message-content").textContent.toLowerCase();
		            if (content.includes(searchTerm)) {
		                message.style.backgroundColor = "#ffffcc"; // 강조 표시
		                if (!firstMatch) {
		                    firstMatch = message; // 첫 번째 매칭된 메시지 저장
		                }
		            } else {
		                message.style.backgroundColor = ""; // 원래 배경색 복원
		            }
		        });
		        
		        if (firstMatch) {
		            firstMatch.scrollIntoView({ behavior: "smooth", block: "center" }); // 첫 번째 매칭된 메시지로 이동
		        } else {
		            alert("검색 결과가 없습니다.");
		        }
		    },
		    
		    clearSearchHighlight: function () {
		        const messages = document.querySelectorAll("#msgArea .message");
		        messages.forEach(message => {
		            message.style.backgroundColor = ""; // 원래 배경색 복원
		        });
		    }
        };

        document.getElementById("searchMsg").addEventListener("keyup", function (event) {
            if (event.key === "Enter") {
                fn.searchMessages();
            }
        });
        
        $(function() {
        	//소켓 연결
            fn.init();
        
    	    // Enter 키로 채팅 전송
            $("#chatMsg").on("keyup", function(event) {
                if (event.key === "Enter") {
                    fn.sendValidate();
                }
            });
        });
    </script>
</body>
</html>