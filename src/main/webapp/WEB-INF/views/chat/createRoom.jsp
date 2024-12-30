<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<h3>채팅방 만들기</h3>
	
	<hr>
	
	방 이름 : <input type="text" id="roomName"> <br>
	
	
	<button type="button" onclick="createRoom()">생성하기</button>
	
	<table border="1">
		<tr>
			<th>선택</th>
			<th>아이디</th>
			<th>이름</th>
		</tr>
		<c:forEach var="m" items="${memberList}">
			<c:if test="${m.memberNo ne loginMember.memberNo}">
		<tr>
			<%-- <td><input type="checkbox" name="members" value="${m.memberNo}"></td> --%>
			<td>${m.memberNo}</td>
			<td>${m.memberNickname}</td> 
			<td><button onclick="createOneRoom('${m.memberNo}')">채팅 요청</button></td>
		</tr>
			</c:if>
			
		</c:forEach>
		
	</table>
	
	<script>
		function createRoom() {
			let checks = $('input[name=members]:checked');
			let members = [];
			
			for(let i=0; i<checks.length; i++){
				members.push(checks[i].value);
			}
			
			
			$.ajax({
				url : '/chat/createRoom.exco',
				data : {roomName : $('#roomName').val()
					   ,members : members.join(",")},
				success : function(roomId){
					window.opener.location.href="/chat/getChatList.exco?roomId=" + roomId;
					self.close();
					
				},
				error : function () {
					
				}
			});
		}
		
		//채팅 요청 버튼 눌렀을 때 해당 전문가랑 채팅방 생성
		function createOneRoom(memberNo) {
	        const roomName = "1:1 Chat with " + memberNo; 

	        $.ajax({
	            url: '/chat/createRoom.exco',
	            method: 'GET',
	            data: {
	                roomName: roomName,
	                members: memberNo //상대방 ID만 전달
	            },
	            success: function(roomId) {
	                // 생성된 채팅방으로 이동
	                window.opener.location.href="/chat/getChatList.exco?roomId=" + roomId; //새창 열어서 이동
	                self.close(); //기존 팝업창 닫기
	                /* window.location.href = "/chat/getChatList.exco?roomId=" + roomId; */ //바로 이동 
	            },
	            error: function() {
	                alert('1:1 채팅방 생성에 실패했습니다.');
	            }
	        });
	    }
	</script>
</body>
</html>