package com.company.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.company.dto.MemberDTO;
import com.company.service.MemberService;

import lombok.RequiredArgsConstructor;



@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class HomeController {
	
	private final MemberService memberService;
	
	@GetMapping("")
	public String index() {
		return "index";
	}
	@GetMapping("/save")
	public String saveForm() {
		return "save";
	}
	
	@PostMapping("/save")
	public String save(@ModelAttribute MemberDTO memberDTO) {
		int saveResult = memberService.save(memberDTO);
		if (saveResult > 0) {
			
			return "login";
		}else {
			return "save";
		}
		
	}
	
}
