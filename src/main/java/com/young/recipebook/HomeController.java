package com.young.recipebook;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("/")
    public String home(HttpServletRequest request) {
        List<String> noticeList=new ArrayList<String>();

        noticeList.add("사용자 정보 등의 인터페이스 개선 완료");

        request.setAttribute("noticeList", noticeList);

        return "home";
    }
	
}
