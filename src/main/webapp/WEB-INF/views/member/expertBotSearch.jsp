<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>전문가 검색 챗봇</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .chatbot-container {
            width: 90%;
            max-width: 600px;
            height: 85%;
            background-color: #fff;
            border-radius: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .chat-header {
            background-color: #4caf50;
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

        .bot {
            background-color: #f0f0f0;
            align-self: flex-start;
        }

        .user {
            background-color: #d1ffd6;
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
		</main>
		
</div>
    <div class="chatbot-container">
        <div class="chat-header">챗봇</div>
        <div class="chat-window" id="chatWindow">
            <div class="chat-bubble bot">안녕하세요! 어떤 전문가를 찾으시나요? 원하는 분야를 입력해주세요.</div>
        </div>
        <div class="chat-footer">
            <input type="text" id="chatInput" class="chat-input" placeholder="답변을 입력하세요...">
            <button id="sendBtn" class="send-btn">▶</button>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </div>

    <script>
        const chatWindow = document.getElementById("chatWindow");
        const chatInput = document.getElementById("chatInput");
        const sendBtn = document.getElementById("sendBtn");

        let step = 0; // 질문 단계
        let userData = {
            categoryName: '',
            region: '',
            age: '',
            gender: ''
        };

        const botResponses = [
            "소분류 이름을 입력해주세요 (예: 멘탈 관리):",
            "원하는 지역을 입력해주세요 (예: 서울):",
            "당신의 나이를 입력해주세요:",
            "당신의 성별을 입력해주세요 (예: 남성, 여성):",
            "모든 정보가 입력되었습니다. 전문가를 검색합니다..."
        ];

        sendBtn.addEventListener("click", () => {
            const userInput = chatInput.value.trim();
            if (!userInput) return;

            // 사용자 답변을 화면에 추가
            addChatBubble(userInput, "user");

            // 데이터 저장 및 다음 단계로 이동
            if (step === 0) {
                userData.categoryName = userInput;
                nextStep();
            } else if (step === 1) {
                userData.region = userInput;
                nextStep();
            } else if (step === 2) {
                userData.age = userInput;
                nextStep();
            } else if (step === 3) {
                userData.gender = userInput;
                nextStep();
                // 데이터 전송
                sendDataToServer();
            }
        });

        function addChatBubble(text, sender) {
            const bubble = document.createElement("div");
            bubble.className = `chat-bubble ${sender}`;
            bubble.textContent = text;
            chatWindow.appendChild(bubble);
            chatWindow.scrollTop = chatWindow.scrollHeight;
        }

        function nextStep() {
            step++;
            if (step < botResponses.length) {
                addChatBubble(botResponses[step], "bot");
            }
            chatInput.value = "";
        }

        function sendDataToServer() {
            fetch('/expert/searchExperts', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(userData),
            })
            .then(response => response.json())
            .then(data => {
                // 검색 결과 표시
                if (data && data.length > 0) {
                    data.forEach(expert => {
                        addChatBubble(
                            `이름: ${expert.name}, 지역: ${expert.region}, 등급: ${expert.grade}, 분야: ${expert.categoryName}`,
                            "bot"
                        );
                    });
                } else {
                    addChatBubble("해당 조건에 맞는 전문가를 찾을 수 없습니다.", "bot");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                addChatBubble("오류가 발생했습니다. 다시 시도해주세요.", "bot");
            });
        }
    </script>
</body>
</html>
