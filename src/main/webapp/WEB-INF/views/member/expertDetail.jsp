<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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

.update-btn, .save-btn {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 8px 12px;
    margin-top: 10px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
}

.update-btn:hover {
    background-color: #0056b3;
}

.save-btn {
    background-color: #28a745;
    display: none;
}

.save-btn:hover {
    background-color: #218838;
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
					<c:choose>
						<c:when test="${not empty loginMember}">
					        <button onclick="createOneRoom('${expertDetail.memberNo}','${expertDetail.expertNickname}')">채팅</button>
					    </c:when>
					</c:choose>
				</div>
			</div>
			<div class="like-review">
				<div class="like">
					❤️ 좋아요 수: <span>${expertDetail.expertLike}</span>
				</div>
				<div class="review">
					⭐ 리뷰: <span>4.8 / 5.0</span>
				</div>
			</div>
			<div class="tabs">
				<button class="active" data-tab="info-tab" onclick="showTab('info-tab')">정보</button>
				<button data-tab="portfolio-tab" onclick="showTab('portfolio-tab')">포트폴리오</button>
			</div>
			
			<!-- 정보탭 -->
			<div id="info-tab" class="tab-content active">
			    <h2 id="info-title">${expertDetail.introduceTitle}</h2>
			    <input type="text" id="info-title-edit" value="${expertDetail.introduceTitle}" style="display:none; width:100%;" />
			    
			    <br>
			    
			    <div class="details">
			        <p id="info-content">${expertDetail.introduceContent}</p>
			        <textarea id="info-content-edit" style="display:none; width:100%;" rows="4">${expertDetail.introduceContent}</textarea>
			    </div>
			
			    <c:if test="${not empty loginMember and loginMember.memberNo == expertDetail.memberNo}">
			        <button class="update-btn" id="info-edit-btn" onclick="enableEdit('info')">정보 업데이트</button>
			        <button class="save-btn" id="info-save-btn" onclick="saveChanges('info')" style="display:none;">저장</button>
			    </c:if>
			</div>
			
			<!-- 포트폴리오 -->
			<div id="portfolio-tab" class="tab-content">
			    <h2>포트폴리오</h2>
			    
			    <p id="portfolio-content">${expertDetail.expertFileName}</p>
			    <textarea id="portfolio-edit" style="display:none; width:100%;" rows="4">${expertDetail.expertFileName}</textarea>
			    
			    <p id="portfolio-path">${expertDetail.expertFilePath}</p>
   			    <input type="text" id="portfolio-path-edit" value="${expertDetail.expertFilePath}" style="display:none; width:100%;" />
			
				<!-- 파일 업로드 추가 -->
				<input type="file" id="portfolio-file" style="display:none;" accept="image/*,.pdf,.ppt,.pptx" onchange="previewFile()"/>
				<p id="file-name-display" style="display:none;"></p> <!-- 업로드한 파일명 표시 -->
				<button id="file-upload-btn" style="display:none;" onclick="uploadFile()">파일 업로드</button> <!-- 파일 업로드 버튼 -->
				
			    <c:if test="${not empty loginMember and loginMember.memberNo == expertDetail.memberNo}">
			        <button class="update-btn" id="portfolio-edit-btn" onclick="enableEdit('portfolio')">포트폴리오 업데이트</button>
			        <button class="save-btn" id="portfolio-save-btn" onclick="saveChanges('portfolio')" style="display:none;">저장</button>
			    </c:if>
			</div>
			
		</div>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		
	</div>

	<script>
	//채팅 버튼 눌렀을 때 해당 전문가랑 채팅방 생성
	function createOneRoom(sellerNo, sellerName) { // 전문가 상세페이지의 전문가 번호
	    // 1. 채팅방 존재 여부 확인
	    $.ajax({
	        url: '/chat/checkChatRoom.exco', // 채팅방 존재 여부 확인 요청 URL
	        type: 'GET',
	        data: { sellerNo: sellerNo },
	        dataType: 'json', // JSON 형식의 데이터 수신
	        success: function (checkResponse) {
	            if (checkResponse=="0") {
	            	//채팅방이 없으면 결제 요청 및 채팅방 생성
	                proceedToCreateChatRoom(sellerNo, sellerName);
	            } else {
	                // 채팅방이 이미 존재하면 바로 이동
	                alert('이미 채팅방이 존재합니다.');
	                window.location.href = "/chat/getChatList.exco?roomId=" + checkResponse;
	            }
	        },
	        error: function () {
	            alert('채팅방 확인 중 오류가 발생했습니다.');
	        }
	    });
	}

	// 채팅방이 없을 때 실행되는 함수
	function proceedToCreateChatRoom(sellerNo, sellerName) {
	    $.ajax({
	        url: '/payment/chatOrder.exco', // 주문번호 생성 요청 URL
	        type: 'GET',
	        data: {
	            sellerNo: sellerNo,
	            sellerName: sellerName
	        },
	        dataType: 'json', // JSON 형식의 데이터 수신
	        success: function (orderData) {
	            if (orderData && orderData.orderNo) {
	                let prodName = orderData.sellerName + "님과 매칭서비스";
	                let customerName = orderData.customerName;
	                let customerEmail = orderData.customerEmail;
	                let totalAmount = orderData.totalAmount;
	                let customerNo = orderData.customerNo;
	
	                // 아임포트 결제 요청
	                IMP.request_pay({
	                    pg: "kcp.AO09C", // 상점 ID
	                    pay_method: "card", // 결제 구분
	                    merchant_uid: orderData.orderNo, // 서버에서 받은 주문번호
	                    name: prodName, // 상품 이름
	                    amount: totalAmount, // 총 금액
	                    buyer_email: customerEmail, // 구매자 메일
	                    buyer_name: customerName // 구매자 이름
	                }, function (resInfo) {
	                    if (resInfo.success) {
	                        // 결제 성공 시 서버에 결제 결과 전송
	                        let orderPayload = {
	                            impUid: resInfo.imp_uid,
	                            orderNo: resInfo.merchant_uid,
	                            tid: resInfo.pg_tid,
	                            authDate: resInfo.paid_at,
	                            prodName: prodName,
	                            totalAmount: totalAmount,
	                            customerEmail: customerEmail,
	                            customerName: customerName,
	                            customerNo: customerNo
	                        };
	
	                        $.ajax({
	                            url: '/payment/chatPay.exco',
	                            type: 'post',
	                            contentType: 'application/json',
	                            data: JSON.stringify(orderPayload),
	                            success: function (res) {
	                                if (res == '1') {
	                                    alert('결제 및 주문 저장 성공');
	                                    const roomName = "1:1 Chat with " + sellerName;
	
	                                    // 채팅방 생성 요청
	                                    $.ajax({
	                                        url: '/chat/goChat.exco',
	                                        method: 'GET',
	                                        data: {
	                                            roomName: roomName,
	                                            members: sellerNo
	                                        },
	                                        success: function (roomId) {
	                                            window.location.href = "/chat/getChatList.exco?roomId=" + roomId;
	                                        },
	                                        error: function () {
	                                            alert('1:1 채팅방 생성에 실패했습니다.');
	                                        }
	                                    });
	                                } else {
	                                    alert('주문 저장 실패');
	                                }
	                            },
	                            error: function () {
	                                alert('서버와 통신 오류');
	                            }
	                        });
	                    } else {
	                        // 결제 실패 처리
	                        alert('결제에 실패하였습니다. 에러 내용 :' + resInfo.error_msg);
	                    }
	                });
	            } else {
	                alert('주문번호 생성에 실패했습니다.');
	            }
	        },
	        error: function () {
	            alert('서버 통신 중 오류가 발생했습니다.');
	        }
	    });
	}
	
	// 초기화
	$(function () {
	    // 아임포트 가맹점 식별 코드 설정
	    IMP.init("imp87933196");
	});
	// 해당 탭(정보, 포트폴리오)으로 이동
	function showTab(tabId) {
	    document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
	    document.getElementById(tabId).classList.add('active');
	    document.querySelectorAll('.tabs button').forEach(btn => btn.classList.remove('active'));
	    document.querySelector(`[data-tab="${tabId}"]`).classList.add('active');
	}
	
	
	// 업데이트 버튼을 누르면 입력 필드를 활성화
	function enableEdit(type) {
	    console.log("enableEdit 실행됨, type:", type);  // 디버깅 로그 추가 ✅

	    if (type === "info") {
	        // 정보 수정: 제목, 내용 활성화
	        document.getElementById("info-title").style.display = "none";
	        document.getElementById("info-title-edit").style.display = "block";

	        document.getElementById("info-content").style.display = "none";
	        document.getElementById("info-content-edit").style.display = "block";
	    } 
	    else if (type === "portfolio") {
	        // 포트폴리오 수정: 파일명, 파일경로 활성화
	        document.getElementById("portfolio-content").style.display = "none";
	        document.getElementById("portfolio-edit").style.display = "block";

	        document.getElementById("portfolio-path").style.display = "none";
	        document.getElementById("portfolio-path-edit").style.display = "block";
	        
	        // 파일 업로드 UI 표시
	        document.getElementById("portfolio-file").style.display = "block";
	        document.getElementById("file-name-display").style.display = "block";
	    }

	    // 버튼 변경
	    document.getElementById(type + "-edit-btn").style.display = "none";
	    document.getElementById(type + "-save-btn").style.display = "inline-block";
	}
	
	//파일 업로드 미리보기
	function previewFile() {
	    let fileInput = document.getElementById("portfolio-file");
	    let fileNameDisplay = document.getElementById("file-name-display");
	    let uploadBtn = document.getElementById("file-upload-btn");

	    if (fileInput.files.length > 0) {
	        let file = fileInput.files[0];
	        fileNameDisplay.innerText = "선택한 파일: " + file.name;
	        fileNameDisplay.style.display = "block";
	        uploadBtn.style.display = "inline-block";  // 파일 업로드 버튼 표시
	    } else {
	        fileNameDisplay.innerText = "";
	        uploadBtn.style.display = "none";
	    }
	}

	// 정보 업데이트 - 저장 버튼을 누르면 AJAX 요청을 통해 제목과 내용 동시 업데이트
	function saveChanges(type) {
	    let formData = new FormData();
	    let requestUrl = ""; // 요청할 URL 저장
	
	    // 정보 수정일 경우
	    if (type === "info") {
	        formData.append("title", document.getElementById("info-title-edit").value);
	        formData.append("content", document.getElementById("info-content-edit").value);
	        
	        requestUrl = "/expert/expertUpdateContent.exco"; // 🔹 정보 업데이트 요청 URL
	    } 
	    // 포트폴리오 수정일 경우
	    else if (type === "portfolio") {
	        formData.append("fileName", document.getElementById("portfolio-edit").value);
	        formData.append("filePath", document.getElementById("portfolio-path-edit").value);
	        
	    	// 🔹 파일도 함께 전송
	        let fileInput = document.getElementById("portfolio-file");
	        if (fileInput.files.length > 0) {
	            formData.append("file", fileInput.files[0]);
	        }
	        
	        requestUrl = "/expert/expertUpdatePortfolio.exco"; // 🔹 포트폴리오 업데이트 요청 URL
	    }
	
	    $.ajax({
	        url: requestUrl, // 요청 URL을 type에 따라 설정
	        type: 'POST',
	        data: formData,
	        processData: false,
	        contentType: false,
	        success: function(response) {
	            console.log("서버 응답:", response);
	            if (response === "success") {
	                if (type === "info") {
	                    document.getElementById("info-title").innerText = formData.get("title");
	                    document.getElementById("info-content").innerText = formData.get("content");
	
	                    document.getElementById("info-title").style.display = "block";
	                    document.getElementById("info-title-edit").style.display = "none";
	                    document.getElementById("info-content").style.display = "block";
	                    document.getElementById("info-content-edit").style.display = "none";
	                } 
	                else if (type === "portfolio") {
	                    document.getElementById("portfolio-content").innerText = formData.get("fileName");
	                    document.getElementById("portfolio-path").innerText = formData.get("filePath");
	
	                    document.getElementById("portfolio-content").style.display = "block";
	                    document.getElementById("portfolio-edit").style.display = "none";
	                    document.getElementById("portfolio-path").style.display = "block";
	                    document.getElementById("portfolio-path-edit").style.display = "none";
	                    
	                    document.getElementById("portfolio-file").style.display = "none";
	                    document.getElementById("file-name-display").style.display = "none";
	                }
	
	                document.getElementById(type + "-edit-btn").style.display = "inline-block";
	                document.getElementById(type + "-save-btn").style.display = "none";
	
	                alert("업데이트가 완료되었습니다!");
	                location.reload(); // 페이지 새로고침 (업데이트된 내용 반영)
	            } else {
	                alert("업데이트 실패: " + response);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.log("AJAX 오류:", xhr.responseText);
	            alert("서버 오류가 발생했습니다: " + xhr.responseText);
	        }
	    });
	}



	</script>
</body>
</html>
