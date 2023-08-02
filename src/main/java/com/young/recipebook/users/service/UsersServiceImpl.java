package com.young.recipebook.users.service;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.young.recipebook.users.dao.UsersDao;
import com.young.recipebook.users.dto.UsersDto;

@Service
public class UsersServiceImpl implements UsersService {
	@Autowired
	private UsersDao dao; 

	// 회원가입
	@Override
	public void addUser(UsersDto dto) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodedPwd = encoder.encode(dto.getPwd());
		dto.setPwd(encodedPwd);
		
		dao.insert(dto);
	}
	
	//아이디 중복체크 
	@Override
	public boolean isExist(String id) {
		return dao.isExist(id) != 0;
	}

	// 로그인
	@Override
	public void loginProcess(UsersDto dto, HttpSession session) {
		boolean isValid = false;
		UsersDto resultDto = dao.getData(dto.getId()); //사용자가 입력한 id값의 데이터 불러오기
		
		//id가 존재하면 비밀번호가 같은지 비교
		if(resultDto != null) {
			isValid = BCrypt.checkpw(dto.getPwd(), resultDto.getPwd());
		}
		
		if(isValid) {
			session.setAttribute("id", resultDto.getId());
		}
	}

	// 회원정보 열람
	@Override
	public void getInfo(HttpSession session, Model model) {
		String id = (String)session.getAttribute("id");
		UsersDto dto = dao.getData(id);
		
		model.addAttribute("dto",dto);
	}

	//비밀번호 변경
	@Override
	public void updateUserPwd(HttpSession session, UsersDto dto, Model model) {
		String id = (String)session.getAttribute("id");
		UsersDto resultdto = dao.getData(id); //기존 정보
		
		boolean isValid = BCrypt.checkpw(dto.getPwd(), resultdto.getPwd());
		if(isValid) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			
			// 입력된 변경할 비밀번호 암호화
			String encodedNewPwd = encoder.encode(dto.getNewPwd());
			dto.setNewPwd(encodedNewPwd);
			dto.setId(id);
			
			dao.updatePwd(dto);
			
			session.invalidate(); //로그아웃
		}
		
		model.addAttribute("isSuccess", isValid);
		model.addAttribute(id);
	}
	
	// 비밀번호 찾기(임시 비밀번호 발급)
	@Override
	public void findUserPwd(UsersDto dto, Model model) {
		String id = dto.getId();
		UsersDto resultdto = dao.getData(id);
		
		boolean isValid = false;
		
		// nullpoint exception 방지
		if(resultdto == null) {
			isValid = false;
		} else {
			isValid= dto.getEmail().equals(resultdto.getEmail());
		}
		
		if(isValid) {
			// 랜덤한 임시 비밀번호 생성 (대문자, 소문자, 숫자)
			StringBuilder password = new StringBuilder();

	        // Generate the remaining random characters
	        for (int i = 0; i < 9; i++) {
	            int randomIndex = (int) (Math.random() * 3); //숫자,소문자,대문자중 랜덤
	            if(i<3) {randomIndex = i;} //0,1,2일때 각각 한번씩 추가됨
	            switch (randomIndex) {
	                case 0:
	                    char randomDigit = (char) (Math.random() * 10 + 48);
	                    password.append(randomDigit);
	                    break;
	                case 1:
	                    char randomLower = (char) (Math.random() * 26 + 97);
	                    password.append(randomLower);
	                    break;
	                case 2:
	                    char randomUpper = (char) (Math.random() * 26 + 65);
	                    password.append(randomUpper);
	                    break;
	            }
	        }

	        // 랜덤하게 생성된 문자의 순서를 섞는다
	        for (int i = password.length() - 1; i > 0; i--) {
	            int j = (int) (Math.random() * (i + 1));
	            char temp = password.charAt(i);
	            password.setCharAt(i, password.charAt(j));
	            password.setCharAt(j, temp);
	        }
			
			String newPwd = password+""; //StringBuilder to String
			dto.setNewPwd(newPwd);
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			
			model.addAttribute("tmpPwd",dto.getNewPwd());
			String encodedNewPwd = encoder.encode(dto.getNewPwd());
			dto.setNewPwd(encodedNewPwd);
			dto.setId(id);
			
			dao.updatePwd(dto);
		}
		System.out.println(isValid);
		model.addAttribute("isSuccess", isValid);
		model.addAttribute(id);
	}
	
	//회원프로필 이미지 등록
	@Override
	public Map<String, Object> saveProfileImage(HttpServletRequest request, MultipartFile mFile) {
		String orgFileName=mFile.getOriginalFilename();
        String saveFileName=System.currentTimeMillis()+orgFileName;
        
        String realPath=request.getServletContext().getRealPath("/resources/upload");

        // upload 폴더가 없을 경우
        File upload=new File(realPath);
        if(!upload.exists()) {
           upload.mkdir();
        }
        
        try {
           String savePath=realPath+File.separator+saveFileName;
           mFile.transferTo(new File(savePath));
        }catch(Exception e) {
           e.printStackTrace();
        }
        
        Map<String, Object> map=new HashMap<>();
        map.put("imagePath", "/resources/upload/"+saveFileName);
        
        return map;
	}

	// 회원정보 수정
	@Override
	public void updateUser(UsersDto dto, HttpServletRequest request, Model model) {
		String id = (String)request.getSession().getAttribute("id");
		dto.setId(id);
		
		if(dto.getProfile().equals("empty")) {
			dto.setProfile(null);
		}
		
		dao.update(dto);
	}

	//회원탈퇴
	@Override
	public void deleteUser(HttpSession session, Model model) {
		String id = (String)session.getAttribute("id");
		model.addAttribute(id);
		dao.delete(id);
	}

}
