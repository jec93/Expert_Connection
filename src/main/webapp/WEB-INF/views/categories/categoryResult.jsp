<%@page import="kr.or.iei.expert.model.vo.ExpertIntroduce"%>
<%@page import="kr.or.iei.member.model.vo.Expert"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  	Map<String, Object> categories = (Map<String, Object>) request.getAttribute("categories");
	ArrayList<ExpertIntroduce> expertList = (ArrayList<ExpertIntroduce>) request.getAttribute("expertList");
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png" />
<link rel="apple-touch-icon"
	href="/resources/logo/expert_connection_favicon.png" />
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

.left-cateogry{
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
}
.info-container:hover{
	cursor: pointer;
}
#category-container{
	margin-left : 5%;
	border-left : 1px solid var(--main3);
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
							<div id="sub-header"><%=request.getParameter("thirdName") %></div>
							<div id="tird-category-title" class="main-category">
								<div class="left-category">
									<ul>
										<%
						                if (categories != null) {
						                	List<Map<String, Object>> subCategories = (List<Map<String, Object>>) categories.get("subCategories");
						                	for(Map<String, Object> c : subCategories){
						                		if(c.get("SECONDCATEGORYCD").equals(request.getParameter("secondCode"))){
						                		%>
										<li class="other-categories" onclick="otherCategories('<%= c.get("THIRDCATEGORYCD")%>','<%= c.get("THIRDCATEGORYNM")%>','<%= c.get("SECONDCATEGORYCD")%>')">
											<img src="/resources/images/icon_category_head.png" style="width:20px;">
											<%= c.get("THIRDCATEGORYNM") %>
										</li>
										<%
							                		}
							                	}
							                } else {
							            %>
										<h3>카테고리 데이터를 로드할 수 없습니다</h3>
										<%
							                }
							            %>
									</ul>
								</div>
							<div id="category-container">
								<% for(ExpertIntroduce i : expertList) {%>
								<div class="info-container" onclick="viewSelectedExpert(<%=i.getMemberNo()%>);">
									<div class="expert-profile">
									    <% 
									        String profileName = i.getProfileName(); // 데이터베이스에서 가져온 값
									        if (profileName == null || profileName.trim().isEmpty()) { 
									    %>
									        <img alt="기본이미지" src="/resources/profile/default.png" style="width: 100%">
									    <% 
									        } else { 
									    %>
									        <img alt="프로필이미지" src="<%= i.getProfilePath() %><%=i.getProfileName() %>" style="width: 100%">
									    <% 
									        } 
									    %>
									</div>
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
        
        function otherCategories(thirdCode, thirdName, secondCode){
            $.ajax({
                url: "/categories/changeThirdCategories.exco",
                type: "GET",
                data: {
                    "thirdCode": thirdCode,
                    "thirdName": thirdName,
                    "secondCode": secondCode
                },
                success: function(response) {
                    // 화면 업데이트 로직
                    const categoryContainer = document.getElementById("category-container"); // 업데이트할 HTML 요소 ID
                    const subHeader = document.getElementById("sub-header");
                    console.log('확인 : '+response);
                    if (categoryContainer) {
                        categoryContainer.innerHTML = ""; // 기존 내용을 초기화
                        response.forEach(item => {
                            // 동적으로 HTML 추가
                            let chkImg = item.profileName;
                            if(!chkImg){
                            	item.profileName = 'default.png';
                            	item.profilePath = '/resources/profile/';
                            }
                            const categoryDiv = document.createElement("div");
                            categoryDiv.classList.add("category-item");
                            categoryDiv.innerHTML = '<div class="info-container" onclick="viewSelectedExpert('+item.memberNo+');">'+
								'<div class="expert-profile"><img src="'+item.profilePath+item.profileName+'" style="width: 100%"></div>'+
								'<div class="content-title">'+ item.introduceTitle + '</div>'+
								'<div>닉네임 :'+item.expertNickname+'</div>'+
								'<div>좋아요 수 :'+ item.expertLike+'</div>'+
								'<div>소개 글 :'+item.introduceContent+'</div>';
                            categoryContainer.appendChild(categoryDiv);
                        });
                        subHeader.innerHTML = thirdName;
                    } else {
                        console.error("HTML 요소를 찾을 수 없습니다.");
                    }
                },
                error: function() {
                    console.error("소분류 업데이트 실패");
                }
            });
        }
    </script>
</body>
</html>