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
    width: 90%;
    height: 80vh; /* 화면 높이의 80%로 조정 */
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
    height: calc(100% - 100px); /* 입력창 높이를 고려하여 조정 */
    max-height: 75vh;
    overflow-y: auto;
    padding: 15px;
    background-color: #ffffff;
    border-radius: 6px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* 참여 멤버 목록 스타일 */
#memberSection {
    flex: 0.8;
    height: 80vh;
    max-height: 90vh;
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
    border: 1px solid #82E3B6;
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
    border: 1px solid #82E3B6;
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
	position: absolute;
    display: flex;
    align-items: center;
    gap: 8px;
    margin-top: 15px;
    width: 95%;
    bottom: 24px;
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
    position: absolute;
}

#searchMsg {
    padding: 8px 12px;
    border: 2px solid #82E3B6;
    border-radius: 20px;
    font-size: 13px;
    outline: none;
    transition: all 0.3s ease-in-out;
    background-color: #ffffff;
    width: 200px;
    display: none;
}

/* 검색 입력 필드 포커스 시 스타일 */
#searchMsg:focus {
    border-color: #34805C;
    box-shadow: 0 0 5px rgba(52, 128, 92, 0.3);
}

#searchContainer button {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 20px; 
    color: #5f6368;
    padding: 0px;
     margin-right: 20px; /* 버튼을 왼쪽으로 이동 */
     margin-top: 5px;
}

#searchContainer button:hover {
    color: #34805C;
}

#filePreview {
    display: flex;
    align-items: center;
    gap: 8px;
    position: absolute;
    bottom: 60px; /* 채팅 입력창 위로 조정 */
    left: 50%;
    transform: translateX(-50%);
    width: 95%;
    background: rgba(255, 255, 255, 0.9);
    padding: 8px;
    border-radius: 8px;
}


#filePreview img {
    width: 100px !important;
    height: 100px !important;
    object-fit: cover;
    border-radius: 8px;
    border: 1px solid #ddd;
}

#filePreview span {
    font-size: 12px;
    margin-right: 3px;
    color: #555;
}

#filePreview button {
    background: none;
    border: none;
    color: #ff0000;
    font-size: 16px;
    cursor: pointer;
    line-height: 20px; /* 내부 정렬 */
    padding: 0; /* 기본 패딩 제거 */
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;
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

/* 자동응답 팝업 스타일 */
#autoResponsePopup {
    display: none;
    position: absolute;
    bottom: 50px; /* 위치 조정 */
    left: 0;
    width: 220px;
    background: #ffffff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    z-index: 1000;
    padding: 10px;
    font-size: 14px;
    max-height: 250px; /* 최대 높이 설정 */
    overflow-y: auto; /* 내용이 많아지면 스크롤 추가 */
}

/* 자동응답 리스트 스타일 */
#autoResponsePopup ul {
    list-style: none;
    margin: 0;
    padding: 0;
    max-height: 200px;
    overflow-y: auto;
}

/* 스크롤바 스타일 */
#autoResponsePopup ul::-webkit-scrollbar {
    width: 6px;
}

#autoResponsePopup ul::-webkit-scrollbar-thumb {
    background: #82E3B6;
    border-radius: 10px;
}

#autoResponsePopup ul::-webkit-scrollbar-track {
    background: #f3f7f6;
}

/* 자동응답 리스트 항목 */
.auto-response-item {
    padding: 12px;
    border-bottom: 1px solid #eee;
    cursor: pointer;
    transition: background 0.3s, color 0.3s;
    border-radius: 5px;
    font-weight: 500;
    color: #333;
}

/* 마지막 항목은 하단 테두리 제거 */
.auto-response-item:last-child {
    border-bottom: none;
}

/* 마우스 오버 시 스타일 */
.auto-response-item:hover {
    background-color: #f1f1f1;
    color: #34805C;
}

/* 팝업 닫기 버튼 */
#autoResponseClose {
    display: block;
    text-align: right;
    font-size: 12px;
    color: #999;
    cursor: pointer;
    padding: 5px;
    margin-bottom: 5px;
}

#autoResponseClose:hover {
    color: #34805C;
}

