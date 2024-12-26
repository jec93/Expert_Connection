<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png"/>
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png"/>
<style>
	.boardContent{
		height: 200px;
	}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section">
				<table class="tbl board-view">
					<tr>
						<th colspan="6">
							${board.boardTitle}
						</th>
					</tr>
					<tr>
                     <th style="width:20%">작성자</th>
                     <td style="width:20%">${board.boardWriter }</td>
                     <th style="width:20%">작성일</th>
                     <td style="width:20%">${board.boardDate}</td>
                     <th style="width:20%">조회수</th>
                     <td style="width:20%">${board.boardCount }</td>
                  </tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="5">
							<c:forEach var="file" items="${board.fileList}">
								<a href="javascript:fileDown('${file.fileName}', '${file.filePath}')">${file.fileName}</a>
							</c:forEach>
						</td>
					</tr>
					<tr>
                     <td class="left" colspan="6">
                        <div class="boardContent">${board.boardContent }</div>
                     </td>
                  </tr>
                  <c:if test="${not empty loginMember and loginMember.memberNickname eq board.boardWriter}">
					<tr>
						<td colspan="6">
							<a href='/board/updateFrm.exco?boardNo=${board.boardNo}' class="btn-primary">수정</a>
							<a href='/board/delete.exco?boardNo=${board.boardNo}&boardType=${board.boardType}' class="btn-secondary">삭제</a>
						</td>
					</tr>
				</c:if>
				</table>
				<c:if test="${not empty loginMember }">
					<div class="inputCommentBox">
						<form name="insertComment" action="/board/insertComment">
							<input type="hidden" name="commentRef" value="${board.boardNo}"> <%-- 현재 게시글 번호 --%>
							<input type="hidden" name="commentWriter" value="${loginMember.memberNo}"> <%-- 현재 댓글 작성자(로그인한 회원) --%>
							<ul class="comment-write">
								<li>
									<div class="input-item">
										<textarea name="commentContent"></textarea>
									</div>
								</li>
								<li>
									<button type="submit" class="btn-primary">등록</button>
								</li>
							</ul>
						</form>
					</div>
				</c:if>
				<div class="commentBox">
					<c:forEach var="comment" items="${board.commentList}">
						<ul class="posting-comment">
							<li>
								<span class="material-icons">account_box</span>
							</li>
							<li>
								<p class="comment-info">
									<span>${comment.commentWriter}</span>
									<span>${comment.commentDate}</span>
									<%-- 로그인한 회원 아이디 == 현재 댓글을 작성한 아이디 --%>
									<c:if test="${not empty loginMember and loginMember.memberNickname eq comment.commentWriter}">
										<a href='javascript:void(0)' onclick="delComment('${comment.commentNo}');">삭제</a>
										<c:if test="${not empty loginMember and loginMember.memberNickname eq comment.commentWriter}">
										<a href='javascript:void(0)' onclick="mdfComment(this,'${comment.commentNo}');">수정</a>
										</c:if>
									</c:if>
								</p>
								<p class="comment-content">
									${comment.commentContent}
								</p>
								<div class="input-item" style="display:none;">
									<textarea name="commentContent">${comment.commentContent}</textarea>
								</div>
							</li>
						</ul>
					</c:forEach>
				</div>
			</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	
	<script>
		function fileDown(fileName, filePath){
			fileName = encodeURIComponent(fileName);
			filePath = encodeURIComponent(filePath);
			
			location.href = "/board/fileDown.exco?fileName=" + fileName + "&filePath=" + filePath;
		}
	</script>
</body>
</html>