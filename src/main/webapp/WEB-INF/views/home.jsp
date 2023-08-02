<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>${pageContext.request.contextPath}</title>
    <meta name="description" content="Core HTML Project">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="./layout/header.jsp">
        <jsp:param value="home" name="currentPage"/>
	</jsp:include>
    <div class="container">
        <div class="py-5 text-center">
            <h2>RecipeBook</h2>
        </div>
        <ul>
            <li><a href="social/list">유저 소통 게시판</a></li>
        </ul>

        <h3>공지사항</h3>
        <ul>
            <c:forEach var="tmp" items="${requestScope.noticeList }">
                <li>${tmp }</li>
            </c:forEach>
        </ul>
    </div>
</body>
</html>