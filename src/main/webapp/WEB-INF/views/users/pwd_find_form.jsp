<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageContext.request.contextPath}</title>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container">
        <div class="py-5 text-center">
	       <h2>비밀번호 찾기</h2>
        </div>
        
	    <form action="${pageContext.request.contextPath}/users/pwd_find" class="card p-2 needs-validation" method="post">
	        <div class="mb-2">
	            <label for="id" class="control-label">아이디</label>
	            <input type="text" class="form-control" name="id" id="id"
	                placeholder="예) hello123"/>
	            <small class="form-text text-muted">아이디는 5~10글자 사이의 영문자 소문자입니다.</small>
	        </div>
	        <div class="mb-2">
	            <label for="email" class="control-label">이메일</label>
	            <input type="text" class="form-control" name="email" id="email"/>
	        </div>
	        
	        <button class="btn btn-primary" type="submit">찾기</button>
	    </form>
    </div>
</body>
</html>