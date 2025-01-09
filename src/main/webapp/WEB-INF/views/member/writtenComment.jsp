<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
   margin-left : 125px;
   margin-top : -40px;
}
.profile-img {
    width: 100%;           /* 버튼 너비에 맞춤 */
    height: 100%;          /* 버튼 높이에 맞춤 */
    object-fit: cover;     /* 이미지 비율 유지하면서 잘라냄 */
    position: absolute;    /* 컨테이너 내 배치 */
    top: 0;
    left: 0;
}
.memberNickname{
   margin-left : 280px;
   margin-top : -100px;
}
.written{
   margin-left : 550px;
   margin-top : -30px;
}
.writtenComment{
	display : inline-block;
	height : 25px;
	width : 100px;
	border-radius : 30px;
	background-color : #7CBBAD;
	color : var(--gray8);
	margin-top : 2px;
	margin-right : 5px;
	text-align : center; 	
}
.writtenComment-comment{
	border : 1px solid black;
	width : 800px;
	height : 120px;
	margin-top : 100px;
	margin-left : 80px;
	
}

</style>
</head>
<body>
<div class="wrap">
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	  <main class="content">
		<section class="section mypage-wrap">
		      <div class="mypage">
		         <input type="hidden" id="memberNo" name="memberNo" value="${loginMember.memberNo}">
		
		         <div class="mypage-memberProfile">
		            <div class="memberInfo-brife">
		               <a href="javascript:void(0)" class="circle-button">
		                <c:choose>
					     <c:when test="${not empty loginMember}">
					       <c:choose>
					           <c:when test="${not empty loginMember.profilePath && not empty loginMember.profileName}">
					               <img src="${loginMember.profilePath}${loginMember.profileName}" class="profile-img">
					           </c:when>
					           <c:otherwise>
					               <img src="/resources/logo/expert_connection_favicon.png" class="profile-img">
					           </c:otherwise>
					       </c:choose>
					     </c:when>
					      <c:otherwise>
					       <img src="/resources/logo/expert_connection_favicon.png" class="profile-img">
					      </c:otherwise>
					    </c:choose>
		               </a>
		            </div>
		            <div class="update-nickname">
		               <h3 class="memberNickname">${loginMember.memberNickname} 님</h3>
		            </div>
		            <div class="written">
	    			<a href="/member/writtenBoardFrm.exco" id="memberInfo-update">작성글</a>
					<div class="writtenComment" >댓글</div>
	             </div>
		         </div>
		         <div class="writtenComment-comment">
		         	 <c:forEach var="comment" items="${boardComment}">
                    <li>
                        <a href="/board/detail.exco?boardNo=${boardComment.CommentNo}">
                        </a>
                        <p>${loginMember.memberNickname} | ${boardComment.CommentDate}</p>
                        <p>${boardComment.boardContent}  | 좋아요 : ${boardComment.CommentLike} 아쉬워요 :${boardComment.CommentDislike}</p>
                    </li>
                </c:forEach>
		         </div>
		          <div class="writtenComment-comment">
		         	
		         </div>
		          <div class="writtenComment-comment">
		         	
		         </div>
		      </div>
		   </section>
		</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>