<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 800px;
	margin: 50px auto;
	padding: 20px;
}


.toggle-section {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 50px;
	padding: 10px;
	border: 3px solid #ddd;
	border-radius: 15px;
}

.toggle-section label {
	font-size: 16px;
	font-weight: bold;
	color: #333;
}

.response-list ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.response-list li {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px;
	margin-bottom: 10px;
	border: 3px solid #ddd;
	border-radius: 15px;
	background-color: #f7f7f7;
	cursor: pointer;
	transition: background-color 0.3s;
}

.response-list li:hover {
	background-color: #eaeaea;
}

.response-list span {
	font-size: 16px;
	font-weight: bold;
	color: #555;
}

.modal {
	display: none; /* 숨김 상태 */
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	justify-content: center;
	align-items: center;
	z-index: 1000;
}

.modal-content {
	background: white;
	padding: 20px;
	border-radius: 8px;
	width: 90%; /* 화면의 90% 너비 */
    max-width: 500px; /* 최대 너비 */
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
	text-align: center;
}

.modal-content textarea {
	width: 100%;
	height: 100px;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ddd;
	border-radius: 4px;
	resize: none;
	box-sizing: border-box;
}

.modal-content button {
	padding: 10px 20px;
	margin: 5px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	font-size: 14px;
	cursor: pointer;
}

.modal-content button.close {
	background-color: #ff4d4d;
}

/* 토글 스위치 스타일 추가 */
.toggle-switch {
    position: relative;
    width: 50px;
    height: 25px;
    background-color: #ddd;
    border-radius: 15px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.toggle-switch input {
    display: none; /* 기본 체크박스 숨김 */
}

.toggle-switch .slider {
    position: absolute;
    top: 3px;
    left: 3px;
    width: 20px;
    height: 20px;
    background-color: white;
    border-radius: 50%;
    transition: transform 0.3s;
}

/* 체크 상태에서의 스타일 */
.toggle-switch input:checked + .slider {
    transform: translateX(25px); /* 슬라이더 오른쪽 이동 */
}

.toggle-switch input:checked ~ .slider {
    background-color: white;
}

/* 체크 상태에서의 배경색 */
.toggle-switch input:checked {
    background-color: #4caf50;
}


</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<main class="content">
			<div class="container">

				<section class="toggle-section">
				    <label for="auto-response-toggle">자동응답</label>
				    <div class="toggle-switch">
					    <input type="checkbox" id="auto-response-toggle">
					    <label for="auto-response-toggle" class="slider"></label>
					</div>
				</section>

				<section class="response-list">
					<ul>
						<li data-question="안녕하세요, 진행 방식은 어떻게 되나요?"><span>안녕하세요,
								진행 방식은 어떻게 되나요?</span></li>
						<li data-question="안녕하세요, 언제 가능할까요?"><span>안녕하세요, 언제
								가능할까요?</span></li>
						<li data-question="전화 상담 언제 가능하실까요?"><span>전화 상담 언제
								가능하실까요?</span></li>
						<li data-question="제 요청과 비슷한 경험이 있으실까요?"><span>제 요청과
								비슷한 경험이 있으실까요?</span></li>
					</ul>
				</section>
				<div class="addList">
					<button>질문 추가</button>
				</div>

				<div class="modal" id="response-modal">
					<div class="modal-content">
						<textarea id="modal-textarea" placeholder="답변을 입력해주세요."></textarea>
						<button class="save">저장</button>
						<button class="close">닫기</button>
					</div>
				</div>
			</div>
		</main>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

	<script>
    // 모달 열기
    document.querySelectorAll('.response-list li').forEach(item => {
        item.addEventListener('click', function () {
            const question = this.dataset.question;
            document.getElementById('modal-textarea').value = question;
            document.getElementById('response-modal').style.display = 'flex';
        });
    });

    // 모달 닫기
    document.querySelector('.modal .close').addEventListener('click', function () {
        document.getElementById('response-modal').style.display = 'none';
    });

    // 저장 버튼 동작
    document.querySelector('.modal .save').addEventListener('click', function () {
        const response = document.getElementById('modal-textarea').value;
        console.log(`저장된 답변: ${response}`);
        document.getElementById('response-modal').style.display = 'none';
    });
    
    // 토글 상태 변경 이벤트
    document.querySelectorAll('.toggle-switch').forEach(toggle => {
        const checkbox = toggle.querySelector('input[type="checkbox"]');
        const slider = toggle.querySelector('.slider');

        // 토글 상태 변경 시 이벤트 처리
        checkbox.addEventListener('change', function () {
            if (this.checked) {
                toggle.style.backgroundColor = '#4caf50'; // 활성화 색상
            } else {
                toggle.style.backgroundColor = '#ddd'; // 비활성화 색상
            }
        });

        // 초기화 (페이지 로드 시)
        if (checkbox.checked) {
            toggle.style.backgroundColor = '#4caf50'; // 활성화 색상
        } else {
            toggle.style.backgroundColor = '#ddd'; // 비활성화 색상
        }
    });
</script>


</body>
</html>