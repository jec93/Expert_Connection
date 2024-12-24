<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<style>
.login-container {
	display: flex;
	justify-content: center;
	align-items: center;
	padding-top : 300px;
	padding-left : 150px;
}

.login-wrap {
	width: 500px;
}

.input-password{
	width : 305px;
	height : 40px;
	margin-top : 10px;
	border-radius : 10px;
	background-color : white;
}
.input-password:hover{
	cursor : pointer;
}
.login-input-item{
	width : 300px;
	height : 30px;
	border-radius : 5px;

}
.member-link-box{
	margin-left : 15px;
	margin-bottom : 200px;
}
.join{
	text-decoration : none;
	color : black;
}
.search{
	text-decoration : none;
	color : black;
}
.join:hover{
	text-decoration : underline;
}
.search:hover{
	text-decoration : underline;
}
.login-input-wrap.checkbox-container {
	
	align-items: center; /* 수직 가운데 정렬 */
	flex-direction: row; /* 가로 배치 */
	gap: 5px; /* 간격 조정 */
	float : right;
	margin-right : 200px;
	margin-bottom : 10px;
	margin-top : -10px;
}
.login-input-title{
	height : 10px;
}
input[type="checkbox"] {
	margin: 0; /* 체크박스 여백 초기화 */
}
.img1{
  display: flex;
  justify-content: center;
  align-items: center; 
}
.img{
	width : 400px;
	height : 130px;
	display: flex;
	justify-content: center;
	align-items: center;
	padding-top : 200px;
}

input[type="password"]:focus
{
	border-color: #808080;
	box-shadow: 0 0 5px rgba(128, 128, 128, 0.5);
	outline: none;
}
input[type="text"]:focus
{
	border-color: #808080;
	box-shadow: 0 0 5px rgba(128, 128, 128, 0.5);
	outline: none;
}
input[type="password"]{
	width: 305px;
	height: 20px;
	padding: 10px;
	margin: 5px 0;
	border: 1px solid #b0b0b0;
	border-radius: 8px;
	transition: border-color 0.3s, box-shadow 0.3s;
}
input[type="text"]{
	width: 305px;
	height : 20px;
	padding: 10px;
	margin: 5px 0;
	border: 1px solid #b0b0b0;
	border-radius: 8px;
	transition: border-color 0.3s, box-shadow 0.3s;
}
input[type="password"] {
    flex: 1;
    font-size: 16px;
    line-height: 1.5;
    border: none;
    border-bottom: 1px solid var(--gray5);
    padding: 8px 0px;
}
input[type="text"] {
    flex: 1;
    font-size: 16px;
    line-height: 1.5;
    border: none;
    border-bottom: 1px solid var(--gray5);
    padding: 8px 0px;
}
</style>

</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="img1"><img class="img" src="/resources/logo/expert_connection_logo_h_01.png" alt="logo image"></div>
	<main class="content login-container">
		<section class="section login-wrap">
				<form action="login.exco" method="post" autocomplete="off"
					onsubmit="return loginValidate()">
					<div class="login-input-title">
							<label for="loginId">아이디</label>
					</div>
					 <div class="login-input-wrap checkbox-container">
						<c:if test="${empty cookie.saveId.value}">
							<input type="checkbox" name="saveId" id="saveId" value="chk">
						</c:if>
						<c:if test="${!empty cookie.saveId.value}">
							<input type="checkbox" name="saveId" id="saveId" value="chk"
								 checked>
						</c:if>
						<label for="saveId" >아이디 저장</label>
					</div><br>  
 						<input class="login-input-item" type="text" name="memberId" value="${cookie.saveId.value}" placeholder="아이디"> <br>
					<div class="login-input-title">
							<label for="loginPw">비밀번호</label>
					</div> <br> 
						<input class="login-input-item" type="password" name="memberPw" placeholder="비밀번호"> <br>
					<button class="input-password" type="submit">로그인</button> <br>
					
					<div class="member-link-box">
						<a href="javascript:void(0)" onclick="showIdSearchPopup()" class="search">아이디 찾기</a> | 
						<a href="javascript:void(0)" onclick="showPwSearchPopup()" class="search">비밀번호 찾기</a> | 
						<a href="/member/joinFrm.exco" class="search">회원가입</a>
					</div>
				</form>
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
	//로그인 버튼 클릭 시, 동작 함수(submit 이전에) 
	function loginValidate() {
		if ($('#loginId').val().length < 1) {
			alert("아이디를 입력하세요.");
			$('#loginId').focus();
			return false;
		}
		if ($('#loginPw').val().length < 1) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
	}
	function showIdSearchPopup() {
		 
		  var popupURL = "/member/searchIdFrm.exco";
		  var popupProperties = "width=700,height=600,scrollbars=yes";
		  
		  window.open(popupURL, "Popup", popupProperties);
		}
	function showPwSearchPopup() {		 
		  var popupURL = "/member/searchPwFrm.exco";
		  var popupProperties = "width=700,height=600,scrollbars=yes";
		  
		  window.open(popupURL, "Popup", popupProperties);
		}
	</script>
</body>
</html>