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
<style>
.posting-comment {
	margin : 10px;
}
#commentUserNickname {
	color : var(--main2);
	padding-right : 20px;
}
#commentDate {
	padding-right : 20px;
}
#thumb-like {
	padding-top: 3px;
	width: 18px;
	height: 20px;
}

#thumb-dislike {
	padding-top: 3px;
	width: 18px;
	height: 20px;
}

.cmt-react>img {
	padding-top: 5px;
}
</style>
</head>
<body>
	<c:forEach var="comment" items="${board.commentList}">
	<ul class="posting-comment">
		<li>
			<div class="comment-info">
				<div class="cmt-info">
					<span id="commentUserNickname">${comment.commentWriter}</span>
				    <span id="commentDate">${comment.commentDate}</span>
				    <span id="like-button" class="cmt-react">
				        <a href='javascript:void(0)' id="commentlike" onclick="commentLike(this,'${comment.commentNo}',1);">
				            <img src="/resources/images/thumb_up_line.png" id="thumb-like">
				        </a>
				    </span>
				    <span id="commentlikeCnt">${comment.commentLike}</span>
				    <span id="dislike-button" class="cmt-react">
				        <a href='javascript:void(0)' id="commentDislike" onclick="commentLike(this, '${comment.commentNo}',-1);">
				            <img src="/resources/images/thumb_down_line.png" id="thumb-dislike">
				        </a>
				    </span>
				    <span id="commentDislikeCnt">${comment.commentDislike}</span>
				</div>
			</div>
			<p class="comment-content">${comment.commentContent}</p>
			<div class="input-item" style="display: none;">
				<textarea name="commentContent">${comment.commentContent}</textarea>
			</div>
		</li>
	</ul>
	</c:forEach>
</body>
</html>