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
	Map<String, Object> categories = (Map<String, Object>) application.getAttribute("categories");
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
	display: flex;
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
	width: 280px;
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
.firstCategory-container {
	    display : flex;
		flex-wrap : wrap;
	    margin: 2px;
	    gap : 15px;
	    cursor: pointer;
	}
.display-firstCate {
	width : 80px;
	border-radius : 20px;
	display : grid;
	justify-items: center;
	padding : 5px 5px 15px 5px;
	line-height: 10px;
	background-color : var(--gray8);
    color: var(--main1);
    box-shadow: 0 1px 1px rgba(0,0,0,0.1), 0 1px 2px rgba(0,0,0,0.1);
  	transition: all 0.3s cubic-bezier(.25,.8,.25,1);
	}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section board-list-wrap">
				<div class="list-body">
				<div class="list-content">
				<%
		                // 모델에서 전달된 데이터를 사용
		
		                if (categories != null) {
		                    List<Map<String, Object>> firstCategories = (List<Map<String, Object>>) categories.get("firstCategories");
				             %>
				             <div class="siteIntro-body"> 							
							 <div class="siteIntro-category">
							 <div class="side-list">
				             <%
		             			for (Map<String, Object> category : firstCategories) {
			             			switch ((String) category.get("FIRSTCATEGORYCD")) {
			             		    case "A0001":
			             		    	%>
			             		    	<div class="firstCategory-container" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
			             		    		<div class="display-firstCate">
												<img id="category_icon" src="/resources/images/img_hobby.png"><br>
												취미
			             			   		</div>
										</div>
										<%
			             		        break;
			             		    case "A0002":
			             		    	 %>
			             		    	 <div class="firstCategory-container" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
			             		    	 	<div class="display-firstCate">
				             		    	 	<img id="category_icon" src="/resources/images/img_move.png"><br>
												이사
			             			   		</div>
			             		    	 </div>
			             		        <%
			             		        break;
			             		   case "A0003":
			             			    %>
			             			    <div class="firstCategory-container" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
			             			    	<div class="display-firstCate">
				             		    	 	<img id="category_icon" src="/resources/images/img_outsourcing.png"><br>
												외주
			             			   		</div>
			             		    	</div>
			             			    <%
			             		    	break;
			             		   case "A0004":
			             			   %>
			             			   <div class="firstCategory-container" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
			             			   		<div class="display-firstCate">
				             		    	 	<img id="category_icon" src="/resources/images/img_event.png"><br>
												이벤트
			             			   		</div>
			             		    	</div>
			             			   <%
			             		    	break;
			             		   case "A0005":
			             			  %>
			             			   <div class="firstCategory-container" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
			             			   		<div class="display-firstCate">
				             		    	 	<img id="category_icon" src="/resources/images/img_beuaty.png"><br>
												뷰티
			             			   		</div>
			             		    	</div>
			             			   <%
			             		    	break;
			             		   case "A0006":
			             			  %>
			             			   <div class="firstCategory-container" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
			             			   		<div class="display-firstCate">
				             		    	 	<img id="category_icon" src="/resources/images/img_job.png"><br>
												취업
			             			   		</div>
			             		    	</div>
			             			   <%
			             		    	break;
			             		   case "A0007":
			             			  %>
			             			   <div class="firstCategory-container" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
			             			   		<div class="display-firstCate">
				             		    	 	<img id="category_icon" src="/resources/images/img_lesson.png"><br>
												과외
			             			   		</div>
			             		    	</div>
			             			   <%
			             		    	break;
			             		   case "A0008":
			             			  %>
			             			   <div class="firstCategory-container" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
			             			   		<div class="display-firstCate">
				             		    	 	<img id="category_icon" src="/resources/images/img_vehicle.png"><br>
												차량
			             			   		</div>
			             		    	</div>
			             			   <%
			             		    	break;
			             		   case "A0009":
			             			  %>
			             			   <div class="firstCategory-container" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
			             			   		<div class="display-firstCate">
				             		    	 	<img id="category_icon" src="/resources/images/img_finance_law.png"><br>
												금융/법률
			             			   		</div>
			             		    	</div>
			             			   <%
			             			   break;
			             			}
		             		}
				          %>
		             	</div>
		             </div>
		             <%
		                } else {
		            %>
		                <h3>카테고리 데이터를 로드할 수 없습니다</h3>
		            <%
		                }
		            %>
				    	</div>
						<div class="menu-container">
							<div id="sub-header"><%=keyword %>검색 결과</div>
							<div id="tird-category-title" class="main-category">
							<div id="category-container">
								<% for(ExpertIntroduce i : srchList) {%>
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
        
        const categories = <%= new com.google.gson.Gson().toJson(categories) %>;
        const suggestData = categories.subCategories;
        const sampleSuggestions = suggestData.map(item => item.THIRDCATEGORYNM);
        
        function srchThirdCategories(FIRSTCATEGORYCD,FIRSTCATEGORYNM) {
        	// 주어진 FIRSTCATEGORYCD 값과 같은 데이터를 필터링하고 THIRDCATEGORYCD 값만 추출
            const thirdCategoryCDList = suggestData
                .filter(item => item.FIRSTCATEGORYCD === FIRSTCATEGORYCD) // 조건에 맞는 항목 필터링
                .map(item => item.THIRDCATEGORYCD); // THIRDCATEGORYCD 값만 추출
            location.href = '/categories/searchSubCategoriesList.exco?&thirdCategoryCDList='+thirdCategoryCDList+'&firstCategoryNm='+FIRSTCATEGORYNM;   	
        }
    </script>
</body>
</html>