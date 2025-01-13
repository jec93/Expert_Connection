<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
	font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f9f9f9;
}

.wrap {
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* 화면 전체를 채움 */
}

main.content {
    flex: 1; /* 남은 공간을 차지하도록 설정 */
    display: flex;
    justify-content: center; /* 수평 가운데 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
}

.chatbot-container {
	width: 90%;
    max-width: 600px;
    height: 820px; /* 높이 조정 */
    background-color: #fff;
    border-radius: 20px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.chat-header {
	background-color: #34805C;
	color: #fff;
	padding: 15px 20px;
	font-size: 18px;
	font-weight: bold;
	text-align: center;
}

.chat-window {
	flex: 1;
	overflow-y: auto;
	padding: 20px;
	background-color: #f9f9f9;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.chat-bubble {
	padding: 12px 15px;
	border-radius: 15px;
	font-size: 15px;
	line-height: 1.6;
	max-width: 80%;
	display: inline-block;
	word-wrap: break-word;
}

.chat-bubble.bot {
	background-color: #beeac5;
	align-self: flex-start;
}

.chat-bubble.user {
	background-color: #34805C;
	color: #ffffff;
	align-self: flex-end;
}

.chat-footer {
	padding: 15px;
	background-color: #fff;
	border-top: 1px solid #ddd;
	display: flex;
	gap: 10px;
}

.chat-input {
	flex: 1;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 25px;
	font-size: 14px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.send-btn {
	background-color: #4caf50;
	color: #fff;
	border: none;
	padding: 10px 15px;
	border-radius: 50%;
	font-size: 18px;
	cursor: pointer;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<main class="content">
			<div class="chatbot-container">
				<div class="chat-header">챗봇</div>
				<div class="chat-window" id="chatWindow">
					<div class="chat-bubble bot">안녕하세요! 어떤 전문가를 찾으시나요? 원하는 분야를
						입력해주세요 (예: 피아노)</div>
				</div>
				<div class="chat-footer">
					<input type="text" id="chatInput" class="chat-input"
						placeholder="답변을 입력하세요...">
					<button id="sendBtn" class="send-btn">▶</button>
				</div>
				
				<!-- 전송용 폼 -->
                <form id="expertSearchForm" action="/expert/expertBotSearch.exco" method="get" style="display:none;">
                    <input type="hidden" name="keyword" id="categoryNm">
                    <input type="hidden" name="addr" id="addr">
                    <input type="submit">
                </form>
			</div>

		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

	<script>
        const chatWindow = document.getElementById("chatWindow");
        const chatInput = document.getElementById("chatInput");
        const sendBtn = document.getElementById("sendBtn");

        let step = 0; // 질문 단계
        let userData = {
            categoryName: '',
            addr: '',
            age: '',
            gender: ''
        };

        const botResponses = [
            "소분류 이름을 입력해주세요 (예: 피아노)",
            "원하는 지역을 입력해주세요 (예: 서울)",
            "당신의 나이를 입력해주세요 (예: 26살)",
            "당신의 성별을 입력해주세요 (예: 남자, 여자)",
            "모든 정보가 입력되었습니다. 전문가를 검색합니다..."
        ];

        sendBtn.addEventListener("click", handleUserInput);
        chatInput.addEventListener("keyup", (event) => {
            if (event.key === "Enter") {
                handleUserInput();
            }
        });
        
        function handleUserInput() {
            const userInput = chatInput.value.trim();
            if (!userInput) return;

            // 사용자 답변을 화면에 추가
            addChatBubble(userInput, "user");

            // 데이터 저장 및 다음 단계로 이동
            if (step === 0) {
                userData.categoryName = userInput;
                nextStep();
            } else if (step === 1) {
                userData.addr = userInput;
                nextStep();
            } else if (step === 2) {
                userData.age = userInput;
                nextStep();
            } else if (step === 3) {
                userData.gender = userInput;
                nextStep();
                // 데이터 전송
                 submitForm(); // 폼 제출
            }
        }

        function addChatBubble(text, sender) {
        	const bubble = document.createElement("div");
            bubble.classList.add("chat-bubble"); 
            bubble.classList.add(sender);
            bubble.textContent = text;
            document.getElementById("chatWindow").appendChild(bubble);
            document.getElementById("chatWindow").scrollTop = document.getElementById("chatWindow").scrollHeight;
        }

        function nextStep() {
            step++;
            if (step < botResponses.length) {
                addChatBubble(botResponses[step], "bot");
            }
            chatInput.value = "";
        }

        function submitForm() {
            // 폼의 입력 필드에 사용자 데이터를 설정
            document.getElementById("categoryNm").value = userData.categoryName;
            document.getElementById("addr").value = userData.addr;
            document.getElementById("expertSearchForm").submit();
        }
    </script>
</body>
</html>
