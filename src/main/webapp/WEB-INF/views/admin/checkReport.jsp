<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="stylesheet" href="/resources/css/test.css" />
</head>
<style>
	body {
		background-color: var(--main3);
	}
</style>
<body>
	<div class="checkReport">
		<div class="checkReport-header">
			<img src="/resources/logo/expert_connection_logo_h_03.png" width="200px" height="30px">
		</div>
		<div class="checkReport-body">
			<div class="checkReport-content">
				<span id="reportTitle">신고번호</span>
				<span>${report.reportNo}</span>
			</div>
			<div class="checkReport-content">
				<span id="reportTitle">신고날짜</span>
				<span>${report.reportDate}</span>
			</div>
			<div class="checkReport-content">
				<span id="reportTitle">신고번호</span>
				<span>${report.reportNo}</span>
			</div>
			<div class="checkReport-content">
				<span id="reportTitle">신고한 회원</span>
				<span>${report.reporter}</span>
			</div>
			<div class="checkReport-content">
				<span id="reportTitle">신고받은 회원</span>
				<span>${report.suspect}</span>
			</div>
			<div class="checkReport-content">
				<span id="reportTitle">신고코드</span>
				<span>${report.thirdCategoryCd}</span>
			</div>
			<div class="checkReport-content">
				<span id="reportTitle">신고사유</span>
				<span>${report.thirdCategoryNM}</span>
			</div>
			<div class="checkReport-content">
				<span id="reportTitle">신고분류</span>
				<c:if test="${report.reportType eq '0'}">
		        <span>게시글</span>
		        </c:if>
		        <c:if test="${report.reportType eq '1'}">
		        <span>댓글</span>
		        </c:if>
			</div>
			<div class="checkReport-content">
				<span id="reportTitle">신고대상</span>
				<c:if test="${report.reportType eq '0'}">
				<span>${report.targetNo}</span><button class="btn-quaternary" onclick="checkTargetBoard('${report.targetNo}')">확인하기</button>
	         	</c:if>
	         	<c:if test="${report.reportType eq '1'}">
	         	<span>${report.targetNo}</span><button class="btn-quaternary" onclick="checkTargetComment('${report.targetNo}')">확인하기</button>
	         	</c:if>
			</div>	
		</div>
		<div class="checkReport-bottom">
			<button class="btn-primary" onclick="trueReport('${report.reportNo}, '${report.suspect}')">신고수리</button>
	        <button class="btn-tertiary" onclick="FakeReport('${report.reportNo}, '${report.reporter}')">허위신고</button>	
		</div>
	</div>
<script>
function checkTargetBoard(targetNo) {
	var popupURL = "/admin/checkBoard.exco?targetNo="+targetNo;
	var popupProperties = "width=1000, height=800, scrollbars=yes";
	
	window.open(popupURL, "popup", popupProperties);
}
function checkTargetComment(targetNo) {
	var popupURL = "/admin/checkComment.exco?targetNo="+targetNo;
	var popupProperties = "width=600, height=200, scrollbars=yes";
	
	window.open(popupURL, "popup", popupProperties);
}
</script>
</body>
</html>