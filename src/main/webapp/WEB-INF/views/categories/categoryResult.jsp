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
<link rel="icon" href="/resources/logo/expert_connection_favicon.png" />
<link rel="apple-touch-icon"
	href="/resources/logo/expert_connection_favicon.png" />
<style>
.menu-container {
	width: 70%;
	max-width: 1200px;
	margin: 0 auto;
	background-color: white;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	padding: 20px;
	display: flex;
}

.left-cateogry{

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

.main-category {
	margin-left: 5%;
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
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section">
				<h1>카테고리 결과</h1>
				
				유저 정보 만들어지면 제작, 같은 중분류인 다른 소분류 클릭시 제목 변경<br>
				추후 관련 유저 출력 구현<br>
				
				(추후에 쓰려고 적어둠)<br>
				<p>
					선택된 소분류 코드:
					<%= request.getParameter("cateKey") %></p>
				<p>
					소분류 이름:
					<%= request.getParameter("thirdName") %></p>
				<p>
					소분류가 포함된 중분류 코드:
					<%= request.getParameter("secondCode") %></p>

				<div class="menu-container">
					<div class="left-category">
						<ul>
							<%
			                if (categories != null) {
			                	List<Map<String, Object>> subCategories = (List<Map<String, Object>>) categories.get("subCategories");
			                	for(Map<String, Object> c : subCategories){
			                		if(c.get("SECONDCATEGORYCD").equals(request.getParameter("secondCode"))){
			                		%>
							<li class="other-categories" data-value="<%= c.get("THIRDCATEGORYNM")%>">
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
					<div id="tird-category-title" class="main-category">
						<div class="sub-header"><%=request.getParameter("thirdName") %></div>
					</div>
				</div>
			</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
        // 모든 .clickable 요소를 선택
        const divs = document.querySelectorAll('.other-categories');

        // 각 div에 클릭 이벤트 추가
        divs.forEach(div => {
            div.addEventListener('click', (event) => {
                // 클릭된 div의 data-value 속성 값을 가져옴
                const value = event.target.getAttribute('data-value');

                // 화면 중간에 표시
                document.getElementById('tird-category-title').innerHTML = '<div class="sub-header">'+value+'</div>';
            });
        });
    </script>
</body>
</html>