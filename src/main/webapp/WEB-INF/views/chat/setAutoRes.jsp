<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자동응답 설정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f9f9f9;
}

.container {
	max-width: 800px;
	margin: 50px auto;
	padding: 20px;
	background-color: white;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.toggle-section {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
	padding: 10px;
	border: 3px solid #beeac5;
	border-radius: 15px;
	background-color: #f5fff5;
}

.toggle-section label {
	font-size: 16px;
	font-weight: bold;
	color: #34805C;
}

/* 토글 스위치 */
.toggle-switch {
	position: relative;
	width: 60px;
	height: 30px;
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
	width: 24px;
	height: 24px;
	background-color: white;
	border-radius: 50%;
	transition: transform 0.3s;
}

/* 체크 상태에서의 스타일 */
.toggle-switch input:checked+.slider {
	transform: translateX(30px); /* 슬라이더 오른쪽 이동 */
}

.toggle-switch input:checked ~ .slider {
	background-color: #34805C; /* 활성화 색상 */
}

.disabled {
	pointer-events: none;
	opacity: 0.5;
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
	border: 3px solid #beeac5;
	border-radius: 15px;
	background-color: #f7f7f7;
	cursor: pointer;
	transition: background-color 0.3s;
}

.response-list li:hover {
	background-color: #e0f5e0;
}

.response-list span {
	font-size: 16px;
	font-weight: bold;
	color: #555;
}

.addList {
	text-align: right;
	margin: 20px 0;
}

.addList button {
	padding: 10px 20px;
	background-color: #34805C;
	color: white;
	border: 1px solid #34805C;
	border-radius: 10px;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
	transition: all 0.3s;
}

.addList button:hover {
	background-color: #276e4b;
	color: white;
}

.modal {
	display: none;
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
	border-radius: 15px;
	width: 90%;
	max-width: 500px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
	text-align: center;
}

.modal-content textarea {
	width: 100%;
	height: 100px;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #beeac5;
	border-radius: 8px;
	resize: none;
	box-sizing: border-box;
}

.modal-content button {
	padding: 10px 20px;
	margin: 5px;
	background-color: #34805C;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.modal-content button.close {
	background-color: #ff4d4d;
}

.modal-content #save-response-btn:hover {
	background-color: #276e4b;
}

.modal-content .close:hover {
	background-color: #fc3535;
}

.delete-response-btn {
    background: none;
	border: none;
	font-size: 18px;
	color: #999;
	cursor: pointer;
}

