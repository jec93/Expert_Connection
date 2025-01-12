<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
Object loginChk = session.getAttribute("loginMember");
boolean isLogin = loginChk != null;
%>
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

.like-review-container{
	display: flex;
	justify-content: center;
}

.intro-react>img {
	padding-top: 5px;
}
#intro-like {
	width: 50%;
}

#intro-dislike {
	width: 50%;
}

.profile-header {
    display: flex;
    align-items: center; /* 세로 중앙 정렬 */
    text-align: left; /* 텍스트 정렬 */
    gap: 30px; /* 이미지와 텍스트 사이 여백 */
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
    background-color: #34805C;
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
    color: #34805C; /* 활성화된 탭의 글자 색 변경 */
    border-bottom-color: #34805C; /* 활성화된 탭에 밑줄 추가 */
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
    background-color: #34805C;
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
    background-color: ##34805C;
    display: none;
}

.save-btn:hover {
    background-color: #218838;
}

/* 정보 및 포트폴리오 입력 박스 스타일 */
#info-title-edit, #info-content-edit,
#portfolio-edit, #portfolio-path-edit {
    width: 100%;
    padding: 10px;
    border: 2px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
    font-size: 16px;
    transition: border-color 0.3s ease-in-out;
    box-sizing: border-box;
}

/* 입력 상자 클릭 시 포커스 스타일 */
#info-title-edit:focus, #info-content-edit:focus,
#portfolio-edit:focus, #portfolio-path-edit:focus {
    border-color: #007bff;
    background-color: #fff;
    outline: none;
}

/* 포트폴리오 파일 선택 UI 스타일 */
#portfolio-file {
    display: block;
    margin-top: 10px;
}

/* 미리보기 컨테이너 스타일 */
#portfolio-preview {
    margin-top: 15px;
    padding: 10px;
    border-radius: 5px;
}

/* 파일 이름 표시 */
#file-name-display {
    margin-top: 10px;
    font-size: 14px;
    color: #333;
    font-weight: bold;
}

/* 업데이트 버튼 간격 조정 */
.update-btn, .save-btn {
    margin-top: 15px;
}

.review-content{
	border-bottom: 1px solid;
}
</style>

