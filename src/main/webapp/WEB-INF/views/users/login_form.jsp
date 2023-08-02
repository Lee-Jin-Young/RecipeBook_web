<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageContext.request.contextPath}</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="canonical" href="https://getbootstrap.com/docs/4.3/examples/floating-labels/">
    <style>
    .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
    }
    
    @media ( min-width : 768px) {
        .bd-placeholder-img-lg {
            font-size: 3.5rem;
        }
    }
    </style>
    <link href="${pageContext.request.contextPath}/resources/css/floating-labels.css" rel="stylesheet">
</head>

<body class="bg-light">
    <div class="div-signin d-grid gap-2">
	    <form class="form-signin" action="${pageContext.request.contextPath}/users/login" method="post">
	        <h1 class="h3 mb-3 font-weight-normal" style="width: 30rem">로그인</h1>
	        
	        <c:choose>
	            <%-- 홈 화면에서 로그인 할 경우 파라미터 값으로 url이 주어지지 않음 --%>
	            <c:when test="${ empty param.url }">
	                <input type="hidden" name="url" value="${pageContext.request.contextPath}/" />
	            </c:when>
	            <%-- 그외는 loginInterceptor를 거치기 때문에 url이 주어짐 --%>
	            <c:otherwise>
	                <input type="hidden" name="url" value="${param.url }" />
	            </c:otherwise>
	        </c:choose>
	        
	        <div class="form-floating mb-2">
	            <input type="text" class="form-control" name="id" id="id" placeholder="아이디" required autofocus>
		        <label for="id">아이디</label>
	            <small class="form-text text-muted">예) hello123</small>
	        </div>
	        
	        <div class="input-group">
	            <div class="form-floating">
		           <input type="password" name="pwd" id="pwd" class="form-control" placeholder="비밀번호" required>
	               <label for="pwd">비밀번호</label>
	            </div>
		        <button class="btn btn-outline-secondary bi-eye-slash" type="button" name="openpwd"></button>
	        </div>
		    <small class="form-text text-muted">예) hello123@ / Hello123</small>
	        
	        <div class="d-grid gap-2">
	            <button class="btn btn-primary btn-block" type="submit">로그인</button>
	        </div>
	    </form>
	    
	    <div class="checkbox mt-3 mb-2">
	        <label><input type="checkbox" id="rememberId"> 아이디 기억하기</label>
	        <label><input type="checkbox" id="autoLogin"> 자동 로그인</label>
	    </div>
	    
	    <a href="">아이디 찾기</a>
	    <a href="${pageContext.request.contextPath}/users/pwd_find_form">비밀번호 찾기</a>
    </div>
    

    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
    <script>
        // 눈 아이콘을 누르면 입력한 비밀번호가 보이도록 설정
        $('button[name=openpwd]').on('click', function() {
            $('#pwd').toggleClass('active');
            if ($('#pwd').hasClass('active')) {
            	$(this).attr('class', "btn btn-outline-secondary bi-eye")
                $('#pwd').attr('type', 'text');
            } else {
            	$(this).attr('class', "btn btn-outline-secondary bi-eye-slash")
                $('#pwd').attr('type', 'password');
            }
        });
        
        // 아이디 기억하기
        $(document).ready(function() {
	        // 저장된 쿠키값 넣기
	        var key = getCookie("key");
	        $("#id").val(key); 
	        
	        if($("#id").val() != ""){ 
	            $("#rememberId").attr("checked", true);
	        }
         
	        // 체크박스 체크시 key update
	        $("#rememberId").change(function() {
	            if($("#rememberId").is(":checked")){
	                setCookie("key", $("#id").val(), 7);
	            }else{
	                deleteCookie("key");
	            }
	        });
	        // id 입력 시 key update
	        $("#id").keyup(function() {
	            if($("#rememberId").is(":checked")){
	                setCookie("key", $("#id").val(), 7);
	            }
	        });
        });
	    // 쿠키 저장하기 
	    function setCookie(cookieName, value, exdays) {
	        var exdate = new Date();
	        exdate.setDate(exdate.getDate() + exdays);
	        var cookieValue = escape(value)
	                + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
	        document.cookie = cookieName + "=" + cookieValue;
	    }
	
	    // 쿠키 삭제
	    function deleteCookie(cookieName) {
	        var expireDate = new Date();
	        expireDate.setDate(expireDate.getDate() - 1);
	        document.cookie = cookieName + "= " + "; expires="
	                + expireDate.toGMTString();
	    }
	     
	    // 쿠키 가져오기
	    function getCookie(cookieName) {
	        cookieName = cookieName + '=';
	        var cookieData = document.cookie;
	        var start = cookieData.indexOf(cookieName);
	        var cookieValue = '';
	        if (start != -1) {
	            start += cookieName.length;
	            var end = cookieData.indexOf(';', start);
	            if (end == -1)
	                end = cookieData.length;
	                console.log("end위치  : " + end);
	            cookieValue = cookieData.substring(start, end);
	        }
	        return unescape(cookieValue);
	    }
        
        // TODO 자동 로그인
        
    </script>
</body>
</html>