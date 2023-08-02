<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageContext.request.contextPath}</title>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container">
        <p>
            <strong>${requestScope.id }</strong> 님 탈퇴 처리 되었습니다.
            <a href="${pageContext.request.contextPath}/">인덱스로 가기</a>
        </p>
    </div>
</body>
</html>