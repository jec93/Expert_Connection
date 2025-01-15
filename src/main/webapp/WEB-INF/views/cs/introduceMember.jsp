<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Map<String, Object> categories = (Map<String, Object>) application.getAttribute("categories");
List<Map<String, Object>> firstCategories = (List<Map<String, Object>>) categories.get("firstCategories");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<main class="content">
			<section class="section cs-list-wrap">
				
				<div class="list-body">
					<div class="side-list">
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
					</div>
					<div class="list-content">
					<div class="page-title">사용자 사이트 이용 가이드</div>
						<div class="cs-content-header">
							<img id="cs-siteIntro-header" src="/resources/logo/expert_connection_logo_h_01.png">
							<h6>Expert Connection을 이용하는 사용자분들을 위한 사이트 이용 가이드입니다.</h6>
						</div>
						<div class="cs-content">
							<div class="cs-box">
								<div class="siteIntro-txt">
									<h2>다양한 분야의 전문가들을 만나 문제를 해결해보세요</h2>
								</div>
								<div class="siteIntro-body">
								<div class="introduce-txt">
										<h4>챗봇을 통해 원하는 전문가를 추천받아보세요</h4>
										<p>몇가지 필요한 정보만 알려주세요</p>
								</div>
									<div class="siteIntro-img"><img id="chatBot-img" src="/resources/images/chatBotSample.png"></div>
								</div>
								<div class="siteIntro-txt">
										<h4>카테고리 검색을 통해 전문가들의 정보를 직접 확인할 수도 있어요.</h4>
								</div>							 
								<div class="siteIntro-body">
									<div class="siteIntro-category">
									<%
			             			for (Map<String, Object> category : firstCategories) {
				             			switch ((String) category.get("FIRSTCATEGORYCD")) {
				             		    case "A0001":
				             		    	%>
				             		    	<div class="info-firstCategory" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
												<img id="category_icon" src="/resources/images/img_hobby.png"><br>
												취미
											</div>
											<%
				             		        break;
				             		    case "A0002":
				             		    	 %>
				             		    	 <div class="info-firstCategory" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
					             		    	 	<img id="category_icon" src="/resources/images/img_move.png"><br>
													이사
				             		    	 </div>
				             		        <%
				             		        break;
				             		   case "A0003":
				             			    %>
				             			    <div class="info-firstCategory" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
					             		    	 	<img id="category_icon" src="/resources/images/img_outsourcing.png"><br>
													외주
				             		    	</div>
				             			    <%
				             		    	break;
				             		   case "A0004":
				             			   %>
				             			   <div class="info-firstCategory" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
					             		    	 	<img id="category_icon" src="/resources/images/img_event.png"><br>
													이벤트
				             		    	</div>
				             			   <%
				             		    	break;
				             		   case "A0005":
				             			  %>
				             			   <div class="info-firstCategory" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
					             		    	 	<img id="category_icon" src="/resources/images/img_beuaty.png"><br>
													뷰티
				             		    	</div>
				             			   <%
				             		    	break;
				             		   case "A0006":
			             			  %>
			             			   <div class="info-firstCategory" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
				             		    	 	<img id="category_icon" src="/resources/images/img_job.png"><br>
												취업
			             		    	</div>
			             			   <%
			             		    	break;
			             		   case "A0007":
			             			  %>
			             			   <div class="info-firstCategory" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
				             		    	 	<img id="category_icon" src="/resources/images/img_lesson.png"><br>
												과외
			             		    	</div>
			             			   <%
			             		    	break;
			             		   case "A0008":
			             			  %>
			             			   <div class="info-firstCategory" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">
				             		    	 	<img id="category_icon" src="/resources/images/img_vehicle.png"><br>
												차량
			             		    	</div>
			             			   <%
			             		    	break;
			             		   case "A0009":
			             			  %>
			             			   <div class="info-firstCategory" onclick="srchThirdCategories('<%= category.get("FIRSTCATEGORYCD") %>','<%= category.get("FIRSTCATEGORYNM") %>')">

				             		    	 	<img id="category_icon" src="/resources/images/img_finance_law.png"><br>
												금융/법률
			             			   		
			             		    	</div>
			             			   <%
			             			   break;
			             			}
		             		}
				          %>
									</div>
								</div>
								<div class="siteIntro-body">
									<div class="siteIntro-img">
										<img id="chat-img" src="/resources/images/chatSample.png">
									</div>
									<div class="introduce-txt">
										<h3>내게 맞는 전문가님을 선택하고 채팅을 요청하세요.</h3>
										<p>원하는 전문가님과 상담하고 서비스를 제공받으세요</p>
									</div>
								</div>
								<div class="siteIntro-txt">
									<h3>커뮤니티를 통해 더 많은 정보를 얻을 수도 있어요</h3>
									<div class="siteIntro-body">
										<div class="siteInfo-link-box">
						            		<div class="community-link">
							            		<a href="/board/list.exco?reqPage=1&boardType=0&boardTypeNm=0" class="info-community">
						            			<img id="community_icon" src="/resources/images/img_audience01.png">
								            		사용자 게시판 바로가기
							            		</a>
							            		<a href="/board/list.exco?reqPage=1&boardType=1&boardTypeNm=1" class="info-community">
							            		<img id="community_icon" src="/resources/images/img_audience02.png">
								            		전문가 게시판 바로가기
							            		</a>
						            			<a href="/board/list.exco?reqPage=1&boardType=2&boardTypeNm=2" class="info-community">
						            			<img id="community_icon" src="/resources/images/img_idea.png">
						            				전문가 노하우 바로가기
							            		</a>
							            		<a href="/board/list.exco?reqPage=1&boardType=3&boardTypeNm=3" class="info-community">
							            		<img id="community_icon" src="/resources/images/img_openbook.png">
							            			그룹레슨 찾아보기
							            		</a>
						            		</div>
					            		</div>
									</div>
								</div>
								<div class="siteIntro-txt">
									<h3>다른 사용자들과 전문가들을 배려하고 존중하는 사이트 이용을 부탁드립니다.</h3>
									<p>지나친 욕설 사용, 혹은 비방 및 음해 등의 건전하지 못한 사이트 이용은 신고의 대상이 될 수 있으며, </p>
									<p>일정 횟수의 신고 누적은 사이트 이용 일시 제한과 영구 제한으로 이어집니다.</p>
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