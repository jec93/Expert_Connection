<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

.delete-input-wrap {
	display: flex;
	flex-direction: column;
	margin-bottom: 15px;
	align-items: center;
}

.input-title {
	margin-bottom: 5px;
}

.delete-input-item {
	width: 100%;
	width:400px;
	margin-left : 30px;
}
.delete-component{
	border-top : none;
	border-left : none;
	border-right : none;
	width : 400px;
	height : 40px; 
	padding-top : 10px;
	font-size : 16px;
	border-radius : 10px;
}

.delete-button{
	display: flex;
	justify-content: center;
	align-items: center;
	padding-top : 30px;
}
.cancel-button{
	display: flex;
	justify-content: center;
	align-items: center;
	padding-top : 30px;
}
button {
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	background-color: #007bff;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.join-button-box {
	display: flex;
	justify-content: center;
	align-items: center;
	padding-top: 30px;
}

.delete-btn-primary {
	background-color: #34805C;
	border: none;
	border-radius: 30px;
	padding: 10px 20px;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.delete-btn-primary:hover {
	background-color: #2f5233;
}

.delete-btn-default:hover {
	background-color: #2f5233;
}

input[type="password"]:focus
{
	border-color: #808080;
	box-shadow: 0 0 5px rgba(128, 128, 128, 0.5);
	outline: none;
}
.delete-wrap{
	margin-top: 100px;
	padding: 20px;
	background-color: #ffffff;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}
.input-msg{
	margin-left : 30px;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="section delete-wrap">
	<div class="page-title">회원 탈퇴</div>
     <form action="/member/delete.exco" method="post" id="deleteForm">
    	<input type="hidden" id="memberNo" name="memberNo" value="${loginMember.memberNo}">
    	
	    	<div class="delete-input-wrap">
			    <p>회원탈퇴를 하시려면 비밀번호를 입력해주세요.</p>
		    	<div>
			        <div class="delete-input-item">
			         <input type="password" id="memberPw" name="memberPw" placeholder="비밀번호" class="delete-component"/>
			        </div>
			        <p id="pwMessage" class="input-msg"></p>
		        </div>
	        </div>
	    <div class="delete-input-wrap">   
         <div class="delete-input-item">
            <input type="password" id="pwChk" name="pwChk" placeholder="비밀번호 확인" class="delete-component"/>
          </div>
            <p id="pwMessage" class="input-msg"></p>
        </div>
        <div class="delete-button">
        	<input type="submit" id="delete" name="delete" value="회원 탈퇴" class="delete-btn-primary"> 
        </div>
        <div class="cancel-button">
    		<a href="/" id="cancelButton"  class="delete-btn-primary">취소 </a>
		</div>
	</form>
   </section>
   	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script>
    
	   	$("#cancelButton").on("click", function(event) {
	        event.preventDefault();
	        window.location.href = "/";
	  	 });
	   	
		$(document).ready(function(){
			
			const checkObj = {
					"memberPw" : false,		
				}
				
			
			const memberPw = $('#memberPw');
			const pwMessage = $('#pwMessage');
			
			memberPw.on('input',function(){
				checkObj.memberPwChanged = true;
		        pwMessage.removeClass('valid');
		        pwMessage.removeClass('invalid');
		        
		        const regExp = /(?=.*[0-9])(?=.*[!@#$%^&*()-_=+])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()-_=+]{8,20}$/;

		        
		        if(regExp.test($(this).val())){
		            checkObj.memberPw = true;
		            pwMessage.html("");
		            pwMessage.addClass("valid");
		        }else{
		            pwMessage.html("올바른 비밀번호가 아닙니다");
		            pwMessage.addClass("invalid");
		            checkObj.memberPw = false;
		        }
		    });
		
			$("#delete").on("click", function(){
				 event.preventDefault();
				if($("#memberPw").val()==""){
					alert("비밀번호를 입력해주세요");
					$("#memberPw").focus();
					return false;
				}
				
				if($("#pwChk").val()==""){
					alert("비밀번호 확인을 입력해주세요");
					$("#pwChk").focus();
					return false;
				}
				
				if ($("#memberPw").val() != $("#pwChk").val()) {
					alert("비밀번호가 일치하지 않습니다.");
					$("#memberPw").focus();
					 
					return false;
					}
				$.ajax({
		            url: "/member/deleteCheck.exco",
		            type: "POST",
		            dataType: "json",
		            data: $("#deleteForm").serializeArray(),
		            success: function(data) {
		                // 비밀번호가 맞으면
		                if (data === 1) {
		                    // 탈퇴 확인 창 띄우기
		                    if (confirm("탈퇴하시겠습니까?")) {
		                        $("#deleteForm").off("submit").submit(); // 폼 제출
		                    }
		                } else {
		                    // 비밀번호가 틀리면
		                    alert("비밀번호를 확인해주세요.");
		                }
		            },
		            error: function() {
		                alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
		            }
		        });
			});
		});
	</script>
</body>
</html>