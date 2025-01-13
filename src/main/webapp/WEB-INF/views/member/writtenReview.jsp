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
.pagination-comment {
  list-style-type: none;
  display: flex;
  justify-content: center;
  align-items: center;
}
.pagination-comment a, .pagination-comment span {
    margin: 0 5px;
    padding: 5px 10px;
    text-decoration: none;
    border: 1px solid #ccc;
    border-radius: 3px;
    margin-top : 10px;
}

.pagination-comment a:hover {
    background-color: #f0f0f0;
}

.pagination-comment .current {
    font-weight: bold;
    color: white;
    background-color: #7CBBAD;
    border-color: #7CBBAD;
}
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
   margin-left : 310px;
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
   margin-left : 470px;
   margin-top : -100px;
}
.written{
   margin-left : 740px;
   margin-top : -30px;
}
.writtenBoard{
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
.writtenBoard-board{
	width : 1100px;
	height : 120px;
	margin-top : 100px;
	margin-left : 80px;
	
}
.writtenBoard-child{
    box-sizing: content-box;
    width: 100%;
}

</style>
</head>
<body>
<div class="wrap">
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	  <main class="content">
		<section class="section mypage-wrap">
		  <c:choose>
		   <c:when test="${loginMember != null && (loginMember.memberType == 1 || loginMember.memberType == 2 || loginMember.memberType == 3)}">
		      <div class="mypage">
		         <input type="hidden" id="memberNo" name="memberNo" value="${loginMember.memberNo}">
		         <div class="mypage-memberProfile">
		            <div class="memberInfo-brife">
		                <a href="javascript:void(0)" class="circle-button">
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
		            <div class="update-nickname">
		               <h3 class="memberNickname">${loginMember.memberNickname} 회원님</h3>
		            </div>
		         </div>
		         <div class="writtenBoard-board">
                       <div class="writtenBoard-child">
						<table class="tbl">
	                     <tr>
	                        <th style="width:8%">번호</th>
	                        <th style="width:25%">내용</th>
	                        <th style="width:15%">작성일</th>
	                        <th style="width:10%">별점</th>
	                     </tr>
	                     <c:forEach var="review" items="${reviewList}">
	                     <tr>
	                        <td>${review.reviewNo}</td>
	                        <td>${review.reviewContent}</td>
	                        <td>${review.reviewDate}</td>
	                        <td>${review.reviewScore}</td>
	                     </tr>
                   		 </c:forEach>
                     <c:if test="${empty reviewList}">
					    <tr>
					        <td colspan="4">리뷰가 없습니다.</td>
					    </tr>
					 </c:if>
                  </table>
                  <div class="pagination-comment">
                    <c:if test="${reqPage > 1}">
                        <a href="?reqPage=${reqPage - 1}">&laquo; 이전</a>
                    </c:if>
				 </div>
				</div>
			  </div>
			 </div>
			 </c:when>
		  <c:when test="${loginMember != null && (loginMember.memberType == 4 || loginMember.memberType == 5 || loginMember.memberType == 6)}">
		      <div class="mypage">
		         <input type="hidden" id="memberNo" name="memberNo" value="${loginMember.memberNo}">
		         <div class="mypage-memberProfile">
		            <div class="memberInfo-brife">
		                <a href="javascript:void(0)" class="circle-button">
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
		            <div class="update-nickname">
		               <h3 class="memberNickname">${loginMember.memberNickname} 전문가님</h3>
		            </div>
		         </div>
		         <div class="writtenBoard-board">
                       <div class="writtenBoard-child">
						<table class="tbl">
	                  	<tr>
	                        <th style="width:8%">번호</th>
	                        <th style="width:25%">내용</th>
	                        <th style="width:15%">작성일</th>
	                        <th style="width:10%">별점</th>
	                     </tr>
	                   	 <c:forEach var="review" items="${reviewList}">
	                     <tr>
	                        <td>${review.reviewNo}</td>
	                        <td>${review.reviewContent}</td>
	                        <td>${review.reviewDate}</td>
	                        <td>${review.reviewScore}</td>
	                     </tr>
                   		 </c:forEach>
                     	<c:if test="${empty reviewList}">
						    <tr>
						        <td colspan="4">리뷰가 없습니다.</td>
						    </tr>
					 	</c:if>
                  </table>
                  <div class="pagination-comment">
                    <c:if test="${reqPage > 1}">
                        <a href="?reqPage=${reqPage - 1}">&laquo; 이전</a>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <c:choose>
                            <c:when test="${i == reqPage}">
                                <span class="current">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?reqPage=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${reqPage < totalPages}">
                        <a href="?reqPage=${reqPage + 1}">다음 &raquo;</a>
                    </c:if>
                   </div>
				 </div>
				</div>
			  </div>
			 </c:when>
			</c:choose> 
		   </section>
		</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>