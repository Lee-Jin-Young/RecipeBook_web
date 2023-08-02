package com.young.recipebook.social.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SocialController {
	@GetMapping("/social/list")
	public String list() {
		return "social/list";
	}
}
