<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>${pageContext.request.contextPath}</title>
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
	<link rel="<canon></canon>ical" href="https://getbootstrap.com/docs/4.3/examples/checkout/">
    <style>
        .bd-placeholder-img {
	        font-size: 1.125rem;
	        text-anchor: middle;
	        -webkit-user-select: none;
	        -moz-user-select: none;
	        -ms-user-select: none;
	        user-select: none;
        }

        @media (min-width: 768px) {
	        .bd-placeholder-img-lg {
	          font-size: 3.5rem;
	        }
        }
        
        .container {
            max-width: 960px;
        }

        .lh-condensed { 
            line-height: 1.25; 
        }
    </style>
</head>

<body class="bg-light">
    <div class="container">
        <div class="py-5 text-center">
            <h2>회원가입</h2>
        </div>
        
        
        <form class="card p-2 needs-validation" action="${pageContext.request.contextPath}/users/signup" method="post">
            <div class="mb-2">
                <label for="id" class="control-label">아이디</label>
                <input type="text" class="form-control" name="id" id="id"
                    placeholder="예) hello123"/>
                <small class="form-text text-muted">5~10글자 사이의 영문자 소문자로 시작하도록 입력하세요</small>
                <div class="valid-feedback">사용 가능한 아이디 입니다.</div>
                <div class="invalid-feedback" id="id_invalid">사용할 수 없는 아이디 입니다.</div>
                <div class="invalid-feedback" id="id_already">이미 사용중인 아이디 입니다.</div>
            </div>
            
            <div class="mb-2">
                <label for="pwd" class="control-label">비밀번호</label>
                <div class="input-group">
	                <input type="password" class="form-control" name="pwd" id="pwd" 
	                    placeholder="예) hello123@ / Hello123"/>
	                <button class="btn btn-outline-secondary bi-eye-slash" type="button" name="openpwd"></button>
                </div>        
                <small class="form-text text-muted">8~20글자 사이의 영문자 소문자, 숫자가 반드시 포함되며, 대문자 혹은 특수기호를 사용하세요.</small>
            </div>
            
            <div class="mb-2">
                <label for="pwd2" class="control-label">비밀번호 확인</label>
                <div class="input-group">
                    <input type="password" class="form-control" name="pwd2" id="pwd2"/>
                    <button class="btn btn-outline-secondary bi-eye-slash" type="button" name="openpwd"></button>
                </div>
	            <div class="invalid-feedback">비밀 번호를 확인 하세요</div>
            </div>
            
            <div class="mb-2">
                <label for="email" class="control-label">이메일</label>
                <input type="text" class="form-control" name="email" id="email"/>
                <div class="invalid-feedback">이메일 형식에 맞게 입력하세요.</div>
            </div>
            <button class="btn btn-primary" type="submit">가입</button>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
    <script>
        
        let isIdValid = false;
        let isIdReady = true;
        let isEmailValid = false;
        let isPwdValid = false;
        
        // 모든 칸이 입력 될 때 가입버튼 활성화
        function checkFormState(){
            if(isIdValid && isIdReady && isPwdValid && isPwdMatch && isEmailValid){
                $("button[type=submit]").removeAttr("disabled");
            }else{ 
                $("button[type=submit]").attr("disabled", "");
            }
        }
        // 아무것도 입력 하지 않았을때 비활성화하기 위해 화면 로딩시 실행
        checkFormState();
        
        // 아이디 중복 확인
        $("#id").on("input", (e) => {
            const inputId = e.target.value;
            const reg = /^[a-z].{4,9}$/;
            isIdValid = reg.test(inputId);
            
            $.ajax({
            	url: './isExist', //UsersController
            	type: 'post',
            	data: {id:$('#id').val()},
            	async: false, //서버측에서 완료될때까지 기다림
            	success: function(isExist) {
            		if(isExist) {
            			isIdReady = false;
            		} else {
            			isIdReady = true;
            		}
            	}
            });
            
            if(isIdValid) {
            	//정규표현식 통과
            	if(isIdReady) {
            		//중복x
            		$(e.target).removeClass("is-invalid").addClass("is-valid");
            		$('#id_already').css("display","none");
            		$('#id_invalid').css("display", "none");
            	} else {
            		//중복o
            		$(e.target).removeClass("is-valid").addClass("is-invalid");
                    $('#id_already').css("display","inline-block");
                    $('#id_invalid').css("display", "none");
            	}
            } else {
            	//정규표현식 미통과
                $(e.target).removeClass("is-valid").addClass("is-invalid");
                $('#id_already').css("display", "none");
                $('#id_invalid').css("display","inline-block");
            }
            checkFormState();
        });
    
        
        //비밀번호 정규표현식
        $("#pwd").on("input", () => {
            const pwd=$("#pwd").val();
            const pwd2=$("#pwd2").val();
            const reg=/(?=.*[a-z])(?=.*[\d])(?=.*([A-Z]|[\W])).{8,}/;
            isPwdValid = reg.test(pwd);
            if(isPwdValid) {
                $("#pwd").removeClass("is-invalid").addClass("is-valid");
            } else {
                $("#pwd").removeClass("is-valid").addClass("is-invalid");
            }
            checkFormState();
        });
        //비밀번호 확인
        $("#pwd, #pwd2").on("input", () => {
            const pwd=$("#pwd").val();
            const pwd2=$("#pwd2").val();
            const reg=/(?=.*[a-z])(?=.*[\d])(?=.*([A-Z]|[\W])).{8,}/;
            isPwdMatch = (pwd == pwd2);
            if(isPwdMatch) {
                $("#pwd2").removeClass("is-invalid").addClass("is-valid");
            } else {
                $("#pwd2").removeClass("is-valid").addClass("is-invalid");
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
        
        //이메일 정규표현식
        $("#email").on("input", (e) => {
            const inputEmail=$(e.target).val();
            const reg=/^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
            isEmailValid=reg.test(inputEmail);
            if(isEmailValid) {
                $(e.target).removeClass("is-invalid").addClass("is-valid");
            } else {
                $(e.target).removeClass("is-valid").addClass("is-invalid");
            }
            checkFormState();
        });
    
    </script>
</body>
</html>