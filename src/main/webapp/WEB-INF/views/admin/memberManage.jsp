<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
							<li><a href="/admin/memberReportManage.exco?reqPage=1&searchName=report">신고내역 관리</a></li>
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
						<div class="page-title">신고내역 관리</div>
						<div class="manage_select_box">
						<c:choose>
							<c:when test="${searchName eq 'report'}">
							<select name="manage_select" id="searchMember" onchange="search(this.value)">
								<option value="report" selected >전체 신고내역 조회</option>
								<option value="whole">전체 사용자 조회</option>
							</select>
							</c:when>
							
							<c:when test="${searchName eq 'whole'}">
							<select name="manage_select" id="searchMember" onchange="search(this.value)">
								<option value="report">전체 신고내역 조회</option>
								<option value="whole" selected>전체 사용자 조회</option>
							</select>
							</c:when>
						</c:choose>
						</div>
						
						<c:choose>
		                  	<c:when test="${searchName eq 'report'}">
		                  	<table class="tbl manage_member">
		                     <tr>
		                        <th style="width:7%">신고번호</th>
		                        <th style="width:10%">신고한 회원</th>
		                        <th style="width:10%">신고받은 회원</th>
		                        <th style="width:7%">신고분류</th>
		                        <th style="width:10%">신고대상</th>
		                        <th style="width:15%">신고날짜</th>
		                        <th style="width:10%">신고내역 확인</th>
		                     </tr>
		                     
		                     <c:forEach var="report" items="${reportList}">
		                     <tr>
		                     	<td>${report.reportNo}</td>
		                        <td>${report.reporter}</td>
		                        <td>${report.suspect}</td>
		                        <c:if test="${report.reportType eq '0'}">
		                        <td>게시글</td>
		                        </c:if>
		                        <c:if test="${report.reportType eq '1'}">
		                        <td>댓글</td>
		                        </c:if>
		                        <td>${report.targetNo}</td>
		                        <td>${report.reportDate}</td>
		                        <td><button class="btn-primary" onclick="">확인</button></td>
		                     </tr>
		                     </c:forEach>
		                    </table>
		                  	<div id="pageNavi">${pageNavi}</div>
		                  	</c:when>
		                  	<c:when test="${searchName eq 'whole'}">
		                  	<table class="tbl manage_member">
		                     <tr>
		                        <th style="width:7%">회원번호</th>
		                        <th style="width:10%">아이디</th>
		                        <th style="width:10%">닉네임</th>
		                        <th style="width:10%">회원구분</th>
		                        <th style="width:10%">신고받은 횟수</th>
		                        <th style="width:10%">신고한 횟수</th>
		                        <th style="width:10%">활동정지횟수</th>
		                        <th style="width:10%">활동제한</th>
		                     </tr>
		                  	
		                  	<c:forEach var="member" items="${reportMemberList}">
		                     <tr>
		                     	<td>${member.memberNo}</td>
		                        <td>${member.memberId}</td>
		                        <td>${member.memberNickname}</td>
		                        <c:choose>
		                     	<c:when test="${member.memberType eq '0'}">
		                     	<td>관리자</td>
		                     	</c:when>
		                     	<c:when test="${member.memberType eq '1' or member.memberType eq '2' or member.memberType eq '3'}">
		                     	<td>사용자</td>
		                     	</c:when>
		                     	<c:when test="${member.memberType eq '4' or member.memberType eq '5' or member.memberType eq '6'}">
		                     	<td>전문가</td>
		                     	</c:when>
		                     	</c:choose>
		                        <td>${member.reportCount}</td>
		                        <td>${member.suspectCount}</td>
		                        <td>${member.restrictionCount}</td>
		                        <c:choose>
		                        <c:when test="${member.restrictionCount eq 0 or 1}">
		                        <td><button class="btn-secondary" onclick="">활동정지</button></td>
		                        </c:when>
								<c:when test="${member.restrictionCount eq 2}">
		                        <td><button class="btn-tertiary" onclick="">사용정지</button></td>
		                        </c:when>
		                        </c:choose>
		                     </tr>
		                     </c:forEach>
		                  	</table>
		                  	</c:when>
		                </c:choose>
					</div>
				</div>
			</section>
		</main>
		
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
<script>
function search(choice){
	if(choice == 'report') {
	    location.href = "/admin/memberReportManage.exco?reqPage=1&searchName="+choice;
	} else if(choice == 'whole') {
		location.href = "/admin/memberManage.exco?reqPage=1&searchName="+choice;
	}
}
</script>
</body>
</html>