<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        width: 70%;
        max-width: 1200px;
        margin: 20px auto;
        background-color: white;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        padding: 20px;
    }

    .category-box {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
    }

    .category-item {
        background-color: #2f6b52;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        text-align: center;
        cursor: pointer;
        transition: background 0.3s;
        flex: 0 1 calc(20% - 10px);
    }

    .category-item.selected {
        background-color: #333;
        color: white;
    }

    .sub-header {
        font-size: 16px;
        font-weight: bold;
        color: rgb(2, 26, 0);
        text-align: center;
        border-radius: 5px;
        margin-top: 15px;
        margin-bottom: 15px;
        padding: 10px 20px;
    }

    .divider {
        border-bottom: 2px solid #ddd;
        margin: 10px 0;
    }
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<h1>카테고리 보기</h1>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		
		<main class="content">
			<section class="section">
			    <!-- 대분류 출력 -->
			    <div class="menu-container">
			            <%
			                // 모델에서 전달된 데이터를 사용
			
			                if (categories != null) {
			                    List<Map<String, Object>> firstCategories = (List<Map<String, Object>>) categories.get("firstCategories");
			             %>
			             		<div class="category-box">
			             <%
			             		for (Map<String, Object> category : firstCategories) {
			            %>
			                    <div class="category-item" onclick="loadSubCategories('<%= category.get("FIRSTCATEGORYCD") %>')">
			                        <%= category.get("FIRSTCATEGORYNM") %>
			                    </div>
			            <%
			                    }
			             %>
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
			    <div id="subCategories">
			        <h2>중분류 및 소분류</h2>
			        <div id="subList"></div>
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
                    .map(item => '<div class="category-item" onclick="navigateToCategoryResult(\'' + item.code + '\', \'' + item.name + '\', \'' + item.secondCategoryCd + '\')">' + item.name + '</div>')
                    .join('');
                subListDiv.append('<div class="category-box">'+thirdList+'</div>');
				}
            } else {
                subListDiv.append('<p>해당 대분류에 대한 데이터가 없습니다.</p>');
            }
        }
        
        function navigateToCategoryResult(thirdCategoryCd, thirdCategoryName, secondCategoryCd) {
        	const url = '/categories/categoriesResult.exco?cateKey=' + thirdCategoryCd +
            '&thirdName=' + thirdCategoryName +
            '&secondCode=' + secondCategoryCd;
			window.location.href = url;
        }
    </script>
</body>
</html>
