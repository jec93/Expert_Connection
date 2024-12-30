<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    table, th, td {
        border: 1px solid #ddd;
    }
    th, td {
        padding: 10px;
        text-align: center;
    }
    th {
        background-color: #f4f4f4;
    }
</style>
</head>
<body>

<h1>전문가 리스트</h1>


<table>
        <tr>
            <th>전문가 번호</th>
            <th>회원 번호</th>
            <th>카테고리</th>
            <th>등급</th>
        </tr>
		<c:forEach var="expert" items="${expertList}">
			<tr>
				<td><a href="expertDetail.exco?receiveNo=${expert.receiveNo}">
						${expert.receiveNo}</a></td>
				<td><a href="expertDetail.exco?receiveNo=${expert.receiveNo}">
						${expert.memberNo}</a></td>
				<td><a href="expertDetail.exco?receiveNo=${expert.receiveNo}">
						${expert.thirdCategoryNm}</a></td>
				<td><a href="expertDetail.exco?receiveNo=${expert.receiveNo}">
						${expert.expertGrade}</a></td>
			</tr>
		</c:forEach>
		</tbody>
</table>
</body>
</html>