</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<main class="content">
			<div class="container">
				<!-- 자동응답 토글 -->
				<div class="toggle-section">
					<label for="auto-response-toggle">자동응답</label>
					<div class="toggle-switch">
						<input type="checkbox" id="auto-response-toggle"
							${isActive == 'Y' ? 'checked' : ''}> <label
							for="auto-response-toggle" class="slider"></label>
					</div>
				</div>

				<!-- 자동응답 관리 섹션 -->
				<div id="response-section" class="disabled">
					<section class="response-list">
						<ul id="response-list">
							<c:forEach var="response" items="${autoResList}">
								<li data-response-no="${response.responseNo}"
									data-response-question="${response.triggerWord}"
									data-response-answer="${response.responseContent}"><span>${response.triggerWord}</span>
									<button class="delete-response-btn" data-response-no="${response.responseNo}">X</button>
								</li>
							</c:forEach>
						</ul>
					</section>
					<div class="addList">
						<button id="add-question-btn">질문 추가</button>
					</div>
				</div>

				<!-- 모달 -->
				<div class="modal" id="response-modal">
					<div class="modal-content">
						<p>질문</p>
						<textarea id="modal-question" placeholder="질문을 입력해주세요."></textarea>
						<p>답변</p>
						<textarea id="modal-answer" placeholder="답변을 입력해주세요."></textarea>
						<button id="save-response-btn" class="save">저장</button>
						<button class="close">닫기</button>
					</div>
				</div>
			</div>
		</main>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

	<script>
		$(document).ready(function() {
			const isChecked = $('#auto-response-toggle').is(':checked');
			const responseSection = $('#response-section');

			// 페이지 로드 시 초기 상태 설정
			if (isChecked) {
				responseSection.removeClass('disabled');
			} else {
				responseSection.addClass('disabled');
			}

			// 토글 상태 변경에 따라 활성화/비활성화 처리
			$('#auto-response-toggle').on('change', function() {
				const isChecked = $(this).is(':checked');
				if (isChecked) {
					responseSection.removeClass('disabled');
				} else {
					responseSection.addClass('disabled');
				}

				// 상태 업데이트 AJAX 호출
				$.ajax({
					url : '/autoRes/autoResUpdateState.exco',
					type : 'POST',
					data : {
						state : isChecked ? 'Y' : 'N'
					},
					success : function(data) {
						if (!data.success) {
						}
					},
					error : function() {
						alert('서버 요청 중 오류가 발생했습니다.');
					}
				});
			});

			// 질문 추가 모달 열기
			$('#add-question-btn').on('click', function() {
				$('#modal-question').val('');
				$('#modal-answer').val('');
				$('#response-modal').css('display', 'flex');
			});

			// 질문 클릭 시 편집 모달 열기
			$('#response-list').on('click', 'li', function() {
				
				// 삭제 버튼 클릭 시는 상세창 안 뜨게 하기
		        if ($(event.target).hasClass('delete-response-btn')) {
		            return;
		        }
				
				const question = $(this).data('response-question');
				const answer = $(this).data('response-answer');

				$('#modal-question').val(question);
				$('#modal-answer').val(answer);
				$('#response-modal').css('display', 'flex');
			});

			// 모달 닫기
			$('.close').on('click', function() {
				$('#response-modal').css('display', 'none');
			});

			// 질문과 답변 저장
			$('#save-response-btn').on('click', function() {
				const triggerWord = $('#modal-question').val(); // 질문
				const responseContent = $('#modal-answer').val(); // 답변

				if (!triggerWord.trim() || !responseContent.trim()) {
					alert('질문과 답변을 모두 입력해주세요.');
					return;
				}
				
				console.log('전송 데이터:', {
			        triggerWord: triggerWord,
			        responseContent: responseContent
			    });

				$.ajax({
				    url: '/autoRes/autoResSave.exco',
				    type: 'POST',
				    data: {
				    	triggerWord: triggerWord,
				    	responseContent: responseContent
				    },
				    success: function(data) {
				        if (data.success) {
				            alert('질문과 답변이 성공적으로 저장되었습니다!');
				            location.reload();
				        } else {
				            alert(data.message || '저장에 실패했습니다.');
				        }
				    },
				    error: function(xhr, status, error) {
				        alert('서버 요청 중 오류가 발생했습니다.');
				        console.error('Error:', error);
				    }
				});

				$('#response-modal').css('display', 'none');
			});
		});

		$('#auto-response-toggle').on('change', function() {
			const isChecked = $(this).is(':checked');
			const responseSection = $('#response-section');

			if (isChecked) {
				responseSection.removeClass('disabled');
			} else {
				responseSection.addClass('disabled');
			}

			// 상태 업데이트 AJAX 호출
			$.ajax({
				url : '/autoRes/autoResUpdateState.exco',
				type : 'POST',
				data : {
					state : isChecked ? 'Y' : 'N'
				},
				success : function(data) {
					if (data.success) {
			            console.log('자동응답 상태가 성공적으로 저장되었습니다.');
			        }
				},
				error : function() {
					alert('서버 요청 중 오류가 발생했습니다.');
				}
			});
		});
		
		// 질문 삭제
		$('#response-list').on('click', '.delete-response-btn', function() {
		    const responseNo = $(this).data('response-no');

		    if (confirm('정말로 삭제하시겠습니까?')) {
		        $.ajax({
		            url: '/autoRes/autoResDelete.exco',
		            type: 'POST',
		            data: { responseNo: responseNo },
		            success: function(data) {
		                if (data.success) {
		                    alert('질문이 성공적으로 삭제되었습니다!');
		                    location.reload();
		                } else {
		                    alert(data.message || '질문 삭제에 실패했습니다.');
		                }
		            },
		            error: function(xhr, status, error) {
		                alert('서버 요청 중 오류가 발생했습니다.');
		                console.error('Error:', error);
		            }
		        });
		    }
		});
	</script>
</body>
</html>
