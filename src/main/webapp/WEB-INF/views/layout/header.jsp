<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">RecipeBook</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample03" aria-controls="navbarsExample03" aria-expanded="false" aria-label="탐색 전환">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse justify-content-between" id="navbarsExample03">
            <ul class="navbar-nav">
            </ul>
            
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${empty sessionScope.id}">
                        <li class="nav-item"><a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/users/login_form">로그인</a></li>
                        <li class="nav-item"><a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/users/signup_form">회원가입</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/users/private/info">${id}</a>로그인 중 </li>
                        <li class="nav-item"><a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/users/private/logout">로그아웃</a> </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>