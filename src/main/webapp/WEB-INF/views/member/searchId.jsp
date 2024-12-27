<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f0f0f0;
	margin: 0;
	padding: 0;
}
.title{
	text-align : center;
	font-size: 20px;
	color: #34805C;
}
.button{
	text-align : center;
}
#idSearchPopup {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 480px;
    height : 350px;
    padding: 20px;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    border-radius: 20px;

}
.popup-content {
   display: flex;
   flex-direction: column;
   justify-content: center;

}

.input-wrap{
	display : flex;
	float : left;
	flex-direction: column;
}
button {
	padding: 10px 20px;
	border: none;
	border-radius: 15px;
	background-color: #34805C;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s;
}

button:hover {
	background-color: #82E3B6;
}
.memberPhone{
	margin-left : 3px;
}
.popupPhone{
	margin-bottom : 10px;
}
#popupMemberPhone{
	width:480px;
	height:40px;
	border-top : none;
	border-right : none;
	border-left : none;
	font-size : 15px;
}
.memberEmail{
	margin-left : 3px;
}
.popupEmail{
	margin-bottom : 20px;
}
#popupMemberEmail{
	width:480px;
	height:40px;
	border-top : none;
	border-right : none;
	border-left : none;
	font-size : 15px;
}
.search{
	width:235px;
	margin:0 auto;
	margin-bottom : 20px;
	margin-top:17px;
	margin-right : 20px;
}
.close{
	width:235px;
	margin:0 auto;
	margin-top:17px;
}
.searchClose{
	display: flex;
	justify-content:center;
	text-align : center;
}

</style>
</head>
<body>
	<form method="post">
		<!-- 팝업 HTML -->
	 	<div id="idSearchPopup" >
		    <div class="title"><h3>아이디 찾기</h3></div>
		  <div class="popup-content">
		    <div class="input-wrap">
		      <div class="memberPhone"><label for="memberPhone" class="memberPhone">전화번호</label></div> <br>
		      <div class="popupPhone"><input type="text" id="popupMemberPhone" placeholder="전화번호를 입력해주세요" /></div>
		    </div>
		    <div class="input-wrap">
		      <div class="memberEmail"><label for="memberEmail" class="memberEmail">이메일</label></div> <br>
		      <div class="popupEmail"><input type="text" id="popupMemberEmail" placeholder="이메일을 입력해주세요" /></div>
		    </div>
		    <div class="search-button">
		    </div>
		  </div>
		  <div class="searchClose">
		     <div class="button"><button type="button" onclick="searchId()" class="search">아이디 찾기</button></div> 
		     <div class="button"><button type="button" onclick="closePopup()" class="close">취소</button></div>
		  </div> 
		</div>
	</form>
	<script>
	function closePopup() {
		window.close();
    }
	
	function showIdSearchPopup() {
        document.getElementById("idSearchPopup").style.display = "block";
    }
    // 아이디 찾기 함수
    function searchId() {
        var memberPhone = document.getElementById("popupMemberPhone").value;
        var memberEmail = document.getElementById("popupMemberEmail").value;

        if (!memberPhone || !memberEmail) {
            alert("전화번호와 이메일을 입력해 주세요.");
            return;
        }

        $.ajax({
            url: '/member/searchId.exco', 
            type: 'POST',
            data: {
                memberPhone: memberPhone,
                memberEmail: memberEmail
            },
            success: function(response) {
                if (response) {
                    alert("아이디: " + response);
                    closePopup(); // 팝업 닫기
                } else {
                    alert("일치하는 회원이 없습니다.");
                }
            },
            error: function() {
                alert("서버에 오류가 발생했습니다.");
            }
        });
	}
	</script>
</body>
</html>
