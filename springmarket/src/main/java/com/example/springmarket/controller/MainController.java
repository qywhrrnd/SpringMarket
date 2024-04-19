package com.example.springmarket.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.love.LoveDAO;
import com.example.springmarket.model.member.MemberDAO;
import com.example.springmarket.model.product.ProductDAO;
import com.example.springmarket.model.product.ProductDTO;

@Controller
public class MainController {
	@Autowired
	ProductDAO productDao;

	@Autowired
	LoveDAO loveDao;

	@Autowired
	MemberDAO memberDao;

	@GetMapping("/")
	public ModelAndView poplist() {
		List<ProductDTO> list = productDao.poplist();

		Map<String, Object> map = new HashMap<>();
		map.put("ldao", loveDao);
		map.put("list", list);
		map.put("memberDao", memberDao);
		return new ModelAndView("main/main", "map", map);
	}

	@GetMapping("main/pagemain.do")
	public ModelAndView a() {
		List<ProductDTO> list = productDao.poplist();

		Map<String, Object> map = new HashMap<>();
		map.put("ldao", loveDao);
		map.put("list", list);
		map.put("memberDao", memberDao);
		return new ModelAndView("main/main", "map", map);
	}
}