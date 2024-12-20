<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<style>
	.menu-container{
		width: 70%;
        max-width: 1200px;
        margin: 0 auto;
        background-color: white;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        padding: 20px;
        display: flex;
	}
	.main-category{
		margin-left:5%;
	}
	.side-category{
	}
	.first-category{
		display:flex;
		flex-direction:column;
		padding : 5px;
		gap:10px;
	}
	.second-category{
        gap: 10px;
	}
    .third-category{
    	padding : 20px 30px;
    	display:flex;
    	flex-wrap: wrap;
    	gap:10px;
    }
    .divider {
        border-bottom: 2px solid #ddd;
        margin: 10px 0;
    }
    .expert-profile{
    	width : 150px;
    	height : 150px;
    	border : 1px solid;
    }
</style>
</head>
<body>
	<div class="wrap">
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section">
				<div class="menu-container">
			<div class="side-category">
				<div class="first-category">
					<ul>
						<li>firstCategoryName1
							<ul>
								<li>secondCategoryName1</li>
								<li>secondCategoryName2</li>
								<li>secondCategoryName3</li>
							</ul>
						</li>
						<li>firstCategoryName2
							<ul>
								<li>secondCategoryName1</li>
								<li>secondCategoryName2</li>
								<li>secondCategoryName3</li>
							</ul>
						</li>
						<li>firstCategoryName3
							<ul>
								<li>secondCategoryName1</li>
								<li>secondCategoryName2</li>
								<li>secondCategoryName3</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<div class="main-category">
				<div class="second-category">
					<div class="category-item">secondCategoryName1</div>
				</div>
				<div class="divider"></div>
				<h1>thirdCategoryName</h1>
				<div class="third-category">
				<div class="expert-profile">전문가 1</div>
				<div class="expert-profile">전문가 2</div>
				<div class="expert-profile">전문가 3</div>
				<div class="expert-profile">전문가 4</div>
				<div class="expert-profile">전문가 5</div>
				<div class="expert-profile">전문가 6</div>
				</div>
			</div>
		</div>
			</section>
		</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>