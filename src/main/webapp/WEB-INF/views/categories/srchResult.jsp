<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="kr.or.iei.expert.model.vo.ExpertIntroduce"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<ExpertIntroduce> srchList = (ArrayList<ExpertIntroduce>) request.getAttribute("srchList");
	String keyword = (String) request.getAttribute("keyword");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png" />
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png" />
<style>
.menu-container {
	width: 90%;
	max-width: 1200px;
	margin: 0 auto;
	background-color: white;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	padding: 20px;
}

.list-content{
	display: inline-block;
}

#sub-header {
    font-size: 30px;
    font-weight: bold;
    color: rgb(2, 26, 0);
    text-align: center;
    border-radius: 5px;
    margin-top: 15px;
    margin-bottom: 15px;
    padding: 10px 20px;
}

.main-category {
	margin-left: 5%;
	display: flex;
}

.other-categories{
    margin: 5px;
    cursor: pointer;
    position: relative;
}

.expert-profile {
	width: 150px;
	height: 150px;
	border: 1px solid;
}
.info-container{
	width: 250px;
	height : 300px;
	box-shadow: 0 4px 8px var(--main3);
	margin : 15px;
	background-color: var(--main5);
	display: block;
}
.info-container:hover{
	cursor: pointer;
}
#category-container{
	margin-left : 5%;
	display: flex;
	flex-wrap: wrap;
}
.content-title{
	font-size: 20px;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section board-list-wrap">
				<div class="list-body">
					<div class="side-list">
	                  <c:choose>
	                  <c:when test="${boardType eq 0 or boardType eq 1 or boardType eq 2 or boardType eq 3}">
	                  <ul class="side-menu-title">
	                     <li>커뮤니티</li>
	                  </ul>
	                  <ul class="side-menu">
	                     <li><a href="/board/list.exco?reqPage=1&boardType=0&boardTypeNm=0">사용자 게시판</a></li>
	                     <li><a href="/board/list.exco?reqPage=1&boardType=1&boardTypeNm=1">전문가 게시판</a></li>
	                     <li><a href="/board/list.exco?reqPage=1&boardType=2&boardTypeNm=2">전문가 노하우</a></li>
	                     <li><a href="/board/list.exco?reqPage=1&boardType=3&boardTypeNm=3">그룹레슨</a></li>
	                  </ul>
	                  </c:when>
	                  <c:otherwise>
	                  <ul class="side-menu-title">
	                     <li><a href="/cs/CS.exco">고객센터</a></li>
	                  </ul>
	                  <ul class="side-menu">
	                     <li><a href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4">공지사항</a></li>
	                     <li><a href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5">FAQ</a></li>
	                     <li><a href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6">1:1문의</a></li>
	                     <li><a href="/cs/siteTermsOfUse.exco">이용약관</a></li>
	                     <li><a href="/cs/personalInfoPolicy.exco">개인정보처리방침</a></li>
	                     <li><a href="/cs/siteIntro.exco">사이트소개</a></li>
	                  </ul>
	                  </c:otherwise>
	                  </c:choose>
	               </div>
				    <div class="list-content">
						<div class="menu-container">
							<div id="sub-header"><%=keyword %>검색 결과</div>
							<div id="tird-category-title" class="main-category">
							<div id="category-container">
								<% for(ExpertIntroduce i : srchList) {%>
								<div class="info-container" onclick="viewSelectedExpert(<%=i.getMemberNo()%>);">
									<div class="expert-profile"><img src="<%=i.getExpertFilePath() %>" style="width: 100%"></div>
									<div class="content-title">
										<%=i.getIntroduceTitle() %>
									</div>
									<div>
										닉네임 : <%=i.getExpertNickname() %>
									</div>
									<div>
										좋아요 수 : <%=i.getExpertLike() %>
									</div>
									<div>
										소개 글 : <%=i.getIntroduceContent() %>
									</div>
								</div>
								<%} %>
							</div>
						</div>
						</div>
				    </div>
				</div>
			</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
        function viewSelectedExpert(memberNo){
        	location.href = '/expert/viewExpertInfoByMemberNo.exco?&memberNo='+memberNo;
        }
    </script>
</body>
</html>