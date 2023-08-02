<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageContext.request.contextPath}</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container">
        <c:choose>
            <c:when test="${isSuccess }">
                <p><strong>${id }</strong> 님의 임시 비밀번호가 발급되었습니다.</p>
                <p>임시비밀번호 : <strong>${tmpPwd}</strong></p>
                <p>로그인후 마이페이지에서 비밀번호 변경이 가능합니다.</p>
            </c:when>
            <c:otherwise>
                <p>
                    아이디 혹은 이메일이 일치하지 않습니다.
                    <a href="${pageContext.request.contextPath}/users/pwd_find_form">재시도</a>
                </p>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>