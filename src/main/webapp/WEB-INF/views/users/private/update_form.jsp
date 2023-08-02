<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageContext.request.contextPath}</title>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
    #imageForm{
        display: none;
    }
    #profileImage{
        width: 100px;
        height: 100px;
        border: 1px solid #cecece;
        border-radius: 50%;
    }
</style>
</head>
<body class="bg-light">
    <div class="container">
        <div class="py-5 text-center">
            <h3>회원 정보 수정</h3>
        </div>
        
        <a id="profileLink" href="javascript:">
            <c:choose>
                <c:when test="${ empty dto.profile }">
                    <i class="bi bi-person-circle" style="font-size: 100px"></i>
                </c:when>
                <c:otherwise>
                    <img id="profileImage" src="${pageContext.request.contextPath }${ dto.profile}">
                </c:otherwise>
            </c:choose>
        </a>
        <form action="${pageContext.request.contextPath}/users/private/update" method="post">        
            <input type="hidden" name="profile" value="${ empty dto.profile ? 'empty' : dto.profile }"/>        
            <div class="mb-2">
                <label for="id" class="control-label">아이디</label>
                <input type="text" class="form-control" id="id" value="${dto.id }" readonly/>
            </div>
            <div class="mb-2">
                <label for="email" class="control-label">이메일</label>
                <input type="text" class="form-control" id="email" name="email" value="${dto.email}" />
            </div>
            <button type="submit" class="btn btn-primary mb-2">수정확인</button>
            <button type="reset" class="btn btn-secondary mb-2">리셋</button>
            <a href="./info" class="btn btn-primary">돌아가기</a>
        </form>    
        
        <form id="imageForm" action="${pageContext.request.contextPath}/user/profile_upload" method="post" enctype="multipart/form-data">
            프로필 사진
            <input type="file" id="image" name="image" accept=".jpg, .png, .gif"/>
            <button type="submit">업로드</button>
        </form>
                    
    </div>
    <!-- my_util.js 로딩 -->
    <script src="${pageContext.request.contextPath }/resources/js/my_util.js"></script>
    <script>

        document.querySelector("#profileLink").addEventListener("click", function(){
            document.querySelector("#image").click();
        });    
        
        document.querySelector("#image").addEventListener("change", function(){
            const form=document.querySelector("#imageForm");
            ajaxFormPromise(form)
            .then(function(response){
                return response.json();
            })
            .then(function(data){
                console.log(data);
                document.querySelector("input[name=profile]").value=data.imagePath;
                
                let img=`<img id="profileImage" 
                    src="${pageContext.request.contextPath }\${data.imagePath}">`;
                document.querySelector("#profileLink").innerHTML=img;
            });
        });        
        
    </script>
</body>
</html>