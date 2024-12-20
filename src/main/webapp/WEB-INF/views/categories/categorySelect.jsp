<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        margin: 5% auto;
        /*min-height는 모니터의 절반*/
        background-color: white;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        padding: 20px;
        display: flex;
        flex-direction: column;
    }
    .main-container {
        display: flex;
        gap: 20px;
    }
    
    .sub-content {
        flex: 3;
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
    }
    .sub-header {
        font-size: 16px;
        font-weight: bold;
        color: rgb(2, 26, 0);
        margin-bottom: 10px;
    }
    .divider {
        border-bottom: 2px solid #ddd;
        margin: 10px 0;
    }
    .leftCategory {
        flex: 1;
        padding: 10px;
        background-color: #f9f9f9;
        border-radius: 5px;
        text-align: center;
        font-weight: bold;
        color: #333;
        height: fit-content;
        flex: 0 1 calc(20% - 10px);
    }
    .left-item{
    	width:80%;
    	background-color: #2f6b52;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        text-align: center;
        cursor: pointer;
        transition: background 0.3s;
    }
</style>

<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section">
				<div class="menu-container">
			        <!-- 대분류 -->
			        <h1>전문가 추천</h1>
			        <div id="firstCategories" class="category-box"></div>
			        <div class="divider"></div>
			
			        <!-- 중분류 및 소분류 -->
			        <div class="main-container">
			            <!-- 왼쪽 중분류 -->
			            <div id="leftCategory" class="leftCategory"></div>
			
			            <!-- 오른쪽 소분류 -->
			            <div id="subList" class="sub-content"></div>
			        </div>
		    	</div>
			</section>
		</main>
		

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
    <script>
    $(document).ready(function () {
        loadFirstCategories();
    });
    
    // 대분류 로드
    function loadFirstCategories() {
        $.ajax({
            url: "/categories/firstCategory.exco",
            type: "GET",
            dataType: "json",
            success: function (data) {
                const dataArray = Object.values(data);
                dataArray.forEach(function (item) {
                    $('#firstCategories').append(
                        '<div class="category-item" onclick="loadSubCategories(this, \'' + item.FIRSTCODE + '\')">' + item.FIRSTNAME + '</div>'
                    );
                });
            },
            error: function (xhr, status, error) {
                console.error("AJAX Error:", error);
                alert("대분류 데이터를 가져오지 못했습니다.");
            }
        });
    }

    // 중분류 및 소분류 로드
    function loadSubCategories(element, firstCode) {
        $('#leftCategory').empty();
        $('#subList').empty();

        // 대분류 선택 스타일 변경
        $('.category-item.selected').removeClass('selected');
        $(element).addClass('selected');

        $.ajax({
            url: "/categories/sub/" + firstCode + ".exco",
            type: "GET",
            dataType: "json",
            success: function (data) {
                const dataArray = Object.values(data);
                const groupedData = groupSubCategories(dataArray);

                displayGroupedCategories(groupedData);
            },
            error: function (xhr, status, error) {
                console.error("AJAX Error for Subcategories:", error);
                alert("중분류 및 소분류 데이터를 가져오지 못했습니다.");
            }
        });
    }

    // 중소분류 데이터를 그룹화
    function groupSubCategories(dataArray) {
        const groupedData = {};
        dataArray.forEach(function (item) {
            if (!groupedData[item.SECONDNAME]) {
                groupedData[item.SECONDNAME] = [];
            }
            groupedData[item.SECONDNAME].push(item.THIRDNAME);
        });
        return groupedData;
    }

    // 그룹화된 중소분류 데이터를 출력
    function displayGroupedCategories(groupedData) {
        $('#leftCategory').append('<div class="category-box"></div>');
        for (const secondName in groupedData) {
            if (groupedData.hasOwnProperty(secondName)) {
                // 왼쪽 중분류 추가
                $('#leftCategory .category-box').append(
                    '<div class="left-item">' + secondName + '</div>'
                );

                // 오른쪽 소분류 출력
                $('#subList').append('<div class="sub-header">' + secondName + '</div>');
                let subHtml = '<div class="category-box">';
                groupedData[secondName].forEach(function (thirdName) {
                    subHtml += '<div class="category-item thirdCate" data-url="/categories/categoriesResult.exco?cateKey=' + thirdName + '">' + thirdName + '</div>';
                });
                subHtml += '</div>';

                $('#subList').append(subHtml);
            }
        }

        // 소분류 클릭 이벤트
        $('.thirdCate').on('click', function () {
            const url = $(this).data('url');
            window.location.href = url;
        });
    }
    </script>
</body>
</html>
