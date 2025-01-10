<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
						<div class="page-title">신고항목 관리</div>
						<div class="categories-manage-table">
							<div class="list-container">
								<div id = "report-cate-list" class="list-area"></div>
								<input type="button" class="btn-primary" onclick='updateCategory(3);' value="수정">
								<input type="button" class="btn-secondary" onclick='insertCategory();' value="추가">
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
		let categories = <%= new com.google.gson.Gson().toJson(categories) %>;
		console.log(categories);
		let reportCategories = categories.reportCategories
		.filter(item=> item.SECONDCATEGORYCD === '301_a0001');
		
		console.log(reportCategories);
		let reportListHtml ='';
		reportCategories.forEach(item => {
			reportListHtml += '<label><input type="radio" class="category-list" name="thirdCd" value="'+item.THIRDCATEGORYCD+'">'+item.THIRDCATEGORYNM +'</label><br>';
		});
		$('#report-cate-list').html(reportListHtml);
		
		function insertCategory(){
		
			let secondCd ='301_a0001';
			let firstCd = 'D0001';
			
			swal({
				icon: "info",
		        title: "추가하기",
		        text: "신고 항목 추가하기",
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
					
					location.href='/admin/insertCategory.exco?key=3&firstCd='+firstCd+'&secondCd='+secondCd+'&categoryNm='+inputValue;
				}
			});
		}
		function deleteThird(){
			swal({
				icon: "warning",
		        title: "삭제하기",
		        text: "신고 항목을 삭제합니다",   
		        buttons :["취소","확인"]
			}).then((value)=>{
				if(value){
					const selectedRadio = document.querySelector('input[name="thirdCd"]:checked').value;
					location.href= '/admin/deleteCategory.exco?thirdCode='+selectedRadio;
				}
			});
		}
		
		function updateCategory() {
		    swal({
		        icon: "info",
		        title: "수정하기",
		        text: "수정하기",
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
		            const selectedRadio = document.querySelector('input[name="thirdCd"]:checked').value;
		            // 새 입력값 읽기
		            const inputValue = document.getElementById('newValue').value;

		            if (selectedRadio && inputValue) {
		            	swal({
		            		icon:"warning",
		            		title:"수정하시겠습니까?",
		            		buttons:["취소", "확인"]
		            	}).then((value)=>{
		            		location.href= '/admin/updateCategoryBymdfInfo.exco?key=3&code='+selectedRadio+'&mdfName='+inputValue;		            		
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
	</script>
</body>
</html>