<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추후에 삭제할 페이지!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</title>
</head>
<body>
    <h3>전문가 목록</h3>
    <ul>
        <c:forEach var="expert" items="${experts}">
            <li>${expert.expertNickname} - ${expert.expertAddr} - ${expert.thirdCategoryNm}</li>
        </c:forEach>
    </ul>
</body>
</html>