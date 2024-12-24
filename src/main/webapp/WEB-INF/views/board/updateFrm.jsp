<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<div class ="page-title">${board.boardTypeNm}수정</div>
				<form action="/notice/update" method="post" enctype="multipart/form-data">
					<input type="hidden" name="boardNo" value="${board.boardNo }">
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
									<c:forEach var="file" items="${notice.fileList }">
										<div class="files">
											<span class="delFileName">${file.fileName }</span>
											<span class="material-icons delBtn" onclick="delFile(this, '${file.fileNo}')">remove_circle</span>
										</div>
									</c:forEach>
								</div>
							</td>
						</tr>
						<tr>
							<th>추가파일</th>
							<td>
								<input type="file" name="addFile">
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td class="left">
								<div class="input-item">
									<textarea id="noticeContent" name="noticeContent">${notice.noticeContent}</textarea>
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
</body>
</html>