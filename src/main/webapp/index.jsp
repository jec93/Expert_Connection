<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	Map<String, Object> categories = (Map<String, Object>) application.getAttribute("categories");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<style>
	.search-area{
		width: 85%;
		margin: 20px auto;
		padding: 20px;
		justify-content: center;
		display: flex;
		margin: 50px;
	}
	
	  .search-container button {
	    position: absolute;
	    right: 10px;
	    top: 50%;
	    transform: translateY(-50%);
	    background: url('/resources/images/icon_search.png') no-repeat center center;
	    background-size: 20px 20px;
	    width: 40px;
	    height: 40px;
	    border: none;
	    cursor: pointer;
	  }
	
	.search-container {
	  display: flex;
	  align-items: center;
	  width: 50%;
	  height: 50px;
	  background-color: var(--main3); /* 배경 색상 */
	  border-radius: 25px;
	  padding: 0 15px;
	  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	  position: relative;
	}

    .search-input {
      flex: 1;
      border: none;
      outline: none;
      background: transparent;
      color: white;
      font-size: 18px;
      padding-left: 10px;
      caret-color: white;
    }

    .search-input::placeholder {
      color: rgba(255, 255, 255, 0.7);
      font-style: italic;
    }

    .search-input:focus + .clear-button {
      display: inline;
    }
    .suggestions {
      position: absolute;
      top: 60px;
      left: 0;
      width: 100%;
      background: white;
      border: 2px solid red;
      border-radius: 8px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      z-index: 999;
      list-style: none;
      padding: 0;
      margin: 0;
      display: none;
      max-height: 200px;
      overflow-y: auto;
   }

    .suggestions li {
      padding: 10px 15px;
      cursor: pointer;
      color: #333;
    }

    .suggestions li:hover {
      background-color: #ff6600;
      color: white;
    }
   
	.info-expert-container{
		width : 300px;
		box-shadow: 0 4px 8px var(--main3);
		margin : 15px;
		background-color: var(--main5);
		overflow: hidden;
		min-width: 250px; /* 각 전문가 박스 고정 크기 */
    	flex-shrink: 0; /* 크기 축소 방지 */
    	cursor: pointer;
	}
	.info-srch-container{
		width : 100px;
		height : 100px;
		box-shadow: 0 4px 8px var(--main3);
		margin : 15px;
		background-color: var(--main5);
		overflow: hidden;
		min-width: 100px; /* 각 전문가 박스 고정 크기 */
    	flex-shrink: 0; /* 크기 축소 방지 */
    	cursor: pointer;
	}
	/* 전체 영역 설정 */
	.expert-carousel {
	    display: flex;
	    align-items: center;
	    position: relative;
	    overflow: hidden; /* 넘치는 콘텐츠 숨기기 */
	    width: 100%; /* 전체 너비 사용 */
	}
	
	/* 전문가 콘텐츠 스타일 */
	.carousel-content {
		width: 90%;
        max-width: 1200px;
        margin: 20px auto;
        background-color: white;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
	    display: flex;
	    gap: 15px; /* 콘텐츠 간 간격 */
	    overflow-x: auto; /* 가로 스크롤 활성화 */
	    scroll-behavior: smooth; /* 부드러운 스크롤 */
	    width: calc(100% - 80px); /* 버튼 크기 제외한 너비 */
	    padding: 10px 0;
	    -ms-overflow-style: none; /* IE에서 스크롤바 숨기기 */
   		scrollbar-width: none; /* Firefox에서 스크롤바 숨기기 */
	}

	/* 화살표 버튼 스타일 */
	.carousel-btn {
	    position: absolute;
	    top: 50%; /* 세로 기준 중앙 */
	    transform: translateY(-50%); /* 정확히 중앙 정렬 */
	    background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
	    color: white; /* 화살표 색상 */
	    border: none; /* 테두리 제거 */
	    border-radius: 50%; /* 원형 버튼 */
	    width: 40px; /* 버튼 크기 */
	    height: 40px;
	    cursor: pointer; /* 포인터 커서 */
	    z-index: 10; /* 콘텐츠 위로 배치 */
	    display: flex;
	    justify-content: center; /* 화살표 가운데 정렬 */
	    align-items: center; /* 화살표 가운데 정렬 */
	}
	
	/* 이전 버튼 */
	.prev-btn {
	    left: 10px; /* 박스 왼쪽으로부터 10px */
	}
	
	/* 다음 버튼 */
	.next-btn {
	    right: 10px; /* 박스 오른쪽으로부터 10px */
	}
	

	.subCategories{
    	width:80%;
    	margin:0px auto;
    }
    
    .expert-profile {
		width: 150px;
		height: 150px;
		border: 1px solid;
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
	[id^="show-"]{
		display:flex;
	}
	.content-title{
		font-size: 20px;
		font-weight: bold;
	}
	.srch-title{
		font-size:20px;
		font-weight: bold;
	}
	.srch-content{
		font-size:15px;
	}

</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<main class="content">
			<section class="section">
				<form action="/categories/searchThirdNm.exco" method="get">
			    	<div class="search-area">
			    		<div class="search-container">
			    			<button></button>
						    <input type="text" class="search-input" placeholder="Search" oninput="showSuggestions(this.value)" name="keyword">
						    <ul class="suggestions" id="suggestions-list"></ul>
						  </div>
			    	</div>
    			</form>
				 <div class="menu-container">
		            <%
		                // 모델에서 전달된 데이터를 사용
		
		                if (categories != null) {
		                    List<Map<String, Object>> firstCategories = (List<Map<String, Object>>) categories.get("firstCategories");
				             %>
				             <div class="siteIntro-body"> 							
							 <div class="siteIntro-category">
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
				<h1>요즘 인기있는 전문가</h1>
				<div class="expert-carousel">
				    <button class="carousel-btn prev-btn" onclick="scrollExpert(-1)">&#10094;</button>
				    <div id="show-expert" class="carousel-content"></div>
				    <button class="carousel-btn next-btn" onclick="scrollExpert(1)">&#10095;</button>
				</div>
				<h1>요즘 인기있는 서비스</h1>
				<div class="expert-carousel">
				    <button class="carousel-btn prev-btn" onclick="scrollSrch(-1)">&#10094;</button>
				    <div id="show-categories" class="carousel-content"></div>
				    <button class="carousel-btn next-btn" onclick="scrollSrch(1)">&#10095;</button>
				</div>
			</section>
		</main>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
	const categories = <%= new com.google.gson.Gson().toJson(categories) %>;
	console.log(categories);
	
		$(document).ready(function(){
			$.ajax({
				url:'/common/indexData.exco',
				method:'Get',
				success:function(data){
					
					let expRank = data.expertList;
					let keyRank = data.rankKeywords;
					console.log(expRank);
					console.log(keyRank);
					let expertHtml = '';
					expRank.forEach(item=>{
						let chkImg = item.profileName;
                        if(!chkImg){
                        	item.profileName = 'default.png';
                        	item.profilePath = '/resources/profile/';
                        }
                        expertHtml +='<div class="info-expert-container" onclick="viewSelectedExpert('+item.memberNo+');"><div class="expert-profile"><img src="'+item.profilePath+item.profileName+'" style="width: 100%"></div>'
						expertHtml +='<div class="content-title">'+item.introduceTitle+'</div>';
						expertHtml +='<div>닉네임 : '+item.expertNickname+'</div>';
						expertHtml +='<div>주소 : '+item.expertAddr+'</div>';
						expertHtml +='<div>'+item.introduceContent+'</div>';
						expertHtml +='<div>좋아요 : '+item.expertLike+'</div></div>';
					});
					$('#show-expert').html(expertHtml);
					
					
					let keyHtml = "";
					keyRank.forEach(item=>{
						console.log(item);
						keyHtml += '<div class="info-srch-container" onclick="viewSelectedCategory(\''+item.thirdCategoryNm+'\',\''+item.secondCategoryCd+'\',\''+item.thirdCategoryCd+'\')"><div class="srch-title">'+item.thirdCategoryNm+'</div>'
						keyHtml += '<div class="srch-content">검색 횟수 : '+item.srchCnt+'</div></div>'
					});
					$('#show-categories').html(keyHtml);
				}
			});
		})
		
		
		const suggestData = categories.subCategories;
        const sampleSuggestions = suggestData.map(item => item.THIRDCATEGORYNM);
        
        function srchThirdCategories(FIRSTCATEGORYCD,FIRSTCATEGORYNM) {
        	// 주어진 FIRSTCATEGORYCD 값과 같은 데이터를 필터링하고 THIRDCATEGORYCD 값만 추출
            const thirdCategoryCDList = suggestData
                .filter(item => item.FIRSTCATEGORYCD === FIRSTCATEGORYCD) // 조건에 맞는 항목 필터링
                .map(item => item.THIRDCATEGORYCD); // THIRDCATEGORYCD 값만 추출
            location.href = '/categories/searchSubCategoriesList.exco?&thirdCategoryCDList='+thirdCategoryCDList+'&firstCategoryNm='+FIRSTCATEGORYNM;   	
        }
          function showSuggestions(value) {
            const suggestionsList = document.getElementById("suggestions-list");
              
            if (!value) {
              suggestionsList.style.display = "none";
              return;
            }

            const filteredSuggestions = sampleSuggestions.filter((suggestion) =>
              suggestion.toLowerCase().includes(value.toLowerCase())
            );

            suggestionsList.innerHTML = filteredSuggestions
              .map((item) => '<li onclick="selectSuggestion(\''+item+'\')">'+item+'</li>')
              .join("");

            suggestionsList.style.display = "block";
          }

          function selectSuggestion(value) {
            const searchInput = document.querySelector(".search-input");
            searchInput.value = value;
            document.getElementById("suggestions-list").style.display = "none";
          }
          
          function viewSelectedExpert(memberNo){
          	location.href = '/expert/viewExpertInfoByMemberNo.exco?&memberNo='+memberNo;
          }
          function viewSelectedCategory(thirdName,secondCode,thirdCode){
            	location.href = '/categories/categoriesResult.exco?&thirdCode='+thirdCode+'&thirdName='+thirdName+'&secondCode='+secondCode;
          }
          
          function scrollExpert(direction) {
        	    const carouselContent = document.getElementById("show-expert"); // 콘텐츠 영역 가져오기
        	    const scrollAmount = 600; // 한 번에 스크롤할 픽셀 양 (조정 가능)
        	    const maxScrollLeft = carouselContent.scrollWidth - carouselContent.clientWidth; // 최대 스크롤 가능한 거리

        	    // 현재 스크롤 위치 확인
        	    const currentScrollLeft = carouselContent.scrollLeft;

        	    if (direction === 1) {
        	        // 오른쪽 버튼 눌렀을 때
        	        if (currentScrollLeft >= maxScrollLeft - 5) { 
        	            // 맨 끝에 도달했을 경우 (오차 5px 허용)
        	            carouselContent.scrollTo({
        	                left: 0,
        	                behavior: "smooth",
        	            });
        	        } else {
        	            // 아직 끝이 아니면 일반 스크롤
        	            carouselContent.scrollBy({
        	                left: scrollAmount,
        	                behavior: "smooth",
        	            });
        	        }
        	    } else if (direction === -1) {
        	        // 왼쪽 버튼 눌렀을 때
        	        if (currentScrollLeft <= 5) { 
        	            // 맨 처음에 도달했을 경우 (오차 5px 허용)
        	            carouselContent.scrollTo({
        	                left: maxScrollLeft,
        	                behavior: "smooth",
        	            });
        	        } else {
        	            // 아직 처음이 아니면 일반 스크롤
        	            carouselContent.scrollBy({
        	                left: -scrollAmount,
        	                behavior: "smooth",
        	            });
        	        }
        	    }
        	}

          
          function scrollSrch(direction) {
       	    const carouselContent = document.getElementById("show-categories"); // 콘텐츠 영역 가져오기
       	    const scrollAmount = 300; // 한 번에 스크롤할 픽셀 양 (조정 가능)
       	 	const maxScrollLeft = carouselContent.scrollWidth - carouselContent.clientWidth; // 최대 스크롤 가능한 거리
       	 	
       		// 현재 스크롤 위치 확인
    	    const currentScrollLeft = carouselContent.scrollLeft;
       	 	
    	    if (direction === 1) {
    	        // 오른쪽 버튼 눌렀을 때
    	        if (currentScrollLeft >= maxScrollLeft - 5) { 
    	            // 맨 끝에 도달했을 경우 (오차 5px 허용)
    	            carouselContent.scrollTo({
    	                left: 0,
    	                behavior: "smooth",
    	            });
    	        } else {
    	            // 아직 끝이 아니면 일반 스크롤
    	            carouselContent.scrollBy({
    	                left: scrollAmount,
    	                behavior: "smooth",
    	            });
    	        }
    	    } else if (direction === -1) {
    	        // 왼쪽 버튼 눌렀을 때
    	        if (currentScrollLeft <= 5) { 
    	            // 맨 처음에 도달했을 경우 (오차 5px 허용)
    	            carouselContent.scrollTo({
    	                left: maxScrollLeft,
    	                behavior: "smooth",
    	            });
    	        } else {
    	            // 아직 처음이 아니면 일반 스크롤
    	            carouselContent.scrollBy({
    	                left: -scrollAmount,
    	                behavior: "smooth",
    	            });
    	        }
    	    }
    	}
	</script>
</body>
</html>