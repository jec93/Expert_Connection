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
						<div class="page-title">전문가 회원 관리</div>
						<div class="manage_select_box">
						<c:choose>
							<c:when test="${searchName eq 'expected'}">
							<select name="manage_select" id="searchExpert" onchange="search(this.value)">
								<option value="expected" selected>전문가 승인 예정</option>
								<option value="approval">전문가 관리</option>
								<option value="decline">승인 거절 전문가</option>
								<option value="hold">활동 정지 전문가</option>
							</select>
							</c:when>
							
							<c:when test="${searchName eq 'approval'}">
							<select name="manage_select" id="searchExpert" onchange="search(this.value)">
								<option value="expected">전문가 승인 예정</option>
								<option value="approval" selected>전문가 관리</option>
								<option value="decline">승인 거절 전문가</option>
								<option value="hold">활동 정지 전문가</option>
							</select>
							</c:when>
							
							<c:when test="${searchName eq 'decline'}">
							<select name="manage_select" id="searchExpert" onchange="search(this.value)">
								<option value="expected">전문가 승인 예정</option>
								<option value="approval">전문가 관리</option>
								<option value="decline" selected>승인 거절 전문가</option>
								<option value="hold">활동 정지 전문가</option>
							</select>
							</c:when>
							
							<c:when test="${searchName eq 'hold'}">
							<select name="manage_select" id="searchExpert" onchange="search(this.value)">
								<option value="expected">전문가 승인 예정</option>
								<option value="approval">전문가 관리</option>
								<option value="decline">승인 거절 전문가</option>
								<option value="hold" selected>활동 정지 전문가</option>
							</select>
							</c:when>
						</c:choose>
						</div>
						
						<c:choose>
		                  	<c:when test="${searchName eq 'expected'}">
		                  	<table class="tbl manage_member">
		                     <tr>
		                        <th style="width:8%">신청 아이디</th>
		                        <th style="width:10%">신청인</th>
		                        <th style="width:15%">이메일</th>
		                        <th style="width:10%">서비스 분류</th>
		                        <th style="width:10%">포트폴리오</th>
		                        <th style="width:7%">반려</th>
		                        <th style="width:7%">승인</th>
		                     </tr>
		                     
		                     <c:forEach var="expert" items="${expertList}">
		                     <tr>
		                     	<td>${expert.memberId}</td>
		                     	<td>${expert.memberNickname}</td>
		                     	<td>${expert.memberEmail}</td>
		                     	<td>${expert.thirdCategoryNm}</td>
		                     	<td>${expert.expertFileName}</td>
		                     	<td><button class="btn-tertiary" onclick="decline('${expert.receiveNo}')">반려</button></td>
		                        <td><button class="btn-primary" onclick="approval('${expert.receiveNo}')">승인</button></td>
		                     </tr>
		                     </c:forEach>
		                    </table>
		                  	<div id="pageNavi">${pageNavi}</div>
		                  	</c:when>
		                  	
		                  	<c:when test="${searchName eq 'approval'}">
		                  	<table class="tbl manage_member">
		                     <tr>
		                        <th style="width:7%">승인번호</th>
		                        <th style="width:10%">이름</th>
		                        <th style="width:10%">서비스 분류</th>
		                        <th style="width:7%">전문가 등급</th>
		                        <th style="width:10%">포트폴리오</th>
		                        <th style="width:10%">승인정지</th>
		                     </tr>
		                     
		                     <c:forEach var="expert" items="${expertList}">
		                     <tr>
		                     	<td>${expert.receiveNo}</td>
		                     	<td>${expert.memberNickname}</td>
		                     	<td>${expert.thirdCategoryNm}</td>
		                     	<c:if test="${expert.expertGrade eq '0'}"> <td>새싹전문가</td></c:if>
		                     	<c:if test="${expert.expertGrade eq '1'}"> <td>능숙한 전문가</td></c:if>
		                     	<c:if test="${expert.expertGrade eq '2'}"> <td>노련한 전문가</td></c:if>
		                     	<td>${expert.expertFileName}</td>
		                     	<td><button class="btn-tertiary" onclick="hold('${expert.receiveNo}')">정지</button></td>
		                     </tr>
		                     </c:forEach>
		                    </table>
		                  	<div id="pageNavi">${pageNavi}</div>
		                  	</c:when>
		                  	
		                  	<c:when test="${searchName eq 'decline'}">
		                  	<table class="tbl manage_member">
		                     <tr>
		                        <th style="width:7%">승인번호</th>
		                        <th style="width:10%">이름</th>
		                        <th style="width:15%">이메일</th>
		                        <th style="width:10%">서비스 분류</th>
		                        <th style="width:7%">전문가 등급</th>
		                        <th style="width:20%">포트폴리오</th>
		                     </tr>
		                     
		                     <c:forEach var="expert" items="${expertList}">
		                     <tr>
		                     	<td>${expert.receiveNo}</td>
		                     	<td>${expert.memberNickname}</td>
		                     	<td>${expert.memberEmail}</td>
		                     	<td>${expert.thirdCategoryNm}</td>
		                     	<c:if test="${expert.expertGrade eq '0'}"> <td>새싹전문가</td></c:if>
		                     	<c:if test="${expert.expertGrade eq '1'}"> <td>능숙한 전문가</td></c:if>
		                     	<c:if test="${expert.expertGrade eq '2'}"> <td>노련한 전문가</td></c:if>
		                     	<td>${expert.expertFileName}</td>
		                     </tr>
		                     </c:forEach>
		                    </table>
		                  	<div id="pageNavi">${pageNavi}</div>
		                  	</c:when>
		                  	
		                  	<c:when test="${searchName eq 'hold'}">
		                  	<table class="tbl manage_member">
		                     <tr>
		                        <th style="width:7%">승인번호</th>
		                        <th style="width:10%">이름</th>
		                        <th style="width:15%">이메일</th>
		                        <th style="width:10%">서비스 분류</th>
		                        <th style="width:7%">전문가 등급</th>
		                        <th style="width:7%">재승인</th>
		                     </tr>
		                     
		                     <c:forEach var="expert" items="${expertList}">
		                     <tr>
		                     	<td>${expert.receiveNo}</td>
		                     	<td>${expert.memberNickname}</td>
		                     	<td>${expert.memberEmail}</td>
		                     	<td>${expert.thirdCategoryNm}</td>
		                     	<c:if test="${expert.expertGrade eq '0'}"> <td>새싹전문가</td></c:if>
		                     	<c:if test="${expert.expertGrade eq '1'}"> <td>능숙한 전문가</td></c:if>
		                     	<c:if test="${expert.expertGrade eq '2'}"> <td>노련한 전문가</td></c:if>
		                     	<td><button class="btn-primary" onclick="approval('${expert.receiveNo}')">승인</button></td>
		                     </tr>
		                     </c:forEach>
		                    </table>
		                  	<div id="pageNavi">${pageNavi}</div>
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
	if(choice == 'expected') {
	    location.href = "/admin/expertManagement.exco?reqPage=1&searchName="+choice;
	} else if(choice == 'approval') {
		location.href = "/admin/expertManagement.exco?reqPage=1&searchName="+choice;
	} else if(choice == 'decline') {
		location.href = "/admin/expertManagement.exco?reqPage=1&searchName="+choice;
	} else if(choice == 'hold') {
		location.href = "/admin/expertManagement.exco?reqPage=1&searchName="+choice;
	}
}

