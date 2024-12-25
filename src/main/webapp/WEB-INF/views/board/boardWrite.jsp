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
				<form action="/board/write.exco" method="post" enctype="multipart/form-data">
					<input type="hidden" name="memberNo" value="${loginMember.memberNo}">
					<input type="hidden" name="boardWriter" value="${loginMember.memberNickname}">
					<input type="hidden" name="boardType" value="${boardType}">
					<input type="hidden" name="boardTypeNm" value="${boardTypeNm}">
					<table class="tbl">
						<tr>
							<th style="width: 20%;">제목</th>
							<td style="width: 80%;">
								<div class="input-item">
									<input type="text" name="boardTitle">
								</div>
							</td>
						</tr>
						<tr>
							<th style="width: 20%;">${boardTypeNm}</th>
							<td style="width: 30%;">${loginMember.memberNickname }</td>
							<th style="width: 20%;">첨부파일</th>
							<td style="width: 30%;"><input type="file" name="files" multiple>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<div class="input-item">
									<textarea id="boardContent" name="boardContent" escapeXml="false" style="background-color: white;"></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3"></td>
							<td colspan="1"
								style="text-align: right; display: flex; justify-content: flex-end;">
							</td>
						</tr>
					</table>
					<button type="submit" class="btn-primary lg">작성하기</button>
				</form>
			</section>
		</main>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
	<script src="/resources/summernote/summernote-lite.js"></script>
	<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
	<script>
		$('#boardContent').summernote({
			height: 500,
			width: 1000,
			lang: "ko-KR",
			disableResize: true,
			disableResizeEditor: true,
			resize: true,
		});
	</script>
</body>
</html>