<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			
				<div class="list-body">
					<div class="side-list">
						<ul class="side-menu-title">
							<li>회원관리</li>
						</ul>
						<ul class="side-menu">
							<li><a href="/admin/memberManage.exco?reqPage=1&searchName=report">신고내역 관리</a></li>
							<li><a href="#">전문가 승인 검토</a></li>
						</ul>
						<ul class="side-menu-title">
							<li>사이트 관리</li>
						</ul>
						<ul class="side-menu">
							<li><a href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4">공지사항 관리</a></li>
							<li><a href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5">FAQ 관리</a></li>
							<li><a href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6">1:1문의 작성</a></li>
							<li><a href="/board/adminManageCommunity.exco?reqPage=1&boardType=${board.boardType}&searchName=board">커뮤니티 관리</a></li>
							<li><a href="#">카테고리 관리</a></li>
							<li><a href="/admin/reportManageFrm.exco">신고항목 관리</a></li>
						</ul>
					</div>
					
					<div class="list-content">
						<div class="page-title">신고항목 관리</div>
						<h1>페이지 로드 테스트</h1>
					</div>
				</div>
			</section>
		</main>
		
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

</body>
</html>