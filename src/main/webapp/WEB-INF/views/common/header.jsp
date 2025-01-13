<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
Boolean isNull = (Boolean) application.getAttribute("isNull");
%>

<link rel="stylesheet" href="/resources/css/exco.css" />

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.5.0/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/dist/stomp.min.js"></script>

<!-- <style>
@media screen and (max-width: 1300px) {
  .member-menu {
    display: none;
  }
} 
</style> -->

   <header class="header">   
      <div class="fixedMenu">
           <div class="logo"><a href="/"><img id="header_logo" src="/resources/logo/expert_connection_logo_h_05.png" width="170px" height="45px"></a></div>
           <nav class="nav">
               <ul class="recommend">
                  <li>
                     <a href="/expert/expertBotSearchFrm.exco">전문가 추천</a>
                  </li>
                  <li>
                  <% if(isNull){ %>
                     <a href="#">검색 점검중</a>
                  <%}else{ %>
                     <a href="/categories/categoryFrm.exco">전문가 검색</a>
                  <%} %>
                  </li>
                  <li><a href="#">커뮤니티</a>
                        <ul class="sub-menu">
                           <li><a href="/board/list.exco?reqPage=1&boardType=0&boardTypeNm=0">사용자 게시판</a></li>
                            <li><a href="/board/list.exco?reqPage=1&boardType=1&boardTypeNm=1">전문가 게시판</a></li>
                            <li><a href="/board/list.exco?reqPage=1&boardType=2&boardTypeNm=2">전문가 노하우</a></li>
                            <li><a href="/board/list.exco?reqPage=1&boardType=3&boardTypeNm=3">그룹 레슨</a></li>
                        </ul>
                  </li>
               </ul>
           </nav>
           <ul class="member-menu">
               <c:choose>
               <c:when test="${empty sessionScope.loginMember}">
                       <li class="login_box">
                          <a href="/member/loginFrm.exco"><img id="icon_login" src="/resources/images/icon_login.png">로그인</a>
                      </li>
                       <li class="signup_box">
                          <a href="/member/joinSelectFrm.exco"><img id="icon_signup" src="/resources/images/icon_signup_01.png">회원가입</a>
                       </li>
               </c:when>
               <c:otherwise>
                        <li class="chat_box">
                          <a href="/chat/getRoomList.exco"><img id="icon_chat" src="/resources/images/icon_chat.png">채팅</a>
                      </li>
                       <li class="alarm_box">
                          <img id="icon_alarm" src="/resources/images/icon_alarm.png">알림
                          <div class="notification-count">
                          	<span>0</span>
                          </div>
                          <div id="notification-list" class="notification-list">
                          </div>
                       </li>
                       <li class="mypage_box">
                    	<c:if test="${sessionScope.loginMember.memberId ne 'admin'}">
                       	<a href="/member/mypageFrm.exco"><img id="icon_mypage" src="/resources/images/icon_mypage.png">마이페이지</a>
                       	</c:if>
                       	<c:if test="${sessionScope.loginMember.memberId eq 'admin'}">
                       	<a href="/board/adminPage.exco?reqPage=1&boardType=6&boardTypeNm=6"><img id="icon_mypage" src="/resources/images/icon_mypage.png">관리자페이지</a>
                       	</c:if>
                      </li>
                       <li class="logout_box">
                          <a href="/member/logout.exco"><img id="icon_logout" src="/resources/images/icon_logout.png">로그아웃</a>
                       </li>
               </c:otherwise>
               </c:choose>
           </ul>
       </div>
   </header>
   
   <script>
   //자주사용하는 함수 header에 선언 -> 다른 jsp에서 script에 작성하지 않아도 됨
   function msg(title, text, icon) {
      swal({
         title : title,
         text : text,
         icon : icon
      });
   }
   
	const eventSource = new EventSource("/emitter?memberNo=${loginMember.memberNo}");//controller 경로
   
   //server에서 메시지 올시 알람 count 증가 처리
   eventSource.onmessage = (event) => { //데이터를 받아옴
      if(Number($('.notification-count').children().html()) < 99){
          if($('.notification-count').css('display') == "none"){
             $('.notification-count').css('display', 'inline-block');
             $('.notification-count').children().html( Number($('.notification-count').children().html()) + 1);
          }else{
             $('.notification-count').children().html( Number($('.notification-count').children().html()) + 1);
          }
      }
   };
	
	// 로컬 스토리지에 알림 개수를 저장하는 함수
   function saveNotificationCount(count) {
       localStorage.setItem('notificationCount', count);
   }

   // 로컬 스토리지에 알림 목록을 저장하는 함수
   function saveNotificationList(list) {
       localStorage.setItem('notificationList', JSON.stringify(list));
   }

	// SSE 이벤트를 처리하는 함수
   function setupSse() {
       const eventSource = new EventSource(`/emitter?memberNo=${loginMember.memberNo}`);
       eventSource.onmessage = function(event) {
           const data = JSON.parse(event.data);
           const message = data.message;
           const url = data.url;
           
           // 알림 UI를 업데이트하는 함수 호출 / 알림 목록에 새로운 알림 추가
           updateNotification(message, url);
       };
   }

   // 알림 UI를 업데이트하는 함수
   function updateNotification(message, url) {
       const notificationCount = $('.notification-count');
       const currentCount = Number(notificationCount.children().html());

       if (currentCount < 99) {
           if (notificationCount.css('display') === "none") {
               notificationCount.css('display', 'inline-block');
           }
           notificationCount.children().html(currentCount + 1);
           saveNotificationCount(currentCount + 1);
       }

       // 알림 목록에 새로운 알림 추가
       const notificationList = $('#notification-list');
       const notifications = loadNotificationList();
       notifications.push({ message, url });
       saveNotificationList(notifications);

       const newNotification = $('<div class="notification-item"></div>')
           .text(message)
           
        // URL이 있는 경우 클릭 이벤트를 추가
	    if (url) {
	        newNotification.data('url', url).on('click', function() {
	            const clickedUrl = $(this).data('url');
	            // 클릭한 알림만 삭제
	            const updatedNotifications = notifications.filter(notif => notif.url !== clickedUrl);
	            saveNotificationList(updatedNotifications);
	            window.location.href = clickedUrl;
	        });
	    }

       notificationList.prepend(newNotification);
   }

   // 페이지가 로드될 때 알림 목록 및 알림 개수 로드
   $(document).ready(function() {
       const notificationCount = loadNotificationCount();
       if (notificationCount > 0) {
           $('.notification-count').css('display', 'inline-block');
           $('.notification-count').children().html(notificationCount);
       } else {
           $('.notification-count').css('display', 'none');
       }

       setupSse();
       loadNotifications();
   });

   // 로컬 스토리지에서 알림 개수를 불러오는 함수
   function loadNotificationCount() {
       return localStorage.getItem('notificationCount') || 0;
   }

   // 알람 클릭 시 알림 목록 표시 및 알림 목록 초기화
   $('.alarm_box').on('click', function() {
       const notificationList = $('#notification-list');
       const notifications = loadNotificationList();
       
       $('#notification-list').toggle();
       
       if ($('#notification-list').css('display') !== 'none') {
           if (notifications.length === 0) {
               // 새로운 알림이 없을 때 메시지 표시
               notificationList.html('<div class="notification-item">새로운 알림이 없습니다</div>');
           } else {
               // 알림 목록 표시
               notificationList.empty(); // 알림 목록 초기화
               notifications.forEach(notification => {
                   const newNotification = $('<div class="notification-item"></div>')
                       .text(notification.message)
                       .data('url', notification.url)
                       .on('click', function() {
                           const clickedUrl = $(this).data('url');
                           // 클릭한 알림만 삭제
                           const updatedNotifications = notifications.filter(notif => notif.url !== clickedUrl);
                           saveNotificationList(updatedNotifications);
                           window.location.href = clickedUrl;
                       });
                   notificationList.append(newNotification);
               });
           }

           // 알림 개수를 초기화
           const notificationCount = $('.notification-count');
           const currentCount = Number(notificationCount.children().html());

           if (currentCount > 0) {
               notificationCount.children().html(0);
               notificationCount.css('display', 'none');
               localStorage.setItem('notificationCount', 0);
           }
       }
   });

   // 로컬 스토리지에서 알림 목록을 불러오는 함수
   function loadNotificationList() {
       return JSON.parse(localStorage.getItem('notificationList')) || [];
   }

   // 알림 목록을 불러와 알림 목록을 초기화하는 함수
   function loadNotifications() {
       const notificationList = $('#notification-list');
       const notifications = loadNotificationList();

       notificationList.empty(); // 알림 목록 초기화
       
       notifications.forEach(notification => {
           const newNotification = $('<div class="notification-item"></div>')
               .text(notification.message)
               .data('url', notification.url)
               .on('click', function() {
                   const clickedUrl = $(this).data('url');
                   // 클릭한 알림만 삭제
                   const updatedNotifications = notifications.filter(notif => notif.url !== clickedUrl);
                   saveNotificationList(updatedNotifications);
                   window.location.href = clickedUrl;
               });
           notificationList.prepend(newNotification);
       });
   }

   </script>