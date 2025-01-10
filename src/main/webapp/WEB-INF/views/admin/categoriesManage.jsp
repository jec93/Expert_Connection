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
<style>
	.categories-manage-table{
		margin: 0px 10%;
		height : 600px;
		display : flex;
		justify-content: space-between;
	}
	.list-container{
		margin: 0px 2%;
		width:35%;
	}
	.list-area{
		width: 90%;
		height : 75%;
		border:1px solid;
		margin-bottom: 10%;
	}
	.list-title{
		font-size: 20px;
		font-weight: bold;
		text-align: center;
 		font-family: ns-b;
  		color: var(--gray1);
  		margin : 20px auto;
	}
	.list-form{
		height: 100%;
	}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		
		<main class="content">
			<section class="section">
			
				<div class="list-body">
					<div class="side-list">
						<ul class="side-menu-title">
							<li>회원관리</li>
						</ul>
						<ul class="side-menu">
							<li><a href="/admin/memberReportManage.exco?reqPage=1&searchName=report">신고내역 관리</a></li>
							<li><a href="/admin/expertManagement.exco?reqPage=1&searchName=expected">전문가 승인 검토</a></li>
						</ul>
						<ul class="side-menu-title">
							<li>사이트 관리</li>
						</ul>
						<ul class="side-menu">
							<li><a href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4">공지사항 관리</a></li>
							<li><a href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5">FAQ 관리</a></li>
							<li><a href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6">1:1문의 작성</a></li>
							<li><a href="/board/adminManageCommunity.exco?reqPage=1&boardType=${board.boardType}&searchName=board">커뮤니티 관리</a></li>
							<li><a href="/categories/categoriesManage.exco">카테고리 관리</a></li>
							<li><a href="/admin/reportManageFrm.exco">신고항목 관리</a></li>
						</ul>
					</div>
					
					<div class="list-content">
						<div class="page-title">카테고리 관리</div>
						<div class="categories-manage-table">
							<div class="list-container">
								<div class="list-title">대분류</div>
								<div id="first-list" class="list-area"></div>
								<input type="button" class="btn-primary" onclick='updateCategory(1);' value="수정">
							</div>
							<div class="list-container">
								<div class="list-title">중분류</div>
								<div id="second-list" class="list-area"></div>
								<input type="button" class="btn-primary" onclick='updateCategory(2);' value="수정">
							</div>
							<div class="list-container">
								<div class="list-title">소분류</div>
								<div id="third-list" class="list-area"></div>
								<input type="button" class="btn-primary" onclick='updateCategory(3);' value="수정">
								<input type="button" class="btn-secondary" onclick='insertCategory(3);' value="추가">
								<input type="button" class="btn-tertiary" onclick='deleteThird();' value="삭제">
							</div>
						</div>
					</div>
				</div>
			</section>
		</main>
		
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
	function insertCategory(key){
		
		let cateType = '';
		let cateTypeCd = '';
		let secondCd ='';
		let firstCd = '';
		switch(key){
		case 1:
			cateType = '대분류';
			cateTypeCd = 'firstCate';
			firstCd = '0';
			secondCd ='0';
			break;
		case 2:
			cateType = '중분류';
			cateTypeCd = 'secondCate';
			firstCd=document.querySelector('input[name="firstCate"]:checked').value;
			secondCd ='0';
			break;
		case 3:
			cateType = '소분류';
			cateTypeCd = 'thirdCate';
			firstCd=document.querySelector('input[name="firstCate"]:checked').value;
			secondCd=document.querySelector('input[name="secondCate"]:checked').value;
			break;
		}
		
		swal({
			icon: "info",
	        title: "추가하기",
	        text: cateType+"추가하기",
	        content: {
	            element: "div",
	            attributes: {
	                innerHTML: '<input type="text" id="newValue" placeholder="새 값 입력">'
	            }
	        },
	        buttons: ["취소", "확인"]
		}).then((value)=>{
			if(value){
				const inputValue = document.getElementById('newValue').value;
				
				location.href='/admin/insertCategory.exco?key='+key+'&firstCd='+firstCd+'&secondCd='+secondCd+'&categoryNm='+inputValue;
			}
		});
	}
	
	function deleteThird(){
		swal({
			icon: "warning",
	        title: "삭제하기",
	        text: "소분류 삭제합니다",   
	        buttons :["취소","확인"]
		}).then((value)=>{
			if(value){
				const selectedRadio = document.querySelector('input[name="thirdCate"]:checked').value;
				location.href= '/admin/deleteCategory.exco?thirdCode='+selectedRadio;
			}
		});
	}
	
	
	
	function updateCategory(key) {
		let cateType = '';
		let cateTypeCd = '';
		switch(key){
		case 1:
			cateType = '대분류';
			cateTypeCd = 'firstCate';
			break;
		case 2:
			cateType = '중분류';
			cateTypeCd = 'secondCate';
			break;
		case 3:
			cateType = '소분류';
			cateTypeCd = 'thirdCate';
			break;
		}
	    swal({
	        icon: "info",
	        title: "수정하기",
	        text: cateType+"수정하기",
	        content: {
	            element: "div",
	            attributes: {
	                innerHTML: '<input type="text" id="newValue" placeholder="새 값 입력">'
	            }
	        },
	        buttons: ["취소", "확인"]
	    }).then((value) => {
	        if (value) {
	            // 라디오 버튼에서 선택된 값 읽기
	            const selectedRadio = document.querySelector('input[name="'+cateTypeCd+'"]:checked').value;
	            // 새 입력값 읽기
	            const inputValue = document.getElementById('newValue').value;

	            if (selectedRadio && inputValue) {
	            	swal({
	            		icon:"warning",
	            		title:"수정하시겠습니까?",
	            		buttons:["취소", "확인"]
	            	}).then((value)=>{
	            		location.href= '/admin/updateCategoryBymdfInfo.exco?key='+key+'&code='+selectedRadio+'&mdfName='+inputValue;		            		
	            	});
	            } else {
	                swal({
	                    icon: "error",
	                    title: "오류",
	                    text: "라디오 버튼과 인풋 값을 모두 입력하세요!"
	                });
	            }
	        }
	    });
	}
	
		let categories = <%= new com.google.gson.Gson().toJson(categories) %>;
		let firstCategoriesList = categories.firstCategories; //대분류 카테고리
		let subCategoriesList = categories.subCategories;	//중,소 카테고리
		console.log(firstCategoriesList);
		console.log(subCategoriesList);
		
		$(document).ready(function(){
			let firstDivList = '';
			for(let i=0; i<firstCategoriesList.length;i++){
				firstDivList += '<label><input type="radio" name="firstCate" value="'+firstCategoriesList[i].FIRSTCATEGORYCD+'" onclick="viewSecondList(\''+firstCategoriesList[i].FIRSTCATEGORYCD+'\');">'+firstCategoriesList[i].FIRSTCATEGORYNM+'</label><br>';
			}
			$('#first-list').html(firstDivList);
		});
		function viewSecondList(firstCd){
			$('#third-list').html('');
			let secondList = subCategoriesList
            .filter(item => item.FIRSTCATEGORYCD === firstCd) // 조건에 맞는 항목 필터링
            .map(item => ({
                SECONDCATEGORYCD: item.SECONDCATEGORYCD,
                SECONDCATEGORYNM: item.SECONDCATEGORYNM
            }));
			
			// 중복 제거
			let uniqueSecondList = Array.from(
			    new Map(
			        secondList.map(item => [item.SECONDCATEGORYCD, item])
			    ).values()
			);

			let secondDivList = '';
			for (let i = 0; i < uniqueSecondList.length; i++) {
			    secondDivList += '<label><input type="radio" name="secondCate" value="'+uniqueSecondList[i].SECONDCATEGORYCD+'" onclick="viewThirdList(\'' + uniqueSecondList[i].SECONDCATEGORYCD + '\')">' + uniqueSecondList[i].SECONDCATEGORYNM+'</label><br>';
			}
			$('#second-list').html(secondDivList);
		}
		function viewThirdList(secondCd){
			let thirdList = subCategoriesList
            .filter(item => item.SECONDCATEGORYCD === secondCd) // 조건에 맞는 항목 필터링
            .map(item => ({
            	THIRDCATEGORYCD: item.THIRDCATEGORYCD,
            	THIRDCATEGORYNM: item.THIRDCATEGORYNM
            }));
			console.log(thirdList);

			let thirdDivList = '';
			for(let i=0; i<thirdList.length; i++){
				thirdDivList += '<label><input type="radio" name="thirdCate" value="'+thirdList[i].THIRDCATEGORYCD+'">'+thirdList[i].THIRDCATEGORYNM+'</label><br>';
			}
			$('#third-list').html(thirdDivList);
		}
	</script>
</body>
</html>