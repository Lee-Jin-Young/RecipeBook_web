package com.young.recipebook.users.controller;

import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.young.recipebook.users.dto.UsersDto;
import com.young.recipebook.users.service.UsersService;

@Controller
public class UsersController {
	@Autowired
	private UsersService service;

	// 회원가입 폼 요청처리
	@GetMapping("/users/signup_form")
	public String signupForm() {
		return "users/signup_form";
	}
	
	// 회원가입 아이디 중복확인
	@ResponseBody
	@PostMapping("/users/isExist")
	public boolean isExist(@RequestParam("id") String id) {
		return service.isExist(id);
	}

	// 회원가입 요청처리
	@PostMapping("/users/signup")
	public String signup(UsersDto dto) {
		service.addUser(dto);

		return "users/signup";
	}

	// 로그인 폼 요청처리
	@GetMapping("/users/login_form")
	public String loginForm() {
		return "users/login_form";
	}

	// 로그인 요청처리
	@PostMapping("/users/login")
	public String login(UsersDto dto, HttpSession session, String url, Model model) {
		service.loginProcess(dto, session);

		// loginInterceptor를 통해 로그인요청한 경우 기존에 있던 페이지로 돌려보내기 위한 설정
		String encodedUrl = URLEncoder.encode(url);
		model.addAttribute("url", url);
		model.addAttribute("encodedUrl", encodedUrl);

		return "users/login";
	}

	// 로그아웃 요청처리
	@GetMapping("/users/private/logout")
	public String logout(HttpSession session) {
		session.invalidate(); // session clear
		return "users/logout";
	}

	// 사용자 정보 보기 요청처리
	@GetMapping("/users/private/info")
	public String info(HttpSession session, Model model) {
		service.getInfo(session, model);

		return "users/private/info";
	}

	// 비밀번호 수정 폼 요청처리
	@GetMapping("/users/private/pwd_update_form")
	public String pwdUpdateForm() {
		return "users/private/pwd_update_form";
	}

	// 비밀번호 수정 요청처리
	@PostMapping("/users/private/pwd_update")
	public String pwdUpdate(UsersDto dto, Model model, HttpSession session) {
		service.updateUserPwd(session, dto, model);
		return "users/private/pwd_update";
	}

	// 비밀번호 찾기 폼 요청처리
	@GetMapping("/users/pwd_find_form")
	public String PwdFindForm() {
		return "users/pwd_find_form";
	}

	// 비밀번호 찾기 요청처리
	@PostMapping("/users/pwd_find")
	public String pwdFind(UsersDto dto, Model model, HttpSession session) {
		service.findUserPwd(dto, model);

		return "users/pwd_find";
	}
	
	// 사용자정보 수정 폼 요청처리
	@GetMapping("/users/private/update_form")
	public String UpdateForm(Model model, HttpSession session) {
		service.getInfo(session, model);
		
		return "users/private/update_form";
	}
		
	// 사용자정보 수정 요청처리
	@PostMapping("/users/private/update")
	public String update(UsersDto dto, HttpServletRequest request, Model model) {
		service.updateUser(dto, request, model);

		return "redirect:/users/private/info";
	}

	// ajax 프로필 사진 업로드 요청 처리
	@ResponseBody
	@GetMapping("/users/private/profile_upload")
	public Map<String, Object> profileUpload(HttpServletRequest request, MultipartFile image) {
        return service.saveProfileImage(request, image);
    }
	
	// 회원 탈퇴 요청처리
	@GetMapping("users/private/delete")
	public String delete(HttpSession session, Model model) {
		service.deleteUser(session, model);

		session.removeAttribute("id");

		return "users/private/delete";
	}
	
	
}
