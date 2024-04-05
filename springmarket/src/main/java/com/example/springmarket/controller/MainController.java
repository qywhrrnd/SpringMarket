package com.example.springmarket.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	@GetMapping("/")
	public String home() {
		return "main/main";
	}
	
	@GetMapping("main/pagemain.do")
    public ModelAndView main() {
        return new ModelAndView("main/main");
    }
}
