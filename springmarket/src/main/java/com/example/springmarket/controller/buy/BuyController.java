package com.example.springmarket.controller.buy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.buy.BuyDAO;
import com.example.springmarket.model.buy.BuyDTO;

@Controller
public class BuyController {

	@Autowired
	BuyDAO buyDao;

	@RequestMapping("buy/buy.do")
	public ModelAndView buy(@RequestParam(name = "userid") String userid, @RequestParam(name = "amount") int amount,
			@RequestParam(name = "totalPrice") int totalPrice, @RequestParam(name = "address1") String address1,
			@RequestParam(name = "address2") String address2, @RequestParam(name = "filename") String filename,
			@RequestParam(name = "goodname") String goodname, @RequestParam(name = "goodidx") int goodidx) {

		BuyDTO dto = new BuyDTO();
		dto.setAddress(address1 + address2);
		dto.setAmount(amount);
		dto.setFilename(filename);
		dto.setGoodname(goodname);
		dto.setPrice(totalPrice);
		dto.setUserid(userid);
		dto.setGoodidx(goodidx);
		buyDao.buy(dto);
		List<BuyDTO> list = buyDao.buylist(userid);
		return new ModelAndView("good/buy", "list", list);

	}

	@RequestMapping("buy/buylist.do")
	public ModelAndView buylist(@RequestParam(name = "userid") String userid) {
		List<BuyDTO> list = buyDao.buylist(userid);
		return new ModelAndView("good/buy", "list", list);
	}

}
