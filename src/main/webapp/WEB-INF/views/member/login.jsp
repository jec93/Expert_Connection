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
	padding-left : 200px;
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
.login-img1{
  display: flex;
  justify-content: center;
  align-items: center; 
  padding-top: 200px;
}
.login-img{
	width : 400px;
	height : 130px;
	display: flex;
	justify-content: center;
	align-items: center;
}
.login-img2{
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: -150px; 
  margin-right: 15px;
}
.kakao-login-img{
	display: flex;
	justify-content: center;
	align-items: center;
	padding-right : 180px;
	margin-bottom : 300px;
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
<div class="login-img1"><a href="/"><img class="login-img" src="/resources/logo/expert_connection_logo_h_01.png" alt="logo image"></a></div>
	<main class="content login-container">
		<section class="section login-wrap">
				<form action="login.exco" method="post" autocomplete="off">
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
						<a href="/member/joinSelectFrm.exco" class="search">회원가입</a>
					</div>
					<div class="login-img2"><a href="https://kauth.kakao.com/oauth/authorize?client_id=97ed8b02d15c6ed0755b30d28b222b89&redirect_uri=http://localhost:80/callback&response_type=code">
					<img class="kakao-login-img" src="/resources/images/kakao_login.png" alt="kakao-login image"></a></div>
				</form>
				<c:if test="${not empty loginFailMessage}">
			        <script>
			            alert("${loginFailMessage}");
			        </script>
			    </c:if>
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
	
	function showIdSearchPopup() {
		 
		  var popupURL = "/member/searchIdFrm.exco";
		  var popupProperties = "width=530,height=410,scrollbars=yes";
		  
		  window.open(popupURL, "Popup", popupProperties);
		}
	function showPwSearchPopup() {		 
		  var popupURL = "/member/searchPwFrm.exco";
		  var popupProperties = "width=530,height=410,scrollbars=yes";
		  
		  window.open(popupURL, "Popup", popupProperties);
		}
	</script>
</body>
</html>