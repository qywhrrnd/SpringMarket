package com.example.springmarket.controller.event;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.email.EmailDTO;
import com.example.springmarket.model.email.EmailEvent;
import com.example.springmarket.model.member.MemberDAO;
import com.example.springmarket.model.quiz.AnswerDTO;
import com.example.springmarket.model.quiz.QuizDAO;
import com.example.springmarket.model.quiz.QuizDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class QuizController {

	@Autowired
	QuizDAO quizDao;

	@Autowired
	MemberDAO memberDao;

	@GetMapping("quiz/quizlist.do")
	public ModelAndView quiz_view(HttpServletRequest request) throws IOException {
		String url = "";
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		int a = quizDao.checkevent(userid);
		if (a >= 1) {
			url = "main/main";
			String message = "이미 참여한 이벤트 입니다";
			// JavaScript 코드를 포함한 문자열 생성
			String alertScript = "<script>alert('" + message + "');</script>";
			// ModelAndView 객체 생성 시 HTML에 전달할 데이터를 설정
			ModelAndView modelAndView = new ModelAndView(url);
			modelAndView.addObject("alertScript", alertScript);
			return modelAndView;
		} else {
			QuizDTO dto = new QuizDTO();
			List<QuizDTO> items = quizDao.quiz_view(4);
			url = "event/quiz";
			return new ModelAndView(url, "items", items);
		}
	}

	@PostMapping("quiz/quiz_insert.do")
	public String handleInsert(HttpServletRequest request, HttpServletResponse response, @RequestParam("num0") int num0,
			@RequestParam("num1") int num1, @RequestParam("num2") int num2, @RequestParam("num3") int num3,
			@RequestParam("quiz_idx0") int quiz_idx0, @RequestParam("quiz_idx1") int quiz_idx1,
			@RequestParam("quiz_idx2") int quiz_idx2, @RequestParam("quiz_idx3") int quiz_idx3, Model model) {

		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");

		AnswerDTO dto = new AnswerDTO();
		dto.setUserid(userid);
		dto.setNum1(num0);
		dto.setNum2(num1);
		dto.setNum3(num2);
		dto.setNum4(num3);
		quizDao.answer_insert(dto);

		int status1 = quizDao.check_answer(quiz_idx0);
		int status2 = quizDao.check_answer(quiz_idx1);
		int status3 = quizDao.check_answer(quiz_idx2);
		int status4 = quizDao.check_answer(quiz_idx3);

		if (num0 == status1 && num1 == status2 && num2 == status3 && num3 == status4) {
			model.addAttribute("result", "정답입니다.");
		} else {
			model.addAttribute("result", "돌아가세요...");
		}

		return "event/result";
	}

	@RequestMapping("quiz/adminquizlist")
	public ModelAndView quizlist() {
		String url = "";
		List<QuizDTO> list = quizDao.quiz_view_admin();
		url = "admin/event_detail";
		return new ModelAndView(url, "list", list);
	}

	@RequestMapping("quiz/pagequiz")
	public String pagequiz() {
		String url = "";
		url = "admin/event_window";
		return url;
	}

	@PostMapping("quiz/insertquiz")
	public String insertQuiz(@RequestParam(name = "question") String question, @RequestParam(name = "ans1") String ans1,
			@RequestParam(name = "ans2") String ans2, @RequestParam(name = "ans3") String ans3,
			@RequestParam(name = "ans4") String ans4, @RequestParam(name = "status") String status) {
		int a = Integer.parseInt(status);
		QuizDTO dto = new QuizDTO();
		dto.setQuestion(question);
		dto.setAns1(ans1);
		dto.setAns2(ans2);
		dto.setAns3(ans3);
		dto.setAns4(ans4);
		dto.setStatus(a);
		quizDao.insertQuiz(dto);
		String url = "";
		url = "report/reportclose";
		return url;

	}

	@RequestMapping("quiz/send.do")
	public String send(@RequestParam(name = "userid") String userid) {

		String email = memberDao.email(userid);
		String senderName = "가지나라"; // replace with actual sender name
		String senderMail = "rhwls159@naver.com";

		EmailDTO edto = new EmailDTO();
		edto.setSenderName(senderName);
		edto.setSenderName(senderMail);
		edto.setEmail(email);
		EmailEvent service = new EmailEvent();
		try {
			service.mailSender3(edto);
			return "main/main";

		} catch (Exception e) {
			e.printStackTrace();
			return "main/main";
		}

	}
}
