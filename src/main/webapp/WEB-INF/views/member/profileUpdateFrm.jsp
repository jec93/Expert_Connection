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
.circle-button {
   width: 120px;
   height: 120px;
   overflow : hidden;
   position : relative;
   border-radius: 50%;
   color: #fff;
   font-size: 12px;
   font-weight: bold;
   display: flex;
   flex-direction: column;
   align-items: center;
   justify-content: center;
   text-align: center;
   text-decoration: none;
   cursor: pointer;
   transition: background-color 0.3s ease;
   margin: 10px;
   border : 1px solid black;
   margin-left : 180px;
   margin-top : 40px;
   margin-bottom : 40px;
}
.profile-img {
    width: 100%;           /* 버튼 너비에 맞춤 */
    height: 100%;          /* 버튼 높이에 맞춤 */
    object-fit: cover;     /* 이미지 비율 유지하면서 잘라냄 */
    position: absolute;    /* 컨테이너 내 배치 */
    top: 0;
    left: 0;
}
.custom-file-label{
	background-color : #7CBBAD;
	color : white;
	font-size: 21px;
	display: flex;
	width:485px;
	justify-content: center;
}
.custom-file-label:hover{
	cursor : pointer;
}
.profile-title{
	text-align : center;
	font-size: 20px;
	color: #34805C;
}
.profile-submit{
	background-color : #7CBBAD;
	color : white;
	border : none;
	font-size: 20px;
	width:485px;
	margin-top:20px;
}
.profile-submit:hover{
	cursor : pointer;
}
</style>
</head>
<body>
		<div class="profileUpdate-wrap">
			<main class="content">
				<section class="section profileUpdate-wrap">
					<div class="profile-title">프로필사진 변경</div>
					<form action="/member/profileUpdateAjax.exco" method="post" enctype="multipart/form-data">
					 <input type="hidden" name="memberNo" value="${loginMember.memberNo}">
						<div class="profileUpdate-input-wrap">
							<div>
							    <a href="javascript:void(0)" onclick="showProfilePopup()" class="circle-button">				  
							       <c:choose>
							           <c:when test="${not empty loginMember.profilePath && not empty loginMember.profileName}">
							               <img src="${loginMember.profilePath}${loginMember.profileName}" class="profile-img">
							           </c:when>
							           <c:otherwise>
							               <img src="/resources/logo/expert_connection_favicon.png" class="profile-img">
							           </c:otherwise>
							       </c:choose>
							    </a>
							</div>
							<div class="profileUpdate-input-title">
							    <label for="file" class="custom-file-label">사진 선택</label>
							    <input type="file" name="file" id="file" style="display: none;" class="updatePic" onchange="fileChg(event)">
							    <span id="fileName" class="file-name-text"></span>
							    <button type="submit" class="profile-submit" id="submitBtn">프로필 사진 업로드</button>
							</div>
						</div>
					</form>
				</section>
			</main>
		</div>
	<script>
		document.getElementById("file").addEventListener("change", function () {
		    var fileName = this.files.length > 0 ? this.files[0].name : "";
		    document.getElementById("fileName").textContent = "";
		});
		  
	    window.onload = function () {
	        var success = "${success}";
	        if (success === "true") {
	            alert("프로필 사진이 업데이트되었습니다.");
	            window.close();
	        }
	    };
	    
	    function fileChg(e){
	    	var reader = new FileReader();

	        reader.onload = function(event) {
	        	
	          var img = document.createElement("img");
	          img.setAttribute("src", event.target.result);
	          img.setAttribute("class", "profile-img");					  //기존 이미지와 클래스 동일하게 부여
	          
	          document.querySelector("a.circle-button").innerHTML = '';   //기존 이미지 제거
	          document.querySelector("a.circle-button").appendChild(img); //업로드한 이미지 추가
	        };

	        reader.readAsDataURL(event.target.files[0]);
	    }
	  
</script>
</body>
</html>