package com.young.recipebook.users.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.young.recipebook.users.dto.UsersDto;

public interface UsersService {
	public void addUser(UsersDto dto);
	public boolean isExist(String id);
	public void loginProcess(UsersDto dto, HttpSession session);
	public void getInfo(HttpSession session, Model model);
	public void updateUserPwd(HttpSession session, UsersDto dto, Model model);
	public Map<String, Object> saveProfileImage(HttpServletRequest request, MultipartFile mFile);
	public void updateUser(UsersDto dto, HttpServletRequest request, Model model);
	public void deleteUser(HttpSession session, Model model);
	public void findUserPwd(UsersDto dto, Model model);
}