</head>
<body>
	<div class="wrap">
	
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<div class="content">
			<div class="profile-header">
				<c:choose>
					<c:when test="${not empty expertDetail.profilePath && not empty expertDetail.profileName}">
						<img src="${expertDetail.profilePath}${expertDetail.profileName}" class="profile-img">
					</c:when>
					<c:otherwise>
						<img src="/resources/logo/expert_connection_favicon.png" class="profile-img">
					</c:otherwise>
				</c:choose>
				<div class="profile-info">
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
		        <p>${expertDetail.thirdCategoryNm} 전문가 | ${expertDetail.expertAddr}</p>
		        <p>${expertDetail.introduceTitle}</p>
		        <div class="actions">
		            <button>찜</button>
		            <c:choose>
		                <c:when test="${not empty loginMember}">
		                    <button onclick="createOneRoom('${expertDetail.memberNo}','${expertDetail.expertNickname}')">채팅</button>
		                </c:when>
		            </c:choose>
		        </div>
		    </div>
		</div>
			
		<div class="like-review-container">
			<div>
				<span id="like-button" class="intro-react">
			        <a href='javascript:void(0)' id="introlike" onclick="introLike(this,'${expertDetail.introNo}','${expertDetail.memberNo}',1);">
			            <img src="/resources/images/board_like.png" id="intro-like">
			        </a>
			    </span>
			    <div id="introlikeCnt">${expertDetail.expertLike}</div>
			    <div>좋아요</div>
			</div>
			<div>
			    <span id="dislike-button" class="intro-react">
			        <a href='javascript:void(0)' id="introDislike" onclick="introLike(this, '${expertDetail.introNo}','${expertDetail.memberNo}',-1);">
			            <img src="/resources/images/board_dislike.png" id="intro-dislike">
			        </a>
			    </span>
			    <div id="introDislikeCnt">${expertDetail.expertDislike}</div>
			    <div>아쉬워요</div>
			</div>
		</div>
			
			<div class="tabs">
				<button class="active" data-tab="info-tab" onclick="showTab('info-tab')">정보</button>
				<button data-tab="portfolio-tab" onclick="showTab('portfolio-tab')">포트폴리오</button>
				<button data-tab="review-tab" onclick="showTab('review-tab')">리뷰</button>
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
			    
			    <p id="portfolio-path"></p>
   			    <input type="text" id="portfolio-path-edit" value="${expertDetail.expertFilePath}" style="display:none; width:100%;" />
			
				<!-- 파일 업로드 추가 -->
				<input type="file" id="portfolio-file" style="display:none;" accept="image/*,.pdf,.ppt,.pptx" onchange="previewFile()"/>
				<p id="file-name-display" style="display:none;"></p> <!-- 업로드한 파일명 표시 -->
				<button id="file-upload-btn" style="display:none;" onclick="uploadFile()">파일 업로드</button> <!-- 파일 업로드 버튼 -->
				
				<!-- 포트폴리오 미리보기 -->
				<div id="portfolio-preview">
				    <c:choose>
				        <c:when test="${not empty expertDetail.expertFilePath}">
				            <c:choose>
				                <c:when test='${fn:endsWith(expertDetail.expertFilePath, ".jpg") or fn:endsWith(expertDetail.expertFilePath, ".png") or fn:endsWith(expertDetail.expertFilePath, ".gif")}'>
				                    <img id="preview-image" src="${expertDetail.expertFilePath}" alt="포트폴리오 이미지" style="max-width:100%; height:auto;">
				                </c:when>
				
				                <c:when test='${fn:endsWith(expertDetail.expertFilePath, ".pdf")}'>
				                	<iframe id="preview-pdf" src="${expertDetail.expertFilePath}" type="application/pdf" width="80%" height=700px></iframe>
				                </c:when>
				
				                <c:otherwise>
				                    <a id="preview-file" href="${expertDetail.expertFilePath}" download>파일 다운로드</a>
				                </c:otherwise>
				            </c:choose>
				        </c:when>
				        <c:otherwise>
				            <p>업로드된 포트폴리오 파일이 없습니다.</p>
				        </c:otherwise>
				    </c:choose>
				</div>
				
				
			    <c:if test="${not empty loginMember and loginMember.memberNo == expertDetail.memberNo}">
			        <button class="update-btn" id="portfolio-edit-btn" onclick="enableEdit('portfolio')">포트폴리오 업데이트</button>
			        <button class="save-btn" id="portfolio-save-btn" onclick="saveChanges('portfolio')" style="display:none;">저장</button>
			    </c:if>
			</div>
			
			<%-- 리뷰 탭 --%>
			<div id="review-tab" class="tab-content">
					<div class="inputreviewBox">
						<form name="insertreview" action="/expert/insertReview">
							<input type="hidden" name="introNo" value="${expertDetail.introNo }"><%-- 현재 소개 번호 --%>
							<input type="hidden" name="writer" value="${loginMember.memberNo}"><%-- 현재 댓글 작성자(로그인한 회원) --%>
							<input type="hidden" name="memberNo" value="${expertDetail.memberNo }"><%-- 전문가 번호 --%>
						    <c:if test="${not empty loginMember }">
								<input type="radio" name="reviewScore" value="1">★<br>
								<input type="radio" name="reviewScore" value="2">★★<br>
								<input type="radio" name="reviewScore" value="3">★★★<br>
								<input type="radio" name="reviewScore" value="4">★★★★<br>
								<input type="radio" name="reviewScore" value="5">★★★★★<br>
								<ul class="review-write">
									<li>
										<div class="input-item">
											<textarea name="reviewContent"></textarea>
										</div>
									</li>
									<li>
										<button type="submit" class="btn-primary">등록</button>
									</li>
								</ul>
							</c:if>
						</form>
					</div>
				<c:forEach var="review" items="${expertDetail.reviewList}">
					<ul class="posting-review">
						<li>
							<div class="review-info">
								<div class="rev-info">
									<span id="reviewNickname">${review.nickname}</span>
									<span id="reviewScore">★ : ${review.reviewScore}</span>
								</div>
								<c:if test="${not empty loginMember}">
									<div class="updreview">
										<c:if test="${loginMember.memberNo eq review.writer}">
										<a href='javascript:void(0)' onclick="delReview('${review.reviewNo}');">삭제</a>
										</c:if>
									</div>
								</c:if>
							</div>
							<p class="review-content">${review.reviewContent}</p>
							<div class="input-item" style="display: none;">
								<textarea name="reviewContent">${review.reviewContent}</textarea>
							</div>
						</li>
					</ul>
				</c:forEach>
			</div>
		</div>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		
	</div>

	<script>
	$(document).ready(function() {
        $.ajax({
            url: "/expert/getIntroStatus.exco",
            type: "GET",
            data: {
                "introNo": "${expertDetail.introNo}",
                "memberNo": "${loginMember.memberNo}"
            },
            dataType: "json",
            success: function(response) {
            	console.log(response);
            	updateintroReaction(response.introReact); // 상태를 업데이트
            },
            error: function() {
                console.error(response.message);
            }
        });
    });
	
	function updateintroReaction(introReact) {
		if (introReact === "1") {
	        // 좋아요 활성화
	        $("#intro-like").attr("src", "/resources/images/board_like_chk.png");
	        $("#intro-dislike").attr("src", "/resources/images/board_dislike.png");
	    } else if (introReact === "-1") {
	        // 싫어요 활성화
	        $("#intro-like").attr("src", "/resources/images/board_like.png");
	        $("#intro-dislike").attr("src", "/resources/images/board_dislike_chk.png");
	    } else {
	        // 기본 상태
	        $("#intro-like").attr("src", "/resources/images/board_like.png");
	        $("#intro-dislike").attr("src", "/resources/images/board_dislike.png");
	    }
	}
	
	var chkLogin = <%= isLogin %>;
	
	//반응 반영,취소
	function introLike (obj, introNo,expertNo, like) {
		if(chkLogin){
		   $.ajax({
		      url : "/expert/updIntroLike.exco",
		      type : "GET",
		      data : {
		         "introNo" : introNo,
		         "memberNo" : "${loginMember.memberNo}",
		         "expertNo" : expertNo,
		         "like" : like
		         },
			  dataType: "json", 
		      success : function(response) {
			    if(response.reviewReact){
			    	updateintroReaction(response.introReact);				    	
			    }
		        if(response.message != "0"){
				  swal({
				      title : "알림",
				      text : response.message,
				      icon : "success"
				   }).then(function(){
					  	location.href = "/expert/viewExpertInfoByMemberNo.exco?memberNo=${expertDetail.memberNo}";
				   });
				}
		        else{
		           swal({
		              title : "알림",
		              text : "호감도 반영 중 오류가 발생하였습니다.",
		              icon : "error"
		           });
		        }
		     },
		    error : function() {
		       console.log("ajax 에러 발생");
		    }
		});
	  }else{
		  swal({
	            title: "로그인 필요",
	            text: "좋아요/아쉬워요를 반영하려면 로그인하세요.",
	            icon: "warning"
	        });
	  }
	}
	
	function delReview(reviewNo){
		swal({
			title : "삭제",
			text : "리뷰를 삭제하시겠습니까? (주의, 당신의 리뷰가 모두에게 도움이 될 수 있습니다)",
			icon : "warning",
			buttons: {
				cancel : {
					text: "취소",
					value:false,
					visible: true,
					closeModal : true
				},
				confirm:{
					text:"삭제",
					value:true,
					visible:true,
					closeModal:true
				}
			}
		}).then(function(isConfirm){
			if(isConfirm){
				location.href = '/expert/deleteReview.exco?&reviewNo='+reviewNo;
			}
		});
	}
	
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
		// 🔹 모든 탭 콘텐츠에서 active 클래스 제거
	    document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));

	    // 🔹 선택한 탭 콘텐츠에 active 클래스 추가
	    let selectedTabContent = document.getElementById(tabId);
	    if (selectedTabContent) {
	        selectedTabContent.classList.add('active');
	    } else {
	        console.error("탭 콘텐츠를 찾을 수 없습니다:", tabId);
	        return;
	    }

	    // 🔹 모든 탭 버튼에서 active 클래스 제거
	    document.querySelectorAll('.tabs button').forEach(btn => btn.classList.remove('active'));

	    // 🔹 클릭한 버튼에 active 클래스 추가
	    var selectedButton = document.querySelector('.tabs button[data-tab="' + tabId + '"]');
	    if (selectedButton) {
	        selectedButton.classList.add('active');
	    } else {
	        console.error("탭 버튼을 찾을 수 없습니다: " + tabId);
	    }
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
	


	// 정보 업데이트 - 저장 버튼을 누르면 AJAX 요청을 통해 제목과 내용 동시 업데이트
	function saveChanges(type) {
     	console.log("saveChanges 실행됨, type:", type);
		
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
	        
	    	// 파일도 함께 전송
	        let fileInput = document.getElementById("portfolio-file");
	        if (fileInput.files.length > 0) {
	            formData.append("file", fileInput.files[0]);
	        }
	        
	   	     // memberNo 추가 (로그인된 사용자)
	        formData.append("memberNo", "${expertDetail.memberNo}");
	   	     
	        requestUrl = "/expert/expertUpdatePortfolio.exco"; // 포트폴리오 업데이트 요청 URL
	    }
	
	    console.log("AJAX 요청 시작:", requestUrl);
	    
	    $.ajax({
	        url: requestUrl, // 요청 URL을 type에 따라 설정
	        type: 'POST',
	        data: formData,
	        processData: false,
	        contentType: false,
	        success: function(response) {
	            console.log("서버 응답:", response);
	            
	            if (response.status === "success") {
	                if (type === "info") {
	                    document.getElementById("info-title").innerText = formData.get("title");
	                    document.getElementById("info-content").innerText = formData.get("content");
	
	                    document.getElementById("info-title").style.display = "block";
	                    document.getElementById("info-title-edit").style.display = "none";
	                    document.getElementById("info-content").style.display = "block";
	                    document.getElementById("info-content-edit").style.display = "none";
	                } 
	                else if (type === "portfolio") {
	                	console.log("response.fileUrl : ", response.fileUrl)
	                	 // 새 이미지 URL 업데이트
	                    document.getElementById("portfolio-path").innerText = response.fileUrl;
	                    document.getElementById("portfolio-content").innerText = response.fileName;
	                    document.getElementById("portfolio-path-edit").value = response.fileUrl;
	
	                    let previewContainer = document.getElementById("portfolio-preview");
	                    let fileExt = response.fileUrl.split('.').pop().toLowerCase();

	                    previewContainer.innerHTML = "";
	                    
	                    if (["jpg", "png", "gif"].includes(fileExt)) {
	                    	previewContainer.innerHTML = "<img src=\"" + response.fileUrl + "\" style=\"max-width:100%; height:auto;\">";
	                    } else if (fileExt === "pdf") {
	                        previewContainer.innerHTML = "<iframe src=\"" + response.fileUrl + "\" type=\"application/pdf\" width=\"100%\" height=\"500px\"></iframe>";
	                    } else {
	                        previewContainer.innerHTML = "<a href=\"" + response.fileUrl + "\" download>파일 다운로드</a>";
	                    }
	                    
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
	                
	            } else {
	                alert("업데이트 실패: " + JSON.stringify(response));
	            }
	        },
	        error: function(xhr, status, error) {
	            console.log("AJAX 오류:", xhr.responseText);
	            alert("서버 오류가 발생했습니다: " + xhr.responseText);
	        }
	    });
	}
	
	function previewFile() {
	    let fileInput = document.getElementById("portfolio-file");
	    let fileNameDisplay = document.getElementById("file-name-display");
	    let previewContainer = document.getElementById("portfolio-preview");

	    if (fileInput.files.length > 0) {
	        let file = fileInput.files[0];
	        let fileURL = URL.createObjectURL(file); // 선택한 파일의 임시 URL 생성
	        
	        fileNameDisplay.innerText = "선택한 파일: " + file.name;
	        fileNameDisplay.style.display = "block";

	        // 파일 확장자 체크
	        let fileExt = file.name.split('.').pop().toLowerCase();
	        
	        // 미리보기 영역 초기화
	        previewContainer.innerHTML = ""; 

	        if (["jpg", "jpeg", "png", "gif"].includes(fileExt)) {
	            // 이미지 미리보기
	            let img = document.createElement("img");
	            img.src = fileURL;
	            img.style.maxWidth = "100%";
	            img.style.height = "auto";
	            previewContainer.appendChild(img);
	        } else if (fileExt === "pdf") {
	            // PDF 미리보기
	            let embed = document.createElement("embed");
	            embed.src = fileURL;
	            embed.type = "application/pdf";
	            embed.width = "100%";
	            embed.height = "500px";
	            previewContainer.appendChild(embed);
	        } else if (["ppt", "pptx"].includes(fileExt)) {
	            // PowerPoint 파일 다운로드 링크 제공
	            let link = document.createElement("a");
	            link.href = fileURL;
	            link.innerText = "PPT 미리보기 지원되지 않음 - 다운로드 클릭";
	            link.download = file.name;
	            previewContainer.appendChild(link);
	        } else {
	            // 기타 파일 (미리보기가 지원되지 않는 파일은 다운로드 링크 제공)
	            let link = document.createElement("a");
	            link.href = fileURL;
	            link.innerText = "파일 다운로드";
	            link.download = file.name;
	            previewContainer.appendChild(link);
	        }
	    } else {
	        // 파일이 선택되지 않았을 경우 미리보기 영역을 초기화
	        fileNameDisplay.innerText = "";
	        previewContainer.innerHTML = "<p>업로드된 포트폴리오 파일이 없습니다.</p>";
	    }
	}
	</script>
</body>
</html>
