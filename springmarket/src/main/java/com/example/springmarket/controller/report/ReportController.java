package com.example.springmarket.controller.report;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.springmarket.model.report.ReportDAO;
import com.example.springmarket.model.report.ReportDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/report/*")
public class ReportController {

	@Autowired
	ReportDAO reportdao;

	@GetMapping("pagereport")
	public ModelAndView pagereport(@RequestParam(name = "userid") String userid,
			@RequestParam(name = "link") String link, HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("link", link);
		return new ModelAndView("report/report", "map", map);
	}

	@PostMapping("report")
	public String insertReport(@RequestParam(name = "userid") String userid,
			@RequestParam(name = "subject") String subject, @RequestParam(name = "contents") String contents,
			@RequestParam(name = "link") String link, @RequestParam(name = "reporter") String reporter) {

		System.out.println(userid);
		System.out.println(subject);
		System.out.println(contents);
		System.out.println(link);
		System.out.println(reporter);
		ReportDTO dto = new ReportDTO();
		dto.setReport_userid(userid);
		dto.setReport_subject(subject);
		dto.setReport_contents(contents);
		dto.setLink(link);
		dto.setReporter(reporter);
		reportdao.insertReport(dto);
		return "redirect:/report/report";
	}

	@GetMapping("report_list")
	public ModelAndView report_list(ModelAndView mav) {
		mav.setViewName("report/reportlist");
		mav.addObject("list", reportdao.report_list());
		System.out.println(reportdao.report_list());

		return mav;
	}

	@GetMapping("report_delete")	
	public String report_delete(@RequestParam(name = "idx") int idx) {
		reportdao.report_delete(idx);
		return "redirect:/report/report_list";
	}

}
