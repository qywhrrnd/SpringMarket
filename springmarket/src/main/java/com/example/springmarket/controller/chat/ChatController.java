package com.example.springmarket.controller.chat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class ChatController {
	
	@GetMapping("chat/chat.do")
	public String chat() {
		return "chat/chat";
	}
}