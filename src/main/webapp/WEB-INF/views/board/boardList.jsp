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
<style>
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
                  <div class="page-title"> ${board.boardTypeNm} </div>
                  <table class="tbl">
                     <tr>
                        <th style="width:10%">번호</th>
                        <th style="width:20%">제목</th>
                        <th style="width:15%">작성자</th>
                        <th style="width:15%">작성일</th>
                        <th style="width:8%">추천수</th>
                        <th style="width:8%">아쉬워요</th>
                        <th style="width:8%">조회수</th>
                     </tr>
                     <c:forEach var="board" items="${boardList }">

                     <tr>
                        <td>${board.boardNo}</td>
                        <td><a href="/board/viewBoardFrm.exco?boardNo=${board.boardNo }&boardType=${board.boardType}">${board.boardTitle}</a></td>
                        <td>${board.boardWriter}</td>
                        <td>${board.boardDate}</td>
                        <td>${board.boardLike}</td>
                        <td>${board.boardDislike}</td>
                        <td>${board.boardCount}</td>
                     </tr>

                     </c:forEach>
                  </table>
               <div class="pagination">${pageNavi}</div>
               <%-- 반대로 로그인 데이터 없을때로 해둠 --%>
               <c:if test="${not empty loginMember }">
	               <div class="btn-primary" style="width:5%" onclick='writeFrm(${boardType},"${boardTypeNm}")'>
               			글작성
               		</div>
               </c:if>
               </div>
            </div>
         </section>
      </main>

      <jsp:include page="/WEB-INF/views/common/footer.jsp" />
   </div>
   
   <script>
   function writeFrm(boardType, boardTypeNm,boardNo) {
   	const url = '/board/writeFrm.exco?boardType='+boardType+'&boardTypeNm='+boardTypeNm;
		window.location.href = url;
   }
   </script>
</body>
</html>