/* 팝업이 화면 아래쪽을 넘지 않도록 조정 */
#autoResponseContainer {
    position: relative;
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
								<img src="${member.profilePath}${member.profileName}" alt="Profile Image">
							</div>
							<div>
								<div class="member-name">${member.memberNickname}</div>
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
								<path d="M784-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l252 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T380-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400Z" /></svg>
						</button>
					</div>

					<div id="msgArea">
						<c:forEach var="chat" items="${chatList}">
							<div class="message ${chat.memberNo == sessionScope.loginMember.memberNo ? 'self' : ''}">
							    <div class="profile-img">
							        <img src="${chat.profilePath}${chat.profileName}" alt="Profile Image">
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
						<!-- 자동응답 아이콘과 팝업 -->
						<c:if test="${sessionScope.loginMember.memberType ne 4 and sessionScope.loginMember.memberType ne 5 and sessionScope.loginMember.memberType ne 6 and not empty autoResList}"> 
						    <div id="autoResponseContainer" style="position: relative; margin-right: 10px;">
							    <button id="autoResponseIcon" style="background: none; border: none; cursor: pointer;">
							        <img src="/resources/images/icon_chat.png" alt="자동응답" style="width: 30px; height: 30px;">
							    </button>
							    
							    <div id="autoResponsePopup">
							        <ul>
							            <c:forEach var="response" items="${autoResList}">
							                <li class="auto-response-item" 
							                    data-response-content="${response.responseContent}" 
							                    data-expert-member-no="${response.expertMemberNo}"
							                    data-expert-nickname="${response.expertNickname}">
							                    ${response.triggerWord}
							                </li>
							            </c:forEach>
							        </ul>
							    </div>
							</div>
						</c:if>
						
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
        var memberNickname = '${sessionScope.loginMember.memberNickname}';
        var roomId = '${roomId}';

        let fn = {
            init : function () {
                ws = new WebSocket("ws://192.168.10.52/chat/doChat.exco"); // 해당 PC IP로 변경할 것.
                ws.onopen = function() {
                    var msg = { type: "connect", memberNo: memberNo };
                    ws.send(JSON.stringify(msg));
                };
                
                
                ws.onmessage = function(e) {
                    var msgData = JSON.parse(e.data); 
                    
                    const memberNo = msgData.memberNo;
                    const memberNickname = msgData.memberNickname; // 발신자 닉네임
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
                                '<div class="member-id">' + memberNickname + '</div>' +
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
                
                $("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
            },
            
            //자동응답 SocketHandler로 전달
            sendAutoResponseAsExpert: function (responseContent, expertMemberNo, expertNickname, triggerWord) {
            	// 질문자의 질문 메시지 먼저 서버로 전송
            	const questionData  = {
                	type: "chat", // 질문 타입
                    roomId: roomId,
                    memberNo: memberNo, // 질문자 ID
                    msg: triggerWord, // 질문 내용
                    memberNickname: memberNickname // 질문자 닉네임
                };
                // WebSocket으로 메시지 전송
                ws.send(JSON.stringify(questionData));
                
           	    // 전문가 답변 메시지 서버로 전송
                const answerData = {
                    type: "autoResponse", // 자동응답 타입
                    roomId: roomId,       // 채팅방 ID
                    memberNo: expertMemberNo, // 전문가 ID
                    msg: responseContent, // 답변 내용
                    memberNickname: expertNickname // 전문가 닉네임
                };
                ws.send(JSON.stringify(answerData));
            },
            
       	  // 자동응답 팝업 열고 닫기
            toggleAutoResponsePopup: function () {
                $("#autoResponsePopup").toggle(); // 팝업 열고 닫기
            },

            // 팝업 외부 클릭 시 닫기
            closeAutoResponsePopup: function (e) {
                if (!$(e.target).closest("#autoResponseContainer").length) {
                    $("#autoResponsePopup").hide();
                }
            },

            // 자동응답 리스트 항목 클릭 시 입력창에 답변 추가
            selectAutoResponse: function (responseContent) {
                $("#chatMsg").val(responseContent); // 답변 입력창에 추가
                $("#autoResponsePopup").hide(); // 팝업 닫기
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
                sendObj.memberNickname = memberNickname;
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

			        // 문서 전체 클릭 이벤트 추가 (검색창 바깥을 클릭하면 닫힘)
			        document.addEventListener("click", fn.closeSearchOnClickOutside);
			    } else {
			        searchInput.style.display = "none";
			        searchInput.value = "";
			        fn.clearSearchHighlight(); // 기존 검색 강조 해제

			        // 문서 클릭 감지 이벤트 제거
			        document.removeEventListener("click", fn.closeSearchOnClickOutside);
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
			},

			closeSearchOnClickOutside: function (event) {
			    const searchContainer = document.getElementById("searchContainer");
			    const searchInput = document.getElementById("searchMsg");

			    if (!searchContainer.contains(event.target) && event.target !== searchInput) {
			        searchInput.style.display = "none";
			        searchInput.value = "";
			        fn.clearSearchHighlight(); // 기존 검색 강조 해제

			        // 문서 클릭 감지 이벤트 제거
			        document.removeEventListener("click", fn.closeSearchOnClickOutside);
			    }
			}

        };
        
    	 // 팝업 열기/닫기 이벤트
        $(document).ready(function () {
            $("#autoResponseIcon").on("click", fn.toggleAutoResponsePopup);

            // 팝업 외부 클릭 시 닫기
            $(document).on("click", fn.closeAutoResponsePopup);

            // 자동응답 리스트 항목 클릭 시 이벤트 연결
            $(".auto-response-item").on("click", function () {
            	const responseContent = $(this).data("response-content"); // 답변 내용
                const expertMemberNo = $(this).data("expert-member-no"); // 전문가 ID
                const expertNickname = $(this).data("expert-nickname"); // 전문가 닉네임
                const triggerWord = $(this).text(); // 질문 내용 (triggerWord)

                // 전문가 메시지를 WebSocket으로 전송
                fn.sendAutoResponseAsExpert(responseContent, expertMemberNo, expertNickname, triggerWord);
            });
        });

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