//전문가 승인 반려
function decline(receiveNo) {
	swal({
		title : "승인 반려",
		text : "해당 승인요청을 반려하시겠습니까?",
		icon : "warning",
		buttons : {
				cancel : {
					text : "취소",
					value : false,
					visible : true,
					closeModal : true
				},
				confirm : {
					text : "반려",
					value : true,
					visible : true,
					closeModal : true
				}
			}
	}).then(function(isConfirm) {
		if(isConfirm) {
			location.href = '/admin/expertDecline.exco?receiveNo='+receiveNo;
		}
	});
}

//전문가 승인 완료
function approval(receiveNo) {
	swal({
		title : "승인 완료",
		text : "해당 요청을 승인하시겠습니까?",
		icon : "info",
		buttons : {
				cancel : {
					text : "취소",
					value : false,
					visible : true,
					closeModal : true
				},
				confirm : {
					text : "확인",
					value : true,
					visible : true,
					closeModal : true
				}
			}
	}).then(function(isConfirm) {
		if(isConfirm) {
			location.href = '/admin/expertApproval.exco?receiveNo='+receiveNo;
		}
	});
}

//전문가 승인 정지
function hold(receiveNo) {
	swal({
		title : "승인 정지",
		text : "해당 서비스를 제공하는 전문가의 활동을 정지하시겠습니까? \n 신중하게 검토후 진행해주세요.",
		icon : "warning",
		buttons : {
				cancel : {
					text : "취소",
					value : false,
					visible : true,
					closeModal : true
				},
				confirm : {
					text : "확인",
					value : true,
					visible : true,
					closeModal : true
				}
			}
	}).then(function(isConfirm) {
		if(isConfirm) {
			location.href = '/admin/expertHold.exco?receiveNo='+receiveNo;
		}
	});
}
</script>
</body>
</html>