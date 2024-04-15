package com.example.springmarket.controller.good;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.good.GoodDAO;
import com.example.springmarket.model.good.GoodDTO;

@Controller
public class GoodController {
	@Autowired
	GoodDAO goodDao;

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

}
