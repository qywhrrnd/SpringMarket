package com.example.market.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	@RequestMapping("/") // 시작 페이지
	public String main() {
		return "main";
	}
}