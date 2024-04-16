package com.example.springmarket.controller.good;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.good.GoodDAO;
import com.example.springmarket.model.good.GoodDTO;
import com.example.springmarket.model.member.MemberDAO;
import com.example.springmarket.model.member.MemberDTO;

@Controller
public class GoodController {
	@Autowired
	GoodDAO goodDao;

	@Autowired
	MemberDAO memberDao;

	@GetMapping("good/goodlist.do")
	public ModelAndView goodlist() {
		List<GoodDTO> list = goodDao.listgood();
		String url = "";
		url = "good/goodlist";
		return new ModelAndView(url, "list", list);

	}

	@GetMapping("good/detailgood.do")
	public ModelAndView detailgood(@RequestParam(name = "goodidx") int goodidx) {
		String url = "";
		url = "good/detailgood";
		GoodDTO dto = goodDao.detailGood(goodidx);
		return new ModelAndView(url, "dto", dto);
	}

	@RequestMapping("good/buypage.do")
	public ModelAndView pagebuy(@RequestParam(name = "userid") String userid,
			@RequestParam(name = "totalPrice") int totalPrice, @RequestParam(name = "goodidx") int goodidx,
			@RequestParam(name = "amount") int amount) {
		String url = "";
		url = "good/buypage";
		MemberDTO mdto = memberDao.mypage(userid);
		GoodDTO gdto = goodDao.detailGood(goodidx);
		Map<String, Object> map = new HashMap<>();
		map.put("mdto", mdto);
		map.put("gdto", gdto);
		map.put("totalPrice", totalPrice);
		map.put("amount", amount);
		return new ModelAndView(url, "map", map);
	}

	

}
