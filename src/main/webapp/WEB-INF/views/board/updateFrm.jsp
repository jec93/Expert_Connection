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
	.delBtn:hover{
		cursor: pointer;
	}
	.delBtn{
		width : 50px;
		display:inline-block;
	}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<main class="content">
			<section class="section">
				<div class ="page-title">${board.boardTypeNm}수정</div>
				<form action="/board/update.exco" method="post" enctype="multipart/form-data">
					<input type="hidden" name="boardNo" value="${board.boardNo }">
					<input type="hidden" name="boardType" value="${board.boardType }">
					<table class="tbl">
						<tr>
							<th style="width:15%;">제목</th>
							<td>
								<div class="input-item">
									<input type="text" name="boardTitle" value="${board.boardTitle }">
								</div>
							</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
								<div class="file-wrap left">
									<c:forEach var="file" items="${board.fileList }">
										<div class="files">
											<span class="delFileName">${file.fileName != null ? file.fileName : '파일이 없습니다'}</span>
											<img alt="delete-file" src="/resources/images/button_delete_03.png" class="delBtn" onclick="delFile(this, '${file.fileNo}')">
											<%-- <span class="material-icons delBtn" onclick="delFile(this, '${file.fileNo}')"></span> --%>
											<input type="hidden" name="files" value="${file.fileName}">
										</div>
									</c:forEach>
								</div>
							</td>
						</tr>
						<tr>
							<th>추가파일</th>
							<td>
								<input type="file" name="addFiles" multiple="multiple">
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td class="left">
								<div class="input-item">
									<textarea id="boardContent" name="boardContent">${board.boardContent}</textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<button class="btn-primary lg">수정</button>
							</td>
						</tr>
					</table>
				</form>
			</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
 	<script src="/resources/summernote/summernote-lite.js"></script>
	<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
	<script>
	function delFile(obj, fileNo){
		swal({
			title : "삭제",
			text : "첨부파일을 삭제하시겠습니까?",
			icon : "warning",
			buttons : {
				cancel : {
					text : "취소",
					value : false,
					visible : true,
					closeModal : true
				},
				confirm : {
					text : "삭제",
					value : true,
					visible : true,
					closeModal : true
				}
			}
		}).then(function(isConfirm) {
	        if (isConfirm) {
	            // 파일 삭제 확인
	            let parentDiv = $(obj).parent(); // 현재 클릭된 버튼의 부모 div (파일 전체 컨테이너)
	            parentDiv.remove(); // 화면에서 파일 제거
	            
	            // 삭제된 파일 정보를 hidden input으로 추가
	            let inputEl = $('<input>');
	            inputEl.attr('type', 'hidden');
	            inputEl.attr('name', 'delFileNo'); // 삭제될 파일 No을 보낼 필드
	            inputEl.attr('value', fileNo);
	            $('form').prepend(inputEl); // 폼의 첫 번째 자식으로 추가
	        }
	    });
	}
	
	//html태그를 서머노트화 하여 수정가능
	$(document).ready(function() {
        $('#boardContent').summernote({
            height: 300, // 에디터 높이
            lang: 'ko-KR', // 한국어 설정
            placeholder: '내용을 입력하세요...',
            toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['insert', ['picture', 'link']],
                ['view', ['fullscreen', 'codeview']]
            ]
        });
    });
	</script>
</body>
</html>