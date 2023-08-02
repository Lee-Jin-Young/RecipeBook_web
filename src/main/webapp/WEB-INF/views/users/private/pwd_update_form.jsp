<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageContext.request.contextPath}</title>
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="bg-light">
    <div class="container">
        <div class="py-5 text-center">
            <h2>비밀 번호 수정</h2>
        </div>
        
        <form action="${pageContext.request.contextPath}/users/private/pwd_update" class="card p-2 needs-validation" method="post" id="myForm">
            <div class="mb-2">
                <input type="text" name="id", id="id" value="${id}" hidden="true">
            </div>
            <div class="mb-2">
                <label for="pwd" class="control-label">기존 비밀 번호</label>
                <div class="input-group">
	                <input type="password" class="form-control" name="pwd" id="pwd"/>
	                <button class="btn btn-outline-secondary bi-eye-slash" type="button" name="openpwd"></button>
                </div>
            </div>
            <div class="mb-2">
                <label for="newPwd" class="control-label">새 비밀번호</label>
                <div class="input-group">
	                <input type="password" class="form-control" name="newPwd" id="newPwd"/>
	                <button class="btn btn-outline-secondary bi-eye-slash" type="button" name="openpwd"></button>
                </div>
            </div>
            <div class="mb-3">
                <label for="newPwd2" class="control-label">새 비밀번호 확인</label>
                <div class="input-group">
	                <input type="password" class="form-control" id="newPwd2"/>
	                <button class="btn btn-outline-secondary bi-eye-slash" type="button" name="openpwd"></button>
                </div>
            </div>
            <button type="submit" class="btn btn-primary mb-2">수정하기</button>
            <button type="reset" class="btn btn-secondary mb-2">리셋</button>
            <a href="./info" class="btn btn-primary">돌아가기</a>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
    <script>
        let isPwdValid = false;
        
        // 모든 칸이 입력 될 때 가입버튼 활성화
        function checkFormState(){
            if(isPwdValid && isPwdMatch){
                $("button[type=submit]").removeAttr("disabled");
            }else{ 
                $("button[type=submit]").attr("disabled", "");
            }
        }
        // 아무것도 입력 하지 않았을때 비활성화하기 위해 화면 로딩시 실행
        checkFormState();
        
        //비밀번호 정규표현식
        $("#newPwd").on("input", () => {
            const pwd=$("#newPwd").val();
            const pwd2=$("#newPwd2").val();
            const reg=/(?=.*[a-z])(?=.*[\d])(?=.*([A-Z]|[\W])).{8,}/;
            isPwdValid = reg.test(pwd);
            if(isPwdValid) {
                $("#newPwd").removeClass("is-invalid").addClass("is-valid");
            } else {
                $("#newPwd").removeClass("is-valid").addClass("is-invalid");
            }
            checkFormState();
        });
        //비밀번호 확인
        $("#newPwd, #newPwd2").on("input", () => {
            const pwd=$("#newPwd").val();
            const pwd2=$("#newPwd2").val();
            const reg=/(?=.*[a-z])(?=.*[\d])(?=.*([A-Z]|[\W])).{8,}/;
            isPwdMatch = (pwd == pwd2);
            if(isPwdMatch) {
                $("#newPwd2").removeClass("is-invalid").addClass("is-valid");
            } else {
                $("#newPwd2").removeClass("is-valid").addClass("is-invalid");
            }
            checkFormState();
        });
        
        // 눈 아이콘을 누르면 입력한 비밀번호가 보이도록 설정
        $(document).ready(function() {
            $('button[name=openpwd]').on('click', function() {
                $(this).parent().toggleClass('active');
                if($(this).parent().hasClass('active')) {
                    $(this).attr('class', "btn btn-outline-secondary bi-eye")
                    .prev('input').attr('type', 'text');
                } else {
                    $(this).attr('class', "btn btn-outline-secondary bi-eye-slash")
                    .prev('input').attr('type', 'password');
                }
            });
        });
    </script>
</body>
</html>


