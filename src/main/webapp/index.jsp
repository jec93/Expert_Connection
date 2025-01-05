<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			<section class="section">
				<div>요즘 인기있는 전문가</div>
				<div id="show-expert"></div>
				
				<div>요즘 인기있는 서비스</div>
				<div id="show-categories"></div>
			</section>
		</main>

		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script>
		$(document).ready(function(){
			$.ajax({
				url:'/common/indexData.exco',
				method:'Get',
				success:function(data){
					
					let expRank = data.expertList;
					let keyRank = data.rankKeywords;
					console.log(expRank);
					console.log(keyRank);
					let expertHtml = "";
					expRank.forEach(item=>{
						expertHtml +='<div>'+item.introduceTitle+'</div>';
						expertHtml +='<div>닉네임 : '+item.expertNickname+'</div>';
						expertHtml +='<div>주소 : '+item.expertAddr+'</div>';
						expertHtml +='<div>'+item.introduceContent+'</div>';
						expertHtml +='<div>좋아요 : '+item.expertLike+'</div>';
					});
					$('#show-expert').html(expertHtml);
					
					
					let keyHtml = "";
					keyRank.forEach(item=>{
						keyHtml += '<div>검색 횟수 : '+item.srchCnt+'</div>'
						keyHtml += '<div>장르 : '+item.thirdCategoryNm+'</div>'
					});
					$('#show-categories').html(keyHtml);
				}
			});
		})
	</script>
</body>
</html>