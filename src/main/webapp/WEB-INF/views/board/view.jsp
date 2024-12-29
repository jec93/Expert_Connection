<%@page import="kr.or.iei.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
Object loginChk = session.getAttribute("loginMember");
boolean isLogin = loginChk != null; %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png" />
<link rel="apple-touch-icon"
	href="/resources/logo/expert_connection_favicon.png" />
<style>
.boardContent {
	height: 200px;
}

#mdfComment {
	padding-right: 10px;
}

#mdfComment:hover {
	color: var(- -main3);
}

#delComment:hover {
	color: #f90b00;
}

#thumb {
	padding-top: 3px;
	width: 18px;
	height: 20px;
}

.cmt-react>img {
	padding-top: 5px;
}

#commentLike {
	display: inline-block;
	text-align: center;
	align-content: start;
	padding-right: 10px;
}

#commentDislike {
	padding-left: 20px;
	padding-right: 10px;
}
/* #commentDislikeCnt {
	    padding-right : 540px;
	} */
#commentUserNickname {
	padding-right: 30px;
	color: var(- -main2);
	font-weight: bold;
}

#commentDate {
	padding-right: 20px;
}

.updComment {
	justify-content: End;
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
						<th colspan="6">${board.boardTitle}</th>
					</tr>
					<tr>
						<th style="width: 20%">작성자</th>
						<td style="width: 20%">${board.boardWriter }</td>
						<th style="width: 20%">작성일</th>
						<td style="width: 20%">${board.boardDate}</td>
						<th style="width: 20%">조회수</th>
						<td style="width: 20%">${board.boardCount }</td>
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
					<c:if
						test="${not empty loginMember and loginMember.memberNickname eq board.boardWriter}">
						<tr>
							<td colspan="6"><a
								href='/board/updateFrm.exco?boardNo=${board.boardNo}'
								class="btn-primary">수정</a>
								<button class="btn-secondary2"
									onclick="deleteBoard('${board.boardNo}','${board.boardType }')">삭제</button>
							</td>
						</tr>
					</c:if>
				</table>
				<c:if test="${not empty loginMember }">
					<div class="inputCommentBox">
						<form name="insertComment" action="/board/insertComment.exco">
							<input type="hidden" name="boardNo" value="${board.boardNo}">
							<%-- 현재 게시글 번호 --%>
							<input type="hidden" name="memberNo"
								value="${loginMember.memberNo}">
							<%-- 현재 댓글 작성자(로그인한 회원) --%>
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
							<li><span class="material-icons">account_box</span></li>
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
									<c:if test="${not empty loginMember and loginMember.memberNo eq comment.memberNo}">
										<div class="updComment">
											<a href='javascript:void(0)' onclick="delComment('${comment.commentNo}');">삭제</a>
											<a href='javascript:void(0)' onclick="mdfComment(this,'${comment.commentNo}');">수정</a>
										</div>
									</c:if>
								</div>
								<p class="comment-content">${comment.commentContent}</p>
								<div class="input-item" style="display: none;">
									<textarea name="commentContent">${comment.commentContent}</textarea>
								</div>
							</li>
						</ul>
						<!-- JavaScript 호출로 개별 AJAX 요청 -->
    					<script>
							$(document).ready(function() {
					            // 각 댓글마다 AJAX 요청을 실행
					            $.ajax({
					                url: "/board/getCmtStatus.exco",
					                type: "GET",
					                data: {
					                    "boardNo": "${board.boardNo}",
					                    "commentNo": "${comment.commentNo}",
					                    "memberNo": "${loginMember.memberNo}"
					                },
					                dataType: "json",
					                success: function(response) {
					                    updateReaction(response.cmtReact); // 상태를 업데이트
					                },
					                error: function() {
					                    console.error("댓글 상태를 가져오는 데 실패했습니다. (commentNo: ${comment.commentNo})");
					                }
					            });
					        });
						</script>
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
		
		function deleteBoard(boardNo,boardType) {
			swal({
				title: "삭제",
				text: "게시글을 삭제하시겠습니까?",
				icon: "warning",
				buttons: {
					cancel: {
						text: "취소",
						value: false,
						visible: true,
						closeModal: true
					},
					confirm: {
						text: "삭제",
						value: true,
						visible: true,
						closeModal: true
					}
				}
			}).then(function(isConfirm) {
				if (isConfirm) {
					location.href = '/board/delete.exco?boardNo='+boardNo+'&boardType='+boardType;
				}
			});
		}
		function delComment(commentNo) { // 삭제 버튼 클릭 시 호출
			swal({
				title: "삭제",
				text: "댓글을 삭제하시겠습니까?",
				icon: "warning",
				buttons: {
					cancel: {
						text: "취소",
						value: false,
						visible: true,
						closeModal: true
					},
					confirm: {
						text: "삭제",
						value: true,
						visible: true,
						closeModal: true
					}
				}
			}).then(function(isConfirm) {
				if (isConfirm) {
					let boardNo = '${board.boardNo}';
					location.href = '/board/deleteComment.exco?commentNo=' + commentNo+ "&boardNo="+boardNo;
				}
			});
		}
		function mdfComment(obj, commentNo) { // 수정 기능 활성화
			let commentContentLi = $(obj).parents('li');
			$(commentContentLi).find('div.input-item').show();
			$(commentContentLi).find('p.comment-content').hide();

			$(obj).text('수정완료');
			$(obj).attr('onclick', 'mdfCommentComplete(this,"'+commentNo+'")');
			
			$(obj).next().text('취소');
			$(obj).next().attr('onclick', 'mdfCommentCancel(this,"'+commentNo+'")');
		}
		
		function mdfCommentComplete(obj, commentNo) { // 수정 완료
			let form = $('<form>');
			form.attr('action', '/board/updateComment.exco');
			form.attr('method', 'post');
			
			let boardNo = '${board.boardNo}';
			form.append($('<input type="hidden" name="boardNo">').val(boardNo));
			form.append($('<input type="hidden" name="commentNo">').val(commentNo));

			let commentContent = $(obj).parents('li').find('textarea[name="commentContent"]').val();
			form.append($('<input type="hidden" name="commentContent">').val(commentContent));
			
			$('body').append(form);
			form.submit();
		}
		
		function mdfCommentCancel(obj, commentNo) { // 수정 취소
			let commentContentLi = $(obj).parents('li');
			$(commentContentLi).find('div.input-item').hide();
			$(commentContentLi).find('p.comment-content').show();
			
			$(obj).text('삭제');
			$(obj).attr('onclick', 'delComment("'+commentNo+'")');
			
			$(obj).prev().text('수정');
			$(obj).prev().attr('onclick', 'mdfComment(this,"'+commentNo+'")');
		}
		
		function updateReaction(cmtReact) {
			if (cmtReact === "1") {
		        // 좋아요 활성화
		        $("#thumb-like").attr("src", "/resources/images/thumb_up_shape.png");
		        $("#thumb-dislike").attr("src", "/resources/images/thumb_down_line.png");
		    } else if (cmtReact === "-1") {
		        // 싫어요 활성화
		        $("#thumb-like").attr("src", "/resources/images/thumb_up_line.png");
		        $("#thumb-dislike").attr("src", "/resources/images/thumb_down_shape.png");
		    } else {
		        // 기본 상태
		        $("#thumb-like").attr("src", "/resources/images/thumb_up_line.png");
		        $("#thumb-dislike").attr("src", "/resources/images/thumb_down_line.png");
		    }
		}
		
		var chkLogin = <%= isLogin %>;
		
		//댓글 좋아요, 좋아요 취소
		function commentLike (obj, commentNo, like) {
			if(chkLogin){
			   $.ajax({
			      url : "/board/updCmtLike.exco",
			      type : "GET",
			      data : {
			         "boardNo" : "${board.boardNo}",
			         "commentNo" : commentNo,
			         "memberNo" : "${loginMember.memberNo}",
			         "like" : like
			         },
				  dataType: "json", 
			      success : function(response) {
			      	console.log(response.cmtReact);
			       	console.log(response.message);
				    if(response.cmtReact){
				       	updateReaction(response.cmtReact);				    	
				    }
			        if(response.message != "0"){
					  swal({
					      title : "알림",
					      text : response.message,
					      icon : "success"
					   }).then(function(){
					      location.href = "/board/viewBoardFrm.exco?boardNo=${board.boardNo}";
					   });
					}
			        else{
			           swal({
			              title : "알림",
			              text : "댓글 호감도 반영 중 오류가 발생하였습니다.",
			              icon : "error"
			           }).then(function(){
			              location.href = "/board/viewBoardFrm.exco?boardNo=${board.boardNo}";
			           });
			        }
			     },
			    error : function() {
			       console.log("ajax 에러 발생");
			    }
			});
		  }else{
			  swal({
		            title: "로그인 필요",
		            text: "댓글에 좋아요/싫어요를 반영하려면 로그인하세요.",
		            icon: "warning"
		        });
		  }
		}
	</script>
</body>
</html>