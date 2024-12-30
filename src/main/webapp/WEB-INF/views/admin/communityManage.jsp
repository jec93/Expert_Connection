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
								<li><a href="#">신고내역 관리</a></li>
								<li><a href="#">전문가 승인 검토</a></li>
								<li></li>
								<li></li>
							</ul>
							<ul class="side-menu-title">
								<li>사이트 관리</li>
							</ul>
							<ul class="side-menu">
								<li><a href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4">공지사항 관리</a></li>
								<li><a href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5">FAQ 관리</a></li>
								<li><a href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6">1:1문의 작성</a></li>
								<li><a href="/board/adminManageList.exco?reqPage=1">커뮤니티 관리</a></li>
								<li><a href="#">카테고리 관리</a></li>
								<li><a href="#">신고항목 관리</a></li>
							</ul>
						</div>
					
					<div class="list-content">
						<div class="manage-title">커뮤니티 관리</div>
						
						<div class="community_manage_select_box">
							<c:choose>
							<c:when test="${searchName eq 'comment'}">
							<select name="commnuity_select" id="searchCommunity" onchange="searchComment(this.value)">
								<option value="board">전체 게시글 조회</option>
								<option value="comment" selected>전체 댓글 조회</option>
							</select>
							</c:when>
							<c:when test="${searchName eq 'board'}">
							<select name="commnuity_select" id="searchCommunity" onchange="searchBoard(this.value)">
								<option value="board" selected>전체 게시글 조회</option>
								<option value="comment">전체 댓글 조회</option>
							</select>
							</c:when>
							<c:when test="${searchName eq null}">
							<select name="commnuity_select" id="searchCommunity" onchange="searchBoard(this.value)">
								<option value="board" selected>전체 게시글 조회</option>
								<option value="comment">전체 댓글 조회</option>
							</select>
							</c:when>
							</c:choose>
						</div>
						
						<c:choose>
		                  	<c:when test="${searchName eq 'comment'}">
		                  	<table class="tbl community_manage">
		                     <tr>
		                        <th style="width:10%">작성자</th>
		                        <th style="width:40%">댓글 내용</th>
		                        <th style="width:20%">작성일</th>
		                        <th style="width:10%">신고수</th>
		                        <th style="width:9%">삭제</th>
		                     </tr>
		                     
		                     <c:forEach var="comment" items="${commentList}">
		                     	<td>${comment.commentWriter}</td>
		                        <td>${comment.commentContent}</td>
		                        <td>${comment.commentDate}</td>
		                        <td>${comment.report}</td>
		                        <td><button>삭제</button></td>
		                     </c:forEach>
		                    </table>
		                  	<div id="pageNavi">${pageNavi}</div>
		                  	</c:when>
		                  	
		                  	<c:when test="${searchName eq 'board'}">
		                  	<table class="tbl community_manage">
		                     <tr>
		                        <th style="width:7%">번호</th>
		                        <th style="width:7%">제목</th>
		                        <th style="width:18%">분류</th>
		                        <th style="width:9%">작성자</th>
		                        <th style="width:20%">작성일</th>
		                        <th style="width:10%">조회수</th>
		                        <th style="width:10%">신고수</th>
		                        <th style="width:9%">삭제</th>
		                     </tr>
		                     <c:forEach var="board" items="${boardList}">
		
		                     <tr>
		                        <td>${board.boardNo}</td>
		                       <c:choose>
								<c:when test="${boardType eq 6}">
									<c:if test="${empty sessionScope.loginMember}">
										<td>작성자만 확인 가능합니다</td>
									</c:if>
									<c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberId ne 'admin' and sessionScope.loginMember.memberNickname ne board.boardWriter}">
										<td>작성자만 확인 가능합니다</td>
									</c:if>
									<c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberNickname eq board.boardWriter}">
										<td><a class="boardTitle" href="/board/viewBoardFrm.exco?boardNo=${board.boardNo}&boardType=${board.boardType}">${board.boardTitle}</a></td>
									</c:if>
									<c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberId eq 'admin'}">
										<td><a class="boardTitle" href="/board/viewBoardFrm.exco?boardNo=${board.boardNo}&boardType=${board.boardType}">${board.boardTitle}</a></td>
									</c:if>
								</c:when>
								<c:when test="${boardType ne 6}">
									<td><a class="boardTitle" href="/board/viewBoardFrm.exco?boardNo=${board.boardNo}&boardType=${board.boardType}">${board.boardTitle}</a></td>
								</c:when>
								<c:otherwise>
		                       		<td><a class="boardTitle" href="/board/viewBoardFrm.exco?boardNo=${board.boardNo}&boardType=${board.boardType}">${board.boardTitle}</a></td>
						 		</c:otherwise>                      
		                        </c:choose>
	                        	<c:choose>
	                        		<c:when test="${board.boardType eq 0}"><td>사용자게시판</td></c:when>
	                        		<c:when test="${board.boardType eq 1}"><td>전문가게시판</td></c:when>
	                        		<c:when test="${board.boardType eq 2}"><td>전문가노하우</td></c:when>
	                        		<c:when test="${board.boardType eq 3}"><td>그룹레슨</td></c:when>
	                        		<c:when test="${board.boardType eq 4}"><td>공지사항</td></c:when>
	                        		<c:when test="${board.boardType eq 5}"><td>FAQ</td></c:when>
	                        		<c:otherwise><td>1:1문의</td></c:otherwise>
	                        	</c:choose>
		                        <td>${board.boardWriter}</td>
		                        <td>${board.boardDate}</td>
		                        <td>${board.boardCount}</td>
		                        <td>${board.report}</td>
		                        <td><button>삭제</button></td>
		                     </tr>
		
		                     </c:forEach>
		                  </table>
               			  <div id="pageNavi">${pageNavi}</div>
		                  	</c:when>
		                  	<c:when test="${searchName eq null}">
		                  	<h1>ERROR</h1>
		                  	<table class="tbl community_manage">
		                     <tr>
		                        <th style="width:7%">번호</th>
		                        <th style="width:7%">제목</th>
		                        <th style="width:18%">분류</th>
		                        <th style="width:9%">작성자</th>
		                        <th style="width:20%">작성일</th>
		                        <th style="width:10%">조회수</th>
		                        <th style="width:10%">신고수</th>
		                        <th style="width:9%">삭제</th>
		                     </tr>
		                     <c:forEach var="board" items="${boardList}">
		
		                     <tr>
		                        <td>${board.boardNo}</td>
		                       <c:choose>
								<c:when test="${boardType eq 6}">
									<c:if test="${empty sessionScope.loginMember}">
										<td>작성자만 확인 가능합니다</td>
									</c:if>
									<c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberId ne 'admin' and sessionScope.loginMember.memberNickname ne board.boardWriter}">
										<td>작성자만 확인 가능합니다</td>
									</c:if>
									<c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberNickname eq board.boardWriter}">
										<td><a class="boardTitle" href="/board/viewBoardFrm.exco?boardNo=${board.boardNo}&boardType=${board.boardType}">${board.boardTitle}</a></td>
									</c:if>
									<c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberId eq 'admin'}">
										<td><a class="boardTitle" href="/board/viewBoardFrm.exco?boardNo=${board.boardNo}&boardType=${board.boardType}">${board.boardTitle}</a></td>
									</c:if>
								</c:when>
								<c:when test="${boardType ne 6}">
									<td><a class="boardTitle" href="/board/viewBoardFrm.exco?boardNo=${board.boardNo}&boardType=${board.boardType}">${board.boardTitle}</a></td>
								</c:when>
								<c:otherwise>
		                       		<td><a class="boardTitle" href="/board/viewBoardFrm.exco?boardNo=${board.boardNo}&boardType=${board.boardType}">${board.boardTitle}</a></td>
						 		</c:otherwise>                      
		                        </c:choose>
	                        	<c:choose>
	                        		<c:when test="${board.boardType eq 0}"><td>사용자게시판</td></c:when>
	                        		<c:when test="${board.boardType eq 1}"><td>전문가게시판</td></c:when>
	                        		<c:when test="${board.boardType eq 2}"><td>전문가노하우</td></c:when>
	                        		<c:when test="${board.boardType eq 3}"><td>그룹레슨</td></c:when>
	                        		<c:when test="${board.boardType eq 4}"><td>공지사항</td></c:when>
	                        		<c:when test="${board.boardType eq 5}"><td>FAQ</td></c:when>
	                        		<c:otherwise><td>1:1문의</td></c:otherwise>
	                        	</c:choose>
		                        <td>${board.boardWriter}</td>
		                        <td>${board.boardDate}</td>
		                        <td>${board.boardCount}</td>
		                        <td>${board.report}</td>
		                        <td><button>삭제</button></td>
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

function searchComment(choice){
	    location.href = "/board/adminManageComment.exco?reqPage=1&searchName="+choice;
}

function searchBoard(choice) {
	location.href = "/board/adminManageList.exco?reqPage=1&searchName="+choice;
}
</script>
</body>
</html>