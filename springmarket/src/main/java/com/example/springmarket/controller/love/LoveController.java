package com.example.springmarket.controller.love;

import java.net.http.HttpRequest;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.love.LoveDAO;
import com.example.springmarket.model.love.LoveDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/love/*")
public class LoveController {

	@Autowired
	LoveDAO loveDao;

	@PostMapping("love_apply")
    @ResponseBody
    public String love_apply(@RequestParam("write_code") int write_code, HttpSession session) {
        String userid = (String) session.getAttribute("userid");
        if (userid != null) {
        LoveDTO dto = new LoveDTO();
        dto.setUserid(userid);
        dto.setWrite_code(write_code);
        loveDao.love_apply(dto);
        }
        return "success";
    }
	
	@PostMapping("love_clear")
	@ResponseBody
	public String love_clear(@RequestParam("write_code") int write_code, HttpSession session) {
		String userid = (String) session.getAttribute("userid");
		if (userid != null) {
			LoveDTO dto = new LoveDTO();
	        dto.setUserid(userid);
	        dto.setWrite_code(write_code);
			loveDao.love_clear(dto);
		}
		return "success";
	}

	@GetMapping("love_list")
	public ModelAndView love_list(ModelAndView mav, HttpSession session) {
		String userid = (String) session.getAttribute("userid");
		mav.setViewName("product/lovelist");
		mav.addObject("list", loveDao.love_list(userid));
		
		return mav;
	}
	
	@GetMapping("love_delete/{write_code}")
	public String love_delete(@PathVariable(name="write_code") int write_code) {
		loveDao.love_delete(write_code);
		return "redirect:/love/love_list";
	}
	
	@PostMapping("love_delete_all")
	public String delete_all(HttpServletRequest request) {
		String[] num = request.getParameterValues("num");
		if(num !=null) {
			for (int i=0; i<num.length; i++) {
				loveDao.love_delete(Integer.parseInt(num[i]));
			}
		}return "redirect:/love/love_list";
	}
	
	
}
