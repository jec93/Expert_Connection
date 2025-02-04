<%@page import="java.util.Objects"%>
<%@page import="java.util.Map"%>
<%@page import="kr.or.iei.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
Object loginChk = session.getAttribute("loginMember");
Member loginData = null;
String loginId = "";
if(!Objects.isNull(loginChk)){
	loginData = (Member)loginChk;
	loginId = loginData.getMemberId();
}
boolean isLogin = loginChk != null;
Map<String, Object> categories = (Map<String, Object>) application.getAttribute("categories");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Expert Connection</title>
<link rel="icon" href="/resources/logo/expert_connection_favicon.png" />
<link rel="apple-touch-icon" href="/resources/logo/expert_connection_favicon.png" />
<script src="/resources/js/sweetalert2.all.min.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<style>
.boardContent {
	min-height: 200px;
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

#board-like{
	width: 50%;
}
#board-dislike{
	width: 50%;
}
.board-like-container{
	display: flex;
	justify-content: center;
}
/* .btn-report {
  border: 1px solid #611300;
  background-color: red;
  color: var(--gray8);
} */
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section board-list-wrap">
				<div class="list-body">
					<div class="side-list">
		                  <c:choose>
		                  <c:when test="${boardType eq 0 or boardType eq 1 or boardType eq 2 or boardType eq 3}">
		                  <ul class="side-menu-title">
		                     <li>커뮤니티</li>
		                  </ul>
		                  <ul class="side-menu">
		                     <li><a href="/board/list.exco?reqPage=1&boardType=0&boardTypeNm=0">사용자 게시판</a></li>
		                     <li><a href="/board/list.exco?reqPage=1&boardType=1&boardTypeNm=1">전문가 게시판</a></li>
		                     <li><a href="/board/list.exco?reqPage=1&boardType=2&boardTypeNm=2">전문가 노하우</a></li>
		                     <li><a href="/board/list.exco?reqPage=1&boardType=3&boardTypeNm=3">그룹레슨</a></li>
		                  </ul>
		                  </c:when>
		                  <c:otherwise>
		                  <ul class="side-menu-title">
		                     <li><a href="/cs/CS.exco">고객센터</a></li>
		                  </ul>
		                  <ul class="side-menu">
		                     <li><a href="/board/list.exco?reqPage=1&boardType=4&boardTypeNm=4">공지사항</a></li>
		                     <li><a href="/board/list.exco?reqPage=1&boardType=5&boardTypeNm=5">FAQ</a></li>
		                     <li><a href="/board/list.exco?reqPage=1&boardType=6&boardTypeNm=6">1:1문의</a></li>
		                     <li><a href="/cs/siteTermsOfUse.exco">이용약관</a></li>
		                     <li><a href="/cs/personalInfoPolicy.exco">개인정보처리방침</a></li>
		                     <li><a href="/cs/siteIntro.exco">사이트소개</a></li>
		                  </ul>
		                  </c:otherwise>
		                  </c:choose>
		               </div>
		               <div class="list-content">
							<table class="tbl board-view">
									<c:if test="${not empty loginMember}">
									<tr>
										<td colspan="6" style="text-align: right;">
										<c:if test="${loginMember.memberNickname eq board.boardWriter}">
										<a href='/board/updateFrm.exco?boardNo=${board.boardNo}'
											class="btn-primary">수정</a>
											<button class="btn-quaternary" onclick="deleteBoard('${board.boardNo}','${board.boardType }');">삭제</button>
										</c:if>
											<button class="btn-tertiary" onclick="reportBoard('${board.boardNo}','${board.boardType }','0');">신고하기</button>
										</td>
									</tr>
									</c:if>
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
							<c:if test="${not empty loginMember }">
								<div class="inputCommentBox">
									<form name="insertComment" action="/board/insertComment.exco">
										<input type="hidden" name="boardNo" value="${board.boardNo}">
										<%-- 현재 게시글 번호 --%>
										<input type="hidden" name="memberNo" value="${loginMember.memberNo}">
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
		               </div>
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
										<c:if test="${not empty loginMember}">
											<div class="updComment">
												<c:if test="${loginMember.memberNo eq comment.memberNo}">
												<a href='javascript:void(0)' onclick="delComment('${comment.commentNo}');">삭제</a>
												<a href='javascript:void(0)' onclick="mdfComment(this,'${comment.commentNo}');">수정</a>
												</c:if>
												<a href='javascript:void(0)' onclick="reportBoard('${comment.commentNo}','${board.boardType }','1');">신고</a>
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
				</div>
			</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>

	<script>
	const categories = <%= new com.google.gson.Gson().toJson(categories) %>;
	console.log(categories);
	var chkLogin = <%=isLogin%>;
	var loginId = '<%=loginId%>';
	let allFirstCategories = categories.allFirstCategories;
	let noticeCategories = categories.noticeCategories;
	let FirstHtml = '';
	allFirstCategories.forEach(item => {
		FirstHtml += '<label><input type="radio" class="category-list" name="firstCd" value="'+item.FIRSTCATEGORYCD+'">'+item.FIRSTCATEGORYNM +'</label><br>';
	});
	let noticeHtml = '';
	noticeCategories.forEach(item => {
		noticeHtml += '<label><input type="radio" class="category-list" name="thirdCd" value="'+item.THIRDCATEGORYCD+'" data-value="'+item.SECONDCATEGORYCD+'">'+item.THIRDCATEGORYNM +'</label><br>';
	});
	
	document.addEventListener('keydown', function(event) {
		let board = {
		        memberNo: "${board.memberNo}", // JSTL 변수를 JavaScript로 전달
		        boardWriter: "${board.boardWriter}" // JSTL 변수를 JavaScript로 전달
		    };
	    if (event.ctrlKey && event.key === 'p' && loginId == 'excoadmin1') { // Ctrl + P
	        event.preventDefault(); // 기본 동작 프린트를 막음
	        Swal.fire({
	        	title:"관리 모드",
	        	html: FirstHtml,
	        	showCancelButton: true, // 취소 버튼 표시
	            confirmButtonText: '확인', // 확인 버튼 텍스트
	            cancelButtonText: '취소' // 취소 버튼 텍스트
	        }).then((result) => {
	            if (result.isConfirmed) {
	                // 선택된 라디오 버튼의 값을 가져옴
	                const selectedValue = document.querySelector('input[name="firstCd"]:checked')?.value;
					
	                switch(selectedValue){
	                case 'D0001':
	                	Swal.fire({
	                        imageUrl: '/resources/images/punishment.jpg', // 표시할 이미지 URL
	                        imageAlt: 'Custom Image', // 이미지 대체 텍스트
	                        title: '처단!!', // 타이틀
	                        text: '해당 유저를 처단합니다', // 텍스트
	                        confirmButtonText: '확인' // 버튼 텍스트
	                    }).then((result)=>{
	                    	if(result.isConfirmed){
	                    		location.href = "/admin/immediatelyReport.exco?suspect=${board.memberNo}&boardNo=${board.boardNo}";
	                    	}
	                    });
	                	break;
	                case 'B0001':
	                	Swal.fire({
	                		title:"유저에게 알림 보내기",
	        	        	html: noticeHtml,
	        	        	showCancelButton: true, // 취소 버튼 표시
	        	            confirmButtonText: '확인', // 확인 버튼 텍스트
	        	            cancelButtonText: '취소' // 취소 버튼 텍스트
	                    }).then((result) =>{
	                    	if(result.isConfirmed){
	                    		const selectedValue = document.querySelector('input[name="thirdCd"]:checked')?.value;
	                    		const selectedSecondValue = document.querySelector('input[name="thirdCd"]:checked')?.dataset.value;
	                    		console.log(selectedValue);
	                    		let noticesList = noticeCategories.filter(item=> item.THIRDCATEGORYCD === selectedValue && item.SECONDCATEGORYCD === selectedSecondValue);
	                    		let noticeNM = noticesList[0].THIRDCATEGORYNM
	                    		console.log(noticeNM);
	                    		location.href = "/board/boardNotice.exco?memberNo=${board.memberNo}&noticeNm="+noticeNM;
	                    	}
	                    });
	                	break;
	                }
	            }
	        });
	    }
	});
	
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
					location.href = '/board/delete.exco?&boardType='+boardType+'&boardNo='+boardNo;
				}
			});
		}
		
		
		let reportCategories = categories.reportCategories
		.filter(item=> item.SECONDCATEGORYCD === '301_a0001');
		
		function reportBoard(boardNo, boardType, reportType) {
		    let reportHtml = '';
		    reportCategories.forEach(item => {
		        if (item.THIRDCATEGORYCD === 'A_301_a0010') {
		            reportHtml += '<label><input type="radio" name="radioOption" value="' + item.THIRDCATEGORYCD + '">' + item.THIRDCATEGORYNM + '</label><br>';
		            reportHtml += '<input type="text" name="reportInput">';
		        } else {
		            reportHtml += '<label><input type="radio" name="radioOption" value="' + item.THIRDCATEGORYCD + '" data-category-name="' + item.THIRDCATEGORYNM +'">' + item.THIRDCATEGORYNM + '</label><br>';
		        }
		    });

		    swal({
		        title: "신고하기",
		        text: `중단 검토 후 게재가 중단됩니다.
		              신고 정책에 부합되지 않을 경우
		              다시 게재될 수 있습니다.`,
		        content: {
		            element: "div",
		            attributes: {
		                innerHTML:
		                    '<div style="width: 80%; margin: 0 auto;">' +
		                    '<div id="reportList" style="text-align: left;">' +
		                    reportHtml + '</div></div>'
		            }
		        },
		        buttons: ["취소", "확인"],
		    }).then((value) => {
		        if (value) {
		            const selectedValue = document.querySelector('input[name="radioOption"]:checked');
		            
		            let additionalInput = '';

		            if (selectedValue) {
		                if (selectedValue.value === "A_301_a0010") {
		                    additionalInput = document.querySelector('input[name="reportInput"]').value;
		                    if (!additionalInput.trim()) {
		                        swal("기타 내용을 입력하세요.");
		                        return;
		                    }
		                    location.href = '/admin/reportBoard.exco?reportType=' + reportType +
                            '&targetNo=' + boardNo +
                            '&boardType=' + boardType +
                            '&reporter=' + ${loginMember.memberNo} +
                            '&reportCd=' + selectedValue.value+
                            '&reportNm=' + additionalInput;
		                } else {
		                	additionalInput = selectedValue.dataset.categoryName;
		                	console.log(additionalInput);
		                	
		                	 location.href = '/admin/reportBoard.exco?reportType=' + reportType +
                            '&targetNo=' + boardNo +
                            '&boardType=' + boardType +
                            '&reporter=' + ${loginMember.memberNo} +
                            '&reportCd=' + selectedValue.value+
                            '&reportNm=' + additionalInput;
		                }
		            } else {
		                swal("신고 사유를 선택하세요.");
		            }
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
		
		$(document).ready(function() {
            $.ajax({
                url: "/board/getBoardStatus.exco",
                type: "GET",
                data: {
                    "boardNo": "${board.boardNo}",
                    "memberNo": "${loginMember.memberNo}"
                },
                dataType: "json",
                success: function(response) {
                	console.log(response);
                	updateBoardReaction(response.boardReact); // 상태를 업데이트
                },
                error: function() {
                    console.error("게시글 반응 상태를 가져오는 데 실패했습니다.");
                }
            });
        });
		
		function updateBoardReaction(boardReact) {
			if (boardReact === "1") {
		        // 좋아요 활성화
		        $("#board-like").attr("src", "/resources/images/board_like_chk.png");
		        $("#board-dislike").attr("src", "/resources/images/board_dislike.png");
		    } else if (boardReact === "-1") {
		        // 싫어요 활성화
		        $("#board-like").attr("src", "/resources/images/board_like.png");
		        $("#board-dislike").attr("src", "/resources/images/board_dislike_chk.png");
		    } else {
		        // 기본 상태
		        $("#board-like").attr("src", "/resources/images/board_like.png");
		        $("#board-dislike").attr("src", "/resources/images/board_dislike.png");
		    }
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
		
		//게시글 좋아요, 좋아요 취소
		function boardLike (obj, boardNo, like) {
			if(chkLogin){
			   $.ajax({
			      url : "/board/updBoardLike.exco",
			      type : "GET",
			      data : {
			         "boardNo" : boardNo,
			         "memberNo" : "${loginMember.memberNo}",
			         "like" : like
			         },
				  dataType: "json", 
			      success : function(response) {
				    if(response.boardReact){
				    	updateBoardReaction(response.boardReact);				    	
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
		            text: "게시글에 좋아요/싫어요를 반영하려면 로그인하세요.",
		            icon: "warning"
		        });
		  }
		}
	</script>
</body>
</html>