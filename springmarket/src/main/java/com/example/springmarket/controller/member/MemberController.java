package com.example.springmarket.controller.member;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.member.MemberDAO;
import com.example.springmarket.model.member.MemberDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	@Autowired
	MemberDAO memberDao;

	@GetMapping("member/pagelogin.do")
	public ModelAndView login() {
		return new ModelAndView("member/login");
	}

	@GetMapping("member/pagejoin.do")
	public ModelAndView join() {
		return new ModelAndView("member/join");
	}

	@PostMapping("member/login.do")
	public ModelAndView login_check(@RequestParam(name = "userid") String userid,
			@RequestParam(name = "passwd") String passwd, HttpSession session) {
		String pass = memberDao.encrypt(passwd);
		String nickname = memberDao.login(userid, pass);
		String message = "";
		String url = "";
		if (nickname == null) { // 로그인 실패
			message = "로그인 정보가 정확하지 않습니다.";
			url = "member/login";
		} else { // 로그인 성공
			message = nickname + "님 환영합니다.";
			url = "index";
			// 세션변수 등록
			session.setAttribute("userid", userid);
		}
		Map<String, Object> map = new HashMap<>();
		map.put("message", message);
		return new ModelAndView(url, "map", map);
	}

	@GetMapping("member/logout.do")
	public String logout(HttpSession session) {
		session.invalidate(); // 세션 초기화
		return "redirect:/member/pagelogin.do";
	}

	@PostMapping("member/join.do")
	public String join(@RequestParam(name = "userid") String userid,
			@RequestParam(name = "passwd") String passwd,
			@RequestParam(name = "name") String name,
			@RequestParam(name = "nickname") String nickname,
			@RequestParam(name = "birth") int birth,
			@RequestParam(name = "phone") String phone,
			@RequestParam(name = "email") String email,
			@RequestParam(name = "address1") String address1,
			@RequestParam(name = "address2") String address2)
			{
		String address = address1 + address2;
		String pass = memberDao.encrypt(passwd);
		MemberDTO dto = new MemberDTO();
		dto.setUserid(userid);
		dto.setPasswd(pass);
		dto.setName(name);
		dto.setNickname(nickname);
		dto.setBirth(birth);
		dto.setPhone(phone);
		dto.setEmail(email);
		dto.setAddress(address);
		memberDao.join(dto); // document 저장
		return "redirect:/member/login.do";
	}
	
	
	
}
