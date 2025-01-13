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
<link rel="stylesheet" href="/resources/css/exco.css" />
</head>
<style>
.board-like-container{
	display: flex;
	justify-content: center;
}
#board-like{
	width: 50%;
}
#board-dislike{
	width: 50%;
}
</style>
<body>
	<h3 id="check-board-title">
	<c:choose>
		<c:when test="${board.boardType eq '0'}">사용자 게시판</c:when>
		<c:when test="${board.boardType eq '1'}">전문가 게시판</c:when>
		<c:when test="${board.boardType eq '2'}">전문가 노하우</c:when>
		<c:when test="${board.boardType eq '3'}">그룹레슨</c:when>
		<c:when test="${board.boardType eq '4'}">공지사항</c:when>
		<c:when test="${board.boardType eq '5'}">자주묻는질문</c:when>
		<c:when test="${board.boardType eq '6'}">1:1문의</c:when>
	</c:choose>
	</h3>
	<table class="tbl check-board">
		<tr>
			<th colspan="6">${board.boardTitle}</th>
		</tr>
		<tr>
			<th style="width: 20%">작성자</th>
			<td style="width: 20%">${board.boardWriter}</td>
			<th style="width: 20%">작성일</th>
			<td style="width: 20%">${board.boardDate}</td>
			<th style="width: 20%">조회수</th>
			<td style="width: 20%">${board.boardCount}</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td colspan="5"><c:forEach var="file"
					items="${board.fileList}">
					<a
						href="javascript:fileDown('${file.fileName}', '${file.filePath}')">${file.fileName}</a>
				</c:forEach></td>
		</tr>
		<tr>
			<td class="left" colspan="6">
				<div class="boardContent">${board.boardContent }</div>
			</td>
		</tr>
		<tr>
			<td colspan="6">
				<div class="board-like-container">
					<div>
						<span id="like-button" class="cmt-react">
					        <a href='javascript:void(0)' id="boardlike" onclick="boardLike(this,'${board.boardNo}',1);">
					            <img src="/resources/images/board_like.png" id="board-like">
					        </a>
					    </span>
					    <div id="commentlikeCnt">${board.boardLike}</div>
					    <div>좋아요</div>
					</div>
					<div>
					    <span id="dislike-button" class="cmt-react">
					        <a href='javascript:void(0)' id="boardDislike" onclick="boardLike(this, '${board.boardNo}',-1);">
					            <img src="/resources/images/board_dislike.png" id="board-dislike">
					        </a>
					    </span>
					    <div id="commentDislikeCnt">${board.boardDislike}</div>
					    <div>아쉬워요</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>