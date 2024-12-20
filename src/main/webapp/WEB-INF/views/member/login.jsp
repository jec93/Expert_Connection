<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
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
	border-radius : 5px;
	background-color : white;
}
.input-item{
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
.input-wrap.checkbox-container {
	
	align-items: center; /* 수직 가운데 정렬 */
	flex-direction: row; /* 가로 배치 */
	gap: 5px; /* 간격 조정 */
	float : right;
	margin-right : 200px;
	margin-bottom : 10px;
	margin-top : -10px;
	
	
}
.input-title{
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
	padding-top : 300px;
	padding-left : 100px;
}


</style>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="img1"><img class="img" src="/resources/logo/expert_connection_logo_h_01.png" alt="logo image"></div>
	<main class="content login-container">
		<section class="section login-wrap">
			<c:if test="${empty loginMember}">
				<form action="/member/login.exco" method="post">
					<div class="input-title">
							<label for="loginId">아이디</label>
					</div> <div class="input-wrap checkbox-container">
						<c:if test="${empty cookie.saveId.value}">
							<input type="checkbox" name="saveId" id="saveId" value="chk">
						</c:if>
						<c:if test="${!empty cookie.saveId.value}">
							<input type="checkbox" name="saveId" id="saveId" value="chk"
								checked>
						</c:if>
						<label for="saveId" >아이디 저장</label>
					</div><br>  
 						<input class="input-item" type="text" name="memberId"> <br>
					
					<div class="input-title">
							<label for="loginPw">비밀번호</label>
					</div> <br> 
						<input class="input-item" type="password" name="memberPw"> <br>
					<input class="input-password" type="submit" value="로그인"> <br>
					
					<div class="member-link-box">
						<a href="javascript:void(0)" onclick="showIdSearchPopup()" class="search">아이디 찾기</a> | 
						<a href="javascript:void(0)" onclick="showPwSearchPopup()" class="search">비밀번호 찾기</a> | 
						<a href="/member/joinFrm.exco">회원가입</a>
					</div>
				</form>
			</c:if>
			
			<c:if test="${not empty loginMember}">
				<h3>[${loginMember.memberNickname}]님 환영합니다!</h3>
				<a href="/member/logout.exco">로그아웃</a>
				<a href="/member/delete.exco?memberId=${loginMember.memberId}">회원탈퇴</a>
				<a href="/member/mypage.exco">마이페이지</a>
			</c:if>
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
	function showIdSearchPopup() {
		 
		  var popupURL = "/member/searchIdFrm";
		  var popupProperties = "width=600,height=500,scrollbars=yes";
		  
		  window.open(popupURL, "Popup", popupProperties);
		}
	function showPwSearchPopup() {		 
		  var popupURL = "/member/searchPwFrm";
		  var popupProperties = "width=600,height=500,scrollbars=yes";
		  
		  window.open(popupURL, "Popup", popupProperties);
		}
	</script>
</body>
</html>