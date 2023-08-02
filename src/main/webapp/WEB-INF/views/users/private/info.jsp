<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ include file="/WEB-INF/views/layout/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageContext.request.contextPath}</title>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
    #profileImage{
        width: 50px;
        height: 50px;
        border: 1px solid #cecece;
        border-radius: 50%;
    }
</style>
</head>
<body class="bg-light">
	<div class="container">
	    <div class="py-5 text-center">
	       <h2>사용자 정보</h2>
	    </div>
	    <table>
	        <tr>
	            <th>아이디</th>
	            <td>${id}</td>
	        </tr>
	        <tr>
	            <th>프로필 이미지</th>
	            <td>
	            <c:choose>
	                <c:when test="${empty dto.profile}">
	                    <i class="bi bi-person-circle" style="font-size:100px"></i>
	                </c:when>
	                <c:otherwise>
	                    <img id="profileImage" src="${pageContext.request.contextPath}${dto.profile}"/>
	                </c:otherwise>
	            </c:choose>
	            </td>
	        </tr>
	        <tr>
	            <th>비밀번호</th>
	            <td><a href="${pageContext.request.contextPath}/users/private/pwd_update_form" class="btn btn-primary">수정하기</a></td>
	        </tr>
	        <tr>
	            <th>이메일</th>
	            <td>${dto.email}</td>
	        </tr>
	        <tr>
	            <th>가입일</th>
	            <td>${dto.regdate}</td>
	        </tr>
	    </table>
	    <a href="${pageContext.request.contextPath}/users/private/update_form" class="btn btn-primary">개인정보 수정</a>
	    <a href="javascript:deleteConfirm()" class="btn btn-danger">탈퇴</a>
	</div>
	
	
	<script>
	    function deleteConfirm(){
	        const isDelete=confirm("${id} 님 탈퇴 하시겠습니까?");
	        if(isDelete){
	            location.href="${pageContext.request.contextPath}/users/private/delete";
	        }
	    }
	</script>
</body>
</html>