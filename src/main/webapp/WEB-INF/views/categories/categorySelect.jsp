<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    	Map<String, Object> categories = (Map<String, Object>) request.getAttribute("categories");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
    .menu-container {
        width: 85%;
        max-width: 1200px;
        margin: 20px auto;
        background-color: white;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        padding: 20px;
    }
    
    .search-area{
		width: 85%;
		margin: 20px auto;
		padding: 20px;
		justify-content: center;
		display: flex;
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
    
    .subCategories{
    	width:80%;
    	margin:0px auto;
    }
    
    .firstCategory-container {
    display : flex;
	flex-wrap : wrap;
    margin: 2px;
    gap : 15px;
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

    .sub-header {
        font-size: 20px;
        font-weight: bold;
        color: rgb(2, 26, 0);
        text-align: center;
        border-radius: 5px;
		margin : 15px auto;
        padding: 10px 20px;
    }

    .divider {
        border-bottom: 2px solid #ddd;
        margin: 10px 0;
    }
    #subList{
        flex-wrap: wrap;
        gap: 10px;
    }
    .category-item{
	display : flex;
	flex-wrap : wrap;
	justify-content: center;
	height : fit-content;
	margin : 10px;
	}
    .category-box {
		height : fit-content;
		display: flex;
		flex-wrap: wrap;
		justify-content: center;
		align-content: center;
		/* flex-wrap : wrap; */
		gap : 8px;
	}
	.category-box a {
		 border: 1px solid rgba(255, 255, 255, .3);
		 overflow: hidden;
		 position: relative;
		 /* z-index: 20; */	/* 스크롤시 헤더 위로 올라가서 주석처리*/
		  border-radius: 30px;
	}
	.category-box a:after {
	  background: #fff;
	  content: "";
	  height: 155px;
	  left: -75px;
	  opacity: 0.2;
	  position: absolute;
	  top: -50px;
	  -webkit-transform: rotate(35deg);
	  transform: rotate(35deg);
	  transition: all 550ms cubic-bezier(0.19, 1, 0.22, 1);
	  width: 50px;
	  z-index: 1;
	  transition-delay: 0.4s;
	  border-radius: 30px;
	}
	.category-box a:hover:after {
	  left: 120%;
	  transition: all 550ms cubic-bezier(0.19, 1, 0.22, 1);
	  border-radius: 30px;
	}
    .cs-conList {
		display : flex;
		flex-basis : 250px;
		width : 250px;
		height : 40px;
		line-height : 40px;
		background-color : var(--main3);
		border-radius : 30px;
		/* border: 1px solid var(--main2); */
		justify-content : center;
		align-content: center;
		justify-items:center;
		color : var(--gray8);
		font-size: 15px;
		margin : 10px;
	}
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<h1>카테고리 보기</h1>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		
		<main class="content">
			<section class="section board-list-wrap">
				<div class="list-body">
				    <div class="list-content">
		    			<form action="/categories/searchThirdNm.exco" method="get">
					    	<div class="search-area">
					    		<div class="search-container">
					    			<button></button>
								    <input type="text" class="search-input" placeholder="Search" oninput="showSuggestions(this.value)" name="keyword">
								    <ul class="suggestions" id="suggestions-list"></ul>
								  </div>
					    	</div>
		    			</form>
					    <!-- 대분류 출력 -->
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
						             		    	<div class="firstCategory-container" onclick="loadSubCategories('<%= category.get("FIRSTCATEGORYCD") %>')">
						             		    		<div class="display-firstCate">
															<img id="category_icon" src="/resources/images/img_hobby.png"><br>
															취미
						             			   		</div>
													</div>
													<%
						             		        break;
						             		    case "A0002":
						             		    	 %>
						             		    	 <div class="firstCategory-container" onclick="loadSubCategories('<%= category.get("FIRSTCATEGORYCD") %>')">
						             		    	 	<div class="display-firstCate">
							             		    	 	<img id="category_icon" src="/resources/images/img_move.png"><br>
															이사
						             			   		</div>
						             		    	 </div>
						             		        <%
						             		        break;
						             		   case "A0003":
						             			    %>
						             			    <div class="firstCategory-container" onclick="loadSubCategories('<%= category.get("FIRSTCATEGORYCD") %>')">
						             			    	<div class="display-firstCate">
							             		    	 	<img id="category_icon" src="/resources/images/img_outsourcing.png"><br>
															외주
						             			   		</div>
						             		    	</div>
						             			    <%
						             		    	break;
						             		   case "A0004":
						             			   %>
						             			   <div class="firstCategory-container" onclick="loadSubCategories('<%= category.get("FIRSTCATEGORYCD") %>')">
						             			   		<div class="display-firstCate">
							             		    	 	<img id="category_icon" src="/resources/images/img_event.png"><br>
															이벤트
						             			   		</div>
						             		    	</div>
						             			   <%
						             		    	break;
						             		   case "A0005":
						             			  %>
						             			   <div class="firstCategory-container" onclick="loadSubCategories('<%= category.get("FIRSTCATEGORYCD") %>')">
						             			   		<div class="display-firstCate">
							             		    	 	<img id="category_icon" src="/resources/images/img_beuaty.png"><br>
															뷰티
						             			   		</div>
						             		    	</div>
						             			   <%
						             		    	break;
						             		   case "A0006":
						             			  %>
						             			   <div class="firstCategory-container" onclick="loadSubCategories('<%= category.get("FIRSTCATEGORYCD") %>')">
						             			   		<div class="display-firstCate">
							             		    	 	<img id="category_icon" src="/resources/images/img_job.png"><br>
															취업
						             			   		</div>
						             		    	</div>
						             			   <%
						             		    	break;
						             		   case "A0007":
						             			  %>
						             			   <div class="firstCategory-container" onclick="loadSubCategories('<%= category.get("FIRSTCATEGORYCD") %>')">
						             			   		<div class="display-firstCate">
							             		    	 	<img id="category_icon" src="/resources/images/img_lesson.png"><br>
															과외
						             			   		</div>
						             		    	</div>
						             			   <%
						             		    	break;
						             		   case "A0008":
						             			  %>
						             			   <div class="firstCategory-container" onclick="loadSubCategories('<%= category.get("FIRSTCATEGORYCD") %>')">
						             			   		<div class="display-firstCate">
							             		    	 	<img id="category_icon" src="/resources/images/img_vehicle.png"><br>
															차량
						             			   		</div>
						             		    	</div>
						             			   <%
						             		    	break;
						             		   case "A0009":
						             			  %>
						             			   <div class="firstCategory-container" onclick="loadSubCategories('<%= category.get("FIRSTCATEGORYCD") %>')">
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
					    <!-- 중분류 및 소분류 출력 -->
					    <div class="subCategories">
					        <h2>중분류 및 소분류</h2>
					        <div id="subList"></div>
					    </div>
				    </div>
				</div>
			</section>
		</main>
		
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>


    <script>
        // JSON 데이터는 모델에서 전달되었다고 가정
        const categories = <%= new com.google.gson.Gson().toJson(categories) %>;
        
        // 중분류 및 소분류 로드 함수
        function loadSubCategories(firstCategoryCd) {
            const subCategories = categories.subCategories.filter(sub => sub.FIRSTCATEGORYCD === firstCategoryCd);
            const subListDiv = $('#subList');
            subListDiv.empty(); // 기존 데이터 초기화

            if (subCategories.length > 0) {
                // 중분류 및 소분류 그룹화
                const groupedSubCategories = {};
                subCategories.forEach(sub => {
                    const secondName = sub.SECONDCATEGORYNM;
                    if (!groupedSubCategories[secondName]) {
                        groupedSubCategories[secondName] = [];
                    }
                    groupedSubCategories[secondName].push({ name: sub.THIRDCATEGORYNM, code: sub.THIRDCATEGORYCD, secondCategoryCd: sub.SECONDCATEGORYCD });
                });

                // 중분류 및 소분류 출력
                for (const [secondName, thirdItems] of Object.entries(groupedSubCategories)) {
				    // 중분류 제목 추가
				    subListDiv.append('<div class="sub-header">' + secondName + '</div>');
				
				    // 소분류 목록 추가
				    
				    const thirdList = thirdItems
                    .map(item => '<div class="category-item"><a class="cs-conList" href="/categories/categoriesResult.exco?thirdCode='+ item.code + '&thirdName=' + item.name + '&secondCode=' + item.secondCategoryCd+'">' + item.name + '</a></div>')
                    .join('');
                subListDiv.append('<div class="category-box">'+thirdList+'</div>');
				}
            } else {
                subListDiv.append('<p>해당 대분류에 대한 데이터가 없습니다.</p>');
            }
        }
        const data = categories.subCategories;
        const sampleSuggestions = data.map(item => item.THIRDCATEGORYNM);

        console.log(sampleSuggestions); // 결과 확인

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
    </script>
</body>
</html>
